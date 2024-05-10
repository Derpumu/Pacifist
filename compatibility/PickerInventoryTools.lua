-- PickerInventoryTools provides a shortcut and user input to toggle active defense equipment
-- the shortcut is unlocked by the active defense equipment technology that is removed by pacifist
-- removing the shortcut is not feasible as it is used in the event handler introduced by PickerInventoryTools
-- so, we add a new hidden dummy technology that can never be researched so the shortcut simply never is unlocked

local dummy_pack = {
    type = "tool",
    name = "pacifist-PickerInventoryTools-dummy-science-pack",
    icon = "__base__/graphics/icons/automation-science-pack.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "science-pack",
    order = "a[automation-science-pack]",
    stack_size = 200,
    durability = 1,
}

local dummy_technology = {
    type = "technology",
    name = "pacifist-PickerInventoryTools-dummy-tech",
    icon_size = 256, icon_mipmaps = 4,
    icon = "__base__/graphics/technology/automation-2.png",
    hidden = true,
    unit = {
        count = 4000000,
        ingredients = { { "pacifist-PickerInventoryTools-dummy-science-pack", 50 } },
        time = 15000
    },
    order = "z"
}

local function remove_active_defense_toggle()
    data:extend({dummy_technology, dummy_pack})
    data.raw["shortcut"]["toggle-active-defense-equipment"].technology_to_unlock = "pacifist-PickerInventoryTools-dummy-tech"
end

return {
    preprocess = { remove_active_defense_toggle }
}
