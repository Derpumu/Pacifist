local settings = require("__Pacifist__.functions.settings")
local recipes  = require("__Pacifist__.functions.recipes")

local _replace_shield_ingredients = function()
    if not settings.remove_shields then return end

    recipes.replace_ingredient_with_raw(data.raw, "protection-field", "energy-shield-mk2-equipment")
    recipes.replace_ingredient_with_raw(data.raw, "protection-field", "energy-shield-equipment")
end

local _replace_laser_ingredients = function()
    recipes.replace_ingredient_with_raw(data.raw, "laser-cannon", "laser-turret")
    recipes.replace_ingredient_with_raw(data.raw, "space-ai-robot-frame", "personal-laser-defense-equipment")
    recipes.replace_ingredient_with_raw(data.raw, "space-ai-robot-frame", "laser-turret")
end

return {
    preprocess = {
        _replace_shield_ingredients,
        _replace_laser_ingredients,
    }
}
