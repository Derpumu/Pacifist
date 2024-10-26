# Pacifist Factorio mod

This mod removes military tech, weapons, and ammo for an undistracted playthrough without biters.
Compatible to a growing number of overhaul mods like K2, Bob's, Angel's.

- [Mod portal](https://mods.factorio.com/mod/Pacifist)
- [How to make other mods compatible](docs/compatibility.md) 



# Why Pacifist?

This mod is for those who want to enjoy a game without biters and a tech tree without useless military research options.
It also strives to remove references to killing and weapons as much as possible, so you might consider it for a kid-friendly playthrough.

## Factorio 2.0 and Space Age
- Factorio 2.0: I am working on making the mod compatible to Factorio 2.0. While I am at it, I am reworking some things that I have not been happy with. Stay tuned, it might take a bit.
- Factorio Space Age DLC: I currently do not see how to make Pacifist compatible with Space Age, as some form of weaponry will be needed to whittle down asteroids. Please let me know your ideas in the discussions, but for now I do not plan to make Space Age compatible.
Below information pertains to the current version of Pacifist for Factorio 1.1

## Remove all the things!
Pacifist removes all weapons, ammo, turrets, and defense equipment as well as their technologies, even military science packs are gone.

**Biters** are removed. If you load the mod into an existing game or don't disable them during game creation, they will be removed for you. Abracadabra.
Pollution is off in map generation settings by default, but if you happen to add the mod to a save with pollution turned on, it will stay on.
Pollution generated (or removed) by entities and modules is disabled by default, but you can turn it on in the option to get your green water and shriveled trees back. 

**Vehicles** are still here but without guns. Removing the tank entirely is an option, but by default it is left in the game so you can still use it to plow down the real enemy - trees.
After all, there are no more grenades available for the task. Tank and spidertron technologies no longer use military science.

**Power armor** stays, for the precious personal roboports and exoskeletons.
They can now be researched without military science packs, the technology tree has been adapted correspondingly.
Laser and discharge defenses are removed. Removal of energy shields is optional.

**Walls and gates** are removed by default, but there is a startup setting to leave them in - unless a mod absolutely requires them.


## Compatibility with other mods

**Mod authors:** 
While currently undocumented, I have a plugin system that makes it relatively straight-forward to add compatibility for most mods.
If you want to make your mod compatible yourself, I am happy to answer any questions and accept your pull requests.
Please have a look here for examples: https://github.com/Derpumu/Pacifist/tree/main/compatibility 

It is in the nature of this mod to remove a part of the game that other mods may consider vital.
Mods that rely on military items or biters being present, be it vanilla items or their own, may break while loading, while creating a new game, or even later in the game.

I do my best to ensure the game does not crash when combining Pacifist with other mods, but each test means I have to at least install the mod, restart Factorio, and start a new game.
All that does not mean that mods that don't crash won't behave strangely or be playable at all.
Mods that need more thorough investigation and more complex adaptations are those that change science packs and all of the larger overhaul mods.
Regarding the status of the ones I know, see below.

Apart from that, purely military mods like Rampant Arsenal that fail to load are marked incompatible and I won't fix those issues unless they are part of popular mod packs.
I'll be grateful if you have suggestions or want to report an incompatible mod.
You can do so either in the discussions on the mod portal or by submitting an issue in GitHub.
When you do a modded playthrough with Pacifist, I'd also be happy to hear if it worked well, and which mods you used.


### Current status of overhaul mod compatibility:
The order represents roughly my plans to playtest and fix them. 
**Please let me know when you'd like to use Pacifist with an overhaul mod that is not on this list or marked as not tested!** I'll prioritize compatibility to mods where I know they will actually be used. The below list is tested more or less thoroughly every time a new version of Pacifist is released.

#### Krastorio2
Fully compatible. Biomass, creep, and bio labs are removed. Biotechnology is renamed to Fertilizers, and the fertilizer recipe uses the alternative recipe (Krastorio2 peaceful setting enforced).

#### Exotic Industries official modpack
Fully compatible. Age progression is handled well. Alien flowers can now be mined and do not have to be killed for loot. Surprise biters are suppressed.

#### Freight forwarding mod pack
Fully compatible.

#### 248k
Superficially tested and seems to work.

#### Bob's mods
All Bob's mods are fully compatible, even Bob's Enemies (Pacifist just removes them all), and Bob's Warfare (in case you like big power Armors and Spidertrons).

#### Angel's mods
**Angel's Exploration** is about biters and weapons and therefore not  compatible.
**Angel's Industries** has been made compatible (warfare blocks and modified military science packs in the tech overhaul removed).
All other mods in the modpack work as they are.

#### SeaBlock
Fully compatible, including Mexmer's Science Pack Overhaul.

#### Pyanodon's
It loads and does not crash with Pacifist. If someone takes over my day job, I might come around to actually test it more thoroughly. If you play Pacifist with Pyanodon's, please let me know. I'll fix any bugs you report ASAP.

#### Yuoki Industries, Darkstar Utilities, MadClown's mods, Nullius
TBD - Not yet tested.

#### IndustrialRevolution3
The mod has its own "no military" startup setting. To not interfere with that, Pacifist has marked IR3 as incompatible.

#### Space Exploration
SE uses turrets not only for biters but also to defend against asteroids crashing into space ships. It seems unwise to remove military items here. Also, I did not look into how biters are spawned on other planets, which is yet another can of worms I won't open. Space Exploration is not compatible with Pacifist.

#### Other overhaul mods
What is missing? Drop me a line in the discussions!

## Users of this mod also downloaded...
There are some mods that go well with the theme of this one (i.e. they help to let you focus on the building and research). Among those are:

- [Invulnerable](https://mods.factorio.com/mod/invulnerable) (makes your character invulnerable)
- [Explosive Termites](https://mods.factorio.com/mod/Explosive%20Termites) (adds very effective "grenades" to the game that destroy trees in a large area)
- [BackpackRename](https://mods.factorio.com/mods/anyoneeb/BackpackRename) (renames armors to backpacks and removes damage resistances)

