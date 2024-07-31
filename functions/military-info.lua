require("__Pacifist__.config")

local array = require("__Pacifist__.lib.array")
local data_raw = require("__Pacifist__.lib.data_raw")
local string = require("__Pacifist__.lib.string")


-- Entities
local function _find_military_entities()
    local entities = {
        types = {}
    }
    array.append(entities.types, PacifistMod.military_entity_types)
    array.append(entities.types, PacifistMod.hide_only_entity_types)
    entities.names = data_raw.get_all_names_for(entities.types)
    array.remove_all_values(entities.names, PacifistMod.exceptions.entity)
    array.append(entities.names, PacifistMod.extra.entity)
    PacifistMod.military_entities = entities
end


-- Equipment
local function _find_military_equipment()
    local equipment = {
        names = data_raw.get_all_names_for(PacifistMod.military_equipment_types)
    }
    array.remove_all_values(equipment.names, PacifistMod.exceptions.equipment)
    PacifistMod.military_equipment = equipment
end


-- Items
local function _is_military_item(item)
    return (item.place_result and array.contains(PacifistMod.military_entities.names, item.place_result))
            or (item.placed_as_equipment_result and array.contains(PacifistMod.military_equipment.names, item.placed_as_equipment_result))
            or array.contains(PacifistMod.extra.item, item.name)
end
local function _is_military_capsule(capsule)
    local is_military_subgroup = capsule.subgroup and array.contains(PacifistMod.military_capsule_subgroups, capsule.subgroup)
    local is_military_equipment_remote = capsule.capsule_action and capsule.capsule_action.type == "equipment-remote"
            and array.contains(PacifistMod.military_equipment.names, capsule.capsule_action.equipment)

    return (is_military_subgroup or is_military_equipment_remote)
            and not array.contains(PacifistMod.exceptions.capsule, capsule.name)
end
local _military_item_filters = {
    tool = function(tool) return array.contains(PacifistMod.extra.science_packs, tool.name) end,
    ammo = function(ammo) return not array.contains(PacifistMod.exceptions.ammo, ammo.name) end,
    gun = function(gun) return not array.contains(PacifistMod.exceptions.gun, gun.name) end,
    capsule = _is_military_capsule,
    item = _is_military_item,
    ["item-with-entity-data"] = _is_military_item,
    armor = function(armor) return array.contains(PacifistMod.extra.armor, armor.name) end
}

local items = {}
for type, filter in pairs(_military_item_filters) do
    items[type] = {}
    for _, item in pairs(data.raw[type]) do
        if filter(item) then
            table.insert(items[type], item.name)
        end
    end
end

for _, derived_item_function in pairs(PacifistMod.extra.get_derived_items) do
    for original_type, name_list in pairs(items) do
        for _, orginal_name in pairs(name_list) do
            local derived = derived_item_function(original_type, orginal_name)
            if data.raw[derived.type] and data.raw[derived.type][derived.name] then
                items[derived.type] = items[derived.type] or {}
                table.insert(items[derived.type], derived.name)
            end
        end
    end
end

local item_names = {}
for _, name_list in pairs(items) do
    array.append(item_names, name_list)
end

_find_military_entities()
_find_military_equipment()

local military = {
    entities = PacifistMod.military_entities,
    equipment = PacifistMod.military_equipment,
    items = items,
    item_names = item_names
}

return military
