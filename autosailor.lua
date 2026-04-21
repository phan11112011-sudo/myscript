_G.AutoFarm = true

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

spawn(function()
    while _G.AutoFarm do
        local folder = workspace:FindFirstChild("NPCs") or workspace:FindFirstChild("Enemies")
        if folder then
            for _, monster in pairs(folder:GetChildren()) do
                if not _G.AutoFarm then break end
                
                -- Kiểm tra quái có sống và có bộ phận để bay tới không
                local humanoid = monster:FindFirstChildOfClass("Humanoid")
                local root = monster:FindFirstChild("HumanoidRootPart")
                
                if humanoid and root and humanoid.Health > 0 then
                    -- Đánh con quái này cho đến khi nó chết hẳn
                    while _G.AutoFarm and humanoid.Health > 0 and monster.Parent do
                        pcall(function()
                            character.HumanoidRootPart.CFrame = root.CFrame * CFrame.new(0, 8, 0) * CFrame.Angles(math.rad(-90), 0, 0)
                            game:GetService("VirtualUser"):CaptureController()
                            game:GetService("VirtualUser"):ClickButton1(Vector2.new(0,0))
                        end)
                        task.wait()
                    end
                end
            end
        end
        task.wait(1)
    end
end)

print("--- SAILOR PIECE AUTO V4: ĐÃ KÍCH HOẠT ---")
