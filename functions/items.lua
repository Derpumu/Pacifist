local array = require("__Pacifist__.lib.array")
local util = require("util")

local items = {}

local _tag = function(t, type, name, tag)
    t[type] = t[type] or {}
    t[type][name] = t[type][name] or {}
    table.insert(t[type][name], tag)
end

items.collect_info = function(data_raw, config, entity_info)
    local item_info = {}

    local entity_names = util.all_names(entity_info)
    for _, type in pairs({"item", "item-with-entity-data"}) do
        for name, item in pairs(data_raw[type]) do
            if item.place_result and array.contains(entity_names, item.place_result) then
                _tag(item_info, type, name, "place_result")
            end
        end
    end

    return item_info
end

items.process = function(data_raw, item_info)
    for type, items in pairs(item_info) do
        for name, item in pairs(items) do
            data_raw:remove(type, name)
        end
    end
end

return items