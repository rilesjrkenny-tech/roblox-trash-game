# Trash Rush: Game-Like Edition

A more polished Roblox prototype where players pick up trash, deposit it for cash, level up, buy upgrades, and complete objectives in a city-style environment.

## Features
- Open-world cleanup gameplay loop
- Trash spawns across multiple zones
- Deposit bins for earning coins and XP
- Upgrade shop with progression values
- Level system and objective tracking
- HUD with live progress, timer, and status
- Leaderboard-style stats through Roblox leaderstats
- Cleaner visual presentation for a more game-like feel

## Gameplay Loop
1. Spawn into the city map
2. Walk around and collect trash scattered across the area
3. Carry trash to a deposit bin
4. Earn coins, XP, and objective progress
5. Spend coins on upgraded pickups and rewards
6. Increase your level and keep cleaning to grow your score

## Controls
- Move with the standard Roblox controls
- Press U to open the upgrade shop
- Walk into trash to collect it
- Touch a deposit bin to turn carried trash into rewards

## Project Structure

```
roblox-trash-game/
├── README.md
├── src/
│   ├── server/
│   │   ├── GameManager.lua
│   │   ├── LevelingService.lua
│   │   ├── QuestService.lua
│   │   ├── SaveService.lua
│   │   ├── TrashService.lua
│   │   ├── UpgradeService.lua
│   │   └── main.lua
│   ├── client/
│   │   ├── HUD.lua
│   │   ├── ShopGui.lua
│   │   └── main.lua
│   └── shared/
│       ├── Config.lua
│       └── Constants.lua
├── docs/
│   ├── ADVANCED_GAMEPLAY.md
│   └── GAMEPLAY.md
└── .gitignore
```

## How to Use in Roblox Studio
1. Open Roblox Studio and create a new place
2. Put all scripts from `src/server` into `ServerScriptService`
3. Put all scripts from `src/client` into `StarterPlayer > StarterPlayerScripts`
4. Create a Roblox map with a large baseplate or open world
5. Press Play
6. Press U to open the upgrade shop

## What Makes It More Game-Like
- The map is designed around a more sandbox-style environment
- There are objective milestones and a repeated reward cycle
- The HUD feels like a more complete game interface
- Upgrades create meaningful progression instead of simple static stats
- The game loop feels more like a live challenge instead of just collecting floating objects

## Notes
This version is still a prototype, but it is much closer to a real Roblox game loop than the earlier versions.

## License
Open for experimentation and learning.
