local Players = game:GetService("Players")

local QuestService = {}

local function getTargetForLevel(level)
    return 6 + (level * 5)
end

local function getObjectiveText(player)
    local level = player:GetAttribute("CurrentObjectiveLevel") or 1
    local target = getTargetForLevel(level)
    local progress = player:GetAttribute("CurrentObjectiveProgress") or 0
    return string.format("Objective %d: Collect %d trash pieces (%d/%d)", level, target, progress, target)
end

local function updatePlayerQuest(player)
    local playerGui = player:FindFirstChild("PlayerGui")
    if not playerGui then
        return
    end

    local hud = playerGui:FindFirstChild("TrashHUD")
    if hud and hud:FindFirstChild("ObjectiveLabel") then
        hud.ObjectiveLabel.Text = getObjectiveText(player)
    end
end

function QuestService.Setup()
    Players.PlayerAdded:Connect(function(player)
        player:SetAttribute("CurrentObjectiveLevel", 1)
        player:SetAttribute("CurrentObjectiveProgress", 0)
        task.defer(updatePlayerQuest, player)
    end)

    for _, player in ipairs(Players:GetPlayers()) do
        player:SetAttribute("CurrentObjectiveLevel", 1)
        player:SetAttribute("CurrentObjectiveProgress", 0)
        task.defer(updatePlayerQuest, player)
    end
end

function QuestService.RegisterPickup(player)
    local level = player:GetAttribute("CurrentObjectiveLevel") or 1
    local progress = player:GetAttribute("CurrentObjectiveProgress") or 0
    local target = getTargetForLevel(level)

    progress += 1
    player:SetAttribute("CurrentObjectiveProgress", progress)

    if progress >= target then
        player:SetAttribute("CurrentObjectiveLevel", level + 1)
        player:SetAttribute("CurrentObjectiveProgress", 0)
    end

    updatePlayerQuest(player)
end

return QuestService
