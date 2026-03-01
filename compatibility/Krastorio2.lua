local settings = require("__Pacifist__.functions.settings")
local recipes  = require("__Pacifist__.functions.recipes")
local array    = require("__Pacifist__.lib.array")


local _fix_heavy_armor_dependency = function()
    -- Krastorio changes the recipe of modular armor to include
    -- a heavy armor which we might remove.
    if not settings.remove_armor then return end

    recipes.replace_ingredient_with_raw(data.raw, "modular-armor", "heavy-armor")
    -- the raw ingredients of heavy-armor contain light-armor...
    recipes.replace_ingredient_with_raw(data.raw, "modular-armor", "light-armor")
end

local _remove_fish_launch_product = function()
    -- Krastorio sets the launch product to a gun we will remove.
    data.raw.capsule["raw-fish"].rocket_launch_products = nil
end

return {
    extra = {
        get_derived_recipes = function(original_name)
            return "kr-crush-" .. original_name
        end
    },
    preprocess = {
        _remove_fish_launch_product,
        _fix_heavy_armor_dependency
    }
}
