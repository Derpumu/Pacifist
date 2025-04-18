-- Mod compatibility for Throwable Capture Bot (https://mods.factorio.com/mod/throwable-capture-robot)
local throwable_capture_robot_config = {
    exceptions = {
        capsule = { "capture-robot-capsule" },
    },
    preprocess = {
        function()
            local capture_bot_capsule = data.raw.capsule["capture-robot-capsule"]
            capture_bot_capsule.subgroup = "capture"
            capture_bot_capsule.capsule_action.attack_parameters.ammo_category = "capture-robot"
            capture_bot_capsule.capsule_action.attack_parameters.ammo_type.target_filter = { "biter-spawner" }
        end,
    },
}

-- Check mod startup setting "Replace capture bot rocket with capsule"
if settings.startup["throwable-capture-robot-replace-rocket"].value then
    -- If the mod replaces (i.e. removes) the capture bot rocket, the rocket launcher doesn't have a use anymore and
    -- therefore can be removed.
    throwable_capture_robot_config.extra = {
        gun = { "rocket-launcher" },
    }
end

return throwable_capture_robot_config
