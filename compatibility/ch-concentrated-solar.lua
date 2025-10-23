local _remove_achievements = function()
    data.raw["build-entity-achievement"]["chcs-bird-murderer"] = nil
end

return {
    preprocess = {_remove_achievements}
}
