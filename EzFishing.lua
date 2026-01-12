local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- KONFIGURASI MASSAL
local JUMLAH_IKAN = 100 -- Coba 100 dulu untuk tes
local NAMA_REMOTE = "CreateRewardInfoEvent" -- Berdasarkan screenshot log kamu

print("--- EZFISHING v11: DIRECT BOMBARDMENT ACTIVE ---")

-- 1. Cari Remote secara spesifik
local targetRemote = ReplicatedStorage:FindFirstChild(NAMA_REMOTE, true)

if not targetRemote then
    warn("Remote '" .. NAMA_REMOTE .. "' tidak ditemukan di ReplicatedStorage!")
    return
end

print("Target Terkunci: " .. targetRemote.Name)

-- 2. Fungsi Eksploitasi
local function GasPol()
    print("Mengirim " .. JUMLAH_IKAN .. " permintaan ikan sekaligus...")
    for i = 1, JUMLAH_IKAN do
        task.spawn(function()
            -- Kita kirim sinyal tanpa argumen rumit
            -- Banyak server hanya mengecek apakah sinyal ini datang
            targetRemote:FireServer() 
        end)
        
        -- Jeda sangat tipis agar tidak crash
        if i % 50 == 0 then task.wait(0.1) end
    end
    print("Selesai. Cek inventory kamu!")
end

-- 3. Cara Pakai
print("TEKAN TOMBOL 'K' UNTUK MENDAPATKAN " .. JUMLAH_IKAN .. " IKAN")

game:GetService("UserInputService").InputBegan:Connect(function(input, gpe)
    if not gpe and input.KeyCode == Enum.KeyCode.K then
        GasPol()
    end
end)