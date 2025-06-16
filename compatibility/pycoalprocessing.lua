local technologies = require("__Pacifist__.functions.technologies")
require("__Pacifist__.functions.pacify_item")
local array = require("__Pacifist__.lib.array") --[[@as Array]]

local _pacify_gunpowder = function()
    technologies.move_unlock(data.raw, "gun-powder", "military", "cliff-explosives")
end

local _pacify_utility_science_capsules = function()
    pacify_item("destroyer-capsule", "utility-science-pack")
    pacify_item("distractor-capsule", "destroyer-capsule")
    pacify_item("defender-capsule", "distractor-capsule")
    pacify_item("piercing-rounds-magazine", "defender-capsule")
    pacify_item("firearm-magazine", "piercing-rounds-magazine")
end

local config = {
    extra = {
        technology = {},
    },
    preprocess = { _pacify_gunpowder }
}

-- pycoalprocessing changes the production chain for utility science to include all the capsules
-- unless pyhightech is included as well, which changes the chain again
if not mods["pyhightech"] then
    table.insert(config.preprocess, _pacify_utility_science_capsules)
    array.append(config.extra.technology, {
        "military",
        "military-2",     -- together with the grenade changes in base.lua we removed the only military effects
        "distractor",
        "destroyer",
    })
end


return config