local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer
local HUD = require(script.Parent:WaitForChild("HUD"))
local ShopGui = require(script.Parent:WaitForChild("ShopGui"))

local hud = HUD:Create(LocalPlayer)
local shopGui = ShopGui:Create(LocalPlayer)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then
        return
    end

    if input.KeyCode == Enum.KeyCode.U then
        shopGui.Enabled = not shopGui.Enabled
    end
end)

if hud then
    print("[TrashRush] HUD initialized")
end
