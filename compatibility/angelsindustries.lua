local array = require("__Pacifist__.lib.array")
local pstring = require("__Pacifist__.lib.string")
require("__Pacifist__.functions.debug")

local update_exploration = function()
    local exploration_blocks = {
        "block-exploration-1",
        "block-exploration-2",
        "block-exploration-3",
        "block-exploration-4",
        "block-exploration-5",
    }

    for _, block_name in pairs(exploration_blocks) do
        local exploration_block_recipe = data.raw.recipe[block_name]
        if exploration_block_recipe then
            for _, ingredient in pairs(exploration_block_recipe.ingredients) do
                if ingredient.name == "weapon-parts" then
                    ingredient.amount = ingredient.amount * 2
                    ingredient.name = "mechanical-parts"
                end
            end
        end
    end
end

local replace_war_cores = function(tech, core_1_replacement, core_2_replacement)
    for _, pack in pairs(tech.unit.ingredients) do
        if pack.name == "datacore-war-1" then pack.name = core_1_replacement end
        if pack[1] == "datacore-war-1" then pack[1] = core_1_replacement end
        if pack.name == "datacore-war-2" then pack.name = core_2_replacement end
        if pack[1] == "datacore-war-2" then pack[1] = core_2_replacement end
    end
end

local update_military_tech = function()
    -- angels overrides some technologies with military tech requirement
    -- see angelsindustries: prototypes/overrides/industries-override-functions.lua

    for rec_4tech, tech in pairs(data.raw.technology) do
        if string.find(rec_4tech, "laser") ~= nil
        then
            replace_war_cores(tech, "datacore-energy-1", "datacore-energy-2")
        elseif string.find(rec_4tech, "tank") ~= nil
                or string.find(rec_4tech, "spidertron") ~= nil
        then
            replace_war_cores(tech, "datacore-exploration-1", "datacore-exploration-2")
        elseif string.find(rec_4tech, "explosive") ~= nil
                or (rec_4tech == "rocket-control-unit")
                or (rec_4tech == "angels-rocket-shield-array")
        then
            replace_war_cores(tech, "datacore-processing-1", "datacore-processing-2")
        else
            -- gates, wall, general fallback
            replace_war_cores(tech, "datacore-basic", "datacore-processing-2")
        end
    end
end

local function is_warfare_block(product)
    return pstring.starts_with(product.name, "block-warfare-")
end

local remove_warfare_lab_mining_result = function()
    for _, lab in pairs(data.raw.lab) do
        debug_log("lab name: "..lab.name)
        debug_log(dump_table(lab))
        local results = lab.minable and lab.minable.results or {}
        array.remove_in_place(results, is_warfare_block)
    end
end

return {
    extra = {
        item = {
            "weapon-parts",
            "angels-trigger",
            "angels-explosionchamber",
            "angels-fluidchamber",
            "angels-energycrystal",
            "angels-acceleratorcoil",
            "body-1",
            "body-2",
            "body-3",
            "body-4",
            "body-5",
            "weapon-1",
            "weapon-2",
            "weapon-3",
            "weapon-4",
            "weapon-5",
            "block-warfare-1",
            "block-warfare-2",
            "block-warfare-3",
            "block-warfare-4",
            "block-warfare-5",
        },
        entity = {
            "angels-war-lab-1",
            "angels-war-lab-2",
            "angels-war-lab-3",
        },
        entity_types = { "lab" },
        science_packs = {
            "datacore-war-1",
            "datacore-war-2",
        },
    },
    preprocess = { update_exploration, update_military_tech, remove_warfare_lab_mining_result }
}
