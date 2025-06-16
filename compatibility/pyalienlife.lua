local array = require("__Pacifist__.lib.array") --[[@as Array]]
require("__Pacifist__.lib.debug")

local _remove_shield_from_spidertron = function()
    if not settings.startup["pacifist-remove-shields"].value then return end

    local is_shield = function(ingredient) return ingredient.name == "energy-shield-mk2-equipment" end
    array.remove_in_place(data.raw["recipe"]["spidertron"].ingredients, is_shield)
    if data.raw["recipe"]["spidertron-earth-sample-turd"] then
        array.remove_in_place(data.raw["recipe"]["spidertron-earth-sample-turd"].ingredients, is_shield)
    end
end

local _remove_rocket_from_nukavan = function()
    local is_rocket = function(ingredient) return ingredient.name == "explosive-rocket" end
    array.remove_in_place(data.raw["recipe"]["nukavan"].ingredients, is_rocket)
    array.remove_in_place(data.raw["recipe"]["nukavan-turd"].ingredients, is_rocket)
    if data.raw["recipe"]["nukavan-earth-sample-turd"] then
        array.remove_in_place(data.raw["recipe"]["nukavan-earth-sample-turd"].ingredients, is_rocket)
    end
end

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

local _convert_laser_turrets = function()
    local laser_turret_item = data.raw.item["laser-turret"]
    laser_turret_item.place_result = nil
end

local config = {
    exceptions = {
        entity = {
            "chorkok", "gobachov", "huzu",
            "caravan", "flyavan", "caravan-turd", "flyavan-turd",
            "digosaurus", "thikat", "work-o-dile", "digosaurus-turd", "thikat-turd", "work-o-dile-turd",
            "ocula"
        },
        technology = {
            "arthurian-upgrade",
            "compost-upgrade",
            "domestication-mk04",
        },
    },
    preprocess = { _remove_shield_from_spidertron, _fix_car_corpses, _remove_rocket_from_nukavan, _convert_laser_turrets },
}

return config
