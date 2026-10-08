# Trash Rush: Advanced Version

A more advanced Roblox prototype where players collect trash, deposit it for coins, level up, buy upgrades, and complete objectives.

## Features
- Randomized trash spawning around a large open map
- Pickup-based collection and deposit-based rewards
- XP and level progression
- Coins and upgrade shop
- Leaderstats for level, XP, trash, and coins
- Simulated objective tracking and progression loop
- Built as a stronger foundation for a realistic playable prototype

## New Advanced Gameplay Loop
1. Spawn into the map
2. Collect trash scattered across the world
3. Carry collected trash to the deposit bins
4. Earn coins and XP from deposit rewards
5. Spend coins to buy upgrades for better pickups and rewards
6. Use the level system to progress through an expanded loop

## Project Structure

```
roblox-trash-game/
├── README.md
├── src/
│   ├── server/
│   │   ├── GameManager.lua
│   │   ├── LevelingService.lua
│   │   ├── TrashService.lua
│   │   ├── UpgradeService.lua
│   │   ├── SaveService.lua
│   │   ├── QuestService.lua
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
2. Put `src/server/*.lua` into `ServerScriptService`
3. Put `src/client/*.lua` into `StarterPlayer > StarterPlayerScripts`
4. Optionally create a `ReplicatedStorage` folder and move any RemoteEvent setup there if you customize the project
5. Make sure there is a flat baseplate or map area for the spawn points
6. Press Play to test the advanced prototype

## Advanced Mechanics
- Trash spawns in waves across the world
- Trash has different values and colors
- Deposit bins convert carried trash into coins and XP
- Each upgrade affects gameplay balance and progression pacing
- Leaderstats make the game feel more complete and rewarding

## Recommended Next Steps
- Add a real map with obstacles and city props
- Add sound effects and particle FX for pickups and deposits
- Add a save/load system using Roblox DataStore
- Add cosmetic unlocks and achievement progression
- Add a leaderboard and daily challenge panel

## License
Open for experimentation and learning.
