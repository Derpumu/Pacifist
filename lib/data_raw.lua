require("debug")

local DataRaw = {}

function DataRaw:new(o)
  assert(o)
  setmetatable(o, self)
  self.__index = self
  return o
end

DataRaw.hide = function(self, type, name)
    local entry = self[type][name]
    if not entry then
        return false
    end
    entry.flags = entry.flags or {}
    table.insert(entry.flags, "hidden")
    return true
end

DataRaw.remove = function(self, type, name)
    if name then
        -- Only remove things that are actually there.
        if self[type][name] then
            debug_log("DataRaw: removing ["..type.."]["..name.."]")
            self[type][name] = nil
        end
    else
        debug_log("DataRaw: removing ["..type.."]")
        self[type] = {}
    end
end

DataRaw.hide_all = function(self, type, name_list)
    for _, name in pairs(name_list) do
        self:hide(type, name)
    end
end


DataRaw.remove_all = function(self, type, name_list)
    for _, name in pairs(name_list) do
        self:remove(type, name)
    end
end

DataRaw.get_all_names_for = function(self, type_list)
    local names = {}
    for _, type in pairs(type_list) do
        for _, entity in pairs(self[type]) do
            table.insert(names, entity.name)
        end
    end
    return names
end

return DataRaw
