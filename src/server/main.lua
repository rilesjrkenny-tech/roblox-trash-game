local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")

local LevelingService = require(script.Parent:WaitForChild("LevelingService"))
local TrashService = require(script.Parent:WaitForChild("TrashService"))
local UpgradeService = require(script.Parent:WaitForChild("UpgradeService"))
local QuestService = require(script.Parent:WaitForChild("QuestService"))

local GameManager = {}

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
        ground.Size = Vector3.new(250, 2, 250)
        ground.Position = Vector3.new(0, 0, 0)
        ground.Anchored = true
        ground.Material = Enum.Material.Grass
        ground.Color = Color3.fromRGB(58, 122, 66)
        ground.Parent = map
    end

    local spawnZone = map:FindFirstChild("SpawnZone")
    if not spawnZone then
        spawnZone = Instance.new("Part")
        spawnZone.Name = "SpawnZone"
        spawnZone.Size = Vector3.new(20, 1, 20)
        spawnZone.Position = Vector3.new(0, 3.5, 0)
        spawnZone.Anchored = true
        spawnZone.Material = Enum.Material.SmoothPlastic
        spawnZone.Color = Color3.fromRGB(255, 190, 73)
        spawnZone.Parent = map
    end

    local spawnLocation = map:FindFirstChild("SpawnLocation")
    if not spawnLocation then
        spawnLocation = Instance.new("SpawnLocation")
        spawnLocation.Name = "SpawnLocation"
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
    player:SetAttribute("PickupBoostLevel", 0)
    player:SetAttribute("BinBonusLevel", 0)
    player:SetAttribute("SpawnRateLevel", 0)
    player:SetAttribute("TrashCarried", 0)
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
