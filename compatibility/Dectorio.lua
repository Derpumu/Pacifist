local array = require("__Pacifist__.lib.array") --[[@as Array]]

local _remove_military_science_signal = function ()
	for _, lamp in pairs(data.raw.lamp) do
        array.remove_in_place(lamp.signal_to_color_mapping, function(mapping) return mapping.name == "military-science-pack" end)
	end
end

local Dectorio_config = {
    preprocess = _remove_military_science_signal
}

return Dectorio_config