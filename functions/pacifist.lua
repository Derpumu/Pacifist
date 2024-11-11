local config = require("config")
local cosmetics = require("cosmetics")
local entities = require("entities")
local equipment = require("equipment")
local items = require("items")
local pollution = require("pollution")
local recipes = require("recipes")
local technologies = require("technologies")

local Pacifist = {
    process = function(data_raw)
        config.run_mod_preprocessing()
        local entity_info = entities.collect_info(data_raw, config)
        local equipment_info = equipment.collect_info(data_raw, config)
        -- collect equipment
        local item_info = items.collect_info(data_raw, config, entity_info, equipment_info)
        -- collect entities and items
        local recipe_info = recipes.collect_info(data_raw, config, item_info)
        -- collect technology info
        -- apply changes to data.raw

        cosmetics.process(data_raw, config) -- simple renaming, new graphics & co
        pollution.process(data_raw)

        technologies.process(data_raw, config, recipe_info)
        recipes.process(data_raw, recipe_info)
        items.process(data_raw, item_info)
        equipment.process(data_raw, equipment_info)
        entities.process(data_raw, entity_info)
    end
}

return Pacifist
