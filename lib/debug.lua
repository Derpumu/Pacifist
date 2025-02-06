local array = require("array")

local dev_mod = "pumu-dev"
---@type boolean
local debug = ((mods and mods[dev_mod])
        or (script and script.active_mods and script.active_mods[dev_mod])) and true or false

---@param message string        
function debug_log(message)
    if debug then
        log(message)
    end
end

---@param n integer
local _padding = function(n)
  local p = ""
  for i=1,n do
    p=p.." "
  end
  return p
end

---@param table table
---@param fields string[]?
---@param indent integer?
local function _to_string(table, fields, indent)
    indent = indent or 0
    local pad = _padding(indent)
    local str = "{"
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

---@param table table
---@param label string?
---@param fields string[]?
function dump_table(table, label, fields)
    if not debug then return end

    log("\n" .. (label or "T") .. ": " .. _to_string(table, fields))
end

