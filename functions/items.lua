local array = require("__Pacifist__.lib.array") --[[@as Array]]

local names = require("names")
local settings = require("settings")
local types = require("types")


---@class (exact) ItemInfo
---@field type Type
---@field remove boolean?
---@field made_by data.RecipeID[]?
---@field ingredient_in data.RecipeID[]?

---@alias AllItemsInfo { [Name]: ItemInfo }


local items = {}

---@param item_info AllItemsInfo
---@param type Type
---@param name data.ItemID
---@return ItemInfo
items.info = function(item_info, type, name)
    item_info[name] = item_info[name] or { type = type } --[[@as ItemInfo]]
    assert(item_info[name].type == type)
    return item_info[name]
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
        end
    end
end

--- Table of functions that determine whether an item has to be considered to be military
---@package
---@type { [Type]: fun(name: any, config: Config): boolean }
local _item_filters = {
    tool = function(tool --[[@as data.ToolPrototype]], config) return array.contains(config.extra.science_packs,
            tool.name) end,
    -- ammo = function(ammo, config) return not array.contains(config.exceptions.ammo, ammo.name) end,
    gun = function(gun --[[@as data.GunPrototype]], config) return not array.contains(config.exceptions.gun, gun.name) end,
    -- capsule = _is_military_capsule,
    armor = function(armor --[[@as data.ArmorPrototype]], config)
        return array.contains(config.extra.armor, armor.name)
            or
            (settings.remove_armor and not armor.equipment_grid and (not armor.inventory_size_bonus or armor.inventory_size_bonus == 0))
    end
}

---there are capsules that, as equipment remotes, trigger equipment that might be removed
---therse capsules have to be removed as well
---@param data_raw DataRaw
---@param item_info AllItemsInfo
---@param equipment_info EquipmentInfo
local _mark_equipment_remotes = function(data_raw, item_info, equipment_info)
    for name, capsule in pairs(data_raw["capsule"]) do
        if capsule.capsule_action.type == "equipment-remote" and array.contains(equipment_info["active-defense-equipment"], capsule.capsule_action.equipment)  then
            items.info(item_info, "capsule", name).remove = true
        end
    end
end

---calculates a table of items to remove.
---@param data_raw DataRaw
---@param config any
---@param entity_info any
---@param equipment_info any
---@return AllItemsInfo
items.collect_info = function(data_raw, config, entity_info, equipment_info)
    ---@type AllItemsInfo
    local item_info = {}

    local entity_names = names.all_names(entity_info)
    local equipment_names = names.all_names(equipment_info)
    for _, type in pairs(types.items) do
        for name, item in pairs(data_raw[type] or {}) do
            if (item.place_result and array.contains(entity_names, item.place_result)) or
                (item.place_as_equipment_result and array.contains(equipment_names, item.place_as_equipment_result)) or
                (_item_filters[type] and _item_filters[type](item, config)) then
                items.info(item_info, type, name).remove = true
            end
        end
    end

    _mark_equipment_remotes(data_raw, item_info, equipment_info)

    return item_info
end


---@param data_raw DataRaw
---@param item_info AllItemsInfo
local _remove_inputs_and_shortcuts = function(data_raw, item_info)
    for name, input in pairs(data_raw["custom-input"]) do
        if input.item_to_spawn then
            local item_name = input.item_to_spawn
            if item_info[item_name] and item_info[item_name].remove then
                data_raw:remove("custom-input", name)
            end
        end
    end

    for name, shortcut in pairs(data_raw["shortcut"]) do
        if shortcut.item_to_spawn then
            local item_name = shortcut.item_to_spawn
            if item_info[item_name] and item_info[item_name].remove then
                data_raw:remove("shortcut", name)
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
            data_raw:remove(info.type, name)
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

return items
