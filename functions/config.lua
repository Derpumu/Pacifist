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
        entity_types = {},
        main_menu_simulations = {},
        tips_and_tricks_items = {},
    },
    preprocess = {},

    types = {
        military_entities = types.military_entities
    },
}

compatibility.extend_config(config)

if settings.remove_walls then
    -- array.append(config.types.military_entities, { "wall", "gate" })
end

config.run_mod_preprocessing = function()
    for _, preprocess_function in pairs(config.preprocess) do
        preprocess_function()
    end
end

return config