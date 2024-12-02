local array = require("__Pacifist__.lib.array") --[[@as Array]]

---@param data_raw DataRaw
---@param config Config
local _relabel_gun_slots = function(data_raw, config)
    local x_icon = "__core__/graphics/set-bar-slot.png"
    local tool_icon = "__core__/graphics/icons/mip/empty-robot-material-slot.png"
    local icon_types = { "gun", "ammo" }
    for _, type in pairs(icon_types) do
        local icon = array.is_empty(config.exceptions[type]) and x_icon or tool_icon
        data_raw["utility-sprites"].default["empty_" .. type .. "_slot"].filename = icon
    end
end

---@param data_raw DataRaw
local _relabel_item_groups = function(data_raw)
    if data_raw["item-group"].combat then
        data_raw["item-group"].combat.icon = "__Pacifist__/graphics/item-group/equipment.png"
    end
    if data_raw["item-group"].enemies then
        data_raw["item-group"].enemies.icon = "__Pacifist__/graphics/item-group/units.png"
    end
end

---@param data_raw DataRaw
---@param config Config
local _remove_menu_simulations = function(data_raw, config)
    local simulations = data_raw["utility-constants"].default.main_menu_simulations
    for _, name in pairs(config.extra.main_menu_simulations) do
        simulations[name] = nil
    end
end

---@param data_raw DataRaw
---@param config Config
local _remove_tips_and_tricks = function(data_raw, config)
    data_raw:remove_all("tips-and-tricks-item", config.extra.tips_and_tricks_items, "extra.extra.tips_and_tricks_items")
end

--[[ TODO:
    - mapgen presets
    - unit attacks
    - signals?
--]]

local cosmetics = {
    ---@param data_raw DataRaw
    ---@param config Config
    process = function(data_raw, config)
        _relabel_gun_slots(data_raw, config)
        _relabel_item_groups(data_raw)
        _remove_menu_simulations(data_raw, config)
        _remove_tips_and_tricks(data_raw, config)
    end
}

return cosmetics