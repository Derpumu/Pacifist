require("__Pacifist__.functions.debug")

local function find_and_destroy_entities(surface, filter)
    for _, entity in pairs(surface.find_entities_filtered(filter)) do
        debug_log("destroyed entity " .. entity.name)
        entity.destroy()
    end
end

local function disable_enemies()
    game.forces.enemy.evolution_factor = 0
    for _, surface in pairs(game.surfaces) do
        find_and_destroy_entities(surface, { force = "enemy" })
        local map_gen_settings = surface.map_gen_settings
        map_gen_settings.autoplace_controls = map_gen_settings.autoplace_controls or {}
        map_gen_settings.autoplace_controls["enemy-base"] = { size = "none" }
        surface.map_gen_settings = map_gen_settings
    end
    game.map_settings.enemy_expansion.enabled = false
    game.map_settings.enemy_evolution.enabled = false
end


local function on_init()
    disable_enemies()
end

script.on_init(on_init)
