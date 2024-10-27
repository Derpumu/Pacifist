local compatibility = require("compatibility")

local config = {
    exceptions = {
        ammo = {},
        gun = {}
    }
}

compatibility.extend_config(config)

return config