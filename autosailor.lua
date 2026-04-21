local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Sailor Piece - Pro Farm Menu", "DarkTheme")

-- Tab Chính
local Main = Window:NewTab("Auto Farm")
local MainSection = Main:NewSection("Chức Năng Chính")

_G.AutoFarm = false
_G.AutoClick = false
_G.AutoItem = false

-- Bật/Tắt Farm
MainSection:NewToggle("Auto Farm Quái", "Tự động bay đến quái gần nhất", function(state)
    _G.AutoFarm = state
end)

-- Bật/Tắt Click
MainSection:NewToggle("Auto Click", "Tự động đánh", function(state)
    _G.AutoClick = state
end)

-- Bật/Tắt Nhặt Đồ
MainSection:NewToggle("Auto Nhặt Đồ (Items)", "Tự động hút vật phẩm", function(state)
    _G.AutoItem = state
end)

-- Logic Farm
spawn(function()
    while wait() do
        if _G.AutoFarm then
            pcall(function()
                local folder = workspace:FindFirstChild("NPCs") or workspace:FindFirstChild("Enemies")
                for _, v in pairs(folder:GetChildren()) do
                    if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and v:FindFirstChild("HumanoidRootPart") then
                        repeat
                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 8, 0) * CFrame.Angles(math.rad(-90), 0, 0)
                            wait()
                        until not _G.AutoFarm or v.Humanoid.Health <= 0
                    end
                end
            end)
        end
    end
end)

-- Logic Click
spawn(function()
    while wait() do
        if _G.AutoClick then
            game:GetService("VirtualUser"):CaptureController()
            game:GetService("VirtualUser"):ClickButton1(Vector2.new(0,0))
        end
    end
end)

-- Logic Nhặt Đồ
spawn(function()
    while wait(1) do
        if _G.AutoItem then
            for _, v in pairs(workspace:GetChildren()) do
                if v:IsA("Tool") or v:IsA("BasePart") and (v.Name:find("Fruit") or v.Name:find("Item")) then
                    v.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                end
            end
        end
    end
end)

print("MENU ĐÃ SẴN SÀNG - BẬT TOGGLE ĐỂ CHẠY!")
