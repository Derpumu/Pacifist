local array = require("__Pacifist__.lib.array")

local compatibility = require("compatibility")
local settings = require("settings")
local types = require("types")

local config = {
    exceptions = {
        ammo = {},
        entity = {},
        gun = {},
    },
    extra = {
        entity = {},
        main_menu_simulations = {},
        tips_and_tricks_items = {},
    },
    preprocess = {},
    required = {
        walls = false,
        shields = false,
    },

    types = {
        military_entities = types.military_entities
    },
}

compatibility.extend_config(config)

if settings.remove_walls then
--   table.insert(config.types.military_entities, "gate")
--   table.insert(config.types.military_entities, "wall")
end

config.run_mod_preprocessing = function()
    for _, preprocess_function in pairs(config.preprocess) do
        preprocess_function()
    end
end

return config