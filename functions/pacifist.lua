local config = require("config")
local cosmetics = require("cosmetics")
local entities = require("entities")
local equipment = require("equipment")
local items = require("items")
local pollution = require("pollution")
local recipes = require("recipes")
local technologies = require("technologies")
local immersion = require("immersion")

local Pacifist = {
    process = function(data_raw)
        --- TODO: if debug then record references and print orphans

        config.run_mod_preprocessing()
        local entity_info = entities.collect_info(data_raw, config)
        local equipment_info = equipment.collect_info(data_raw, config)
        local item_info = items.collect_info(data_raw, config, entity_info, equipment_info)
        local recipe_info = recipes.collect_info(data_raw, config, item_info)

        -- apply changes to data.raw
        cosmetics.process(data_raw, config)
        pollution.process(data_raw)

        technologies.process(data_raw, config, recipe_info)
        recipes.process(data_raw, recipe_info)
        items.process(data_raw, item_info)
        equipment.process(data_raw, equipment_info)
        entities.process(data_raw, entity_info)
        immersion.process(data_raw, config) -- simple renaming, new graphics & co
    end
}

return Pacifist
