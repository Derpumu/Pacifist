local settings = require("__Pacifist__.functions.settings")

-- companion drones automatically inserts defense equipment into the initial drone at startup.
-- Pacifist can not undo that, so we need to provide a fake versions that is just a copy
-- of the roboport. The original item for the defense has to be removed explicitly
local _make_fake_defense_equipment = function()
    data.raw["active-defense-equipment"]["companion-defense-equipment"] = nil
    local roboport = data.raw["roboport-equipment"]["companion-roboport-mk2"]
    local fake_defense = util.table.deepcopy(roboport)
    fake_defense.name = "companion-defense-equipment"
    fake_defense.hidden = true
    fake_defense.take_result = "companion-roboport-mk2"
    data:extend { fake_defense }
end

local config = {
    extra = {
        item = {
            "companion-defense-equipment",
        },
    },
    preprocess = { _make_fake_defense_equipment }
}

-- companion drones also inserts a shield into the initial drone
-- replacing it with a fake would result in the dronw taking damage from the ship wreck
-- and warning about a missing repair pack which is not researched at game start
-- so instead we keep the shield equipment but remove the recipes so no new ones can be made.
if settings.remove_shields then
    config.exceptions = {
        equipment = {
            "companion-shield-equipment",
            "companion-shield-mk0",
            "companion-shield-mk1",
            "companion-shield-mk2",
            "companion-shield-mk3",
        }
    }
    config.extra.recipe = {
        "companion-shield-equipment",
        "companion-shield-mk0",
        "companion-shield-mk1",
        "companion-shield-mk2",
        "companion-shield-mk3",
    }
end

return config
