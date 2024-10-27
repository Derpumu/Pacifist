local config = require("config")
local cosmetics = require("cosmetics")
local entities = require("entities")
local pollution = require("pollution")

local Pacifist = {
    process = function(data_raw)
        cosmetics.process(data_raw, config) -- simple renaming, new graphics & co
        -- collect entities and items
        -- collect recipes
        -- collect technology info
        -- apply changes to data.raw
        pollution.process(data_raw)
        -- return new entries for data.raw
        return {}
    end
}

return Pacifist
