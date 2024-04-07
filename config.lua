PacifistMod = PacifistMod or {}

local array = require("__Pacifist__.lib.array")
local compatibility = require("__Pacifist__.functions.compatibility")

PacifistMod.military_science_packs = { "military-science-pack" }

-- Entities types from items (place_result)
PacifistMod.military_entity_types = {
    "artillery-turret",
    -- "combat-robot", -- technically entities, it would be VERY tedious to remove their prototypes
    "land-mine",
    "ammo-turret",
    "electric-turret",
    "fluid-turret",
    "artillery-wagon",
    "unit",
    "unit-spawner",
    "turret",
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

-- units that stay in game but should have their attacks removed.
PacifistMod.units_to_disarm = {
    "compilatron",
}

PacifistMod.exceptions = {
    ammo = {},
    ammo_category = {},
    capsule = {},
    entity = { "compilatron" },
    gun = {},
    equipment = {},
    technology = {}
}

PacifistMod.ignore = {
    result_items = {},
    recipe_pred = {},
    effects_pred = {}
}

PacifistMod.extra = {
    armor = {},
    misc = {},
    item = {},
    entity = {},
    entity_types = { "assembling-machine" },
    technology = { "military-1", "military-2", "military-3", "military-4" },
    main_menu_simulations = {
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
}

PacifistMod.required = {
    walls = false,
    shields = false
}

compatibility.extend_config()

-- settings section

PacifistMod.settings = {
    remove_walls = settings.startup["pacifist-remove-walls"].value and not PacifistMod.required.walls,
    remove_shields = settings.startup["pacifist-remove-shields"].value and not PacifistMod.required.shields,
    remove_armor = settings.startup["pacifist-remove-armor"].value,
    remove_tank = settings.startup["pacifist-remove-tank"].value,
    remove_pollution = settings.startup["pacifist-remove-pollution"].value,
}

if PacifistMod.settings.remove_walls then
    array.append(PacifistMod.military_entity_types, { "wall", "gate" })
end

if PacifistMod.settings.remove_shields then
    array.append(PacifistMod.military_equipment_types, { "energy-shield-equipment" })
end

if PacifistMod.settings.remove_armor then
    array.append(PacifistMod.extra.armor, { "light-armor", "heavy-armor" })
end

if PacifistMod.settings.remove_tank then
    array.append(PacifistMod.extra.entity_types, { "car" })
    array.append(PacifistMod.extra.entity, { "tank" })
end
