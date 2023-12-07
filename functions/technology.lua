PacifistMod = PacifistMod or {}
require("__Pacifist__.functions.debug")

local data_raw = require("__Pacifist__.lib.data_raw")
local array = require("__Pacifist__.lib.array")

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
    end

    local function try_to_fix(name)
        local prerequisites = {}
        local prerequisites_changed = false

        for _, prerequisite in pairs(tech_cache[name].prerequisites) do
            if not tech_cache[prerequisite].fixed then
                return false
            end
            if tech_cache[prerequisite].obsolete then
                array.append_unique(prerequisites, tech_cache[prerequisite].prerequisites)
                prerequisites_changed = true
            else
                if tech_cache[name].obsolete then
                    -- mark prerequisites of obsolete technologies as altered to check later whether they are leaves
                    tech_cache[prerequisite].altered = true
                else
                    tech_cache[prerequisite].is_prerequisite = true
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
    -- some altered techs (e.g. laser) may have become redundant because they are neither prerequisite nor have effects
    for _, technology in pairs(data.raw.technology) do
        if tech_cache[technology.name].altered
                and (not tech_cache[technology.name].is_prerequisite)
                and (not technology.effects or array.is_empty(technology.effects))
                and (not array.contains(technologies_to_remove, technology.name))
        then
            table.insert(technologies_to_remove, technology.name)
        end
    end

    array.remove_all_values(technologies_to_remove, PacifistMod.exceptions.technology)
    debug_log("removing technologies: " .. array.to_string(technologies_to_remove, "\n  "))
    data_raw.remove_all("technology", technologies_to_remove)
end

local function is_ignored_effect(effect)
    -- PacifistMod.detect_ignored_effects is an array of functions.
    -- If any of them recognizes the effect, it does not count as non-military effect.
    local function matches_effect(fun)
        return fun(effect)
    end

    return array.any_of(PacifistMod.detect_ignored_effects, matches_effect)
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
        if technology.effects and not array.is_empty(technology.effects) then
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

