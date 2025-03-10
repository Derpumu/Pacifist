require("debug")

---@class Type : string
---@class Name : string


---@alias DataRaw.ElementProcessor fun(thing:(data.AnyPrototype|data.MapGenPresets))

---@class (exact) DataRaw : data.raw
---@field __index DataRaw
---@field hide function
---@field remove fun(self:DataRaw, type:Type, name:Name, log:string)
---@field remove_all fun(self:DataRaw, type:Type, name_list:Name[], log:string)
---@field apply_to_all fun(self:DataRaw, type_list:Type[], f:DataRaw.ElementProcessor)
---@field get_all_names_for fun(seld:DataRaw, type:Type): Name[]
local DataRaw = {}

--- constructor
---@param o data.raw
---@return DataRaw
function DataRaw:new(o)
    assert(o)
    setmetatable(o, self)
    self.__index = self
    return o --[[@as DataRaw]]
end

--- tag things as hidden
--- @deprecated
---@param self DataRaw
---@param type Type
---@param name Name
---@return boolean
DataRaw.hide = function(self, type, name)
    local entry = self[type][name]
    if not entry then
        return false
    end
    entry.hidden = true
    return true
end

--- remove things
---@param self DataRaw
---@param type Type
---@param name Name
---@param log string the details to add to the log message
DataRaw.remove = function(self, type, name, log)
    -- Only remove things that are actually there.
    if self[type][name] then
        debug_log("DataRaw: removing [" .. type .. "][" .. name .. "]: " .. log)
        self[type][name] = nil
    end
end


--- remove all things of that type in the name_list
---@param self DataRaw
---@param type Type
---@param name_list Name[]
---@param log string the details to add to the log message
DataRaw.remove_all = function(self, type, name_list, log)
    for _, name in pairs(name_list) do
        self:remove(type, name, log)
    end
end

--- apply f to all things of any of the types in type_list
--- @param self DataRaw
--- @param type_list Type[]
--- @param f DataRaw.ElementProcessor
DataRaw.apply_to_all = function(self, type_list, f)
    for _, type in pairs(type_list) do
        for _, thing in pairs(self[type] or {}) do
            f(thing)
        end
    end
end

---@param self DataRaw
---@param type Type
---@return Name[]
DataRaw.get_all_names_for = function(self, type)
    ---@type Name[]
    local names = {}
    for _, thing in pairs(self[type] or {}) do
        table.insert(names, thing.name)
    end
    return names
end

return DataRaw
