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
    entity = { "compilatron" },
    gun = {},
    equipment = {},
    technology = {}
}

PacifistMod.void_items = {}
PacifistMod.void_recipe_suffix = {}
PacifistMod.detect_ignored_effects = {}

PacifistMod.extra = {
    armor = {},
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
        { "tips-and-tricks-item", "kr-new-gun-play"}
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
if mods["exotic-industries"] then
    local function is_age_progression(effect)
        return effect.type == "nothing"
            and effect.effect_description
            and type(effect.effect_description) == "table"
            and array.contains(effect.effect_description, "description.tech-counts-for-age-progression")
    end
    table.insert(PacifistMod.detect_ignored_effects, is_age_progression)
    array.append(PacifistMod.military_main_menu_simulations, {"ei_menu_3", "ei_menu_5"})
end
if mods["Companion_Drones"] then
    array.append(PacifistMod.exceptions.equipment, {"companion-shield-equipment", "companion-defense-equipment"})
end

if mods["blueprint-shotgun"] then
    array.append(PacifistMod.exceptions.ammo, { "item-canister" })
    array.append(PacifistMod.exceptions.gun, { "blueprint-shotgun" })
end

PacifistMod.settings = {
    remove_walls = settings.startup["pacifist-remove-walls"].value and not mods_require_walls,
    remove_shields = settings.startup["pacifist-remove-shields"].value and not mods_require_shields,
    remove_armor = settings.startup["pacifist-remove-armor"].value,
    remove_tank = settings.startup["pacifist-remove-tank"].value,
}

if PacifistMod.settings.remove_walls then
    array.append(PacifistMod.military_entity_types, { "wall", "gate" })
end

if PacifistMod.settings.remove_shields then
    table.insert(PacifistMod.military_equipment_types, "energy-shield-equipment")
end

if PacifistMod.settings.remove_armor then
    array.append(PacifistMod.extra.armor, { "light-armor", "heavy-armor" })
end

if PacifistMod.settings.remove_tank then
    array.append(PacifistMod.extra.entity_types, { "car" })
    array.append(PacifistMod.extra.entity, { "tank" })
end
