local items = require("__Pacifist__.functions.items")
local array = require("__Pacifist__.lib.array") --[[@as Array]]


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


function convert_to_item(military_item_name)
    local item = items.find(data.raw, military_item_name)
    assert(item, "(convert_to_item) item not found: " .. military_item_name)
    data.raw[item.type][military_item_name] = nil
    item.type = "item"
    item.place_result = nil
    item.place_as_equipment_result = nil
    data:extend { item }
    return data.raw["item"][military_item_name]
end

---replaces a military item with an actual item that is no longer a gun, ammo, etc.
---it also moves the recipe to create that item to a technology that has a followup recipe
---example: grenades are required for cliff explosives, so they are moved to the cliff explosive technology
---@param military_item_name data.ItemID
---@param result_item_name data.ItemID
function pacify_item(military_item_name, result_item_name)
    local result_item = items.find(data.raw, result_item_name)
    if not result_item then
        log("Warning: (pacify_item) item not found: " .. military_item_name)
        return
    end

    local item = convert_to_item(military_item_name)
    item.subgroup = result_item.subgroup
    item.order = (result_item.order or "") .. "z"

    local military_recipes = _recipes_producing(military_item_name)

    ---@type data.RecipeID[]
    local military_recipe_names = {}
    for _, military_recipe in pairs(military_recipes) do
        table.insert(military_recipe_names, military_recipe.name)
    end

    local result_recipes = _recipes_producing(result_item_name)
    if #result_recipes ~= 1 then
        log("Warning: (pacify_item ) No/multiple recipes found producing " ..
        result_item_name .. " (" .. tostring(#result_recipes) .. ")")
        dump_table(result_recipes)
        return
    end
    local result_recipe_name = result_recipes[1].name
    if not array.any_of(result_recipes[1].ingredients, function(ingredient --[[@as data.ItemIngredientPrototype]])
            return ingredient.name == military_item_name
        end) then
        log("Warning: (pacify_item) Recipe " ..
        result_recipe_name .. " producing " .. result_item_name .. " does not use " .. military_item_name)
        return
    end


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
            array.remove_in_place(technology.effects,
                function(effect) return effect.type == "unlock-recipe" and
                    array.contains(military_recipe_names, effect.recipe) end)
        end
    end

    if array.is_empty(military_recipe_effects) then
        log("Warning: (pacify_item) No technology found enabling recipes " ..
        array.to_string(military_recipe_names, ",") .. " for item " .. military_item_name)
        return
    end

    if not result_tech then
        log("Warning: (pacify_item) no technology found enabling recipe " ..
        result_recipe_name .. " using item " .. military_item_name)
        return
    end

    result_tech.effects = result_tech.effects or {}
    for _, effect in pairs(military_recipe_effects) do
        table.insert(result_tech.effects, effect)
        debug_log("Moved unlocking of recipe " .. effect.recipe .. " to technology " .. result_tech.name)
    end
end
