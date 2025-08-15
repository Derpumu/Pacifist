local array = require("__Pacifist__.lib.array") --[[@as Array]]
require("__Pacifist__.functions.pacify_item")

local _remove_achievements = function()
    data.raw["group-attack-achievement"]["it-stinks-and-they-dont-like-it"] = nil
    data.raw["research-with-science-pack-achievement"]["research-with-military"] = nil
    data.raw["kill-achievement"]["pest-control"] = nil
    data.raw["kill-achievement"]["steamrolled"] = nil
    data.raw["kill-achievement"]["pyromaniac"] = nil
    data.raw["shoot-achievement"]["destroyer-of-worlds"] = nil
    data.raw["combat-robot-count-achievement"]["minions"] = nil
    data.raw["kill-achievement"]["art-of-siege"] = nil
    data.raw["dont-kill-manually-achievement"]["keeping-your-hands-clean"] = nil
    data.raw["dont-build-entity-achievement"]["raining-bullets"] = nil
end

local _pacify_grenade = function()
    pacify_item("grenade", "cliff-explosives")
end

local base_config = {
    extra = {
        main_menu_simulations = {
            "nauvis_mining_defense",
            "nauvis_artillery",
            "nauvis_biter_base_spidertron",
            "nauvis_biter_base_artillery",
            "nauvis_biter_base_laser_defense",
            "nauvis_biter_base_player_attack",
            "nauvis_biter_base_steamrolled",
            "nauvis_chase_player",
            "nauvis_big_defense",
            "nauvis_brutal_defeat",
        },
        tool = {
            "military-science-pack",
        },
        tips_and_tricks_items = {
            "shoot-targeting",
        },
    },
    preprocess = { _remove_achievements, _pacify_grenade },
    immersion = {
        name = {
            item_group = {
                "combat",
                "enemies"
            },
            item = {
                "grenade",
                "light-armor",
                "heavy-armor",
                "modular-armor",
                "power-armor",
                "power-armor-mk2"
            }
        }
    }
}

if settings.startup["pacifist-remove-walls"].value then
    table.insert(base_config.extra.tips_and_tricks_items, "construction-robots") -- simulation uses walls
    table.insert(base_config.extra.tips_and_tricks_items, "gate-over-rail")
    table.insert(base_config.extra.tips_and_tricks_items, "storage-chest") -- simulation uses walls
end

if settings.startup["pacifist-remove-tank"].value then
    base_config.extra.entity = base_config.extra.entity or {}
    table.insert(base_config.extra.entity, "tank")
end
return base_config
