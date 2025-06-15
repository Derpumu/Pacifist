local array = require("__Pacifist__.lib.array") --[[@as Array]]
local types = require("types")

---finds the item of any type with the given name
---@param item_name data.ItemID
---@return data.ItemPrototype?
local _find_item = function(item_name)
    for _, type in pairs(types.items) do
        if data.raw[type] and data.raw[type][item_name] then
            return data.raw[type][item_name] --[[@as data.ItemPrototype]]
        end
    end
    return nil
end


---@param item_name data.ItemID
---@return data.RecipePrototype[]
local _recipes_producing = function(item_name)
    --@type data.RecipePrototype[]
    local recipes = {}
    for _, recipe in pairs(data.raw["recipe"]) do
        if recipe.category ~= "recycling" then
            for _, result in pairs(recipe.results or {}) do
                if result.name == item_name then
                    table.insert(recipes, recipe)
                end
            end
        end
    end
    return recipes
end


---replaces a military item with an actual item that is no longer a gun, ammo, etc.
---it also moves the recipe to create that item to a technology that has a followup recipe
---example: grenades are required for cliff explosives, so they are moved to the cliff explosive technology
---@param military_item_name data.ItemID
---@param result_item_name data.ItemID
function pacify_item(military_item_name, result_item_name)
    local item = _find_item(military_item_name)
    assert(item, "(pacify_item) item not found: " .. military_item_name)
    data.raw[item.type][military_item_name] = nil

    item.type = "item"

    local result_item = _find_item(result_item_name)
    assert(result_item, "(pacify_item) item not found: " .. result_item_name)
    item.subgroup = result_item.subgroup
    item.order = (result_item.order or "").."z"

    data:extend{item}


    local military_recipes = _recipes_producing(military_item_name)

    ---@type data.RecipeID[]
    local military_recipe_names = {}
    for _, military_recipe in pairs(military_recipes) do
        table.insert(military_recipe_names, military_recipe.name)
    end


    local result_recipes = _recipes_producing(result_item_name)
    assert(#result_recipes == 1, "(pacify_item) No/multiple recipes found producing " .. result_item_name .. " (" .. tostring(#result_recipes) .. ")")
    local result_recipe_name = result_recipes[1].name
    assert(array.any_of(result_recipes[1].ingredients, function (ingredient --[[@as data.ItemIngredientPrototype]])
        return ingredient.name == military_item_name
    end), "(pacify_item) Recipe " .. result_recipe_name .. " producing " .. result_item_name .. " does not use " .. military_item_name)


    ---@type data.UnlockRecipeModifier[]
    local military_recipe_effects = {}
    ---@type data.TechnologyPrototype
    local result_tech = nil

    for _, technology in pairs(data.raw["technology"]) do
        if technology.effects then
            for _, effect in pairs(technology.effects) do
                if effect.type == "unlock-recipe" and array.contains(military_recipe_names, effect.recipe) then
                    table.insert(military_recipe_effects, effect)
                end
                if effect.type == "unlock-recipe" and effect.recipe == result_recipe_name then
                    result_tech = technology
                end
            end
            array.remove_in_place(technology.effects, function(effect) return effect.type =="unlock-recipe" and array.contains(military_recipe_names, effect.recipe) end)
        end
    end

    assert(not array.is_empty(military_recipe_effects), "(pacify_item) No technology found enabling recipes " .. array.to_string(military_recipe_names, ",") .. " for item " .. military_item_name)
    assert(result_tech, "(pacify_item) no technology found enabling recipe " .. result_recipe_name .. " using item " .. military_item_name)

    result_tech.effects = result_tech.effects or {}
    for _, effect in pairs(military_recipe_effects) do
        table.insert(result_tech.effects, effect)
        debug_log("Moved unlocking of recipe " .. effect.recipe .. " to technology " .. result_tech.name)
    end
end
