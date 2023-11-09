require("__Pacifist__.functions")
local array = require("__Pacifist__.lib.array")

-- find military stuff...
local military_item_table, military_item_names = PacifistMod.find_all_military_items()
local military_item_recipes = PacifistMod.find_recipes_for(military_item_names)

-- ... and remove it all
local more_obsolete_recipes = PacifistMod.remove_military_recipe_ingredients(military_item_names)
array.append(military_item_recipes, more_obsolete_recipes)

local obsolete_technologies = PacifistMod.remove_military_technology_effects(military_item_recipes)
PacifistMod.treat_military_science_pack_requirements()
PacifistMod.remove_technologies(obsolete_technologies)
PacifistMod.remove_recipes(military_item_recipes)
PacifistMod.remove_military_items_signals(military_item_names)
PacifistMod.remove_military_entities()
PacifistMod.remove_vehicle_guns()
PacifistMod.remove_military_items(military_item_table)
PacifistMod.remove_misc()

PacifistMod.disable_biters_in_presets()
PacifistMod.rename_item_category()

-- We're removing all military items and entities, but some prototypes need to remain in the game for saves to be loadable
-- to not have some entities and items stay in the game, we instead have dummy prototypes
local dummies = require("__Pacifist__.prototypes.dummies")
data:extend(dummies)

if mods["stargate"] then
    data.raw["land-mine"]["stargate-sensor"].minable = nil
end
if mods["Krastorio2"] then
    data.raw["tile"]["kr-creep"].minable = nil
    local biotech = data.raw.technology["kr-bio-processing"]
    if biotech then
        biotech.icon = "__Pacifist__/graphics/technology/kr-fertilizers.png"
    end
end