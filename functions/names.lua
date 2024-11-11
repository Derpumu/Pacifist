local array = require("__Pacifist__.lib.array")
local names = {}

names.all_names = function(table)
    local all_names = {}
    for type, names in pairs(table) do
        array.append(all_names, names)
    end
    return all_names
end

return names