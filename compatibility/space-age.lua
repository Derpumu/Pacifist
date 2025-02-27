local array = require("__Pacifist__.lib.array") --[[@as Array]]
local simulations = require("__Pacifist__.simulations.tips-and-tricks") --[[@as {[string]:data.SimulationDefinition}]]

local spawner_map_color = { r = 255, g = 0, b = 0 }


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
        { type = "ammo-turret",     name = "gun-turret" },
        { type = "electric-turret", name = "laser-turret" },
        { type = "ammo-turret",     name = "rocket-turret" },
        { type = "ammo-turret",     name = "railgun-turret" }
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


---returns a function that checks if the parameter and the reference are the same ingredient
---@param reference { [1]: string, [2]: integer }
---@return fun(ingredient: { [1]: string, [2]: integer }): boolean
local _match_ingredient = function(reference)
    return function(ingredient)
        return reference[1] == ingredient[1]
    end
end

---add any missing science pack ingredients from the reference to the tech
---@param tech data.TechnologyPrototype
---@param reference_ingredients { [1]: string, [2]: integer }[]
local _adjust_ingredients = function(tech, reference_ingredients)
    for _, reference in pairs(reference_ingredients) do
        if not array.any_of(tech.unit.ingredients, _match_ingredient(reference)) then
            table.insert(tech.unit.ingredients, table.deepcopy(reference))
        end
    end
end


---returns the typical tech ingredients for defense tech after space science.
---military science is left in for Pacifist main code to deal with
---@return ({ [1]: string, [2]: integer })[]
local tech_ingredients = function()
    return {
        { "automation-science-pack", 1 },
        { "logistic-science-pack",   1 },
        { "chemical-science-pack",   1 },
        { "military-science-pack",   1 },
        { "space-science-pack",      1 }
    }
end


--- gun turrets and their magazines only make sense after space science
--- technology prices should be updated accordingly
local update_projectile_defense_tech = function()
    local gun_tech = data.raw.technology["gun-turret"]
    gun_tech.prerequisites = { "space-science-pack" }
    gun_tech.unit = {
        count = 200,
        ingredients = tech_ingredients(),
        time = 30
    }

    local dmg_tech = function(n)
        return data.raw.technology["physical-projectile-damage-" .. tostring(n)]
    end
    dmg_tech(1).prerequisites = { "gun-turret" }
    for level = 1, 7 do
        _adjust_ingredients(dmg_tech(level), gun_tech.unit.ingredients)
        dmg_tech(level).icons = dmg_tech(1).icons -- no need to change icons between levels
    end

    local speed_tech = function(n)
        return data.raw.technology["weapon-shooting-speed-" .. tostring(n)]
    end
    speed_tech(1).prerequisites = { "gun-turret" }
    for level = 1, 6 do
        _adjust_ingredients(speed_tech(level), gun_tech.unit.ingredients)
        speed_tech(level).icons = speed_tech(1).icons -- no need to change icons between levels
    end

    _move_recipe_unlocks({ "piercing-rounds-magazine", "firearm-magazine" }, "gun-turret")
    -- remove the ability to craft magazines from the start
    data.raw["recipe"]["firearm-magazine"].enabled = false
end


--- laserturrets only make sense after space science
local update_laser_defense_tech = function()
    local laser_tech = data.raw.technology["laser-turret"]
    laser_tech.prerequisites = { "space-science-pack" }
    laser_tech.unit = {
        count = 200,
        ingredients = tech_ingredients(),
        time = 30
    }

    local dmg_tech = function(n)
        return data.raw.technology["laser-weapons-damage-" .. tostring(n)]
    end
    dmg_tech(1).prerequisites = { "laser-turret" }
    array.remove(dmg_tech(7).prerequisites, "space-science-pack")
    for level = 1, 7 do
        _adjust_ingredients(dmg_tech(level), laser_tech.unit.ingredients)
    end

    local speed_tech = function(n)
        return data.raw.technology["laser-shooting-speed-" .. tostring(n)]
    end
    speed_tech(1).prerequisites = { "laser-turret" }
    for level = 1, 7 do
        _adjust_ingredients(speed_tech(level), laser_tech.unit.ingredients)
    end
end


