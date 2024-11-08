local array = require("array")

local dev_mod = "pumu-dev"
local debug = (mods and mods[dev_mod])
        or (script and script.active_mods and script.active_mods[dev_mod])

function debug_log(message)
    if debug then
        log(message)
    end
end

local _padding = function(n)
  local p = ""
  for i=1,n do
    p=p.." "
  end
  return p
end

function _to_string(table, fields, indent)
    indent = indent or 0
    local pad = _padding(indent)
    str = "{"
    for k, v in pairs(table or {}) do
        if not fields or array.contains(fields, k) then
            str = str .. "\n  " .. pad .. tostring(k) .. ": "
            if type(v) == "table" then
                str = str .. _to_string(v, fields, indent+2)
            else
                str = str .. tostring(v)
            end
        end
    end
    str = str .. "\n" .. pad .. "}"
    return str
end


function dump_table(table, label, fields)
    if not debug then return end

    log("\n" .. (label or "T") .. ": " .. _to_string(table, fields))
end

