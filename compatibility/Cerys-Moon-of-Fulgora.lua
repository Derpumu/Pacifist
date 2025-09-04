require("__Pacifist__.functions.pacify_item")
local add_asteroid_density = function()
    local cerys = data.raw["planet"]["cerys"]
    cerys.surface_properties["pacifist-asteroid-density"] = 0.1
end

local pacify_hydrogen_bomb = function()
    convert_to_item("cerys-hydrogen-bomb")
end

return {
    preprocess = {
        add_asteroid_density,
        pacify_hydrogen_bomb,
    },
}
