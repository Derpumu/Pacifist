PacifistMod = PacifistMod or {}
require("__Pacifist__.config")
require("__Pacifist__.functions.technology")

local array = require("__Pacifist__.lib.array")
local data_raw = require("__Pacifist__.lib.data_raw")

function PacifistMod.clone_dummies()
    local dummies = {}

    for type, name_list in pairs(PacifistMod.dummies_to_clone) do
        for _, name in pairs(name_list) do

            dummy = util.table.deepcopy(data.raw[type][name])
            assert(dummy, "tried to clone " .. type .. " " .. name .. ", but got nil")
            dummy.name = "dummy-" .. name
            dummy.minable = nil
            dummy.placed_as_equipment_result = nil
            if dummy.gun then
                dummy.gun = "dummy-" .. dummy.gun
            end
            table.insert(dummies, dummy)

        end
    end

    return dummies
end

-- identify which items are military
local military_entity_names = data_raw.get_all_names_for(PacifistMod.military_entity_types)
local military_equipment_names = data_raw.get_all_names_for(PacifistMod.military_equipment_types)

local function is_military_item(item)
    return (item.place_result and array.contains(military_entity_names, item.place_result))
            or (item.placed_as_equipment_result and array.contains(military_equipment_names, item.placed_as_equipment_result))
end

local function is_military_capsule(capsule)
    return capsule.subgroup and array.contains(PacifistMod.military_capsule_subgroups, capsule.subgroup)
end

local function is_military_science_pack(tool)
    return array.contains(PacifistMod.military_science_packs, tool.name)
end

local function always(item)
    return true
end

local military_item_filters = {
    tool = is_military_science_pack,
    ammo = always,
    gun = always,
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
        return (recipe.result and array.contains(resulting_items, recipe.result))
                or (recipe.normal and recipe.normal.result and array.contains(resulting_items, recipe.normal.result))
                or (recipe.expensive and recipe.expensive.result and array.contains(resulting_items, recipe.expensive.result))
    end

    local relevant_recipes = {}
    for _, recipe in pairs(data.raw.recipe) do
        if is_relevant_recipe(recipe) then
            table.insert(relevant_recipes, recipe.name)
        end
    end
    return relevant_recipes
end

-- remove military effects from technologies, returns obsolete technologies that have no effects left
function PacifistMod.remove_military_technology_effects(military_recipes)
    local function is_military(effect)
        return array.contains(PacifistMod.military_tech_effects, effect.type)
                or (effect.type == "unlock-recipe" and array.contains(military_recipes, effect.recipe))
    end

    local obsolete_technologies = {}
    for _, technology in pairs(data.raw.technology) do
        if technology.effects then
            array.remove_in_place(technology.effects, is_military)
            if array.is_empty(technology.effects) then
                table.insert(obsolete_technologies, technology.name)
            end
        end
    end
    return obsolete_technologies
end

function PacifistMod.remove_obsolete_technologies(obsolete_technologies)
    local prerequisites_fixed = {}

    local function fix_prerequisites(technology_name)
        if (not data.raw.technology[technology_name].prerequisites) or prerequisites_fixed[technology_name] then
            return
        end

        local new_prerequisites = {}
        local prerequisite_added = {}

        local function add_prerequisite(prerequisite_name)
            if prerequisite_added[prerequisite_name] then
                return
            end
            table.insert(new_prerequisites, prerequisite_name)
            prerequisite_added[prerequisite_name] = true
        end

        for _, prerequisite_name in ipairs(data.raw.technology[technology_name].prerequisites) do
            if not array.contains(obsolete_technologies, prerequisite_name) then
                add_prerequisite(prerequisite_name)
            elseif data.raw.technology[prerequisite_name].prerequisites then
                -- make sure the prerequisites of the obsolete prerequisite are not obsolete too before taking them over
                fix_prerequisites(prerequisite_name)
                for _, pre_prerequisite in ipairs(data.raw.technology[prerequisite_name].prerequisites) do
                    add_prerequisite(pre_prerequisite)
                end
            end
        end

        data.raw.technology[technology_name].prerequisites = new_prerequisites
        prerequisites_fixed[technology_name] = true
    end

    for _, technology in pairs(data.raw.technology) do
        fix_prerequisites(technology.name)
    end

    data_raw.remove_all("technology", obsolete_technologies)
end

function PacifistMod.remove_military_science_pack_requirements()
    local function is_ingredient_military_science_pack(ingredient)
        -- ingredient format: {"item-name", count}
        local ingredient_name = ingredient[1]
        return data.raw.tool[ingredient_name] and is_military_science_pack(data.raw.tool[ingredient_name])
    end

    for _, technology in pairs(data.raw.technology) do
        array.remove_in_place(technology.unit.ingredients, is_ingredient_military_science_pack)
    end
end

function PacifistMod.remove_military_recipe_ingredients(military_item_names)
    local function is_ingredient_military_item(ingredient)
        -- ingredients have either the format {"advanced-circuit", 5}
        -- or {type="fluid", name="water", amount=50}
        local item_name = ingredient.name or ingredient[1]
        return array.contains(military_item_names, item_name)
    end

    for _, recipe in pairs(data.raw.recipe) do
        array.remove_in_place(recipe.ingredients, is_ingredient_military_item)
    end
end

function PacifistMod.remove_military_entities()
    local all_type_lists = {}
    array.append(all_type_lists, PacifistMod.military_entity_types)
    array.append(all_type_lists, PacifistMod.military_equipment_types)

    for _, type in pairs(all_type_lists) do
        for _, entry in pairs(data.raw[type]) do
            data_raw.remove(type)
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

function PacifistMod.make_military_items_unplaceable(military_item_table)
    for type, items in pairs(military_item_table) do
        for _, item_name in pairs(items) do
            data.raw[type][item_name].place_result = nil
            data.raw[type][item_name].placed_as_equipment_result = nil
        end
    end
end

function PacifistMod.remove_military_items(military_item_table)
    for type, items in pairs(military_item_table) do
        data_raw.remove_all(type, items)
    end

    -- labs should not show/take the science packs any more even if we can't produce them
    for _, lab in pairs(data.raw.lab) do
        array.remove_all_values(lab.inputs, PacifistMod.military_science_packs)
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
    data_raw.remove("tips-and-tricks-item", "gate-over-rail")

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
        end
    end

    presets["pacifist-default"] = {
        order = "a",
        basic_settings = {
            autoplace_controls = {
                ["enemy-base"] = { size = "none" }
            }
        }
    }
    presets.default.order = "aa"
end