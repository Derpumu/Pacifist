local array = require("__Pacifist__.lib.array")
local data_raw = require("__Pacifist__.lib.data_raw")


local function _is_ignored_result(result)
    if type(result) == "string" then
        return not array.contains(PacifistMod.ignore.result_items, result)
    else
        return array.is_empty(result) or array.contains(PacifistMod.ignore.result_items, result.name or result[1])
    end
end

local function _has_no_results(recipe)
    local function section_has_no_result(section)
        if not section then return false end

        if section.result then
            return _is_ignored_result(section.result)
        elseif section.results then
            return array.all_of(section.results, _is_ignored_result)
        else
            return false
        end
    end

    return section_has_no_result(recipe)
            or section_has_no_result(recipe.normal)
            or section_has_no_result(recipe.expensive)
            or array.any_of(PacifistMod.ignore.recipe_pred, function(predicate) return predicate(recipe) end)
end

local function _is_ingredient_military_item(ingredient)
    -- ingredients have either the format {"advanced-circuit", 5}
    -- or {type="fluid", name="water", amount=50}
    local ingredient_name = ingredient.name or ingredient[1]
    if array.contains(PacifistMod.military_item_names, ingredient_name) then
        return true
    end
    return false
end

local function _has_only_military_ingredients(recipe)
    if not recipe.normal and not recipe.expensive then
        -- if neither normal nor expensive is defined, recipe.ingredients has to be defined
        return not array.is_empty(recipe.ingredients)
                and array.all_of(recipe.ingredients, _is_ingredient_military_item)
    end

    if recipe.normal
            and (array.is_empty(recipe.normal.ingredients)
            or not array.all_of(recipe.normal.ingredients, _is_ingredient_military_item)) then
        return false
    end

    if recipe.expensive
            and (array.is_empty(recipe.expensive.ingredients)
            or not array.all_of(recipe.expensive.ingredients, _is_ingredient_military_item)) then
        return false
    end
    return true
end

local function _has_military_results(recipe)
    local function _is_military_result(entry)
        local name = (type(entry) == "string" and entry) or entry.name or entry[1]
        return name and array.contains(PacifistMod.military_item_names, name)
    end

    local function _contains_military_result(section)
        if section.result then
            return _is_military_result(section.result)
        elseif section.results then
            for _, result_entry in pairs(section.results) do
                if _is_military_result(result_entry) then
                    return true
                end
            end
            return false
        else
            return false
        end
    end

    return _contains_military_result(recipe)
            or (recipe.normal and _contains_military_result(recipe.normal))
            or (recipe.expensive and _contains_military_result(recipe.expensive))

end

local function _is_military_recipe(recipe)
    return _has_military_results(recipe)
    or (_has_no_results(recipe) and _has_only_military_ingredients(recipe))
end


local function _replace_military_ingredients(recipe)
    -- 1: find recipes that have military ingredients but do not produce military results
    -- 2: log their ingredients as non_military, find recipes that make them
    -- 3: check if those recipes have military ingredients (recursively)

    local removed_ingredients = {}
    local function _check_and_log(ingredient)
        if _is_ingredient_military_item(ingredient) then
            array.append_unique(removed_ingredients, { ingredient.name or ingredient[1] })
            return true
        else
            return false
        end
    end

    local function _remove_from_section(section)
        if not section then return end
        array.remove_in_place(section.ingredients, _check_and_log)
    end

    if not recipe.normal and not recipe.expensive then
        _remove_from_section(recipe)
    end
    if recipe.normal then _remove_from_section(recipe.normal) end
    if recipe.expensive then _remove_from_section(recipe.expensive) end

    if not array.is_empty(removed_ingredients) and not recipe.hidden then
        log("Removed ingredients from recipe " .. recipe.name .. ": " .. array.to_string(removed_ingredients))
    end
end

function PacifistMod.process_recipes()
    local military_recipes = {}
    for _, recipe in pairs(data.raw.recipe) do
        if _is_military_recipe(recipe) then
            table.insert(military_recipes, recipe.name)
        else
            _replace_military_ingredients(recipe)
        end
    end

    PacifistMod.military_recipes = military_recipes
end

function PacifistMod.remove_recipes()
    data_raw.remove_all("recipe", PacifistMod.military_recipes)

    -- productivity module limitations contain recipe names
    for _, module in pairs(data.raw.module) do
        array.remove_all_values(module.limitation, PacifistMod.military_recipes)
    end
end
