local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")

local LevelingService = require(script.Parent:WaitForChild("LevelingService"))
local TrashService = require(script.Parent:WaitForChild("TrashService"))
local UpgradeService = require(script.Parent:WaitForChild("UpgradeService"))
local QuestService = require(script.Parent:WaitForChild("QuestService"))

local GameManager = {}

local function buildRoads(map)
    local roadMaterial = Enum.Material.SmoothPlastic
    local roadColors = {
        Color3.fromRGB(45, 45, 45),
        Color3.fromRGB(60, 60, 60),
        Color3.fromRGB(35, 35, 35),
    }

    local roadPositions = {
        Vector3.new(0, 0.6, 0),
        Vector3.new(0, 0.6, 30),
        Vector3.new(0, 0.6, -30),
        Vector3.new(30, 0.6, 0),
        Vector3.new(-30, 0.6, 0),
        Vector3.new(25, 0.6, 25),
        Vector3.new(-25, 0.6, 25),
        Vector3.new(25, 0.6, -25),
        Vector3.new(-25, 0.6, -25),
    }

    for i, pos in ipairs(roadPositions) do
        local road = Instance.new("Part")
        road.Name = "Road"
        road.Size = Vector3.new(12, 0.5, 12)
        road.Position = pos
        road.Anchored = true
        road.Material = roadMaterial
        road.Color = roadColors[(i % #roadColors) + 1]
        road.Parent = map
    end
end

local function buildDecorations(map)
    local lampColors = {
        Color3.fromRGB(255, 224, 128),
        Color3.fromRGB(255, 204, 88),
    }

    for _, pos in ipairs({
        Vector3.new(0, 5, 35),
        Vector3.new(0, 5, -35),
        Vector3.new(35, 5, 0),
        Vector3.new(-35, 5, 0),
        Vector3.new(25, 5, 25),
        Vector3.new(-25, 5, 25),
        Vector3.new(25, 5, -25),
        Vector3.new(-25, 5, -25),
    }) do
        local pole = Instance.new("Part")
        pole.Name = "LampPole"
        pole.Size = Vector3.new(0.4, 8, 0.4)
        pole.Position = pos
        pole.Anchored = true
        pole.Material = Enum.Material.Metal
        pole.Color = Color3.fromRGB(70, 70, 70)
        pole.Parent = map

        local lamp = Instance.new("Part")
        lamp.Name = "LampLight"
        lamp.Size = Vector3.new(1.5, 1.5, 1.5)
        lamp.Position = pos + Vector3.new(0, 4, 0)
        lamp.Anchored = true
        lamp.Material = Enum.Material.Neon
        lamp.Color = lampColors[math.random(1, #lampColors)]
        lamp.Parent = map
    end
end

local function ensureMap()
    local map = Workspace:FindFirstChild("TrashRushMap")
    if not map then
        map = Instance.new("Folder")
        map.Name = "TrashRushMap"
        map.Parent = Workspace
    end

    local ground = map:FindFirstChild("Ground")
    if not ground then
        ground = Instance.new("Part")
        ground.Name = "Ground"
        ground.Size = Vector3.new(260, 2, 260)
        ground.Position = Vector3.new(0, 0, 0)
        ground.Anchored = true
        ground.Material = Enum.Material.Grass
        ground.Color = Color3.fromRGB(77, 125, 72)
        ground.Parent = map
    end

    local spawnZone = map:FindFirstChild("SpawnZone")
    if not spawnZone then
        spawnZone = Instance.new("Part")
        spawnZone.Name = "SpawnZone"
        spawnZone.Size = Vector3.new(18, 1, 18)
        spawnZone.Position = Vector3.new(0, 3, 0)
        spawnZone.Anchored = true
        spawnZone.Material = Enum.Material.SmoothPlastic
        spawnZone.Color = Color3.fromRGB(255, 188, 74)
        spawnZone.Parent = map
    end

    local spawnLocation = map:FindFirstChild("SpawnLocation")
    if not spawnLocation then
        spawnLocation = Instance.new("SpawnLocation")
        spawnLocation.Name = "SpawnLocation"
        spawnLocation.Size = Vector3.new(18, 1, 18)
        spawnLocation.Position = Vector3.new(0, 4, 0)
        spawnLocation.Anchored = true
        spawnLocation.Neutral = true
        spawnLocation.Transparency = 0.2
        spawnLocation.Parent = map
    end

    buildRoads(map)
    buildDecorations(map)
end

local function onPlayerAdded(player)
    LevelingService.Initialize(player)
    player:SetAttribute("PickupBoostLevel", 0)
    player:SetAttribute("BinBonusLevel", 0)
    player:SetAttribute("SpawnRateLevel", 0)
    player:SetAttribute("TrashCarried", 0)
    player:SetAttribute("CurrentObjectiveLevel", 1)
    player:SetAttribute("CurrentObjectiveProgress", 0)
    player:SetAttribute("RoundTime", 180)
end

function GameManager.Start()
    ensureMap()
    UpgradeService.Setup()
    QuestService.Setup()
    TrashService.Start()

    Players.PlayerAdded:Connect(onPlayerAdded)
    for _, player in ipairs(Players:GetPlayers()) do
        onPlayerAdded(player)
    end
end

return GameManager
