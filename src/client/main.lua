local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ShopGui = {}

function ShopGui:Create(player)
    local playerGui = player:WaitForChild("PlayerGui")

    local gui = Instance.new("ScreenGui")
    gui.Name = "ShopGui"
    gui.ResetOnSpawn = false
    gui.Parent = playerGui

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 360, 0, 260)
    frame.Position = UDim2.new(0.5, -180, 0.5, -130)
    frame.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
    frame.BorderSizePixel = 0
    frame.Parent = gui

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, -20, 0, 28)
    title.Position = UDim2.new(0, 10, 0, 10)
    title.BackgroundTransparency = 1
    title.Font = Enum.Font.GothamBold
    title.Text = "Upgrade Shop"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.TextSize = 22
    title.Parent = frame

    local upgrades = {
        {
            name = "PickupBoost",
            label = "Pickup Boost",
            description = "Adds more XP from every pickup.",
        },
        {
            name = "BinBonus",
            label = "Bin Bonus",
            description = "Adds bigger rewards when depositing trash.",
        },
        {
            name = "SpawnRate",
            label = "Spawn Rate",
            description = "Increases trash availability and pace.",
        },
    }

    local remoteFolder = ReplicatedStorage:FindFirstChild("TrashGameRemotes")
    local upgradeEvent = remoteFolder and remoteFolder:FindFirstChild("UpgradeEvent") or nil

    local yOffset = 52
    for _, upgrade in ipairs(upgrades) do
        local card = Instance.new("Frame")
        card.Size = UDim2.new(1, -20, 0, 52)
        card.Position = UDim2.new(0, 10, 0, yOffset)
        card.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        card.BorderSizePixel = 0
        card.Parent = frame

        local button = Instance.new("TextButton")
        button.Size = UDim2.new(0, 90, 0, 30)
        button.Position = UDim2.new(1, -100, 0.5, -15)
        button.BackgroundColor3 = Color3.fromRGB(74, 172, 255)
        button.Font = Enum.Font.GothamBold
        button.Text = "Buy"
        button.TextColor3 = Color3.fromRGB(255, 255, 255)
        button.TextSize = 14
        button.Parent = card

        local name = Instance.new("TextLabel")
        name.Size = UDim2.new(0.5, 0, 0, 18)
        name.Position = UDim2.new(0, 8, 0, 6)
        name.BackgroundTransparency = 1
        name.Font = Enum.Font.GothamBold
        name.Text = upgrade.label
        name.TextColor3 = Color3.fromRGB(255, 255, 255)
        name.TextSize = 14
        name.TextXAlignment = Enum.TextXAlignment.Left
        name.Parent = card

        local description = Instance.new("TextLabel")
        description.Size = UDim2.new(0.6, 0, 0, 16)
        description.Position = UDim2.new(0, 8, 0, 28)
        description.BackgroundTransparency = 1
        description.Font = Enum.Font.Gotham
        description.Text = upgrade.description
        description.TextColor3 = Color3.fromRGB(190, 190, 190)
        description.TextSize = 11
        description.TextXAlignment = Enum.TextXAlignment.Left
        description.Parent = card

        button.MouseButton1Click:Connect(function()
            if upgradeEvent then
                upgradeEvent:FireServer(upgrade.name)
            end
        end)

        yOffset += 60
    end

    local closeButton = Instance.new("TextButton")
    closeButton.Size = UDim2.new(0, 90, 0, 30)
    closeButton.Position = UDim2.new(1, -100, 1, -40)
    closeButton.BackgroundColor3 = Color3.fromRGB(255, 109, 109)
    closeButton.Font = Enum.Font.GothamBold
    closeButton.Text = "Close"
    closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeButton.TextSize = 14
    closeButton.Parent = frame

    closeButton.MouseButton1Click:Connect(function()
        gui.Enabled = false
    end)

    gui.Enabled = false
    return gui
end

return ShopGui
