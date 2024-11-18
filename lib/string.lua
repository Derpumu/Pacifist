local lib_str = {}

---@param str string
---@param prefix string
---@return boolean
lib_str.starts_with = function(str, prefix)
    return str:sub(1,prefix:len()) == prefix
end

---@param str string
---@param suffix string
---@return boolean
lib_str.ends_with = function(str, suffix)
    return str:sub(-#suffix) == suffix
end

return lib_str