# How to make other mods compatible

Pacifist is generic and does in general not remove things by name but by their type.
The removal is done in `data-final-fixes.lua`.

That way, it works well with most mods that only do simple additions in `data.lua` or `data-updates.lua`:
if a mod only adds a gun, a turret, or new ammo, Pacifist takes care of it.

If a mod adds something in its own `data-final-fixes.lua`, it often is enough to add that mod as implicit dependency in `info.json`.

## Not so simple cases
If the implicit dependency is not enough, Pacifist's configuration needs to be extended.
This is done by adding a lua file with the same name as the mod in the [compatibility directory](../compatibility).

The file is expected to return a table containing an extension to Pacifist's config.
Before we get into the details of that table, we need to have an overview of what Pacifist does:

In general, Pacifist removes all of the following:
- Entities of type `land-mine`, `unit-spawner`, `artillery-wagon`, and any type of turret.
- Entities of type `combat-robot` (currently only hidden, not removed, due to technical difficulties).
- Entities of type `wall` and `gate` unless the startup option is unchecked or ignored (see below).
- Equipment of type `active-defense-equipment`.
- Equipment of type `energy-shield-equipment` unless the startup option is unchecked or ignored (see below).
- Items of type `gun` and `ammo`.
- Items of type `capsule` and the subgroup `capsule`, `military-equipment`, and `defensive-structure`.
- Items of type `item` or `item-with-entity-data` that have any of the above entities or equipment as place result.
- Recipes that result in any of the removed items.
- Recipes that void or recycle any of the removed items.
- Technology effects of type `ammo-damage`, `turret-attack`, `gun-speed`, `artillery-range`, and `maximum-following-robots-count`.
- Technologies that after removal of these effects, only result in removed recipes and/or effects explicitly ignored in the configuration (see below).
- Some more things that depend on the above (e.g. network signals for military items).
- Pollution effects from entity energy sources and modules, unless the startup option is unchecked. 

The configuration table can contain one or more of the following:
- Specific exceptions to the above general removals.
- Names of science packs, armor, and additional entities to remove.
- Names of additional items to remove. 
- Predicates for additional technology effects to ignore in order to mark military technologies obsolete.
- Result items and/or predicates that mark recipes as voiding their ingredients.
- Setting overrides for personal shield and wall startup options.
- Miscellaneous other things to remove, like achievements, main menu simulations, tips and tricks items.
- Preprocessing functions meant to tweak the mod before Pacifist starts to remove all things military.


## Reference

The following is an example of an compatibility file that contains all sections and subsections currently supported:

```lua
return {
    exceptions = {                                    -- things that should NOT be removed
        ammo = { "ammo-nano-constructors" },          -- any ammo named here stays
        ammo_category = "nano-ammo",                  -- tech effects related to these aren't considered military
        capsule = { "explosive-termites" },           -- any capsules named here stay
        entity = "ll-mass-driver-energy-source",      -- any entities named here stay (of any concrete type)
        equipment = { "my-defense-equipment" },       -- any equipment named here stays (defense, shields)
        gun = "dolphin-gun",                          -- any gun named here stays
    },
    extra = {                                         -- additional things to remove
        entity = { "angels-war-lab-1" },              -- these entities will be treated as military, see notes below
        entity_types = { "lab" },                     -- instructs Pacifist to look for the extra.entity names in these types
        item = { "biters-research-data", "biomass" }, -- these items will be treated as military items, see notes below
        get_derived_items = get_derived_items,        -- more military items, see notes below
        main_menu_simulations = { "ei_menu_3" },      -- remove these main menu simulations 
        misc = {                                      -- list of type-name pairs to remove, see notes below
            { "research-achievement", "destroyer-of-worlds" },
            { "tips-and-tricks-item", "kr-creep" },
        },
        science_packs = { "military-science-pack" },  -- these science packs will be removed 
    },
    ignore = {
        effects_pred = { effects_pred },              -- technology effects matching these will be ignored, see notes below
        recipe_pred = { is_pyvoid_recipe },           -- recipes matching these count as "voiding" recipes, see notes below
        result_items = { "kr-void", "matter" },       -- recipes with any of these results count as "voiding" recipes 
    },
    preprocess = preprocess,                          -- see notes below
    required = {                                      -- startup settings override
        shields = true,                               -- can only be true, false has no effect
        walls = true,                                 -- can only be true, false has no effect
    }
}
```

