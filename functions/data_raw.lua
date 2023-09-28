local data_raw = {}

data_raw.hide = function(type, name)
    local entry = data.raw[type][name]
    if not entry then
        return
    end
    entry.flags = entry.flags or {}
    table.insert(entry.flags, "hidden")
end

data_raw.remove = function(type, name)
    if name then
        data.raw[type][name] = nil
    else
        data.raw[type] = nil
    end
end

data_raw.hide_all = function(type, name_list)
    for _, name in pairs(name_list) do
        data_raw.hide(type, name)
    end
end

data_raw.remove_all = function(type, name_list)
    for _, name in pairs(name_list) do
        data_raw.remove(type, name)
    end
end

return data_raw
