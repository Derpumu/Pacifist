local array = require("__Pacifist__.lib.array") --[[@as Array]]

local names = require("names")
local settings = require("settings")
local types = require("types")

require("__Pacifist__.lib.debug")

---@class (exact) ItemInfo
---@field type Type
---@field remove boolean?
---@field made_by data.RecipeID[]
---@field ingredient_in data.RecipeID[]

---@alias AllItemsInfo { [data.ItemID]: ItemInfo }


local items = {}

---@param item_info AllItemsInfo
---@param type Type
---@param name data.ItemID
local _add_info = function(item_info, type, name)
    item_info[name] = item_info[name] or { type = type, made_by = {}, ingredient_in = {} } --[[@as ItemInfo]]
end

---@package
---@param data_raw DataRaw
---@param item_info AllItemsInfo
local _remove_armor_references = function(data_raw, item_info)
    for name, info in pairs(item_info) do
        if info.type == "armor" and info.remove then
            for _, corpse in pairs(data_raw["character-corpse"]) do
                if corpse.armor_picture_mapping then
                    corpse.armor_picture_mapping[name] = nil
                end
            end

            for _, character in pairs(data_raw["character"]) do
                for _, animation in pairs(character.animations) do
                    if animation.armors then
                        array.remove(animation.armors, name)
                    end
                end
            end
        end
    end
end


--- removes guns from all vehicles
---@package
---@param data_raw DataRaw
local _remove_vehicle_guns = function(data_raw)
    for _, type in pairs(types.vehicles) do
        for _, vehicle in pairs(data_raw[type]) do
            vehicle.guns = nil
            vehicle.gun = nil
            vehicle.turret_animation = nil
            vehicle.turret_rotation_speed = nil
            vehicle.turret_return_timeout = nil
        end
    end
end

--- checks whether a capsule is military
---@package
---@param capsule data.CapsulePrototype
---@param config Config
local _capsule_filter = function(capsule, config)
    return capsule.subgroup == "capsule"
        and not array.contains(config.exceptions.capsule, capsule.name)
end

--- checks whether an armor item should be removed
---@param armor data.ArmorPrototype
---@param config Config
---@return boolean
local _armor_filter = function(armor --[[@as data.ArmorPrototype]], config)
    if not settings.remove_armor then return false end
    local no_bonus = not armor.inventory_size_bonus or armor.inventory_size_bonus == 0
    local purely_military = no_bonus and not armor.equipment_grid
    return array.contains(config.extra.armor, armor.name) or (purely_military and not array.contains(config.exceptions.armor, armor.name))
end

--- create a filter that checks whether a military item should be removed (default: yes)
---@param type Type
---@return fun(name: data.ItemPrototype, config: Config): boolean
local _default_yes = function(type)
    return function (item, config)
        return not array.contains(config.exceptions[type], item.name)
    end
end

--- Table of functions that determine whether an item has to be considered to be military
---@package
---@type { [Type]: fun(name: data.ItemPrototype, config: Config): boolean }
local _item_filters = {
    ammo = _default_yes("ammo"),
    gun = _default_yes("gun"),
    capsule = _capsule_filter,
    armor = _armor_filter,
}

---there are capsules that, as equipment remotes, trigger equipment that might be removed
---therse capsules have to be removed as well
---prerequisite: item info has to exist for every capsule
---@param data_raw DataRaw
---@param item_info AllItemsInfo
---@param equipment_info EquipmentInfo
local _mark_equipment_remotes = function(data_raw, item_info, equipment_info)
    for name, capsule in pairs(data_raw["capsule"]) do
        if capsule.capsule_action.type == "equipment-remote" and array.contains(equipment_info["active-defense-equipment"], capsule.capsule_action.equipment) then
            item_info[name].remove = true
        end
    end
end

---@param data_raw DataRaw
---@param item_info AllItemsInfo
local _mark_artillery_remotes = function(data_raw, item_info)
    for name, capsule in pairs(data_raw["capsule"]) do
        if capsule.capsule_action.type == "artillery-remote" then
            item_info[name].remove = true
        end
    end
end

---collect in which recipes items are involved
---prerequisite: item info has to exist for every item
---@param data_raw DataRaw
---@param item_info AllItemsInfo
local _collect_recipe_involvement = function(data_raw, item_info)
    for recipe_name, recipe in pairs(data_raw["recipe"]) do
        for _, result in pairs(recipe.results or {}) do
            if result.type == "item" then
                ---@cast result data.ItemProductPrototype
                assert(item_info[result.name], "no item info for result " .. result.name .. " (" .. recipe_name .. ")")
                array.append(item_info[result.name].made_by, { recipe_name })
            end
        end
        for _, ingredient in pairs(recipe.ingredients or {}) do
            if ingredient.type == "item" then
                ---@cast ingredient data.ItemIngredientPrototype
                assert(item_info[ingredient.name],
                    "no item info for ingredient " .. ingredient.name .. " (" .. recipe_name .. ")")
                array.append(item_info[ingredient.name].ingredient_in, { recipe_name })
            end
        end
    end
