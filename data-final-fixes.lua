PacifistMod = PacifistMod or {}

require("__Pacifist__.config")
require("__Pacifist__.functions")

-- We're removing all military items and entities, but some need to remain in the game for saves to be loadable
-- to not have some entities and items stay in the game, we instead clone prototypes and add them with different names
local dummies = PacifistMod.clone_dummies()

-- find military stuff...
local military_item_table, military_item_names = PacifistMod.find_all_military_items()
local military_item_recipes = PacifistMod.find_recipes_for(military_item_names)

-- ... and remove it all
local obsolete_technologies = PacifistMod.remove_military_technology_effects(military_item_recipes)
PacifistMod.remove_obsolete_technologies(obsolete_technologies)
PacifistMod.remove_military_science_pack_requirements()
PacifistMod.remove_recipes(military_item_recipes)
PacifistMod.remove_military_recipe_ingredients(military_item_names)
PacifistMod.make_military_items_unplaceable(military_item_table)
PacifistMod.remove_military_entities()
PacifistMod.remove_vehicle_guns()
PacifistMod.remove_military_items(military_item_table)
PacifistMod.remove_misc()

PacifistMod.disable_biters_in_presets()

data:extend(dummies)

-- TODO:
-- remove tanks? (type = car, name = tank)
-- make removal of walls/gates optional
-- make removal of energy shield optional
-- improve technology removal (check for transitive prerequisites before adding new ones)
-- offer alternative science pack
-- change category icon from SMG to armor, maybe move radar to buildings tab