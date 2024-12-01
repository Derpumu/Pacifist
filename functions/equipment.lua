local array = require("__Pacifist__.lib.array") --[[@as Array]]

require("__Pacifist__.lib.debug")

---@class Equipment
local equipment = {}

---@class EquipmentInfo : { [Type]: Name[] }

---@param data_raw DataRaw
---@param config Config
---@return EquipmentInfo
equipment.collect_info = function(data_raw, config)
    local equipment_info = {}
    for _, type in pairs(config.types.military_equipment) do
        equipment_info[type] = data_raw:get_all_names_for(type)
        array.remove_all_values(equipment_info[type], config.exceptions.equipment)
    end

    dump_table(equipment_info)
    return equipment_info
end


---@param data_raw DataRaw
---@param equipment_info EquipmentInfo
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