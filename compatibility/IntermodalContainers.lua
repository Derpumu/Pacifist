return {
    extra = {
        get_derived_items = function(original_type, original_name)
            return { type = "item", name = "ic-container-" .. original_name }
        end
    }
}