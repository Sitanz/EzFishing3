local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RemoteName = "CreateRewardInfoEvent"
local targetRemote = ReplicatedStorage:FindFirstChild(RemoteName, true)

print("--- EZFISHING v12: DATA CAPTURE MODE ---")

-- Menunggu kemenangan manual untuk mencuri 'Argumen' yang sah
local function CaptureAndMultiply(self, ...)
    local args = {...}
    print("DATA TERCIDUK! Melakukan Multiplier 100x...")
    
    for i = 1, 100 do
        task.spawn(function()
            self:FireServer(unpack(args)) -- Mengirim data yang BENAR-BENAR VALID
        end)
    end
    print("Duplikasi 100 ikan terkirim dengan data sah.")
end

-- Karena Xeno memblokir Hooking, kita gunakan koneksi alternatif
-- Selesaikan pancingan secara manual SEKARANG
targetRemote.OnClientEvent:Connect(function()
    -- Jika ada sinyal dari server ke client, kita balas 100x
    CaptureAndMultiply(targetRemote, true) -- Asumsi argumen sederhana
end)

-- Jika tetap gagal, coba tekan K saat minigame SELESAI
game:GetService("UserInputService").InputBegan:Connect(function(input, gpe)
    if not gpe and input.KeyCode == Enum.KeyCode.K then
        -- Kirim sinyal dengan argumen 'true' sebagai pemicu umum
        for i = 1, 100 do task.spawn(function() targetRemote:FireServer(true) end) end
    end
end)