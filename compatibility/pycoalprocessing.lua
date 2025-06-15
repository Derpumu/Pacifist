require("__Pacifist__.functions.pacify_item")

local _handle_utility_science_capsules = function()
    pacify_item("destroyer-capsule", "utility-science-pack")
    pacify_item("distractor-capsule", "destroyer-capsule")
    pacify_item("defender-capsule", "distractor-capsule")
    pacify_item("piercing-rounds-magazine", "defender-capsule")
    pacify_item("firearm-magazine", "piercing-rounds-magazine")
    pacify_item("gunpowder", "firearm-magazine")
end

return {
    extra = {
        technology = {
            "military",
            "military-2",  -- together with the grenade changes in base.lua we removed the only military effects
            "distractor",
            "destroyer",
        }
    },
    preprocess = { _handle_utility_science_capsules }
}
