local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

print("--- EZFISHING v6: SILENT DUPLICATOR ---")
print("Mode: Pengetesan Toleransi Anti-Cheat")

local fishingKeywords = {"fish", "pancing", "minigame", "catch", "hook", "reward", "win"}

local function isFishingRemote(remote)
    local n = remote.Name:lower()
    for _, keyword in ipairs(fishingKeywords) do
        if n:match(keyword) then return true end
    end
    return false
end

-- Mencari remote yang relevan
local targetRemotes = {}
for _, v in pairs(ReplicatedStorage:GetDescendants()) do
    if v:IsA("RemoteEvent") and isFishingRemote(v) then
        targetRemotes[v] = true
    end
end

-- Hook Metamethod
local oldNamecall
oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
    local args = {...}
    local method = getnamecallmethod()
    
    if method == "FireServer" and targetRemotes[self] then
        print("Sinyal asli terdeteksi: " .. self.Name)
        
        -- Kita jalankan duplikasi di luar thread utama agar tidak lag/kick
        task.defer(function()
            -- Kita hanya coba duplikasi 1 atau 2 kali saja dengan jeda lama
            -- Jika 1 kali tambahan saja sudah kick, berarti Anti-Cheatmu SANGAT KUAT
            for i = 1, 2 do 
                local delayTime = math.random(1.5, 3.5) -- Jeda acak 1.5 - 3.5 detik
                task.wait(delayTime)
                
                print("Mencoba kirim sinyal duplikat ke-"..i.." setelah "..delayTime.." detik...")
                self:FireServer(unpack(args))
            end
        end)
    end
    
    return oldNamecall(self, ...)
end)