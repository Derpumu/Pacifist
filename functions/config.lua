local compatibility = require("compatibility")

local config = {
    exceptions = {
        ammo = {},
        gun = {},
    },
    extra = {
        main_menu_simulations = {},
        tips_and_tricks_items = {},
    },
    preprocess = {}
}

compatibility.extend_config(config)

config.run_mod_preprocessing = function()
    for _, preprocess_function in pairs(config.preprocess) do
        preprocess_function()
    end
end

return config