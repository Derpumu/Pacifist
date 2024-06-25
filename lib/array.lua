-- Array helpers
local array = {}

array.contains = function(arr, element)
    assert(element, "element is nil")
    if not arr then
        return false
    end

    for _, e in pairs(arr) do
        if e == element then
            return true
        end
    end
    return false
end

array.remove_in_place = function(arr, remove_condition)
    if not arr then
        return
    end

    local original_size = #arr
    local next_index = 1

    for _, element in ipairs(arr) do
        if not remove_condition(element) then
            arr[next_index] = element
            next_index = next_index + 1
        end
    end

    for i = next_index, original_size do
        arr[i] = nil
    end
end

array.all_of = function(arr, pred)
    for _, element in pairs(arr) do
        if not pred(element) then
            return false
        end
    end
    return true
end

array.any_of = function(arr, pred)
    for _, element in pairs(arr) do
        if pred(element) then
            return true
        end
    end
    return false
end

array.is_empty = function(arr)
    return next(arr) == nil
end

array.append = function(arr1, arr2)
    for i = 1, #arr2 do
        arr1[#arr1 + 1] = arr2[i]
    end
end

array.append_unique = function(arr1, arr2)
    for i = 1, #arr2 do
        if not array.contains(arr1, arr2[i]) then arr1[#arr1 + 1] = arr2[i] end
    end
end

array.remove = function(arr, value)
    local function is_value(element)
        return value == element
    end

    array.remove_in_place(arr, is_value)
end

array.remove_all_values = function(arr, values)
    local function is_in_values(element)
        return array.contains(values, element)
    end

    array.remove_in_place(arr, is_in_values)
end

array.to_string = function(arr, sep)
    sep = sep or " "
    if array.is_empty(arr) then
        return "{}"
    end
    return "{" .. sep .. table.concat(arr, "," .. sep) .. sep .. "}"
end

return array