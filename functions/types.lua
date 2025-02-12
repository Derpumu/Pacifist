---@type { [string]:Type[] }
local types = {
    entities_with_energy_source = {
        'accumulator',
        'active-defense-equipment',
        'agricultural-tower',
        'ammo-turret',
        'arithmetic-combinator',
        'assembling-machine',
        'asteroid-collector',
        'battery-equipment',
        'beacon',
        'belt-immunity-equipment',
        'boiler',
        'burner-generator',
        'car',
        'crafting-machine',
        'decider-combinator',
        'electric-energy-interface',
        'electric-turret',
        'energy-shield-equipment',
        'furnace',
        'fusion-generator',
        'fusion-reactor',
        'generator',
        'generator-equipment',
        'inserter',
        'inventory-bonus-equipment',
        'lab',
        'lamp',
        'lightning-attractor',
        'loader',
        'loader-1x1',
        'locomotive',
        'mining-drill',
        'movement-bonus-equipment',
        'night-vision-equipment',
        'offshore-pump',
        'programmable-speaker',
        'pump',
        'radar',
        'reactor',
        'roboport',
        'roboport-equipment',
        'rocket-silo',
        'selector-combinator',
        'solar-panel',
        'solar-panel-equipment',
        'spider-vehicle',
    },

    -- TODO: go through all the military types and look for thins they refer to tha might be orphaned

    military_effects = {
        'ammo-damage',
        'artillery-range',
        'gun-speed',
        'follower-robot-lifetime',
        'maximum-following-robots-count',
        'turret-attack',
    },

    military_entities = {
        'ammo-turret',
        'artillery-turret',
        'artillery-wagon',
        'combat-robot',
        'electric-turret',
        'fluid-turret',
        'land-mine',
        'segmented-unit',
        'segment',
        'spider-unit',
        'turret',
        'unit',
        'unit-spawner',
    },

    military_equipment = {
        'active-defense-equipment',
    },

    entities = {
        'arrow',
        'artillery-flare',
        'artillery-projectile',
        'beam',
        'character-corpse',
        'cliff',
        'corpse',
        'rail-remnants',
        'deconstructible-tile-proxy',
        'entity-ghost',
        'accumulator',
        'agricultural-tower',
        'artillery-turret',
        'asteroid-collector',
        'asteroid',
        'beacon',
        'boiler',
        'burner-generator',
        'cargo-bay',
        'cargo-landing-pad',
        'cargo-pod',
        'character',
        'arithmetic-combinator',
        'decider-combinator',
        'selector-combinator',
        'constant-combinator',
        'container',
        'logistic-container',
        'infinity-container',
        'temporary-container',
        'assembling-machine',
        'rocket-silo',
        'furnace',
        'display-panel',
        'electric-energy-interface',
        'electric-pole',
        'unit-spawner',
        'capture-robot',
        'combat-robot',
        'construction-robot',
        'logistic-robot',
        'fusion-generator',
        'fusion-reactor',
        'gate',
        'generator',
        'heat-interface',
        'heat-pipe',
        'inserter',
        'lab',
        'lamp',
        'land-mine',
        'lightning-attractor',
        'linked-container',
        'market',
        'mining-drill',
        'offshore-pump',
        'pipe',
        'infinity-pipe',
        'pipe-to-ground',
        'player-port',
        'power-switch',
        'programmable-speaker',
        'pump',
        'radar',
        'curved-rail-a',
        'elevated-curved-rail-a',
        'curved-rail-b',
        'elevated-curved-rail-b',
        'half-diagonal-rail',
        'elevated-half-diagonal-rail',
        'legacy-curved-rail',
        'legacy-straight-rail',
        'rail-ramp',
        'straight-rail',
        'elevated-straight-rail',
        'rail-chain-signal',
        'rail-signal',
        'rail-support',
        'reactor',
        'roboport',
        'segment',
        'segmented-unit',
        'simple-entity-with-owner',
        'simple-entity-with-force',
        'solar-panel',
        'space-platform-hub',
        'spider-leg',
        'spider-unit',
        'storage-tank',
        'thruster',
        'train-stop',
        'lane-splitter',
        'linked-belt',
        'loader-1x1',
        'loader',
        'splitter',
        'transport-belt',
        'underground-belt',
        'turret',
        'ammo-turret',
        'electric-turret',
        'fluid-turret',
        'unit',
        'car',
        'artillery-wagon',
        'cargo-wagon',
        'fluid-wagon',
        'locomotive',
        'spider-vehicle',
        'wall',
        'fish',
        'simple-entity',
        'tree',
        'plant',
        'explosion',
        'fire',
        'stream',
        'highlight-box',
        'item-entity',
        'item-request-proxy',
        'lightning',
        'particle-source',
        'projectile',
        'resource',
        'rocket-silo-rocket',
        'rocket-silo-rocket-shadow',
        'smoke-with-trigger',
        'speech-bubble',
        'sticker',
        'tile-ghost',
    },

    items = {
        'item',
        'ammo',
        'capsule',
        'gun',
        'item-with-entity-data',
        'item-with-label',
        'item-with-inventory',
        'blueprint-book',
        'item-with-tags',
        'selection-tool',
        'blueprint',
        'copy-paste-tool',
        'deconstruction-item',
        'spidertron-remote',
        'upgrade-item',
        'module',
        'rail-planner',
        'space-platform-starter-pack',
        'tool',
        'armor',
        'repair-tool',
    },

    vehicles = {
        'car',
        'spider-vehicle',
    },

}

return types