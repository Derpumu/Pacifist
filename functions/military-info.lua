require("__Pacifist__.config")

local array = require("__Pacifist__.lib.array")
local data_raw = require("__Pacifist__.lib.data_raw")


-- Entities

local entities = {}
entities.types = PacifistMod.military_entity_types
entities.names = (function()
    local military_entity_names = data_raw.get_all_names_for(entities.types)
    array.remove_all_values(military_entity_names, PacifistMod.exceptions.entity)
    array.append(military_entity_names, PacifistMod.extra.entity)
    return military_entity_names
end)()


-- Equipment

local equipment = {}
equipment.names = (function()
    local military_equipment_names = data_raw.get_all_names_for(PacifistMod.military_equipment_types)
    array.remove_all_values(military_equipment_names, PacifistMod.exceptions.equipment)
    return military_equipment_names
end)()


-- Items

local function is_military_item(item)
    return (item.place_result and array.contains(entities.names, item.place_result))
            or (item.placed_as_equipment_result and array.contains(equipment.names, item.placed_as_equipment_result))
            or array.contains(PacifistMod.extra.item, item.name)
end
local function is_military_capsule(capsule)
    local is_military_subgroup = capsule.subgroup and array.contains(PacifistMod.military_capsule_subgroups, capsule.subgroup)
    local is_military_equipment_remote = capsule.capsule_action and capsule.capsule_action.type == "equipment-remote"
            and array.contains(equipment.names, capsule.capsule_action.equipment)

    return (is_military_subgroup or is_military_equipment_remote)
            and not array.contains(PacifistMod.exceptions.capsule, capsule.name)
end

local military_item_filters = {
    tool = function(tool) return array.contains(PacifistMod.military_science_packs, tool.name) end,
    ammo = function(ammo) return not array.contains(PacifistMod.exceptions.ammo, ammo.name) end,
    gun = function(gun) return not array.contains(PacifistMod.exceptions.gun, gun.name) end,
    capsule = is_military_capsule,
    item = is_military_item,
    ["item-with-entity-data"] = is_military_item,
    armor = function(armor) return array.contains(PacifistMod.extra.armor, armor.name) end
}

local items = {}
items.names = {}

for type, filter in pairs(military_item_filters) do
    items[type] = {}
    for _, item in pairs(data.raw[type]) do
        if filter(item) then
            table.insert(items[type], item.name)
            table.insert(items.names, item.name)
        end
    end
end

if mods["IntermodalContainers"] then
    items.item = items.item or {}
    for _, name in pairs(items.names) do
        local container_name = "ic-container-" .. name
        if data.raw.item[container_name] then
            table.insert(items.item, container_name)
            table.insert(items.names, container_name)
        end
    end
end


--

local military = {
    entities = entities,
    equipment = equipment,
    items = items
}

return military
