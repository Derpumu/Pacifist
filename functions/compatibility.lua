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


    if mods["shield-projector"] then
        array.append(PacifistMod.exceptions.entity, { "shield-projector" })
    end
    if mods["Nanobots"] then
        array.append(PacifistMod.exceptions.ammo, { "ammo-nano-constructors", "ammo-nano-termites" })
        array.append(PacifistMod.exceptions.ammo_category, { "nano-ammo" })
        array.append(PacifistMod.exceptions.equipment, {
            "equipment-bot-chip-feeder",
            "equipment-bot-chip-items",
            "equipment-bot-chip-nanointerface",
            "equipment-bot-chip-trees"
        })
        array.append(PacifistMod.exceptions.gun, { "gun-nano-emitter" })
    end
    if mods["Krastorio2"] then
        array.append(PacifistMod.exceptions.gun, { "dolphin-gun" })
        array.append(PacifistMod.extra.misc, {
            { "research-achievement", "destroyer-of-worlds" },
            { "tips-and-tricks-item", "kr-creep" },
            { "tips-and-tricks-item", "kr-new-gun-play" }
        })
        array.append(PacifistMod.extra.item, { "biters-research-data", "biomass" })
        array.append(PacifistMod.extra.entity, { "kr-bio-lab" })
        -- tag matter as void item to remove military item to matter recipes
        array.append(PacifistMod.void_items, { "kr-void", "matter" })
    end
    if mods["pyindustry"] then
        table.insert(PacifistMod.void_recipe_suffix, "-pyvoid")
    end
    if mods["stargate"] then
        array.append(PacifistMod.exceptions.entity, { "stargate-sensor" })
    end
    if mods["Teleporters"] then
        array.append(PacifistMod.exceptions.entity, { "teleporter" })
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
    if mods["Companion_Drones"] then
        array.append(PacifistMod.exceptions.equipment, { "companion-shield-equipment", "companion-defense-equipment" })
    end

    if mods["blueprint-shotgun"] then
        array.append(PacifistMod.exceptions.ammo, { "item-canister" })
        array.append(PacifistMod.exceptions.gun, { "blueprint-shotgun" })
    end

    if mods["ch-concentrated-solar"] then
        array.append(PacifistMod.exceptions.entity, { "chcs-heliostat-mirror" })
    end

    if mods["pyalternativeenergy"] then
        array.append(PacifistMod.exceptions.entity, { "aerial-blimp-mk01", "aerial-blimp-mk02", "aerial-blimp-mk03", "aerial-blimp-mk04" })
    end

    if mods["pyalienlife"] then
        local units = {
            "caravan", "flyavan", "nukavan", "caravan-turd", "flyavan-turd", "nukavan-turd",
            "chorkok", "gobachov", "huzu", "ocula"
        }
        array.append(PacifistMod.exceptions.entity, units)
    end

    if mods["ScienceCostTweakerM"] then
        array.append(PacifistMod.extra.item, { "sct-mil-plating", "sct-mil-subplating", "sct-mil-circuit1", "sct-mil-circuit2", "sct-mil-circuit3" })
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