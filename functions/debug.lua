local array = require("__Pacifist__.lib.array")

local dev_mod = "pumu-dev"
local debug = (mods and mods[dev_mod])
        or (script and script.active_mods and script.active_mods[dev_mod])

function debug_log(message)
    if debug then
        log(message)
    end
end

function dump_table(table, fields)
    str = "{"
    for k, v in pairs(table or {}) do
        if not fields or array.contains(fields, k) then
            str = str .. "\n" .. tostring(k) .. ": "
            if type(v) == "table" then
                str = str .. dump_table(v, fields)
            else
                str = str .. tostring(v)
            end
        end
    end
    str = str .. "\n}"
    return str
end

