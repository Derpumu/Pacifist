local array = require("__Pacifist__.lib.array") --[[@as Array]]

local _pacify_abomb = function()
    local item = data.raw["ammo"]["atomic-bomb"]
    if not item then return end
    data.raw["ammo"]["atomic-bomb"] = nil

    local cliff_explosives = data.raw["capsule"]["maraxsis-big-cliff-explosives"]

    item.type = "item"
    item.subgroup = cliff_explosives.subgroup
    item.localised_name = {"item-name.pacifist-abomb"}
    item.order = (cliff_explosives.order or "").."z"

    data:extend{item}

    ---@type data.UnlockRecipeModifier?
    local recipe_effect = nil
    for _, technology in pairs(data.raw["technology"]) do
        if technology.effects then
            for _, effect in pairs(technology.effects) do
                if effect.type == "unlock-recipe" and effect.recipe == "atomic-bomb" then
                    recipe_effect = effect
                end
            end
            array.remove_in_place(technology.effects, function(effect) return effect.type =="unlock-recipe" and effect.recipe == "atomic-bomb" end)
        end
    end

    ---@type data.TechnologyPrototype?
    local big_cliff_tech = data.raw["technology"]["maraxsis-depth-charges"]
    if recipe_effect and big_cliff_tech then
        big_cliff_tech.effects = big_cliff_tech.effects or {}
        table.insert(big_cliff_tech.effects, recipe_effect)
    end
end

return {
    exceptions = {
        entity = {
            "maraxsis-tropical-fish-1",
            "maraxsis-tropical-fish-2",
            "maraxsis-tropical-fish-3",
            "maraxsis-tropical-fish-4",
            "maraxsis-tropical-fish-5",
            "maraxsis-tropical-fish-6",
            "maraxsis-tropical-fish-7",
            "maraxsis-tropical-fish-8",
            "maraxsis-tropical-fish-9",
            "maraxsis-tropical-fish-10",
            "maraxsis-tropical-fish-11",
            "maraxsis-tropical-fish-12",
            "maraxsis-tropical-fish-13",
            "maraxsis-tropical-fish-14",
            "maraxsis-tropical-fish-15",
        },
    },
    extra = {
        item = { "maraxsis-military-science-pack-research-vessel" },
    },
    preprocess = _pacify_abomb
}
