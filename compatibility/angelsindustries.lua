local array = require("__Pacifist__.lib.array")

local update_exploration = function()
    exploration_tech = data.raw.technology["tech-specialised-labs-basic-exploration-1"]
    if exploration_tech then
        array.remove(exploration_tech.prerequisites, "angels-components-weapons-basic")
    end

    exploration_block1_recipe = data.raw.recipe["block-exploration-1"]
    if exploration_block1_recipe then
        for _, ingredient in pairs(exploration_block1_recipe.ingredients) do
            if ingredient.name == "weapon-parts" then
                ingredient.amount = ingredient.amount * 2
                ingredient.name = "angels-gear"
            end
        end
    end
end

return {
    --exceptions = {
    --    gun = "dolphin-gun"
    --},
    --extra = {
    --    misc = {
    --        { "research-achievement", "destroyer-of-worlds" },
    --        { "tips-and-tricks-item", "kr-creep" },
    --        { "tips-and-tricks-item", "kr-new-gun-play" }
    --    },
    --    item = { "biters-research-data", "biomass" },
    --    entity = { "kr-bio-lab" }
    --},
    --ignore = {
    --    result_items = { "kr-void", "matter" }
    --},
    preprocess = { update_exploration }
}
