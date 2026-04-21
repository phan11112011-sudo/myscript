--[[ 
    SAILOR PIECE AUTO FARM - BASIC EDITION
    Hướng dẫn: Copy toàn bộ code này dán vào file trên GitHub của bạn
]]

_G.AutoFarm = true
_G.AutoStats = true -- Tự động cộng điểm vào Melee

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local root = character:WaitForChild("HumanoidRootPart")

-- Hàm cộng điểm tiềm năng tự động
spawn(function()
    while _G.AutoStats do
        wait(1)
        local args = { [1] = "Melee", [2] = 1 }
        game:GetService("ReplicatedStorage").Events.StatsEvent:FireServer(unpack(args))
    end
end)

-- Hàm tìm quái gần nhất
local function getClosestMonster()
    local target = nil
    local dist = math.huge
    for _, v in pairs(game.Workspace.Enemies:GetChildren()) do
        if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
            local magnitude = (v.HumanoidRootPart.Position - root.Position).magnitude
            if magnitude < dist then
                target = v
                dist = magnitude
            end
        end
    end
    return target
end

-- Vòng lặp Farm chính
spawn(function()
    while _G.AutoFarm do
        local monster = getClosestMonster()
        if monster then
            -- Di chuyển đến quái (giữ khoảng cách an toàn phía trên)
            root.CFrame = monster.HumanoidRootPart.CFrame * CFrame.new(0, 7, 0) * CFrame.Angles(math.rad(-90), 0, 0)
            
            -- Tự động đánh
            game:GetService("VirtualUser"):CaptureController()
            game:GetService("VirtualUser"):ClickButton1(Vector2.new(0,0))
            
            -- Dùng kỹ năng nếu có (Ví dụ phím Z, X)
            game:GetService("VirtualInputManager"):SendKeyEvent(true, "Z", false, game)
            wait(0.1)
            game:GetService("VirtualInputManager"):SendKeyEvent(false, "Z", false, game)
        end
        wait()
    end
end)

print("Script đã kích hoạt! Chúc bạn farm vui vẻ.")
