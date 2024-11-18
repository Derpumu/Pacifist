require("debug")

--- @class DataRaw : data.raw
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
---@param type string
---@param name string
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
---@param type string
---@param name string
DataRaw.remove = function(self, type, name)
    -- Only remove things that are actually there.
    if self[type][name] then
        debug_log("DataRaw: removing [" .. type .. "][" .. name .. "]")
        self[type][name] = nil
    end
end


-- DataRaw.hide_all = function(self, type, name_list)
--     for _, name in pairs(name_list) do
--         self:hide(type, name)
--     end
-- end

--- remove all things of that type in the name_list
---@param self DataRaw
---@param type string
---@param name_list string[]
DataRaw.remove_all = function(self, type, name_list)
    for _, name in pairs(name_list) do
        self:remove(type, name)
    end
end

--- apply f to all things of any of the types in type_list
--- @param self DataRaw
--- @param type_list string[]
--- @param f fun(thing:(data.AnyPrototype|data.MapGenPresets))
DataRaw.apply_to_all = function(self, type_list, f)
    for _, type in pairs(type_list) do
        for _, thing in pairs(self[type] or {}) do
            f(thing)
        end
    end
end

---@param self DataRaw
---@param type string[]
---@return string[]
DataRaw.get_all_names_for = function(self, type)
    local names = {}
    for _, thing in pairs(self[type] or {}) do
        table.insert(names, thing.name)
    end
    return names
end

return DataRaw
