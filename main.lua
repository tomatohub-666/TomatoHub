-- [[ TOMATO HUB V20 - FIX CHUẨN 100% ]]
local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/SiriusSoftware-External/Rayfield/main/source'))()

local Window = Rayfield:CreateWindow({
   Name = "Tomato Hub 🍅 | V20 FINAL",
   LoadingTitle = "Đang tải hệ thống...",
   LoadingSubtitle = "by Tomato Team",
   ConfigurationSaving = { Enabled = false },
   KeySystem = false
})

-- [[ BIẾN HỆ THỐNG ]]
_G.AutoFarm = false
_G.FastAttack = true
_G.Distance = 7

-- [[ TAB FARM ]]
local Tab = Window:CreateTab("🏠 Main Farm", 4483362458)

Tab:CreateToggle({
   Name = "Auto Farm Level (Teleport)",
   CurrentValue = false,
   Callback = function(v) _G.AutoFarm = v end,
})

Tab:CreateSlider({
   Name = "Khoảng cách đứng farm",
   Range = {0, 20},
   Increment = 1,
   CurrentValue = 7,
   Callback = function(v) _G.Distance = v end,
})

-- [[ LOGIC FARM ]]
spawn(function()
    while wait() do
        if _G.AutoFarm then
            pcall(function()
                local Enemy = nil
                for _, v in pairs(game.Workspace.Enemies:GetChildren()) do
                    if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                        Enemy = v break
                    end
                end
                
                if Enemy then
                    -- Tự cầm vũ khí
                    local tool = game.Players.LocalPlayer.Backpack:FindFirstChildOfClass("Tool") or game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")
                    if tool then game.Players.LocalPlayer.Character.Humanoid:EquipTool(tool) end
                    
                    -- Teleport sát quái
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Enemy.HumanoidRootPart.CFrame * CFrame.new(0, _G.Distance, 0) * CFrame.Angles(math.rad(-90), 0, 0)
                    
                    -- Đánh
                    game:GetService("VirtualUser"):ClickButton1(Vector2.new(851, 158))
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Attack")
                end
            end)
        end
    end
end)

Rayfield:Notify({Title = "Tomato Hub", Content = "Script đã sẵn sàng!", Duration = 5})
