local entities = {}

entities.collect_info = function(data_raw, config)
    return {
        data_raw = data_raw
    }
end

entities.process = function(entity_info)
    local data_raw = entity_info.data_raw
end

return entities