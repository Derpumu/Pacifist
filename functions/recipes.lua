local array = require("__Pacifist__.lib.array")
local names = require("names")
local types = require("types")

require("__Pacifist__.lib.debug")

local recipes = {}

local _produces_any_of = function (recipe, item_names)
    if recipe.name == "stone-wall" then
        dump_table(recipe)
        dump_table(item_names)
    end
    for _, product in pairs(recipe.results or {}) do
        if array.contains(item_names, product.name) then
            return true
        end
    end
    return false
end

local _produces_vehicle = function(data_raw, recipe_name)
    local recipe = data_raw.recipe[recipe_name]
    for _, type in pairs(types.vehicles) do
        for vehicle_name, _ in pairs(data_raw[type]) do
            if array.any_of(recipe.results or {}, function(result) return result.name == vehicle_name end ) then
                return true
            end
        end
    end
    return false
end

local _remove_ingredient = function(recipe, ingredient_name)
    debug_log("Recipes: removing ingredient " .. ingredient_name .. " from recipe " .. recipe.name)
    array.remove_in_place(recipe.ingredients, function(i) return i.name == ingredient_name end)
end

local _tag_ingredient = function(recipe_info, recipe_name, type, name)
    recipe_info[recipe_name] = recipe_info[recipe_name] or {}
    recipe_info[recipe_name].ingredient = recipe_info[recipe_name].ingredient or {}
    table.insert(recipe_info[recipe_name].ingredient, { type = type, name = name })
end

--[[
returns table recipe_info: RecipeID -> action
    possible actions:
    {
       remove = true,
       ingredient = { type = name }
    }
--]]
recipes.collect_info = function(data_raw, config, item_info)
    local recipe_info = {}

    dump_table(item_info)
    local item_names = names.all_names(item_info)
    dump_table(item_names)
    for name, recipe in pairs(data_raw.recipe) do
        if _produces_any_of(recipe, item_names) then
            recipe_info[name] = recipe_info[name] or {}
            recipe_info[name].remove = true
        end

        for _, ingredient in pairs(recipe.ingredients or {}) do
            for type, names in pairs(item_info) do
                if array.contains(names, ingredient.name) then
                    _tag_ingredient(recipe_info, name, type, ingredient.name)
                end
            end
        end
    end
    dump_table(recipe_info, "return recipe_info")
    return recipe_info
end

recipes.process = function(data_raw, recipe_info)
    dump_table(recipe_info, "process recipe_info")
    for recipe_name, actions in pairs(recipe_info) do
        if actions.remove then 
            data_raw:remove("recipe", recipe_name)
        elseif actions.ingredient then
            for _, ingredient in pairs(actions.ingredient) do
                if ingredient.type =="gun" and _produces_vehicle(data_raw, recipe_name) then
                    _remove_ingredient(data_raw.recipe[recipe_name], ingredient.name)
                else
                    assert(false, "Didn't handle ingredient " .. ingredient.name .."(" .. ingredient.type ..")")
                end
            end
        end
    end
    --[[
     TODO: remove references to deleted EntityIDs:
     see https://lua-api.factorio.com/latest/types/EntityID.html
    ]]

end

return recipes