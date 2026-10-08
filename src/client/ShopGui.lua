local HUD = {}

function HUD:Create(player)
    local playerGui = player:WaitForChild("PlayerGui")

    local gui = Instance.new("ScreenGui")
    gui.Name = "TrashHUD"
    gui.ResetOnSpawn = false
    gui.IgnoreGuiInset = true
    gui.Parent = playerGui

    local panel = Instance.new("Frame")
    panel.Size = UDim2.new(0, 420, 0, 170)
    panel.Position = UDim2.new(0, 20, 0, 20)
    panel.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
    panel.BackgroundTransparency = 0.15
    panel.BorderSizePixel = 0
    panel.Parent = gui

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, -20, 0, 24)
    title.Position = UDim2.new(0, 10, 0, 8)
    title.BackgroundTransparency = 1
    title.Font = Enum.Font.GothamBold
    title.Text = "Trash Rush"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.TextSize = 22
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = panel

    local statRow = Instance.new("Frame")
    statRow.Size = UDim2.new(1, -20, 0, 60)
    statRow.Position = UDim2.new(0, 10, 0, 38)
    statRow.BackgroundTransparency = 1
    statRow.Parent = panel

    local levelLabel = Instance.new("TextLabel")
    levelLabel.Size = UDim2.new(0.32, 0, 0, 20)
    levelLabel.Position = UDim2.new(0, 0, 0, 0)
    levelLabel.BackgroundTransparency = 1
    levelLabel.Font = Enum.Font.Gotham
    levelLabel.Text = "Level: 1"
    levelLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    levelLabel.TextSize = 16
    levelLabel.TextXAlignment = Enum.TextXAlignment.Left
    levelLabel.Parent = statRow

    local coinsLabel = Instance.new("TextLabel")
    coinsLabel.Size = UDim2.new(0.32, 0, 0, 20)
    coinsLabel.Position = UDim2.new(0.34, 0, 0, 0)
    coinsLabel.BackgroundTransparency = 1
    coinsLabel.Font = Enum.Font.Gotham
    coinsLabel.Text = "Coins: 0"
    coinsLabel.TextColor3 = Color3.fromRGB(255, 220, 90)
    coinsLabel.TextSize = 16
    coinsLabel.TextXAlignment = Enum.TextXAlignment.Left
    coinsLabel.Parent = statRow

    local trashLabel = Instance.new("TextLabel")
    trashLabel.Size = UDim2.new(0.32, 0, 0, 20)
    trashLabel.Position = UDim2.new(0.68, 0, 0, 0)
    trashLabel.BackgroundTransparency = 1
    trashLabel.Font = Enum.Font.Gotham
    trashLabel.Text = "Trash: 0"
    trashLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    trashLabel.TextSize = 16
    trashLabel.TextXAlignment = Enum.TextXAlignment.Left
    trashLabel.Parent = statRow

    local carryLabel = Instance.new("TextLabel")
    carryLabel.Size = UDim2.new(0.32, 0, 0, 20)
    carryLabel.Position = UDim2.new(0, 0, 0, 28)
    carryLabel.BackgroundTransparency = 1
    carryLabel.Font = Enum.Font.Gotham
    carryLabel.Text = "Carry: 0"
    carryLabel.TextColor3 = Color3.fromRGB(125, 214, 255)
    carryLabel.TextSize = 16
    carryLabel.TextXAlignment = Enum.TextXAlignment.Left
    carryLabel.Parent = statRow

    local timerLabel = Instance.new("TextLabel")
    timerLabel.Size = UDim2.new(0.32, 0, 0, 20)
    timerLabel.Position = UDim2.new(0.34, 0, 0, 28)
    timerLabel.BackgroundTransparency = 1
    timerLabel.Font = Enum.Font.Gotham
    timerLabel.Text = "Time: 03:00"
    timerLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    timerLabel.TextSize = 16
    timerLabel.TextXAlignment = Enum.TextXAlignment.Left
    timerLabel.Parent = statRow

    local xpBackground = Instance.new("Frame")
    xpBackground.Size = UDim2.new(1, -20, 0, 18)
    xpBackground.Position = UDim2.new(0, 10, 0, 106)
    xpBackground.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
    xpBackground.BorderSizePixel = 0
    xpBackground.Parent = panel

    local xpFill = Instance.new("Frame")
    xpFill.Size = UDim2.new(0, 0, 1, 0)
    xpFill.BackgroundColor3 = Color3.fromRGB(72, 214, 118)
    xpFill.BorderSizePixel = 0
    xpFill.Parent = xpBackground

    local objectiveLabel = Instance.new("TextLabel")
    objectiveLabel.Name = "ObjectiveLabel"
    objectiveLabel.Size = UDim2.new(1, -20, 0, 26)
    objectiveLabel.Position = UDim2.new(0, 10, 0, 128)
    objectiveLabel.BackgroundTransparency = 1
    objectiveLabel.Font = Enum.Font.Gotham
    objectiveLabel.Text = "Objective: Collect trash and deposit it."
    objectiveLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    objectiveLabel.TextSize = 12
    objectiveLabel.TextXAlignment = Enum.TextXAlignment.Left
    objectiveLabel.Parent = panel

    local function formatTime(seconds)
        local minutes = math.floor(seconds / 60)
        local secs = math.floor(seconds % 60)
        return string.format("%02d:%02d", minutes, secs)
    end

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
        local objective = player:GetAttribute("CurrentObjectiveLevel") or 1
        local objectiveProgress = player:GetAttribute("CurrentObjectiveProgress") or 0
        local target = 6 + (objective * 5)

        levelLabel.Text = "Level: " .. tostring(level.Value)
        coinsLabel.Text = "Coins: " .. tostring(coins.Value)
        trashLabel.Text = "Trash: " .. tostring(trash.Value)
        carryLabel.Text = "Carry: " .. tostring(player:GetAttribute("TrashCarried") or 0)
        xpFill.Size = UDim2.new(progress, 0, 1, 0)
        objectiveLabel.Text = string.format("Objective %d: %d/%d", objective, objectiveProgress, target)
        timerLabel.Text = "Time: " .. formatTime(player:GetAttribute("RoundTime") or 180)
    end

    local function bindChanges()
        local leaderstats = player:FindFirstChild("leaderstats")
        if leaderstats then
            leaderstats.ChildChanged:Connect(updateHUD)
        end

        player:GetAttributeChangedSignal("TrashCarried"):Connect(updateHUD)
        player:GetAttributeChangedSignal("CurrentObjectiveLevel"):Connect(updateHUD)
        player:GetAttributeChangedSignal("CurrentObjectiveProgress"):Connect(updateHUD)
        player:GetAttributeChangedSignal("RoundTime"):Connect(updateHUD)
    end

    bindChanges()
    updateHUD()

    return gui
end

return HUD
