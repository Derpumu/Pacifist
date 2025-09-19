require("__Pacifist__.lib.debug")
local compatibility = require("compatibility")
local settings = require("settings")
local types = require("types")


---@class (exact) Config
---@field exceptions { [string]: data.ItemID[] }
---@field extra { [string]: data.ItemID[], get_derived_items: (fun(name: data.ItemID): data.ItemID)[], config.lua: (fun(name: data.ItemID, type:Type?): data.RecipeID)[] }
---@field preprocess (fun())[]
---@field types { [string]: Type[] }
---@field run_mod_preprocessing fun()

---@type Config
local config = {
    exceptions = {
        ammo = {},
        capsule = {},
        entity = {},
        equipment = {},
        gun = {},
        technology = {},
    },
    extra = {
        entity = {},
        ammo = {},
        gun = {},
        recipe = {},
        get_derived_items = {},
        get_derived_recipes = {},
        main_menu_simulations = {},
        technology = {},
        tips_and_tricks_items = {},
    },
    preprocess = {},

    types = {
        military_entities = types.military_entities,
        military_equipment = types.military_equipment,
        military_effects = types.military_effects,
    },
    run_mod_preprocessing = function() end
}

compatibility.extend_config(config)

if settings.remove_walls then
   table.insert(config.types.military_entities, "gate")
   table.insert(config.types.military_entities, "wall")
end

if settings.remove_shields then
    table.insert(config.types.military_equipment, "energy-shield-equipment")
end

if settings.remove_health_bonus then
    table.insert(config.types.military_effects, "character-health-bonus")
end

config.run_mod_preprocessing = function()
    for _, preprocess_function in pairs(config.preprocess) do
        preprocess_function()
    end
end

dump_table(settings, "settings")
dump_table(config, "config")

return config