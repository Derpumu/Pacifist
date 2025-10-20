require("__Pacifist__.functions.pacify_item")

local _pacify_abomb = function()
    pacify_item("atomic-bomb", "maraxsis-big-cliff-explosives")
end

return {
    exceptions = {
        entity = {
            "maraxsis-tropical-fish-1",
            "maraxsis-tropical-fish-2",
            "maraxsis-tropical-fish-3",
            "maraxsis-tropical-fish-4",
            "maraxsis-tropical-fish-5",
            "maraxsis-tropical-fish-6",
            "maraxsis-tropical-fish-7",
            "maraxsis-tropical-fish-8",
            "maraxsis-tropical-fish-9",
            "maraxsis-tropical-fish-10",
            "maraxsis-tropical-fish-11",
            "maraxsis-tropical-fish-12",
            "maraxsis-tropical-fish-13",
            "maraxsis-tropical-fish-14",
            "maraxsis-tropical-fish-15",
        },
    },
    extra = {
        item = { "maraxsis-military-science-pack-research-vessel" },
        technology = { "atomic-bomb" },
    },
    preprocess = _pacify_abomb
}
