-- [[ TOMATO HUB V20 - OMNI TELEPORT PORTAL ]]
local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()

local Window = Rayfield:CreateWindow({
   Name = "Tomato Hub 🍅 | V20 TELEPORT",
   LoadingTitle = "OMNIPOTENCE FINAL EDITION",
   LoadingSubtitle = "by Tomato Team",
   ConfigurationSaving = { Enabled = true, FolderName = "TomatoHub" },
   KeySystem = false
})

-- [[ BIẾN HỆ THỐNG ]]
_G.AutoFarm = false
_G.FastAttack = true
_G.BringMob = true
_G.Distance = 5 -- Khoảng cách đứng trên đầu quái

-- [[ TAB FARM LEVEL ]]
local TabFarm = Window:CreateTab("🚜 Farm Level", 4483362458)
TabFarm:CreateToggle({
   Name = "Auto Farm Level (Teleport + Attack)",
   CurrentValue = false,
   Callback = function(v) _G.AutoFarm = v end,
})

TabFarm:CreateSlider({
   Name = "Khoảng cách đứng farm",
   Range = {0, 20},
   Increment = 1,
   CurrentValue = 5,
   Callback = function(v) _G.Distance = v end,
})

-- [[ HÀM TÌM QUÁI GẦN NHẤT ]]
function GetEnemy()
    for _, v in pairs(game.Workspace.Enemies:GetChildren()) do
        if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and v:FindFirstChild("HumanoidRootPart") then
            return v
        end
    end
    -- Nếu không thấy quái trong Enemies, tìm trong toàn bộ Workspace (trường hợp quái chưa vào folder)
    for _, v in pairs(game.Workspace:GetChildren()) do
        if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Head") then
             return v
        end
    end
    return nil
end

-- [[ LOGIC DỊCH CHUYỂN VÀ ĐÁNH ]]
spawn(function()
    while wait() do
        if _G.AutoFarm then
            pcall(function()
                local Enemy = GetEnemy()
                if Enemy then
                    -- 1. Tự động cầm vũ khí
                    local tool = game.Players.LocalPlayer.Backpack:FindFirstChildOfClass("Tool") or game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")
                    if tool then game.Players.LocalPlayer.Character.Humanoid:EquipTool(tool) end

                    -- 2. Dịch chuyển lại gần quái (Cách đầu quái một khoảng _G.Distance)
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Enemy.HumanoidRootPart.CFrame * CFrame.new(0, _G.Distance, 0) * CFrame.Angles(math.rad(-90), 0, 0)
                    
                    -- 3. Gom quái (Nếu bật)
                    if _G.BringMob then
                        Enemy.HumanoidRootPart.CanCollide = false
                        Enemy.HumanoidRootPart.Size = Vector3.new(60, 60, 60) -- Phóng to hit box quái để dễ đánh
                    end

                    -- 4. Thực hiện tấn công
                    game:GetService("VirtualUser"):ClickButton1(Vector2.new(851, 158))
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Attack")
                end
            end)
        end
    end
end)

-- [[ CHỐNG BỊ KẸT (STUCK) ]]
spawn(function()
    while wait(1) do
        if _G.AutoFarm then
            if not game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then return end
            -- Vô hiệu hóa trọng lực nhẹ để không bị rơi khi teleport
            for _, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                if v:IsA("BasePart") then v.CanCollide = false end
            end
        end
    end
end)

-- Giữ lại các Tab cũ từ bản V19 (Race V4, Sea Events, PvP, v.v.)
-- [Bạn có thể copy các phần Tab cũ dán tiếp vào đây]

Rayfield:Notify({
   Title = "Tomato Hub V20",
   Content = "Đã kích hoạt chế độ Auto Teleport Farm!",
   Duration = 5,
})
