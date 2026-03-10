local technologies = require("__Pacifist__.functions.technologies")

local _remove_achievements = function()
    data.raw["use-item-achievement"]["pm-use-more-gun"] = nil
end

local _move_cyano_recipe = function()
    technologies.move_unlock(data.raw, "pm-cyanobacteriaed-agar-solution", "pm-chemical-weaponry",
        "pm-agar-bacteria-filtering")
end

return {
    preprocess = { _remove_achievements, _move_cyano_recipe },
    extra = {
        fluid = { "pm-phosgene", "pm-melatonin" }
    }
}
