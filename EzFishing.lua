local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local JUMLAH_DUPLIKAT = 10
local JEDA_ANTAR_SINYAL = 0.3

print("--- EZFISHING v7: MASS DUPLICATOR STARTING ---")

local targetRemote = nil
for _, v in pairs(ReplicatedStorage:GetDescendants()) do
    if v:IsA("RemoteEvent") and (v.Name:lower():match("reward") or v.Name:lower():match("fish") or v.Name:lower():match("add")) then
        targetRemote = v
        break
    end
end

if not targetRemote then
    warn("Remote tidak ditemukan! Pastikan nama remote mengandung kata kunci 'fish' atau 'reward'.")
    return
end

local function startMassExploit(args)
    print("Mengirim " .. JUMLAH_DUPLIKAT .. " sinyal ke: " .. targetRemote.Name)
    
    for i = 1, JUMLAH_DUPLIKAT do
        task.spawn(function()
            targetRemote:FireServer(unpack(args))
        end)
        
        if i % 10 == 0 then task.wait(JEDA_ANTAR_SINYAL) end
    end
    
    print("Done.")
end

local oldNamecall
oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
    local args = {...}
    local method = getnamecallmethod()
    
    if self == targetRemote and method == "FireServer" then
        task.spawn(function()
            startMassExploit(args)
        end)
        
    end
    
    return oldNamecall(self, ...)
end)