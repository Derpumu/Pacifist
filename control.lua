require("__Pacifist__.lib.debug")

local function find_and_destroy_enemies(surface)
    for _, entity in pairs(surface.find_entities_filtered({ force = "enemy" })) do
        debug_log("destroyed entity " .. entity.name)
        entity.destroy()
    end
end

local function disable_enemies()
    game.forces.enemy.reset_evolution()
    for _, surface in pairs(game.surfaces) do
        find_and_destroy_enemies(surface)
        local map_gen_settings = surface.map_gen_settings
        map_gen_settings.autoplace_controls = map_gen_settings.autoplace_controls or {}
        map_gen_settings.autoplace_controls["enemy-base"] = { size = "none", frequency = "none", richness = "none" }
        surface.map_gen_settings = map_gen_settings
    end
    game.map_settings.enemy_expansion.enabled = false
    game.map_settings.enemy_evolution.enabled = false
end


local function on_init()
    disable_enemies()
end

script.on_init(on_init)
