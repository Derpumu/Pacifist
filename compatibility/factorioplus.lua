local array = require("__Pacifist__.lib.array") --[[@as Array]]

local remove_shields = settings.startup["pacifist-remove-shields"].value
assert(remove_shields)

---comment
---@param loot_item data.LootItem
local _is_military_loot = function(loot_item)
    local name = loot_item.item
    return
        (remove_shields and string.find(name, "energy%-shield"))
        or string.find(name, "laser%-defense")
end

---@param name any
---@return integer|nil
local _is_military_name = function(name)
    return string.find(name, "weapons")
        or string.find(name, "turrets")
        or string.find(name, "grenades")
        or string.find(name, "military")
        or string.find(name, "magazine")
        or string.find(name, "shell")
        or string.find(name, "rocket")
end

---@param entity data.SimpleEntityPrototype|data.EntityWithHealthPrototype
local _adjust_entity = function(entity)
    if not string.find(entity.name, "abandonment") then return end

    local name = entity.name
    if _is_military_name(name) then
        data.raw[entity.type][name] = nil
        return
    end

    if entity.loot and not string.find(name, "barren") then
        debug_log("factorioplus: check " .. name)
        array.remove_in_place(entity.loot, _is_military_loot)
    end

    entity.dying_trigger_effect = nil -- remove spawning of loot proxies
end

local _adjust_abandonments = function()
    for _, container in pairs(data.raw.container) do
        _adjust_entity(container)
    end

    for _, entity in pairs(data.raw["simple-entity"]) do
        _adjust_entity(entity)
    end
end

local _remove_egg_streams = function ()
    for name, _ in pairs(data.raw.stream) do
        if string.find(name, "egg%-stream") then
            data.raw.stream[name] = nil
        end
    end
end

local factorioplus_config = {
    preprocess = { _adjust_abandonments, _remove_egg_streams }
}

return factorioplus_config