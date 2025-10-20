local recipes = require("__Pacifist__.functions.recipes")
local items = require("__Pacifist__.functions.items")
local technologies = require("__Pacifist__.functions.technologies")

local _remove_shield_from_spidertron = function()
    if not settings.startup["pacifist-remove-shields"].value then return end

    recipes.remove_ingredient(data.raw, "spidertron", "energy-shield-mk2-equipment")
    recipes.remove_ingredient(data.raw, "spidertron-earth-sample-turd", "energy-shield-mk2-equipment")
end

-- corpses are not reference counted (https://github.com/Derpumu/Pacifist/issues/112)
local _fix_car_corpses = function()
    local car_corpse_name = "car-biter-corpse"
    local corpse = table.deepcopy(data.raw["corpse"]["medium-biter-corpse"])
    corpse.name = car_corpse_name
    data:extend({corpse})

    data.raw.car["crawdad"].corpse = car_corpse_name
    data.raw.car["dingrido"].corpse = car_corpse_name

    local big_corpse_name = "spider-biter-corpse"
    local corpse = table.deepcopy(data.raw["corpse"]["big-biter-corpse"])
    corpse.name = big_corpse_name
    data:extend({corpse})

    data.raw["spider-vehicle"]["phadaisus"].corpse = big_corpse_name
end

local _convert_military_turd_ingredients = function()
    local laser_equipment_item = data.raw.item["personal-laser-defense-equipment"]
    laser_equipment_item.place_as_equipment_result = nil
    laser_equipment_item.localised_name = { "item-name.pacifist-py-genlab-laser" }
    laser_equipment_item.subgroup = "py-alienlife-genetics"
    laser_equipment_item.order = "zz"
    technologies.move_unlock(data.raw, "personal-laser-defense-equipment", "personal-laser-defense-equipment",
        "genlab-upgrade")

    local laser_euipment_recipe = data.raw.recipe["personal-laser-defense-equipment"]
    laser_euipment_recipe.localised_name = { "item-name.pacifist-py-genlab-laser" }

    local laser_turret_item = data.raw.item["laser-turret"]
    laser_turret_item.localised_name = { "item-name.pacifist-py-biotech-laser" }
    laser_turret_item.place_result = nil
    laser_turret_item.subgroup = "py-alienlife-items"
    laser_turret_item.order = "aza"

    local laser_turret_recipe = data.raw.recipe["laser-turret"]
    laser_turret_recipe.localised_name = { "item-name.pacifist-py-biotech-laser" }

    local laser_turret_tech = data.raw.technology["laser-turret"]
    laser_turret_tech.localised_name = { "item-name.pacifist-py-biotech-laser" }
    laser_turret_tech.localised_description = { "", "" }

    local item = items.change_type(data.raw, "poison-capsule", "item")
    item.subgroup = "py-alienlife-items"
    item.order = "azb"
    technologies.move_unlock(data.raw, "poison-capsule", "military-3", "bioreactor-upgrade")
end

local _remove_gun_turret_from_zungror_lair = function()
    recipes.remove_ingredient(data.raw, "zungror-lair-mk01", "gun-turret")
end

local config = {
    exceptions = {
        entity = {
            "chorkok", "gobachov", "huzu",
            "caravan", "flyavan", "fluidavan", "caravan-turd", "flyavan-turd", "fluidavan-turd",
            "digosaurus", "thikat", "work-o-dile", "digosaurus-turd", "thikat-turd", "work-o-dile-turd",
            "ocula",
            "aerial-blimp-mk01", "aerial-blimp-mk02", "aerial-blimp-mk03", "aerial-blimp-mk04",
        },
        technology = {
            "arthurian-upgrade",
            "compost-upgrade",
            "domestication-mk04",
            "genlab-upgrade",
            "ralesia-upgrade",
        },
    },
    extra = {
        technology = {
            "personal-laser-defense-equipment"
        },
    },
    preprocess = {
        _remove_shield_from_spidertron,
        _fix_car_corpses,
        _convert_military_turd_ingredients,
        _remove_gun_turret_from_zungror_lair,
    },
}

return config
