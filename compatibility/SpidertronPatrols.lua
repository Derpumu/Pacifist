-- corpses are not reference counted (https://github.com/Derpumu/Pacifist/issues/112)
local clone_spidertron_dock_corpse = function()
    local cloned_corpse = table.deepcopy(data.raw.corpse["artillery-turret-remnants"])
    cloned_corpse.name = "sp-spidertron-dock-remnants"

    data.raw["proxy-container"]["sp-spidertron-dock"].corpse = cloned_corpse.name
    data:extend{cloned_corpse}
end

return {
    preprocess = clone_spidertron_dock_corpse
}
