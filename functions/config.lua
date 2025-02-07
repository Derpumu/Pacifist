local compatibility = require("compatibility")
local settings = require("settings")
local types = require("types")

---@class (exact) Config
---@field exceptions { [string]: data.ItemID[] }
---@field extra { [string]: data.ItemID[], get_derived_items: (fun(type: Type, name: data.ItemID): data.ItemID)[], get_derived_recipes: (fun(type: Type, name: data.ItemID): data.RecipeID)[] }
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
        get_derived_items = {},
        get_derived_recipes = {},
        main_menu_simulations = {},
        technology = {},
        tips_and_tricks_items = {},
        science_packs = {},
    },
    preprocess = {},

    types = {
        military_entities = types.military_entities,
        military_equipment = types.military_equipment,
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

config.run_mod_preprocessing = function()
    for _, preprocess_function in pairs(config.preprocess) do
        preprocess_function()
    end
end

return config