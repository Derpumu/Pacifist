if not script.active_mods["space-age"] then return end

-- spawners must me on enemy force in order to capture them
-- Pacifist put them on neutral force before
local neutral_spawners = game.get_surface("nauvis").find_entities_filtered({ force = "neutral", name = "biter-spawner" })
for _, spawner in pairs(neutral_spawners) do
    spawner.force = "enemy"
end