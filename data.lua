PacifistMod = PacifistMod or {}
require("__Pacifist__.config")

if PacifistMod.settings.replace_science_packs then
    data:extend({
        {
            type = "tool",
            name = "equipment-science-pack",
            localised_description = { "item-description.science-pack" },
            icon = "__base__/graphics/icons/military-science-pack.png",
            icon_size = 64, icon_mipmaps = 4,
            subgroup = "science-pack",
            order = "c[equipment-science-pack]",
            stack_size = 200,
            durability = 1,
            durability_description_key = "description.science-pack-remaining-amount-key",
            durability_description_value = "description.science-pack-remaining-amount-value"
        },
        {
            type = "recipe",
            name = "equipment-science-pack",
            enabled = false,
            energy_required = 10,
            ingredients = {
                { "battery-equipment", 1 },
                { "plastic-bar", 4 },
                { "stone-brick", 10 }
            },
            result_count = 2,
            result = "equipment-science-pack"
        },
        {
            type = "technology",
            name = "equipment-science-pack",
            icon_size = 256, icon_mipmaps = 4,
            icon = "__base__/graphics/technology/military-science-pack.png",
            effects = {
                {
                    type = "unlock-recipe",
                    recipe = "equipment-science-pack"
                }
            },
            unit = {
                count = 30,
                ingredients = {
                    { "automation-science-pack", 1 },
                    { "logistic-science-pack", 1 }
                },
                time = 15
            },
            prerequisites = { "battery-equipment" },
            order = "c-a"
        },
    })
end