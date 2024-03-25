require("__Pacifist__.config")

local array = require("__Pacifist__.lib.array")
local data_raw = require("__Pacifist__.lib.data_raw")


-- Entities

local entities = {}
entities.types = PacifistMod.military_entity_types
entities.names = (function()
    local military_entity_names = data_raw.get_all_names_for(entities.types)
    array.remove_all_values(military_entity_names, PacifistMod.exceptions.entity)
    array.append(military_entity_names, PacifistMod.extra.entity)
    return military_entity_names
end)()


-- Equipment

local equipment = {}
equipment.names = (function()
    local military_equipment_names = data_raw.get_all_names_for(PacifistMod.military_equipment_types)
    array.remove_all_values(military_equipment_names, PacifistMod.exceptions.equipment)
    return military_equipment_names
end)()


-- Items

local function is_military_item(item)
    return (item.place_result and array.contains(entities.names, item.place_result))
            or (item.placed_as_equipment_result and array.contains(equipment.names, item.placed_as_equipment_result))
            or array.contains(PacifistMod.extra.item, item.name)
end
local function is_military_capsule(capsule)
    local is_military_subgroup = capsule.subgroup and array.contains(PacifistMod.military_capsule_subgroups, capsule.subgroup)
    local is_military_equipment_remote = capsule.capsule_action and capsule.capsule_action.type == "equipment-remote"
            and array.contains(equipment.names, capsule.capsule_action.equipment)

    return (is_military_subgroup or is_military_equipment_remote)
            and not array.contains(PacifistMod.exceptions.capsule, capsule.name)
end

local military_item_filters = {
    tool = function(tool) return array.contains(PacifistMod.military_science_packs, tool.name) end,
    ammo = function(ammo) return not array.contains(PacifistMod.exceptions.ammo, ammo.name) end,
    gun = function(gun) return not array.contains(PacifistMod.exceptions.gun, gun.name) end,
    capsule = is_military_capsule,
    item = is_military_item,
    ["item-with-entity-data"] = is_military_item,
    armor = function(armor) return array.contains(PacifistMod.extra.armor, armor.name) end
}

local items = {}
local item_names = {}

for type, filter in pairs(military_item_filters) do
    items[type] = {}
    for _, item in pairs(data.raw[type]) do
        if filter(item) then
            table.insert(items[type], item.name)
            table.insert(item_names, item.name)
        end
    end
end

if mods["IntermodalContainers"] then
    items.item = items.item or {}
    for _, name in pairs(item_names) do
        local container_name = "ic-container-" .. name
        if data.raw.item[container_name] then
            table.insert(items.item, container_name)
            table.insert(item_names, container_name)
        end
    end
end


-- Recipes
local function find_recipes()
    local function is_military_result(entry)
        local name = (type(entry) == "string" and entry) or entry.name or entry[1]
        return name and array.contains(item_names, name)
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

local recipes = find_recipes()

local function has_no_ingredients(recipe)
    if recipe.ingredients then
        return array.is_empty(recipe.ingredients)
    end
    return (recipe.normal and array.is_empty(recipe.normal.ingredients or {}))
            or (recipe.expensive and array.is_empty(recipe.expensive.ingredients or {}))
end


local function has_no_results(recipe)
    local function is_void_result(result)
        if type(result) == "string" then
            return array.contains(PacifistMod.void_items, result)
        else
            return array.is_empty(result) or is_void_result(result.name or result[1])
        end
    end

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
local
for _, recipe in pairs(data.raw.recipe) do
    if not has_no_ingredients(recipe) then
        local removed = {}
        local function is_ingredient_military_item(ingredient)
            -- ingredients have either the format {"advanced-circuit", 5}
            -- or {type="fluid", name="water", amount=50}
            local ingredient_name = ingredient.name or ingredient[1]
            if array.contains(item_names, ingredient_name) then
                table.insert(removed, ingredient_name)
                return true
            end
            return false
        end


        --array.remove_in_place(recipe.ingredients, is_ingredient_military_item)
        --array.remove_in_place(recipe.normal and recipe.normal.ingredients, is_ingredient_military_item)
        --array.remove_in_place(recipe.expensive and recipe.expensive.ingredients, is_ingredient_military_item)
        if (has_no_ingredients(recipe)) and has_no_results(recipe) then
            table.insert(obsolete_recipes, recipe.name)
            --elseif (not array.is_empty(removed)) and (not array.contains(military_item_recipes, recipe.name)) then
            --    log("removing ingredient(s) " .. array.to_string(removed) .. " from recipe " .. recipe.name)
        end
    end
end
if (not array.is_empty(obsolete_recipes)) then
    debug_log("recipes with no ingredients and no results left: " .. array.to_string(obsolete_recipes, "\n    "))
    array.append(recipes, obsolete_recipes)
end
--

local military = {
    entities = entities,
    equipment = equipment,
    items = items,
    item_names = item_names,
    recipes = recipes
}

return military
