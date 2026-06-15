local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Camera = workspace.CurrentCamera
local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

if PlayerGui:FindFirstChild("BananaMenuGui") then
    PlayerGui.BananaMenuGui:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BananaMenuGui"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = PlayerGui

local Banana = Instance.new("ImageLabel")
Banana.Name = "Banana"
Banana.Size = UDim2.new(0, 100, 0, 100)
Banana.Position = UDim2.new(0.3, 0, 0.3, 0)
Banana.BackgroundTransparency = 1
Banana.Image = "rbxassetid://12591498191"
Banana.Parent = ScreenGui

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 220, 0, 180)
MainFrame.Position = UDim2.new(0.05, 0, 0.3, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 8)
Corner.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(1, 0, 0, 35)
Title.BackgroundTransparency = 1
Title.Text = "Banana Control Panel"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 16
Title.Font = Enum.Font.SourceSansBold
Title.Parent = MainFrame

local SpeedLabel = Instance.new("TextLabel")
SpeedLabel.Size = UDim2.new(1, 0, 0, 25)
SpeedLabel.Position = UDim2.new(0, 0, 0, 40)
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.Text = "Speed: 5"
SpeedLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
SpeedLabel.TextSize = 14
SpeedLabel.Font = Enum.Font.SourceSans
SpeedLabel.Parent = MainFrame

local SpeedPlus = Instance.new("TextButton")
SpeedPlus.Size = UDim2.new(0, 80, 0, 30)
SpeedPlus.Position = UDim2.new(0.55, 0, 0, 70)
SpeedPlus.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
SpeedPlus.Text = "+ Increase"
SpeedPlus.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedPlus.Font = Enum.Font.SourceSansBold
SpeedPlus.TextSize = 14
SpeedPlus.Parent = MainFrame
Instance.new("UICorner", SpeedPlus).CornerRadius = UDim.new(0, 5)

local SpeedMinus = Instance.new("TextButton")
SpeedMinus.Size = UDim2.new(0, 80, 0, 30)
SpeedMinus.Position = UDim2.new(0.08, 0, 0, 70)
SpeedMinus.BackgroundColor3 = Color3.fromRGB(150, 50, 50)
SpeedMinus.Text = "- Decrease"
SpeedMinus.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedMinus.Font = Enum.Font.SourceSansBold
SpeedMinus.TextSize = 14
SpeedMinus.Parent = MainFrame
Instance.new("UICorner", SpeedMinus).CornerRadius = UDim.new(0, 5)

local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Size = UDim2.new(0, 180, 0, 35)
ToggleBtn.Position = UDim2.new(0.1, 0, 0, 120)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
ToggleBtn.Text = "Hide Banana"
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.Font = Enum.Font.SourceSansBold
ToggleBtn.TextSize = 14
ToggleBtn.Parent = MainFrame
Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(0, 5)

local moveSpeed = 5
local rotationSpeed = 2
local speedX = moveSpeed
local speedY = moveSpeed
local isVisible = true

SpeedPlus.MouseButton1Click:Connect(function()
    moveSpeed = math.min(moveSpeed + 1, 20)
    SpeedLabel.Text = "Speed: " .. tostring(moveSpeed)
    speedX = (speedX > 0 and moveSpeed) or -moveSpeed
    speedY = (speedY > 0 and moveSpeed) or -moveSpeed
end)

SpeedMinus.MouseButton1Click:Connect(function()
    moveSpeed = math.max(moveSpeed - 1, 1)
    SpeedLabel.Text = "Speed: " .. tostring(moveSpeed)
    speedX = (speedX > 0 and moveSpeed) or -moveSpeed
    speedY = (speedY > 0 and moveSpeed) or -moveSpeed
end)

ToggleBtn.MouseButton1Click:Connect(function()
    isVisible = not isVisible
    Banana.Visible = isVisible
    ToggleBtn.Text = isVisible and "Hide Banana" or "Show Banana"
end)

RunService.RenderStepped:Connect(function()
    if not Banana or not Banana.Parent then return end
    if not isVisible then return end
    
    local screenSize = Camera.ViewportSize
    local maxX = screenSize.X - Banana.AbsoluteSize.X
    local maxY = screenSize.Y - Banana.AbsoluteSize.Y
    
    local currentX = Banana.AbsolutePosition.X
    local currentY = Banana.AbsolutePosition.Y
    
    local nextX = currentX + speedX
    local nextY = currentY + speedY
    
    if nextX <= 0 then
        nextX = 0
        speedX = -speedX
    elseif nextX >= maxX then
        nextX = maxX
        speedX = -speedX
    end
    
    if nextY <= 0 then
        nextY = 0
        speedY = -speedY
    elseif nextY >= maxY then
        nextY = maxY
        speedY = -speedY
    end
    
    Banana.Position = UDim2.new(0, nextX, 0, nextY)
    Banana.Rotation = Banana.Rotation + rotationSpeed
end)
