local array = require("__Pacifist__.lib.array")
local string = require("__Pacifist__.lib.string")

local function clone_military_to_repair_pack()
    local military_tech = data.raw.technology["military"]
    if military_tech then

        -- create a clone of the military tech just for the repair pack with appropriate name and icon
        local repair_pack_tech = table.deepcopy(military_tech)
        repair_pack_tech.name = "pacifist-repair-pack"
        repair_pack_tech.localised_name = { "item-name.repair-pack" }
        if mods["boblogistics"] and not mods["reskins-bobs"] then
            repair_pack_tech.icon = "__boblogistics__/graphics/icons/technology/repair-pack.png"
            repair_pack_tech.icon_size = 32
            repair_pack_tech.icon_mipmaps = 1
        else
            repair_pack_tech.icon = "__base__/graphics/icons/repair-pack.png"
            repair_pack_tech.icon_size = 64
            repair_pack_tech.icon_mipmaps = 4
        end
        data:extend({ repair_pack_tech })

        -- remove repair pack recipe unlocks from military tech. Pacifist's general processing will remove it later
        -- note: string.ends_with is used to include unlocks of generic recycling recipes and similar
        local function is_repair_pack_unlock(effect)
            return effect.type == "unlock-recipe" and string.ends_with(effect.recipe, "repair-pack")
        end
        array.remove_in_place(military_tech.effects, is_repair_pack_unlock)

        -- repair pack 2 should have repair pack as prerequisite
        local repair_pack_2_tech = data.raw.technology["bob-repair-pack-2"]
        if repair_pack_2_tech then
            array.append(repair_pack_2_tech.prerequisites, { "pacifist-repair-pack" })
        end
    end
end

return {
    preprocess = clone_military_to_repair_pack
}
