local array = require("__Pacifist__.lib.array")
local names = require("names")
local settings = require("settings")
local types = require("types")

local items = {}

local _tag = function(t, type, name)
    t[type] = t[type] or {}
    table.insert(t[type], name)
end

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

local _item_filters = {
    tool = function(tool, config) return array.contains(config.extra.science_packs, tool.name) end,
    -- ammo = function(ammo, config) return not array.contains(config.exceptions.ammo, ammo.name) end,
    -- gun = function(gun, config) return not array.contains(config.exceptions.gun, gun.name) end,
    -- capsule = _is_military_capsule,
    armor = function(armor, config)
        return array.contains(config.extra.armor, armor.name)
            or (settings.remove_armor and not armor.equipment_grid and (not armor.inventory_size_bonus or armor.inventory_size_bonus == 0))
    end
}

--[[
returns table item_info: type -> namelist
--]]
items.collect_info = function(data_raw, config, entity_info, equipment_info)
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

items.process = function(data_raw, item_info)
    for type, names in pairs(item_info) do
        data_raw:remove_all(type, names)
    end

    _remove_armor_references(data_raw, item_info.armor or {})
    --[[
     TODO: remove references to deleted ItemIDs:
     see https://lua-api.factorio.com/latest/types/ItemID.html
    ]]
end

return items