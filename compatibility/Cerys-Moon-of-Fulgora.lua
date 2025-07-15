local add_asteroid_density = function()
    local cerys = data.raw["planet"]["cerys"]
    cerys.surface_properties["pacifist-asteroid-density"] = 0.1
end

return {
    preprocess = {
        add_asteroid_density,
    }
}
