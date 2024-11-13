-- Factorio requires at least one prototype of these entities and items to successfully load
data:extend{
    {
        type = "ammo-category",
        name = "pacifist-dummy-ammo-category",
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
        cannon_base_shift = {0.0, 0.0, 0.0},
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
        attack_parameters = {
            type = "projectile",
            range = 1.0,
            cooldown = 100,
            ammo_category = "pacifist-dummy-ammo-category",
        },
        stack_size = 1,
        icon = "__base__/graphics/icons/tank-cannon.png",
    },
    {
        type = "wall",
        name = "pacifist-dummy-wall",
        hidden = true,
    },
}