return {
    preprocess = function()
        local heavy_vest_technology = data.raw.technology["heavy-armor"]
        if heavy_vest_technology then
            heavy_vest_technology.localised_name = { "technology-name.pamk3-heavy-vest" }
            heavy_vest_technology.localised_description = { "technology-description.pamk3-heavy-vest" }
        end
    end
}
