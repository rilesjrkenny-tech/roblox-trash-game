# Advanced Gameplay Overview

## Core Loop
This advanced version expands the simple prototype into a more complete trash-cleanup game loop:

1. Players collect trash scattered across the map
2. They carry the trash to deposit bins
3. Deposits grant coins and XP
4. Coins are spent on upgrades
5. Upgrades improve pickup power and rewards
6. Players level up and progress toward larger goals

## Features Included
- Dynamic trash spawns
- Value-based pickup rewards
- Deposit bin reward conversion
- Leveling and leaderstats
- Coin economy and upgrade shop
- Objective text system

## Upgrades
The shop contains three upgrade categories:
- Pickup Boost: stronger XP gain from each trash item
- Bin Bonus: larger reward conversions per deposit
- Spawn Rate: increases the overall trash flow

## Why This Is Better
This version is more game-like because it introduces:
- a reward loop
- progression structure
- an economy
- a broader and more satisfying feel

## Recommended Expansion Ideas
- Better map layout and props
- Sound cues and particle effects
- More utility items and tools
- Save data with DataStore
- Seasonal challenges or event objectives

## Implementation Notes
For Roblox Studio, place server scripts in `ServerScriptService`, client scripts in `StarterPlayer > StarterPlayerScripts`, and make sure the map is a flat area or an appropriate playfield.
