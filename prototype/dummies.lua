-- Factorio requires at least one prototype of these entities and items to successfully load

local attack_parameters = {
    type = "projectile",
    range = 1.0,
    cooldown = 100,
    ammo_category = "pacifist-dummy-ammo-category",
    ammo_type = {},
}

local stream_attack_parameters = {
    type = "stream",
    range = 1.0,
    cooldown = 100,
    ammo_category = "pacifist-dummy-ammo-category",
    ammo_type = {},
}


local dummy_spriteparams = {
    filename = "__base__/graphics/entity/gate/gate-vertical.png",
    size = 1,
}

local rotated_animation_8way = {
    north = dummy_spriteparams,
}

data:extend {
    {
        type = "ammo-category",
        name = "pacifist-dummy-ammo-category",
        hidden = true,
    },
    {
        type = "ammo-turret",
        name = "pacifist-dummy-ammo-turret",
        hidden = true,
        inventory_size = 1,
        automated_ammo_count = 1,
        attack_parameters = attack_parameters,
        folded_animation = rotated_animation_8way,
        call_for_help_radius = 1.0,
        graphics_set = {},
    },
    {
        type = "artillery-turret",
        name = "pacifist-dummy-artillery-turret",
        hidden = true,
        gun = "pacifist-dummy-gun",
        inventory_size = 1,
        ammo_stack_limit = 1,
        automated_ammo_count = 1,
        turret_rotation_speed = 1.0,
        manual_range_modifier = 1.0,
        cannon_base_shift = { 0.0, 0.0, 0.0 },
    },
    {
        type = "artillery-wagon",
        name = "pacifist-dummy-artillery-wagon",
        hidden = true,
        gun = "pacifist-dummy-gun",
        inventory_size = 1,
        ammo_stack_limit = 1,
        turret_rotation_speed = 1.0,
        manual_range_modifier = 1.0,
        max_speed = 1.0,
        air_resistance = 1.0,
        joint_distance = 4.0,
        connection_distance = 3.0,
        vertical_selection_shift = 1.0,
        weight = 1.0,
        braking_force = 1.0,
        friction = 1.0,
        energy_per_hit_point = 1.0,
        collision_box = { { -0.6, -2.4 }, { 0.6, 2.4 } },
    },
    {
        type = "combat-robot",
        name = "pacifist-dummy-combat-robot",
        hidden = true,
        time_to_live = 1,
        attack_parameters = attack_parameters,
        speed = 1.0,
    },
    {
        type = "electric-turret",
        name = "pacifist-dummy-electric-turret",
        hidden = true,
        attack_parameters = attack_parameters,
        call_for_help_radius = 1.0,
        energy_source = { type = "void" },
        folded_animation = rotated_animation_8way,
        graphics_set = {},
    },
    {
        type = "fluid-turret",
        name = "pacifist-dummy-fluid-turret",
        hidden = true,

        collision_box = { { -0.4, -0.4 }, { 0.4, 0.4 } },
        fluid_buffer_size = 1.0,
        fluid_buffer_input_flow = 1.0,
        activation_buffer_ratio = 0.5,
        fluid_box = {
            volume = 2.0,
            pipe_connections = {
                {
                    direction = defines.direction.north --[[@as data.Direction ]],
                    position = { 0.0, 0.0 },
                }
            },
        },
        attack_parameters = stream_attack_parameters,
        folded_animation = rotated_animation_8way,
        call_for_help_radius = 1.0,
        graphics_set = {},
        turret_base_has_direction = true,
    },
    {
        type = "gate",
        name = "pacifist-dummy-gate",
        hidden = true,
        activation_distance = 0.1,
        opening_speed = 0.1,
        timeout_to_close = 1,
    },
    {
        type = "gun",
        name = "pacifist-dummy-gun",
        hidden = true,
        attack_parameters = attack_parameters,
        stack_size = 1,
        icon = "__base__/graphics/icons/tank-cannon.png",
    },
    {
        type = "land-mine",
        name = "pacifist-dummy-land-mine",
        hidden = true,
        trigger_radius = 1.0,
    },
    {
        type = "turret",
        name = "pacifist-dummy-turret",
        hidden = true,
        attack_parameters = attack_parameters,
        call_for_help_radius = 1.0,
        folded_animation = rotated_animation_8way,
        graphics_set = {},
    },
    {
        type = "unit-spawner",
        name = "pacifist-dummy-unit-spawner",
        hidden = true,
        call_for_help_radius = 1.0,
        graphics_set = {},
        max_count_of_owned_units = 1,
        max_friends_around_to_spawn = 1,
        max_richness_for_spawn_shift = 1.0,
        max_spawn_shift = 1.0,
        result_units = { { spawn_points = { { 1.0, 1.0 } }, unit = "small-biter" } },
        spawning_cooldown = { 1.0, 1.0 },
        spawning_radius = 1.0,
        spawning_spacing = 1.0,
    },
    {
        type = "wall",
        name = "pacifist-dummy-wall",
        hidden = true,
    },
}
