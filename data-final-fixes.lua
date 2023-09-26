Pacifistmod = Pacifistmod or {}

-- Configuration
Pacifistmod.military_science_packs = {"military-science-pack"}
--- entity types from items (place_result)
Pacifistmod.military_entity_types = {"gate", "wall", "land-mine", "ammo-turret", "electric-turret", "artillery-turret", "fluid-turret", "artillery-wagon"}
-- Equipment types from items (placed_as_equipment_result)
Pacifistmod.military_equipment_types = {"active-defense-equipment", "energy-shield-equipment"}
Pacifistmod.military_item_types = {"ammo", "gun"}
Pacifistmod.vehicle_types = {"car", "spider-vehicle"}
-- capsules include fish and cliff explosives
Pacifistmod.military_capsule_subgroups = {capsule = true, ["military-equipment"] = true, ["defensive-structure"] = true}
Pacifistmod.military_tech_effects = {
    ["ammo-damage"] = true,
    ["turret-attack"] = true,
    ["gun-speed"] = true,
    ["artillery-range"] = true,
    ["maximum-following-robots-count"] = true
}

-- Array helpers
local array = {
    contains = function (arr, element)
        if not arr then
            return false
        end

        for _, e in ipairs(arr) do
            if e == element then
                return true
            end
        end
        return false
    end,

    remove_in_place = function (arr, remove_condition)
        if not arr then
            return
        end

        local original_size = #arr
        local next_index = 1

        for _, element in ipairs(arr) do
            if not remove_condition(element) then
                arr[next_index] = element
                next_index = next_index + 1
            end
        end

        for i = next_index, original_size do
            arr[i] = nil
        end
    end,

    is_empty = function (arr)
        return next(arr) == nil
    end,
}


-- helpers
local function make_contains_condition(arr)
    local function contains_condition(element)
        return array.contains(arr, element)
    end

    return contains_condition
end

local factorio_data = {
    hide = function (type, name)
        local entry = data.raw[type][name]
        if not entry then
            return
        end
        entry.flags = entry.flags or {}
        table.insert(entry.flags, "hidden")
    end,

    remove = function (type, name)
        if name then 
            data.raw[type][name] = nil
        else
            data.raw[type] = nil
        end
    end,
}

factorio_data.hide_all = function (type, name_list)
    for _, name in pairs(name_list) do
        factorio_data.hide(type, name)
    end
end

factorio_data.remove_all = function (type, name_list)
    for _, name in pairs(name_list) do
        factorio_data.remove(type, name)
    end
end


-- technology -> effect (recipe, ...)
-- recipe -> item
-- item -> entity (place_result)
-- item -> equiment (placed_as_equipment_result)

function Pacifistmod.identify_military_results(types)
    local military_results = {}
    for _, type in ipairs(types) do
        for _, entity in pairs(data.raw[type]) do
            military_results[entity.name] = true
        end
    end
    return military_results
end

function Pacifistmod.find_military_capsules()
    local military_capsules = {}
    -- military capsules (not fish and cliff explosives)
    for _, capsule in pairs(data.raw.capsule) do
        if capsule.subgroup and Pacifistmod.military_capsule_subgroups[capsule.subgroup] then
            table.insert(military_capsules, capsule.name)
        end
    end
    return military_capsules
end

function Pacifistmod.find_all_military_items()
    local military_entities = Pacifistmod.identify_military_results(Pacifistmod.military_entity_types)
    local military_equipment = Pacifistmod.identify_military_results(Pacifistmod.military_equipment_types)

    local military_items = {}
    -- science packs
    for _, name in ipairs(Pacifistmod.military_science_packs) do
        table.insert(military_items, name)
    end

    -- item with own types
    --[[
        type = "ammo",
        type = "gun",
        type = "capsule", (grenade, defender) BUT: cliff explosives
            -> check capsule_action.type
    ]]
    for _, type in ipairs(Pacifistmod.military_item_types) do
        for _, item in pairs(data.raw[type]) do
            table.insert(military_items, item.name)
        end
    end

    -- military capsules (not fish and cliff explosives)
    local military_capsules = Pacifistmod.find_military_capsules()
    for _, capsule_name in pairs(military_capsules) do
          table.insert(military_items, capsule_name)
    end

    -- items that are military equipment or placeables
    for _, item in pairs(data.raw.item) do
        if item.place_result and military_entities[item.place_result] then
            table.insert(military_items, item.name)
        elseif item.placed_as_equipment_result and military_equipment[item.placed_as_equipment_result] then
            table.insert(military_items, item.name)
        end
    end

    -- artillery-wagon is a placeable entity, but from an item-with-entity-data instead of an item
    table.insert(military_items, "artillery-wagon")

    return military_items
