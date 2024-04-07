local lib_str = {}

lib_str.starts_with = function(str, prefix)
    return str:sub(1,prefix:len()) == prefix
end

lib_str.ends_with = function(str, suffix)
    return str:sub(-#suffix) == suffix
end

return lib_str