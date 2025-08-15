require("__Pacifist__.lib.debug")
local settings = require("settings")

---@param data_raw DataRaw
---@param type Type
---@param name Name
---@return data.PrototypeBase?
local _find_prototype = function(data_raw, type, name)
    if settings.immersion_off then return end

    local prototype = data_raw[type] and data_raw[type][name] --[[@as data.PrototypeBase]]
    if not prototype then
        debug_log("Protoype not found: " .. type .. ":" .. name)
    end
    return prototype
end

---@param data_raw DataRaw
---@param type Type
---@param name Name
local _rename = function(data_raw, type, name)
    local prototype = _find_prototype(data_raw, type, name)
    if not prototype then return end

    local immersed_name = "pacifist-" .. type .. "-name." .. name
    prototype.localised_name = { immersed_name }
end


---@class Immersion
return {
    ---@param data_raw DataRaw
    ---@param config Config
    process = function(data_raw, config)
        if settings.immersion_off then return end

        for type, names in pairs(config.immersion.rename) do
            for _, name in names do 
                _rename(data_raw, type, name)
            end
        end
    end
}
