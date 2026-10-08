local Config = {
    SpawnInterval = 2.2,
    TrashLifetime = 18,
    WorldSize = 85,
    MaxTrashAlive = 30,
    LevelBaseXP = 180,
    LevelGrowth = 1.35,
    DepositBonus = 12,
    PickupBoostBase = 15,
    BinRewardBase = 40,
    UpgradeCosts = {
        PickupBoost = { base = 35, scale = 1.65 },
        BinBonus = { base = 60, scale = 1.75 },
        SpawnRate = { base = 90, scale = 1.9 },
    },
    TrashTypes = {
        {
            Name = "Plastic Bottle",
            Value = 12,
            Color = Color3.fromRGB(72, 162, 255),
            Size = Vector3.new(0.8, 1.2, 0.8),
        },
        {
            Name = "Aluminum Can",
            Value = 16,
            Color = Color3.fromRGB(220, 220, 220),
            Size = Vector3.new(0.8, 0.9, 0.8),
        },
        {
            Name = "Paper Bag",
            Value = 18,
            Color = Color3.fromRGB(214, 170, 96),
            Size = Vector3.new(1.0, 0.8, 1.0),
        },
        {
            Name = "Coffee Cup",
            Value = 21,
            Color = Color3.fromRGB(120, 82, 59),
            Size = Vector3.new(0.7, 0.9, 0.7),
        },
        {
            Name = "Snack Wrapper",
            Value = 26,
            Color = Color3.fromRGB(164, 86, 255),
            Size = Vector3.new(0.6, 0.6, 0.6),
        },
        {
            Name = "Old Tire",
            Value = 35,
            Color = Color3.fromRGB(90, 90, 90),
            Size = Vector3.new(1.2, 0.8, 1.2),
        },
    },
}

function Config:GetLevelRequirement(level)
    return math.floor(self.LevelBaseXP * (level ^ self.LevelGrowth))
end

function Config:GetUpgradeCost(upgradeName, level)
    local upgrade = self.UpgradeCosts[upgradeName]
    if not upgrade then
        return 0
    end

    return math.floor(upgrade.base * (upgrade.scale ^ level))
end

return Config
