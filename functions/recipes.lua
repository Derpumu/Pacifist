local array = require("__Pacifist__.lib.array")
local debug = require("__Pacifist__.lib.debug")
local util = require("util")
local recipes = {}

local _produces_any_of = function (recipe, item_names)
    if recipe.name == "stone-wall" then
        dump_table(recipe)
        dump_table(item_names)
    end
    for _, product in pairs(recipe.results or {}) do
        if array.contains(item_names, product.name) then
            debug_log(recipe.name .. " produces " .. product.name)
            return true
        end
    end
    return false
end

--[[
returns table recipe_info: namelist of obsolete recipes
--]]
recipes.collect_info = function(data_raw, config, item_info)
    local recipe_info = {}

    dump_table(item_info)
    local item_names = util.all_names(item_info)
    dump_table(item_names)
    for name, recipe in pairs(data_raw.recipe) do
        if _produces_any_of(recipe, item_names) then
            debug_log("recipe_info: inserting " .. name)
            table.insert(recipe_info, name)
        end
    end
    dump_table(recipe_info, "return recipe_info")
    return recipe_info
end

recipes.process = function(data_raw, recipe_info)
    dump_table(recipe_info, "process recipe_info")
    data_raw:remove_all("recipe", recipe_info)
end

return recipes