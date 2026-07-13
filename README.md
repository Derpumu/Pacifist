# Pacifist Factorio mod

This mod removes military tech, weapons, and ammo for an undistracted playthrough without biters.
Compatible to a growing number of overhaul mods like Pyanodon's and Space Age.

- [Mod portal](https://mods.factorio.com/mod/Pacifist)

# Why Pacifist?

This mod is for those who want to enjoy a game without biters and a tech tree without useless military research options.
It also strives to remove references to killing and weapons as much as possible, so you might consider it for a
kid-friendly playthrough.

# Pacifist: Remove all the things!

Pacifist removes all weapons, ammo, turrets, and defense equipment as well as their technologies, even military science
packs are gone.

**Biters** are removed. If you load the mod into an existing game or don't disable them during game creation, they will
be removed for you. Abracadabra.
Pollution is off in map generation settings by default, but if you happen to add the mod to a save with pollution turned
on, it will stay on.
Pollution generated (or removed) by entities and modules is disabled by default, but you can turn it on in the option to
get your green water and shriveled trees back.

**Vehicles** are still here but without guns. Removing the tank entirely is an option, but by default it is left in the
game so you can still use it to plow down the real enemy - trees.
After all, there are no more grenades available for the task. Tank and spidertron technologies no longer use military
science.

**Power armor** stays, for the precious personal roboports and exoskeletons.
They can now be researched without military science packs, the technology tree has been adapted correspondingly.
Laser and discharge defenses are removed. Removal of energy shields is optional.

**Walls and gates** are removed by default (unless you are using a compatible mod that absolutely requires them), but
there is a startup setting to leave them in.

# Compatibility Tweaks

While a peaceful vanilla experience is enjoyable, the original purpose of Pacifist is to play more complex overhauls
without military distractions. The implementation is designed to allow easy configuration of what gets removed and what
stays depending on additional mods that are loaded. The large majority of mods will Just Work™ with Pacifist, for most
others some simple tweaks will suffice, even for larger overhaul modpacks it is usually only a matter of hours to make
Pacifist compatible.

## Base game

While grenades can no longer be thrown to destroy things, an item called "Blasting Cap" that currently still looks very
much like a grenade is still in the game as ingredient for cliff explosives.

## Space Age DLC

Due to the nature of Space Age, some weaponry has to remain as well as spawners on Gleba and Nauvis. However, care has
been taken to rename everything and restrict it to the necessary uses:

- Gun turrets etc. are now called "asteroid defense" and are only buildable on space platforms
- Ammunition and rockets are unlocked with the respective defense technology
- Damage and speed bonus research is only available after the respective defense technology
- Pentapod and biter eggs and everything related to them have been renamed to themes that do not imply the existence of
  hostile organisms
  If you are looking for a more lightweight approach to play a peaceful round of Space Age without useless technologies,
  have a look at the [Hide Unused Military Technologies mod](https://mods.factorio.com/mod/hide-military-tech).
- Since spore deposits (biter spawners) still have to count as enemies in order to be captured, and enemies can not be
  mined. Therefore, the only way to get rid of them is driving through them with a tank or car (don't worry, they are
  _very_ squishy)

## Pyanodon's

The Pyanodon modpack is fully compatible in terms of loading all the prototypes for units etc. A small handful of
military items is used for T.U.R.D. recipes. Those items have been "pacified", i.e. they are left in the game but are
normal items now that can not be placed as equipment or turrets and can nor be thrown as grenades etc.

## More mods

For a list of additional mods that I am continuously testing or have explicitly made compatible, see the list further
below. Compatibility with even more mods is work in progress.

I'll be grateful if you have suggestions or want to report an incompatible mod.
You can do so either in the discussions on the mod portal or by submitting an issue in GitHub.
When you do a modded playthrough with Pacifist, I'd also be happy to hear if it worked well, and which mods you used.

It is in the nature of this mod to remove a part of the game that other mods may consider vital.
Mods that rely on military items or biters being present, be it vanilla items or their own, may break while loading,
while creating a new game, or even later in the game, unless I put in the work to make them compatible.

I do my best to ensure the game does not crash when combining Pacifist with other mods, but each test means I have to at
least install the mod, restart Factorio, and start a new game. All that does not mean that mods that don't crash won't
behave strangely or be playable at all.
Mods that need more thorough investigation and more complex adaptations are those that change science packs and all the
larger overhaul mods.

Apart from that, purely military mods that fail to load are marked incompatible and I won't fix those issues unless they
are part of popular mod packs.

**Please let me know when you'd like to use Pacifist with an overhaul mod that is not on this list or marked as not
tested!** I'll prioritize compatibility to mods where I know they will actually be used. The mods marked as compatible
in the list at the end of this page are tested more or less thoroughly every time a new version of Pacifist is released.

## Users of this mod also downloaded...

There are some mods that go well with the theme of this one (i.e. they help to let you focus on the building and
research). Among those are:

- [Explosive Termites](https://mods.factorio.com/mod/Explosive%20Termites) (adds very effective "grenades" to the game
  that destroy trees in a large area)
- [Throwable Capture Bot](https://mods.factorio.com/mod/throwable-capture-robot) (throw your "Bio probes" instead of
  using a launcher that suspiciously looks like a rocket launcher...)

# HELP WANTED!

One big target for Pacifist is large overhaul mods. Playing and testing all of them is impossible for me as long as days
have only 24 hours.
I also have no experience to speak of with graphics design, so the occasional image adjustment is a challenge I tend to
postpone indefinitely.
Help in any form is much appreciated:

## How you can help

- **Constructive feedback**: Knowing that people use the mod and care about it gives me motivation. Feature requests,
  praise, even a little "worked well for me" are appreciated.
- **Bug reports**: When you experience crashes, Factorio not loading, or things wrongly being removed or kept in the
  game by Pacifist, drop me a line. GitHub, Mod portal, Discord, everything's fine. 
- **Compatibility notes**: If you play a save with Pacifist, even without problems, consider sending me the list of mods
  that worked.
  That can be a handwritten list, your mod-list.json (in your Factorio mods directory), or your save game.
- **Testing**: Check how Pacifist does together with other mods, especially overhaul mods and ones that add tools that
  are used like weapons (like grappling gun, nanobots, etc.), but also purely military mods.
- **Graphics**: There is a number of graphics related issues that I'd love to get some help with over
  at [GitHub](https://github.com/Derpumu/Pacifist/issues?q=is%3Aissue%20state%3Aopen%20label%3Agraphics).
- **Patches**: Many compatibility issues can be solved with smaller non-intrusive configration patches. I'll be happy to
  chat with you if you're interested.

## How to get in touch

- Start a thread in the [mod portal discussions section](https://mods.factorio.com/mod/Pacifist/discussion).
- Create an [issue at GitHub](https://github.com/Derpumu/Pacifist/issues).
- Look me up in the Factorio Discord and send me a DM. (No friend requests out of the blue, please. I ignore those as
  there are too many scammers)

# Compatibility List

The below list in non-exhaustive. Mods that don't add or change anything of interest for Pacifist are not listed and
_should_ just work.

Please let me know of any other mods that you'd like to see in the list.
Legend:
❌ = incompatible.
❓ = test needed.
✅ = superficially tested. No crashes on load, no important items missing as far as a quick peek after game start can
reveal. Sufficient for most smaller mods.
✨ = polished. If needed, manual adjustments to prototypes and names etc. have been made to make the experience
consistent and non-violent.
🎮 = playtested. Some mods (usually more complex mod packs) have scripted surprises that are only revealed by actually
playing them with Pacifist.

| Mod                                                                                               | Version     | Status     | Notes                                                                              |
|---------------------------------------------------------------------------------------------------|-------------|:-----------|:-----------------------------------------------------------------------------------|
| base                                                                                              | 2.1.10      | 🎮✨        |                                                                                    |
| elevated-rails                                                                                    | 2.1.10      | 🎮✨        |                                                                                    |
| quality                                                                                           | 2.1.10      | 🎮✨        |                                                                                    |
| recycler                                                                                          | 2.1.10      | 🎮✨        |                                                                                    |
| space-age                                                                                         | 2.1.10      | 🎮✨        |                                                                                    |
| **Overhauls**                                                                                     | **Version** | **Status** | **Notes**                                                                          |
| [Pyanodons Alien Life](https://mods.factorio.com/mod/pyalienlife)                                 | 3.0.67      | ✅          | With slaughterhouses, "non-violent" is out of scope for Py                         |
| [Pyanodons Alternative Energy](https://mods.factorio.com/mod/pyalternativeenergy)                 | 3.1.38      | ✅          |                                                                                    |
| [Pyanodons Coal Processing](https://mods.factorio.com/mod/pycoalprocessing)                       | 3.0.44      | ✅          |                                                                                    |
| [Pyanodons Fusion Energy](https://mods.factorio.com/mod/pyfusionenergy)                           | 3.0.17      | ✅          |                                                                                    |
| [Pyanodons HighTech](https://mods.factorio.com/mod/pyhightech)                                    | 3.0.19      | ✅          |                                                                                    |
| [Pyanodons Industry](https://mods.factorio.com/mod/pyindustry)                                    | 3.0.21      | ✅          |                                                                                    |
| [Pyanodons Petroleum Handling](https://mods.factorio.com/mod/pypetroleumhandling)                 | 3.0.23      | ✅          |                                                                                    |
| [Pyanodons Raw Ores](https://mods.factorio.com/mod/pyrawores)                                     | 3.0.25      | ✅          |                                                                                    |
| [248k Redux Mod](https://mods.factorio.com/mod/248k-Redux)                                        | 0.1.40      | ✅          |                                                                                    |
| [Krastorio2](https://mods.factorio.com/mod/Krastorio2)                                            | 2.0.19      | ✅          |                                                                                    |
| [Bob's Mods](https://mods.factorio.com/user/bobingabout)                                          | 2.1.x       | ✅          | Excluding: ❌ Bob's Enemies, ❌ Bob's Warfare                                        |
| [Bob's Character Classes](https://mods.factorio.com/mod/bobclasses)                               | 2.1.x       | ❌          | One or two classes may work, others will crash on selection                        |
| [Angels Mods](https://mods.factorio.com/user/Arch666Angel)                                        | 2.0.x       | ✅          |                                                                                    |
| [Periodic Madness](https://mods.factorio.com/mod/periodic-madness)                                | 0.8.13      | ✅          | Not checked with Factorio 2.1 yet                                                  |
| [lunar landings](https://mods.factorio.com/mod/LunarLandings)                                     |             | ❓          |                                                                                    |
| [Galdoc's manufacturing](https://mods.factorio.com/mod/galdocs-manufacturing)                     |             | ❓          |                                                                                    |
| [Ultracube](https://mods.factorio.com/mod/Ultracube)                                              |             | ❓          |                                                                                    |
| [5Dim's](https://mods.factorio.com/user/McGuten)                                                  |             | ❓          |                                                                                    |
| [Yuoki Industries](https://mods.factorio.com/mod/Yuoki)                                           |             | ❓          |                                                                                    |
| [Exotic Space Industries](https://mods.factorio.com/mod/exotic-space-industries)                  |             | ❓          |                                                                                    |
| [Factorio+](https://mods.factorio.com/mod/factorioplus)                                           | 2.2.6       | ❌          | Compatibility broke during 3 minor upgrades in a row, maintenance is on hold       |
| **Other mods**                                                                                    | **Version** | **Status** | **Notes**                                                                          |
| [AAI Containers](https://mods.factorio.com/mod/aai-containers)                                    | 0.3.2       | ✅          |                                                                                    |
| [AAI Vehicles: Ironclad](https://mods.factorio.com/mod/aai-vehicles-ironclad)                     | 0.7.5       | ✅          |                                                                                    |
| [Blueprint Shotgun](https://mods.factorio.com/mod/blueprint-shotgun)                              | 0.2.22      | 🎮✨        |                                                                                    |
| [Cerys](https://mods.factorio.com/mod/Cerys-Moon-of-Fulgora)                                      | 4.22.4      | 🎮✨        |                                                                                    |
| [Cheese's Concentrated Solar](https://mods.factorio.com/mod/ch-concentrated-solar)                | 0.5.1       | ✅          |                                                                                    |
| [Companion Drones for 2.0](https://mods.factorio.com/mod/companion-drones-mjlfix)                 | 3.1.2       | ✅          | Not checked with Factorio 2.1 yet                                                  |
| [Creative Mod](https://mods.factorio.com/mod/creative-mod)                                        | 2.1.5       | ✅          |                                                                                    |
| [crushing industry](https://mods.factorio.com/mod/crushing-industry)                              | 0.5.12      | ✅          | Not checked with Factorio 2.1 yet                                                  |
| [🌐Cubium](https://mods.factorio.com/mod/cubium)                                                  | 1.0.28      | ✅          | Untested runtime scripts                                                           |
| [Dectorio](https://mods.factorio.com/mod/Dectorio)                                                | 0.13.1      | ✅          | Not checked with Factorio 2.1 yet                                                  |
| [Early Spidertron](https://mods.factorio.com/mod/early-spidertron)                                | 2.0.1       | ✅          |                                                                                    |
| [Explosive Termites](https://mods.factorio.com/mod/Explosive%20Termites)                          | 1.1.16      | 🎮✨        | Not checked with Factorio 2.1 yet                                                  |
| [Factorio and Conquer: Tiberian Dawn](https://mods.factorio.com/mod/Factorio-Tiberium)            | 2.0.15      | ✅          |                                                                                    |
| [Flare Stack](https://mods.factorio.com/mod/Flare%20Stack)                                        | 4.1.1       | ✅          |                                                                                    |
| [Flare Stack Redux](https://mods.factorio.com/mod/Flares_Stack_Redux)                             | 2.20.0      | ✅          | Not checked with Factorio 2.1 yet                                                  |
| [Grappling Gun](https://mods.factorio.com/mod/grappling-gun)                                      | 0.4.1       | ✨          |                                                                                    |
| [Intermodal Containers](https://mods.factorio.com/mod/IntermodalContainers)                       | 2.1.3       | ✅          | Not checked with Factorio 2.1 yet                                                  |
| [Jetpack](https://mods.factorio.com/mod/jetpack)                                                  | 0.4.17      | ✅          |                                                                                    |
| [Kitty Cat](https://mods.factorio.com/mod/kittycat)                                               | 0.3.7       | ✨          | Not checked with Factorio 2.1 yet                                                  |
| [Memory Storage](https://mods.factorio.com/mod/deep-storage-unit)                                 | 1.6.8       | ✅          |                                                                                    |
| [Nanobots: Early Bots 2.0](https://mods.factorio.com/mod/Nanobots2)                               | 3.3.2       | ✅          | Not checked with Factorio 2.1 yet                                                  |
| [Offshore dump](https://mods.factorio.com/mod/offshore-dump)                                      | 0.1.3       | ✅          | Not checked with Factorio 2.1 yet                                                  |
| [🌐 Planet Maraxsis](https://mods.factorio.com/mod/maraxsis)                                      | 1.31.8      | ✅          | Untested runtime scripts, imperfect adoption of big cliff explosives recipe in 2.1 |
| [Power Armor MK3](https://mods.factorio.com/mod/Power%20Armor%20MK3)                              | 2.1.7       | ✅          |                                                                                    |
| [Reverse Factory](https://mods.factorio.com/mod/reverse-factory)                                  | 9.1.5       | ✅          |                                                                                    |
| [Robot Quick Start](https://mods.factorio.com/mod/RobotQuickStart)                                | 2.0.3       | ✨          | Not checked with Factorio 2.1 yet                                                  |
| [Space Extension Mod (Feoras Fork)](https://mods.factorio.com/mod/SpaceModFeorasFork)             | 1.3.3       | ✅          |                                                                                    |
| [Spidertron Automation](https://mods.factorio.com/mod/Constructron-Continued)                     | 2.0.44      | ✅          |                                                                                    |
| [Spidertron Patrols](https://mods.factorio.com/mod/SpidertronPatrols)                             | 2.6.4       | ✅          | Untested runtime scripts                                                           |
| [Teleporters](https://mods.factorio.com/mod/Teleporters)                                          | 2.0.0       | ✅          | Not checked with Factorio 2.1 yet                                                  |
| [Throwable Capture Robot](https://mods.factorio.com/mod/throwable-capture-robot)                  | 1.0.1       | ✨          | Not checked with Factorio 2.1 yet                                                  |
| [Updated Construction Drones](https://mods.factorio.com/mod/Updated_Construction_Drones)          | 2.0.4       | ✅          | Not checked with Factorio 2.1 yet                                                  |
| [Updated Construction Drones  - Forked](https://mods.factorio.com/mod/Construction_Drones_Forked) | 1.1.9       | ✅          |                                                                                    |
| **Military/Alien mods**                                                                           | **Version** | **Status** | **Notes**                                                                          |
| [Alien Loot Economy](https://mods.factorio.com/mod/alien-module)                                  |             | ❌          | Won't fix                                                                          |
| [Explosive biters](https://mods.factorio.com/mod/Explosive_biters)                                |             | ❌          | Won't fix                                                                          |

# Factorio 1.1 and 2.0

Pacifist 0.6.x works with Factorio 1.1 and a longer list of overhaul mods, so does Pacifist 2.2.7 for Factorio 2.0.
I won't work on new features for those versions, but if you find bugs with mods that should be compatible, please send them my way.
