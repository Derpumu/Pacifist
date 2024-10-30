local config = require("config")
local cosmetics = require("cosmetics")
local entities = require("entities")
local pollution = require("pollution")

local Pacifist = {
    process = function(data_raw)
        local entity_info = entities.collect_info(data_raw, config)
        -- collect entities and items
        -- collect recipes
        -- collect technology info
        -- apply changes to data.raw
        cosmetics.process(data_raw, config) -- simple renaming, new graphics & co
        pollution.process(data_raw)
        entities.process(data_raw, entity_info)
        -- return new entries for data.raw
        return {}
    end
}

return Pacifist