end

---mark items that are derived from identified military items, e.g. packaged containers
---@param config Config
---@param item_info AllItemsInfo
local _mark_derived_items = function(config, item_info)
    local derived_names = {}
    for _ , mapping_fun in pairs(config.extra.get_derived_items) do
        for name, info in pairs(item_info) do
            if info.remove then
                local derived_name = mapping_fun(name)
                if derived_name then
                    array.append_unique(derived_names, { derived_name })
                    debug_log(name .. " -> " .. derived_name)
                end
            end
        end
    end

    for _, derived_name in pairs(derived_names) do
        if item_info[derived_name] then item_info[derived_name].remove = true end
    end
end

---calculates a table of items to remove.
---@param data_raw DataRaw
---@param config Config
---@param entity_info EntityInfo
---@param equipment_info EquipmentInfo
---@return AllItemsInfo
items.collect_info = function(data_raw, config, entity_info, equipment_info)
    ---@type AllItemsInfo
    local item_info = {}

    local entity_names = names.all_names(entity_info)
    local equipment_names = names.all_names(equipment_info)
    for _, type in pairs(types.item) do
        for name, item in pairs(data_raw[type] or {}) do
            _add_info(item_info, type, name)
            -- is this ammo/gun, military science, etc.?
            item_info[name].remove = (_item_filters[type] and _item_filters[type](item, config))
                -- is this placed as a military building? (turret, artillery wagon, etc.)
                or (item.place_result and array.contains(entity_names, item.place_result))
                -- is this placed as military equipment?
                or (item.place_as_equipment_result and array.contains(equipment_names, item.place_as_equipment_result))
                -- did someone mark this explicitly to be removed?
                or (config.extra[type] and array.contains(config.extra[type], name))
                or false
        end
    end

    _mark_equipment_remotes(data_raw, item_info, equipment_info)
    _mark_artillery_remotes(data_raw, item_info)
    _mark_derived_items(config, item_info)

    _collect_recipe_involvement(data_raw, item_info)

    return item_info
end


---@param data_raw DataRaw
---@param item_info AllItemsInfo
local _remove_inputs_and_shortcuts = function(data_raw, item_info)
    for name, input in pairs(data_raw["custom-input"]) do
        if input.item_to_spawn then
            local item_name = input.item_to_spawn
            if item_info[item_name] and item_info[item_name].remove then
                data_raw:remove("custom-input", name, "spawns removed item " .. item_name)
            end
        end
    end

    for name, shortcut in pairs(data_raw["shortcut"]) do
        if shortcut.item_to_spawn then
            local item_name = shortcut.item_to_spawn
            if item_info[item_name] and item_info[item_name].remove then
                data_raw:remove("shortcut", name, "spawns removed item " .. item_name)
            end
        end
    end
end

--- removes the items according to the item_info
---@param data_raw DataRaw
---@param item_info AllItemsInfo
items.process = function(data_raw, item_info)
    for name, info in pairs(item_info) do
        if info.remove then
            data_raw:remove(info.type, name, "item marked for removal")
        end
    end

    _remove_armor_references(data_raw, item_info)
    _remove_vehicle_guns(data_raw)
    _remove_inputs_and_shortcuts(data_raw, item_info)
    --[[
     TODO: remove references to deleted ItemIDs:
     see https://lua-api.factorio.com/latest/types/ItemID.html
    ]]
end

---@param data_raw data.raw
---@param item_name data.ItemID
---@return data.ItemPrototype?
items.find = function(data_raw, item_name)
    for _, type in pairs(types.item) do
        if data_raw[type] and data_raw[type][item_name] then
            return data_raw[type][item_name] --[[@as data.ItemPrototype]]
        end
    end
    return nil
end


---replaces the item with the name with the same item but a different type in data_raw
---@param data_raw data.raw
---@param item_name data.ItemID
---@param type Type
---@return data.ItemPrototype?
items.change_type = function(data_raw, item_name, type)
    local item = items.find(data_raw, item_name)
    if not item then return nil end

    data_raw[item.type][item_name] = nil
    item.type = type
    data:extend({item})
    return item
end

return items
