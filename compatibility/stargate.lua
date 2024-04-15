return {
    exceptions = { entity = "stargate-sensor" },
    preprocess = function()
        data.raw["land-mine"]["stargate-sensor"].minable = nil
    end
}
