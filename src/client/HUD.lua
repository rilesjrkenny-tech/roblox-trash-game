local HUD = {}

function HUD:Create(player)
    local playerGui = player:WaitForChild("PlayerGui")
    local gui = Instance.new("ScreenGui")
    gui.Name = "TrashHUD"
    gui.ResetOnSpawn = false
    gui.IgnoreGuiInset = true
    gui.Parent = playerGui

    local panel = Instance.new("Frame")
    panel.Name = "Panel"
    panel.Size = UDim2.new(0, 320, 0, 110)
    panel.Position = UDim2.new(0, 20, 0, 20)
    panel.BackgroundColor3 = Color3.fromRGB(33, 33, 33)
    panel.BackgroundTransparency = 0.2
    panel.BorderSizePixel = 0
    panel.Parent = gui

    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(255, 255, 255)
    stroke.Transparency = 0.5
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke.Parent = panel

    local title = Instance.new("TextLabel")
    title.Name = "Title"
    title.Size = UDim2.new(1, -20, 0, 24)
    title.Position = UDim2.new(0, 10, 0, 8)
    title.BackgroundTransparency = 1
    title.Font = Enum.Font.GothamBold
    title.Text = "Trash Rush"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.TextSize = 20
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = panel

    local levelLabel = Instance.new("TextLabel")
    levelLabel.Name = "LevelLabel"
    levelLabel.Size = UDim2.new(0.5, -20, 0, 20)
    levelLabel.Position = UDim2.new(0, 10, 0, 36)
    levelLabel.BackgroundTransparency = 1
    levelLabel.Font = Enum.Font.Gotham
    levelLabel.Text = "Level: 1"
    levelLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    levelLabel.TextSize = 16
    levelLabel.TextXAlignment = Enum.TextXAlignment.Left
    levelLabel.Parent = panel

    local trashLabel = Instance.new("TextLabel")
    trashLabel.Name = "TrashLabel"
    trashLabel.Size = UDim2.new(0.5, -20, 0, 20)
    trashLabel.Position = UDim2.new(0.5, 0, 0, 36)
    trashLabel.BackgroundTransparency = 1
    trashLabel.Font = Enum.Font.Gotham
    trashLabel.Text = "Trash: 0"
    trashLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    trashLabel.TextSize = 16
    trashLabel.TextXAlignment = Enum.TextXAlignment.Left
    trashLabel.Parent = panel

    local xpBarBackground = Instance.new("Frame")
    xpBarBackground.Name = "XPBarBackground"
    xpBarBackground.Size = UDim2.new(1, -20, 0, 18)
    xpBarBackground.Position = UDim2.new(0, 10, 0, 66)
    xpBarBackground.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    xpBarBackground.BorderSizePixel = 0
    xpBarBackground.Parent = panel

    local xpBarFill = Instance.new("Frame")
    xpBarFill.Name = "XPBarFill"
    xpBarFill.Size = UDim2.new(0, 0, 1, 0)
    xpBarFill.Position = UDim2.new(0, 0, 0, 0)
    xpBarFill.BackgroundColor3 = Color3.fromRGB(75, 214, 120)
    xpBarFill.BorderSizePixel = 0
    xpBarFill.Parent = xpBarBackground

    local xpText = Instance.new("TextLabel")
    xpText.Name = "XPText"
    xpText.Size = UDim2.new(1, 0, 0, 18)
    xpText.Position = UDim2.new(0, 0, 0, 66)
    xpText.BackgroundTransparency = 1
    xpText.Font = Enum.Font.Gotham
    xpText.Text = "XP: 0 / 120"
    xpText.TextColor3 = Color3.fromRGB(255, 255, 255)
    xpText.TextSize = 14
    xpText.TextTransparency = 0.05
    xpText.Parent = panel

    local function updateHUD()
        local leaderstats = player:FindFirstChild("leaderstats")
        if not leaderstats then
            return
        end

        local level = leaderstats:FindFirstChild("Level")
        local xp = leaderstats:FindFirstChild("XP")
        local trash = leaderstats:FindFirstChild("TrashCollected")

        if not level or not xp or not trash then
            return
        end

        local requiredXP = math.floor(120 * (level.Value ^ 1.45))
        local progress = math.clamp(xp.Value / requiredXP, 0, 1)

        levelLabel.Text = "Level: " .. tostring(level.Value)
        trashLabel.Text = "Trash: " .. tostring(trash.Value)
        xpText.Text = "XP: " .. tostring(xp.Value) .. " / " .. tostring(requiredXP)
        xpBarFill.Size = UDim2.new(progress, 0, 1, 0)
    end

    local function watchLeaderstats()
        local leaderstats = player:FindFirstChild("leaderstats")
        if not leaderstats then
            return
        end

        leaderstats.ChildAdded:Connect(updateHUD)
        leaderstats.ChildRemoved:Connect(updateHUD)
        leaderstats.ChildChanged:Connect(updateHUD)
    end

    task.spawn(function()
        local leaderstats = player:WaitForChild("leaderstats", 10)
        if leaderstats then
            watchLeaderstats()
            updateHUD()
        end
    end)

    return gui
end

return HUD
