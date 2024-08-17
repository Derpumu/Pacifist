local array = require("__Pacifist__.lib.array")

local bobwar_config = {
    extra = {
        entity = {
            "bob-robot-gun-drone",
            "bob-robot-laser-drone",
            "bob-robot-flamethrower-drone",
            "bob-robot-plasma-drone"
        },
        entity_types = { "unit" },
        item = {
            "petroleum-jelly",
            "gun-cotton",
            "cordite",
            "bullet-casing",
            "magazine",
            "bullet-projectile",
            "bullet",
            "ap-bullet-projectile",
            "ap-bullet",
            "he-bullet-projectile",
            "he-bullet",
            "flame-bullet-projectile",
            "flame-bullet",
            "acid-bullet-projectile",
            "acid-bullet",
            "poison-bullet-projectile",
            "poison-bullet",
            "electric-bullet-projectile",
            "electric-bullet",
            "uranium-bullet-projectile",
            "uranium-bullet",
            "shotgun-shell-casing",
            "shot",
            "laser-rifle-battery-case",
            "rocket-engine",
            "rocket-body",
            "rocket-warhead",
            "piercing-rocket-warhead",
            "electric-rocket-warhead",
            "explosive-rocket-warhead",
            "acid-rocket-warhead",
            "flame-rocket-warhead",
            "poison-rocket-warhead",
            "plasma-bullet-projectile",
            "plasma-bullet",
            "plasma-rocket-warhead",
            "spidertron-cannon",
            "robot-drone-frame",
            "robot-drone-frame-large"
        },
    }
}

if settings.startup["pacifist-remove-tank"].value then
    array.append(bobwar_config.extra.entity, {"bob-tank-2", "bob-tank-3"})
end

return bobwar_config
