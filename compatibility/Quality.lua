return {
    extra = {
        get_derived_recipes = function(original_name)
            return original_name .. "-recycling"
        end
    }
}