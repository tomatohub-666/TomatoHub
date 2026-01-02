-- [[ TOMATO HUB - LOADER CHUẨN ]]
repeat wait() until game:IsLoaded()

-- Xóa bảng thông báo cũ nếu có
local function Notify(text)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Tomato Hub 🍅",
        Text = text,
        Duration = 5
    })
end

Notify("Đang kiểm tra phiên bản...")

-- Link dẫn tới file main.lua của bạn (Đã thêm lệnh phá cache)
local url = "https://raw.githubusercontent.com/tomatohub-666/TomatoHubb/main/main.lua?v="..os.time()))()

local success, result = pcall(function()
    return game:HttpGet(url)
end)

if success then
    Notify("Tải thành công! Chúc bạn chơi vui vẻ.")
    loadstring(result)()
else
    Notify("Lỗi kết nối GitHub! Thử lại sau.")
    warn("Lỗi tải script: " .. result)
end
