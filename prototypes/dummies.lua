require("__Pacifist__.config")

local dummy_gate = {
    type = "gate",
    name = "pacifist-dummy-gate",
    icon = "__base__/graphics/icons/gate.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = { "hidden", "placeable-neutral", "placeable-player", "player-creation" },
    fast_replaceable_group = "wall",
    max_health = 350,
    corpse = "gate-remnants",
    dying_explosion = "gate-explosion",
    collision_box = { { -0.29, -0.29 }, { 0.29, 0.29 } },
    selection_box = { { -0.5, -0.5 }, { 0.5, 0.5 } },
    opening_speed = 0.0666666,
    activation_distance = 3,
    timeout_to_close = 5,
    fadeout_interval = 15,
    resistances = {
        {
            type = "physical",
            decrease = 3,
            percent = 20
        },
        {
            type = "impact",
            decrease = 45,
            percent = 60
        },
        {
            type = "explosion",
            decrease = 10,
            percent = 30
        },
        {
            type = "fire",
            percent = 100
        },
        {
            type = "acid",
            percent = 80
        },
        {
            type = "laser",
            percent = 70
        }
    },
    vertical_animation = {
        layers = {
            {
                filename = "__base__/graphics/entity/gate/gate-vertical.png",
                line_length = 8,
                width = 38,
                height = 62,
                frame_count = 16,
                shift = util.by_pixel(0, -14),
                hr_version = {
                    filename = "__base__/graphics/entity/gate/hr-gate-vertical.png",
                    line_length = 8,
                    width = 78,
                    height = 120,
                    frame_count = 16,
                    shift = util.by_pixel(-1, -13),
                    scale = 0.5
                }
            },
            {
                filename = "__base__/graphics/entity/gate/gate-vertical-shadow.png",
                line_length = 8,
                width = 40,
                height = 54,
                frame_count = 16,
                shift = util.by_pixel(10, 8),
                draw_as_shadow = true,
                hr_version = {
                    filename = "__base__/graphics/entity/gate/hr-gate-vertical-shadow.png",
                    line_length = 8,
                    width = 82,
                    height = 104,
                    frame_count = 16,
                    shift = util.by_pixel(9, 9),
                    draw_as_shadow = true,
                    scale = 0.5
                }
            }
        }
    },
    horizontal_animation = {
        layers = {
            {
                filename = "__base__/graphics/entity/gate/gate-horizontal.png",
                line_length = 8,
                width = 34,
                height = 48,
                frame_count = 16,
                shift = util.by_pixel(0, -4),
                hr_version = {
                    filename = "__base__/graphics/entity/gate/hr-gate-horizontal.png",
                    line_length = 8,
                    width = 66,
                    height = 90,
                    frame_count = 16,
                    shift = util.by_pixel(0, -3),
                    scale = 0.5
                }
            },
            {
                filename = "__base__/graphics/entity/gate/gate-horizontal-shadow.png",
                line_length = 8,
                width = 62,
                height = 30,
                frame_count = 16,
                shift = util.by_pixel(12, 10),
                draw_as_shadow = true,
                hr_version = {
                    filename = "__base__/graphics/entity/gate/hr-gate-horizontal-shadow.png",
                    line_length = 8,
                    width = 122,
                    height = 60,
                    frame_count = 16,
                    shift = util.by_pixel(12, 10),
                    draw_as_shadow = true,
                    scale = 0.5
                }
            }
        }
    },
    horizontal_rail_animation_left = {
        layers = {
            {
                filename = "__base__/graphics/entity/gate/gate-rail-horizontal-left.png",
                line_length = 8,
                width = 34,
                height = 40,
                frame_count = 16,
                shift = util.by_pixel(0, -8),
                hr_version = {
                    filename = "__base__/graphics/entity/gate/hr-gate-rail-horizontal-left.png",
                    line_length = 8,
                    width = 66,
                    height = 74,
                    frame_count = 16,
                    shift = util.by_pixel(0, -7),
                    scale = 0.5
                }
            },
            {
                filename = "__base__/graphics/entity/gate/gate-rail-horizontal-shadow-left.png",
                line_length = 8,
                width = 62,
                height = 30,
                frame_count = 16,
                shift = util.by_pixel(12, 10),
                draw_as_shadow = true,
                hr_version = {
                    filename = "__base__/graphics/entity/gate/hr-gate-rail-horizontal-shadow-left.png",
                    line_length = 8,
                    width = 122,
                    height = 60,
                    frame_count = 16,
                    shift = util.by_pixel(12, 10),
                    draw_as_shadow = true,
                    scale = 0.5
                }
            }
        }
    },
    horizontal_rail_animation_right = {
        layers = {
            {
                filename = "__base__/graphics/entity/gate/gate-rail-horizontal-right.png",
                line_length = 8,
                width = 34,
                height = 40,
                frame_count = 16,
                shift = util.by_pixel(0, -8),
                hr_version = {
                    filename = "__base__/graphics/entity/gate/hr-gate-rail-horizontal-right.png",
                    line_length = 8,
                    width = 66,
                    height = 74,
                    frame_count = 16,
                    shift = util.by_pixel(0, -7),
                    scale = 0.5
                }
            },
            {
                filename = "__base__/graphics/entity/gate/gate-rail-horizontal-shadow-right.png",
                line_length = 8,
                width = 62,
                height = 30,
                frame_count = 16,
                shift = util.by_pixel(12, 10),
                draw_as_shadow = true,
                hr_version = {
                    filename = "__base__/graphics/entity/gate/hr-gate-rail-horizontal-shadow-right.png",
                    line_length = 8,
                    width = 122,
                    height = 58,
                    frame_count = 16,
                    shift = util.by_pixel(12, 11),
                    draw_as_shadow = true,
                    scale = 0.5
                }
            }
        }
    },
    vertical_rail_animation_left = {
        layers = {
            {
                filename = "__base__/graphics/entity/gate/gate-rail-vertical-left.png",
                line_length = 8,
                width = 22,
                height = 62,
                frame_count = 16,
                shift = util.by_pixel(0, -14),
                hr_version = {
                    filename = "__base__/graphics/entity/gate/hr-gate-rail-vertical-left.png",
                    line_length = 8,
                    width = 42,
                    height = 118,
                    frame_count = 16,
                    shift = util.by_pixel(0, -13),
                    scale = 0.5
                }
            },
            {
                filename = "__base__/graphics/entity/gate/gate-rail-vertical-shadow-left.png",
                line_length = 8,
                width = 44,
                height = 54,
                frame_count = 16,
                shift = util.by_pixel(8, 8),
                draw_as_shadow = true,
                hr_version = {
                    filename = "__base__/graphics/entity/gate/hr-gate-rail-vertical-shadow-left.png",
                    line_length = 8,
                    width = 82,
                    height = 104,
                    frame_count = 16,
                    shift = util.by_pixel(9, 9),
                    draw_as_shadow = true,
                    scale = 0.5
                }
            }
        }
    },
    vertical_rail_animation_right = {
        layers = {
            {
                filename = "__base__/graphics/entity/gate/gate-rail-vertical-right.png",
                line_length = 8,
                width = 22,
                height = 62,
                frame_count = 16,
                shift = util.by_pixel(0, -14),
                hr_version = {
                    filename = "__base__/graphics/entity/gate/hr-gate-rail-vertical-right.png",
                    line_length = 8,
                    width = 42,
                    height = 118,
                    frame_count = 16,
                    shift = util.by_pixel(0, -13),
                    scale = 0.5
                }
            },
            {
                filename = "__base__/graphics/entity/gate/gate-rail-vertical-shadow-right.png",
                line_length = 8,
                width = 44,
                height = 54,
                frame_count = 16,
                shift = util.by_pixel(8, 8),
                draw_as_shadow = true,
                hr_version = {
                    filename = "__base__/graphics/entity/gate/hr-gate-rail-vertical-shadow-right.png",
                    line_length = 8,
                    width = 82,
                    height = 104,
                    frame_count = 16,
                    shift = util.by_pixel(9, 9),
                    draw_as_shadow = true,
                    scale = 0.5
                }
            }
        }
    },
    vertical_rail_base = {
        filename = "__base__/graphics/entity/gate/gate-rail-base-vertical.png",
        line_length = 8,
        width = 68,
        height = 66,
        frame_count = 16,
        shift = util.by_pixel(0, 0),
        hr_version = {
            filename = "__base__/graphics/entity/gate/hr-gate-rail-base-vertical.png",
            line_length = 8,
            width = 138,
            height = 130,
            frame_count = 16,
            shift = util.by_pixel(-1, 0),
            scale = 0.5
        }
    },
    horizontal_rail_base = {
        filename = "__base__/graphics/entity/gate/gate-rail-base-horizontal.png",
        line_length = 8,
        width = 66,
        height = 54,
        frame_count = 16,
        shift = util.by_pixel(0, 2),
        hr_version = {
            filename = "__base__/graphics/entity/gate/hr-gate-rail-base-horizontal.png",
            line_length = 8,
            width = 130,
            height = 104,
            frame_count = 16,
            shift = util.by_pixel(0, 3),
            scale = 0.5
        }
    },
    wall_patch = {
        layers = {
            {
                filename = "__base__/graphics/entity/gate/gate-wall-patch.png",
                line_length = 8,
                width = 34,
                height = 48,
                frame_count = 16,
                shift = util.by_pixel(0, 12),
                hr_version = {
                    filename = "__base__/graphics/entity/gate/hr-gate-wall-patch.png",
                    line_length = 8,
                    width = 70,
                    height = 94,
                    frame_count = 16,
                    shift = util.by_pixel(-1, 13),
                    scale = 0.5
                }
            },
            {
                filename = "__base__/graphics/entity/gate/gate-wall-patch-shadow.png",
                line_length = 8,
                width = 44,
                height = 38,
                frame_count = 16,
                shift = util.by_pixel(8, 32),
                draw_as_shadow = true,
                hr_version = {
                    filename = "__base__/graphics/entity/gate/hr-gate-wall-patch-shadow.png",
                    line_length = 8,
                    width = 82,
                    height = 72,
                    frame_count = 16,
                    shift = util.by_pixel(9, 33),
                    draw_as_shadow = true,
                    scale = 0.5
                }
            }
        }
    },
    open_sound = { filename = "__base__/sound/item-open.ogg", volume = 1 },
    close_sound = { filename = "__base__/sound/item-close.ogg", volume = 1 }
}
local dummy_wall = {
    type = "wall",
    name = "pacifist-dummy-wall",
    icon = "__base__/graphics/icons/wall.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = { "hidden", "placeable-neutral", "player-creation" },
    collision_box = { { -0.29, -0.29 }, { 0.29, 0.29 } },
    selection_box = { { -0.5, -0.5 }, { 0.5, 0.5 } },
    fast_replaceable_group = "wall",
    max_health = 350,
    repair_speed_modifier = 2,
    corpse = "wall-remnants",
    dying_explosion = "wall-explosion",
    connected_gate_visualization = {
        filename = "__core__/graphics/arrows/underground-lines.png",
        priority = "high",
        width = 64,
        height = 64,
        scale = 0.5
    },
    resistances = {
        {
            type = "physical",
            decrease = 3,
            percent = 20
        },
        {
            type = "impact",
            decrease = 45,
            percent = 60
        },
        {
            type = "explosion",
            decrease = 10,
            percent = 30
        },
        {
            type = "fire",
            percent = 100
        },
        {
            type = "acid",
            percent = 80
        },
        {
            type = "laser",
            percent = 70
        }
    },
    visual_merge_group = 0, -- different walls will visually connect to each other if their merge group is same (defaults to 0)
    pictures = {
        single = {
            layers = {
                {
                    filename = "__base__/graphics/entity/wall/wall-single.png",
                    priority = "extra-high",
                    width = 32,
                    height = 46,
                    variation_count = 2,
                    line_length = 2,
                    shift = util.by_pixel(0, -6),
                    hr_version = {
                        filename = "__base__/graphics/entity/wall/hr-wall-single.png",
                        priority = "extra-high",
                        width = 64,
                        height = 86,
                        variation_count = 2,
                        line_length = 2,
                        shift = util.by_pixel(0, -5),
                        scale = 0.5
                    }
                },
                {
                    filename = "__base__/graphics/entity/wall/wall-single-shadow.png",
                    priority = "extra-high",
                    width = 50,
                    height = 32,
                    repeat_count = 2,
                    shift = util.by_pixel(10, 16),
                    draw_as_shadow = true,
                    hr_version = {
                        filename = "__base__/graphics/entity/wall/hr-wall-single-shadow.png",
                        priority = "extra-high",
                        width = 98,
                        height = 60,
                        repeat_count = 2,
                        shift = util.by_pixel(10, 17),
                        draw_as_shadow = true,
                        scale = 0.5
                    }
                }
            }
        },
        straight_vertical = {
            layers = {
                {
                    filename = "__base__/graphics/entity/wall/wall-vertical.png",
                    priority = "extra-high",
                    width = 32,
                    height = 68,
                    variation_count = 5,
                    line_length = 5,
                    shift = util.by_pixel(0, 8),
                    hr_version = {
                        filename = "__base__/graphics/entity/wall/hr-wall-vertical.png",
                        priority = "extra-high",
                        width = 64,
                        height = 134,
                        variation_count = 5,
                        line_length = 5,
                        shift = util.by_pixel(0, 8),
                        scale = 0.5
                    }
                },
                {
                    filename = "__base__/graphics/entity/wall/wall-vertical-shadow.png",
                    priority = "extra-high",
                    width = 50,
                    height = 58,
                    repeat_count = 5,
                    shift = util.by_pixel(10, 28),
                    draw_as_shadow = true,
                    hr_version = {
                        filename = "__base__/graphics/entity/wall/hr-wall-vertical-shadow.png",
                        priority = "extra-high",
                        width = 98,
                        height = 110,
                        repeat_count = 5,
                        shift = util.by_pixel(10, 29),
                        draw_as_shadow = true,
                        scale = 0.5
                    }
                }
            }
        },
        straight_horizontal = {
            layers = {
                {
                    filename = "__base__/graphics/entity/wall/wall-horizontal.png",
                    priority = "extra-high",
                    width = 32,
                    height = 50,
                    variation_count = 6,
                    line_length = 6,
                    shift = util.by_pixel(0, -4),
                    hr_version = {
                        filename = "__base__/graphics/entity/wall/hr-wall-horizontal.png",
                        priority = "extra-high",
                        width = 64,
                        height = 92,
                        variation_count = 6,
                        line_length = 6,
                        shift = util.by_pixel(0, -2),
                        scale = 0.5
                    }
                },
                {
                    filename = "__base__/graphics/entity/wall/wall-horizontal-shadow.png",
                    priority = "extra-high",
                    width = 62,
                    height = 36,
                    repeat_count = 6,
                    shift = util.by_pixel(14, 14),
                    draw_as_shadow = true,
                    hr_version = {
                        filename = "__base__/graphics/entity/wall/hr-wall-horizontal-shadow.png",
                        priority = "extra-high",
                        width = 124,
                        height = 68,
                        repeat_count = 6,
                        shift = util.by_pixel(14, 15),
                        draw_as_shadow = true,
                        scale = 0.5
                    }
                }
            }
        },
        corner_right_down = {
            layers = {
                {
                    filename = "__base__/graphics/entity/wall/wall-corner-right.png",
                    priority = "extra-high",
                    width = 32,
                    height = 64,
                    variation_count = 2,
                    line_length = 2,
                    shift = util.by_pixel(0, 6),
                    hr_version = {
                        filename = "__base__/graphics/entity/wall/hr-wall-corner-right.png",
                        priority = "extra-high",
                        width = 64,
                        height = 128,
                        variation_count = 2,
                        line_length = 2,
                        shift = util.by_pixel(0, 7),
                        scale = 0.5
                    }
                },
                {
                    filename = "__base__/graphics/entity/wall/wall-corner-right-shadow.png",
                    priority = "extra-high",
                    width = 62,
                    height = 60,
                    repeat_count = 2,
                    shift = util.by_pixel(14, 28),
                    draw_as_shadow = true,
                    hr_version = {
                        filename = "__base__/graphics/entity/wall/hr-wall-corner-right-shadow.png",
                        priority = "extra-high",
                        width = 124,
                        height = 120,
                        repeat_count = 2,
                        shift = util.by_pixel(17, 28),
                        draw_as_shadow = true,
                        scale = 0.5
                    }
                }
            }
        },
        corner_left_down = {
            layers = {
                {
                    filename = "__base__/graphics/entity/wall/wall-corner-left.png",
                    priority = "extra-high",
                    width = 32,
                    height = 68,
                    variation_count = 2,
                    line_length = 2,
                    shift = util.by_pixel(0, 6),
                    hr_version = {
                        filename = "__base__/graphics/entity/wall/hr-wall-corner-left.png",
                        priority = "extra-high",
                        width = 64,
                        height = 134,
                        variation_count = 2,
                        line_length = 2,
                        shift = util.by_pixel(0, 7),
                        scale = 0.5
                    }
                },
                {
                    filename = "__base__/graphics/entity/wall/wall-corner-left-shadow.png",
                    priority = "extra-high",
                    width = 54,
                    height = 60,
                    repeat_count = 2,
                    shift = util.by_pixel(8, 28),
                    draw_as_shadow = true,
                    hr_version = {
                        filename = "__base__/graphics/entity/wall/hr-wall-corner-left-shadow.png",
                        priority = "extra-high",
                        width = 102,
                        height = 120,
                        repeat_count = 2,
                        shift = util.by_pixel(9, 28),
                        draw_as_shadow = true,
                        scale = 0.5
                    }
                }
            }
        },
        t_up = {
            layers = {
                {
                    filename = "__base__/graphics/entity/wall/wall-t.png",
                    priority = "extra-high",
                    width = 32,
                    height = 68,
                    variation_count = 4,
                    line_length = 4,
                    shift = util.by_pixel(0, 6),
                    hr_version = {
                        filename = "__base__/graphics/entity/wall/hr-wall-t.png",
                        priority = "extra-high",
                        width = 64,
                        height = 134,
                        variation_count = 4,
                        line_length = 4,
                        shift = util.by_pixel(0, 7),
                        scale = 0.5
                    }
                },
                {
                    filename = "__base__/graphics/entity/wall/wall-t-shadow.png",
                    priority = "extra-high",
                    width = 62,
                    height = 60,
                    repeat_count = 4,
                    shift = util.by_pixel(14, 28),
                    draw_as_shadow = true,
                    hr_version = {
                        filename = "__base__/graphics/entity/wall/hr-wall-t-shadow.png",
                        priority = "extra-high",
                        width = 124,
                        height = 120,
                        repeat_count = 4,
                        shift = util.by_pixel(14, 28),
                        draw_as_shadow = true,
                        scale = 0.5
                    }
                }
            }
        },
        ending_right = {
            layers = {
                {
                    filename = "__base__/graphics/entity/wall/wall-ending-right.png",
                    priority = "extra-high",
                    width = 32,
                    height = 48,
                    variation_count = 2,
                    line_length = 2,
                    shift = util.by_pixel(0, -4),
                    hr_version = {
                        filename = "__base__/graphics/entity/wall/hr-wall-ending-right.png",
                        priority = "extra-high",
                        width = 64,
                        height = 92,
                        variation_count = 2,
                        line_length = 2,
                        shift = util.by_pixel(0, -3),
                        scale = 0.5
                    }
                },
                {
                    filename = "__base__/graphics/entity/wall/wall-ending-right-shadow.png",
                    priority = "extra-high",
                    width = 62,
                    height = 36,
                    repeat_count = 2,
                    shift = util.by_pixel(14, 14),
                    draw_as_shadow = true,
                    hr_version = {
                        filename = "__base__/graphics/entity/wall/hr-wall-ending-right-shadow.png",
                        priority = "extra-high",
                        width = 124,
                        height = 68,
                        repeat_count = 2,
                        shift = util.by_pixel(17, 15),
                        draw_as_shadow = true,
                        scale = 0.5
                    }
                }
            }
        },
        ending_left = {
            layers = {
                {
                    filename = "__base__/graphics/entity/wall/wall-ending-left.png",
                    priority = "extra-high",
                    width = 32,
                    height = 48,
                    variation_count = 2,
                    line_length = 2,
                    shift = util.by_pixel(0, -4),
                    hr_version = {
                        filename = "__base__/graphics/entity/wall/hr-wall-ending-left.png",
                        priority = "extra-high",
                        width = 64,
                        height = 92,
                        variation_count = 2,
                        line_length = 2,
                        shift = util.by_pixel(0, -3),
                        scale = 0.5
                    }
                },
                {
                    filename = "__base__/graphics/entity/wall/wall-ending-left-shadow.png",
                    priority = "extra-high",
                    width = 54,
                    height = 36,
                    repeat_count = 2,
                    shift = util.by_pixel(8, 14),
                    draw_as_shadow = true,
                    hr_version = {
                        filename = "__base__/graphics/entity/wall/hr-wall-ending-left-shadow.png",
                        priority = "extra-high",
                        width = 102,
                        height = 68,
                        repeat_count = 2,
                        shift = util.by_pixel(9, 15),
                        draw_as_shadow = true,
                        scale = 0.5
                    }
                }
            }
        },
        filling = {
            filename = "__base__/graphics/entity/wall/wall-filling.png",
            priority = "extra-high",
            width = 24,
            height = 30,
            variation_count = 8,
            line_length = 8,
            shift = util.by_pixel(0, -2),
            hr_version = {
                filename = "__base__/graphics/entity/wall/hr-wall-filling.png",
                priority = "extra-high",
                width = 48,
                height = 56,
                variation_count = 8,
                line_length = 8,
                shift = util.by_pixel(0, -1),
                scale = 0.5
            }
        },
        water_connection_patch = {
            sheets = {
                {
                    filename = "__base__/graphics/entity/wall/wall-patch.png",
                    priority = "extra-high",
                    width = 58,
                    height = 64,
                    shift = util.by_pixel(0, -2),
                    hr_version = {
                        filename = "__base__/graphics/entity/wall/hr-wall-patch.png",
                        priority = "extra-high",
                        width = 116,
                        height = 128,
                        shift = util.by_pixel(0, -2),
                        scale = 0.5
                    }
                },
                {
                    filename = "__base__/graphics/entity/wall/wall-patch-shadow.png",
                    priority = "extra-high",
                    width = 74,
                    height = 52,
                    shift = util.by_pixel(8, 14),
                    draw_as_shadow = true,
                    hr_version = {
                        filename = "__base__/graphics/entity/wall/hr-wall-patch-shadow.png",
                        priority = "extra-high",
                        width = 144,
                        height = 100,
                        shift = util.by_pixel(9, 15),
                        draw_as_shadow = true,
                        scale = 0.5
                    }
                }
            }
        },
        gate_connection_patch = {
            sheets = {
                {
                    filename = "__base__/graphics/entity/wall/wall-gate.png",
                    priority = "extra-high",
                    width = 42,
                    height = 56,
                    shift = util.by_pixel(0, -8),
                    hr_version = {
                        filename = "__base__/graphics/entity/wall/hr-wall-gate.png",
                        priority = "extra-high",
                        width = 82,
                        height = 108,
                        shift = util.by_pixel(0, -7),
                        scale = 0.5
                    }
                },
                {
                    filename = "__base__/graphics/entity/wall/wall-gate-shadow.png",
                    priority = "extra-high",
                    width = 66,
                    height = 40,
                    shift = util.by_pixel(14, 18),
                    draw_as_shadow = true,
                    hr_version = {
                        filename = "__base__/graphics/entity/wall/hr-wall-gate-shadow.png",
                        priority = "extra-high",
                        width = 130,
                        height = 78,
                        shift = util.by_pixel(14, 18),
                        draw_as_shadow = true,
                        scale = 0.5
                    }
                }
            }
        }
    },

    wall_diode_green = {
        sheet = {
            filename = "__base__/graphics/entity/wall/wall-diode-green.png",
            priority = "extra-high",
            width = 38,
            height = 24,
            draw_as_glow = true,
            --frames = 4, -- this is optional, it will default to 4 for Sprite4Way
            shift = util.by_pixel(-2, -24),
            hr_version = {
                filename = "__base__/graphics/entity/wall/hr-wall-diode-green.png",
                priority = "extra-high",
                width = 72,
                height = 44,
                draw_as_glow = true,
                --frames = 4,
                shift = util.by_pixel(-1, -23),
                scale = 0.5
            }
        }
    },
    wall_diode_green_light_top = {
        minimum_darkness = 0.3,
        color = { g = 1 },
        shift = util.by_pixel(0, -30),
        size = 1,
        intensity = 0.2
    },
    wall_diode_green_light_right = {
        minimum_darkness = 0.3,
        color = { g = 1 },
        shift = util.by_pixel(12, -23),
        size = 1,
        intensity = 0.2
    },
    wall_diode_green_light_bottom = {
        minimum_darkness = 0.3,
        color = { g = 1 },
        shift = util.by_pixel(0, -17),
        size = 1,
        intensity = 0.2
    },
    wall_diode_green_light_left = {
        minimum_darkness = 0.3,
        color = { g = 1 },
        shift = util.by_pixel(-12, -23),
        size = 1,
        intensity = 0.2
    },

    wall_diode_red = {
        sheet = {
            filename = "__base__/graphics/entity/wall/wall-diode-red.png",
            priority = "extra-high",
            width = 38,
            height = 24,
            draw_as_glow = true,
            --frames = 4, -- this is optional, it will default to 4 for Sprite4Way
            shift = util.by_pixel(-2, -24),
            hr_version = {
                filename = "__base__/graphics/entity/wall/hr-wall-diode-red.png",
                priority = "extra-high",
                width = 72,
                height = 44,
                draw_as_glow = true,
                --frames = 4,
                shift = util.by_pixel(-1, -23),
                scale = 0.5
            }
        }
    },
    wall_diode_red_light_top = {
        minimum_darkness = 0.3,
        color = { r = 1 },
        shift = util.by_pixel(0, -30),
        size = 1,
        intensity = 0.2
    },
    wall_diode_red_light_right = {
        minimum_darkness = 0.3,
        color = { r = 1 },
        shift = util.by_pixel(12, -23),
        size = 1,
        intensity = 0.2
    },
    wall_diode_red_light_bottom = {
        minimum_darkness = 0.3,
        color = { r = 1 },
        shift = util.by_pixel(0, -17),
        size = 1,
        intensity = 0.2
    },
    wall_diode_red_light_left = {
        minimum_darkness = 0.3,
        color = { r = 1 },
        shift = util.by_pixel(-12, -23),
        size = 1,
        intensity = 0.2
    },

    circuit_wire_connection_point = circuit_connector_definitions["gate"].points,
    circuit_connector_sprites = circuit_connector_definitions["gate"].sprites,
    circuit_wire_max_distance = default_circuit_wire_max_distance,
    default_output_signal = { type = "virtual", name = "signal-G" }
}
local dummy_shield_equipment = {
    type = "energy-shield-equipment",
    name = "pacifist-dummy-energy-shield-equipment",
    flags = { "hidden" },
    sprite = {
        filename = "__base__/graphics/equipment/energy-shield-equipment.png",
        width = 64,
        height = 64,
        priority = "medium",
        hr_version = {
            filename = "__base__/graphics/equipment/hr-energy-shield-equipment.png",
            width = 128,
            height = 128,
            priority = "medium",
            scale = 0.5
        }
    },
    shape = {
        width = 2,
        height = 2,
        type = "full"
    },
    max_shield_value = 50,
    energy_source = {
        type = "electric",
        buffer_capacity = "120kJ",
        input_flow_limit = "240kW",
        usage_priority = "primary-input"
    },
    energy_per_shield = "20kJ",
    categories = { "armor" }
}
local dummy_shield_item =   {
    type = "item",
    name = "pacifist-dummy-energy-shield-equipment",
    flags = { "hidden" },
    icon = "__base__/graphics/icons/energy-shield-equipment.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "military-equipment",
    order = "a[shield]-a[energy-shield-equipment]",
    default_request_amount = 5,
    stack_size = 20
  }



