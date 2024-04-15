local array = require("__Pacifist__.lib.array")
local string = require("__Pacifist__.lib.string")

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

return {
    ignore = {
        effects_pred = { is_age_progression }
    },
    extra = {
        main_menu_simulations = { "ei_menu_3", "ei_menu_5" }
    },
    preprocess = { convert_flower_loot, remove_explosion_effects }
}
