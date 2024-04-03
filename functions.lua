PacifistMod = PacifistMod or {}
require("__Pacifist__.config")
require("__Pacifist__.functions.technology")

local array = require("__Pacifist__.lib.array")
local data_raw = require("__Pacifist__.lib.data_raw")

local military_info = require("__Pacifist__.functions.military-info")



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
        return data.raw.tool[ingredient_name] and array.contains(military_info.items.tool, ingredient_name)
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
    debug_log("removing entities: " .. array.to_string(military_info.entities.names, "\n  "))
    local entity_types = PacifistMod.military_entity_types
    array.append(entity_types, PacifistMod.extra.entity_types)

    for _, type in pairs(entity_types) do
        data_raw.remove_all(type, military_info.entities.names)
    end

    for _, type in pairs(PacifistMod.military_equipment_types) do
        data_raw.remove_all(type, military_info.equipment.names)
    end
end

function PacifistMod.disable_gun_slots()
    local x_icon = "__core__/graphics/set-bar-slot.png"
    local tool_icon = "__Pacifist__/graphics/slot-icon-tool.png"
    local icon_kinds = { "gun", "ammo" }
    for _, kind in pairs(icon_kinds) do
        local icon = x_icon
        if (not array.is_empty(PacifistMod.exceptions[kind])) then
            icon = tool_icon
        end
        for _, to_replace in pairs({"slot_icon_"..kind, "slot_icon_"..kind.."_black"}) do
            data.raw["utility-sprites"].default[to_replace].filename = icon
        end
    end
end

function PacifistMod.remove_vehicle_guns()
    for _, type in pairs(PacifistMod.vehicle_types) do
        for _, vehicle in pairs(data.raw[type]) do
            vehicle.guns = nil
        end
    end
end

function PacifistMod.remove_unit_attacks()
    for _, name in pairs(PacifistMod.units_to_disarm) do
        if data.raw["unit"][name].attack_parameters.ammo_type then
            data.raw["unit"][name].attack_parameters.ammo_type.action = nil
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

    -- hide explosion entities revealed by removing/hiding other things
    data_raw.hide("explosion", "atomic-nuke-shockwave")
    data_raw.hide("explosion", "wall-damaged-explosion")
end

function PacifistMod.record_references()
    -- When we see a name, we aren't being careful enough to know what type
    -- that name is, so if multiple types have the same name, treat a reference
    -- to any one of them as a reference to all of them. This may lead to not
    -- removing something that's actually unreferenced, but won't ever result in
    -- accidentally removing something this is referenced.

    -- all_names is a map from names to all types that have that name.
    local all_names = {}

    -- references[group][name]['from'][other_group][other_name]
    -- is true (not nil) if there is a reference from data.raw[group][name]
    -- to data.raw[other_group][other_name]. There should be a matching entry
    -- references[other_group][other_name]['to'][group][name] which indicates
    -- data.raw[other_group][other_name] has a reference to it
    -- from data.raw[group][name].
    local references = {}

    -- Read just the keys of data.raw to initialize those data structures.
    for group, list in pairs(data.raw) do
        local refs_for_group = {}
        references[group] = refs_for_group
        for _, entity in pairs(list) do
            if not all_names[entity.name] then
                all_names[entity.name] = {}
            end
            all_names[entity.name][group] = true
            refs_for_group[entity.name] = {
                -- Collection of names referenced from this entity.
                from = {},
                -- Collection of names with references to this entity.
                -- If it's empty, then this entity is unreferenced and can be removed.
                to = {},
            }
        end
    end

    -- Helper that recurses through an object x which is data.row[from_group][from_name]
    -- or some subtree thereof and looks for any references to other objects.
    -- Any string matching a name in all_names is assumed to be a reference to be safe.
    -- ref_from is references[from_group][from_name].from.
    local function enumerate_all_strings(ref_from, from_group, from_name, x)
        if not x then
            return
        elseif type(x) == "string" then
            -- Found a string, record references from from_group.from_name to group.x
            --  for all groups x might be in.
            -- Record references in both directions: 
            if all_names[x] then
                for group, _ in pairs(all_names[x]) do
                    -- Record reference from from_group.from_name to group.x.
                    local ref_from_group = ref_from[group]
                    if not ref_from_group then
                        ref_from_group = {}
                        ref_from[group] = ref_from_group
                    end
                    ref_from_group[x] = true

                    -- Record reference to group.x from from_group.from_name.
                    local ref_to = references[group][x].to
                    local ref_to_group = ref_to[from_group]
                    if not ref_to_group then
                        ref_to_group = {}
                        ref_to[from_group] = ref_to_group
                    end
                    ref_to_group[from_name] = true
                end
            end
        elseif type(x) == "table" then
            -- If it's a table, recurse. Some table keys reference entities,
            -- so include keys in the strings that may be references.
            for name, el in pairs(x) do
                if not (name == "type") then
                    enumerate_all_strings(ref_from, from_group, from_name, name)
                    enumerate_all_strings(ref_from, from_group, from_name, el)
                end
            end
        end
    end

    for group, list in pairs(data.raw) do
        for id, entry in pairs(list) do
            for name, value in pairs(entry) do
                if not (name == "name" or name == "type") then
                    local ref_from = references[group][id].from
                    enumerate_all_strings(ref_from, group, id, value)
                end
            end
        end
    end

    return references
end

function PacifistMod.remove_orphaned_entities(references)
    while not (next(data_raw.removed) == nil) do
        local removed = data_raw.removed
        data_raw.removed = {}

        for rem_type, rem_list in pairs(removed) do
            local rem_type_refs = references[rem_type]
            if rem_type_refs then
                for rem_name, _ in pairs(rem_list) do
                    local refs_from_removed = rem_type_refs[rem_name].from
                    for target_type, target_list in pairs(refs_from_removed) do
                        -- Technologies are used even if they don't have references.
                        if not (target_type == "technology") then
                            local target_type_refs = references[target_type]
                            for target_name, _ in pairs(target_list) do
                                -- Only process objects that haven't been removed.
                                if data.raw[target_type][target_name] then
                                    local refs_to_target = target_type_refs[target_name].to
                                    local ref_to_target_of_rem_type = refs_to_target[rem_type]
                                    ref_to_target_of_rem_type[rem_name] = nil
                                    if next(ref_to_target_of_rem_type) == nil then
                                        refs_to_target[rem_type] = nil
                                    end

                                    -- If there's no remaining references to the target, remove it.
                                    if next(refs_to_target) == nil then
                                        log("Removing "..target_type.." orphan: "..target_name)
                                        data_raw.remove(target_type, target_name)
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
        log("Some orphans removed. Checking if anything is newly orphaned...")
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
    data.raw["item-group"].enemies.icon = "__Pacifist__/graphics/item-group/units.png"
end
