local config = require("config")
local cosmetics = require("cosmetics")
local entities = require("entities")
local items = require("items")
local pollution = require("pollution")

local Pacifist = {
    process = function(data_raw)
        config.run_mod_preprocessing()
        local entity_info = entities.collect_info(data_raw, config)
        -- collect equipment
        local item_info = items.collect_info(data_raw, config, entity_info)
        -- collect entities and items
        -- collect recipes
        -- collect technology info
        -- apply changes to data.raw
        cosmetics.process(data_raw, config) -- simple renaming, new graphics & co
        pollution.process(data_raw)
        entities.process(data_raw, entity_info)
        items.process(data_raw, item_info)
        -- return new entries for data.raw
        return {}
    end
}

return Pacifist
