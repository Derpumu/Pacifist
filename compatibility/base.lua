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
        tips_and_tricks_items = {
            "shoot-targeting"
        }
    }
}

if settings.startup["pacifist-remove-walls"].value then
    table.insert(base_config.extra.tips_and_tricks_items, "gate-over-rail")
end

return base_config