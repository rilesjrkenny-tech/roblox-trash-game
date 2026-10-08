local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Config = require(script.Parent.Parent:WaitForChild("Shared"):WaitForChild("Config"))
local LevelingService = require(script.Parent:WaitForChild("LevelingService"))

local UpgradeService = {}

local function getUpgradeLevel(player, upgradeName)
    return player:GetAttribute(upgradeName .. "Level") or 0
end

local function setUpgradeLevel(player, upgradeName, level)
    player:SetAttribute(upgradeName .. "Level", level)
end

local function buyUpgrade(player, upgradeName)
    local currentLevel = getUpgradeLevel(player, upgradeName)
    local cost = Config:GetUpgradeCost(upgradeName, currentLevel)

    local leaderstats = player:FindFirstChild("leaderstats")
    if not leaderstats then
        return false, "No leaderstats"
    end

    local coinsStat = leaderstats:FindFirstChild("Coins")
    if not coinsStat then
        return false, "No Coins stat"
    end

    if coinsStat.Value < cost then
        return false, "Not enough coins"
    end

    coinsStat.Value -= cost
    setUpgradeLevel(player, upgradeName, currentLevel + 1)

    if upgradeName == "PickupBoost" then
        LevelingService.AddExperience(player, 40)
    elseif upgradeName == "BinBonus" then
        LevelingService.AddExperience(player, 60)
    elseif upgradeName == "SpawnRate" then
        LevelingService.AddExperience(player, 75)
    end

    return true, cost
end

function UpgradeService.Setup()
    local folder = ReplicatedStorage:FindFirstChild("TrashGameRemotes")
    if not folder then
        folder = Instance.new("Folder")
        folder.Name = "TrashGameRemotes"
        folder.Parent = ReplicatedStorage
    end

    local upgradeEvent = folder:FindFirstChild("UpgradeEvent")
    if not upgradeEvent then
        upgradeEvent = Instance.new("RemoteEvent")
        upgradeEvent.Name = "UpgradeEvent"
        upgradeEvent.Parent = folder
    end

    upgradeEvent.OnServerEvent:Connect(function(player, upgradeName)
        local success, result = buyUpgrade(player, upgradeName)
        if success then
            upgradeEvent:FireClient(player, "SUCCESS", upgradeName, result)
        else
            upgradeEvent:FireClient(player, "ERROR", upgradeName, result)
        end
    end)
end

return UpgradeService
