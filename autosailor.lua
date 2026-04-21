_G.AutoFarm = true

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

-- Tìm thư mục quái
local enemyFolder = game.Workspace:FindFirstChild("NPCs") or game.Workspace:FindFirstChild("Enemies")

spawn(function()
    while _G.AutoFarm do
        if enemyFolder then
            for _, v in pairs(enemyFolder:GetChildren()) do
                -- Kiểm tra quái có đủ bộ phận và còn sống không
                if v:IsA("Model") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and v:FindFirstChild("HumanoidRootPart") then
                    repeat
                        if not _G.AutoFarm then break end
                        
                        -- Bay lên đầu quái (Dùng pcall để né mọi lỗi vặt)
                        pcall(function()
                            character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 8, 0) * CFrame.Angles(math.rad(-90), 0, 0)
                        end)
                        
                        -- Click đánh
                        game:GetService("VirtualUser"):CaptureController()
                        game:GetService("VirtualUser"):ClickButton1(Vector2.new(0,0))
                        wait()
                    until not v:Parent or v.Humanoid.Health <= 0
                end
            end
        end
        wait(1)
    end
end)

print("Script v3 đã chạy! Đang bắt đầu farm...")
