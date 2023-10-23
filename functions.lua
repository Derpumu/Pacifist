PacifistMod = PacifistMod or {}
require("__Pacifist__.config")
require("__Pacifist__.functions.technology")

local array = require("__Pacifist__.lib.array")
local data_raw = require("__Pacifist__.lib.data_raw")

function PacifistMod.clone_dummies()
    local dummies = require("__Pacifist__.prototypes.dummies")
    return dummies
end

local military_entity_names = data_raw.get_all_names_for(PacifistMod.military_entity_types)
array.remove_all_values(military_entity_names, PacifistMod.exceptions.entity)
assert(not array.contains(military_entity_names, "shield-projector"))

local military_equipment_names = data_raw.get_all_names_for(PacifistMod.military_equipment_types)

local function is_military_item(item)
    assert (not array.contains(military_entity_names, "shield-projector"))
    return (item.place_result and array.contains(military_entity_names, item.place_result))
            or (item.placed_as_equipment_result and array.contains(military_equipment_names, item.placed_as_equipment_result))
end

local function is_military_capsule(capsule)
    return capsule.subgroup and array.contains(PacifistMod.military_capsule_subgroups, capsule.subgroup)
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

local military_item_filters = {
    tool = is_military_science_pack,
    ammo = is_military_ammo,
    gun = is_military_gun,
    capsule = is_military_capsule,
    item = is_military_item,
    ["item-with-entity-data"] = is_military_item,
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

    return military_items, military_item_names
end

-- recipes that generate any of the given items
function PacifistMod.find_recipes_for(resulting_items)
    local function is_relevant_recipe(recipe)
        local function contains_result(section)
            if section.result then
                if type(section.result) == "string" then
                    return array.contains(resulting_items, section.result)
                elseif section.result.name then
                    return array.contains(resulting_items, section.result.name)
                elseif section.result[1] then
                    return array.contains(resulting_items, section.result[1])
                else
                    log("recipe result format not recognized: " .. recipe.name)
                    return false
                end
            elseif section.results then
                for _, result_entry in pairs(section.results) do
                    if result_entry.name and array.contains(resulting_items, result_entry.name) then
                        return true
                    end
                end
                return false
            else
                return false
            end
        end

        return contains_result(recipe)
                or (recipe.normal and contains_result(recipe.normal))
                or (recipe.expensive and contains_result(recipe.normal))
    end

    local relevant_recipes = {}
    for _, recipe in pairs(data.raw.recipe) do
        if is_relevant_recipe(recipe) then
            table.insert(relevant_recipes, recipe.name)
        end
    end
    return relevant_recipes
end

function PacifistMod.treat_military_science_pack_requirements()

    local function is_ingredient_military_science_pack(ingredient)
        -- ingredients have either the format {"science-pack", 5}
        -- or {type="tool", name="science-pack", amount=5}
        local ingredient_name = ingredient.name or ingredient[1]
        return data.raw.tool[ingredient_name] and is_military_science_pack(data.raw.tool[ingredient_name])
    end

    for _, technology in pairs(data.raw.technology) do
        if PacifistMod.settings.replace_science_packs then
            for _, ingredient in pairs(technology.unit.ingredients) do
                local ingredient_name = ingredient[1]
                local replacement = PacifistMod.settings.replace_science_packs[ingredient_name]
                ingredient[1] = replacement or ingredient_name
            end
            for i, prerequisite in pairs(technology.prerequisites or {}) do
                local replacement = PacifistMod.settings.replace_science_packs[prerequisite]
                technology.prerequisites[i] = replacement or prerequisite
            end
        else
            array.remove_in_place(technology.unit.ingredients, is_ingredient_military_science_pack)
        end
    end

    -- labs should not show/take the science packs any more even if we can't produce them
    for _, lab in pairs(data.raw.lab) do
        if PacifistMod.settings.replace_science_packs then
            for i, input in ipairs(lab.inputs) do
                local replacement = PacifistMod.settings.replace_science_packs[input]
                lab.inputs[i] = replacement or input
            end
        else
            array.remove_all_values(lab.inputs, PacifistMod.military_science_packs)
        end
    end

end

function PacifistMod.remove_military_recipe_ingredients(military_item_names)
    local function is_ingredient_military_item(ingredient)
        -- ingredients have either the format {"advanced-circuit", 5}
        -- or {type="fluid", name="water", amount=50}
        local ingredient_name = ingredient.name or ingredient[1]
        return array.contains(military_item_names, ingredient_name)
    end

    for _, recipe in pairs(data.raw.recipe) do
        array.remove_in_place(recipe.ingredients, is_ingredient_military_item)
    end
end

function PacifistMod.remove_military_entities()
    for _, type in pairs(PacifistMod.military_entity_types) do
        data_raw.remove_all(type, military_entity_names)
    end

    for _, type in pairs(PacifistMod.military_equipment_types) do
        data_raw.remove_all(type, military_equipment_names)
    end
end

function PacifistMod.remove_vehicle_guns()
    for _, type in pairs(PacifistMod.vehicle_types) do
        for _, vehicle in pairs(data.raw[type]) do
            vehicle.guns = nil
        end
    end
end

function PacifistMod.make_military_items_unplaceable(military_item_table)
    for type, items in pairs(military_item_table) do
        for _, item_name in pairs(items) do
            data.raw[type][item_name].place_result = nil
            data.raw[type][item_name].placed_as_equipment_result = nil
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
        data_raw.remove_all(type, items)
    end
end

function PacifistMod.remove_recipes(obsolete_recipe_names)
    data_raw.remove_all("recipe", obsolete_recipe_names)

    -- productivity module limitations contain recipe names
    for _, module in pairs(data.raw.module) do
        array.remove_all_values(module.limitation, obsolete_recipe_names)
    end
end

function PacifistMod.remove_misc()
    -- the tips and tricks item regarding gates over rails is obsolete and refers to removed technology
    if PacifistMod.settings.remove_walls then
        data_raw.remove("tips-and-tricks-item", "gate-over-rail")
    end

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
end

function PacifistMod.disable_biters_in_presets()
    local presets = data.raw["map-gen-presets"]["default"]
    presets["death-world"] = nil
    presets["death-world-marathon"] = nil

    for key, preset in pairs(presets) do
        if not array.contains({ "type", "name", "default" }, key) then
            assert(type(preset) == "table", key .. "->" .. tostring(preset) .. " = " .. type(preset))
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
