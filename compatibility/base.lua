local array = require("__Pacifist__.lib.array") --[[@as Array]]

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
    local grenade = data.raw["capsule"]["grenade"]
    if not grenade then return end
    data.raw["capsule"]["grenade"] = nil

    local cliff_explosives = data.raw["capsule"]["cliff-explosives"]

    grenade.type = "item"
    grenade.subgroup = cliff_explosives.subgroup
    grenade.localised_name = {"item-name.pacifist-grenade"}
    grenade.order = (cliff_explosives.order or "").."z"

    data:extend{grenade}

    ---@type data.UnlockRecipeModifier?
    local recipe_effect = nil
    for _, technology in pairs(data.raw["technology"]) do
        if technology.effects then
            for _, effect in pairs(technology.effects) do
                if effect.type == "unlock-recipe" and effect.recipe == "grenade" then
                    recipe_effect = effect
                end
            end
            array.remove_in_place(technology.effects, function(effect) return effect.type =="unlock-recipe" and effect.recipe == "grenade" end)
        end
    end

    ---@type data.TechnologyPrototype?
    local cliff_tech = data.raw["technology"]["cliff-explosives"]
    if recipe_effect and cliff_tech then
        cliff_tech.effects = cliff_tech.effects or {}
        table.insert(cliff_tech.effects, recipe_effect)
    end
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
    preprocess = { _remove_achievements, _pacify_grenade }
}

if settings.startup["pacifist-remove-walls"].value then
    table.insert(base_config.extra.tips_and_tricks_items, "construction-robots") -- simulation uses walls
    table.insert(base_config.extra.tips_and_tricks_items, "gate-over-rail")
    table.insert(base_config.extra.tips_and_tricks_items, "storage-chest") -- simulation uses walls
end

return base_config