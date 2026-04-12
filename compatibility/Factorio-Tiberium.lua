local recipes = require("__Pacifist__.functions.recipes")
local technologies = require("__Pacifist__.functions.technologies")


local _replace_missile_recipes = function()
    recipes.replace_ingredient_with_raw(data.raw, "tiberium-catalyst-missile-all", "rocket")
    recipes.replace_ingredient_with_raw(data.raw, "tiberium-catalyst-missile-blue", "rocket")
end


local _move_recipe_unlocks = function()
    assert(not mods["space-age"], "Pacifist currently does not support Space Age and Tiberian Dawn at the same time!")
    -- we keep the rocket launcher for the seed and catalyst rockets
    -- move its recipe unlock to the corresponding technologies
    technologies.move_unlock_multiple(data.raw, "rocket-launcher", "rocketry",
        { "tiberium-nuke", "tiberium-ore-destruction" })
end


local _rename_military_3 = function()
    -- Due to the locale mechanics in Factorio, we have to rename Tiberium Military 3 to something else in order to
    -- change its technology-name key
    technologies.rename(data.raw, "tiberium-military-3", "tiberium-marv-tech")

    -- the ion core is only used in the marv, so move its unlock to the marv tech
    technologies.move_unlock(data.raw, "tiberium-ion-core", "tiberium-military-2", "tiberium-marv-tech")
end


return {
    exceptions = {
        ammo = {
            "tiberium-seed",
            "tiberium-seed-blue",
            "tiberium-catalyst-missile-all",
            "tiberium-catalyst-missile-blue"
        },
        gun = { "rocket-launcher" },
    },
    preprocess = {
        _replace_missile_recipes,
        _move_recipe_unlocks,
        _rename_military_3,
    },
}
