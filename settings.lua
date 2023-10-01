data:extend({
    {
        type = "bool-setting",
        name = "pacifist-remove-walls",
        order = "a",
        setting_type = "startup",
        default_value = true,
    },
    {
        type = "bool-setting",
        name = "pacifist-remove-shields",
        order = "b",
        setting_type = "startup",
        default_value = true,
    },
    {
        type = "string-setting",
        name = "pacifist-treat-science-packs",
        order = "c",
        setting_type = "startup",
        allowed_values = { "remove", "replace" },
        default_value = "remove",
    }
})