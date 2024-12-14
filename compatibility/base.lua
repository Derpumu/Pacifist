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

    local item_properties = {
        "icons",
        "icon",
        "icon_size",
        "dark_background_icons",
        "dark_background_icon",
        "dark_background_icon_size",
        "fuel_category",
        "burnt_result",
        "spoil_result",
        "plant_result",
        "place_as_tile",
        "pictures",
        "flags",
        "spoil_ticks",
        "fuel_value",
        "fuel_acceleration_multiplier",
        "fuel_top_speed_multiplier",
        "fuel_emissions_multiplier",
        "fuel_acceleration_multiplier_quality_bonus",
        "fuel_top_speed_multiplier_quality_bonus",
        "weight",
        "ingredient_to_weight_coefficient",
        "fuel_glow_color",
        "open_sound",
        "close_sound",
        "pick_sound",
        "drop_sound",
        "inventory_move_sound",
        "default_import_location",
        "color_hint",
        "has_random_tint",
        "spoil_to_trigger_result",
        "destroyed_by_dropping_trigger",
        "rocket_launch_products",
        "send_to_orbit_mode",
        "random_tint_color",
        "spoil_level",
        "factoriopedia_alternative",
        "order",
        "parameter",
    }

    ---@type data.ItemPrototype
    local pacified_grenade = {
        type = "item",
        stack_size = grenade.stack_size,
        name = grenade.name
    }

    for _, property_name in pairs(item_properties) do
        pacified_grenade[property_name] = grenade[property_name]
    end

    pacified_grenade.localised_name = {"item-name.pacifist-grenade"}

    data.raw["capsule"]["grenade"] = nil
    data:extend{pacified_grenade}

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
        science_packs = {
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