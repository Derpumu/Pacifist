local array = require("__Pacifist__.lib.array") --[[@as Array]]

---@class Names
local names = {}

---returns the concatenated name lists of the input table
---@param table table<string, string[]>
---@return string[]
names.all_names = function(table)
    local all_names = {}
    for _, namelist in pairs(table) do
        array.append(all_names, namelist)
    end
    return all_names
end

return names