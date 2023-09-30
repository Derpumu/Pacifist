PacifistMod = PacifistMod or {}


PacifistMod.military_science_packs = { "military-science-pack" }

-- Entities types from items (place_result)
PacifistMod.military_entity_types = {
    "artillery-turret",
    -- "combat-robot", -- techincally entities, it would be VERY tedous to remove their prototypes
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

-- We're removing all military items and entities, but some need to remain in the game for saves to be loadable
-- to not have some entities and items stay in the game, we instead clone prototypes and add them with different names
PacifistMod.dummies_to_clone = {
    -- type, name
    gun = { "artillery-wagon-cannon" },
    ammo = { "artillery-shell" },
    ["land-mine"] = { "land-mine" },
    ["artillery-turret"] = { "artillery-turret" },
    ["ammo-turret"] = { "gun-turret" },
    ["electric-turret"] = { "laser-turret" },
    ["fluid-turret"] = { "flamethrower-turret" },
    ["artillery-wagon"] = { "artillery-wagon" },
    ["active-defense-equipment"] = { "personal-laser-defense-equipment" },

    ["item"] = { "personal-laser-defense-equipment", "energy-shield-equipment" },
}

if settings.startup["pacifist-remove-walls"].value then
    array.append(PacifistMod.military_entity_types, { "wall", "gate" })
    PacifistMod.dummies_to_clone["gate"] = { "gate" }
    PacifistMod.dummies_to_clone["wall"] = { "stone-wall" }
end

if settings.startup["pacifist-remove-shields"].value then
    table.insert(PacifistMod.military_equipment_types, "energy-shield-equipment")
    PacifistMod.dummies_to_clone["energy-shield-equipment"] = { "energy-shield-equipment" }
end
