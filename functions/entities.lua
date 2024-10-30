local array = require("__Pacifist__.lib.array")

local entities = {}

entities.collect_info = function(data_raw, config)
    local entity_info = {
        types = config.types.military_entities,
        names = data_raw:get_all_names_for(config.types.military_entities)
    }
    array.remove_all_values(entity_info.names, config.exceptions.entity)
    array.append(entity_info.names, config.extra.entity)
    array.append(entity_info.types, config.extra.entity_types)
    return entity_info
end

entities.process = function(data_raw, entity_info)
    for _, type in pairs(entity_info.types) do
        data_raw:remove_all(type, entity_info.names)
    end
end

return entities