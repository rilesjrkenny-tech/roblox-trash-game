local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ShopGui = {}

function ShopGui:Create(player)
    local playerGui = player:WaitForChild("PlayerGui")
    local gui = Instance.new("ScreenGui")
    gui.Name = "ShopGui"
    gui.ResetOnSpawn = false
    gui.Parent = playerGui

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 340, 0, 220)
    frame.Position = UDim2.new(0.5, -170, 0.5, -110)
    frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    frame.BorderSizePixel = 0
    frame.Parent = gui

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, -20, 0, 26)
    title.Position = UDim2.new(0, 10, 0, 10)
    title.BackgroundTransparency = 1
    title.Font = Enum.Font.GothamBold
    title.Text = "Upgrade Shop"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.TextSize = 20
    title.Parent = frame

    local upgrades = {
        { name = "PickupBoost", label = "Pickup Boost" },
        { name = "BinBonus", label = "Bin Bonus" },
        { name = "SpawnRate", label = "Spawn Rate" },
    }

    local remoteFolder = ReplicatedStorage:FindFirstChild("TrashGameRemotes")
    local upgradeEvent = remoteFolder and remoteFolder:FindFirstChild("UpgradeEvent") or nil

    local yOffset = 50
    for _, upgrade in ipairs(upgrades) do
        local button = Instance.new("TextButton")
        button.Size = UDim2.new(1, -20, 0, 40)
        button.Position = UDim2.new(0, 10, 0, yOffset)
        button.BackgroundColor3 = Color3.fromRGB(60, 152, 255)
        button.Font = Enum.Font.GothamBold
        button.Text = upgrade.label
        button.TextColor3 = Color3.fromRGB(255, 255, 255)
        button.TextSize = 16
        button.Parent = frame

        button.MouseButton1Click:Connect(function()
            if upgradeEvent then
                upgradeEvent:FireServer(upgrade.name)
            end
        end)

        yOffset += 48
    end

    local closeButton = Instance.new("TextButton")
    closeButton.Size = UDim2.new(0, 90, 0, 30)
    closeButton.Position = UDim2.new(1, -100, 1, -40)
    closeButton.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
    closeButton.Font = Enum.Font.GothamBold
    closeButton.Text = "Close"
    closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeButton.Parent = frame

    closeButton.MouseButton1Click:Connect(function()
        gui.Enabled = false
    end)

    gui.Enabled = false
    return gui
end

return ShopGui
