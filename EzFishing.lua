local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

print("--- UNIVERSAL FISHING BYPASS v3 (ACCURATE MODE) ---")

-- Argumen kemenangan
local winningArgs = {
    {true},
    {"Finished"},
    {100},
    {"Success"}
}

-- Filter: Hanya tembak remote yang namanya mengandung kata-kata ini
local fishingKeywords = {"fish", "pancing", "minigame", "catch", "hook", "rod", "game"}

local function isFishingRemote(name)
    local n = name:lower()
    for _, keyword in ipairs(fishingKeywords) do
        if n:match(keyword) then
            return true
        end
    end
    return false
end

local function startBypass(remote)
    -- Abaikan remote sistem/default
    if remote.Name:match("Default") or remote.Name:match("Roblox") then return end
    
    -- Hanya tembak jika namanya relevan dengan pancingan
    if isFishingRemote(remote.Name) then
        print("Target ditemukan! Mencoba bypass: " .. remote.Name)
        for _, args in ipairs(winningArgs) do
            task.spawn(function()
                pcall(function()
                    remote:FireServer(unpack(args))
                end)
            end)
        end
    end
end

task.spawn(function()
    while true do
        -- Scan ReplicatedStorage
        for _, v in pairs(ReplicatedStorage:GetDescendants()) do
            if v:IsA("RemoteEvent") then
                startBypass(v)
            end
        end

        -- Scan alat yang dipegang
        if LocalPlayer.Character then
            for _, v in pairs(LocalPlayer.Character:GetDescendants()) do
                if v:IsA("RemoteEvent") then
                    startBypass(v)
                end
            end
        end
        
        task.wait(5) -- Jeda lebih lama agar tidak dianggap spam/respawn
    end
end)