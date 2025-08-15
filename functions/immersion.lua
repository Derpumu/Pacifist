require("__Pacifist__.lib.debug")
local settings = require("settings")
local types = require("types")
local array = require("__Pacifist__.lib.array") --[[@as Array]]

---@param data_raw DataRaw
local _relabel_item_groups = function(data_raw)
    if data_raw["item-group"].combat then
        data_raw["item-group"].combat.icon = "__Pacifist__/graphics/item-group/equipment.png"
    end
    if data_raw["item-group"].enemies then
        data_raw["item-group"].enemies.icon = "__Pacifist__/graphics/item-group/units.png"
    end
end

---@param data_raw DataRaw
---@param config Config
local _relabel_gun_slots = function(data_raw, config)
    local x_icon = "__core__/graphics/set-bar-slot.png"
    local tool_icon = "__core__/graphics/icons/mip/empty-robot-material-slot.png"
    local icon_types = { "gun", "ammo" }
    for _, type in pairs(icon_types) do
        local icon = array.is_empty(config.exceptions[type]) and x_icon or tool_icon
        data_raw["utility-sprites"].default["empty_" .. type .. "_slot"].filename = icon
    end
end

---@param data_raw DataRaw
---@param type Type
---@param name Name
---@return data.PrototypeBase?
local _get_prototype = function(data_raw, type, name)
    return data_raw[type] and data_raw[type][name] --[[@as data.PrototypeBase?]]
end

---@param data_raw DataRaw
---@param typelist Type[]?
---@param name Name
---@return data.PrototypeBase?
local _find_prototype_in_typelist = function(data_raw, typelist, name)
    for _, type in pairs(typelist or {}) do
        local prototype = _get_prototype(data_raw, type, name)
        if prototype then return prototype end
    end
end

---@param data_raw DataRaw
---@param type Type
---@param name Name
---@return data.PrototypeBase?
local _find_prototype = function(data_raw, type, name)
    local prototype = _get_prototype(data_raw, type, name)
    -- if type is a generic/base type (e.g. entity), we may find it by trying all specific/derived types
    if not prototype then
        prototype = _find_prototype_in_typelist(data_raw, types[type], name)
    end

    if not prototype then
        debug_log("Protoype not found: " .. type .. ":" .. name)
    end
    return prototype
end

---@param what string
---@return fun(data_raw: DataRaw, listed_type: Type, name: Name)
local _localise = function(what)
    return function(data_raw, listed_type, name)
        local type = string.gsub(listed_type, "_", "-")
        local prototype = _find_prototype(data_raw, type, name)
        if not prototype then return end

        -- e.g. pacifist-item-name.firearm-magazine
        local immersed_version = "pacifist-" .. type .. "-" .. what .. "." .. name
        prototype["localised_" .. what] = { immersed_version }
    end
end

local section_processors = {
    name = _localise("name"),
    description = _localise("description")
}

---@class Immersion
return {
    ---@param data_raw DataRaw
    ---@param config Config
    process = function(data_raw, config)

        _relabel_gun_slots(data_raw, config)
        _relabel_item_groups(data_raw)

        if settings.immersion_off then return end

        for section_name, processor in pairs(section_processors) do
            for type, names in pairs(config.immersion[section_name]) do
                for _, name in pairs(names) do
                    processor(data_raw, type, name)
                end
            end
        end
    end
}
