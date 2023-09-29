local function disable_enemies()
    game.forces.enemy.evolution_factor = 0
    for _, surface in pairs(game.surfaces) do
        local map_gen_settings = surface.map_gen_settings
        map_gen_settings.autoplace_controls = map_gen_settings.autoplace_controls or {}
        map_gen_settings.autoplace_controls["enemy-base"] = { size = "none" }
        surface.map_gen_settings = map_gen_settings
        for _, enemy in pairs(surface.find_entities_filtered({force="enemy"})) do
	        enemy.destroy()
        end
    end
    game.map_settings.enemy_expansion.enabled = false
    game.map_settings.enemy_evolution.enabled = false
end

local function on_init()
    disable_enemies()
end

script.on_init(on_init)
