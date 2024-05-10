local data_raw = {}
data_raw.removed = {}

data_raw.hide = function(type, name)
    local entry = data.raw[type][name]
    if not entry then
        return false
    end
    entry.flags = entry.flags or {}
    table.insert(entry.flags, "hidden")
    return true
end

data_raw.mark_removed = function(type, name)
    if name then
        -- Record what was removed so remove_orphaned_entities()
        -- can check if the things it referenced can be removed.
        data_raw.removed[type] = data_raw.removed[type] or {}
        data_raw.removed[type][name] = true
    end
end

data_raw.hide_and_mark_removed = function(type, name)
    if (data_raw.hide(type, name)) then
        data_raw.mark_removed(type, name)
    end
end

data_raw.remove = function(type, name)
    if name then
        -- Only remove things that are actually there.
        if data.raw[type][name] then
            data.raw[type][name] = nil
            data_raw.mark_removed(type, name)
        end
    else
        data.raw[type] = {}
    end
end

data_raw.hide_all = function(type, name_list)
    for _, name in pairs(name_list) do
        data_raw.hide(type, name)
    end
end

data_raw.hide_and_mark_removed_all = function(type, name_list)
    for _, name in pairs(name_list) do
        data_raw.hide_and_mark_removed(type, name)
    end
end

data_raw.remove_all = function(type, name_list)
    for _, name in pairs(name_list) do
        data_raw.remove(type, name)
    end
end

data_raw.get_all_names_for = function(type_list)
    local names = {}
    for _, type in pairs(type_list) do
        for _, entity in pairs(data.raw[type]) do
            table.insert(names, entity.name)
        end
    end
    return names
end

return data_raw
