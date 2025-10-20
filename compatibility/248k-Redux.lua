require("__Pacifist__.functions.pacify_item")


local _pacify_laser = function()
    -- temporarily remove the results of a second recipe to make pacify_item work
    local wh_fu_laser_recipe = data.raw.recipe["gr_white_hole_cycle_fu_laser_item_recipe"]
    local wh_fu_laser_results = wh_fu_laser_recipe.results
    wh_fu_laser_recipe.results = nil
    pacify_item("laser-turret", "fu_laser_item")
    wh_fu_laser_recipe.results = wh_fu_laser_results

    local laser_tech = data.raw.technology["fu_laser_tech"]
    if data.raw.technology["laser"] then
        table.insert(laser_tech.prerequisites, "laser")
    end
end


return {
    extra = {
        get_derived_recipes = function(original_name)
            return "fu_burn_"..original_name.."_recipe"
        end
    },

    preprocess = {_pacify_laser}
}