-- Pacifist's space-age handling leaves these entities in, including their corpses.
-- creative-mod clones the entities, they are then removed by Pacifist, including their corpses
-- because corpses are not reference counted (https://github.com/Derpumu/Pacifist/issues/112)
local _remove_space_age_corpses = function()
    if not mods["space-age"] then return end
    for _, name in pairs({"gleba-spawner", "gleba-spawner-small", "biter-spawner"}) do
        local creative_clone = data.raw["unit-spawner"]["creative-mod_enemy-object_" .. name]
        if creative_clone then creative_clone.corpse = nil end
    end
end

return {
    preprocess = _remove_space_age_corpses
}