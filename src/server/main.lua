local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")

local LevelingService = require(script.Parent:WaitForChild("LevelingService"))
local TrashService = require(script.Parent:WaitForChild("TrashService"))

local function ensureMap()
    local map = Workspace:FindFirstChild("TrashMap")
    if not map then
        map = Instance.new("Folder")
        map.Name = "TrashMap"
        map.Parent = Workspace
    end

    local ground = map:FindFirstChild("Ground")
    if not ground then
        ground = Instance.new("Part")
        ground.Name = "Ground"
        ground.Size = Vector3.new(200, 2, 200)
        ground.Position = Vector3.new(0, 0, 0)
        ground.Anchored = true
        ground.Material = Enum.Material.Grass
        ground.Color = Color3.fromRGB(58, 122, 66)
        ground.Parent = map
    end

    local spawnPad = map:FindFirstChild("SpawnPad")
    if not spawnPad then
        spawnPad = Instance.new("Part")
        spawnPad.Name = "SpawnPad"
        spawnPad.Size = Vector3.new(20, 1, 20)
        spawnPad.Position = Vector3.new(0, 3, 0)
        spawnPad.Anchored = true
        spawnPad.Material = Enum.Material.SmoothPlastic
        spawnPad.Color = Color3.fromRGB(255, 176, 32)
        spawnPad.Parent = map
    end

    local spawnLocation = map:FindFirstChild("TrashSpawnLocation")
    if not spawnLocation then
        spawnLocation = Instance.new("SpawnLocation")
        spawnLocation.Name = "TrashSpawnLocation"
        spawnLocation.Size = Vector3.new(20, 1, 20)
        spawnLocation.Position = Vector3.new(0, 4, 0)
        spawnLocation.Anchored = true
        spawnLocation.Neutral = true
        spawnLocation.Transparency = 0.2
        spawnLocation.Parent = map
    end
end

local function onPlayerAdded(player)
    LevelingService.Initialize(player)
end

Players.PlayerAdded:Connect(onPlayerAdded)
for _, player in ipairs(Players:GetPlayers()) do
    onPlayerAdded(player)
end

ensureMap()
TrashService.Start()
