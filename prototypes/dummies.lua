require("__Pacifist__.config")

local dummy_spriteparams = {
    filename = "__base__/graphics/entity/gate/gate-vertical.png",
    size = 1,
}
local dummy_rotated_sprite = {
    direction_count = 1,
    filename = "__base__/graphics/entity/gate/gate-vertical.png",
    size = 1,
}
local dummy_attack_parameters = {
    type = "projectile",
    cooldown = 1,
    range = 1,
    ammo_type = { category = "bullet" },
    animation = dummy_rotated_sprite,
}

local dummy_gate = {
    type = "gate",
    name = "pacifist-dummy-gate",
    icon = "__base__/graphics/icons/gate.png",
    icon_size = 64,
    flags = { "hidden", "placeable-neutral", "placeable-player", "player-creation" },
    opening_speed = 0.0666666,
    activation_distance = 3,
    timeout_to_close = 5,
    vertical_animation = dummy_spriteparams,
    horizontal_animation = dummy_spriteparams,
    horizontal_rail_animation_left = dummy_spriteparams,
    horizontal_rail_animation_right = dummy_spriteparams,
    vertical_rail_animation_left = dummy_spriteparams,
    vertical_rail_animation_right = dummy_spriteparams,
    vertical_rail_base = dummy_spriteparams,
    horizontal_rail_base = dummy_spriteparams,
    wall_patch = dummy_spriteparams,
    open_sound = { filename = "__base__/sound/item-open.ogg", volume = 1 },
    close_sound = { filename = "__base__/sound/item-close.ogg", volume = 1 }
}
local dummy_wall = {
    type = "wall",
    name = "pacifist-dummy-wall",
    flags = { "hidden" },
    pictures = {
        single = dummy_spriteparams,
        straight_vertical = dummy_spriteparams,
        straight_horizontal = dummy_spriteparams,
        corner_right_down = dummy_spriteparams,
        corner_left_down = dummy_spriteparams,
        t_up = dummy_spriteparams,
        ending_right = dummy_spriteparams,
        ending_left = dummy_spriteparams,
    },
}
local dummy_energy_shield_equipment = {
    type = "energy-shield-equipment",
    name = "pacifist-dummy-energy-shield-equipment",
    flags = { "hidden" },
    sprite = dummy_spriteparams,
    shape = {
        width = 2,
        height = 2,
        type = "full"
    },
    max_shield_value = 50,
    energy_source = {
        usage_priority = "primary-input"
    },
    energy_per_shield = "20kJ",
    categories = { "armor" }
}
local dummy_shield_item = {
    type = "item",
    name = "pacifist-dummy-energy-shield-equipment",
    flags = { "hidden" },
    icon = "__base__/graphics/icons/energy-shield-equipment.png",
    icon_size = 64, icon_mipmaps = 4,
    stack_size = 1
}
local dummy_gun = {
    type = "gun",
    name = "pacifist-dummy-gun",
    icon = "__base__/graphics/icons/tank-cannon.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = { "hidden" },
    attack_parameters = dummy_attack_parameters,
    stack_size = 1
}
local dummy_ammo = {
    type = "ammo",
    name = "pacifist-dummy-ammo",
    flags = { "hidden" },
    icon = "__base__/graphics/icons/artillery-shell.png",
    icon_size = 64, icon_mipmaps = 4,
    ammo_type = {
        category = "artillery-shell",
    },
    stack_size = 1
}
local dummy_land_mine = {
    type = "land-mine",
    name = "pacifist-dummy-land-mine",
    icon = "__base__/graphics/icons/land-mine.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {
        "hidden",
        "placeable-player",
        "placeable-enemy",
        "player-creation",
        "placeable-off-grid",
        "not-on-map"
    },
    picture_safe = dummy_spriteparams,
    picture_set = dummy_spriteparams,
    trigger_radius = 1,
}
local dummy_artillery_turret = {
    type = "artillery-turret",
    name = "pacifist-dummy-artillery-turret",
    icon = "__base__/graphics/icons/artillery-turret.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = { "hidden", "placeable-neutral", "placeable-player", "player-creation" },
    inventory_size = 1,
    ammo_stack_limit = 1,
    automated_ammo_count = 1,
    gun = "pacifist-dummy-gun",
    turret_rotation_speed = 0.001,
    manual_range_modifier = 1,
}
local dummy_ammo_turret = {
    type = "ammo-turret",
    name = "pacifist-dummy-ammo-turret",
    icon = "__base__/graphics/icons/gun-turret.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = { "hidden", "placeable-player", "player-creation" },
    inventory_size = 1,
    automated_ammo_count = 1,
    folded_animation = dummy_rotated_sprite,
    attack_parameters = dummy_attack_parameters,
    call_for_help_radius = 1,
}
local dummy_electric_turret = {
    type = "electric-turret",
    name = "pacifist-dummy-electric-turret",
    icon = "__base__/graphics/icons/laser-turret.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = { "hidden", "placeable-player", "placeable-enemy", "player-creation" },
    energy_source = {
        type = "electric",
        usage_priority = "primary-input"
    },
    folded_animation = dummy_rotated_sprite,
    attack_parameters = {
        type = "beam",
        cooldown = 1,
        range = 1,
        ammo_type = {
            category = "laser",
        }
    },
    call_for_help_radius = 1,
}
local dummy_fluid_turret = {
    type = "fluid-turret",
    name = "pacifist-dummy-fluid-turret",
    icon = "__base__/graphics/icons/flamethrower-turret.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = { "hidden", "placeable-player", "player-creation" },
    turret_base_has_direction = true,
    fluid_box = {
        pipe_connections = {}
    },
    fluid_buffer_size = 1,
    fluid_buffer_input_flow = 1, -- 5s to fill the buffer
    activation_buffer_ratio = 1,
    folded_animation = dummy_rotated_sprite,
    attack_parameters = {
        type = "stream",
        cooldown = 1,
        range = 1,
        ammo_type = {
            category = "flamethrower",
        },
    },
    call_for_help_radius = 1
}
local dummy_artillery_wagon = {
    type = "artillery-wagon",
    name = "pacifist-dummy-artillery-wagon",
    icon = "__base__/graphics/icons/artillery-wagon.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = { "hidden", "placeable-neutral", "player-creation", "placeable-off-grid" },
    inventory_size = 1,
    ammo_stack_limit = 1,
    collision_box = { { -0.6, -2.4 }, { 0.6, 2.4 } },
    vertical_selection_shift = -0.796875,
    weight = 4000,
    max_speed = 1,
    braking_force = 3,
    friction_force = 0.50,
    air_resistance = 0.015,
    connection_distance = 3,
    joint_distance = 4,
    energy_per_hit_point = 1,
    gun = "pacifist-dummy-gun",
    turret_rotation_speed = 0.001,
    manual_range_modifier = 1,
    pictures = dummy_rotated_sprite,
}
local dummy_active_defense_equipment = {
    type = "active-defense-equipment",
    name = "pacifist-dummy-active-defense-equipment",
    sprite = dummy_spriteparams,
    shape = {
        width = 1,
        height = 1,
        type = "full"
    },
    energy_source = {
        type = "electric",
        usage_priority = "secondary-input",
    },
    attack_parameters = {
        type = "beam",
        cooldown = 1,
        range = 1,
        ammo_type = {
            category = "laser",
        }
    },
    automatic = true,
    categories = { "armor" }
}
local dummy_active_defense_item = {
    type = "item",
    name = "pacifist-dummy-active-defense-equipment",
    icon = "__base__/graphics/icons/personal-laser-defense-equipment.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = { "hidden" },
    stack_size = 1
}

