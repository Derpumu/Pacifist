local array = require("__Pacifist__.lib.array") --[[@as Array]]

local _remove_esmk3 = function()
    if not settings.startup["pacifist-remove-shields"].value then return end

    local is_esmk3 = function(ingredient) return ingredient.name == "pamk3-esmk3" end
    array.remove_in_place(data.raw["recipe"]["pamk3-se"].ingredients, is_esmk3)
end

return {
    preprocess = _remove_esmk3
}