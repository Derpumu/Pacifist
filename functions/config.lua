local compatibility = require("compatibility")

local config = {
    exceptions = {
        ammo = {},
        gun = {}
    },
    extra = {
        main_menu_simulations = {}
    }
}

compatibility.extend_config(config)

return config