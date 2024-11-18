-- Array helpers
local array = {}

---@param arr any[]?
---@param element any
---@return boolean
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

--- remove elements from arr that fulfil the condition
---@param arr any[]?
---@param remove_condition fun(e:any):boolean
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

---check that all elements fulfil the predicate
---@param arr any[]
---@param pred fun(e:any):boolean
---@return boolean
array.all_of = function(arr, pred)
    for _, element in pairs(arr) do
        if not pred(element) then
            return false
        end
    end
    return true
end

---check whether any element fulfils the predicate
---@param arr any[]
---@param pred fun(e:any):boolean
---@return boolean
array.any_of = function(arr, pred)
    for _, element in pairs(arr) do
        if pred(element) then
            return true
        end
    end
    return false
end

---@param arr any[]
---@return boolean
array.is_empty = function(arr)
    return next(arr) == nil
end

---concatenates two arrays
---@param arr1 any[]
---@param arr2 any[]
array.append = function(arr1, arr2)
    for i = 1, #arr2 do
        arr1[#arr1 + 1] = arr2[i]
    end
end

---concatenates two arrays, without duplicates
---@param arr1 any[]
---@param arr2 any[]
array.append_unique = function(arr1, arr2)
    for i = 1, #arr2 do
        if not array.contains(arr1, arr2[i]) then arr1[#arr1 + 1] = arr2[i] end
    end
end

---removes all instances of value from arr
---@param arr any[]
---@param value any
array.remove = function(arr, value)
    local function is_value(element)
        return value == element
    end

    array.remove_in_place(arr, is_value)
end

---removes all instances of any of the values from arr
---@param arr any[]
---@param values any[]
array.remove_all_values = function(arr, values)
    local function is_in_values(element)
        return array.contains(values, element)
    end

    array.remove_in_place(arr, is_in_values)
end

---convert to a string
---@param arr any[]
---@param sep string?
---@return string
array.to_string = function(arr, sep)
    sep = sep or " "
    if array.is_empty(arr) then
        return "{}"
    end
    return "{" .. sep .. table.concat(arr, "," .. sep) .. sep .. "}"
end

return array