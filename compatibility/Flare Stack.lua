return {
    extra = {
        get_derived_recipes = function(item_name, type)
            return type .. "-" .. item_name .. "-incineration"
        end
    }
}