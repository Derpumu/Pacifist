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
        or string.find(name, "bio%-science%-pack")
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

local _air_scrubber_corpse_workaround = function()
    -- workaround for https://github.com/Derpumu/Pacifist/issues/112:
    data.raw["electric-energy-interface"]["air-scrubber"].corpse = nil
    data.raw["electric-energy-interface"]["air-scrubber-large"].corpse = nil
end

local factorioplus_config = {
    extra = {
        tool = {
            "bio-science-pack",
        },
        capsule = {
            "meaty-chunks",
            "chunky-meat",
        },
        item = {
            "bio-fuel",
        },
        entity = {
            "air-scrubber",
            "air-scrubber-large",
        },
        recipe = {
            "fish-processing",
            "resin-extraction",
        },
    },
    preprocess = { _adjust_abandonments, _remove_egg_streams, _air_scrubber_corpse_workaround},
}

return factorioplus_config