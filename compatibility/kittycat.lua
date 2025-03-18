local array = require("__Pacifist__.lib.array") --[[@as Array]]

return {
    exceptions = {
        entity = { "cat" },
    },

    preprocess = function()
        array.remove_in_place(data.raw.recipe["zcat-luring"].ingredients, function(i) return i.name == "laser-turret" end)
    end
}
