local compatibility = require("compatibility")

local config = {
    exceptions = {
        ammo = {},
        gun = {},
    },
    extra = {
        main_menu_simulations = {},
        tips_and_tricks_items = {},
    }
}

compatibility.extend_config(config)

return config