local string = require("__Pacifist__.lib.string")

if not script.active_mods["space-age"] then return end

for _, surface in pairs(game.surfaces) do
    local density = surface.get_property("pacifist-asteroid-density")
    if density == 0 and (string.starts_with(surface.name, "platform-") )then
        surface.set_property("pacifist-asteroid-density", 0.01)
    end
end
