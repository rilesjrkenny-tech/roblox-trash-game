local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")

local Config = require(script.Parent.Parent:WaitForChild("Shared"):WaitForChild("Config"))
local LevelingService = require(script.Parent:WaitForChild("LevelingService"))

local TrashService = {}

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
    part.Parent = Workspace
    part:SetAttribute("TrashValue", trashType.Value)
    part:SetAttribute("TrashName", trashType.Name)

    local highlight = Instance.new("Highlight")
    highlight.FillTransparency = 0.75
    highlight.OutlineColor = trashType.Color
    highlight.Parent = part

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

        local leaderstats = player:FindFirstChild("leaderstats")
        if not leaderstats then
            return
        end

        local trashStat = leaderstats:FindFirstChild("TrashCollected")
        if trashStat then
            trashStat.Value += 1
        end

        local xpGain = part:GetAttribute("TrashValue") or 10
        LevelingService.AddExperience(player, xpGain)

        if touchedConnection then
            touchedConnection:Disconnect()
        end

        part:Destroy()
    end)

    task.delay(Config.TrashLifetime, function()
        if touchedConnection then
            touchedConnection:Disconnect()
        end

        if part and part.Parent then
            part:Destroy()
        end
    end)
end

function TrashService.Start()
    task.spawn(function()
        while true do
            local x = math.random(-Config.WorldSize, Config.WorldSize)
            local z = math.random(-Config.WorldSize, Config.WorldSize)
            local spawnPosition = Vector3.new(x, 3, z)

            createTrashPart(spawnPosition)
            task.wait(Config.SpawnInterval)
        end
    end)
end

return TrashService
