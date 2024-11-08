local array = require("__Pacifist__.lib.array")
local util = require("util")

local items = {}

local _tag = function(t, type, name)
    t[type] = t[type] or {}
    table.insert(t[type], name)
end

--[[
returns table item_info: type -> namelist
--]]
items.collect_info = function(data_raw, config, entity_info)
    local item_info = {}

    local entity_names = util.all_names(entity_info)
    for _, type in pairs({"item", "item-with-entity-data"}) do
        for name, item in pairs(data_raw[type]) do
            if item.place_result and array.contains(entity_names, item.place_result) then
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

    --[[
     TODO: remove references to deleted ItemIDs:
     see https://lua-api.factorio.com/latest/types/ItemID.html
    ]]
end

return items