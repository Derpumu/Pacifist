require("__Pacifist__.functions.debug")

local string = require("__Pacifist__.lib.string")

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

if script.active_mods["exotic-industries"] then
    local function on_destroyed_entity(e)
        if not e.entity then return end

        local entity = e.entity
        if not string.starts_with(entity.name, "ei_alien-flowers")
                and entity.name ~= "ei_alien-stabilizer"
                and entity.name ~= "ei_alien-beacon"
        then
            return
        end

        -- EI uses an area of +-30 tiles to create guardians, let's be conservative
        local distance = 50
        local area = {
            {entity.position.x - distance,  entity.position.y - distance},
            {entity.position.x + distance,  entity.position.y + distance}
        }
        -- find and destroy potentially spawned worms and biters
        find_and_destroy_entities(entity.surface, {
            area = area,
            force = "enemy"
        })
        -- and the explosions that come with them
        find_and_destroy_entities(entity.surface, {
            area = area,
            name = "blood-explosion-huge"
        })
        -- also the warning texts that come earlier
        find_and_destroy_entities(entity.surface,{
            position = entity.position,
            name = "flying-text"
        })
    end

    script.on_event({
        defines.events.on_entity_died,
        defines.events.on_pre_player_mined_item,
        defines.events.on_robot_pre_mined,
        defines.events.script_raised_destroy
    }, on_destroyed_entity)
end

local function on_init()
    disable_enemies()
end

script.on_init(on_init)
