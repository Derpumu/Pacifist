require("__Pacifist__.lib.debug")
local array = require("__Pacifist__.lib.array") --[[@as Array]]

local enemy_exceptions = {}
if script.active_mods["space-age"] then
    table.insert(enemy_exceptions, "biter-spawner")
end


local function remove_freeplay_gun_and_mags()
    if not remote.interfaces["freeplay"] then return end
    local _remove_gun_and_mags = function(get_set_suffix)
        local items = remote.call("freeplay", "get_" .. get_set_suffix)
        assert(items)
        items["firearm-magazine"] = nil
        items["pistol"] = nil
        remote.call("freeplay", "set_" .. get_set_suffix, items)
    end

    for _, suffix in pairs({ "created_items", "respawn_items", "ship_items", "debris_items" }) do
        _remove_gun_and_mags(suffix)
    end
end

local function find_and_destroy_enemies(surface)
    for _, entity in pairs(surface.find_entities_filtered({ force = "enemy" })) do
        if not array.contains(enemy_exceptions, entity.name) then
            debug_log("destroyed entity " .. entity.name)
            entity.destroy()
        end
    end
end

local function disable_enemies()
    game.forces.enemy.reset_evolution()
    for _, surface in pairs(game.surfaces) do
        find_and_destroy_enemies(surface)
    end
    game.map_settings.enemy_expansion.enabled = false
    game.map_settings.enemy_evolution.enabled = false
end


local function on_init()
    remove_freeplay_gun_and_mags()
    disable_enemies()
end

script.on_init(on_init)
