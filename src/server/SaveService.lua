local DataStoreService = game:GetService("DataStoreService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local SaveService = {}

local dataStore = nil
if not RunService:IsStudio() then
    dataStore = DataStoreService:GetDataStore("TrashRushAdvancedData")
end

local function getDefaultData()
    return {
        Level = 1,
        XP = 0,
        TrashCollected = 0,
        Coins = 0,
        PickupBoost = 0,
        BinBonus = 0,
        SpawnRate = 0,
    }
end

local function getPlayerDataKey(player)
    return "Player_" .. player.UserId
end

function SaveService.Load(player)
    local defaultData = getDefaultData()

    if RunService:IsStudio() then
        return defaultData
    end

    local success, data = pcall(function()
        return dataStore:GetAsync(getPlayerDataKey(player))
    end)

    if success and data then
        for key, value in pairs(defaultData) do
            if data[key] ~= nil then
                defaultData[key] = data[key]
            end
        end
        return defaultData
    end

    return defaultData
end

function SaveService.Save(player, data)
    if RunService:IsStudio() then
        return true
    end

    local success, err = pcall(function()
        dataStore:SetAsync(getPlayerDataKey(player), data)
    end)

    return success, err
end

return SaveService
