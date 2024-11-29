local array = require("__Pacifist__.lib.array") --[[@as Array]]

require("__Pacifist__.lib.debug")

local equipment = {}

equipment.collect_info = function(data_raw, config)
    local equipment_info = {}
    for _, type in pairs(config.types.military_equipment) do
        equipment_info[type] = data_raw:get_all_names_for(type)
    end

    for type, names in pairs(config.exceptions.equipment) do
        if equipment_info[type] then
            array.remove_all(equipment_info[type], names)
        end
    end

    dump_table(equipment_info)
    return equipment_info
end

equipment.process = function(data_raw, equipment_info)
    for type, names in pairs(equipment_info) do
        data_raw:remove_all(type, names)
    end

    --[[
     TODO: remove references to deleted EquipmentIDs:
     see https://lua-api.factorio.com/latest/types/EquipmentID.html
    ]]
end

return equipment