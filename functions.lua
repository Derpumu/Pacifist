PacifistMod = PacifistMod or {}
require("__Pacifist__.config")
require("__Pacifist__.functions.technology")

local array = require("__Pacifist__.lib.array")
local data_raw = require("__Pacifist__.lib.data_raw")

local military_entity_names = data_raw.get_all_names_for(PacifistMod.military_entity_types)
array.remove_all_values(military_entity_names, PacifistMod.exceptions.entity)
array.append(military_entity_names, PacifistMod.extra.entity)

local military_equipment_names = data_raw.get_all_names_for(PacifistMod.military_equipment_types)
array.remove_all_values(military_equipment_names, PacifistMod.exceptions.equipment)

local function is_military_item(item)
    return (item.place_result and array.contains(military_entity_names, item.place_result))
            or (item.placed_as_equipment_result and array.contains(military_equipment_names, item.placed_as_equipment_result))
            or array.contains(PacifistMod.extra.item, item.name)
end

local function is_military_capsule(capsule)
    local is_military_subgroup = capsule.subgroup and array.contains(PacifistMod.military_capsule_subgroups, capsule.subgroup)
    local is_military_equipment_remote = capsule.capsule_action and capsule.capsule_action.type == "equipment-remote"
            and array.contains(military_equipment_names, capsule.capsule_action.equipment)

    return (is_military_subgroup or is_military_equipment_remote)
            and not array.contains(PacifistMod.exceptions.capsule, capsule.name)
end

local function is_military_science_pack(tool)
    return array.contains(PacifistMod.military_science_packs, tool.name)
end

local function is_military_ammo(ammo)
    return not array.contains(PacifistMod.exceptions.ammo, ammo.name)
end

local function is_military_gun(gun)
    return not array.contains(PacifistMod.exceptions.gun, gun.name)
end

local function is_military_armor(armor)
    return array.contains(PacifistMod.extra.armor, armor.name)
end

local military_item_filters = {
    tool = is_military_science_pack,
    ammo = is_military_ammo,
    gun = is_military_gun,
    capsule = is_military_capsule,
    item = is_military_item,
    ["item-with-entity-data"] = is_military_item,
    armor = is_military_armor
}

function PacifistMod.find_all_military_items()
    local military_items = {}
    local military_item_names = {}

    for type, filter in pairs(military_item_filters) do
        military_items[type] = {}
        for _, item in pairs(data.raw[type]) do
            if filter(item) then
                table.insert(military_items[type], item.name)
                table.insert(military_item_names, item.name)
            end
        end
    end

    if mods["IntermodalContainers"] then
        military_items.item = military_items.item or {}
        for _, name in pairs(military_item_names) do
            local container_name = "ic-container-" .. name
            if data.raw.item[container_name] then
                table.insert(military_items.item, container_name)
                table.insert(military_item_names, container_name)
            end
        end
    end

    return military_items, military_item_names
end

-- recipes that generate any of the given items
function PacifistMod.find_recipes_for(resulting_items)
    local function is_military_result(entry)
        local name = (type(entry) == "string" and entry) or entry.name or entry[1]
        return name and array.contains(resulting_items, name)
    end

    local function contains_result(section)
        if section.result then
            return is_military_result(section.result)
        elseif section.results then
            for _, result_entry in pairs(section.results) do
                if is_military_result(result_entry) then
                    return true
                end
            end
            return false
        else
            return false
        end
    end

    local function is_relevant_recipe(recipe)
        return contains_result(recipe)
                or (recipe.normal and contains_result(recipe.normal))
                or (recipe.expensive and contains_result(recipe.expensive))
    end

    local relevant_recipes = {}
    for _, recipe in pairs(data.raw.recipe) do
        if is_relevant_recipe(recipe) then
            table.insert(relevant_recipes, recipe.name)
        end
    end
    return relevant_recipes
end

function PacifistMod.remove_recipes(obsolete_recipe_names)
    data_raw.remove_all("recipe", obsolete_recipe_names)

    -- productivity module limitations contain recipe names
    for _, module in pairs(data.raw.module) do
        array.remove_all_values(module.limitation, obsolete_recipe_names)
    end
