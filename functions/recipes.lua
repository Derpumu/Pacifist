local array = require("__Pacifist__.lib.array")
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

---comment
---@param recipe_info RecipeInfo
---@param recipe_name data.RecipeID
---@param type Type
---@param name data.ItemID
local _tag_ingredient = function(recipe_info, recipe_name, type, name)
    recipe_info[recipe_name] = recipe_info[recipe_name] or {}
    recipe_info[recipe_name].ingredients = recipe_info[recipe_name].ingredients or {}
    table.insert(recipe_info[recipe_name].ingredients, { type = type, name = name })
end

---comment
---@param item_info AllItemsInfo
---@return Name[]
local _names_of_items_to_remove = function(item_info)
    local names = {}
    for _, info_by_name in pairs(item_info) do
        for name, info in pairs(info_by_name) do
            if info.remove then
                table.insert(names, name)
            end
        end
    end
    return names
end

--[[
returns table recipe_info: RecipeID -> action
    possible actions:
    {
       remove = true,
       ingredient = { type = name }
    }
--]]
---comment
---@param data_raw DataRaw
---@param config Config
---@param item_info AllItemsInfo
---@return RecipeInfo
recipes.collect_info = function(data_raw, config, item_info)
    ---@type RecipeInfo
    local recipe_info = {}

    dump_table(item_info)
    local item_names = _names_of_items_to_remove(item_info)
    dump_table(item_names)
    for name, recipe in pairs(data_raw.recipe) do
        if _produces_any_of(recipe, item_names) then
            recipe_info[name] = recipe_info[name] or {}
            recipe_info[name].remove = true
        end

        for _, ingredient in pairs(recipe.ingredients or {}) do
            for type, info_by_name in pairs(item_info) do
                if info_by_name[ingredient.name] and info_by_name[ingredient.name].remove then
                    _tag_ingredient(recipe_info, name, type, ingredient.name)
                end
            end
        end
    end
    dump_table(recipe_info, "return recipe_info")
    return recipe_info
end

---comment
---@param data_raw DataRaw
---@param recipe_info RecipeInfo
recipes.process = function(data_raw, recipe_info)
    dump_table(recipe_info, "process recipe_info")

    for recipe_name, actions in pairs(recipe_info) do
        ---@cast recipe_name data.RecipeID
        ---@cast actions RecipeAction
        if actions.remove then
            data_raw:remove("recipe", recipe_name)
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
     TODO: remove references to deleted EntityIDs:
     see https://lua-api.factorio.com/latest/types/EntityID.html
    ]]

end

return recipes