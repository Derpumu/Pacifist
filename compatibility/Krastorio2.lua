-- TODO: modular armor depends on heavy armor

local _remove_fish_launch_product = function()
    -- Krastorio sets the launch product to a gun we will remove.
    data.raw.capsule["raw-fish"].rocket_launch_products = nil
end

return {
    extra = {
        get_derived_recipes = function(original_name)
            return "kr-crush-" .. original_name
        end
    },
    preprocess = {
        _remove_fish_launch_product
    }
}

