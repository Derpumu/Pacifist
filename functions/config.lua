local compatibility = require("compatibility")
local settings = require("settings")
local types = require("types")

local config = {
    exceptions = {
        ammo = {},
        entity = {},
        equipment = {},
        gun = {},
        technology = {},
    },
    extra = {
        entity = {},
        main_menu_simulations = {},
        technology = {},
        tips_and_tricks_items = {},
    },
    preprocess = {},

    types = {
        military_entities = types.military_entities,
        military_equipment = types.military_equipment,
    },
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