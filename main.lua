-- [[ TOMATO HUB - V12 INFINITY: AUTO TRIAL & FULL AZURE ]]
local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()

local Window = Rayfield:CreateWindow({
   Name = "Tomato Hub 🍅 | Azure V12 [FINAL]",
   LoadingTitle = "Infinity Overlord Edition",
   LoadingSubtitle = "by Tomato Team",
   ConfigurationSaving = { Enabled = true, FolderName = "TomatoHub", FileName = "Config" },
   KeySystem = false
})

-- [[ BẢNG TRẠNG THÁI ]]
local StatsTab = Window:CreateTab("📊 Status", 4483362458)
local LevelLabel = StatsTab:CreateParagraph({Title = "Level:", Content = "..."})
local RaceLabel = StatsTab:CreateParagraph({Title = "Race:", Content = tostring(game.Players.LocalPlayer.Data.Race.Value)})

spawn(function()
    while wait(1) do
        pcall(function()
            LevelLabel:Set({Title = "Level:", Content = tostring(game.Players.LocalPlayer.Data.Level.Value)})
        end)
    end
end)

-- [[ TAB TRIAL V4 (MỚI) ]]
local TrialTab = Window:CreateTab("🌟 Auto Trial", 4483345998)
TrialTab:CreateSection("Thử Thách Tộc V4")

_G.AutoTrial = false
TrialTab:CreateToggle({
   Name = "Auto Finish Trial (Hoàn thành thử thách)",
   CurrentValue = false,
   Callback = function(Value) _G.AutoTrial = Value end,
})

TrialTab:CreateButton({
   Name = "Teleport to Temple of Time",
   Callback = function()
       game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(28282, 14891, 102)
   end,
})

_G.AutoAncient = false
TrialTab:CreateToggle({
   Name = "Auto Click Ancient Clock",
   CurrentValue = false,
   Callback = function(Value) _G.AutoAncient = Value end,
})

-- [[ TAB CHIẾN ĐẤU & PVP ]]
local CombatTab = Window:CreateTab("⚔️ Combat", 4483345998)
_G.AutoBounty = false
CombatTab:CreateToggle({
   Name = "Auto Bounty (Săn Người)",
   CurrentValue = false,
   Callback = function(Value) _G.AutoBounty = Value end,
})

_G.FastAttack = false
CombatTab:CreateToggle({
   Name = "Fast Attack X100",
   CurrentValue = false,
   Callback = function(Value) _G.FastAttack = Value end,
})

-- [[ TAB FARM CHÍNH ]]
local MainTab = Window:CreateTab("🏠 Main Farm", 4483362458)
_G.AutoFarm = false
MainTab:CreateToggle({
   Name = "Auto Farm Level",
   CurrentValue = false,
   Callback = function(Value) _G.AutoFarm = Value end,
})

_G.BringMob = false
MainTab:CreateToggle({
   Name = "Bring Mob (Gom Quái)",
   CurrentValue = false,
   Callback = function(Value) _G.BringMob = Value end,
})

-- [[ LOGIC HỆ THỐNG V12 ]]

-- 1. Logic Auto Trial (Giết quái nhanh trong phòng Trial)
spawn(function()
    while wait() do
        if _G.AutoTrial then
            pcall(function()
                for _, v in pairs(game.Workspace.Enemies:GetChildren()) do
                    if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 0, 5)
                        game:GetService("VirtualUser"):ClickButton1(Vector2.new(851, 158))
                    end
                end
            end)
        end
    end
end)

-- 2. Logic Auto Bounty (Săn Người)
spawn(function()
    while wait() do
        if _G.AutoBounty then
            pcall(function()
                for _, v in pairs(game.Players:GetPlayers()) do
                    if v ~= game.Players.LocalPlayer and v.Character and v.Character.Humanoid.Health > 0 then
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3)
                        game:GetService("VirtualUser"):ClickButton1(Vector2.new(851, 158))
                    end
                end
            end)
        end
    end
end)

-- 3. Đánh Nhanh Tối Thượng
spawn(function()
    while wait() do
        if _G.AutoFarm or _G.FastAttack then
            pcall(function()
                game:GetService("VirtualUser"):ClickButton1(Vector2.new(851, 158))
                if _G.FastAttack then wait(0.0000000001) end
            end)
        end
    end
end)

-- 4. Auto Click Đồng Hồ Cổ (Ancient Clock)
spawn(function()
    while wait(0.5) do
        if _G.AutoAncient then
            fireclickdetector(game:GetService("Workspace").Map["Temple of Time"].AncientClock.ClickDetector)
        end
    end
end)

Rayfield:Notify({
   Title = "Tomato Hub V12 FINAL",
   Content = "Hệ thống Trial V4 & Auto Bounty đã sẵn sàng!",
   Duration = 6.5,
   Image = 4483345998,
})
