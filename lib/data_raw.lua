require("debug")

---@class Type : string
---@class Name : string

--- @class (exact) DataRaw : data.raw
--- @field __index DataRaw
--- @field hide function
--- @field remove function
--- @field remove_all function
--- @field apply_to_all function
--- @field get_all_names_for function
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
DataRaw.remove = function(self, type, name)
    -- Only remove things that are actually there.
    if self[type][name] then
        debug_log("DataRaw: removing [" .. type .. "][" .. name .. "]")
        self[type][name] = nil
    end
end


--- remove all things of that type in the name_list
---@param self DataRaw
---@param type Type
---@param name_list Name[]
DataRaw.remove_all = function(self, type, name_list)
    for _, name in pairs(name_list) do
        self:remove(type, name)
    end
end

--- apply f to all things of any of the types in type_list
--- @param self DataRaw
--- @param type_list Type[]
--- @param f fun(thing:(data.AnyPrototype|data.MapGenPresets))
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
