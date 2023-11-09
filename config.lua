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



local mods_require_walls = (settings.startup["dectorio-walls"] and settings.startup["dectorio-walls"].value)
        or mods["angelsbioprocessing"]

local mods_require_shields = mods["500BotStart"]

PacifistMod.exceptions = {
    ammo = {},
    ammo_category = {},
    capsule = {},
    entity = {},
    gun = {},
    equipment = {}
}

PacifistMod.void_items = {}
PacifistMod.void_recipe_suffix = {}

PacifistMod.extra = {
    misc = {},
    item = {},
    entity = {},
    entity_types = { "assembling-machine" }
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
if mods["Nanobots"] then
    array.append(PacifistMod.exceptions.ammo, { "ammo-nano-constructors", "ammo-nano-termites" })
    array.append(PacifistMod.exceptions.ammo_category, { "nano-ammo" })
    array.append(PacifistMod.exceptions.equipment, {
        "equipment-bot-chip-feeder",
        "equipment-bot-chip-items",
        "equipment-bot-chip-nanointerface",
        "equipment-bot-chip-trees"
    })
    array.append(PacifistMod.exceptions.gun, { "gun-nano-emitter" })
end
if mods["Krastorio2"] then
    array.append(PacifistMod.exceptions.gun, { "dolphin-gun" })
    array.append(PacifistMod.extra.misc, {
        { "research-achievement", "destroyer-of-worlds" },
        { "tips-and-tricks-item", "kr-creep" },
    })
    array.append(PacifistMod.extra.item, { "biters-research-data", "biomass" })
    array.append(PacifistMod.extra.entity, { "kr-bio-lab" })
    -- tag matter as void item to remove military item to matter recipes
    array.append(PacifistMod.void_items, { "kr-void", "matter" })
end
if mods["pyindustry"] then
    table.insert(PacifistMod.void_recipe_suffix, "-pyvoid")
end
if mods["stargate"] then
    array.append(PacifistMod.exceptions.entity, { "stargate-sensor" })
end
if mods["Teleporters"] then
    array.append(PacifistMod.exceptions.entity, { "teleporter" })
end

PacifistMod.settings = {
    remove_walls = settings.startup["pacifist-remove-walls"].value and not mods_require_walls,
    remove_shields = settings.startup["pacifist-remove-shields"].value and not mods_require_shields,
}

if PacifistMod.settings.remove_walls then
    array.append(PacifistMod.military_entity_types, { "wall", "gate" })
end

if PacifistMod.settings.remove_shields then
    table.insert(PacifistMod.military_equipment_types, "energy-shield-equipment")
end
