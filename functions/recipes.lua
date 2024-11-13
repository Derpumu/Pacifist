local array = require("__Pacifist__.lib.array")
local names = require("names")

require("__Pacifist__.lib.debug")

local recipes = {}

local _produces_any_of = function (recipe, item_names)
    if recipe.name == "stone-wall" then
        dump_table(recipe)
        dump_table(item_names)
    end
    for _, product in pairs(recipe.results or {}) do
        if array.contains(item_names, product.name) then
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
    local item_names = names.all_names(item_info)
    dump_table(item_names)
    for name, recipe in pairs(data_raw.recipe) do
        if _produces_any_of(recipe, item_names) then
            table.insert(recipe_info, name)
        end
    end
    dump_table(recipe_info, "return recipe_info")
    return recipe_info
end

recipes.process = function(data_raw, recipe_info)
    dump_table(recipe_info, "process recipe_info")
    data_raw:remove_all("recipe", recipe_info)
    --[[
     TODO: remove references to deleted EntityIDs:
     see https://lua-api.factorio.com/latest/types/EntityID.html
    ]]

end

return recipes