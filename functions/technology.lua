PacifistMod = PacifistMod or {}

local data_raw = require("__Pacifist__.lib.data_raw")
local array = require("__Pacifist__.lib.array")

local function remove_obsolete_prerequisites(technology, obsolete_technologies, prerequisite_cache)
    local name = technology.name
    if prerequisite_cache[name] and prerequisite_cache[name].fixed then
        return
    end

    if not technology.prerequisites then
        prerequisite_cache[name] = { fixed = true, transitive_prerequisites = {} }
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
    for _, prerequisite_name in pairs(technology.prerequisites) do
        if array.contains(obsolete_technologies, prerequisite_name) then
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
    prerequisite_cache[name] = { fixed = true, transitive_prerequisites = transitive_prerequisites }
    prerequisite_cache[name].fixed = true
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

    -- some techs (e.g. laser) may have become redundant because the are neither prerequisite nor have effects
    local redundant_leaf_technologies = {}
    for _, technology in pairs(data.raw.technology) do
        if not prerequisite_cache[technology.name].is_prerequisite
                and (not technology.effects or array.is_empty(technology.effects))
                and not array.contains(obsolete_technologies, technology.name)
        then
            table.insert(redundant_leaf_technologies, technology.name)
        end
    end

    data_raw.remove_all("technology", obsolete_technologies)
    data_raw.remove_all("technology", redundant_leaf_technologies)
end