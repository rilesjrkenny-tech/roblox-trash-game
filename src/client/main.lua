local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local HUD = require(script.Parent:WaitForChild("HUD"))

HUD:Create(LocalPlayer)
