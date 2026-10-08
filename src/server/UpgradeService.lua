local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")

local Config = require(script.Parent.Parent:WaitForChild("Shared"):WaitForChild("Config"))
local LevelingService = require(script.Parent:WaitForChild("LevelingService"))
local QuestService = require(script.Parent:WaitForChild("QuestService"))

local TrashService = {}

local activeTrash = {}

local function addGlow(part, color)
    local glow = Instance.new("SelectionBox")
    glow.Adornee = part
    glow.Color3 = color
    glow.LineThickness = 0.05
    glow.Transparency = 0.6
    glow.Parent = part
end

local function createTrashPart(position)
    local trashType = Config.TrashTypes[math.random(1, #Config.TrashTypes)]

    local part = Instance.new("Part")
    part.Name = "Trash"
    part.Size = trashType.Size
    part.Color = trashType.Color
    part.Material = Enum.Material.SmoothPlastic
    part.Position = position
    part.Anchored = true
    part.CanCollide = false
    part.Shape = Enum.PartType.Ball
    part.Parent = Workspace

    part:SetAttribute("TrashValue", trashType.Value)
    part:SetAttribute("TrashName", trashType.Name)
    addGlow(part, trashType.Color)

    local touchedConnection
    touchedConnection = part.Touched:Connect(function(hit)
        local character = hit.Parent
        if not character then
            return
        end

        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if not humanoid then
            return
        end

        local player = Players:GetPlayerFromCharacter(character)
        if not player then
            return
        end

        local pickupBoost = player:GetAttribute("PickupBoostLevel") or 0
        local baseValue = part:GetAttribute("TrashValue") or 10
        local xpGain = baseValue + (pickupBoost * 7)

        LevelingService.AddExperience(player, xpGain)
        LevelingService.AddTrash(player, 1)
        QuestService.RegisterPickup(player)

        local currentCarry = player:GetAttribute("TrashCarried") or 0
        player:SetAttribute("TrashCarried", currentCarry + 1)

        if touchedConnection then
            touchedConnection:Disconnect()
        end

        part:Destroy()
        activeTrash[part] = nil
    end)

    task.delay(Config.TrashLifetime, function()
        if touchedConnection then
            touchedConnection:Disconnect()
        end

        if part and part.Parent then
            part:Destroy()
        end

        activeTrash[part] = nil
    end)

    activeTrash[part] = true
end

local function createDepositBin(position)
    local bin = Instance.new("Part")
    bin.Name = "TrashDepositBin"
    bin.Size = Vector3.new(6, 8, 6)
    bin.Position = position
    bin.Anchored = true
    bin.Material = Enum.Material.Metal
    bin.Color = Color3.fromRGB(41, 41, 41)
    bin.Parent = Workspace

    local label = Instance.new("BillboardGui")
    label.Name = "BinLabel"
    label.Size = UDim2.new(0, 180, 0, 60)
    label.StudsOffset = Vector3.new(0, 4, 0)
    label.AlwaysOnTop = true
    label.Parent = bin

    local text = Instance.new("TextLabel")
    text.Size = UDim2.new(1, 0, 1, 0)
    text.BackgroundTransparency = 1
    text.Text = "DEPOSIT BIN"
    text.Font = Enum.Font.GothamBold
    text.TextScaled = true
    text.TextColor3 = Color3.fromRGB(255, 255, 255)
    text.Parent = label

    local touchedConnection
    touchedConnection = bin.Touched:Connect(function(hit)
        local character = hit.Parent
        if not character then
            return
        end

        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if not humanoid then
            return
        end

        local player = Players:GetPlayerFromCharacter(character)
        if not player then
            return
        end

        local carryAmount = player:GetAttribute("TrashCarried") or 0
        if carryAmount <= 0 then
            return
        end

        local binBonus = player:GetAttribute("BinBonusLevel") or 0
        local reward = carryAmount * (Config.DepositBonus + binBonus * 7)

        LevelingService.AddCoins(player, reward)
        LevelingService.AddExperience(player, reward)

        player:SetAttribute("TrashCarried", 0)
    end)

    return bin
end

function TrashService.Start()
    local depositFolder = Workspace:FindFirstChild("TrashDepositFolder")
    if not depositFolder then
        depositFolder = Instance.new("Folder")
        depositFolder.Name = "TrashDepositFolder"
        depositFolder.Parent = Workspace
    end

    if #depositFolder:GetChildren() == 0 then
        local depositPositions = {
            Vector3.new(-30, 3, -30),
            Vector3.new(30, 3, -30),
            Vector3.new(0, 3, 32),
            Vector3.new(-28, 3, 28),
            Vector3.new(28, 3, 28),
        }

        for _, pos in ipairs(depositPositions) do
            createDepositBin(pos)
        end
    end

    task.spawn(function()
        while true do
            local currentTrashCount = 0
            for _ in pairs(activeTrash) do
                currentTrashCount += 1
            end

            if currentTrashCount < Config.MaxTrashAlive then
                local spawnX = math.random(-Config.WorldSize, Config.WorldSize)
                local spawnZ = math.random(-Config.WorldSize, Config.WorldSize)
                local position = Vector3.new(spawnX, 3, spawnZ)
                createTrashPart(position)
            end

            task.wait(Config.SpawnInterval)
        end
    end)
end

return TrashService
