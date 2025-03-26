local clone_spidertron_dock_corpse = function()
    local cloned_corpse = table.deepcopy(data.raw.corpse["artillery-turret-remnants"])
    cloned_corpse.name = "sp-spidertron-dock-corpse"

    data.raw["proxy-container"]["sp-spidertron-dock"].corpse = cloned_corpse.name
    data:extend{cloned_corpse}
end

return {
    preprocess = clone_spidertron_dock_corpse
}
