PacifistMod = PacifistMod or {}

local data_raw = require("__Pacifist__.lib.data_raw")
local array = require("__Pacifist__.lib.array")

local function remove_obsolete_prerequisites(technology, obsolete_technologies, prerequisite_cache)
    local name = technology.name
    if prerequisite_cache[name] and prerequisite_cache[name].fixed then
        return
    end

    if not technology.prerequisites or array.is_empty(technology.prerequisites) then
        prerequisite_cache[name] = { fixed = true, transitive_prerequisites = {}, altered = false }
        return
    end

    -- step 1: collect all non-obsolete transitive prerequisites
    local transitive_prerequisites = {}
    for _, prerequisite_name in pairs(technology.prerequisites) do
        remove_obsolete_prerequisites(data.raw.technology[prerequisite_name], obsolete_technologies, prerequisite_cache)

        if not array.contains(obsolete_technologies, prerequisite_name) then
            array.append(transitive_prerequisites, prerequisite_cache[prerequisite_name].transitive_prerequisites)
            table.insert(transitive_prerequisites, prerequisite_name)
        end
    end

    -- step 2: add prerequisites of obsolete prerequisites as direct prerequisites
    --         unless they already are transitive prerequisites
    local had_obsolete_prerequisite = false
    for _, prerequisite_name in pairs(technology.prerequisites) do
        if array.contains(obsolete_technologies, prerequisite_name) then
            had_obsolete_prerequisite = true
            local obsolete_prerequisite = data.raw.technology[prerequisite_name]
            for _, pre_prerequisite_name in pairs(obsolete_prerequisite.prerequisites or {}) do
                if not array.contains(transitive_prerequisites, pre_prerequisite_name) then
                    table.insert(technology.prerequisites, pre_prerequisite_name)
                    table.insert(transitive_prerequisites, pre_prerequisite_name)
                end
            end
        end
    end

    -- step 3 remove the obsolete prerequisites
    array.remove_all_values(technology.prerequisites, obsolete_technologies)
    prerequisite_cache[name] = {
        fixed = true,
        transitive_prerequisites = transitive_prerequisites,
        altered = had_obsolete_prerequisite
    }
end

function PacifistMod.remove_technologies(obsolete_technologies)
    local prerequisite_cache = {}
    for _, technology in pairs(data.raw.technology) do
        remove_obsolete_prerequisites(technology, obsolete_technologies, prerequisite_cache)

        if not array.contains(obsolete_technologies, technology.name) then
            for _, prerequisite_name in pairs(technology.prerequisites or {}) do
                prerequisite_cache[prerequisite_name].is_prerequisite = true
            end
        end
    end

    -- some altered techs (e.g. laser) may have become redundant because they are neither prerequisite nor have effects
    local redundant_leaf_technologies = {}
    for _, technology in pairs(data.raw.technology) do
        if prerequisite_cache[technology.name].altered
                and (not prerequisite_cache[technology.name].is_prerequisite)
                and (not technology.effects or array.is_empty(technology.effects))
                and not array.contains(obsolete_technologies, technology.name)
        then
            table.insert(redundant_leaf_technologies, technology.name)
        end
    end

    data_raw.remove_all("technology", obsolete_technologies)
    data_raw.remove_all("technology", redundant_leaf_technologies)
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

