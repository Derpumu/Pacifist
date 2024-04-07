PacifistMod = PacifistMod or {}
require("__Pacifist__.functions.debug")

local data_raw = require("__Pacifist__.lib.data_raw")
local array = require("__Pacifist__.lib.array")

local function is_ignored_effect(effect)
    -- PacifistMod.detect_ignored_effects is an array of functions.
    -- If any of them recognizes the effect, it does not count as non-military effect.
    local function matches_effect(fun)
        return fun(effect)
    end

    return array.any_of(PacifistMod.detect_ignored_effects, matches_effect)
end

function PacifistMod.remove_technologies(obsolete_technologies)

    local tech_cache = {}
    local technologies_to_repeat = {}
    for _, technology in pairs(data.raw.technology) do
        tech_cache[technology.name] = {
            fixed = false,
            prerequisites = technology.prerequisites or {},
            transitive_prerequisites = {},
            obsolete = array.contains(obsolete_technologies, technology.name)
        }

        if array.is_empty(tech_cache[technology.name].prerequisites) then
            tech_cache[technology.name].fixed = true
        else
            table.insert(technologies_to_repeat, technology.name)
        end

        if debug_tech(technology.name) then
            debug_log(technology.name .. (tech_cache[technology.name].obsolete and " is obsolete" or " is not obsolete"))
            debug_log(technology.name .. (tech_cache[technology.name].fixed and " is fixed" or " is not fixed"))
        end
    end

    local function try_to_fix(name)
        local prerequisites = {}
        local prerequisites_changed = false

        for _, prerequisite in pairs(tech_cache[name].prerequisites) do
            if not tech_cache[prerequisite].fixed then
                if debug_tech(name) then
                    debug_log(name .. ": prerequisite " .. prerequisite .. " not fixed yet - continue")
                end
                return false
            end
        end

        for _, prerequisite in pairs(tech_cache[name].prerequisites) do
            if tech_cache[prerequisite].obsolete then
                if debug_tech(name) then
                    debug_log(name .. ": prerequisite " .. prerequisite .. " is obsolete")
                end
                for _, new_prerequisite in pairs(tech_cache[prerequisite].prerequisites) do
                    if not array.contains(prerequisites, new_prerequisite) then
                        table.insert(prerequisites, new_prerequisite)
                        if (not data.raw.technology[name].hidden) and (not tech_cache[name].obsolete)  then
                            tech_cache[new_prerequisite].is_prerequisite = true
                        end
                    end
                end

                prerequisites_changed = true
            else
                if tech_cache[name].obsolete then
                    -- mark prerequisites of obsolete technologies as altered to check later whether they are leaves
                    if debug_tech(name) or debug_tech(prerequisite) then
                        debug_log(name .. " obsolete: prerequisite " .. prerequisite .. " marked as altered")
                    end
                    tech_cache[prerequisite].altered = true
                elseif not data.raw.technology[name].hidden then
                    -- a prerequisite of a hidden technology may still be a leaf technology
                    if (debug_tech(prerequisite)) then
                        debug_log(name .. ": " .. prerequisite .. " is a prerequisite")
                    end
                    tech_cache[prerequisite].is_prerequisite = true
                else
                    if debug_tech(prerequisite) or debug_tech(name) then
                        debug_log(name .. " is hidden: " .. prerequisite .. " is not considered a prerequisite")
                    end
                end
                if not array.contains(prerequisites, prerequisite) then
                    table.insert(prerequisites, prerequisite)
                end
            end
        end

        -- transitive prerequisites are all that are not direct prerequisites
        local transitive_prerequisites = {}
        for _, prerequisite in pairs(prerequisites) do
            array.append_unique(transitive_prerequisites, tech_cache[prerequisite].prerequisites)
            array.append_unique(transitive_prerequisites, tech_cache[prerequisite].transitive_prerequisites)
        end

        if prerequisites_changed then
            -- if an added prerequisite is already transitive through another prerequisite, remove it
            array.remove_all_values(prerequisites, transitive_prerequisites)
            data.raw.technology[name].prerequisites = prerequisites
            tech_cache[name].altered = true
            if debug_tech(name) then
                debug_log(name .. " altered: new prerequisites:" .. array.to_string(prerequisites))
            end
        end
        tech_cache[name].prerequisites = prerequisites
        tech_cache[name].transitive_prerequisites = transitive_prerequisites
        tech_cache[name].fixed = true
        return true
    end

    while not array.is_empty(technologies_to_repeat) do
        debug_log("cleaning up: " .. #technologies_to_repeat .. " technologies remaining")
        local technologies_still_not_done = {}
        for _, name in pairs(technologies_to_repeat) do
            if not try_to_fix(name) then
                table.insert(technologies_still_not_done, name)
            end
        end
        assert(#technologies_still_not_done < #technologies_to_repeat,
                #technologies_still_not_done .. " >= " .. #technologies_to_repeat)
        technologies_to_repeat = technologies_still_not_done
    end

    technologies_to_remove = {}
    array.append(technologies_to_remove, obsolete_technologies)
    if array.any_of(technologies_to_remove, debug_tech) then
        debug_log("technologies_to_remove contains techs to debug: ".. array.to_string(technologies_to_remove, "\n "))
    end

    -- some altered techs (e.g. laser) may have become redundant because they are neither prerequisite nor have effects
    for _, technology in pairs(data.raw.technology) do
        if debug_tech(technology.name) then
            debug_log(technology.name .. (tech_cache[technology.name].altered and " is altered" or "is NOT altered"))
            debug_log(technology.name .. (tech_cache[technology.name].is_prerequisite and " IS a prerequisite" or "is no prerequisite"))
        end

        if tech_cache[technology.name].altered
                and (not tech_cache[technology.name].is_prerequisite)
                and (not technology.effects or array.all_of(technology.effects, is_ignored_effect))
                and (not array.contains(technologies_to_remove, technology.name))
        then
            table.insert(technologies_to_remove, technology.name)
            if debug_tech(technology.name) then
                debug_log("additional tech removed: " .. technology.name)
            end
        end
    end

    local function keep(technology_name)
        return array.contains(PacifistMod.exceptions.technology, technology_name)
          or data.raw.technology[technology_name].hidden
    end

    array.remove_in_place(technologies_to_remove, keep)
    debug_log("removing technologies: " .. array.to_string(technologies_to_remove, "\n  "))
    data_raw.remove_all("technology", technologies_to_remove)

    -- some removed technologies may be prerequisites of hidden technologies than need to be removed there
    for _, technology in pairs(data.raw.technology) do
        if technology.hidden then
            array.remove_all_values(technology.prerequisites, technologies_to_remove)
        end
    end
end



-- remove military effects from technologies, returns obsolete technologies that have no effects left
function PacifistMod.remove_military_technology_effects(military_recipes)
    local function is_military(effect)
        if (effect.type == "unlock-recipe") then
            return array.contains(military_recipes, effect.recipe)
        elseif (effect.type == "ammo-damage") or (effect.type == "gun-speed") then
            return not array.contains(PacifistMod.exceptions.ammo_category, effect.ammo_category)
        else
            return array.contains(PacifistMod.military_tech_effects, effect.type)
        end
    end

    local obsolete_technologies = {}
    for _, technology in pairs(data.raw.technology) do
        -- typically, technologies without effect may exist before Pacifist removes military effects
        -- therefore, we ignore those technologies here, except for special circumstances (listed in extra.technology)
        if technology.effects and (not array.is_empty(technology.effects) or array.contains(PacifistMod.extra.technology, technology.name)) then
            local old_effect_count = #technology.effects
            array.remove_in_place(technology.effects, is_military)
            local effects_removed = #technology.effects < old_effect_count

            -- some mods define effects for multiple technologies that should not make a technology non-military
            -- an example is the "counts towards age progression" effect in Exotic Industries
            if array.is_empty(technology.effects) or
                ( effects_removed and array.all_of(technology.effects, is_ignored_effect) )
            then
                table.insert(obsolete_technologies, technology.name)
            end
        end
    end
    return obsolete_technologies
end

