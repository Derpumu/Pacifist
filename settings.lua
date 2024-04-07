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
        type = "bool-setting",
        name = "pacifist-remove-armor",
        order = "c",
        setting_type = "startup",
        default_value = true,
    },
    {
        type = "bool-setting",
        name = "pacifist-remove-tank",
        order = "d",
        setting_type = "startup",
        default_value = false,
    },
    {
        type = "bool-setting",
        name = "pacifist-remove-pollution",
        order = "e",
        setting_type = "startup",
        default_value = true,
    },
})

if mods["Krastorio2"] then
    local kr_peaceful_setting = data.raw["bool-setting"]["kr-peaceful-mode"]
    if kr_peaceful_setting then
        kr_peaceful_setting.default_value = true
        kr_peaceful_setting.forced_value = true
        kr_peaceful_setting.hidden = true
    end
end