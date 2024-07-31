require("__Pacifist__.functions")
require("__Pacifist__.functions.military-info")
require("__Pacifist__.functions.recipes")

PacifistMod.mod_preprocessing()

local original_references = PacifistMod.record_references()

-- find military stuff...
PacifistMod.process_items_and_entities()
PacifistMod.process_recipes()

PacifistMod.remove_military_technology_effects()
PacifistMod.remove_military_science_pack_tech_ingredients()
PacifistMod.remove_technologies()
PacifistMod.remove_recipes()
PacifistMod.remove_military_items_signals()
PacifistMod.remove_military_entities()
PacifistMod.remove_military_equipment()
PacifistMod.remove_vehicle_guns()
PacifistMod.remove_unit_attacks()
PacifistMod.remove_military_items()
PacifistMod.remove_armor_references()
PacifistMod.remove_menu_simulations()
PacifistMod.remove_misc()

PacifistMod.hide_orphaned_entities(original_references)

if PacifistMod.settings.remove_pollution then
    PacifistMod.remove_pollution_emission()
end

PacifistMod.disable_biters_in_presets()
PacifistMod.relabel_item_groups()
PacifistMod.disable_gun_slots()

-- We're removing all military items and entities, but some prototypes need to remain in the game for saves to be loadable
-- to not have some entities and items stay in the game, we instead have dummy prototypes
local dummies = require("__Pacifist__.prototypes.dummies")
data:extend(dummies)

