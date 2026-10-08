# The Cheesiest Heist (Of the Century!)

If you grew up watching Oggy and the Cockroaches, you already know how this goes. Oggy has cheese. Joey, Dee Dee and Marky want the cheese, Oggy is bigger, angrier and has a fly swatter.

This game puts you on the cockroach side of that fight. You sneak through Oggy's house, get past everything he's set up, and walk out with the cheesiest cheese in town. It's being built in Godot as a co-op game, so eventually you and your friends will be the three roaches. Right now it's single player while we get the levels and mechanics right.

It's still very much a work in progress. Stuff will break, things will look weird in places, and your character is currently a capsule. We're working on it.

---
## The HEIST
The whole game takes place inside (and around) Oggy's house, and you move through it room by room.

-  **The Escape.** It starts with Oggy chasing the roaches out. They get away by climbing up the zipline in front of the garage and slipping in through the vent.
-  **The Garage.** A parkour course with ziplines and vents to get across.
-  **The Library.** There's a toy gun sitting somewhere. Get to it, find the hidden button, shoot it, and the paintings drop into place so you can climb higher.
-  **The Hallway.** The only safe way across is on the objects lying on the ground.
-  **The Kitchen.** Climb the shelves up to the fridge. (there's a secret cheese too, maybe check some shelf??)
-  **The Getaway.** Grab the cheese and get away on the bike.

Six pieces of cheese are hidden along the way. The HUD keeps count of how many you've picked up, how long you've been going, and shows a little radar minimap.

##Controls
| What | Key |
| --- | --- |
| Move | W A S D |
| Look around | Mouse |
| Jump | Space |
| Sprint | Shift (hold it while jumping to go higher) |
| Zipline | E |
| Pick up cheese / the gun | G |
| Crawl through a vent | C |
| Shoot | Left click (once you have the gun) |
| Go back to your last checkpoints | R |
| Pause | Esc |

Vents also save your checkpoint, so if you fall off something after going through one, R puts you back at that vent instead of all the way at the start.

## Running it yourself

1. Go to downloads section in https://rishukamboj.itch.io/the-cheesiest-heist 

2. Download the 3 files and run Cheesiestt-Heist.exe

3. Enjoy!

## How it's built

- Godot 4.7 with GDScript
- Jolt Physics for collisions
- The Mobile rendered, so it runs on laptops without a proper GPU
- [Simple Grass Textured](https://github.com/IcterusGames/SimpleGrassTextured) for all the grass outside the house.
- The house, the car and pretty much all the furniture are models from Sketchfab that we edited in Blender to fit (opening doors, cutting pieces out, fixing sclaes, that kind of thing)

Most of the gameplay stuff (ziplines, vents, the lava floor, cheese, the gun) is small separate scripts that talk to the player through a few functions, so adding a new vent or zipline is mostly a matter of dropping it into the scene and pointing it at a start and end marker.

## What's done and what's not

**Working now:**
- Player movement with sprinting (Holding Shift gives extra Boost)
- Ziplines
- Vents that teleport you and save a checkpoint
- Picking up the toy gun and shooting
- The hidden button that makes the paintings appear
- The floor-is-lava hallway
- Cheese collecting and the HUD (counter, time, minimap)
- Main menu with a fade into the game, and a pause menu

**Working on it:**
- The opening cutscene, where you see Oggy chasing the roaches through his eyes
- Proper cockroaches models and animations instead of the capsule
- Grabbing and hanging off ledges
- Finishing the parkour through the kitchen
- The fridge and the bike ending
- Multiplayer, which is the big one(not gonna be soon </3).

## Known issues
- A few collision boxes don't line up perfectly eith the models yet, so you might clip into a wall or land slightly above a surface in some spots.

If you find something else, open up an issue and tell us where it happened.

## Credits
The 3D models come from a bunch of different creators on Sketchfab. We're putting together the full lit with links and licenses and it'll be in the next update.
Oggy and the Cockroaches and its characters belong to XILAM Animation. This is a fan project made for fun and isn't affiliated with them in any way.

## License
The code in this repo is under the MIT License, see `LICENSE`. That doesn't cover the third-party models, which keep their own licenses.
