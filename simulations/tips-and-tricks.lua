--- @type {[string]:data.SimulationDefinition}
local simulations = {}
simulations.gleba_briefing =
{
  planet = "gleba",
  mute_wind_sounds = false,
  init =
  [[
    game.simulation.camera_position = {0, 1.5}

    for x = -12, 12, 1 do
      for y = -6, 6 do
        game.surfaces[1].set_tiles{{position = {x, y}, name = "wetland-jellynut"}}
      end
    end

    for k, position in pairs ({{-12, -6}, {-11, -6}, {-10, -6}, {-9, -6}, {-8, -6}, {-7, -6}, {-6, -6}, {-5, -6}, {-4, -6}, {-3, -6},
                               {-2, -6}, {-1, -6}, {0, -6}, {1, -6}, {2, -6}, {3, -6}, {-12, -5}, {-11, -5}, {-10, -5}, {-9, -5},
                               {-8, -5}, {-7, -5}, {-6, -5}, {-5, -5}, {-4, -5}, {-3, -5}, {-2, -5}, {-1, -5}, {0, -5}, {1, -5}, {2, -5},
                               {-12, -4}, {-11, -4}, {-10, -4}, {-9, -4}, {-8, -4}, {-7, -4}, {-6, -4}, {-5, -4}, {-4, -4}, {-3, -4},
                               {-2, -4}, {-1, -4}, {0, -4}, {1, -4}, {2, -4}, {-12, -3}, {-11, -3}, {-10, -3}, {-9, -3}, {-8, -3},
                               {-7, -3}, {-6, -3}, {-5, -3}, {-4, -3}, {-3, -3}, {-2, -3}, {-1, -3}, {0, -3}, {1, -3}, {-12, -2}, {-11, -2},
                               {-10, -2}, {-9, -2}, {-8, -2}, {-7, -2}, {-6, -2}, {-5, -2}, {-4, -2}, {-3, -2}, {-2, -2}, {-1, -2},
                               {0, -2}, {-12, -1}, {-11, -1}, {-8, -1}, {-7, -1}, {-6, -1}, {-5, -1}, {-4, -1}, {-3, -1}, {-2, -1},
                               {-1, -1}, {0, -1}, {-12, 0}, {-11, 0}, {-8, 0}, {-7, 0}, {-6, 0}, {-5, 0}, {-4, 0}, {-3, 0}, {-2, 0},
                               {-1, 0}, {-12, 1}, {-11, 1}, {-10, 1}, {-9, 1}, {-8, 1}, {-7, 1}, {-6, 1}, {-5, 1}, {-4, 1}, {-12, 2},
                               {-9, 2}, {-8, 2}, {-7, 2}, {-6, 2}, {-5, 2}, {-4, 2}, {-12, 3}, {-9, 3}, {-8, 3}, {-7, 3}, {-6, 3},
                               {-5, 3}, {-4, 3}, {-3, 3}, {-2, 3}, {-12, 4}, {-11, 4}, {-10, 4}, {-9, 4}, {-8, 4}, {-7, 4}, {-6, 4},
                               {-5, 4}, {-4, 4}, {-12, 5}, {-11, 5}, {-10, 5}, {-9, 5}, {-8, 5}, {-12, 6}, {-11, 6}}) do
      game.surfaces[1].set_tiles{{position = position, name = "midland-yellow-crust"}}
    end

    for k, position in pairs ({{1, -2}, {-10, -1}, {-9, -1}, {-10, 0}, {-9, 0}, {0, 0}, {-3, 1}, {-2, 1}, {-1, 1}, {-11, 2}, {-10, 2},
                               {-3, 2}, {-2, 2}, {-1, 2}, {-11, 3}, {-10, 3}}) do
      game.surfaces[1].set_tiles{{position = position, name = "midland-yellow-crust-2"}}
    end

    for k, position in pairs ({{1, -1}, {1, 0}, {0, 1}, {1, 1}, {2, 1}, {0, 2}, {1, 2}, {2, 2}, {-1, 3}, {0, 3}, {1, 3}}) do
      game.surfaces[1].set_tiles{{position = position, name = "lowland-red-vein-2"}}
    end

    game.surfaces[1].set_tiles{{position = {-7, 5}, name = "lowland-red-vein-dead"}}
    game.surfaces[1].set_tiles{{position = {-10, 6}, name = "lowland-red-vein-dead"}}


    local create_list = {}

    for k, position in pairs ({{-14, -8}, {-13, -8}, {-12, -6}, {-10, -7}, {-8, -7}, {-11, -3}, {-11, 0}}) do
      table.insert(create_list, { name = "dark-mud-decal", position = position, amount = 1})
    end

    for k, position in pairs ({{-7, -9}, {0, -9}, {-1, -8}, {-12, -7}, {-6, -6}}) do
      table.insert(create_list, { name = "light-mud-decal", position = position, amount = 1})
    end

    for k, position in pairs ({{-10, -6}, {3, -7}, {7, -6}, {6, -4}, {7, -4}, {9, -5}, {6, 0}, {2, 1}, {-13, 5}}) do
      table.insert(create_list, { name = "pale-lettuce-lichen-cups-1x1", position = position, amount = 1})
    end

    for k, position in pairs ({{-1, -6}, {-9, -4}, {-2, -5}, {-2, -4}, {5, -4}, {1, -3}, {9, 0}, {-4, 2}, {-3, 2}, {5, 2}, {9, 1}, {12, 1}}) do
      table.insert(create_list, { name = "pale-lettuce-lichen-cups-1x1", position = position, amount = 2})
    end

    for k, position in pairs ({{-12, -8}, {-13, -6}, {-11, -7}, {-8, -6}, {-6, -6}, {-11, -5}, {-9, -4}, {0, -5}, {4, -4}, {7, -4},
                               {-9, -2}, {1, -2}, {2, -2}, {2, 0}, {2, 2}, {-4, 4}, {-12, 6}, {-4, 5}}) do
      table.insert(create_list, { name = "pale-lettuce-lichen-cups-3x3", position = position, amount = 1})
    end

    table.insert(create_list, { name = "pale-lettuce-lichen-cups-3x3", position = {-12, -1}, amount = 2 })

    for k, position in pairs ({{-10, 0}, {2, 3}, {1, 4}}) do
      table.insert(create_list, { name = "pale-lettuce-lichen-cups-6x6", position = position, amount = 1})
    end

    table.insert(create_list, { name = "nerve-roots-veins-dense", position = {3, -9}, amount = 1 })

    table.insert(create_list, { name = "nerve-roots-veins-sparse", position = {-12, 6}, amount = 1 })

    for k, position in pairs ({{-11, -6}, {-8, -6}, {-12, -4}, {-11, -5}, {-10, -5}, {-11, -4}, {-10, -4}, {-6, -5}, {-12, -2},
                               {-10, -3}, {-10, -2}, {-8, -3}, {-9, -2}, {-7, -3}, {-10, -1}}) do
      table.insert(create_list, { name = "knobbly-roots-orange", position = position, amount = 1})
    end

    table.insert(create_list, { name = "knobbly-roots-orange", position = {-10, -6}, amount = 2 })

    table.insert(create_list, { name = "brambles", position = {0, -6}, amount = 1 })
    table.insert(create_list, { name = "brambles", position = {0, -5}, amount = 1 })

    table.insert(create_list, { name = "blood-grape", position = {2, -7}, amount = 1 })

    table.insert(create_list, { name = "matches-small", position = {-5, -5}, amount = 1 })

    for k, position in pairs ({{6, -5}, {9, -4}, {10, -4}, {8, 2}, {10, 1}, {9, 2}, {9, 4}, {11, -6}, {11, -5}, {12, -4}, {11, -3}, {11, 5}}) do
      table.insert(create_list, { name = "coral-water", position = position, amount = 1})
    end

    for k, position in pairs ({{7, -7}, {10, -6}, {6, -4}, {8, -5}, {9, -5}, {9, 0}, {10, 2}, {8, 3}, {10, 3}, {13, -4}, {12, 1}, {12, 3}, {12, 4}}) do
      table.insert(create_list, { name = "coral-water", position = position, amount = 2})
    end

    for k, position in pairs ({{-5, -3}, {-4, -2}, {-5, -1}, {-4, -1}, {-1, -1}, {-11, 1}, {-11, 3}}) do
      table.insert(create_list, { name = "pink-lichen-decal", position = position, amount = 1})
    end

    for k, position in pairs ({{1, 1}, {2, 1}, {2, 2}, {-1, 3}}) do
      table.insert(create_list, { name = "split-gill-1x1", position = position, amount = 1})
    end

    table.insert(create_list, { name = "yellow-lettuce-lichen-cups-1x1", position = {5, -3}, amount = 1 })

    for k, position in pairs ({{-11, -6}, {-10, -6}, {-8, -5}, {-2, -4}}) do
      table.insert(create_list, { name = "yellow-lettuce-lichen-cups-3x3", position = position, amount = 1})
    end

    table.insert(create_list, { name = "yellow-lettuce-lichen-cups-3x3", position = {-11, -2}, amount = 2 })

    for k, position in pairs ({{-10, -6}, {-11, -4}, {-9, -4}, {-3, -4}, {-2, -4}, {1, -3}, {-4, 2}, {-3, 2}, {-12, 4}, {-11, 3},
                               {-10, 4}, {-8, 3}, {-11, 6}, {-7, 5}}) do
      table.insert(create_list, { name = "yellow-lettuce-lichen-1x1", position = position, amount = 1})
    end

    for k, position in pairs ({{-7, -6}, {-5, -7}, {-4, -7}, {-13, -5}, {-12, -5}, {-5, -5}, {-8, -3}, {-3, -3}, {-3, -2}, {0, -2},
                               {-5, -1}, {-11, 1}, {-5, 2}, {-6, 3}}) do
      table.insert(create_list, { name = "yellow-lettuce-lichen-3x3", position = position, amount = 1})
    end

    game.surfaces[1].create_decoratives{decoratives = create_list}

    game.surfaces[1].create_entity{name = "boompuff", position = {-6.9375, -6.375}}
    game.surfaces[1].create_entity{name = "boompuff", position = {-9.375, -0.5}}
    game.surfaces[1].create_entity{name = "water-cane", position = {1.4375, 4.1875}}
    game.surfaces[1].create_entity{name = "water-cane", position = {3.125, 4.4375}}
    game.surfaces[1].create_entity{name = "water-cane", position = {1.1875, 6.1875}}
    game.surfaces[1].create_entity{name = "water-cane", position = {2.125, 6.4375}}
    game.surfaces[1].create_entity{name = "water-cane", position = {3.1875, 6.75}}
    game.surfaces[1].create_entity{name = "water-cane", position = {4.75, 6}}
    game.surfaces[1].create_entity{name = "water-cane", position = {5.4375, 6.125}}
    game.surfaces[1].create_entity{name = "water-cane", position = {7.5625, 6.375}}
  ]]
}

return simulations