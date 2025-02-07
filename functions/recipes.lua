local array = require("__Pacifist__.lib.array") --[[@as Array]]

local types = require("types")

require("__Pacifist__.lib.debug")

---@class (exact) RecipeIngredient
---@field type Type
---@field name Name

---@class RecipeAction
---@field remove boolean
---@field ingredients RecipeIngredient[]


---@class RecipeInfo: {[data.RecipeID]:RecipeAction}[]

local recipes = {}

---@param recipe data.RecipePrototype
---@param item_names Name[]
---@return boolean
local _produces_any_of = function (recipe, item_names)
    for _, product in pairs(recipe.results or {}) do
        if array.contains(item_names, product.name) then
            return true
        end
    end
    return false
end

---@param data_raw DataRaw
---@param recipe_name data.RecipeID
---@return boolean
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

---@param recipe data.RecipePrototype
---@param ingredient_name data.ItemID
local _remove_ingredient = function(recipe, ingredient_name)
    ---@param i data.IngredientPrototype
    ---@return boolean
    local match_ingredient = function(i) return i.name == ingredient_name end

    debug_log("Recipes: removing ingredient " .. ingredient_name .. " from recipe " .. recipe.name)
    array.remove_in_place(recipe.ingredients,  match_ingredient)
end


---@param recipe_info RecipeInfo
---@param recipe_name data.RecipeID
---@param type Type
---@param name data.ItemID
local _tag_ingredient = function(recipe_info, recipe_name, type, name)
    recipe_info[recipe_name] = recipe_info[recipe_name] or {}
    recipe_info[recipe_name].ingredients = recipe_info[recipe_name].ingredients or {}
    table.insert(recipe_info[recipe_name].ingredients, { type = type, name = name })
end


---@param item_info AllItemsInfo
---@return Name[]
local _names_of_items_to_remove = function(item_info)
    ---@type Name[]
    local names = {}
    for name, info in pairs(item_info) do
        if info.remove then
            table.insert(names, name)
        end
    end
    return names
end

---@param config Config
---@param item_info AllItemsInfo
---@return data.RecipeID[]
local _names_of_derived_recipes = function(config, item_info)
    ---@type data.RecipeID[]
    local names = {}
    for name, info in pairs(item_info) do
        if info.remove then
            for _, mapping_fun in pairs(config.extra.get_derived_recipes) do
                local derived_name = mapping_fun(info.type, name)
                if mapping_fun then array.append_unique(names, {derived_name}) end
            end
        end
    end
    return names
end


---@param data_raw DataRaw
---@param config Config
---@param item_info AllItemsInfo
---@return RecipeInfo
recipes.collect_info = function(data_raw, config, item_info)
    ---@type RecipeInfo
    local recipe_info = {}
    local item_names = _names_of_items_to_remove(item_info)
    local derived_recipes = _names_of_derived_recipes(config, item_info)

    for name, recipe in pairs(data_raw.recipe) do
        if _produces_any_of(recipe, item_names) or array.contains(derived_recipes, name) then
            recipe_info[name] = recipe_info[name] or {}
            recipe_info[name].remove = true
        end

        for _, ingredient in pairs(recipe.ingredients or {}) do
            if item_info[ingredient.name] and item_info[ingredient.name].remove then
                _tag_ingredient(recipe_info, name, item_info[ingredient.name].type, ingredient.name)
            end
        end
    end
    return recipe_info
end


---@param data_raw DataRaw
---@param recipe_info RecipeInfo
recipes.process = function(data_raw, recipe_info)

    for recipe_name, actions in pairs(recipe_info) do
        ---@cast recipe_name data.RecipeID
        ---@cast actions RecipeAction
        if actions.remove then
            data_raw:remove("recipe", recipe_name, "marked for removal")
        elseif actions.ingredients then
            for _, ingredient in pairs(actions.ingredients) do
                ---@cast ingredient { type: Type, name: Name }
                if ingredient.type =="gun" and _produces_vehicle(data_raw, recipe_name) then
                    _remove_ingredient(data_raw.recipe[recipe_name], ingredient.name)
                else
                    assert(false, "Didn't handle ingredient " .. ingredient.name .."(" .. ingredient.type ..") of recipe " .. recipe_name)
                end
            end
        end
    end
    --[[
     TODO: remove entities with no more references:
     see https://lua-api.factorio.com/latest/types/EntityID.html
    ]]

end

return recipes