local ReplicatedStorage = game:GetService("ReplicatedStorage")
local targetRemotes = {}

-- Mencari remote pancing atau inventory reward
for _, v in pairs(ReplicatedStorage:GetDescendants()) do
    if v:IsA("RemoteEvent") and (v.Name:lower():match("fish") or v.Name:lower():match("add") or v.Name:lower():match("reward")) then
        targetRemotes[v] = true
    end
end

local oldNamecall
oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
    local args = {...}
    local method = getnamecallmethod()
    
    if method == "FireServer" and targetRemotes[self] then
        print("Sinyal Reward terdeteksi! Mencoba injeksi ke Database Inventory...")
        
        -- Kita beri jeda sedikit lebih lama (0.3s) agar server selesai menulis data pertama
        -- Lalu kita coba kirim 3 kali tambahan
        task.spawn(function()
            for i = 1, 3 do
                task.wait(0.3) 
                self:FireServer(unpack(args))
                print("Injeksi duplikat ke-" .. i .. " terkirim.")
            end
        end)
    end
    
    return oldNamecall(self, ...)
end)