local dummy_unit = {
    type = "unit",
    name = "pacifist-dummy-unit",
    icon = "__base__/graphics/icons/small-biter.png",
    icon_mipmaps = 4,
    icon_size = 64,
    flags = {
        "hidden",
        "placeable-player",
        "placeable-enemy",
        "placeable-off-grid",
        "not-repairable",
        "breaths-air"
    },
    attack_parameters = dummy_attack_parameters,
    run_animation = dummy_rotated_sprite,
    movement_speed = 0,
    distance_per_frame = 0,
    pollution_to_join_attack = 0,
    distraction_cooldown = 0,
    vision_distance = 0,
}

local dummy_unit_spawner = {
    type = "unit-spawner",
    name = "pacifist-dummy-unit-spawner",
    icon = "__base__/graphics/icons/biter-spawner.png",
    icon_mipmaps = 4,
    icon_size = 64,
    flags = {
        "hidden",
        "placeable-player",
        "placeable-enemy",
        "not-repairable"
    },
    animations = dummy_rotated_sprite,
    max_count_of_owned_units = 0,
    max_friends_around_to_spawn = 0,
    spawning_cooldown = {0, 0},
    spawning_radius = 0,
    spawning_spacing = 0,
    max_richness_for_spawn_shift = 0,
    max_spawn_shift = 0,
    pollution_absorption_absolute = 0,
    pollution_absorption_proportional = 0,
    call_for_help_radius = 0,
    result_units = {
        {
            "pacifist-dummy-unit",
            {
                {
                    0,
                    1
                }
            }
        }
    }
}