---rockets only make sense with rocket turrets
local update_rocket_defense_tech = function()
    _move_recipe_unlocks({ "rocket" }, "rocket-turret")

    local rocket_turret_tech = data.raw.technology["rocket-turret"]
    local explosive_rocket_tech = data.raw.technology["explosive-rocketry"]
    explosive_rocket_tech.prerequisites = { "rocket-turret" }

    local dmg_tech = function(n)
        return data.raw.technology["stronger-explosives-" .. tostring(n)]
    end

    -- avoid a prerequisite loop between rocket turret tech and stronger explosives
    array.remove(rocket_turret_tech.prerequisites, dmg_tech(2).name)
    dmg_tech(1).prerequisites = { "rocket-turret" }

    -- add rocket damage to levels 1 and 2 so the tree does not start at level 3
    table.insert(dmg_tech(1).effects, {
        type = "ammo-damage",
        ammo_category = "rocket",
        modifier = 0.1
    })
    table.insert(dmg_tech(2).effects, {
        type = "ammo-damage",
        ammo_category = "rocket",
        modifier = 0.2
    })

    for level = 1, 7 do
        _adjust_ingredients(dmg_tech(level), rocket_turret_tech.unit.ingredients)
    end
end

--- Pentapod eggs and egg rafts
local adapt_gleba = function()
    local egg = data.raw.item["pentapod-egg"]
    egg.spoil_to_trigger_result = nil
    egg.spoil_result = "spoilage"

    -- replace egg rafts with minable simple entities
    for _, name in pairs({"gleba-spawner", "gleba-spawner-small"}) do
        local egg_raft = data.raw["unit-spawner"][name]
        data.raw["unit-spawner"][name] = nil

        ---@type data.ItemPrototype[]
        local results = {}
        for _, loot_item in pairs(egg_raft.loot) do
            table.insert(results,
                {
                    type = "item",
                    name = loot_item.item,
                    amount_min = loot_item.count_min,
                    amount_max = loot_item.count_max
                })
        end
        egg_raft.loot = nil
        egg_raft.dying_trigger_effect = nil

        local new_raft = egg_raft --[[@as data.SimpleEntityPrototype]]
        new_raft.type = "simple-entity"
        new_raft.minable = {
            mining_time = 2,
            results = results
        }
        new_raft.map_color = spawner_map_color
        new_raft.animations = egg_raft.graphics_set.animations
        new_raft.subgroup = "trees"
        data:extend{new_raft}
    end
end


--- capture bot, biter spawners, biter captivity tech
local adapt_captivity = function()
    _move_recipe_unlocks({"rocket-launcher"}, "captivity")

    local biter_spawner = data.raw["unit-spawner"]["biter-spawner"]
    biter_spawner.loot = nil
    biter_spawner.spawn_decoration = nil
    biter_spawner.map_color = spawner_map_color
    biter_spawner.max_count_of_owned_units = 0
    biter_spawner.max_count_of_owned_defensive_units = 0
    biter_spawner.max_friends_around_to_spawn = 0
    biter_spawner.max_defensive_friends_around_to_spawn = 0
    biter_spawner.result_units = { { "pacifist-dummy-unit", { { 0.0, 0.0 } } } }

    local biter_egg = data.raw.item["biter-egg"]
    biter_egg.spoil_to_trigger_result = nil
    biter_egg.spoil_result = "spoilage"

    local captive_spawner = data.raw.item["captive-biter-spawner"]
    captive_spawner.spoil_to_trigger_result = nil
    captive_spawner.spoil_result = "spoilage"
end


-- CONFIG

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
            "rocket",
            "railgun",
        },
        entity = {
            "gun-turret",
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
        technology = {
            "military-2",  -- together with the grenade changes in base.lua we removed the only military effects
        }
    },
    preprocess = {
        remove_achievements,
        fix_simulations,
        modify_item_groups,
        modify_turrets,
        modify_capture_bot,
        update_projectile_defense_tech,
        update_rocket_defense_tech,
        adapt_gleba,
        adapt_captivity,
    },
}

if not settings.startup["pacifist-remove-lasers"].value then
    table.insert(space_age_config.exceptions.ammo_category, "laser")
    table.insert(space_age_config.exceptions.entity, "laser-turret")
    table.insert(space_age_config.preprocess, update_laser_defense_tech)
end

return space_age_config
