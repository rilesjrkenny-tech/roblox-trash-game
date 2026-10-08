local LevelingService = {}

local Config = require(script.Parent.Parent:WaitForChild("Shared"):WaitForChild("Config"))

local function ensureLeaderstats(player)
    local leaderstats = player:FindFirstChild("leaderstats")
    if not leaderstats then
        leaderstats = Instance.new("Folder")
        leaderstats.Name = "leaderstats"
        leaderstats.Parent = player
    end

    local level = leaderstats:FindFirstChild("Level")
    if not level then
        level = Instance.new("IntValue")
        level.Name = "Level"
        level.Value = 1
        level.Parent = leaderstats
    end

    local xp = leaderstats:FindFirstChild("XP")
    if not xp then
        xp = Instance.new("IntValue")
        xp.Name = "XP"
        xp.Value = 0
        xp.Parent = leaderstats
    end

    local trash = leaderstats:FindFirstChild("TrashCollected")
    if not trash then
        trash = Instance.new("IntValue")
        trash.Name = "TrashCollected"
        trash.Value = 0
        trash.Parent = leaderstats
    end
end

function LevelingService.Initialize(player)
    ensureLeaderstats(player)
end

function LevelingService.AddExperience(player, amount)
    local leaderstats = player:FindFirstChild("leaderstats")
    if not leaderstats then
        return 1
    end

    local levelValue = leaderstats:FindFirstChild("Level")
    local xpValue = leaderstats:FindFirstChild("XP")

    if not levelValue or not xpValue then
        return 1
    end

    xpValue.Value = xpValue.Value + amount

    while xpValue.Value >= Config:GetLevelRequirement(levelValue.Value) do
        xpValue.Value = xpValue.Value - Config:GetLevelRequirement(levelValue.Value)
        levelValue.Value = levelValue.Value + 1
    end

    return levelValue.Value
end

return LevelingService
