local array = require("__Pacifist__.lib.array")
local names = require("names")
local settings = require("settings")
local types = require("types")


---@class (exact) ItemInfo
---@field remove boolean?
---@field made_by data.RecipeID[]?
---@field ingredient_in data.RecipeID[]?

---@class AllItemsInfo
---@field [Type] { [Name]: ItemInfo }


local items = {}

---@param item_info AllItemsInfo
---@param type Type
---@param name data.ItemID
---@return ItemInfo
items.info = function(item_info, type, name)
    item_info[type] = item_info[type] or {}
    item_info[type][name] = item_info[type][name] or {}
    return item_info[type][name]
end


---@param data_raw DataRaw
---@param armors { [Name]: ItemInfo }
local _remove_armor_references = function(data_raw, armors)
    for _, corpse in pairs(data_raw["character-corpse"]) do
        if corpse.armor_picture_mapping then
            for armor_name, info in pairs(armors) do
                if info.remove then
                    corpse.armor_picture_mapping[armor_name] = nil
                end
            end
        end
    end

    for _, character in pairs(data_raw["character"]) do
        for _, animation in pairs(character.animations) do
            if animation.armors then
                array.remove_in_place(animation.armors, function(armor_name --[[@as Name]]) return armors[armor_name] and armors[armor_name].remove end)
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

    return item_info
end

--- removes the items according to the item_info
---@param data_raw DataRaw
---@param item_info AllItemsInfo
items.process = function(data_raw, item_info)
    for type, info_by_name in pairs(item_info) do
        for name, info in pairs(info_by_name) do
            if info.remove then
                data_raw:remove(type, name)
            end
        end
    end

    if item_info.armor then
        _remove_armor_references(data_raw, item_info.armor)
    end
    _remove_vehicle_guns(data_raw)
    --[[
     TODO: remove references to deleted ItemIDs:
     see https://lua-api.factorio.com/latest/types/ItemID.html
    ]]
end

return items
