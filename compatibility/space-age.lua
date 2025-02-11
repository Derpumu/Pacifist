local array = require("__Pacifist__.lib.array") --[[@as Array]]

local remove_achievements = function()
    data.raw["group-attack-achievement"]["it-stinks-and-they-do-like-it"] = nil
    data.raw["group-attack-achievement"]["get-off-my-lawn"] = nil
end

local temp_fixes = function()
    if data.raw.item["captive-biter-spawner"] then
        data.raw.item["captive-biter-spawner"].spoil_to_trigger_result = nil
    end
    if data.raw.item["biter-egg"] then
        data.raw.item["biter-egg"].spoil_to_trigger_result = nil
    end
    if data.raw.item["pentapod-egg"] then
        data.raw.item["pentapod-egg"].spoil_to_trigger_result = nil
    end

    if data.raw["unit-spawner"]["biter-spawner"] then
        data.raw["unit-spawner"]["biter-spawner"].result_units = { {"pacifist-dummy-unit", {{0.0, 0.0}, {1.0, 0.0}}} }
    end

    if data.raw.ammo["capture-robot-rocket"] then
        data.raw.ammo["capture-robot-rocket"].ammo_type.target_filter = { "biter-spawner" }
    end
end

local modify_turrets = function()
    ---@type data.SurfaceCondition
    local platform_condition = { property = "gravity", min = 0, max = 0 }
    local turrets = {
        { type = "ammo-turret", name = "gun-turret" },
        { type = "electric-turret", name = "laser-turret" },
        { type = "ammo-turret", name = "rocket-turret" },
        { type = "ammo-turret", name = "railgun-turret" }
    }

    for _, t in pairs(turrets) do
        local turret = data.raw[t.type][t.name]
        local surface_conditions = turret.surface_conditions or {}
        table.insert(surface_conditions, platform_condition)
        turret.surface_conditions = surface_conditions
    end
end

local space_age_config = {
    exceptions = {
        ammo = {
            "firearm-magazine",
            "piercing-rounds-magazine",
            "rocket",
            "explosive-rocket",
            "railgun-ammo",
            "capture-robot-rocket",
        },
        ammo_category = {
            "bullet",
            "laser",
            "rocket",
            "railgun",
        },
        entity = {
            "gun-turret",
            "laser-turret",
            "rocket-turret",
            "railgun-turret",
            "biter-spawner",
        },
        gun = { "rocket-launcher" },
    },
    extra = {
        entity = { "small-stomper-shell", "medium-stomper-shell", "big-stomper-shell" },
        main_menu_simulations = { "gleba_egg_escape", "vulcanus_crossing", "gleba_pentapod_ponds", "platform_messy_nuclear" },
    },
    preprocess = { temp_fixes, remove_achievements, modify_turrets },
}

return space_age_config