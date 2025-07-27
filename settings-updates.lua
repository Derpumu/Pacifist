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
end

if mods["pyalienlife"] then
    force_setting("pacifist-remove-walls", false)
end
