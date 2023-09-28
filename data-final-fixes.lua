PacifistMod = PacifistMod or {}

-- Configuration
PacifistMod.military_science_packs = { "military-science-pack" }

-- Entities types from items (place_result)
PacifistMod.military_entity_types = {
    "artillery-turret",
    -- "character",
    -- "enemy-spawner",
    -- "combat-robot",
    "gate",
    "land-mine",
    "ammo-turret",
    "electric-turret",
    "fluid-turret",
    -- "car" -- tanks are here
    "artillery-wagon",
    "wall",
}

-- Equipment types from items (placed_as_equipment_result)
PacifistMod.military_equipment_types = {
    "active-defense-equipment",
    "energy-shield-equipment"
}

-- Items
PacifistMod.military_item_types = {
    "ammo",
    "gun",
}

PacifistMod.vehicle_types = {
    "car",
    "spider-vehicle"
}

-- capsules include fish and cliff explosives
PacifistMod.military_capsule_subgroups = {
    "capsule",
    "military-equipment",
    "defensive-structure" -- e.g. artillery remote
}

PacifistMod.military_tech_effects = {
    "ammo-damage",
    "turret-attack",
    "gun-speed",
    "artillery-range",
    "maximum-following-robots-count"
}

local array = require("functions.array")
local data_raw = require("functions.data_raw")


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

local function always(item) return true end

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

    for type, filter in pairs(military_item_filters) do
        for _, item in pairs(data.raw[type]) do
            if filter(item) then
                table.insert(military_items, item.name)
            end
        end
    end

    return military_items
end


-- deprecated
function PacifistMod.find_military_capsules()
    local military_capsules = {}
    -- military capsules (not fish and cliff explosives)
    for _, capsule in pairs(data.raw.capsule) do
        if capsule.subgroup and array.contains(PacifistMod.military_capsule_subgroups, capsule.subgroup) then
            table.insert(military_capsules, capsule.name)
        end
    end
    return military_capsules
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
        return array.contains(PacifistMod.military_tech_effects)
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
    local function is_military_science_pack(ingredient)
        -- ingredient format: {"item-name", count}
        local ingredient_name = ingredient[1]
        return array.contains(PacifistMod.military_science_packs, ingredient_name)
    end

    for _, technology in pairs(data.raw.technology) do
        array.remove_in_place(technology.unit.ingredients, is_military_science_pack)
    end
end

function PacifistMod.remove_military_recipe_ingredients(military_items)
    local function is_military_item(ingredient)
        -- ingredient format: {"item-name", count}
        local ingredient_name = ingredient[1]
        return array.contains(military_items, ingredient_name)
    end

    for _, recipe in pairs(data.raw.recipe) do
        array.remove_in_place(recipe.ingredients, is_military_item)
    end
end

function PacifistMod.remove_military_types()
    local all_type_lists = { PacifistMod.military_item_types, PacifistMod.military_equipment_types }
    for _, type_list in pairs(all_type_lists) do
        for _, type in pairs(type_list) do
            for _, entry in pairs(data.raw[type]) do
                data_raw.hide(type, entry.name)
            end
        end
    end

    for _, type in pairs(PacifistMod.military_entity_types) do
        for _, entity in pairs(data.raw[type]) do
            entity.minable = nil
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

function PacifistMod.hide_military_items(military_items)
    data_raw.hide_all("item", military_items)

    local military_capsules = PacifistMod.find_military_capsules()
    data_raw.hide_all("capsule", military_capsules)

    data_raw.hide("item-with-entity-data", "artillery-wagon")
end

function PacifistMod.hide_science_packs()
    data_raw.hide_all("tool", PacifistMod.military_science_packs)

    -- labs should not show/take the science packs any more even if we can't produce them
    for _, lab in pairs(data.raw.lab) do
        array.remove_in_place(lab.inputs, array.bind_contains(PacifistMod.military_science_packs))
    end
end

function PacifistMod.remove_recipes(obsolete_recipe_names)
    data_raw.remove_all("recipe", obsolete_recipe_names)

    -- productivity module limitations contain recipe names
    for _, module in pairs(data.raw.module) do
        array.remove_in_place(module.limitation, array.bind_contains(obsolete_recipe_names))
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
end

local military_items = PacifistMod.find_all_military_items()
local military_item_recipes = PacifistMod.find_recipes_for(military_items)
local obsolete_technologies = PacifistMod.remove_military_technology_effects(military_item_recipes)
PacifistMod.remove_obsolete_technologies(obsolete_technologies)
PacifistMod.remove_military_science_pack_requirements()

PacifistMod.remove_military_recipe_ingredients(military_items)

PacifistMod.remove_military_types()
PacifistMod.hide_military_items(military_items)
PacifistMod.remove_vehicle_guns()
PacifistMod.hide_science_packs()
PacifistMod.remove_recipes(military_item_recipes)

PacifistMod.remove_misc()

-- TODO:
-- disable biters
-- remove tanks? (type = car, name = tank)
-- remove ammo and weapon slots from player (guns = {})
-- remove instead of hide items and entities

