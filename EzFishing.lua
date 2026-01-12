local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

print("--- EZFISHING v5: REWARD MULTIPLIER MODE ---")
print("Selesaikan minigame secara manual, script akan melipatgandakan hasilnya!")

local fishingKeywords = {"fish", "pancing", "minigame", "catch", "hook", "reward", "win"}

local function isFishingRemote(remote)
    local n = remote.Name:lower()
    for _, keyword in ipairs(fishingKeywords) do
        if n:match(keyword) then return true end
    end
    return false
end

local remotes = {}
for _, v in pairs(ReplicatedStorage:GetDescendants()) do
    if v:IsA("RemoteEvent") and isFishingRemote(v) then
        table.insert(remotes, v)
    end
end

for _, remote in ipairs(remotes) do
    local oldFireServer
    oldFireServer = hookmetamethod(game, "__namecall", function(self, ...)
        local args = {...}
        local method = getnamecallmethod()
        
        if self == remote and method == "FireServer" then
            print("Kemenangan manual terdeteksi pada: " .. self.Name)
            print("Melakukan duplikasi hadiah (x10)...")
            
            for i = 1, 10 do
                task.spawn(function()
                    self:FireServer(unpack(args))
                end)
            end
            
            print("Duplikasi selesai!")
        end
        
        return oldFireServer(self, ...)
    end)
end