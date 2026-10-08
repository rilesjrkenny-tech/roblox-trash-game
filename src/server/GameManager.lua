local Players = game:GetService("Players")

local QuestService = {}

local function getObjectiveText(player)
    local level = player:GetAttribute("CurrentObjectiveLevel") or 1
    local target = 5 + (level * 3)
    return string.format("Collect %d pieces of trash and deposit them at the bins.", target)
end

local function updatePlayerQuest(player)
    local objectiveText = getObjectiveText(player)
    local gui = player:FindFirstChild("PlayerGui")
    if not gui then
        return
    end

    local hud = gui:FindFirstChild("TrashHUD")
    if hud and hud:FindFirstChild("ObjectiveLabel") then
        hud.ObjectiveLabel.Text = objectiveText
    end
end

function QuestService.Setup()
    Players.PlayerAdded:Connect(function(player)
        player:SetAttribute("CurrentObjectiveLevel", 1)
        player:SetAttribute("CurrentObjectiveProgress", 0)
        task.defer(updatePlayerQuest, player)
    end)
end

function QuestService.RegisterPickup(player)
    local progress = player:GetAttribute("CurrentObjectiveProgress") or 0
    local nextGoal = (player:GetAttribute("CurrentObjectiveLevel") or 1) * 8
    player:SetAttribute("CurrentObjectiveProgress", progress + 1)

    if progress + 1 >= nextGoal then
        player:SetAttribute("CurrentObjectiveLevel", (player:GetAttribute("CurrentObjectiveLevel") or 1) + 1)
        player:SetAttribute("CurrentObjectiveProgress", 0)
    end

    updatePlayerQuest(player)
end

return QuestService
