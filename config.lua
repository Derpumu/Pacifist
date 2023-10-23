PacifistMod = PacifistMod or {}

local array = require("__Pacifist__.lib.array")


PacifistMod.military_science_packs = { "military-science-pack" }

-- Entities types from items (place_result)
PacifistMod.military_entity_types = {
    "artillery-turret",
    -- "combat-robot", -- techincally entities, it would be VERY tedious to remove their prototypes
    "land-mine",
    "ammo-turret",
    "electric-turret",
    "fluid-turret",
    "artillery-wagon",
}

-- Equipment types from items (placed_as_equipment_result)
PacifistMod.military_equipment_types = {
    "active-defense-equipment",
}

-- Items
PacifistMod.military_item_types = {
    "ammo",
    "gun",
}

PacifistMod.vehicle_types = {
    "car",
    "spider-vehicle"
}

-- capsules include fish and cliff explosives
PacifistMod.military_capsule_subgroups = {
    "capsule",
    "military-equipment",
    "defensive-structure" -- e.g. artillery remote
}

PacifistMod.military_tech_effects = {
    "ammo-damage",
    "turret-attack",
    "gun-speed",
    "artillery-range",
    "maximum-following-robots-count"
}

PacifistMod.military_main_menu_simulations = {
    "mining_defense",
    "biter_base_steamrolled",
    "biter_base_spidertron",
    "biter_base_artillery",
    "biter_base_player_attack",
    "biter_base_laser_defense",
    "artillery",
    "chase_player",
    "big_defense",
    "brutal_defeat",
}


PacifistMod.settings = {
    remove_walls = settings.startup["pacifist-remove-walls"].value,
    remove_shields = settings.startup["pacifist-remove-shields"].value,
}

-- Dectorio compatibility fix
if settings.startup["dectorio-walls"] and settings.startup["dectorio-walls"].value then
    PacifistMod.settings.remove_walls = false
end

if settings.startup["pacifist-treat-science-packs"].value == "replace" then
    PacifistMod.settings.replace_science_packs = { ["military-science-pack"] = "equipment-science-pack" }
end

if PacifistMod.settings.remove_walls then
    array.append(PacifistMod.military_entity_types, { "wall", "gate" })
end

if PacifistMod.settings.remove_shields then
    table.insert(PacifistMod.military_equipment_types, "energy-shield-equipment")
end

PacifistMod.exceptions = {
    ammo = {},
    capsule = {},
    entity = {},
    gun = {}
}

if mods["Explosive Termites"] then
    array.append(PacifistMod.exceptions.capsule, { "explosive-termites", "alien-explosive-termites" })
end

if mods["grappling-gun"] then
    array.append(PacifistMod.exceptions.ammo, { "grappling-gun-ammo" })
    array.append(PacifistMod.exceptions.gun, { "grappling-gun" })
end

if mods["shield-projector"] then
    array.append(PacifistMod.exceptions.entity, { "shield-projector" })
end