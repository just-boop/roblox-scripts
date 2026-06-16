local player = game:GetService("Players").LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

if playerGui:FindFirstChild("GG2_FixedMenu") then
    playerGui.GG2_FixedMenu:Destroy()
end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "GG2_FixedMenu"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

local keyFrame = Instance.new("Frame")
keyFrame.Size = UDim2.new(0, 270, 0, 160)
keyFrame.Position = UDim2.new(0.5, -135, 0.4, -80)
keyFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
keyFrame.BorderSizePixel = 0
keyFrame.Active = true
keyFrame.Draggable = true
keyFrame.Parent = screenGui

local keyCorner = Instance.new("UICorner")
keyCorner.CornerRadius = UDim.new(0, 10)
keyCorner.Parent = keyFrame

local keyTitle = Instance.new("TextLabel")
keyTitle.Size = UDim2.new(1, 0, 0, 35)
keyTitle.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
keyTitle.Text = "🔑 ENTER KEY"
keyTitle.TextColor3 = Color3.fromRGB(255, 165, 0)
keyTitle.TextSize = 14
keyTitle.Font = Enum.Font.SourceSansBold
keyTitle.Parent = keyFrame

local keyTextBox = Instance.new("TextBox")
keyTextBox.Size = UDim2.new(0, 230, 0, 35)
keyTextBox.Position = UDim2.new(0.5, -115, 0.35, 0)
keyTextBox.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
keyTextBox.Text = ""
keyTextBox.PlaceholderText = "Введите секретный ключ..."
keyTextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
keyTextBox.TextSize = 14
keyTextBox.Parent = keyFrame

local checkKeyButton = Instance.new("TextButton")
checkKeyButton.Size = UDim2.new(0, 130, 0, 35)
checkKeyButton.Position = UDim2.new(0.5, -65, 0.65, 0)
checkKeyButton.BackgroundColor3 = Color3.fromRGB(41, 128, 185)
checkKeyButton.Text = "Проверить"
checkKeyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
checkKeyButton.TextSize = 14
checkKeyButton.Font = Enum.Font.SourceSansBold
checkKeyButton.Parent = keyFrame

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 300, 0, 220)
mainFrame.Position = UDim2.new(0.5, -150, 0.4, -110)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Visible = false
mainFrame.Parent = screenGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 12)
mainCorner.Parent = mainFrame

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, 0, 0, 40)
titleLabel.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
titleLabel.Text = "Grow a Garden 2 VIP"
titleLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
titleLabel.TextSize = 16
titleLabel.Font = Enum.Font.SourceSansBold
titleLabel.Parent = mainFrame

local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 25, 0, 25)
closeButton.Position = UDim2.new(1, -30, 0, 7)
closeButton.BackgroundColor3 = Color3.fromRGB(231, 76, 60)
closeButton.Text = "X"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.Parent = mainFrame

closeButton.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

local getSeedsButton = Instance.new("TextButton")
getSeedsButton.Size = UDim2.new(0, 240, 0, 40)
getSeedsButton.Position = UDim2.new(0.5, -120, 0.25, 0)
getSeedsButton.BackgroundColor3 = Color3.fromRGB(46, 204, 113)
getSeedsButton.Text = "🌱 Выдать 99k Семян"
getSeedsButton.TextColor3 = Color3.fromRGB(255, 255, 255)
getSeedsButton.TextSize = 14
getSeedsButton.Font = Enum.Font.SourceSansBold
getSeedsButton.Parent = mainFrame

local getPetsButton = Instance.new("TextButton")
getPetsButton.Size = UDim2.new(0, 240, 0, 40)
getPetsButton.Position = UDim2.new(0.5, -120, 0.5, 0)
getPetsButton.BackgroundColor3 = Color3.fromRGB(155, 89, 182)
getPetsButton.Text = "🦝 Выдать Худж Енота"
getPetsButton.TextColor3 = Color3.fromRGB(255, 255, 255)
getPetsButton.TextSize = 14
getPetsButton.Font = Enum.Font.SourceSansBold
getPetsButton.Parent = mainFrame

local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(1, 0, 0, 25)
statusLabel.Position = UDim2.new(0, 0, 0.8, 0)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = "Готов к активации..."
statusLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
statusLabel.TextSize = 12
statusLabel.Parent = mainFrame

checkKeyButton.MouseButton1Click:Connect(function()
    if keyTextBox.Text == "BOBIKBOBIK" then
        keyFrame.Visible = false
        mainFrame.Visible = true
    else
        keyTextBox.Text = ""
        keyTextBox.PlaceholderText = "НЕВЕРНЫЙ КЛЮЧ!"
    end
end)

getSeedsButton.MouseButton1Click:Connect(function()
    statusLabel.Text = "Взлом семян..."
    task.wait(0.5)
    
    pcall(function()
        local leaderstats = player:FindFirstChild("leaderstats")
        if leaderstats then
            for _, v in pairs(leaderstats:GetChildren()) do
                if v:IsA("IntValue") or v:IsA("NumberValue") then v.Value = 99999 end
            end
        end
    end)
    
    statusLabel.TextColor3 = Color3.fromRGB(46, 204, 113)
    statusLabel.Text = "99,999 семян успешно начислено!"
    getSeedsButton.Text = "🌱 УСПЕШНО ВЫДАНЫ"
end)

getPetsButton.MouseButton1Click:Connect(function()
    statusLabel.Text = "Спавн Худж Енота..."
    task.wait(0.5)
    
    pcall(function()
        local char = player.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")
        if root then
            local p = Instance.new("Part")
            p.Size = Vector3.new(2.5, 2.5, 2.5)
            p.Position = root.Position + Vector3.new(-3, 1, -3)
            p.CanCollide = false
            p.Anchored = true
            p.Material = Enum.Material.Neon
            p.Parent = workspace
            
            local b = Instance.new("SelectionBox")
            b.Adornee = p
            b.Parent = p
            
            local g = Instance.new("BillboardGui")
            g.Size = UDim2.new(0, 140, 0, 40)
            g.AlwaysOnTop = true
            g.ExtentsOffset = Vector3.new(0, 2, 0)
            g.Parent = p
            
            local t = Instance.new("TextLabel")
            t.Size = UDim2.new(1, 0, 1, 0)
            t.BackgroundTransparency = 1
            t.Text = "🌈 Huge Rainbow Raccoon"
            t.TextSize = 12
            t.Font = Enum.Font.SourceSansBold
            t.Parent = g
            
            task.spawn(function()
                local c = 0
                while p and p.Parent and char and char.Parent do
                    local color = Color3.fromHSV(c, 1, 1)
                    p.Color = color
                    b.Color3 = color
                    t.TextColor3 = color
                    
                    local target = root.Position + root.CFrame.LookVector * -2.5 + root.CFrame.RightVector * -2
                    p.Position = p.Position:Lerp(Vector3.new(target.X, root.Position.Y, target.Z), 0.2)
                    p.CFrame = CFrame.new(p.Position, root.Position)
                    
                    c = c + 0.02
                    if c >= 1 then c = 0 end
                    task.wait(0.02)
                end
            end)
        end
    end)
    
    statusLabel.TextColor3 = Color3.fromRGB(46, 204, 113)
    statusLabel.Text = "Енот успешно следует за вами!"
    getPetsButton.Text = "🦝 ЕНОТ СТАРТОВАЛ"
end)
