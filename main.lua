-- [[ TOMATO HUB - V16 ZENITH LOG EDITION ]]
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Tomato Hub 🍅 | V16 ZENITH [LOG]",
   LoadingTitle = "Infinity Overlord Edition",
   LoadingSubtitle = "by Tomato Team",
   ConfigurationSaving = { Enabled = true, FolderName = "TomatoHub", FileName = "Config" },
   KeySystem = false
})

-- [[ TAB 1: STATUS & LOG ]]
local TabStatus = Window:CreateTab("📊 Status & Log", 4483362458)
TabStatus:CreateSection("Thông Số Nhân Vật")

local LvlInfo = TabStatus:CreateParagraph({Title = "Level:", Content = "Đang tính..."})
local MoneyInfo = TabStatus:CreateParagraph({Title = "Beli:", Content = "Đang tính..."})

TabStatus:CreateSection("Nhật Ký Hệ Thống (Log)")
local SystemLog = TabStatus:CreateParagraph({Title = "Thông Báo:", Content = "Chưa có hoạt động nào..."})

-- Hàm cập nhật Log
local function UpdateLog(msg)
    local time = os.date("%H:%M:%S")
    SystemLog:Set({Title = "Thông Báo ["..time.."]:", Content = msg})
end

spawn(function()
    while wait(1) do
        pcall(function()
            LvlInfo:Set({Title = "Level:", Content = tostring(game.Players.LocalPlayer.Data.Level.Value)})
            MoneyInfo:Set({Title = "Beli:", Content = tostring(game.Players.LocalPlayer.Data.Beli.Value)})
        end)
    end
end)

-- [[ TAB 2: MAIN FARM ]]
local TabMain = Window:CreateTab("🏠 Main", 4483362458)
_G.AutoFarm = false
TabMain:CreateToggle({
   Name = "Auto Farm Level",
   CurrentValue = false,
   Callback = function(Value) 
       _G.AutoFarm = Value 
       UpdateLog(Value and "Đã bật Auto Farm" or "Đã tắt Auto Farm")
   end,
})

_G.FastAttack = false
TabMain:CreateToggle({
   Name = "Fast Attack (Siêu Tốc)",
   CurrentValue = false,
   Callback = function(Value) _G.FastAttack = Value end,
})

-- [[ TAB 3: EVENT & AUTO BUY ]]
local TabEvent = Window:CreateTab("🎁 Event/Shop", 4483362458)
_G.AutoBuy = false
TabEvent:CreateToggle({
   Name = "Auto Mua Trái Mới (Kitsune/Gas/Event)",
   CurrentValue = false,
   Callback = function(Value) 
       _G.AutoBuy = Value 
       UpdateLog(Value and "Đang canh mua Trái Ác Quỷ xịn..." or "Đã tắt Auto Buy")
   end,
})

-- [[ TAB 4: RACE V4 & TRIAL ]]
local TabV4 = Window:CreateTab("🌟 Race V4", 4483345998)
_G.AutoMirage = false
TabV4:CreateToggle({
   Name = "Auto Tìm Đảo Bí Ẩn",
   CurrentValue = false,
   Callback = function(Value) _G.AutoMirage = Value end,
})

-- [[ LOGIC HỆ THỐNG ]]

-- Logic Mua Trái & Thông Báo
spawn(function()
    while wait(2) do
        if _G.AutoBuy then
            local fruits = {"Kitsune-Kitsune", "Gas-Gas", "Leopard-Leopard"}
            for _, name in pairs(fruits) do
                local success = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyFruit", name)
                if success then
                    UpdateLog("⭐ ĐÃ MUA THÀNH CÔNG: " .. name .. "!")
                    Rayfield:Notify({Title = "MUA THÀNH CÔNG", Content = "Bạn vừa sở hữu trái "..name, Duration = 10})
                end
            end
        end
    end
end)

-- Logic Tìm Đảo Mirage
spawn(function()
    while wait(1) do
        if _G.AutoMirage then
            local M = game:GetService("Workspace").Map:FindFirstChild("Mirage Island")
            if M then
                UpdateLog("🚩 PHÁT HIỆN ĐẢO BÍ ẨN! Đang dịch chuyển...")
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = M:GetModelCFrame()
            end
        end
    end
end)

-- Logic Đánh Nhanh
spawn(function()
    while wait() do
        if _G.FastAttack or _G.AutoFarm then
            pcall(function()
                game:GetService("VirtualUser"):ClickButton1(Vector2.new(851, 158))
                if _G.FastAttack then wait(0.0001) end
            end)
        end
    end
end)

UpdateLog("Tomato Hub đã khởi động thành công!")
