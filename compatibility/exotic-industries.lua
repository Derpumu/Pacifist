local array = require("__Pacifist__.lib.array")
local string = require("__Pacifist__.lib.string")
local data_raw = require("__Pacifist__.lib.data_raw")

local function is_age_progression(effect)
    return effect.type == "nothing"
            and effect.effect_description
            and type(effect.effect_description) == "table"
            and array.contains(effect.effect_description, "description.tech-counts-for-age-progression")
end

local function convert_flower_loot()
    -- In Exotic Industries, alien flowers can be mined and killed to get some loot.
    -- Mining them gives a corresponding item that allows to plant them elsewhere, and
    -- the loot is needed to get the necessary alien seeds to kickstart the alien resin production.
    -- Since we can not kill anything in Pacifist, we convert the loot into the mining result.
    -- The item for replanting can not be a result as well, since it would allow to plant and mine the flowers
    -- in an endless loop to farm the alien seeds
    for name, entity in pairs(data.raw["simple-entity"]) do
        if string.starts_with(name, "ei_alien-flowers") and entity.loot then
            local mining_time = entity.minable and entity.minable.mining_time or 1
            entity.minable = {
                mining_time = mining_time,
                results = {}
            }
            for _, loot_item in pairs(entity.loot) do
                local mining_product = {
                    name = loot_item.item,
                    probability = loot_item.probability,
                    amount_min = loot_item.count_min or 1,
                    amount_max = loot_item.count_max or 1
                }
                table.insert(entity.minable.results, mining_product)
            end
            entity.loot = nil
        end
    end
end

local function remove_explosion_effects()
    -- When alien flowers are killed or mined, guardians with blood explosions may get spawned.
    -- While we destroy them immediately in control.lua, we can not destroy the immediate particle effects
    -- Therefore we remove the effects from the prototype here
    data.raw.explosion["blood-explosion-huge"].created_effect = nil
end

local preserved_biters = {
    "small-biter",
    "medium-biter",
    "big-biter",
    "behemoth-biter"
}

local function remove_biters_from_spawners()
    -- EI occasionally spawns biters and worms.
    -- Currently, the orphan detection system finds those biters as orphaned after spawners have been removed.
    -- This results in spawning entities with non-existing prototypes before Pacifist can kill them, and the game crashes.
    -- To remedy this, remove these biters as results of the spawners
    for _, spawner in pairs(data.raw["unit-spawner"]) do
        for i, result in ipairs(spawner.result_units) do
            -- result unit entries have the form {"medium-biter", {{0.2, 0.0}, {0.6, 0.3}, {0.7, 0.1}}}
            if array.contains(preserved_biters, result[1]) then
                result[1] = "?" -- does not really matter as the spawner gets removed anyway
            end
        end
    end

    -- To not have the biters show up as signals or RTF symbols, hide them
    data_raw.hide_all("unit", preserved_biters)
end

local preserved_turrets = {
    "small-worm-turret",
    "medium-worm-turret",
    "big-worm-turret",
    "behemoth-worm-turret",
}

local function preserve_spawned_turrets()
    -- EI occasionally spawns worms and biters.
    -- Since all turrets are removed by Pacifist, replace them with a plain entity.
    for _, turret_name in pairs(preserved_turrets) do
        local turret = data.raw.turret[turret_name]
        if turret then
            data.raw.turret[turret_name] = nil
            data:extend({{
                type = "deconstructible-tile-proxy",
                name = turret_name,
                flags = {"hidden"},
            }})
        end
    end
end

return {
    ignore = {
        effects_pred = { is_age_progression }
    },
    extra = {
        main_menu_simulations = { "ei_menu_3", "ei_menu_5" }
    },
    preprocess = { convert_flower_loot, remove_explosion_effects, remove_biters_from_spawners, preserve_spawned_turrets }
}
