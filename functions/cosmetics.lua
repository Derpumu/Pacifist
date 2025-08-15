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
    data_raw:remove_all("tips-and-tricks-item", config.extra.tips_and_tricks_items, "extra.tips_and_tricks_items")
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
        _remove_menu_simulations(data_raw, config)
        _remove_tips_and_tricks(data_raw, config)
    end
}

return cosmetics