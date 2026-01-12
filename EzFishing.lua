local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

print("--- UNIVERSAL FISHING BYPASS v4 (STEALTH MODE) ---")

local winningArg = true 

local fishingKeywords = {"fish", "pancing", "minigame", "catch", "hook", "rod", "game"}

local function isFishingRemote(name)
    local n = name:lower()
    for _, keyword in ipairs(fishingKeywords) do
        if n:match(keyword) then return true end
    end
    return false
end

local function stealthBypass(remote)
    if remote.Name:match("Default") or remote.Name:match("Roblox") then return end
    
    if isFishingRemote(remote.Name) then
        local humanDelay = math.random(3, 7)
        print("Target ditemukan: " .. remote.Name .. ". Menunggu " .. humanDelay .. " detik agar tidak terdeteksi...")
        
        task.wait(humanDelay)
        
        pcall(function()
            remote:FireServer(winningArg)
        end)
        
        print("Sinyal Stealth terkirim ke: " .. remote.Name)
    end
end

task.spawn(function()
    while true do
        local remotesFound = {}
        
        for _, v in pairs(ReplicatedStorage:GetDescendants()) do
            if v:IsA("RemoteEvent") and isFishingRemote(v.Name) then
                table.insert(remotesFound, v)
            end
        end

        if LocalPlayer.Character then
            for _, v in pairs(LocalPlayer.Character:GetDescendants()) do
                if v:IsA("RemoteEvent") and isFishingRemote(v.Name) then
                    table.insert(remotesFound, v)
                end
            end
        end

        for _, remote in ipairs(remotesFound) do
            stealthBypass(remote)
            task.wait(math.random(2, 4))
        end
        
        task.wait(10)
    end
end)