local dummies = {
    {
        type = "gun",
        name = "pacifist-dummy-gun",
        icon = "__base__/graphics/icons/tank-cannon.png",
        icon_size = 64, icon_mipmaps = 4,
        flags = { "hidden" },
        subgroup = "gun",
        order = "z[artillery]-a[cannon]",
        attack_parameters = {
            type = "projectile",
            ammo_category = "artillery-shell",
            cooldown = 200,
            movement_slow_down_factor = 0,
            projectile_creation_distance = 1.6,
            projectile_center = { -0.15625, -0.07812 },
            range = 7 * 32,
            min_range = 1 * 32,
            sound = {
                switch_vibration_data = {
                    filename = "__base__/sound/fight/artillery-shoots.bnvib",
                    play_for = "everything"
                },
                game_controller_vibration_data = {
                    low_frequency_vibration_intensity = 1,
                    duration = 150,
                    play_for = "everything"
                },
                variations = {
                    filename = "__base__/sound/fight/artillery-shoots-1.ogg",
                    volume = 0.7
                }
            },
            shell_particle = {
                name = "artillery-shell-particle",
                direction_deviation = 0.05,
                direction = 0.4,
                speed = 0.10,
                speed_deviation = 0.1,
                vertical_speed = 0.05,
                vertical_speed_deviation = 0.01,
                center = { 0, -0.5 },
                creation_distance = 0.5,
                creation_distance_orientation = 0.4,
                starting_frame_speed = 0.5,
                starting_frame_speed_deviation = 0.5,
                use_source_position = true,
                height = 1
            }
        },
        stack_size = 1
    },
    {
        type = "ammo",
        name = "pacifist-dummy-ammo",
        flags = { "hidden" },
        icon = "__base__/graphics/icons/artillery-shell.png",
        icon_size = 64, icon_mipmaps = 4,
        ammo_type = {
            category = "artillery-shell",
            target_type = "position",
            action = {
                type = "direct",
                action_delivery = {
                    type = "artillery",
                    projectile = "artillery-projectile",
                    starting_speed = 1,
                    direction_deviation = 0,
                    range_deviation = 0,
                    source_effects = {
                        type = "create-explosion",
                        entity_name = "artillery-cannon-muzzle-flash"
                    }
                }
            }
        },
        subgroup = "ammo",
        order = "d[explosive-cannon-shell]-d[artillery]",
        stack_size = 1
    },
    {
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
        max_health = 15,
        corpse = "land-mine-remnants",
        dying_explosion = "land-mine-explosion",
        collision_box = { { -0.4, -0.4 }, { 0.4, 0.4 } },
        selection_box = { { -0.5, -0.5 }, { 0.5, 0.5 } },
        picture_safe = {
            filename = "__base__/graphics/entity/land-mine/hr-land-mine.png",
            priority = "medium",
            width = 64,
            height = 64,
            scale = 0.5
        },
        picture_set = {
            filename = "__base__/graphics/entity/land-mine/hr-land-mine-set.png",
            priority = "medium",
            width = 64,
            height = 64,
            scale = 0.5
        },
        picture_set_enemy = {
            filename = "__base__/graphics/entity/land-mine/land-mine-set-enemy.png",
            priority = "medium",
            width = 32,
            height = 32
        },
        trigger_radius = 2.5,
        ammo_category = "landmine",
        action = {
            type = "direct",
            action_delivery = {
                type = "instant",
                source_effects = {
                    {
                        type = "nested-result",
                        affects_target = true,
                        action = {
                            type = "area",
                            radius = 6,
                            force = "enemy",
                            action_delivery = {
                                type = "instant",
                                target_effects = {
                                    {
                                        type = "damage",
                                        damage = { amount = 250, type = "explosion" }
                                    },
                                    {
                                        type = "create-sticker",
                                        sticker = "stun-sticker"
                                    }
                                }
                            }
                        }
                    },
                    {
                        type = "create-entity",
                        entity_name = "explosion"
                    },
                    {
                        type = "damage",
                        damage = { amount = 1000, type = "explosion" }
                    }
                }
            }
        }
    },
    {
        type = "artillery-turret",
        name = "pacifist-dummy-artillery-turret",
        icon = "__base__/graphics/icons/artillery-turret.png",
        icon_size = 64, icon_mipmaps = 4,
        flags = { "hidden", "placeable-neutral", "placeable-player", "player-creation" },
        inventory_size = 1,
        ammo_stack_limit = 15,
        automated_ammo_count = 5,
        alert_when_attacking = false,
        rotating_sound = { sound = { filename = "__base__/sound/fight/artillery-rotation-loop.ogg", volume = 0.6 } },
        rotating_stopped_sound = { filename = "__base__/sound/fight/artillery-rotation-stop.ogg" },
        max_health = 2000,
        corpse = "artillery-turret-remnants",
        dying_explosion = "artillery-turret-explosion",
        collision_box = { { -1.2, -1.2 }, { 1.2, 1.2 } },
        selection_box = { { -1.5, -1.5 }, { 1.5, 1.5 } },
        drawing_box = { { -1.5, -5 }, { 1.5, 1.5 } },
        gun = "pacifist-dummy-gun",
        turret_rotation_speed = 0.001,
        turn_after_shooting_cooldown = 60,
        cannon_parking_frame_count = 8,
        cannon_parking_speed = 0.25,
        manual_range_modifier = 2.5,
        resistances = {
            {
                type = "fire",
                decrease = 15,
                percent = 50
            },
            {
                type = "physical",
                decrease = 15,
                percent = 30
            },
            {
                type = "impact",
                decrease = 50,
                percent = 50
            },
            {
                type = "explosion",
                decrease = 15,
                percent = 30
            },
            {
                type = "acid",
                decrease = 3,
                percent = 20
            }
        },

        base_shift = util.by_pixel(0, -22),

        base_picture_render_layer = "lower-object-above-shadow",

        base_picture = {
            layers = {
                {
                    filename = "__base__/graphics/entity/artillery-turret/artillery-turret-base.png",
                    priority = "high",
                    width = 104,
                    height = 100,
                    direction_count = 1,
                    frame_count = 1,
                    shift = util.by_pixel(-0, 22),
                    hr_version = {
                        filename = "__base__/graphics/entity/artillery-turret/hr-artillery-turret-base.png",
                        priority = "high",
                        line_length = 1,
                        width = 207,
                        height = 199,
                        frame_count = 1,
                        direction_count = 1,
                        shift = util.by_pixel(-0, 22),
                        scale = 0.5
                    }
                },
                {
                    filename = "__base__/graphics/entity/artillery-turret/artillery-turret-base-shadow.png",
                    priority = "high",
                    line_length = 1,
                    width = 138,
                    height = 75,
                    frame_count = 1,
                    direction_count = 1,
                    shift = util.by_pixel(18, 38),
                    draw_as_shadow = true,
                    hr_version = {
                        filename = "__base__/graphics/entity/artillery-turret/hr-artillery-turret-base-shadow.png",
                        priority = "high",
                        line_length = 1,
                        width = 277,
                        height = 149,
                        frame_count = 1,
                        direction_count = 1,
                        shift = util.by_pixel(18, 38),
                        draw_as_shadow = true,
                        scale = 0.5
                    }
                }
            }
        },

        cannon_barrel_pictures = {
            layers = {
                {
                    priority = "very-low",
                    width = 266,
                    height = 192,
                    direction_count = 256,
                    line_length = 4,
                    lines_per_file = 4,
                    shift = util.by_pixel(0, -56),
                    filenames = {
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-cannon-barrel-1.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-cannon-barrel-2.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-cannon-barrel-3.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-cannon-barrel-4.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-cannon-barrel-5.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-cannon-barrel-6.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-cannon-barrel-7.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-cannon-barrel-8.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-cannon-barrel-9.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-cannon-barrel-10.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-cannon-barrel-11.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-cannon-barrel-12.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-cannon-barrel-13.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-cannon-barrel-14.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-cannon-barrel-15.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-cannon-barrel-16.png"
                    },
                    hr_version = {
                        priority = "very-low",
                        width = 530,
                        height = 384,
                        direction_count = 256,
                        line_length = 4,
                        lines_per_file = 4,
                        shift = util.by_pixel(0, -56),
                        scale = 0.5,
                        filenames = {
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-cannon-barrel-1.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-cannon-barrel-2.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-cannon-barrel-3.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-cannon-barrel-4.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-cannon-barrel-5.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-cannon-barrel-6.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-cannon-barrel-7.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-cannon-barrel-8.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-cannon-barrel-9.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-cannon-barrel-10.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-cannon-barrel-11.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-cannon-barrel-12.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-cannon-barrel-13.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-cannon-barrel-14.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-cannon-barrel-15.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-cannon-barrel-16.png"
                        }
                    }
                },
                {
                    priority = "very-low",
                    width = 454,
                    height = 314,
                    direction_count = 256,
                    line_length = 4,
                    lines_per_file = 4,
                    shift = util.by_pixel(-3 + 58, 8 + 46),
                    draw_as_shadow = true,
                    filenames = {
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-cannon-barrel-shadow-1.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-cannon-barrel-shadow-2.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-cannon-barrel-shadow-3.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-cannon-barrel-shadow-4.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-cannon-barrel-shadow-5.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-cannon-barrel-shadow-6.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-cannon-barrel-shadow-7.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-cannon-barrel-shadow-8.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-cannon-barrel-shadow-9.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-cannon-barrel-shadow-10.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-cannon-barrel-shadow-11.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-cannon-barrel-shadow-12.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-cannon-barrel-shadow-13.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-cannon-barrel-shadow-14.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-cannon-barrel-shadow-15.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-cannon-barrel-shadow-16.png"
                    },
                    hr_version = {
                        priority = "very-low",
                        width = 906,
                        height = 626,
                        direction_count = 256,
                        line_length = 4,
                        lines_per_file = 4,
                        shift = util.by_pixel(-3.5 + 58, 7.5 + 46),
                        scale = 0.5,
                        draw_as_shadow = true,
                        filenames = {
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-cannon-barrel-shadow-1.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-cannon-barrel-shadow-2.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-cannon-barrel-shadow-3.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-cannon-barrel-shadow-4.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-cannon-barrel-shadow-5.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-cannon-barrel-shadow-6.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-cannon-barrel-shadow-7.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-cannon-barrel-shadow-8.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-cannon-barrel-shadow-9.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-cannon-barrel-shadow-10.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-cannon-barrel-shadow-11.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-cannon-barrel-shadow-12.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-cannon-barrel-shadow-13.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-cannon-barrel-shadow-14.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-cannon-barrel-shadow-15.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-cannon-barrel-shadow-16.png"
                        }
                    }
                }
            }
        },
        cannon_base_pictures = {
            layers = {
                {
                    priority = "very-low",
                    width = 180,
                    height = 136,
                    direction_count = 256,
                    line_length = 4,
                    lines_per_file = 4,
                    shift = util.by_pixel(0, -40),
                    filenames = {
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-cannon-base-1.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-cannon-base-2.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-cannon-base-3.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-cannon-base-4.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-cannon-base-5.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-cannon-base-6.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-cannon-base-7.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-cannon-base-8.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-cannon-base-9.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-cannon-base-10.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-cannon-base-11.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-cannon-base-12.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-cannon-base-13.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-cannon-base-14.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-cannon-base-15.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-cannon-base-16.png"
                    },
                    hr_version = {
                        priority = "very-low",
                        width = 358,
                        height = 270,
                        direction_count = 256,
                        line_length = 4,
                        lines_per_file = 4,
                        shift = util.by_pixel(0, -40.5),
                        scale = 0.5,
                        filenames = {
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-cannon-base-1.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-cannon-base-2.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-cannon-base-3.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-cannon-base-4.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-cannon-base-5.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-cannon-base-6.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-cannon-base-7.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-cannon-base-8.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-cannon-base-9.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-cannon-base-10.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-cannon-base-11.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-cannon-base-12.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-cannon-base-13.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-cannon-base-14.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-cannon-base-15.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-cannon-base-16.png"
                        }
                    }
                },
                {
                    priority = "very-low",
                    width = 238,
                    height = 170,
                    direction_count = 256,
                    line_length = 4,
                    lines_per_file = 4,
                    shift = util.by_pixel(54 + 58, -1 + 46),
                    draw_as_shadow = true,
                    filenames = {
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-cannon-base-shadow-1.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-cannon-base-shadow-2.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-cannon-base-shadow-3.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-cannon-base-shadow-4.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-cannon-base-shadow-5.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-cannon-base-shadow-6.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-cannon-base-shadow-7.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-cannon-base-shadow-8.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-cannon-base-shadow-9.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-cannon-base-shadow-10.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-cannon-base-shadow-11.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-cannon-base-shadow-12.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-cannon-base-shadow-13.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-cannon-base-shadow-14.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-cannon-base-shadow-15.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-cannon-base-shadow-16.png"
                    },
                    hr_version = {
                        priority = "very-low",
                        width = 476,
                        height = 340,
                        direction_count = 256,
                        line_length = 4,
                        lines_per_file = 4,
                        shift = util.by_pixel(54.5 + 58, -1 + 46),
                        scale = 0.5,
                        draw_as_shadow = true,
                        filenames = {
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-cannon-base-shadow-1.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-cannon-base-shadow-2.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-cannon-base-shadow-3.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-cannon-base-shadow-4.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-cannon-base-shadow-5.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-cannon-base-shadow-6.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-cannon-base-shadow-7.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-cannon-base-shadow-8.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-cannon-base-shadow-9.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-cannon-base-shadow-10.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-cannon-base-shadow-11.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-cannon-base-shadow-12.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-cannon-base-shadow-13.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-cannon-base-shadow-14.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-cannon-base-shadow-15.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-cannon-base-shadow-16.png"
                        }
                    }
                }
            }
        },
        cannon_barrel_recoil_shiftings = {
            { x = -0.000, y = 0.040, z = -0.000 },
            { x = -0.789, y = 0.037, z = -0.351 },
            { x = -1.578, y = 0.035, z = -0.702 },
            { x = -2.367, y = 0.033, z = -1.054 },
            { x = -3.155, y = 0.031, z = -1.405 },
            { x = -3.944, y = 0.028, z = -1.756 },
            { x = -3.931, y = 0.028, z = -1.750 },
            { x = -3.901, y = 0.028, z = -1.737 },
            { x = -3.854, y = 0.029, z = -1.716 },
            { x = -3.790, y = 0.029, z = -1.688 },
            { x = -3.711, y = 0.029, z = -1.652 },
            { x = -3.617, y = 0.029, z = -1.610 },
            { x = -3.508, y = 0.030, z = -1.562 },
            { x = -3.385, y = 0.030, z = -1.507 },
            { x = -3.249, y = 0.030, z = -1.447 },
            { x = -3.102, y = 0.031, z = -1.381 },
            { x = -2.944, y = 0.031, z = -1.311 },
            { x = -2.776, y = 0.032, z = -1.236 },
            { x = -2.599, y = 0.032, z = -1.157 },
            { x = -2.416, y = 0.033, z = -1.076 },
            { x = -2.226, y = 0.033, z = -0.991 },
            { x = -2.032, y = 0.034, z = -0.905 },
            { x = -1.835, y = 0.034, z = -0.817 },
            { x = -1.635, y = 0.035, z = -0.728 },
            { x = -1.436, y = 0.035, z = -0.639 },
            { x = -1.238, y = 0.036, z = -0.551 },
            { x = -1.042, y = 0.037, z = -0.464 },
            { x = -0.851, y = 0.037, z = -0.379 },
            { x = -0.665, y = 0.038, z = -0.296 },
            { x = -0.485, y = 0.038, z = -0.216 },
            { x = -0.314, y = 0.039, z = -0.140 },
            { x = -0.152, y = 0.039, z = -0.068 }
        },
        cannon_barrel_light_direction = { 0.5976251, 0.0242053, -0.8014102 },
        cannon_barrel_recoil_shiftings_load_correction_matrix = {
            { 0, 0.25, 0 },
            { -0.25, 0, 0 },
            { 0, 0, 0.25 }
        },

        water_reflection = {
            pictures = {
                filename = "__base__/graphics/entity/artillery-turret/artillery-turret-reflection.png",
                priority = "extra-high",
                width = 28,
                height = 32,
                shift = util.by_pixel(0, 75),
                variation_count = 1,
                scale = 5
            },
            rotate = false,
            orientation_to_variation = false
        }
    },
    {
        type = "ammo-turret",
        name = "pacifist-dummy-ammo-turret",
        icon = "__base__/graphics/icons/gun-turret.png",
        icon_size = 64, icon_mipmaps = 4,
        flags = { "hidden", "placeable-player", "player-creation" },
        max_health = 400,
        corpse = "gun-turret-remnants",
        dying_explosion = "gun-turret-explosion",
        collision_box = { { -0.7, -0.7 }, { 0.7, 0.7 } },
        selection_box = { { -1, -1 }, { 1, 1 } },
        rotation_speed = 0.015,
        preparing_speed = 0.08,
        folding_speed = 0.08,
        inventory_size = 1,
        automated_ammo_count = 10,
        attacking_speed = 0.5,
        alert_when_attacking = true,
        folded_animation = {
            layers = {
                gun_turret_extension { frame_count = 1, line_length = 1 },
                gun_turret_extension_mask { frame_count = 1, line_length = 1 },
                gun_turret_extension_shadow { frame_count = 1, line_length = 1 }
            }
        },
        preparing_animation = {
            layers = {
                gun_turret_extension {},
                gun_turret_extension_mask {},
                gun_turret_extension_shadow {}
            }
        },
        prepared_animation = gun_turret_attack { frame_count = 1 },
        attacking_animation = gun_turret_attack {},
        folding_animation = {
            layers = {
                gun_turret_extension { run_mode = "backward" },
                gun_turret_extension_mask { run_mode = "backward" },
                gun_turret_extension_shadow { run_mode = "backward" }
            }
        },
        base_picture = {
            layers = {
                {
                    filename = "__base__/graphics/entity/gun-turret/gun-turret-base.png",
                    priority = "high",
                    width = 76,
                    height = 60,
                    axially_symmetrical = false,
                    direction_count = 1,
                    frame_count = 1,
                    shift = util.by_pixel(1, -1),
                    hr_version = {
                        filename = "__base__/graphics/entity/gun-turret/hr-gun-turret-base.png",
                        priority = "high",
                        width = 150,
                        height = 118,
                        axially_symmetrical = false,
                        direction_count = 1,
                        frame_count = 1,
                        shift = util.by_pixel(0.5, -1),
                        scale = 0.5
                    }
                },
                {
                    filename = "__base__/graphics/entity/gun-turret/gun-turret-base-mask.png",
                    flags = { "mask", "low-object" },
                    line_length = 1,
                    width = 62,
                    height = 52,
                    axially_symmetrical = false,
                    direction_count = 1,
                    frame_count = 1,
                    shift = util.by_pixel(0, -4),
                    apply_runtime_tint = true,
                    hr_version = {
                        filename = "__base__/graphics/entity/gun-turret/hr-gun-turret-base-mask.png",
                        flags = { "mask", "low-object" },
                        line_length = 1,
                        width = 122,
                        height = 102,
                        axially_symmetrical = false,
                        direction_count = 1,
                        frame_count = 1,
                        shift = util.by_pixel(0, -4.5),
                        apply_runtime_tint = true,
                        scale = 0.5
                    }
                }

            }
        },

        attack_parameters = {
            type = "projectile",
            ammo_category = "bullet",
            cooldown = 6,
            projectile_creation_distance = 1.39375,
            projectile_center = { 0, -0.0875 }, -- same as gun_turret_attack shift
            shell_particle = {
                name = "shell-particle",
                direction_deviation = 0.1,
                speed = 0.1,
                speed_deviation = 0.03,
                center = { -0.0625, 0 },
                creation_distance = -1.925,
                starting_frame_speed = 0.2,
                starting_frame_speed_deviation = 0.1
            },
            range = 18,
        },

        call_for_help_radius = 40,
        water_reflection = {
            pictures = {
                filename = "__base__/graphics/entity/gun-turret/gun-turret-reflection.png",
                priority = "extra-high",
                width = 20,
                height = 32,
                shift = util.by_pixel(0, 40),
                variation_count = 1,
                scale = 5
            },
            rotate = false,
            orientation_to_variation = false
        }
    },
    {
        type = "electric-turret",
        name = "pacifist-dummy-electric-turret",
        icon = "__base__/graphics/icons/laser-turret.png",
        icon_size = 64, icon_mipmaps = 4,
        flags = { "hidden", "placeable-player", "placeable-enemy", "player-creation" },
        max_health = 1000,
        collision_box = { { -0.7, -0.7 }, { 0.7, 0.7 } },
        selection_box = { { -1, -1 }, { 1, 1 } },
        rotation_speed = 0.01,
        preparing_speed = 0.05,
        corpse = "laser-turret-remnants",
        dying_explosion = "laser-turret-explosion",
        folding_speed = 0.05,
        energy_source = {
            type = "electric",
            buffer_capacity = "801kJ",
            input_flow_limit = "9600kW",
            drain = "24kW",
            usage_priority = "primary-input"
        },
        folded_animation = {
            layers = {
                laser_turret_extension { frame_count = 1, line_length = 1 },
                laser_turret_extension_shadow { frame_count = 1, line_length = 1 },
                laser_turret_extension_mask { frame_count = 1, line_length = 1 }
            }
        },
        preparing_animation = {
            layers = {
                laser_turret_extension {},
                laser_turret_extension_shadow {},
                laser_turret_extension_mask {}
            }
        },
        prepared_animation = {
            layers = {
                laser_turret_shooting(),
                laser_turret_shooting_shadow(),
                laser_turret_shooting_mask()
            }
        },
        --attacking_speed = 0.1,
        energy_glow_animation = laser_turret_shooting_glow(),
        glow_light_intensity = 0.5, -- defaults to 0
        folding_animation = {
            layers = {
                laser_turret_extension { run_mode = "backward" },
                laser_turret_extension_shadow { run_mode = "backward" },
                laser_turret_extension_mask { run_mode = "backward" }
            }
        },
        base_picture = {
            layers = {
                {
                    filename = "__base__/graphics/entity/laser-turret/laser-turret-base.png",
                    priority = "high",
                    width = 70,
                    height = 52,
                    direction_count = 1,
                    frame_count = 1,
                    shift = util.by_pixel(0, 2),
                    hr_version = {
                        filename = "__base__/graphics/entity/laser-turret/hr-laser-turret-base.png",
                        priority = "high",
                        width = 138,
                        height = 104,
                        direction_count = 1,
                        frame_count = 1,
                        shift = util.by_pixel(-0.5, 2),
                        scale = 0.5
                    }
                },
                {
                    filename = "__base__/graphics/entity/laser-turret/laser-turret-base-shadow.png",
                    line_length = 1,
                    width = 66,
                    height = 42,
                    draw_as_shadow = true,
                    direction_count = 1,
                    frame_count = 1,
                    shift = util.by_pixel(6, 3),
                    hr_version = {
                        filename = "__base__/graphics/entity/laser-turret/hr-laser-turret-base-shadow.png",
                        line_length = 1,
                        width = 132,
                        height = 82,
                        draw_as_shadow = true,
                        direction_count = 1,
                        frame_count = 1,
                        shift = util.by_pixel(6, 3),
                        scale = 0.5
                    }
                }
            }
        },

        attack_parameters = {
            type = "beam",
            cooldown = 40,
            range = 24,
            source_direction_count = 64,
            source_offset = { 0, -3.423489 / 4 },
            damage_modifier = 2,
            ammo_type = {
                category = "laser",
                energy_consumption = "800kJ",
                action = {
                    type = "direct",
                    action_delivery = {
                        type = "beam",
                        beam = "laser-beam",
                        max_length = 24,
                        duration = 40,
                        source_offset = { 0, -1.31439 }
                    }
                }
            }
        },

        call_for_help_radius = 40,
        water_reflection = {
            pictures = {
                filename = "__base__/graphics/entity/laser-turret/laser-turret-reflection.png",
                priority = "extra-high",
                width = 20,
                height = 32,
                shift = util.by_pixel(0, 40),
                variation_count = 1,
                scale = 5
            },
            rotate = false,
            orientation_to_variation = false
        }
    },
    {
        type = "fluid-turret",
        name = "pacifist-dummy-fluid-turret",
        icon = "__base__/graphics/icons/flamethrower-turret.png",
        icon_size = 64, icon_mipmaps = 4,
        flags = { "hidden", "placeable-player", "player-creation" },
        max_health = 1400,
        corpse = "flamethrower-turret-remnants",
        collision_box = { { -0.7, -1.2 }, { 0.7, 1.2 } },
        selection_box = { { -1, -1.5 }, { 1, 1.5 } },
        rotation_speed = 0.015,
        preparing_speed = 0.08,
        folding_speed = 0.08,
        attacking_speed = 1,
        ending_attack_speed = 0.2,
        dying_explosion = "medium-explosion",
        turret_base_has_direction = true,

        resistances = {
            {
                type = "fire",
                percent = 100
            }
        },

        fluid_box = {
            production_type = "input-output",
            secondary_draw_order = 0,
            render_layer = "lower-object",
            --pipe_picture = fireutil.flamethrower_turret_pipepictures(),
            pipe_covers = pipecoverspictures(),
            base_area = 1,
            pipe_connections = {
                { position = { -1.5, 1.0 } },
                { position = { 1.5, 1.0 } }
            }
        },
        fluid_buffer_size = 100,
        fluid_buffer_input_flow = 250 / 60 / 5, -- 5s to fill the buffer
        activation_buffer_ratio = 0.25,

        folded_animation = {
            layers = {
                laser_turret_extension { frame_count = 1, line_length = 1 },
                laser_turret_extension_shadow { frame_count = 1, line_length = 1 },
                laser_turret_extension_mask { frame_count = 1, line_length = 1 }
            }
        },

        not_enough_fuel_indicator_picture = indicator_pictures,
        not_enough_fuel_indicator_light = { intensity = 0.2, size = 1.5, color = { 1, 0, 0 } },
        enough_fuel_indicator_light = { intensity = 0.2, size = 1.5, color = { 0, 1, 0 } },
        out_of_ammo_alert_icon = {
            filename = "__core__/graphics/icons/alerts/fuel-icon-red.png",
            priority = "extra-high-no-scale",
            width = 64,
            height = 64,
            flags = { "icon" }
        },

        gun_animation_render_layer = "object",
        gun_animation_secondary_draw_order = 1,
        base_picture_render_layer = "lower-object-above-shadow",
        base_picture_secondary_draw_order = 1,
        base_picture = {
            north = {
                layers = {
                    -- diffuse
                    {
                        filename = "__base__/graphics/entity/flamethrower-turret/flamethrower-turret-base-north.png",
                        line_length = 1,
                        width = 80,
                        height = 96,
                        frame_count = 1,
                        axially_symmetrical = false,
                        direction_count = 1,
                        shift = util.by_pixel(-2, 14),
                        hr_version = {
                            filename = "__base__/graphics/entity/flamethrower-turret/hr-flamethrower-turret-base-north.png",
                            line_length = 1,
                            width = 158,
                            height = 196,
                            frame_count = 1,
                            axially_symmetrical = false,
                            direction_count = 1,
                            shift = util.by_pixel(-1, 13),
                            scale = 0.5
                        }
                    },
                    -- mask
                    {
                        filename = "__base__/graphics/entity/flamethrower-turret/flamethrower-turret-base-north-mask.png",
                        flags = { "mask" },
                        line_length = 1,
                        width = 36,
                        height = 38,
                        frame_count = 1,
                        axially_symmetrical = false,
                        direction_count = 1,
                        shift = util.by_pixel(0, 32),
                        apply_runtime_tint = true,
                        hr_version = {
                            filename = "__base__/graphics/entity/flamethrower-turret/hr-flamethrower-turret-base-north-mask.png",
                            flags = { "mask" },
                            line_length = 1,
                            width = 74,
                            height = 70,
                            frame_count = 1,
                            axially_symmetrical = false,
                            direction_count = 1,
                            shift = util.by_pixel(-1, 33),
                            apply_runtime_tint = true,
                            scale = 0.5
                        }
                    },
                    -- shadow
                    {
                        filename = "__base__/graphics/entity/flamethrower-turret/flamethrower-turret-base-north-shadow.png",
                        draw_as_shadow = true,
                        line_length = 1,
                        width = 70,
                        height = 78,
                        frame_count = 1,
                        axially_symmetrical = false,
                        direction_count = 1,
                        shift = util.by_pixel(2, 14),
                        hr_version = {
                            filename = "__base__/graphics/entity/flamethrower-turret/hr-flamethrower-turret-base-north-shadow.png",
                            draw_as_shadow = true,
                            line_length = 1,
                            width = 134,
                            height = 152,
                            frame_count = 1,
                            axially_symmetrical = false,
                            direction_count = 1,
                            shift = util.by_pixel(3, 15),
                            scale = 0.5
                        }
                    }
                }
            },
            east = {
                layers = {
                    -- diffuse
                    {
                        filename = "__base__/graphics/entity/flamethrower-turret/flamethrower-turret-base-east.png",
                        line_length = 1,
                        width = 106,
                        height = 72,
                        frame_count = 1,
                        axially_symmetrical = false,
                        direction_count = 1,
                        shift = util.by_pixel(-6, 2),
                        hr_version = {
                            filename = "__base__/graphics/entity/flamethrower-turret/hr-flamethrower-turret-base-east.png",
                            line_length = 1,
                            width = 216,
                            height = 146,
                            frame_count = 1,
                            axially_symmetrical = false,
                            direction_count = 1,
                            shift = util.by_pixel(-6, 3),
                            scale = 0.5
                        }
                    },
                    -- mask
                    {
                        filename = "__base__/graphics/entity/flamethrower-turret/flamethrower-turret-base-east-mask.png",
                        flags = { "mask" },
                        apply_runtime_tint = true,
                        line_length = 1,
                        width = 32,
                        height = 42,
                        frame_count = 1,
                        axially_symmetrical = false,
                        direction_count = 1,
                        shift = util.by_pixel(-32, 0),
                        hr_version = {
                            filename = "__base__/graphics/entity/flamethrower-turret/hr-flamethrower-turret-base-east-mask.png",
                            flags = { "mask" },
                            apply_runtime_tint = true,
                            line_length = 1,
                            width = 66,
                            height = 82,
                            frame_count = 1,
                            axially_symmetrical = false,
                            direction_count = 1,
                            shift = util.by_pixel(-33, 1),
                            scale = 0.5
                        }
                    },
                    -- shadow
                    {
                        filename = "__base__/graphics/entity/flamethrower-turret/flamethrower-turret-base-east-shadow.png",
                        draw_as_shadow = true,
                        line_length = 1,
                        width = 72,
                        height = 46,
                        frame_count = 1,
                        axially_symmetrical = false,
                        direction_count = 1,
                        shift = util.by_pixel(14, 8),
                        hr_version = {
                            filename = "__base__/graphics/entity/flamethrower-turret/hr-flamethrower-turret-base-east-shadow.png",
                            draw_as_shadow = true,
                            line_length = 1,
                            width = 144,
                            height = 86,
                            frame_count = 1,
                            axially_symmetrical = false,
                            direction_count = 1,
                            shift = util.by_pixel(14, 9),
                            scale = 0.5
                        }
                    }
                }
            },
            south = {
                layers = {
                    -- diffuse
                    {
                        filename = "__base__/graphics/entity/flamethrower-turret/flamethrower-turret-base-south.png",
                        line_length = 1,
                        width = 64,
                        height = 84,
                        frame_count = 1,
                        axially_symmetrical = false,
                        direction_count = 1,
                        shift = util.by_pixel(0, -8),
                        hr_version = {
                            filename = "__base__/graphics/entity/flamethrower-turret/hr-flamethrower-turret-base-south.png",
                            line_length = 1,
                            width = 128,
                            height = 166,
                            frame_count = 1,
                            axially_symmetrical = false,
                            direction_count = 1,
                            shift = util.by_pixel(0, -8),
                            scale = 0.5
                        }
                    },
                    -- mask
                    {
                        filename = "__base__/graphics/entity/flamethrower-turret/flamethrower-turret-base-south-mask.png",
                        flags = { "mask" },
                        apply_runtime_tint = true,
                        line_length = 1,
                        width = 36,
                        height = 38,
                        frame_count = 1,
                        axially_symmetrical = false,
                        direction_count = 1,
                        shift = util.by_pixel(0, -32),
                        hr_version = {
                            filename = "__base__/graphics/entity/flamethrower-turret/hr-flamethrower-turret-base-south-mask.png",
                            flags = { "mask" },
                            apply_runtime_tint = true,
                            line_length = 1,
                            width = 72,
                            height = 72,
                            frame_count = 1,
                            axially_symmetrical = false,
                            direction_count = 1,
                            shift = util.by_pixel(0, -31),
                            scale = 0.5
                        }
                    },
                    -- shadow
                    {
                        filename = "__base__/graphics/entity/flamethrower-turret/flamethrower-turret-base-south-shadow.png",
                        draw_as_shadow = true,
                        line_length = 1,
                        width = 70,
                        height = 52,
                        frame_count = 1,
                        axially_symmetrical = false,
                        direction_count = 1,
                        shift = util.by_pixel(2, 8),
                        hr_version = {
                            filename = "__base__/graphics/entity/flamethrower-turret/hr-flamethrower-turret-base-south-shadow.png",
                            draw_as_shadow = true,
                            line_length = 1,
                            width = 134,
                            height = 98,
                            frame_count = 1,
                            axially_symmetrical = false,
                            direction_count = 1,
                            shift = util.by_pixel(3, 9),
                            scale = 0.5
                        }
                    }
                }

            },
            west = {
                layers = {
                    -- diffuse
                    {
                        filename = "__base__/graphics/entity/flamethrower-turret/flamethrower-turret-base-west.png",
                        line_length = 1,
                        width = 100,
                        height = 74,
                        frame_count = 1,
                        axially_symmetrical = false,
                        direction_count = 1,
                        shift = util.by_pixel(8, -2),
                        hr_version = {
                            filename = "__base__/graphics/entity/flamethrower-turret/hr-flamethrower-turret-base-west.png",
                            line_length = 1,
                            width = 208,
                            height = 144,
                            frame_count = 1,
                            axially_symmetrical = false,
                            direction_count = 1,
                            shift = util.by_pixel(7, -1),
                            scale = 0.5
                        }
                    },
                    -- mask
                    {
                        filename = "__base__/graphics/entity/flamethrower-turret/flamethrower-turret-base-west-mask.png",
                        flags = { "mask" },
                        apply_runtime_tint = true,
                        line_length = 1,
                        width = 32,
                        height = 40,
                        frame_count = 1,
                        axially_symmetrical = false,
                        direction_count = 1,
                        shift = util.by_pixel(32, -2),
                        hr_version = {
                            filename = "__base__/graphics/entity/flamethrower-turret/hr-flamethrower-turret-base-west-mask.png",
                            flags = { "mask" },
                            apply_runtime_tint = true,
                            line_length = 1,
                            width = 64,
                            height = 74,
                            frame_count = 1,
                            axially_symmetrical = false,
                            direction_count = 1,
                            shift = util.by_pixel(32, -1),
                            scale = 0.5
                        }
                    },
                    -- shadow
                    {
                        filename = "__base__/graphics/entity/flamethrower-turret/flamethrower-turret-base-west-shadow.png",
                        draw_as_shadow = true,
                        line_length = 1,
                        width = 104,
                        height = 44,
                        frame_count = 1,
                        axially_symmetrical = false,
                        direction_count = 1,
                        shift = util.by_pixel(14, 4),
                        hr_version = {
                            filename = "__base__/graphics/entity/flamethrower-turret/hr-flamethrower-turret-base-west-shadow.png",
                            draw_as_shadow = true,
                            line_length = 1,
                            width = 206,
                            height = 88,
                            frame_count = 1,
                            axially_symmetrical = false,
                            direction_count = 1,
                            shift = util.by_pixel(15, 4),
                            scale = 0.5
                        }
                    }
                }
            }
        },

        muzzle_animation = util.draw_as_glow {
            filename = "__base__/graphics/entity/flamethrower-turret/flamethrower-turret-muzzle-fire.png",
            line_length = 8,
            width = 17,
            height = 41,
            frame_count = 32,
            axially_symmetrical = false,
            direction_count = 1,
            blend_mode = "additive",
            scale = 0.5,
            shift = { 0.015625 * 0.5, -0.546875 * 0.5 + 0.05 }
        },
        muzzle_light = { size = 1.5, intensity = 0.2, color = { 1, 0.5, 0 } },

        prepare_range = 35,
        shoot_in_prepare_state = false,
        attack_parameters = {
            type = "stream",
            cooldown = 4,
            range = 30,
            min_range = 6,

            turn_range = 1.0 / 3.0,
            fire_penalty = 15,

            -- lead_target_for_projectile_speed = 0.2* 0.75 * 1.5, -- this is same as particle horizontal speed of flamethrower fire stream

            fluids = {
                { type = "crude-oil" },
                { type = "heavy-oil", damage_modifier = 1.05 },
                { type = "light-oil", damage_modifier = 1.1 }
            },
            fluid_consumption = 0.2,

            gun_barrel_length = 0.4,

            ammo_type = {
                category = "flamethrower",
                action = {
                    type = "direct",
                    action_delivery = {
                        type = "stream",
                        stream = "flamethrower-fire-stream",
                        source_offset = { 0.15, -0.5 }
                    }
                }
            },

            cyclic_sound = {
                begin_sound = {
                    {
                        filename = "__base__/sound/fight/flamethrower-turret-start-01.ogg",
                        volume = 0.5
                    },
                    {
                        filename = "__base__/sound/fight/flamethrower-turret-start-02.ogg",
                        volume = 0.5
                    },
                    {
                        filename = "__base__/sound/fight/flamethrower-turret-start-03.ogg",
                        volume = 0.5
                    }
                },
                middle_sound = {
                    {
                        filename = "__base__/sound/fight/flamethrower-turret-mid-01.ogg",
                        volume = 0.5
                    },
                    {
                        filename = "__base__/sound/fight/flamethrower-turret-mid-02.ogg",
                        volume = 0.5
                    },
                    {
                        filename = "__base__/sound/fight/flamethrower-turret-mid-03.ogg",
                        volume = 0.5
                    }
                },
                end_sound = {
                    {
                        filename = "__base__/sound/fight/flamethrower-turret-end-01.ogg",
                        volume = 0.5
                    },
                    {
                        filename = "__base__/sound/fight/flamethrower-turret-end-02.ogg",
                        volume = 0.5
                    },
                    {
                        filename = "__base__/sound/fight/flamethrower-turret-end-03.ogg",
                        volume = 0.5
                    }
                }
            }
        }, -- {0,  0.625}
        call_for_help_radius = 40
    },
    {
        type = "artillery-wagon",
        name = "pacifist-dummy-artillery-wagon",
        icon = "__base__/graphics/icons/artillery-wagon.png",
        icon_size = 64, icon_mipmaps = 4,
        flags = { "hidden", "placeable-neutral", "player-creation", "placeable-off-grid" },
        inventory_size = 1,
        ammo_stack_limit = 100,
        max_health = 600,
        corpse = "artillery-wagon-remnants",
        dying_explosion = "artillery-wagon-explosion",
        collision_box = { { -0.6, -2.4 }, { 0.6, 2.4 } },
        selection_box = { { -1, -2.703125 }, { 1, 3.296875 } },
        vertical_selection_shift = -0.796875,
        weight = 4000,
        max_speed = 1.5,
        braking_force = 3,
        friction_force = 0.50,
        air_resistance = 0.015,
        connection_distance = 3,
        joint_distance = 4,
        energy_per_hit_point = 2,
        gun = "pacifist-dummy-gun",
        turret_rotation_speed = 0.001,
        turn_after_shooting_cooldown = 60,
        cannon_parking_frame_count = 8,
        cannon_parking_speed = 0.25,
        manual_range_modifier = 2.5,
        resistances = {
            {
                type = "fire",
                decrease = 15,
                percent = 50
            },
            {
                type = "physical",
                decrease = 15,
                percent = 30
            },
            {
                type = "impact",
                decrease = 50,
                percent = 50
            },
            {
                type = "explosion",
                decrease = 15,
                percent = 30
            },
            {
                type = "acid",
                decrease = 3,
                percent = 20
            }
        },
        back_light = rolling_stock_back_light(),
        stand_by_light = rolling_stock_stand_by_light(),
        color = { r = 0.43, g = 0.23, b = 0, a = 0.5 },
        pictures = {
            layers = {
                {
                    priority = "very-low",
                    width = 238,
                    height = 206,
                    direction_count = 256,
                    allow_low_quality_rotation = true,
                    line_length = 4,
                    lines_per_file = 4,
                    shift = util.by_pixel(0, -27),
                    dice = 4,
                    filenames = {
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-base-1.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-base-2.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-base-3.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-base-4.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-base-5.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-base-6.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-base-7.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-base-8.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-base-9.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-base-10.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-base-11.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-base-12.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-base-13.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-base-14.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-base-15.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-base-16.png"
                    },
                    hr_version = {
                        priority = "very-low",
                        width = 476,
                        height = 410,
                        direction_count = 256,
                        allow_low_quality_rotation = true,
                        line_length = 4,
                        lines_per_file = 4,
                        shift = util.by_pixel(0.5, -27.5),
                        scale = 0.5,
                        dice = 4,
                        filenames = {
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-base-1.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-base-2.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-base-3.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-base-4.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-base-5.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-base-6.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-base-7.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-base-8.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-base-9.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-base-10.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-base-11.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-base-12.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-base-13.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-base-14.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-base-15.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-base-16.png"
                        }
                    }
                },
                {
                    priority = "very-low",
                    dice = 4,
                    width = 300,
                    height = 240,
                    direction_count = 256,
                    allow_low_quality_rotation = true,
                    line_length = 4,
                    lines_per_file = 4,
                    shift = util.by_pixel(37, 6),
                    draw_as_shadow = true,
                    filenames = {
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-base-shadow-1.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-base-shadow-2.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-base-shadow-3.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-base-shadow-4.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-base-shadow-5.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-base-shadow-6.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-base-shadow-7.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-base-shadow-8.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-base-shadow-9.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-base-shadow-10.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-base-shadow-11.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-base-shadow-12.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-base-shadow-13.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-base-shadow-14.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-base-shadow-15.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-base-shadow-16.png"
                    },
                    hr_version = {
                        priority = "very-low",
                        dice = 4,
                        width = 598,
                        height = 480,
                        direction_count = 256,
                        allow_low_quality_rotation = true,
                        line_length = 4,
                        lines_per_file = 4,
                        shift = util.by_pixel(36.5, 6.5), --v
                        scale = 0.5,
                        draw_as_shadow = true,
                        filenames = {
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-base-shadow-1.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-base-shadow-2.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-base-shadow-3.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-base-shadow-4.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-base-shadow-5.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-base-shadow-6.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-base-shadow-7.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-base-shadow-8.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-base-shadow-9.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-base-shadow-10.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-base-shadow-11.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-base-shadow-12.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-base-shadow-13.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-base-shadow-14.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-base-shadow-15.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-base-shadow-16.png"
                        }
                    }
                }
            }
        },
        cannon_barrel_pictures = {
            layers = {
                {
                    priority = "very-low",
                    width = 266,
                    height = 192,
                    direction_count = 256,
                    line_length = 4,
                    lines_per_file = 4,
                    shift = util.by_pixel(0, -56),
                    filenames = {
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-cannon-barrel-1.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-cannon-barrel-2.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-cannon-barrel-3.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-cannon-barrel-4.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-cannon-barrel-5.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-cannon-barrel-6.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-cannon-barrel-7.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-cannon-barrel-8.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-cannon-barrel-9.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-cannon-barrel-10.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-cannon-barrel-11.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-cannon-barrel-12.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-cannon-barrel-13.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-cannon-barrel-14.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-cannon-barrel-15.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-cannon-barrel-16.png"
                    },
                    hr_version = {
                        priority = "very-low",
                        width = 530,
                        height = 384,
                        direction_count = 256,
                        line_length = 4,
                        lines_per_file = 4,
                        shift = util.by_pixel(0, -56),
                        scale = 0.5,
                        filenames = {
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-cannon-barrel-1.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-cannon-barrel-2.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-cannon-barrel-3.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-cannon-barrel-4.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-cannon-barrel-5.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-cannon-barrel-6.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-cannon-barrel-7.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-cannon-barrel-8.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-cannon-barrel-9.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-cannon-barrel-10.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-cannon-barrel-11.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-cannon-barrel-12.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-cannon-barrel-13.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-cannon-barrel-14.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-cannon-barrel-15.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-cannon-barrel-16.png"
                        }
                    }
                },
                {
                    priority = "very-low",
                    width = 454,
                    height = 314,
                    direction_count = 256,
                    line_length = 4,
                    lines_per_file = 4,
                    shift = util.by_pixel(-3 + 58, 8 + 46),
                    draw_as_shadow = true,
                    filenames = {
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-cannon-barrel-shadow-1.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-cannon-barrel-shadow-2.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-cannon-barrel-shadow-3.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-cannon-barrel-shadow-4.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-cannon-barrel-shadow-5.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-cannon-barrel-shadow-6.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-cannon-barrel-shadow-7.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-cannon-barrel-shadow-8.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-cannon-barrel-shadow-9.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-cannon-barrel-shadow-10.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-cannon-barrel-shadow-11.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-cannon-barrel-shadow-12.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-cannon-barrel-shadow-13.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-cannon-barrel-shadow-14.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-cannon-barrel-shadow-15.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-cannon-barrel-shadow-16.png"
                    },
                    hr_version = {
                        priority = "very-low",
                        width = 906,
                        height = 626,
                        direction_count = 256,
                        line_length = 4,
                        lines_per_file = 4,
                        shift = util.by_pixel(-3.5 + 58, 7.5 + 46),
                        scale = 0.5,
                        draw_as_shadow = true,
                        filenames = {
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-cannon-barrel-shadow-1.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-cannon-barrel-shadow-2.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-cannon-barrel-shadow-3.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-cannon-barrel-shadow-4.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-cannon-barrel-shadow-5.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-cannon-barrel-shadow-6.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-cannon-barrel-shadow-7.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-cannon-barrel-shadow-8.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-cannon-barrel-shadow-9.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-cannon-barrel-shadow-10.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-cannon-barrel-shadow-11.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-cannon-barrel-shadow-12.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-cannon-barrel-shadow-13.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-cannon-barrel-shadow-14.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-cannon-barrel-shadow-15.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-cannon-barrel-shadow-16.png"
                        }
                    }
                }
            }
        },
        cannon_base_pictures = {
            layers = {
                {
                    priority = "very-low",
                    width = 180,
                    height = 136,
                    direction_count = 256,
                    line_length = 4,
                    lines_per_file = 4,
                    shift = util.by_pixel(0, -40),
                    filenames = {
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-cannon-base-1.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-cannon-base-2.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-cannon-base-3.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-cannon-base-4.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-cannon-base-5.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-cannon-base-6.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-cannon-base-7.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-cannon-base-8.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-cannon-base-9.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-cannon-base-10.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-cannon-base-11.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-cannon-base-12.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-cannon-base-13.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-cannon-base-14.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-cannon-base-15.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-cannon-base-16.png"
                    },
                    hr_version = {
                        priority = "very-low",
                        width = 358,
                        height = 270,
                        direction_count = 256,
                        line_length = 4,
                        lines_per_file = 4,
                        shift = util.by_pixel(0, -40.5),
                        scale = 0.5,
                        filenames = {
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-cannon-base-1.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-cannon-base-2.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-cannon-base-3.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-cannon-base-4.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-cannon-base-5.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-cannon-base-6.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-cannon-base-7.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-cannon-base-8.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-cannon-base-9.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-cannon-base-10.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-cannon-base-11.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-cannon-base-12.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-cannon-base-13.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-cannon-base-14.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-cannon-base-15.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-cannon-base-16.png"
                        }
                    }
                },
                {
                    priority = "very-low",
                    width = 238,
                    height = 170,
                    direction_count = 256,
                    line_length = 4,
                    lines_per_file = 4,
                    shift = util.by_pixel(54 + 58, -1 + 46),
                    draw_as_shadow = true,
                    filenames = {
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-cannon-base-shadow-1.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-cannon-base-shadow-2.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-cannon-base-shadow-3.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-cannon-base-shadow-4.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-cannon-base-shadow-5.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-cannon-base-shadow-6.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-cannon-base-shadow-7.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-cannon-base-shadow-8.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-cannon-base-shadow-9.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-cannon-base-shadow-10.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-cannon-base-shadow-11.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-cannon-base-shadow-12.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-cannon-base-shadow-13.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-cannon-base-shadow-14.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-cannon-base-shadow-15.png",
                        "__base__/graphics/entity/artillery-wagon/artillery-wagon-cannon-base-shadow-16.png"
                    },
                    hr_version = {
                        priority = "very-low",
                        width = 476,
                        height = 340,
                        direction_count = 256,
                        line_length = 4,
                        lines_per_file = 4,
                        shift = util.by_pixel(54.5 + 58, -1 + 46),
                        scale = 0.5,
                        draw_as_shadow = true,
                        filenames = {
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-cannon-base-shadow-1.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-cannon-base-shadow-2.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-cannon-base-shadow-3.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-cannon-base-shadow-4.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-cannon-base-shadow-5.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-cannon-base-shadow-6.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-cannon-base-shadow-7.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-cannon-base-shadow-8.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-cannon-base-shadow-9.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-cannon-base-shadow-10.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-cannon-base-shadow-11.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-cannon-base-shadow-12.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-cannon-base-shadow-13.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-cannon-base-shadow-14.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-cannon-base-shadow-15.png",
                            "__base__/graphics/entity/artillery-wagon/hr-artillery-wagon-cannon-base-shadow-16.png"
                        }
                    }
                }
            }
        },
        cannon_base_shiftings = {
            util.by_pixel(0.0, 19.5),
            util.by_pixel(-1.5, 19.0),
            util.by_pixel(-3.5, 19.0),
            util.by_pixel(-5.5, 18.5),
            util.by_pixel(-7.5, 18.5),
            util.by_pixel(-9.0, 18.0),
            util.by_pixel(-11.0, 17.5),
            util.by_pixel(-13.0, 17.5),
            util.by_pixel(-15.0, 17.0),
            util.by_pixel(-16.5, 16.5),
            util.by_pixel(-18.5, 16.0),
            util.by_pixel(-20.5, 15.5),
            util.by_pixel(-22.0, 15.0),
            util.by_pixel(-24.0, 14.5),
            util.by_pixel(-25.5, 14.0),
            util.by_pixel(-27.5, 13.0),
            util.by_pixel(-29.0, 12.5),
            util.by_pixel(-30.5, 12.0),
            util.by_pixel(-32.0, 11.0),
            util.by_pixel(-34.0, 10.5),
            util.by_pixel(-35.5, 9.5),
            util.by_pixel(-37.0, 9.0),
            util.by_pixel(-38.5, 8.0),
            util.by_pixel(-40.0, 7.5),
            util.by_pixel(-41.5, 6.5),
            util.by_pixel(-42.5, 5.5),
            util.by_pixel(-44.0, 4.5),
            util.by_pixel(-45.5, 4.0),
            util.by_pixel(-46.5, 3.0),
            util.by_pixel(-48.0, 2.0),
            util.by_pixel(-49.0, 1.0),
            util.by_pixel(-50.5, 0.0),
            util.by_pixel(-51.5, -0.5),
            util.by_pixel(-52.5, -1.5),
            util.by_pixel(-53.5, -2.5),
            util.by_pixel(-54.5, -3.5),
            util.by_pixel(-55.5, -5.0),
            util.by_pixel(-56.5, -6.0),
            util.by_pixel(-57.5, -7.0),
            util.by_pixel(-58.0, -8.0),
            util.by_pixel(-59.0, -9.0),
            util.by_pixel(-60.0, -10.5),
            util.by_pixel(-60.5, -11.5),
            util.by_pixel(-61.0, -12.5),
            util.by_pixel(-62.0, -13.5),
            util.by_pixel(-62.5, -15.0),
            util.by_pixel(-63.0, -16.0),
            util.by_pixel(-63.5, -17.0),
            util.by_pixel(-64.0, -18.5),
            util.by_pixel(-64.5, -19.5),
            util.by_pixel(-65.0, -21.0),
            util.by_pixel(-65.0, -22.0),
            util.by_pixel(-65.5, -23.0),
            util.by_pixel(-65.5, -24.5),
            util.by_pixel(-66.0, -25.5),
            util.by_pixel(-66.0, -26.5),
            util.by_pixel(-66.0, -28.0),
            util.by_pixel(-66.5, -29.0),
            util.by_pixel(-66.5, -30.0),
            util.by_pixel(-66.5, -31.5),
            util.by_pixel(-66.5, -32.5),
            util.by_pixel(-66.0, -34.0),
            util.by_pixel(-66.0, -35.0),
            util.by_pixel(-66.0, -36.0),
            util.by_pixel(-65.5, -37.0),
            util.by_pixel(-66.0, -38.5),
            util.by_pixel(-66.0, -39.5),
            util.by_pixel(-66.5, -40.5),
            util.by_pixel(-66.5, -42.0),
            util.by_pixel(-66.5, -43.0),
            util.by_pixel(-66.5, -44.0),
            util.by_pixel(-66.5, -45.5),
            util.by_pixel(-66.5, -46.5),
            util.by_pixel(-66.5, -48.0),
            util.by_pixel(-66.0, -49.0),
            util.by_pixel(-66.0, -50.0),
            util.by_pixel(-65.5, -51.5),
            util.by_pixel(-65.5, -52.5),
            util.by_pixel(-65.0, -53.5),
            util.by_pixel(-64.5, -55.0),
            util.by_pixel(-64.5, -56.0),
            util.by_pixel(-64.0, -57.5),
            util.by_pixel(-63.5, -58.5),
            util.by_pixel(-63.0, -59.5),
            util.by_pixel(-62.5, -61.0),
            util.by_pixel(-61.5, -62.0),
            util.by_pixel(-61.0, -63.0),
            util.by_pixel(-60.5, -64.0),
            util.by_pixel(-59.5, -65.5),
            util.by_pixel(-59.0, -66.5),
            util.by_pixel(-58.0, -67.5),
            util.by_pixel(-57.0, -68.5),
            util.by_pixel(-56.0, -70.0),
            util.by_pixel(-55.0, -71.0),
            util.by_pixel(-54.0, -72.0),
            util.by_pixel(-53.0, -73.0),
            util.by_pixel(-52.0, -74.0),
            util.by_pixel(-51.0, -75.0),
            util.by_pixel(-50.0, -76.0),
            util.by_pixel(-48.5, -77.0),
            util.by_pixel(-47.5, -78.0),
            util.by_pixel(-46.0, -79.0),
            util.by_pixel(-45.0, -80.0),
            util.by_pixel(-43.5, -81.0),
            util.by_pixel(-42.0, -81.5),
            util.by_pixel(-40.5, -82.5),
            util.by_pixel(-39.5, -83.5),
            util.by_pixel(-38.0, -84.0),
            util.by_pixel(-36.5, -85.0),
            util.by_pixel(-34.5, -85.5),
            util.by_pixel(-33.0, -86.5),
            util.by_pixel(-31.5, -87.0),
            util.by_pixel(-30.0, -88.0),
            util.by_pixel(-28.5, -88.5),
            util.by_pixel(-26.5, -89.0),
            util.by_pixel(-25.0, -90.0),
            util.by_pixel(-23.0, -90.5),
            util.by_pixel(-21.5, -91.0),
            util.by_pixel(-19.5, -91.5),
            util.by_pixel(-17.5, -92.0),
            util.by_pixel(-16.0, -92.5),
            util.by_pixel(-14.0, -93.0),
            util.by_pixel(-12.0, -93.0),
            util.by_pixel(-10.5, -93.5),
            util.by_pixel(-8.5, -94.0),
            util.by_pixel(-6.5, -94.0),
            util.by_pixel(-4.5, -94.5),
            util.by_pixel(-2.5, -94.5),
            util.by_pixel(-0.5, -95.0),
            util.by_pixel(1.0, -95.0),
            util.by_pixel(3.0, -94.5),
            util.by_pixel(5.0, -94.5),
            util.by_pixel(7.0, -94.0),
            util.by_pixel(8.5, -94.0),
            util.by_pixel(10.5, -93.5),
            util.by_pixel(12.5, -93.0),
            util.by_pixel(14.5, -92.5),
            util.by_pixel(16.5, -92.5),
            util.by_pixel(18.0, -92.0),
            util.by_pixel(20.0, -91.5),
            util.by_pixel(21.5, -91.0),
            util.by_pixel(23.5, -90.5),
            util.by_pixel(25.0, -89.5),
            util.by_pixel(27.0, -89.0),
            util.by_pixel(28.5, -88.5),
            util.by_pixel(30.5, -88.0),
            util.by_pixel(32.0, -87.0),
            util.by_pixel(33.5, -86.5),
            util.by_pixel(35.0, -85.5),
            util.by_pixel(36.5, -85.0),
            util.by_pixel(38.0, -84.0),
            util.by_pixel(39.5, -83.5),
            util.by_pixel(41.0, -82.5),
            util.by_pixel(42.5, -81.5),
            util.by_pixel(44.0, -80.5),
            util.by_pixel(45.0, -80.0),
            util.by_pixel(46.5, -79.0),
            util.by_pixel(47.5, -78.0),
            util.by_pixel(49.0, -77.0),
            util.by_pixel(50.0, -76.0),
            util.by_pixel(51.5, -75.0),
            util.by_pixel(52.5, -74.0),
            util.by_pixel(53.5, -73.0),
            util.by_pixel(54.5, -72.0),
            util.by_pixel(55.5, -71.0),
            util.by_pixel(56.5, -70.0),
            util.by_pixel(57.5, -68.5),
            util.by_pixel(58.5, -67.5),
            util.by_pixel(59.0, -66.5),
            util.by_pixel(60.0, -65.5),
            util.by_pixel(60.5, -64.0),
            util.by_pixel(61.5, -63.0),
            util.by_pixel(62.0, -62.0),
            util.by_pixel(62.5, -61.0),
            util.by_pixel(63.0, -59.5),
            util.by_pixel(63.5, -58.5),
            util.by_pixel(64.0, -57.5),
            util.by_pixel(64.5, -56.0),
            util.by_pixel(65.0, -55.0),
            util.by_pixel(65.5, -53.5),
            util.by_pixel(65.5, -52.5),
            util.by_pixel(66.0, -51.5),
            util.by_pixel(66.5, -50.0),
            util.by_pixel(66.5, -49.0),
            util.by_pixel(66.5, -48.0),
            util.by_pixel(66.5, -46.5),
            util.by_pixel(67.0, -45.5),
            util.by_pixel(67.0, -44.0),
            util.by_pixel(67.0, -43.0),
            util.by_pixel(66.5, -42.0),
            util.by_pixel(66.5, -40.5),
            util.by_pixel(66.5, -39.5),
            util.by_pixel(66.5, -38.5),
            util.by_pixel(66.5, -37.5),
            util.by_pixel(66.5, -36.0),
            util.by_pixel(67.0, -35.0),
            util.by_pixel(67.0, -34.0),
            util.by_pixel(67.0, -32.5),
            util.by_pixel(67.0, -31.5),
            util.by_pixel(67.0, -30.5),
            util.by_pixel(67.0, -29.0),
            util.by_pixel(67.0, -28.0),
            util.by_pixel(67.0, -26.5),
            util.by_pixel(66.5, -25.5),
            util.by_pixel(66.5, -24.5),
            util.by_pixel(66.0, -23.0),
            util.by_pixel(66.0, -22.0),
            util.by_pixel(65.5, -20.5),
            util.by_pixel(65.0, -19.5),
            util.by_pixel(65.0, -18.5),
            util.by_pixel(64.5, -17.0),
            util.by_pixel(64.0, -16.0),
            util.by_pixel(63.0, -15.0),
            util.by_pixel(62.5, -13.5),
            util.by_pixel(62.0, -12.5),
            util.by_pixel(61.5, -11.5),
            util.by_pixel(60.5, -10.0),
            util.by_pixel(60.0, -9.0),
            util.by_pixel(59.0, -8.0),
            util.by_pixel(58.0, -7.0),
            util.by_pixel(57.5, -6.0),
            util.by_pixel(56.5, -4.5),
            util.by_pixel(55.5, -3.5),
            util.by_pixel(54.5, -2.5),
            util.by_pixel(53.5, -1.5),
            util.by_pixel(52.0, -0.5),
            util.by_pixel(51.0, 0.0),
            util.by_pixel(50.0, 1.0),
            util.by_pixel(48.5, 2.0),
            util.by_pixel(47.5, 3.0),
            util.by_pixel(46.0, 4.0),
            util.by_pixel(45.0, 5.0),
            util.by_pixel(43.5, 5.5),
            util.by_pixel(42.0, 6.5),
            util.by_pixel(40.5, 7.5),
            util.by_pixel(39.0, 8.0),
            util.by_pixel(37.5, 9.0),
            util.by_pixel(36.0, 10.0),
            util.by_pixel(34.5, 10.5),
            util.by_pixel(33.0, 11.5),
            util.by_pixel(31.5, 12.0),
            util.by_pixel(29.5, 12.5),
            util.by_pixel(28.0, 13.5),
            util.by_pixel(26.5, 14.0),
            util.by_pixel(24.5, 14.5),
            util.by_pixel(23.0, 15.0),
            util.by_pixel(21.0, 15.5),
            util.by_pixel(19.0, 16.0),
            util.by_pixel(17.5, 16.5),
            util.by_pixel(15.5, 17.0),
            util.by_pixel(13.5, 17.5),
            util.by_pixel(11.5, 18.0),
            util.by_pixel(10.0, 18.0),
            util.by_pixel(8.0, 18.5),
            util.by_pixel(6.0, 19.0),
            util.by_pixel(4.0, 19.0)
        },
        cannon_barrel_recoil_shiftings = {
            { x = -0.000, y = 0.040, z = -0.000 },
            { x = -0.789, y = 0.037, z = -0.351 },
            { x = -1.578, y = 0.035, z = -0.702 },
            { x = -2.367, y = 0.033, z = -1.054 },
            { x = -3.155, y = 0.031, z = -1.405 },
            { x = -3.944, y = 0.028, z = -1.756 },
            { x = -3.931, y = 0.028, z = -1.750 },
            { x = -3.901, y = 0.028, z = -1.737 },
            { x = -3.854, y = 0.029, z = -1.716 },
            { x = -3.790, y = 0.029, z = -1.688 },
            { x = -3.711, y = 0.029, z = -1.652 },
            { x = -3.617, y = 0.029, z = -1.610 },
            { x = -3.508, y = 0.030, z = -1.562 },
            { x = -3.385, y = 0.030, z = -1.507 },
            { x = -3.249, y = 0.030, z = -1.447 },
            { x = -3.102, y = 0.031, z = -1.381 },
            { x = -2.944, y = 0.031, z = -1.311 },
            { x = -2.776, y = 0.032, z = -1.236 },
            { x = -2.599, y = 0.032, z = -1.157 },
            { x = -2.416, y = 0.033, z = -1.076 },
            { x = -2.226, y = 0.033, z = -0.991 },
            { x = -2.032, y = 0.034, z = -0.905 },
            { x = -1.835, y = 0.034, z = -0.817 },
            { x = -1.635, y = 0.035, z = -0.728 },
            { x = -1.436, y = 0.035, z = -0.639 },
            { x = -1.238, y = 0.036, z = -0.551 },
            { x = -1.042, y = 0.037, z = -0.464 },
            { x = -0.851, y = 0.037, z = -0.379 },
            { x = -0.665, y = 0.038, z = -0.296 },
            { x = -0.485, y = 0.038, z = -0.216 },
            { x = -0.314, y = 0.039, z = -0.140 },
            { x = -0.152, y = 0.039, z = -0.068 }
        },
        cannon_barrel_light_direction = { 0.5976251, 0.0242053, -0.8014102 },
        cannon_barrel_recoil_shiftings_load_correction_matrix = {
            { 0, 0.25, 0 },
            { -0.25, 0, 0 },
            { 0, 0, 0.25 }
        },
        minimap_representation = {
            filename = "__base__/graphics/entity/artillery-wagon/artillery-wagon-minimap-representation.png",
            flags = { "icon" },
            size = { 20, 40 },
            scale = 0.5
        },
        selected_minimap_representation = {
            filename = "__base__/graphics/entity/artillery-wagon/artillery-wagon-selected-minimap-representation.png",
            flags = { "icon" },
            size = { 20, 40 },
            scale = 0.5
        },
        wheels = standard_train_wheels,
        drive_over_tie_trigger = drive_over_tie(),
        tie_distance = 50,
        working_sound = {
            sound = {
                filename = "__base__/sound/train-wheels.ogg",
                volume = 0.3
            },
            match_volume_to_activity = true
        },
        rotating_sound = { sound = { filename = "__base__/sound/fight/artillery-rotation-loop.ogg", volume = 0.2 } },
        rotating_stopped_sound = { filename = "__base__/sound/fight/artillery-rotation-stop.ogg" },
        sound_minimum_speed = 0.1,
        water_reflection = {
            pictures = {
                filename = "__base__/graphics/entity/artillery-wagon/artillery-wagon-reflection.png",
                priority = "extra-high",
                width = 32,
                height = 52,
                shift = util.by_pixel(0, 40),
                variation_count = 1,
                scale = 5
            },
            rotate = true,
            orientation_to_variation = false
        }
    },
    {
        type = "active-defense-equipment",
        name = "pacifist-dummy-active-defense-equipment",
        sprite = {
            filename = "__base__/graphics/equipment/personal-laser-defense-equipment.png",
            width = 64,
            height = 64,
            priority = "medium",
            hr_version = {
                filename = "__base__/graphics/equipment/hr-personal-laser-defense-equipment.png",
                width = 128,
                height = 128,
                priority = "medium",
                scale = 0.5
            }
        },
        shape = {
            width = 2,
            height = 2,
            type = "full"
        },
        energy_source = {
            type = "electric",
            usage_priority = "secondary-input",
            buffer_capacity = "220kJ"
        },

        attack_parameters = {
            type = "beam",
            cooldown = 40,
            range = 15,
            --source_direction_count = 64,
            --source_offset = {0, -3.423489 / 4},
            damage_modifier = 3,
            ammo_type = {
                category = "laser",
                energy_consumption = "50kJ",
                action = {
                    type = "direct",
                    action_delivery = {
                        type = "beam",
                        beam = "laser-beam",
                        max_length = 15,
                        duration = 40,
                        source_offset = { 0, -1.31439 }
                    }
                }
            }
        },

        automatic = true,
        categories = { "armor" }
    },
    {
        type = "item",
        name = "pacifist-dummy-active-defense-equipment",
        icon = "__base__/graphics/icons/personal-laser-defense-equipment.png",
        icon_size = 64, icon_mipmaps = 4,
        subgroup = "military-equipment",
        order = "b[active-defense]-a[personal-laser-defense-equipment]",
        default_request_amount = 5,
        stack_size = 20
    },
}

if PacifistMod.settings.remove_walls then
    table.insert(dummies, dummy_gate)
    table.insert(dummies, dummy_wall)
end

if PacifistMod.settings.remove_shields then
    table.insert(dummies, dummy_shield_item)
    table.insert(dummies, dummy_shield_equipment)
end

return dummies