local types = require("types")

local _remove_from_energy_sources = function(data_raw)
    for _, type in pairs(types.entities_with_energy_source) do
        for _, entity in pairs(data_raw[type] or {}) do
            -- some entities have both a burner and an energy_source
            if entity.energy_source then
                entity.energy_source.emissions_per_minute = nil
            end
            if entity.burner then
                entity.burner.emissions_per_minute = nil
            end
        end
    end
end


local pollution = {}

pollution.process = function(data_raw)
    if not settings.startup["pacifist-remove-pollution"].value then return end

    _remove_from_energy_sources(data_raw)
    --[[
     TODO:
     - Module effects
     - recipes (allow_pollution*)
     - map settings
     - mapgen presets
    ]]
end

return pollution