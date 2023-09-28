-- Array helpers
local array = {}

array.contains = function(arr, element)
    if not arr then
        return false
    end

    for _, e in ipairs(arr) do
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

array.is_empty = function(arr)
    return next(arr) == nil
end

array.bind_contains = function(arr)
    local function contains_condition(element)
        return array.contains(arr, element)
    end
    return contains_condition
end

return array