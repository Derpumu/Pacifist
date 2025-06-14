local array = require("__Pacifist__.lib.array") --[[@as Array]]
local types = require("types")

local _find_item = function(item_name)
    for _, type in pairs(types.items) do
        assert(data.raw[type], type .. ": type not found")
        if data.raw[type][item_name] then
            return data.raw[type][item_name]
        end
    end
    return nil
end


---replaces a military item with an actual item that is no longer a gun, ammo, etc.
---it also moves the recipe to create that item to a technology that has a followup recipe
---example: grenades are required for cliff explosives, so they are moved to the cliff explosive technology
---@param item_name data.ItemID
---@param item_type Type
---@param recipe_result_name data.ItemID
---@param localised_name data.LocalisedString
function pacify_item(item_name, item_type, recipe_result_name, localised_name)
    local item = data.raw[item_type][item_name] --[[@as data.ItemPrototype]]
    if not item then return end
    data.raw[item_type][item_name] = nil

    item.type = "item"

    local result_item = _find_item(recipe_result_name)
    if result_item then
        item.subgroup = result_item.subgroup
        item.order = (result_item.order or "").."z"
    end
    if localised_name then
        item.localised_name = localised_name
    end

    data:extend{item}

    local recipe_name = item_name
    assert(data.raw["recipe"][item_name], "pacify_item: item " .. item_name .. " has no equally named recipe")

    local result_tech_name = recipe_result_name
    local result_tech = data.raw["technology"][result_tech_name]
    assert(result_tech, "pacify_item: result item " .. recipe_result_name .. " has no equally names technology")

    ---@type data.UnlockRecipeModifier?
    local recipe_effect = nil
    for _, technology in pairs(data.raw["technology"]) do
        if technology.effects then
            for _, effect in pairs(technology.effects) do
                if effect.type == "unlock-recipe" and effect.recipe == recipe_name then
                    recipe_effect = effect
                end
            end
            array.remove_in_place(technology.effects, function(effect) return effect.type =="unlock-recipe" and effect.recipe == recipe_name end)
        end
    end

    ---@type data.TechnologyPrototype?
    if recipe_effect and result_tech then
        result_tech.effects = result_tech.effects or {}
        table.insert(result_tech.effects, recipe_effect)
    end
end
