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
        order = "m",
        setting_type = "startup",
        default_value = true,
    },
})

if mods["space-age"] then
    data:extend({
        {
            type = "bool-setting",
            name = "pacifist-remove-lasers",
            order = "e",
            setting_type = "startup",
            default_value = false,
        },
    })
end

if mods["factorioplus"] then
    data:extend({
        {
            type = "bool-setting",
            name = "pacifist-remove-character-health-bonus",
            order = "f",
            setting_type = "startup",
            default_value = true,
        },
    })
end

if mods["blueprint-shotgun"] then
    local no_shotgun_setting = data.raw["bool-setting"]["blueprint-shotgun-no-wood"]
    if no_shotgun_setting then
        no_shotgun_setting.default_value = true
        no_shotgun_setting.forced_value = true
        no_shotgun_setting.hidden = true
    end
end
