local Config = {
    SpawnInterval = 3,
    TrashLifetime = 18,
    WorldSize = 60,
    LevelBaseXP = 120,
    LevelGrowth = 1.45,
    TrashTypes = {
        {
            Name = "Plastic Bottle",
            Value = 15,
            Color = Color3.fromRGB(51, 153, 255),
            Size = Vector3.new(0.8, 1.2, 0.8),
        },
        {
            Name = "Aluminum Can",
            Value = 18,
            Color = Color3.fromRGB(220, 220, 220),
            Size = Vector3.new(0.8, 0.9, 0.8),
        },
        {
            Name = "Paper Bag",
            Value = 20,
            Color = Color3.fromRGB(214, 170, 96),
            Size = Vector3.new(1.0, 0.8, 1.0),
        },
        {
            Name = "Coffee Cup",
            Value = 24,
            Color = Color3.fromRGB(120, 82, 59),
            Size = Vector3.new(0.7, 0.9, 0.7),
        },
        {
            Name = "Snack Wrapper",
            Value = 27,
            Color = Color3.fromRGB(164, 86, 255),
            Size = Vector3.new(0.6, 0.6, 0.6),
        },
    },
}

function Config:GetLevelRequirement(level)
    return math.floor(self.LevelBaseXP * (level ^ self.LevelGrowth))
end

return Config
