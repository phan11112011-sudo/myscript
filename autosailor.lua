_G.AutoFarm = true
_G.AutoStats = true

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local root = character:WaitForChild("HumanoidRootPart")

-- Hàm tìm thư mục chứa quái (Sửa lỗi "Enemies is not a valid member")
local enemyFolder = game.Workspace:FindFirstChild("Enemies") or game.Workspace:FindFirstChild("NPCs") or game.Workspace:FindFirstChild("Monsters") or game.Workspace

-- Hàm cộng điểm (Bỏ qua nếu lỗi thư mục Events)
spawn(function()
    while _G.AutoStats do
        pcall(function()
            local remote = game:GetService("ReplicatedStorage"):FindFirstChild("StatsEvent", true)
            if remote then
                remote:FireServer("Melee", 1)
            end
        end)
        wait(1)
    end
end)

-- Hàm tìm quái gần nhất
local function getClosestMonster()
    local target = nil
    local dist = math.huge
    for _, v in pairs(enemyFolder:GetChildren()) do
        if v:IsA("Model") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
            local magnitude = (v.HumanoidRootPart.Position - root.Position).magnitude
            if magnitude < dist then
                target = v
                dist = magnitude
            end
        end
    end
    return target
end

spawn(function()
    while _G.AutoFarm do
        local monster = getClosestMonster()
        if monster then
            -- Bay lên đầu quái để né đòn
            root.CFrame = monster.HumanoidRootPart.CFrame * CFrame.new(0, 7, 0) * CFrame.Angles(math.rad(-90), 0, 0)
            
            -- Đánh
            game:GetService("VirtualUser"):CaptureController()
            game:GetService("VirtualUser"):ClickButton1(Vector2.new(0,0))
        end
        wait()
    end
end)

print("Script đã sửa lỗi! Đang tìm quái...")
