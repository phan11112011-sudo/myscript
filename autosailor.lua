local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("SAILOR PIECE SUPER VIP - phan11112011", "BloodTheme")

-- TỰ ĐỘNG CHỐNG KICK KHI TREO MÁY
local vu = game:GetService("VirtualUser")
game:GetService("Players").LocalPlayer.Idled:Connect(function()
    vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
    wait(1)
    vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
end)

-- TAB CHÍNH
local Main = Window:NewTab("Auto Farm VIP")
local MainSection = Main:NewSection("Cày Cấp & Đồ")

_G.AutoFarm = false
_G.AutoClick = false
_G.AutoItems = false
_G.AutoStats = false

MainSection:NewToggle("Siêu Auto Farm (Gom Quái)", "Gom quái lại một chỗ và tiêu diệt", function(state)
    _G.AutoFarm = state
end)

MainSection:NewToggle("Auto Click VIP", "Đánh cực nhanh", function(state)
    _G.AutoClick = state
end)

MainSection:NewToggle("Auto Nhặt Đồ & Rương", "Hút vật phẩm và rương toàn bản đồ", function(state)
    _G.AutoItems = state
end)

-- TAB NHÂN VẬT
local StatsTab = Window:NewTab("Stats")
local StatsSection = StatsTab:NewSection("Tự Động Cộng Điểm")

StatsSection:NewToggle("Auto Stats (Melee)", "Tự cộng điểm vào Sức mạnh", function(state)
    _G.AutoStats = state
end)

-- LOGIC AUTO FARM VIP
spawn(function()
    while wait() do
        if _G.AutoFarm then
            pcall(function()
                local folder = workspace:FindFirstChild("NPCs") or workspace:FindFirstChild("Enemies")
                for _, v in pairs(folder:GetChildren()) do
                    if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and v:FindFirstChild("HumanoidRootPart") then
                        repeat
                            if not _G.AutoFarm then break end
                            -- Vị trí bay an toàn
                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 8, 0) * CFrame.Angles(math.rad(-90), 0, 0)
                            wait()
                        until v.Humanoid.Health <= 0
                    end
                end
            end)
        end
    end
end)

-- LOGIC CLICK & NHẶT ĐỒ
spawn(function()
    while wait() do
        if _G.AutoClick then
            vu:CaptureController()
            vu:ClickButton1(Vector2.new(0,0))
        end
        if _G.AutoItems then
            for _, v in pairs(workspace:GetChildren()) do
                if v:IsA("Tool") or (v:IsA("BasePart") and v.Name:find("Chest")) then
                    v.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                end
            end
        end
    end
end)

-- LOGIC AUTO STATS
spawn(function()
    while wait(1) do
        if _G.AutoStats then
            -- Tùy chỉnh tên Remote cộng điểm của game bạn
            local args = { [1] = "Melee", [2] = 1 }
            game:GetService("ReplicatedStorage"):FindFirstChild("StatsEvent", true):FireServer(unpack(args))
        end
    end
end)
