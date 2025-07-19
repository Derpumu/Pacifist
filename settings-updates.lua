local function force_setting(name, value)
    if data.raw["bool-setting"] and data.raw["bool-setting"][name] then
        local the_setting = data.raw["bool-setting"][name]
        the_setting.default_value = value
        the_setting.forced_value = value
        the_setting.hidden = true
        return
    end

    for _, type in pairs({"int-setting", "double-setting", "string-setting"}) do
        local category = data.raw[type] or {}
        local the_setting = category[name]
        if the_setting then
            the_setting.default_value = value
            the_setting.allowed_values = {value}
            the_setting.hidden = true
            return
        end
    end
end

if mods["blueprint-shotgun"] then
    -- blueprint shotgun's default recipe uses an actual shotgun, this setting changes that
    force_setting("blueprint-shotgun-no-wood", true)
    -- blueprint shotgun uses light armor for upgrades, see
    -- https://mods.factorio.com/mod/blueprint-shotgun/discussion/6875c40cb6a5fecc0184b970
    force_setting("pacifist-remove-armor", false)
end

if mods["factorioplus"] then
    -- everything but normal tries to add guns and more as loot at run time
    force_setting("settings-crashsite-bonus", "normal")
    -- these are removed anyway, so the actual value is not relevant
    force_setting("settings-chunks-probability", 0)
    force_setting("settings-chunks-multiplier", 1)
    force_setting("settings-enemy-health", "normal")
end

if mods["pyalienlife"] then
    force_setting("pacifist-remove-walls", false)
end
