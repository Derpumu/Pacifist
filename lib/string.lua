local lib_str = {}

lib_str.starts_with = function(str, prefix)
    return str:sub(1,prefix:len()) == prefix
end

return lib_str