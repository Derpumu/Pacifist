return {
    extra = {
        get_derived_recipes = function(original_name)
            return "rf-" .. original_name
        end
    }
}
