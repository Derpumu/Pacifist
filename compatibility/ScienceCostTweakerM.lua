local array = require("__Pacifist__.lib.array")
local string = require("__Pacifist__.lib.string")

local function is_waste_processing_recipe(effect)
    return effect.type == "unlock-recipe" and string.starts_with(effect.recipe, "sct-waste-processing")
end

return {
    extra = {
        item = {
            "sct-mil-plating",
            "sct-mil-subplating",
            "sct-mil-circuit1",
            "sct-mil-circuit2",
            "sct-mil-circuit3"
        }
    },
    preprocess = function()
        local military_science_pack_tech = data.raw.technology["sct-military-science-pack"]
        array.remove_in_place(military_science_pack_tech.effects, is_waste_processing_recipe)
    end
}
