local array = require("__Pacifist__.lib.array") --[[@as Array]]

local types = require("types")

require("__Pacifist__.lib.debug")

---@class (exact) RecipeIngredient
---@field type Type
---@field name Name
---@field amount number

---@class RecipeAction
---@field remove boolean
---@field ingredients RecipeIngredient[]


---@class RecipeInfo: {[data.RecipeID]:RecipeAction}

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

---returns a predicate that matches ingredients based on the provided name
---@param ingredient_name data.ItemID
---@return fun(i:data.IngredientPrototype):boolean
local _match_ingredient_name = function(ingredient_name)
    return function(i) return i.name == ingredient_name end
end

---@param recipe data.RecipePrototype
---@param ingredient_name data.ItemID
local _remove_ingredient = function(recipe, ingredient_name)
    debug_log("Recipes: removing ingredient " .. ingredient_name .. " from recipe " .. recipe.name)
    array.remove_in_place(recipe.ingredients, _match_ingredient_name(ingredient_name))
end


---@param recipe_info RecipeInfo
---@param recipe_name data.RecipeID
---@param type Type
---@param name data.ItemID
---@param amount number
local _tag_ingredient = function(recipe_info, recipe_name, type, name, amount)
    recipe_info[recipe_name] = recipe_info[recipe_name] or {}
    recipe_info[recipe_name].ingredients = recipe_info[recipe_name].ingredients or {}
    table.insert(recipe_info[recipe_name].ingredients, { type = type, name = name, amount = amount })
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
                local derived_name = mapping_fun(name, info.type)
                if derived_name then array.append_unique(names, {derived_name}) end
            end
        end
    end
    return names
end

---replaces in ingredient in the recipe with the corresponding amount of raw ingredients from the ingredient_recipe
---@param recipe data.RecipePrototype
---@param ingredient RecipeIngredient
---@param ingredient_recipe data.RecipePrototype
local _replace_with_raw_ingredients = function(recipe, ingredient, ingredient_recipe)
    assert(#ingredient_recipe.results == 1, "replacement recipe " .. ingredient_recipe.name .. " can only have one result! (" .. recipe.name .. "(recipe))")
    local result_amount = ingredient_recipe.results[1].amount
    assert(result_amount ~= nil, "replacement recipe " .. ingredient_recipe.name .. " may not have variable result! (" .. recipe.name .. "(recipe))")

    debug_log("Recipes: replacing ingredient " .. ingredient.name .. " of recipe " .. recipe.name .. " with ingredients of " .. ingredient_recipe.name)

    local multiplier = ingredient.amount/result_amount
    _remove_ingredient(recipe, ingredient.name)
    for _, replacement_ingredient in pairs(ingredient_recipe.ingredients) do
        local amount = replacement_ingredient.amount * multiplier

        -- Duplicate ingredient entries are not allowed, so look whether the ingredient already exists
        local existing_ingredients = array.select(recipe.ingredients, _match_ingredient_name(replacement_ingredient.name))
        if array.is_empty(existing_ingredients) then
            table.insert(recipe.ingredients, {type = "item", name = replacement_ingredient.name, amount = amount })
        else
            local i = existing_ingredients[1] -- there can be only the one
            local total_amount = i.amount + amount
            i.amount = total_amount
        end
    end
end


---@param data_raw DataRaw
---@param ingredient RecipeIngredient
---@return boolean
local _is_wall_or_gate = function(data_raw, ingredient)
    local item = data_raw[ingredient.type][ingredient.name] --[[@as data.ItemPrototype]]
    local name = item and item.place_result
    if not name then return false end

    if data_raw.wall and data_raw.wall[name] then return true end
    if data_raw.gate and data_raw.gate[name] then return true end
    return false
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
        if _produces_any_of(recipe, item_names) or array.contains(derived_recipes, name) or array.contains(config.extra.recipe, name) then
            recipe_info[name] = recipe_info[name] or {}
            recipe_info[name].remove = true
        end

        for _, ingredient in pairs(recipe.ingredients or {}) do
            if item_info[ingredient.name] and item_info[ingredient.name].remove then
                _tag_ingredient(recipe_info, name, item_info[ingredient.name].type, ingredient.name, ingredient.amount)
            end
        end
    end
    return recipe_info
end


---@param data_raw DataRaw
---@param recipe_info RecipeInfo
local _process_ingredients = function(data_raw, recipe_info)
    for recipe_name, actions in pairs(recipe_info) do
        if not actions.remove and actions.ingredients then
            for _, ingredient in pairs(actions.ingredients) do
                ---@cast ingredient { type: Type, name: Name }
                if ingredient.type =="gun" and _produces_vehicle(data_raw, recipe_name) then
                    _remove_ingredient(data_raw.recipe[recipe_name], ingredient.name)
                elseif _is_wall_or_gate(data_raw, ingredient) and data_raw.recipe[ingredient.name] then
                    _replace_with_raw_ingredients(data_raw.recipe[recipe_name], ingredient, data_raw.recipe[ingredient.name])
                else
                    dump_table(data_raw.recipe[recipe_name], "recipe")
                    dump_table(actions, "recipe actions")
                    assert(false, "Didn't handle ingredient " .. ingredient.name .."(" .. ingredient.type ..") of recipe " .. recipe_name)
                end
            end
        end
    end
end


---@param data_raw DataRaw
---@param recipe_info RecipeInfo
recipes.process = function(data_raw, recipe_info)
    -- ingredients have to be processed before any recipes are removed
    _process_ingredients(data_raw, recipe_info)

    for recipe_name, actions in pairs(recipe_info) do
        if actions.remove then
            data_raw:remove("recipe", recipe_name, "marked for removal")
        end
    end
    --[[
     TODO: remove entities with no more references:
     see https://lua-api.factorio.com/latest/types/EntityID.html
    ]]

end


---@param data_raw data.raw
---@param recipe_name data.RecipeID
---@param ingredient_name data.ItemID
recipes.remove_ingredient = function(data_raw, recipe_name, ingredient_name)
    local recipe = data_raw["recipe"][recipe_name]
    if not recipe then return end
    _remove_ingredient(recipe, ingredient_name)
end

return recipes