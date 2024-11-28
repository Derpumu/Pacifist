local array = require("__Pacifist__.lib.array")
local names = require("names")
local settings = require("settings")
local types = require("types")


---@class ItemInfo : { [Type]: Name[] }
---@field armor Name[]

local items = {}

---tag an item to remove in the item info table
---@param item_info ItemInfo
---@param type Type
---@param name data.ItemID
local _tag = function(item_info, type, name)
    item_info[type] = item_info[type] or {}
    table.insert(item_info[type], name)
end

---@param data_raw DataRaw
---@param armor_names data.ItemID[]
local _remove_armor_references = function(data_raw, armor_names)
    for _, corpse in pairs(data_raw["character-corpse"]) do
        if corpse.armor_picture_mapping then
            for _, armor in pairs(armor_names) do
                corpse.armor_picture_mapping[armor] = nil
            end
        end
    end

    for _, character in pairs(data_raw["character"]) do
        for _, animation in pairs(character.animations) do
            if animation.armors then
                array.remove_all_values(animation.armors, armor_names)
            end
        end
    end
end

--- removes guns from all vehicles
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
---@type { [Type]: fun(name: any, config: Config): boolean }
local _item_filters = {
    tool = function(tool --[[@as data.ToolPrototype]], config) return array.contains(config.extra.science_packs, tool.name) end,
    -- ammo = function(ammo, config) return not array.contains(config.exceptions.ammo, ammo.name) end,
    gun = function(gun --[[@as data.GunPrototype]], config) return not array.contains(config.exceptions.gun, gun.name) end,
    -- capsule = _is_military_capsule,
    armor = function(armor --[[@as data.ArmorPrototype]], config)
        return array.contains(config.extra.armor, armor.name)
            or (settings.remove_armor and not armor.equipment_grid and (not armor.inventory_size_bonus or armor.inventory_size_bonus == 0))
    end
}


---calculates a table of items to remove.
---@param data_raw DataRaw
---@param config any
---@param entity_info any
---@param equipment_info any
---@return ItemInfo
items.collect_info = function(data_raw, config, entity_info, equipment_info)
    ---@type ItemInfo
    local item_info = {}

    local entity_names = names.all_names(entity_info)
    local equipment_names = names.all_names(equipment_info)
    for _, type in pairs(types.items) do
        for name, item in pairs(data_raw[type] or {}) do
            if item.place_result and array.contains(entity_names, item.place_result) then
                _tag(item_info, type, name)
            elseif item.place_as_equipment_result and array.contains(equipment_names, item.place_as_equipment_result) then
                _tag(item_info, type, name)
            elseif _item_filters[type] and _item_filters[type](item, config) then
                _tag(item_info, type, name)
            end
        end
    end

    return item_info
end

--- removes the items according to the item_info
---@param data_raw DataRaw
---@param item_info ItemInfo
items.process = function(data_raw, item_info)
    for type, namelist in pairs(item_info) do
        data_raw:remove_all(type, namelist)
    end

    _remove_armor_references(data_raw, item_info.armor or {})
    _remove_vehicle_guns(data_raw)
    --[[
     TODO: remove references to deleted ItemIDs:
     see https://lua-api.factorio.com/latest/types/ItemID.html
    ]]
end

return items