local dummy_turret = {
    type = "turret",
    name = "pacifist-dummy-turret",
    icon = "__base__/graphics/icons/small-worm.png",
    icon_mipmaps = 4,
    icon_size = 64,
    flags = {
        "hidden",
        "placeable-player",
        "placeable-enemy",
        "placeable-off-grid",
        "not-repairable",
        "breaths-air"
    },
    attack_parameters = dummy_attack_parameters,
    folded_animation = dummy_rotated_sprite,
    call_for_help_radius = 0
}

local dummy_beam = {
    type = "beam",
    name = "pacifist-dummy-beam",
    flags = { "hidden" },
    width = 0,
    damage_interval = 1,
    head = dummy_rotated_sprite,
    tail = dummy_rotated_sprite,
    body = dummy_rotated_sprite,
}

local dummy_combat_robot = {
    type = "combat-robot",
    name = "pacifist-dummy-combat-robot",
    flags = { "hidden" },
    attack_parameters = dummy_attack_parameters,
    time_to_live = 0,
    idle = dummy_rotated_sprite,
    shadow_idle = dummy_rotated_sprite,
    in_motion = dummy_rotated_sprite,
    shadow_in_motion = dummy_rotated_sprite,
    speed = 0,
}

local dummy_sticker = {
    type = "sticker",
    name = "pacifist-dummy-sticker",
    flags = { "hidden" },
    duration_in_ticks = 1,
}

local dummy_stream = {
    type = "stream",
    name = "pacifist-dummy-stream",
    flags = { "hidden" },
    particle_spawn_interval = 1,
    particle_horizontal_speed = 1,
    particle_horizontal_speed_deviation = 0,
    particle_vertical_acceleration = 0,
}

local dummy_artillery_flare = {
    type = "artillery-flare",
    name = "pacifist-dummy-artillery-flare",
    flags = { "hidden" },
    pictures = dummy_rotated_sprite,
    life_time = 0,
    map_color = { 0, 0, 0 },
}

local dummy_artillery_projectile = {
    type = "artillery-projectile",
    name = "pacifist-dummy-artillery-projectile",
    flags = { "hidden" },
    reveal_map = false,
    map_color = { 0, 0, 0 },
}


local dummies = {
    dummy_gun,
    dummy_ammo,
    dummy_land_mine,
    dummy_artillery_turret,
    dummy_ammo_turret,
    dummy_electric_turret,
    dummy_fluid_turret,
    dummy_artillery_wagon,
    dummy_active_defense_equipment,
    dummy_active_defense_item,
    dummy_unit,
    dummy_unit_spawner,
    dummy_turret,
    dummy_beam,
    dummy_stream,
    dummy_combat_robot,
    dummy_sticker,
    dummy_artillery_flare,
    dummy_artillery_projectile,
}

if PacifistMod.settings.remove_walls then
    table.insert(dummies, dummy_gate)
    table.insert(dummies, dummy_wall)
end

if PacifistMod.settings.remove_shields then
    table.insert(dummies, dummy_shield_item)
    table.insert(dummies, dummy_energy_shield_equipment)
end

return dummies