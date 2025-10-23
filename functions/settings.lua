return {
    remove_walls = settings.startup["pacifist-remove-walls"].value,
    remove_shields = settings.startup["pacifist-remove-shields"].value,
    remove_armor = settings.startup["pacifist-remove-armor"].value,
    remove_tank = settings.startup["pacifist-remove-tank"].value,
    remove_pollution = settings.startup["pacifist-remove-pollution"].value,
    remove_corpses = settings.startup["pacifist-remove-corpses"].value,
    remove_health_bonus = (settings.startup["pacifist-remove-character-health-bonus"] or {}).value,
}