local array = require("__Pacifist__.lib.array") --[[@as Array]]
local settings = require("settings")
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
---@class RefCounts: {[data.EntityID]:integer}

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

---counts references to names in other entities, e.g. corpses
---@param data_raw DataRaw
---@param ref_counts RefCounts
---@param keys string[]
local _ref_count = function(data_raw, ref_counts, keys)
    assert(#keys > 0, "ref_count: no keys given")

    for _, type in pairs(types.entities) do
        for _, entity in pairs(data_raw[type] or {}) do
            for _, key in pairs(keys) do
                local ref_id = entity[key]
                if ref_id then
                    ref_counts[ref_id] = (ref_counts[ref_id] or 0) + 1
                end
            end
        end
    end
end

--- add projectiles to the entity_info that create other flagged entities
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

--- add corpses to the entity_info that are result of flagged entities dying and have no references left
---@param data_raw DataRaw
---@param entity_info EntityInfo
---@param ref_keys string[]
---@param ref_counts RefCounts
local _flag_orphaned_references = function(data_raw, entity_info, ref_keys, ref_counts)
    if not settings.remove_corpses then return end

    -- Go through all entities in entity_info, they all will be removed
    for type, names in pairs(entity_info) do
        for _, name in pairs(names) do
            -- reduce reference counter for anything the removed entities refer to
            for _, key in pairs(ref_keys) do
                local ref_id = data_raw[type][name][key]
                if ref_id then
                    ref_counts[ref_id] = ref_counts[ref_id] - 1
                end
            end
        end
    end

    -- where no references are left, remove the refernced entity
    for name, count in pairs(ref_counts) do
        if count <= 0 then
            if count < 0 then
                debug_log("!!! REF COUNT < 0: " .. name .. ": " .. tostring(count))
            end
            _tag_entity(entity_info, name, _find_type(data_raw, name))
        end
    end
end

---@param data_raw DataRaw
---@param config Config
---@return EntityInfo
entities.collect_info = function(data_raw, config)
    local ref_keys = {"corpse", "folded_state_corpse"}

    ---@type RefCounts
    local ref_counts = {}
    _ref_count(data_raw, ref_counts, ref_keys)

    ---@type EntityInfo
    local entity_info = {}
    for _, type in pairs(config.types.military_entities) do
        entity_info[type] = data_raw:get_all_names_for(type)
        if config.exceptions.entity then
            array.remove_all_values(entity_info[type], config.exceptions.entity)
        end
    end

    --[[
     TODO:
     - add types of non-placeable entities, e.g. artillery-flare
     see https://lua-api.factorio.com/latest/prototypes/EntityPrototype.html
    ]]


    for _, name in pairs(config.extra.entity) do
        local type = _find_type(data_raw, name);
        _tag_entity(entity_info, name, type)
    end

    _flag_projectiles_creating_entities(data_raw, entity_info)
    _flag_orphaned_references(data_raw, entity_info, ref_keys, ref_counts)

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