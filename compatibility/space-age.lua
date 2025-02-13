local array = require("__Pacifist__.lib.array") --[[@as Array]]
local simulations = require("__Pacifist__.simulations.tips-and-tricks") --[[@as {[string]:data.SimulationDefinition}]]

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
end

--- achievements that require enemies
local remove_achievements = function()
    data.raw["group-attack-achievement"]["it-stinks-and-they-do-like-it"] = nil
    data.raw["group-attack-achievement"]["get-off-my-lawn"] = nil
    data.raw["kill-achievement"]["if-it-bleeds"] = nil
    data.raw["kill-achievement"]["we-need-bigger-guns"] = nil
    data.raw["kill-achievement"]["size-doesnt-matter"] = nil
end

--- replace simulations that contain enemies and/or military tech
local fix_simulations = function()
    data.raw["tips-and-tricks-item"]["gleba-briefing"].simulation = simulations.gleba_briefing
end

--- make turrets only buildable on space platforms
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

--- move turrets and ammo to the "space" category
local modify_item_groups = function()
    data.raw["item-subgroup"]["turret"].group = "space"
    data.raw["item-subgroup"]["ammo"].group = "space"

    data.raw["item-subgroup"]["turret"].order = "j"
    data.raw["item-subgroup"]["ammo"].order = "k"
    data.raw["item-subgroup"]["planets"].order = "l"
    data.raw["item-subgroup"]["planet-connections"].order = "m"
end

--- rocket launchers should only shoot capture bots, so they get their own ammo category
local modify_capture_bot = function()
    data:extend(
        {
            {
                type = "ammo-category",
                name = "capture-robot",
                icon = "__space-age__/graphics/icons/capture-bot.png",
                subgroup = "ammo-category",
            },
            {
                type = "item-subgroup",
                name = "capture",
                group = "combat",
                order = "j"
            },
        }
    )

    local capture_bot = data.raw.ammo["capture-robot-rocket"]
    capture_bot.ammo_type.target_filter = { "biter-spawner" }
    capture_bot.ammo_category = "capture-robot"
    capture_bot.subgroup = "capture"

    local rocket_launcher = data.raw.gun["rocket-launcher"]
    rocket_launcher.attack_parameters.ammo_category = "capture-robot"
    rocket_launcher.subgroup = "capture"
end

---move the unlocks of given recipes to a different technology
---@param recipe_names data.RecipeID[]
---@param tech_name data.TechnologyID
local _move_recipe_unlocks = function(recipe_names, tech_name)
    local match = function(effect)
        return effect.type == "unlock-recipe" and array.contains(recipe_names, effect.recipe)
    end
    for _, tech in pairs(data.raw.technology) do
        array.remove_in_place(tech.effects, match)
    end

    local tech = data.raw.technology[tech_name]
    tech.effects = tech.effects or {}
    for _, recipe in pairs(recipe_names) do
        table.insert(tech.effects, {
            type = "unlock-recipe",
            recipe = recipe
        })
    end
end

--- gun turrets and their magazines only make sense after space science
--- technology prices should be updated accordingly
local update_projectile_defense = function()
    local gun_tech = data.raw.technology["gun-turret"]
    gun_tech.prerequisites = { "space-science-pack" }
    gun_tech.unit = {
        count = 200,
        ingredients =
        {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"military-science-pack", 1},
            {"space-science-pack", 1}
        },
        time = 30
    }

    data.raw["recipe"]["firearm-magazine"].enabled = false
    _move_recipe_unlocks({"piercing-rounds-magazine", "firearm-magazine"}, "gun-turret")
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
        entity = {
            "small-stomper-shell",
            "medium-stomper-shell",
            "big-stomper-shell",
        },
        main_menu_simulations = {
            "gleba_egg_escape",
            "vulcanus_crossing",
            "gleba_pentapod_ponds",
            "platform_messy_nuclear"
        },
    },
    preprocess = {
        temp_fixes,
        remove_achievements,
        fix_simulations,
        modify_item_groups,
        modify_turrets,
        modify_capture_bot,
        update_projectile_defense,
    },
}

return space_age_config