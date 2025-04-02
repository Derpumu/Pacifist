-- Array helpers
---@class Array
local array = {}

---@generic T
---@param arr T[]?
---@param element T
---@return boolean
array.contains = function(arr, element)
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
---@generic T
---@param arr T[]?
---@param remove_condition fun(e:T):boolean
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
---@generic T
---@param arr T[]
---@param pred fun(e:T):boolean
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
---@generic T
---@param arr T[]
---@param pred fun(e:T):boolean
---@return boolean
array.any_of = function(arr, pred)
    for _, element in pairs(arr) do
        if pred(element) then
            return true
        end
    end
    return false
end

---@generic T
---@param arr T[]
---@return boolean
array.is_empty = function(arr)
    return next(arr) == nil
end

---concatenates two arrays
---@generic T
---@param arr1 T[]
---@param arr2 T[]
array.append = function(arr1, arr2)
    for i = 1, #arr2 do
        arr1[#arr1 + 1] = arr2[i]
    end
end

---concatenates two arrays, without duplicates
---@generic T
---@param arr1 T[]
---@param arr2 T[]
array.append_unique = function(arr1, arr2)
    for i = 1, #arr2 do
        if not array.contains(arr1, arr2[i]) then arr1[#arr1 + 1] = arr2[i] end
    end
end

---removes all instances of value from arr
---@generic T
---@param arr T[]
---@param value T
array.remove = function(arr, value)
    local function is_value(element)
        return value == element
    end

    array.remove_in_place(arr, is_value)
end

---removes all instances of any of the values from arr
---@generic T
---@param arr T[]
---@param values T[]?
array.remove_all_values = function(arr, values)
    if not values then return end

    local function is_in_values(element)
        return array.contains(values, element)
    end

    array.remove_in_place(arr, is_in_values)
end

---convert to a string
---@generic T
---@param arr T[]
---@param sep string?
---@return string
array.to_string = function(arr, sep)
    sep = sep or " "
    if array.is_empty(arr) then
        return "{}"
    end
    return "{" .. sep .. table.concat(arr, "," .. sep) .. sep .. "}"
end

--- returns the list of all elements that fulfil the predicate
---@generic T
---@param arr T[]
---@param pred fun(e:T):boolean
---@return T[]
array.select = function(arr, pred)
    local result = {}
    for _, element in ipairs(arr) do
        if pred(element) then
            result[#result + 1] = element
        end
    end
    return result
end


return array