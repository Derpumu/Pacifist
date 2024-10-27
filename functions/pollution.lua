local types = require("types")

local _remove_from_energy_sources = function(data_raw)
    data_raw:apply_to_all(types.entities_with_energy_source,
       function(entity)
           -- some entities have both a burner and an energy_source
           if entity.energy_source then
               entity.energy_source.emissions_per_minute = nil
           end
           if entity.burner then
               entity.burner.emissions_per_minute = nil
           end
       end
    )
end

local _remove_from_modules = function(data_raw)
    for _, module in pairs(data_raw.module) do
        module.effect.pollution = nil
    end
    data_raw:apply_to_all(types.entities_with_energy_source,
        function(entity)
            if entity.effect_receiver and entity.effect_receiver.base_effect then
                entity.effect_receiver.base_effect = nil
            end
        end
    )
end

local pollution = {}

pollution.process = function(data_raw)
    if not settings.startup["pacifist-remove-pollution"].value then return end

    _remove_from_energy_sources(data_raw)
    _remove_from_modules(data_raw)
    --[[
     TODO:
     - recipes (allow_pollution*)
     - map settings
     - mapgen presets
    ]]
end

return pollution