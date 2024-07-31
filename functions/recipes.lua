local array = require("__Pacifist__.lib.array")
local data_raw = require("__Pacifist__.lib.data_raw")


-- recipes that generate any of the given items
local function find_recipes_for(resulting_items)
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

local function has_no_ingredients(recipe)
    if recipe.ingredients then
        return array.is_empty(recipe.ingredients)
    end
    return (recipe.normal and array.is_empty(recipe.normal.ingredients or {}))
            or (recipe.expensive and array.is_empty(recipe.expensive.ingredients or {}))
end

local function is_ignored_result(result)
    if type(result) == "string" then
        return not array.contains(PacifistMod.ignore.result_items, result)
    else
        return array.is_empty(result) or array.contains(PacifistMod.ignore.result_items, result.name or result[1])
    end
end

local function has_no_results(recipe)
    local function section_has_no_result(section)
        if not section then return false end

        if section.result then
            return is_ignored_result(section.result)
        elseif section.results then
            return array.all_of(section.results, is_ignored_result)
        else
            return false
        end
    end

    return section_has_no_result(recipe)
            or section_has_no_result(recipe.normal)
            or section_has_no_result(recipe.expensive)
            or array.any_of(PacifistMod.ignore.recipe_pred, function(predicate) return predicate(recipe) end)
end

local function remove_military_recipe_ingredients(military_item_names, military_item_recipes)
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

function PacifistMod.process_recipes()
    local military_item_recipes = find_recipes_for(PacifistMod.military_item_names)

    local more_obsolete_recipes = remove_military_recipe_ingredients(PacifistMod.military_item_names, military_item_recipes)
    array.append(military_item_recipes, more_obsolete_recipes)

    return military_item_recipes
end

function PacifistMod.remove_recipes(obsolete_recipe_names)
    data_raw.remove_all("recipe", obsolete_recipe_names)

    -- productivity module limitations contain recipe names
    for _, module in pairs(data.raw.module) do
        array.remove_all_values(module.limitation, obsolete_recipe_names)
    end
end
