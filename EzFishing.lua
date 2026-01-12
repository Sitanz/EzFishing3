local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

print("--- EZFISHING v6: AGGRESSIVE DUPLICATOR ---")
print("Mode: Sinyal Serentak (Simultaneous Fire)")

local fishingKeywords = {"fish", "pancing", "minigame", "catch", "hook", "reward", "win"}

local function isFishingRemote(remote)
    local n = remote.Name:lower()
    for _, keyword in ipairs(fishingKeywords) do
        if n:match(keyword) then return true end
    end
    return false
end

local targetRemotes = {}
for _, v in pairs(ReplicatedStorage:GetDescendants()) do
    if v:IsA("RemoteEvent") and isFishingRemote(v) then
        targetRemotes[v] = true
    end
end

local oldNamecall
oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
    local args = {...}
    local method = getnamecallmethod()
    
    if method == "FireServer" and targetRemotes[self] then
        print("Sinyal asli terdeteksi! Mengirim 5 duplikat serentak...")
        
        -- Mengirim 5 sinyal tambahan secara instan
        for i = 1, 5 do 
            task.spawn(function() 
                self:FireServer(unpack(args)) 
            end)
        end
    end
    
    return oldNamecall(self, ...)
end)