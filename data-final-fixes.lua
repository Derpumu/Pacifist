require("__Pacifist__.functions")
local array = require("__Pacifist__.lib.array")
local string = require("__Pacifist__.lib.string")

local military_info = require("__Pacifist__.functions.military-info")


PacifistMod.mod_preprocessing()

local original_references = PacifistMod.record_references()

-- find military stuff...
local military_item_recipes = PacifistMod.find_recipes_for(military_info.item_names)

-- ... and remove it all
local more_obsolete_recipes = PacifistMod.remove_military_recipe_ingredients(military_info.item_names, military_item_recipes)
array.append(military_item_recipes, more_obsolete_recipes)

local obsolete_technologies = PacifistMod.remove_military_technology_effects(military_item_recipes)
PacifistMod.treat_military_science_pack_requirements()
PacifistMod.remove_technologies(obsolete_technologies)
PacifistMod.remove_recipes(military_item_recipes)
PacifistMod.remove_military_items_signals(military_info.item_names)
PacifistMod.remove_military_entities()
PacifistMod.remove_vehicle_guns()
PacifistMod.remove_unit_attacks()
PacifistMod.remove_military_items(military_info.items)
PacifistMod.remove_armor_references()
PacifistMod.remove_misc()
PacifistMod.remove_orphaned_entities(original_references)

if PacifistMod.settings.remove_pollution then
    PacifistMod.remove_pllution_emission()
end

PacifistMod.disable_biters_in_presets()
PacifistMod.relabel_item_groups()
PacifistMod.disable_gun_slots()

-- We're removing all military items and entities, but some prototypes need to remain in the game for saves to be loadable
-- to not have some entities and items stay in the game, we instead have dummy prototypes
local dummies = require("__Pacifist__.prototypes.dummies")
data:extend(dummies)

PacifistMod.mod_postprocessing()
