local array = require("__Pacifist__.lib.array") --[[@as Array]]
local types = require("types")
local entities = {}


---@param data_raw DataRaw
---@param entity_id data.EntityID
---@return Type
local _find_type = function(data_raw, entity_id)
    for _, type in types.entities do
        if data_raw[type] and data_raw[type][entity_id] then return type end
    end
    assert(false, "Entity not found: " .. entity_id)
    return ""
end

---@class EntityInfo: {[Type]:data.EntityID[]}

---@param data_raw DataRaw
---@param config Config
---@return EntityInfo
entities.collect_info = function(data_raw, config)
    ---@type EntityInfo
    local entity_info = {}
    for _, type in pairs(config.types.military_entities) do
        entity_info[type] = data_raw:get_all_names_for(type)
    end

    --[[
     TODO:
     - add types of non-placeable entities, e.g. artillery-flare
     see https://lua-api.factorio.com/latest/prototypes/EntityPrototype.html
    ]]

    if config.exceptions.entity then 
        array.remove_all_values(entity_info[type], config.exceptions.entity)
    end

    for _, name in pairs(config.extra.entity) do
        local type = _find_type(data_raw, name);
        entity_info[type] = entity_info[type] or {}
        array.append(entity_info[type], {name})
    end

    return entity_info
end

---@param data_raw DataRaw
---@param entity_info EntityInfo
entities.process = function(data_raw, entity_info)
    for type, names in pairs(entity_info) do
        data_raw:remove_all(type, names, "remove entity")
    end

    --[[
     TODO: remove references to deleted EntityIDs:
     see https://lua-api.factorio.com/latest/types/EntityID.html
    ]]
end

return entities