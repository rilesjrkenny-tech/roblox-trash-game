# Roblox Trash Game - Project Structure

This document outlines the folder and file organization for the Roblox Trash Game project.

## Directory Structure

```
roblox-trash-game/
├── README.md                          # Main project documentation
├── PROJECT_STRUCTURE.md               # This file
├── scripts/                           # Server and local scripts
│   ├── server/
│   │   ├── game-manager.lua          # Main game controller
│   │   ├── trash-spawner.lua         # Handles trash item spawning
│   │   ├── player-manager.lua        # Player data and stats management
│   │   └── leaderboard.lua           # Leaderboard system
│   ├── client/
│   │   ├── ui-manager.lua            # UI updates and display
│   │   ├── input-handler.lua         # Player input handling
│   │   └── camera-controller.lua     # Camera movement
│   └── shared/
│       ├── constants.lua             # Game constants and config
│       └── utilities.lua             # Shared utility functions
├── models/                            # 3D models and parts
│   ├── trash-items/
│   │   ├── plastic-bottle.rbxm       # Trash item models
│   │   ├── aluminum-can.rbxm
│   │   └── cardboard-box.rbxm
│   ├── tools/
│   │   └── trash-collector.rbxm      # Player tool for picking up trash
│   └── map/
│       ├── spawn-area.rbxm           # Main play area
│       └── deposit-area.rbxm         # Trash deposit zone
├── config/                           # Configuration files
│   ├── game-config.lua               # Game settings and balancing
│   ├── trash-types.lua               # Trash item definitions
│   └── player-perks.lua              # Leveling rewards
├── data/                             # Player data storage
│   ├── save-system.lua               # Data persistence
│   └── player-stats.lua              # Player statistics
└── docs/                             # Documentation
    ├── API.md                        # API documentation
    ├── MECHANICS.md                  # Game mechanics explanation
    └── SETUP.md                      # Setup instructions
```

## Key Folders Explained

### `scripts/`
- **server/**: Scripts that run on Roblox servers (game logic, data management)
- **client/**: LocalScripts that run on players' clients (UI, input)
- **shared/**: ModuleScripts used by both server and client

### `models/`
- **trash-items/**: Reusable trash model files
- **tools/**: Player equipment and tools
- **map/**: Environmental assets and spawn zones

### `config/`
- Centralized configuration for easy balance adjustments
- Trash drop rates, level requirements, rewards, etc.

### `data/`
- Player save data and statistics tracking
- DataStore integration for persistence

### `docs/`
- Game design documentation
- Setup guides and API references

## File Naming Conventions

- **Server scripts**: `lowercase-with-hyphens.lua`
- **Functions**: `camelCase()`
- **Constants**: `UPPER_CASE`
- **Classes/Modules**: `PascalCase`

## Getting Started

1. Review `docs/SETUP.md` for implementation steps
2. Configure `config/game-config.lua` with your game balance
3. Load trash item models into `models/trash-items/`
4. Deploy scripts to appropriate locations in Roblox Studio
5. Test with `docs/MECHANICS.md` as your reference

