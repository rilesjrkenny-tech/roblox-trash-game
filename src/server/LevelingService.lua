local LevelingService = {}

local Config = require(script.Parent.Parent:WaitForChild("Shared"):WaitForChild("Config"))
local SaveService = require(script.Parent:WaitForChild("SaveService"))

local function ensureLeaderstats(player)
    local leaderstats = player:FindFirstChild("leaderstats")
    if not leaderstats then
        leaderstats = Instance.new("Folder")
        leaderstats.Name = "leaderstats"
        leaderstats.Parent = player
    end

    local stats = {
        Level = "Level",
        XP = "XP",
        TrashCollected = "TrashCollected",
        Coins = "Coins",
    }

    for statName, valueName in pairs(stats) do
        local stat = leaderstats:FindFirstChild(valueName)
        if not stat then
            stat = Instance.new("IntValue")
            stat.Name = valueName
            stat.Value = 0
            stat.Parent = leaderstats
        end
    end

    local stat = leaderstats:FindFirstChild("Level")
    if stat and stat.Value < 1 then
        stat.Value = 1
    end
end

function LevelingService.Initialize(player)
    ensureLeaderstats(player)

    local data = SaveService.Load(player)
    local leaderstats = player:FindFirstChild("leaderstats")
    if not leaderstats then
        return
    end

    local levelStat = leaderstats:FindFirstChild("Level")
    local xpStat = leaderstats:FindFirstChild("XP")
    local trashStat = leaderstats:FindFirstChild("TrashCollected")
    local coinStat = leaderstats:FindFirstChild("Coins")

    if levelStat then levelStat.Value = data.Level or 1 end
    if xpStat then xpStat.Value = data.XP or 0 end
    if trashStat then trashStat.Value = data.TrashCollected or 0 end
    if coinStat then coinStat.Value = data.Coins or 0 end

    player:SetAttribute("PickupBoostLevel", data.PickupBoost or 0)
    player:SetAttribute("BinBonusLevel", data.BinBonus or 0)
    player:SetAttribute("SpawnRateLevel", data.SpawnRate or 0)
end

function LevelingService.GetPlayerSnapshot(player)
    local leaderstats = player:FindFirstChild("leaderstats")
    if not leaderstats then
        return nil
    end

    return {
        Level = leaderstats:FindFirstChild("Level") and leaderstats.Level.Value or 1,
        XP = leaderstats:FindFirstChild("XP") and leaderstats.XP.Value or 0,
        TrashCollected = leaderstats:FindFirstChild("TrashCollected") and leaderstats.TrashCollected.Value or 0,
        Coins = leaderstats:FindFirstChild("Coins") and leaderstats.Coins.Value or 0,
        PickupBoost = player:GetAttribute("PickupBoostLevel") or 0,
        BinBonus = player:GetAttribute("BinBonusLevel") or 0,
        SpawnRate = player:GetAttribute("SpawnRateLevel") or 0,
    }
end

function LevelingService.SavePlayer(player)
    local snapshot = LevelingService.GetPlayerSnapshot(player)
    if not snapshot then
        return
    end

    SaveService.Save(player, snapshot)
end

function LevelingService.AddExperience(player, amount)
    local leaderstats = player:FindFirstChild("leaderstats")
    if not leaderstats then
        return 1
    end

    local levelStat = leaderstats:FindFirstChild("Level")
    local xpStat = leaderstats:FindFirstChild("XP")
    if not levelStat or not xpStat then
        return 1
    end

    xpStat.Value += amount

    while xpStat.Value >= Config:GetLevelRequirement(levelStat.Value) do
        xpStat.Value -= Config:GetLevelRequirement(levelStat.Value)
        levelStat.Value += 1
    end

    return levelStat.Value
end

function LevelingService.AddCoins(player, amount)
    local leaderstats = player:FindFirstChild("leaderstats")
    if not leaderstats then
        return 0
    end

    local coinStat = leaderstats:FindFirstChild("Coins")
    if not coinStat then
        return 0
    end

    coinStat.Value += amount
    return coinStat.Value
end

function LevelingService.AddTrash(player, amount)
    local leaderstats = player:FindFirstChild("leaderstats")
    if not leaderstats then
        return 0
    end

    local trashStat = leaderstats:FindFirstChild("TrashCollected")
    if not trashStat then
        return 0
    end

    trashStat.Value += amount
    return trashStat.Value
end

return LevelingService