end

function PacifistMod.treat_military_science_pack_requirements()

    local function is_ingredient_military_science_pack(ingredient)
        -- ingredients have either the format {"science-pack", 5}
        -- or {type="tool", name="science-pack", amount=5}
        local ingredient_name = ingredient.name or ingredient[1]
        return data.raw.tool[ingredient_name] and is_military_science_pack(data.raw.tool[ingredient_name])
    end

    for _, technology in pairs(data.raw.technology) do
        array.remove_in_place(technology.unit.ingredients, is_ingredient_military_science_pack)
    end

    -- labs should not show/take the science packs any more even if we can't produce them
    for _, lab in pairs(data.raw.lab) do
        array.remove_all_values(lab.inputs, PacifistMod.military_science_packs)
    end

end

function PacifistMod.remove_military_recipe_ingredients(military_item_names, military_item_recipes)
    local function has_no_ingredients(recipe)
        if recipe.ingredients then
            return array.is_empty(recipe.ingredients)
        end
        return (recipe.normal and array.is_empty(recipe.normal.ingredients or {}))
                or (recipe.expensive and array.is_empty(recipe.expensive.ingredients or {}))
    end

    local function is_void_result(result)
        if type(result) == "string" then
            return not array.contains(PacifistMod.void_items, result)
        else
            return array.is_empty(result) or array.contains(PacifistMod.void_items, result.name or result[1])
        end
    end

    local function has_no_results(recipe)
        local function section_has_empty_result(section)
            if not section then return false end

            if section.result then
                is_void_result(section.result)
            elseif section.results then
                return array.all_of(section.results, is_void_result)
            else
                return false
            end
        end

        return section_has_empty_result(recipe)
                or section_has_empty_result(recipe.normal)
                or section_has_empty_result(recipe.expensive)
                or array.any_of(PacifistMod.void_recipe_suffix, function(suffix) return recipe.name:sub(-#suffix) == suffix end)
    end

    local obsolete_recipes = {}
    for _, recipe in pairs(data.raw.recipe) do
        if not has_no_ingredients(recipe) then
            local removed = {}
            local function is_ingredient_military_item(ingredient)
                -- ingredients have either the format {"advanced-circuit", 5}
                -- or {type="fluid", name="water", amount=50}
                local ingredient_name = ingredient.name or ingredient[1]
                if array.contains(military_item_names, ingredient_name) then
                    table.insert(removed, ingredient_name)
                    return true
                end
                return false
            end

            array.remove_in_place(recipe.ingredients, is_ingredient_military_item)
            array.remove_in_place(recipe.normal and recipe.normal.ingredients, is_ingredient_military_item)
            array.remove_in_place(recipe.expensive and recipe.expensive.ingredients, is_ingredient_military_item)
            if (has_no_ingredients(recipe)) and has_no_results(recipe) then
                table.insert(obsolete_recipes, recipe.name)
            elseif (not array.is_empty(removed)) and (not array.contains(military_item_recipes, recipe.name)) then
                log("removing ingredient(s) " .. array.to_string(removed) .. " from recipe " .. recipe.name)
            end
        end
    end
    if (not array.is_empty(obsolete_recipes)) then
        debug_log("removing recipes with no ingredients and no results left: " .. array.to_string(obsolete_recipes, "\n    "))
        PacifistMod.remove_recipes(obsolete_recipes)
    end
    return obsolete_recipes
end

function PacifistMod.remove_military_entities()
    debug_log("removing entities: " .. array.to_string(military_entity_names, "\n  "))
    local entity_types = PacifistMod.military_entity_types
    array.append(entity_types, PacifistMod.extra.entity_types)

    for _, type in pairs(entity_types) do
        data_raw.remove_all(type, military_entity_names)
    end

    for _, type in pairs(PacifistMod.military_equipment_types) do
        data_raw.remove_all(type, military_equipment_names)
    end
end

function PacifistMod.disable_gun_slots()
    local icon = "__core__/graphics/set-bar-slot.png"
    local icons_to_replace = {
        "slot_icon_ammo",
        "slot_icon_ammo_black",
        "slot_icon_gun",
        "slot_icon_gun_black",
    }
    for _, to_replace in pairs(icons_to_replace) do
        data.raw["utility-sprites"].default[to_replace].filename = icon
    end
end

function PacifistMod.remove_vehicle_guns()
    for _, type in pairs(PacifistMod.vehicle_types) do
        for _, vehicle in pairs(data.raw[type]) do
            vehicle.guns = nil
        end
    end
end

function PacifistMod.remove_armor_references()
    for _, corpse in pairs(data.raw["character-corpse"]) do
        if corpse.armor_picture_mapping then
            for _, armor in pairs(PacifistMod.extra.armor) do
                corpse.armor_picture_mapping[armor] = nil
            end
        end
    end

    for _, character in pairs(data.raw["character"]) do
        for _, animation in pairs(character.animations) do
            if animation.armors then
                array.remove_all_values(animation.armors, PacifistMod.extra.armor)
            end
        end
    end
end

function PacifistMod.remove_military_items_signals(military_item_names)
    local function is_military_item_signal(signal_color_mapping)
        return signal_color_mapping.type == "item"
                and array.contains(military_item_names, signal_color_mapping.name)
    end

    for _, lamp in pairs(data.raw["lamp"] or {}) do
        array.remove_in_place(lamp.signal_to_color_mapping, is_military_item_signal)
    end
end

function PacifistMod.remove_military_items(military_item_table)
    for type, items in pairs(military_item_table) do
        debug_log("removing " .. type .. " prototypes: " .. array.to_string(items, "\n  "))
        data_raw.remove_all(type, items)
    end
end

function PacifistMod.remove_misc()
    -- the tips and tricks items that refers to removed technology/weapons
    if PacifistMod.settings.remove_walls then
        data_raw.remove("tips-and-tricks-item", "gate-over-rail")
    end
    data_raw.remove_all("tips-and-tricks-item", { "shoot-targeting", "shoot-targeting-controller" })

    -- achievements involving military means
    data_raw.remove("dont-build-entity-achievement", "raining-bullets")
    data_raw.remove("group-attack-achievement", "it-stinks-and-they-dont-like-it")
    data_raw.remove("kill-achievement", "steamrolled")
    data_raw.remove("kill-achievement", "pyromaniac")
    data_raw.remove("combat-robot-count", "minions")

    -- some main menu simulations won't run when the according prototypes are missing
    -- also we don't want to see biters and characters slaughtering each other
    local simulations = data.raw["utility-constants"]["default"].main_menu_simulations
    for _, name in pairs(PacifistMod.military_main_menu_simulations) do
        simulations[name] = nil
    end

    for _, entry in pairs(PacifistMod.extra.misc) do
        assert(entry[1] and entry[2])
        data_raw.remove(entry[1], entry[2])
    end
end

function PacifistMod.disable_biters_in_presets()
    local presets = data.raw["map-gen-presets"]["default"]
    presets["death-world"] = nil
    presets["death-world-marathon"] = nil

    for key, preset in pairs(presets) do
        if not array.contains({ "type", "name", "default" }, key) then
            preset.basic_settings = preset.basic_settings or {}
            preset.basic_settings.autoplace_controls = preset.basic_settings.autoplace_controls or {}
            preset.basic_settings.autoplace_controls["enemy-base"] = { size = "none" }
            preset.advanced_settings = preset.advanced_settings or {}
            preset.advanced_settings.pollution = { enabled = false }
        end
    end

    presets["pacifist-default"] = {
        order = "a",
        basic_settings = {
            autoplace_controls = { ["enemy-base"] = { size = "none" } }
        },
        advanced_settings = {
            pollution = { enabled = false }
        }
    }
    presets.default.order = "aa"
end

function PacifistMod.rename_item_category()
    data.raw["item-group"].combat.icon = "__Pacifist__/graphics/item-group/equipment.png"
end
