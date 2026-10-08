# Trash Rush

A simple Roblox game prototype where players pick up trash around the map to earn experience and level up.

## Features
- Trash items spawn randomly across the map
- Picking up trash gives XP and increases your trash count
- Each level unlocks stronger progression and more satisfying gameplay
- Simple HUD with level, XP bar, and collected trash count
- Easy to expand into a larger game with upgrades, shops, or team objectives

## Gameplay Loop
1. Spawn into the main map
2. Walk around and collect floating or ground trash
3. Each trash pickup grants a small XP boost
4. Reach leveling thresholds to gain a new level
5. Use level gains as a progression loop or to unlock rewards later

## Project Structure

```
roblox-trash-game/
├── README.md
├── src/
│   ├── server/
│   │   ├── LevelingService.lua
│   │   ├── TrashService.lua
│   │   └── main.lua
│   ├── client/
│   │   ├── HUD.lua
│   │   └── main.lua
│   └── shared/
│       ├── Config.lua
│       └── Constants.lua
├── docs/
│   └── GAMEPLAY.md
└── .gitignore
```

## How to Use in Roblox Studio
1. Open Roblox Studio and create a new place
2. Copy the scripts from `src/server/` into `ServerScriptService`
3. Copy the scripts from `src/client/` into `StarterPlayer > StarterPlayerScripts`
4. Create a folder structure named `TrashGame` if you want to mirror the module layout
5. Press Play to test the prototype

## Notes
This is a simple single-place prototype designed to be easy to build on. It focuses on the core loop:
- collect trash
- earn XP
- level up

This foundation is ready to be expanded with:
- a shop system
- better map design
- collectible objectives
- leaderboard/tracker
- more visual polish

## License
This project is open for learning and experimentation.
