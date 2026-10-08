local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local HUD = {}

function HUD:Create(player)
    local playerGui = player:WaitForChild("PlayerGui")
    local gui = Instance.new("ScreenGui")
    gui.Name = "TrashHUD"
    gui.ResetOnSpawn = false
    gui.IgnoreGuiInset = true
    gui.Parent = playerGui

    local panel = Instance.new("Frame")
    panel.Size = UDim2.new(0, 360, 0, 150)
    panel.Position = UDim2.new(0, 20, 0, 20)
    panel.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    panel.BackgroundTransparency = 0.18
    panel.BorderSizePixel = 0
    panel.Parent = gui

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, -20, 0, 28)
    title.Position = UDim2.new(0, 10, 0, 8)
    title.BackgroundTransparency = 1
    title.Font = Enum.Font.GothamBold
    title.Text = "Trash Rush Advanced"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.TextSize = 22
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = panel

    local levelLabel = Instance.new("TextLabel")
    levelLabel.Size = UDim2.new(0.45, -10, 0, 20)
    levelLabel.Position = UDim2.new(0, 10, 0, 42)
    levelLabel.BackgroundTransparency = 1
    levelLabel.Font = Enum.Font.Gotham
    levelLabel.Text = "Level: 1"
    levelLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    levelLabel.TextSize = 16
    levelLabel.TextXAlignment = Enum.TextXAlignment.Left
    levelLabel.Parent = panel

    local coinsLabel = Instance.new("TextLabel")
    coinsLabel.Size = UDim2.new(0.45, -10, 0, 20)
    coinsLabel.Position = UDim2.new(0.5, 0, 0, 42)
    coinsLabel.BackgroundTransparency = 1
    coinsLabel.Font = Enum.Font.Gotham
    coinsLabel.Text = "Coins: 0"
    coinsLabel.TextColor3 = Color3.fromRGB(255, 206, 82)
    coinsLabel.TextSize = 16
    coinsLabel.TextXAlignment = Enum.TextXAlignment.Left
    coinsLabel.Parent = panel

    local trashLabel = Instance.new("TextLabel")
    trashLabel.Size = UDim2.new(0.45, -10, 0, 20)
    trashLabel.Position = UDim2.new(0, 10, 0, 68)
    trashLabel.BackgroundTransparency = 1
    trashLabel.Font = Enum.Font.Gotham
    trashLabel.Text = "Trash: 0"
    trashLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    trashLabel.TextSize = 16
    trashLabel.TextXAlignment = Enum.TextXAlignment.Left
    trashLabel.Parent = panel

    local carryLabel = Instance.new("TextLabel")
    carryLabel.Size = UDim2.new(0.45, -10, 0, 20)
    carryLabel.Position = UDim2.new(0.5, 0, 0, 68)
    carryLabel.BackgroundTransparency = 1
    carryLabel.Font = Enum.Font.Gotham
    carryLabel.Text = "Carry: 0"
    carryLabel.TextColor3 = Color3.fromRGB(109, 216, 255)
    carryLabel.TextSize = 16
    carryLabel.TextXAlignment = Enum.TextXAlignment.Left
    carryLabel.Parent = panel

    local xpBack = Instance.new("Frame")
    xpBack.Size = UDim2.new(1, -20, 0, 18)
    xpBack.Position = UDim2.new(0, 10, 0, 100)
    xpBack.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
    xpBack.BorderSizePixel = 0
    xpBack.Parent = panel

    local xpFill = Instance.new("Frame")
    xpFill.Size = UDim2.new(0, 0, 1, 0)
    xpFill.BackgroundColor3 = Color3.fromRGB(75, 214, 120)
    xpFill.BorderSizePixel = 0
    xpFill.Parent = xpBack

    local objectiveLabel = Instance.new("TextLabel")
    objectiveLabel.Size = UDim2.new(1, -20, 0, 18)
    objectiveLabel.Position = UDim2.new(0, 10, 0, 122)
    objectiveLabel.BackgroundTransparency = 1
    objectiveLabel.Font = Enum.Font.Gotham
    objectiveLabel.Text = "Collect trash and deposit it for rewards."
    objectiveLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    objectiveLabel.TextSize = 12
    objectiveLabel.TextXAlignment = Enum.TextXAlignment.Left
    objectiveLabel.Parent = panel

    local function updateHUD()
        local leaderstats = player:FindFirstChild("leaderstats")
        if not leaderstats then
            return
        end

        local level = leaderstats:FindFirstChild("Level")
        local xp = leaderstats:FindFirstChild("XP")
        local trash = leaderstats:FindFirstChild("TrashCollected")
        local coins = leaderstats:FindFirstChild("Coins")

        if not level or not xp or not trash or not coins then
            return
        end

        local requiredXP = math.floor(180 * (level.Value ^ 1.35))
        local progress = math.clamp(xp.Value / requiredXP, 0, 1)

        levelLabel.Text = "Level: " .. tostring(level.Value)
        trashLabel.Text = "Trash: " .. tostring(trash.Value)
        coinsLabel.Text = "Coins: " .. tostring(coins.Value)
        carryLabel.Text = "Carry: " .. tostring(player:GetAttribute("TrashCarried") or 0)
        xpFill.Size = UDim2.new(progress, 0, 1, 0)
    end

    local function bindStats()
        local leaderstats = player:FindFirstChild("leaderstats")
        if leaderstats then
            local connection = leaderstats.ChildChanged:Connect(function()
                updateHUD()
            end)
            player:SetAttribute("TrashCarried", player:GetAttribute("TrashCarried") or 0)
            updateHUD()
            return connection
        end
    end

    player:GetAttributeChangedSignal("TrashCarried"):Connect(updateHUD)
    bindStats()
    updateHUD()

    return gui
end

return HUD
