local recipes = require("__Pacifist__.functions.recipes")

return {
    exceptions = {
        entity = { "kcat-cat" },
    },

    preprocess = function()
        recipes.remove_ingredient(data.raw, "kcat-cat-luring", "laser-turret")
    end
}
