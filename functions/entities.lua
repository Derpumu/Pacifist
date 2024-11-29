local array = require("__Pacifist__.lib.array") --[[@as Array]]
local entities = {}

--[[
returns table entity_info: type -> namelist of placeable military entities
--]]
entities.collect_info = function(data_raw, config)
    local entity_info = {}
    for _, type in pairs(config.types.military_entities) do
        entity_info[type] = data_raw:get_all_names_for(type)
    end

    --[[
     TODO:
     - add types of non-placeable entities, e.g. artillery-flare
     see https://lua-api.factorio.com/latest/prototypes/EntityPrototype.html
    ]]


    for type, names in pairs(config.exceptions.entity) do
        if entity_info[type] then
            array.remove_all(entity_info[type], names)
        end
    end

    for type, names in pairs(config.extra.entity) do
        entity_info[type] = entity_info[type] or {}
        array.append(entity_info[type], names)
    end

    return entity_info
end

entities.process = function(data_raw, entity_info)
    for type, names in pairs(entity_info) do
        data_raw:remove_all(type, names)
    end

    --[[
     TODO: remove references to deleted EntityIDs:
     see https://lua-api.factorio.com/latest/types/EntityID.html
    ]]

end

return entities