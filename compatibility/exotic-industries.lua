local array = require("__Pacifist__.lib.array")

local function is_age_progression(effect)
    return effect.type == "nothing"
            and effect.effect_description
            and type(effect.effect_description) == "table"
            and array.contains(effect.effect_description, "description.tech-counts-for-age-progression")
end

return {
    ignore = {
        effects_pred = { is_age_progression }
    },
    extra = {
        main_menu_simulations = { "ei_menu_3", "ei_menu_5" }
    }
}
