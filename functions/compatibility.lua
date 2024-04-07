local compatibility = {}

local array = require("__Pacifist__.lib.array")

local mod_info = {
    exceptions = {},
    extra = {}
}

for mod_name, version in pairs(mods) do
    local status, module = pcall(require,"__Pacifist__.compatibility." .. mod_name)
    module = status and module or {}

    for section_name, info_section in pairs(mod_info) do
        if module[section_name] then
            for subsection_name, mod_subsection in pairs(module[section_name]) do
                info_section[subsection_name] = info_section[subsection_name] or {}
                if type(mod_subsection) == "table" then
                    array.append(info_section[subsection_name], mod_subsection)
                else
                    array.append(info_section[subsection_name], { tostring(mod_subsection) })
                end
            end
        end
    end
end

function compatibility.extend_config()
    for section_name, info_section in pairs(mod_info) do
        for subsection_name, info_subsection in pairs(info_section) do
            array.append(PacifistMod[section_name][subsection_name], info_subsection)
        end
    end

    if mods["Krastorio2"] then
        -- tag matter as void item to remove military item to matter recipes
        array.append(PacifistMod.void_items, { "kr-void", "matter" })
    end
    if mods["pyindustry"] then
        table.insert(PacifistMod.void_recipe_suffix, "-pyvoid")
    end

    if mods["exotic-industries"] then
        local function is_age_progression(effect)
            return effect.type == "nothing"
                    and effect.effect_description
                    and type(effect.effect_description) == "table"
                    and array.contains(effect.effect_description, "description.tech-counts-for-age-progression")
        end
        table.insert(PacifistMod.detect_ignored_effects, is_age_progression)
        array.append(PacifistMod.military_main_menu_simulations, { "ei_menu_3", "ei_menu_5" })
    end
end

function compatibility.walls_required()
    return (settings.startup["dectorio-walls"] and settings.startup["dectorio-walls"].value)
        or mods["angelsbioprocessing"]
end

function compatibility.shields_required()
    return mods["500BotStart"] ~= nil
end

return compatibility