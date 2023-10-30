PacifistMod = PacifistMod or {}
require("__Pacifist__.functions.debug")

local data_raw = require("__Pacifist__.lib.data_raw")
local array = require("__Pacifist__.lib.array")

function PacifistMod.remove_technologies(obsolete_technologies)

    local tech_cache = {}
    local technologies_to_repeat = {}
    for _, technology in pairs(data.raw.technology) do
        if not technology.prerequisites or array.is_empty(technology.prerequisites) then
            tech_cache[technology.name] = {
                fixed = true,
                prerequisites = {},
                transitive_prerequisites = {},
                obsolete = array.contains(obsolete_technologies, technology.name)
            }
        else
            table.insert(technologies_to_repeat, technology.name)
            tech_cache[technology.name] = {
                fixed = false,
                prerequisites = technology.prerequisites,
                transitive_prerequisites = {},
                obsolete = array.contains(obsolete_technologies, technology.name)
            }
        end
    end

    local function try_to_fix(name)
        local transitive_prerequisites = {}
        local prerequisites = {}

        local prerequisites_changed = false
        for _, prerequisite in pairs(tech_cache[name].prerequisites) do
            if not tech_cache[prerequisite].fixed then
                return false
            end
            array.append(transitive_prerequisites, tech_cache[prerequisite].transitive_prerequisites)
            if tech_cache[prerequisite].obsolete then
                array.append(prerequisites, tech_cache[prerequisite].transitive_prerequisites)
                prerequisites_changed = true
            else
                tech_cache[prerequisite].is_prerequisite = true
                table.insert(prerequisites, prerequisite)
            end
        end

        tech_cache[name].prerequisites = prerequisites
        if prerequisites_changed then
            data.raw.technology[name].prerequisites = prerequisites
            tech_cache[name].altered = true
        end
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


    -- some altered techs (e.g. laser) may have become redundant because they are neither prerequisite nor have effects
    for _, technology in pairs(data.raw.technology) do
        if tech_cache[technology.name].altered
                and (not tech_cache[technology.name].is_prerequisite)
                and (not technology.effects or array.is_empty(technology.effects))
        then
            data_raw.remove("technology", technology.name)
        end
    end
    data_raw.remove_all("technology", obsolete_technologies)
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
            array.remove_in_place(technology.effects, is_military)
            if array.is_empty(technology.effects) then
                table.insert(obsolete_technologies, technology.name)
            end
        end
    end
    return obsolete_technologies
end