end

-- recipes that generate any of the given items
function Pacifistmod.find_recipes_for(resulting_items)
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
function Pacifistmod.remove_military_technology_effects(military_recipes)
    local function is_military(effect)
        return Pacifistmod.military_tech_effects[effect.type]
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


function Pacifistmod.remove_obsolete_technologies(obsolete_technologies)
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

    factorio_data.remove_all("technology", obsolete_technologies)
end


function Pacifistmod.remove_military_science_pack_requirements()
    local function is_military_science_pack(ingredient)
        -- ingredient format: {"item-name", count}
        local ingredient_name = ingredient[1]
        return array.contains(Pacifistmod.military_science_packs, ingredient_name)
    end

    for _, technology in pairs(data.raw.technology) do
        array.remove_in_place(technology.unit.ingredients, is_military_science_pack)
    end
end


function Pacifistmod.remove_military_recipe_ingredients(military_items)
    local function is_military_item(ingredient)
        -- ingredient format: {"item-name", count}
        local ingredient_name = ingredient[1]
        return array.contains(military_items, ingredient_name)
    end

    for _, recipe in pairs(data.raw.recipe) do
        array.remove_in_place(recipe.ingredients, is_military_item)
    end
end



function Pacifistmod.remove_military_types()
    local all_type_lists = {Pacifistmod.military_item_types, Pacifistmod.military_equipment_types}
    for _, type_list in pairs(all_type_lists) do
        for _, type in pairs(type_list) do
            for _, entry in pairs(data.raw[type]) do
                factorio_data.hide(type, entry.name)
            end
        end
    end

    for _, type in pairs(Pacifistmod.military_entity_types) do
        for _, entity in pairs(data.raw[type]) do
            entity.minable = nil
        end
    end
end

function Pacifistmod.remove_vehicle_guns()
    for _, type in pairs(Pacifistmod.vehicle_types) do
        for _, vehicle in pairs(data.raw[type]) do
            vehicle.guns = nil
        end
    end
end

function Pacifistmod.hide_military_items(military_items)
    factorio_data.hide_all("item", military_items)

    local military_capsules = Pacifistmod.find_military_capsules()
    factorio_data.hide_all("capsule", military_capsules)

    factorio_data.hide("item-with-entity-data", "artillery-wagon")
end


function Pacifistmod.hide_science_packs()
    factorio_data.hide_all("tool", Pacifistmod.military_science_packs)

    -- labs should not show/take the science packs any more even if we can't produce them
    for _, lab in pairs(data.raw.lab) do
        array.remove_in_place(lab.inputs, make_contains_condition(Pacifistmod.military_science_packs))
    end
end


function Pacifistmod.remove_recipes(obsolete_recipe_names)
    factorio_data.remove_all("recipe", obsolete_recipe_names)

    -- productivity module limitations contain recipe names
    for _, module in pairs(data.raw.module) do
        array.remove_in_place(module.limitation, make_contains_condition(obsolete_recipe_names))
    end
end


function Pacifistmod.remove_mischellaneous()
    -- the tips and tricks item regarding gates over rails is obsolete and refers to removed technology
    factorio_data.remove("tips-and-tricks-item", "gate-over-rail")

    -- achievements involving military means
    factorio_data.remove("dont-build-entity-achievement", "raining-bullets")
    factorio_data.remove("group-attack-achievement", "it-stinks-and-they-dont-like-it")
    factorio_data.remove("kill-achievement", "steamrolled")
    factorio_data.remove("kill-achievement", "pyromaniac")
    factorio_data.remove("combat-robot-count", "minions")
end


local military_items = Pacifistmod.find_all_military_items()
local military_item_recipes = Pacifistmod.find_recipes_for(military_items)
local obsolete_technologies = Pacifistmod.remove_military_technology_effects(military_item_recipes)
Pacifistmod.remove_obsolete_technologies(obsolete_technologies)
Pacifistmod.remove_military_science_pack_requirements()

Pacifistmod.remove_military_recipe_ingredients(military_items)

Pacifistmod.remove_military_types()
Pacifistmod.hide_military_items(military_items)
Pacifistmod.remove_vehicle_guns()
Pacifistmod.hide_science_packs()
Pacifistmod.remove_recipes(military_item_recipes)


Pacifistmod.remove_mischellaneous()

-- TODO:
-- disable biters
-- remove tanks? (type = car, name = tank)
-- remove ammo and weapon slots from player (guns = {})
-- remove instead of hide items and entities

