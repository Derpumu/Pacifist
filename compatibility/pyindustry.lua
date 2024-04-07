local string = require("__Pacifist__.lib.string")

local function is_pyvoid_recipe(recipe)
    return string.ends_with(recipe.name, "-pyvoid")
end

return {
    ignore = {
        recipe_pred = { is_pyvoid_recipe }
    }
}
