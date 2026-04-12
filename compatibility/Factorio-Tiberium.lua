local recipes  = require("__Pacifist__.functions.recipes")

local _replace_missile_recipes = function() 
    recipes.replace_ingredient_with_raw(data.raw, "tiberium-catalyst-missile-all", "rocket")
    recipes.replace_ingredient_with_raw(data.raw, "tiberium-catalyst-missile-blue", "rocket")
end

return {
    exceptions = {
        ammo = {
            "tiberium-seed",
            "tiberium-seed-blue",
            "tiberium-catalyst-missile-all",
            "tiberium-catalyst-missile-blue"
        }
    },
    preprocess = {
        _replace_missile_recipes
    },
}
