# Test scenarios

## General compatibility
Mods:
- Aircraft
- Companion_Drones
- EditorExtensions
- Explosive Termites
- LunarLandings
- Milestones
- Nanobots
- Power Armor Mk3
- PickerInventoryTools
- RecipeBook
- Teleporters
- aai-industry
- grappling-gun
- shield-projector
- stargate
- blueprint shotgun
Test:
- Mod version is correct
- Mod changelog can be displayed
- explosive termites capsules available
- grappling gun and ammo available
- blueprint shotgun and ammo available
- shield-projector tech available
- Nanobots available ("Nano" -> 5 techs)
- Technology "Heavy utility vest" is present 
- technology "laser" removed
- placing a mass driver does not crash
- new game does not crash


## Forced settings
Mods:
- 500BotStart
- Dectorio
- Mining_Dronws
- toms-byproducts
- Transport_Drones
Settings:
- Remove Tank ON
Test:
- Shields and Walls available regardless of settings
- tank removed
- new game does not crash


## 248k
Mods:
- 248k
- ArmouredBiters
- Cold_biters
- Explosive_biters
- Toxic_biters
Test:
- load test game and start new game does not crash


## AngelBobs
Mods:
- angelsaddons-cab
- angelsaddons-mobility
- angelsaddons-storage
- angelsinfiniteores
- angelspetrochem
- angelsrefining
- angelssmelting
- bobassembly
- bobelectronics
- bobequipment
- bobgreenhouse
- bobinserterst
- boblibrary
- boblogistics
- bobmining
- bobmodules
- bobores
- bobplates
- bobpower
- bobrevamp
- bobtech
- bobvehicleequipment
- bobenemies
- reskins-angels
- reskins-bobs
Settings:
- Angel's industries component overhaul ON
- Angel's industries technology overhaul ON
- Angel's industries mining components ON
Test:
- test techs for replaced data cores laser, wall, gate, explosives, rcu, Rocket defense, tank, spidertron:
- exploration blocks have mechanical parts as ingredients (recipes in exploration technologies) 
- load test game and start new game does not crash


## Exotic Industriessa
Mods:
- Exotic Industries: Official Modpack
Settings: default
Test:
- load test game and start new game does not crash
- flammables is prerequisite to rocket-fuel
- light and heavy armor removed
- changed text when mining alien flowers (random, reload and try again if it does not appear)
- debug-log for removed worms, biters after mining alien flowers (random, reload and try again if it does not appear)
- debug-log for removed worms, biters after scanning alien flowers and structures (random, reload and try again if it does not appear)


## FreightForwarding
Mods:
- EditorExtensions
- FreightForwardingPack
Test:
- load test game and start new game does not crash
- containers with ammo do not exist (e.g. use editor extensions)

## Krastorio 2
Mods:
- Krastorio2
Settings:
- remove-walls OFF
- remove-tank ON
Test:
- laser tech removed
- light and heavy armor removed
- walls are prerequisite of spidertron
- both tank technologies removed
- fertilizer tech


## Pyanodon's
Mods:
- py modpack
Test:sa
- load test game and start new game does not crash


## SeaBlock
Mods:
- SeaBlockModPack
Test:
- load test game and start new game does not crash
- military science tech removed (Ablative weapon...)
- military-1 tech replaced with Repair pack tech
