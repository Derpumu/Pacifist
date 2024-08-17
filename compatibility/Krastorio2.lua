local kr_config = {
    exceptions = {
        gun = "dolphin-gun"
    },
    extra = {
        misc = {
            { "research-achievement", "destroyer-of-worlds" },
            { "tips-and-tricks-item", "kr-creep" },
            { "tips-and-tricks-item", "kr-new-gun-play" },
            { "build-entity-achievement", "death-on-wheels" }
        },
        item = { "biters-research-data", "biomass" },
        entity = { "kr-bio-lab" }
    },
    ignore = {
        result_items = { "kr-void", "matter" }
    },
    preprocess = function()
        data.raw["tile"]["kr-creep"].minable = nil
        local biotech = data.raw.technology["kr-bio-processing"]
        if biotech then
            biotech.icon = "__Pacifist__/graphics/technology/kr-fertilizers.png"
        end
    end
}

if settings.startup["pacifist-remove-tank"].value then
    table.insert(kr_config.extra.entity, "kr-advanced-tank")
end

return kr_config

