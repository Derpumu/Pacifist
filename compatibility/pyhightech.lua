local array = require("__Pacifist__.lib.array") --[[@as Array]]

local _fix_random_science_pack = function()
    local recipe = data.raw["recipe"]["random-science-pack"]
    array.remove_in_place(recipe.results, function(result) return result.name == "military-science-pack" end)
end

return {
    exceptions = {
        technology = {
            "space-science-pack"
        },
    },
    preprocess = {_fix_random_science_pack}
}