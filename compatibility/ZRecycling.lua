local string = require("__Pacifist__.lib.string")

return {
    ignore = {
        recipe_pred = function(recipe) return string.starts_with(recipe.name, "dry411srev-") end
    }
}