In general, where you see lists with a single string, you can also use a single string (like in `exceptions.gun`), it will then be wrapped in a list.

### extra.entity, extra.item
When entities are removed via `extra.entity`, Pacifist will also look for items that have these entities as place result and remove them.
For those items and the ones mentioned in `extra.item`, recipes that produce or void them will be removed as well, potentially including technologies enabling those recipes. 

### extra.get_derived_items
Rarely needed. This is expected to be a function or list of functions.
The functions will be called with all identified military item names and their types as arguments and should return a type-name pair.
If an item prototype of that type and name exists, it will be treated as military item (see notes for extra.item).

Example for [IntermodalContainers](https://mods.factorio.com/mod/IntermodalContainers) (part of the Freight Forwarding mod pack):
The mod generates containers for each item, and e.g. `ic-container-firearm-magazine` should be considered a military item and be removed, along with the related recipes.
```lua
get_derived_items = function(original_type, original_name)
    return { type = "item", name = "ic-container-" .. original_name }
end
```
### extra.misc
A catch-all meant for achievements, tips-and tricks items etc. Theoretically you can remove _everything_ with this one, but you shouldn't.
It will especially not include the special chain of removal for entities, items, etc. or the special treatment for science packs and armor.

### ignore.effects_pred
Rarely needed. This is expected to be a function or list of functions.
The functions will be called with technology effects as arguments and should return a boolean.
It will be called on all effects of technologies that are altered by Pacifist, that are technologies that have their predecessors or successors in the tech tree removed.
If after removal of military effects (including unlocks of military recipes) a technology has only effects ignored by this predicate, it will be removed as well.

Example: In [Exotic Industries](https://mods.factorio.com/mod/exotic-industries), every technology has the effect of "age progression".
Military technologies will after removal of their effects only contain this generic effect, so it needs to be ignored in order to remove the technology.

### ignore.recipe_pred
Rarely needed. This is expected to be a function or list of functions.
The functions will be called with recipes as arguments that have only military ingredients and more complex outputs than simple "void" items (use `ignore.result_items` for those).
The function is expected to return a boolean value. If it is true, the recipe will be considered a voiding or recycling recipe and be removed.

Example: The [Pyanodons Industry](https://mods.factorio.com/mod/pyindustry) mod generates generic "voiding" recipes that have different results depending on other mods and/or settings.
It is simpler to identify those recipes by their name than to reconstruct those conditions.

Example: Recycling mods like [Recycling Machines](https://mods.factorio.com/mod/ZRecycling) generate recycling recipes by copying all original recipes and swapping ingredients with results.
Pacifist would then encounter a recipe that takes a combat shotgun and returns some steel, gears, copper, and wood.
We can only identify and remove that kind of recipe by its name.

### preprocess
The place to prepare a mod for Pacifist's treatment. This is expected to be a function or list of functions.
The functions will be called without arguments and are not expected to return a value.
Many of the overhaul mods but also some smaller ones need small (or not so small) preprocessing steps.

You will find more examples in the [existing compatibility patches](https://github.com/Derpumu/Pacifist/tree/main/compatibility).


## Really complex cases
While the mechanism of adding exceptions, extras, and preprocessing to Pacifists config works pretty well for many mods, some do weird things that require some creativity or may be impossible to solve within Pacifist itself.
If you find a case you can not solve, please don't hesitate to get in touch!