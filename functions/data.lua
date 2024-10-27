local config = require("config")
local cosmetics = require("cosmetics")

local Pacifist = {
    process = function(data_raw)
    cosmetics.process(data_raw, config) -- simple renaming, new graphics & co
    -- collect entities and items
    -- collect recipes
    -- collect technology info
    -- apply changes to data.raw
    -- return new entries for data.raw
        return {}
    end
}

return Pacifist
