-- companion drones automatically insert shield equipment and defense equipment
-- into the initial drone at startup.
-- Pacifist can not undo that, so we need to provide fake versions that are just copies
-- of the roboports or reactors
local _make_fake_defense_equipment = function()
    data.raw["active-defense-equipment"]["companion-defense-equipment"] = nil
    local roboport = data.raw["roboport-equipment"]["companion-roboport-mk2"]
    local fake_defense = util.table.deepcopy(roboport)
    fake_defense.name = "companion-defense-equipment"
    fake_defense.hidden = true
    fake_defense.take_result = "companion-roboport-mk2"
    data:extend{fake_defense}
end

local _make_fake_shields = function()
    local reactor = data.raw["generator-equipment"]["companion-reactor-equipment"]
    for _, suffix in pairs{"equipment", "mk0", "mk1", "mk2", "mk3"} do
        local name = "companion-shield-" .. suffix
        data.raw["energy-shield-equipment"][name] = nil
        local fake_shield = util.table.deepcopy(reactor)
        fake_shield.name = name
        fake_shield.hidden = true
        fake_shield.take_result = reactor.name
        data:extend{fake_shield}
    end
end


return {
    extra = {
        item = {
            "companion-defense-equipment",
            "companion-shield-equipment",
            "companion-shield-mk0",
            "companion-shield-mk1",
            "companion-shield-mk2",
            "companion-shield-mk3",
        }
    },
    preprocess = { _make_fake_defense_equipment, _make_fake_shields }

}
