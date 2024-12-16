local array = require("__Pacifist__.lib.array") --[[@as Array]]
local types = require("types")
local entities = {}


---@param data_raw DataRaw
---@param entity_id data.EntityID
---@return Type
local _find_type = function(data_raw, entity_id)
    for _, type in pairs(types.entities) do
        if data_raw[type] and data_raw[type][entity_id] then return type end
    end
    assert(false, "Entity not found: " .. entity_id)
    return ""
end


---@generic T
---@param t T[]|T?
---@return T[]
local _to_array = function(t)
    if not t then return {} end
    if t[1] then return t end
    return {t}
end

---@class EntityInfo: {[Type]:data.EntityID[]}

---tags an entity for removal
---@param entity_info EntityInfo
---@param name Name
---@param type Type
local _tag_entity = function(entity_info, name, type)
    entity_info[type] = entity_info[type] or {}
    array.append(entity_info[type], {name})
end

---checks whether an entity is tagged for removal
---@param entity_info EntityInfo
---@param name Name
---@param type Type
local _is_tagged = function(entity_info, name, type)
    return entity_info[type] and array.contains(entity_info[type], name)
end

---comment
---@param data_raw DataRaw
---@param entity_info EntityInfo
local _flag_projectiles_creating_entities = function(data_raw, entity_info)
    for _, projectile in pairs(data_raw["projectile"]) do
        if projectile.action then
            ---@type data.TriggerDelivery[]
            local action_deliveries = _to_array(projectile.action.action_delivery)
            ---@type data.TriggerEffect[]
            local trigger_effects = {}
            for _, delivery in pairs(action_deliveries) do
                array.append(trigger_effects, _to_array(delivery.source_effects))
                array.append(trigger_effects, _to_array(delivery.target_effects))
            end

            for _, effect in pairs(trigger_effects) do
                if effect.type == "create-entity" then
                    local name = effect.entity_name
                    local type = _find_type(data_raw, name)
                    if _is_tagged(entity_info, name, type) then
                        _tag_entity(entity_info, projectile.name, "projectile")
                    end
                end
            end
        end
    end
end



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
        _tag_entity(entity_info, name, type)
    end

    _flag_projectiles_creating_entities(data_raw, entity_info)

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