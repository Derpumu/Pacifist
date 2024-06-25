local array = require("__Pacifist__.lib.array")

local update_exploration = function()
    local exploration_tech = data.raw.technology["tech-specialised-labs-basic-exploration-1"]
    if exploration_tech then
        array.remove(exploration_tech.prerequisites, "angels-components-weapons-basic")
    end

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

local update_wall_tech = function()
    -- angels overrides walls and gates with military tech requirement
    -- see angelsindustries: prototypes/overrides/industries-override-functions.lua

    for rec_4tech in pairs(data.raw.technology) do
        if string.find(rec_4tech, "wall") ~= nil
                or string.find(rec_4tech, "gate") ~= nil
        then
            local tech = data.raw.technology[rec_4tech]
            for _, pack in pairs(tech.unit.ingredients) do
                local packname = pack.name or pack[1]
                log("tech: "..rec_4tech.." pack: "..packname)
                if pack.name == "datacore-war-1" then pack.name = "datacore-basic" end
                if pack[1] == "datacore-war-1" then pack[1] = "datacore-basic" end
            end
        end
    end
end

return {
    --exceptions = {
    --    gun = "dolphin-gun"
    --},
    extra = {
        --    misc = {
        --        { "research-achievement", "destroyer-of-worlds" },
        --        { "tips-and-tricks-item", "kr-creep" },
        --        { "tips-and-tricks-item", "kr-new-gun-play" }
        --    },
        item = {
            "weapon-parts",
            "angels-trigger",
            "body-1",
            "weapon-1",
            "block-warfare-1",
            "block-warfare-2",
            "block-warfare-3",
            "block-warfare-4",
            "block-warfare-5",
        },
        entity = { "angels-war-lab-1" },
        entity_types = { "lab" },
    },
    --ignore = {
    --    result_items = { "kr-void", "matter" }
    --},
    preprocess = { update_exploration, update_wall_tech }
}
