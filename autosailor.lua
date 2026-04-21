_G.AutoFarm = true

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

-- Hàm tìm Folder chứa quái một cách thông minh
local function getEnemyFolder()
    local names = {"Enemies", "NPCs", "Monsters", "Mob"}
    for _, name in pairs(names) do
        local folder = game.Workspace:FindFirstChild(name)
        if folder then return folder end
    end
    return nil
end

local enemyFolder = getEnemyFolder()

-- Thông báo lỗi ra Console nếu vẫn không thấy quái
if not enemyFolder then
    warn("Không tìm thấy thư mục quái! Hãy kiểm tra lại tên thư mục trong Workspace.")
else
    print("Đã tìm thấy thư mục quái: " .. enemyFolder.Name)
end

spawn(function()
    while _G.AutoFarm and enemyFolder do
        for _, v in pairs(enemyFolder:GetChildren()) do
            if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                repeat
                    if not _G.AutoFarm then break end
                    -- Bay lên đầu quái
                    character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 7, 0)
                    
                    -- Click đánh
                    game:GetService("VirtualUser"):CaptureController()
                    game:GetService("VirtualUser"):ClickButton1(Vector2.new(0,0))
                    wait()
                until v.Humanoid.Health <= 0
            end
        end
        wait(1)
    end
end)
