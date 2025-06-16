local recipes = require("__Pacifist__.functions.recipes")

return {
    exceptions = {
        entity = { "cat" },
    },

    preprocess = function()
        recipes.remove_ingredient(data.raw, "zcat-luring", "laser-turret")
    end
}
