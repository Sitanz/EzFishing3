local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local JUMLAH_IKAN = 100
local JEDA_SPAM = 0.05

print("--- EZFISHING v10: XENO EDITION ACTIVE ---")

local targetRemote = nil
for _, v in pairs(ReplicatedStorage:GetDescendants()) do
    if v:IsA("RemoteEvent") then
        local n = v.Name:lower()
        if n:match("fish") or n:match("reward") or n:match("catch") or n:match("add") then
            targetRemote = v
            break
        end
    end
end

if not targetRemote then
    warn("Remote tidak ditemukan! Pastikan nama remote mengandung kata 'fish' atau 'reward'.")
    return
end

print("Remote Target: " .. targetRemote.Name)

local function panggilHadiah(args)
    print("Memulai duplikasi " .. JUMLAH_IKAN .. " ikan...")
    for i = 1, JUMLAH_IKAN do
        task.spawn(function()
            targetRemote:FireServer(unpack(args))
        end)
        
        if i % 20 == 0 then task.wait(JEDA_SPAM) end
    end
    print("Duplikasi Selesai. Cek Inventory!")
end

local mt = getrawmetatable(game)
local oldIndex = mt.__index
setreadonly(mt, false)

mt.__index = newcclosure(function(t, k)
    if k == "FireServer" and t == targetRemote then
        return function(self, ...)
            local args = {...}
            task.spawn(function()
                panggilHadiah(args)
            end)
            return targetRemote.FireServer(self, unpack(args))
        end
    end
    return oldIndex(t, k)
end)
setreadonly(mt, true)

print("SISTEM SIAP: Silakan memancing 1x secara manual.")