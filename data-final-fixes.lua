require("__Pacifist__.functions")
local array = require("__Pacifist__.lib.array")
local string = require("__Pacifist__.lib.string")

local military_info = require("__Pacifist__.functions.military-info")

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

PacifistMod.disable_biters_in_presets()
PacifistMod.rename_item_category()
PacifistMod.disable_gun_slots()

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
if mods["exotic-industries"] then
    -- In Exotic Industries, alien flowers are supposed to be killed. We make them minable instead.
    -- This is necessary to get the necessary alien seeds to kickstart the alien resin production.
    for name, entity in pairs(data.raw["simple-entity"]) do
        if string.starts_with(name, "ei_alien-flowers") and entity.loot then
            entity.minable = {
                mining_time = 1,
                results = {}
            }
            for _, loot_item in pairs(entity.loot) do
                local mining_product = {
                    name = loot_item.item,
                    probability = loot_item.probability,
                    amount_min = loot_item.count_min or 1,
                    amount_max = loot_item.count_max or 1
                }
                table.insert(entity.minable.results, mining_product)
            end
            entity.loot = nil
        end
    end

    -- When alien flowers are killed or mined, guardians with blood explosions may get spawned.
    -- While we destroy them immediately in control.lua, we can not destroy the immediate particle effects
    -- Therefore we remove the effects from the prototype here
    data.raw.explosion["blood-explosion-huge"].created_effect = nil
end
if mods["Power Armor MK3"] then
    local heavy_vest_technology = data.raw.technology["heavy-armor"]
    if heavy_vest_technology then
        heavy_vest_technology.localised_name = {"technology-name.pamk3-heavy-vest"}
        heavy_vest_technology.localised_description = {"technology-description.pamk3-heavy-vest"}
    end
end