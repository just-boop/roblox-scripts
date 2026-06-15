if game:GetService("CoreGui"):FindFirstChild("DeltaFlyingCatGui") then
    game:GetService("CoreGui").DeltaFlyingCatGui:Destroy()
end

local Players = game:Service("Players")
local TweenService = game:Service("TweenService")
local UserInputService = game:Service("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "DeltaFlyingCatGui"
ScreenGui.ResetOnSpawn = false

if syn and syn.protect_gui then
    syn.protect_gui(ScreenGui)
end
ScreenGui.Parent = game:GetService("CoreGui")

local CatImage = Instance.new("ImageLabel")
CatImage.Name = "Cat"
CatImage.Image = "rbxassetid://13545167660" 
CatImage.BackgroundTransparency = 1 
CatImage.Size = UDim2.new(0, 80, 0, 80) 
CatImage.AnchorPoint = Vector2.new(0.5, 0.5)
CatImage.Position = UDim2.new(0.5, 0, 0.5, 0)
CatImage.ZIndex = 2
CatImage.Parent = ScreenGui

local MenuFrame = Instance.new("Frame")
MenuFrame.Name = "Menu"
MenuFrame.Size = UDim2.new(0, 200, 0, 150)
MenuFrame.Position = UDim2.new(0, 20, 0, 20)
MenuFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MenuFrame.BorderSizePixel = 0
MenuFrame.Visible = true
MenuFrame.Active = true
MenuFrame.Draggable = true
MenuFrame.Parent = ScreenGui

local MenuCorner = Instance.new("UICorner")
MenuCorner.CornerRadius = UDim.new(0, 8)
MenuCorner.Parent = MenuFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 30)
Title.BackgroundTransparency = 1
Title.Text = "Cat Settings"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 16
Title.Font = Enum.Font.SourceSansBold
Title.Parent = MenuFrame

local SpeedLabel = Instance.new("TextLabel")
SpeedLabel.Size = UDim2.new(1, 0, 0, 20)
SpeedLabel.Position = UDim2.new(0, 0, 0, 35)
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
SpeedLabel.TextSize = 14
SpeedLabel.Font = Enum.Font.SourceSans
SpeedLabel.Parent = MenuFrame

local SizeLabel = Instance.new("TextLabel")
SizeLabel.Size = UDim2.new(1, 0, 0, 20)
SizeLabel.Position = UDim2.new(0, 0, 0, 85)
SizeLabel.BackgroundTransparency = 1
SizeLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
SizeLabel.TextSize = 14
SizeLabel.Font = Enum.Font.SourceSans
SizeLabel.Parent = MenuFrame

local SpeedUp = Instance.new("TextButton")
SpeedUp.Size = UDim2.new(0, 40, 0, 25)
SpeedUp.Position = UDim2.new(0, 110, 0, 55)
SpeedUp.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
SpeedUp.Text = "+"
SpeedUp.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedUp.Parent = MenuFrame

local SpeedDown = Instance.new("TextButton")
SpeedDown.Size = UDim2.new(0, 40, 0, 25)
SpeedDown.Position = UDim2.new(0, 50, 0, 55)
SpeedDown.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
SpeedDown.Text = "-"
SpeedDown.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedDown.Parent = MenuFrame

local SizeUp = Instance.new("TextButton")
SizeUp.Size = UDim2.new(0, 40, 0, 25)
SizeUp.Position = UDim2.new(0, 110, 0, 105)
SizeUp.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
SizeUp.Text = "+"
SizeUp.TextColor3 = Color3.fromRGB(255, 255, 255)
SizeUp.Parent = MenuFrame

local SizeDown = Instance.new("TextButton")
SizeDown.Size = UDim2.new(0, 40, 0, 25)
SizeDown.Position = UDim2.new(0, 50, 0, 105)
SizeDown.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
SizeDown.Text = "-"
SizeDown.TextColor3 = Color3.fromRGB(255, 255, 255)
SizeDown.Parent = MenuFrame

for _, btn in pairs({SpeedUp, SpeedDown, SizeUp, SizeDown}) do
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 4)
    c.Parent = btn
end

local ToggleButton = Instance.new("TextButton")
ToggleButton.Name = "ToggleMenu"
ToggleButton.Size = UDim2.new(0, 40, 0, 40)
ToggleButton.Position = UDim2.new(0, 20, 0, 180)
ToggleButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
ToggleButton.Text = "Cat"
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.Font = Enum.Font.SourceSansBold
ToggleButton.TextSize = 14
ToggleButton.Parent = ScreenGui

local toggleCorner = Instance.new("UICorner")
toggleCorner.CornerRadius = UDim.new(0, 8)
toggleCorner.Parent = ToggleButton

ToggleButton.MouseButton1Click:Connect(function()
    MenuFrame.Visible = not MenuFrame.Visible
end)

local config = {
    speed = 250,
    size = 80,
    fleeDistance = 150
}

local function updateUI()
    SpeedLabel.Text = "Speed: " .. tostring(config.speed)
    SizeLabel.Text = "Size: " .. tostring(config.size)
    CatImage.Size = UDim2.new(0, config.size, 0, config.size)
end
updateUI()

SpeedUp.MouseButton1Click:Connect(function() config.speed = math.min(600, config.speed + 25) updateUI() end)
SpeedDown.MouseButton1Click:Connect(function() config.speed = math.max(50, config.speed - 25) updateUI() end)
SizeUp.MouseButton1Click:Connect(function() config.size = math.min(200, config.size + 10) updateUI() end)
SizeDown.MouseButton1Click:Connect(function() config.size = math.max(40, config.size - 10) updateUI() end)

local currentTween = nil

local function getPointerPosition()
    if UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled then
        local touches = UserInputService:GetFocusedTouchLocation()
        if touches then return touches end
        return Vector2.new(Mouse.X, Mouse.Y)
    else
        return Vector2.new(Mouse.X, Mouse.Y)
    end
end

local function getRandomPoint()
    local screenSize = workspace.CurrentCamera.ViewportSize
    local padding = config.size + 20
    return Vector2.new(
        math.random(padding, screenSize.X - padding),
        math.random(padding, screenSize.Y - padding)
    )
end

task.spawn(function()
    while ScreenGui and ScreenGui.Parent do
        local catPos = Vector2.new(CatImage.AbsolutePosition.X + (CatImage.AbsoluteSize.X/2), CatImage.AbsolutePosition.Y + (CatImage.AbsoluteSize.Y/2))
        local pointerPos = getPointerPosition()
        local distance = (catPos - pointerPos).Magnitude

        if distance < config.fleeDistance then
            if currentTween then currentTween:Cancel() end
            
            local direction = (catPos - pointerPos).Unit
            if direction.X ~= direction.X then direction = Vector2.new(1, 0) end 
            
            local targetPos = catPos + (direction * (config.fleeDistance * 1.5))
            local screenSize = workspace.CurrentCamera.ViewportSize
            local padding = config.size / 2
            
            local clampX = math.clamp(targetPos.X, padding, screenSize.X - padding)
            local clampY = math.clamp(targetPos.Y, padding, screenSize.Y - padding)
            
            local finalTarget = Vector2.new(clampX, clampY)
            local travelDist = (finalTarget - catPos).Magnitude
            local duration = travelDist / (config.speed * 1.8)
            
            if duration > 0 then
                local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.QuadOut, Enum.EasingDirection.Out)
                currentTween = TweenService:Create(CatImage, tweenInfo, {
                    Position = UDim2.new(0, finalTarget.X, 0, finalTarget.Y)
                })
                currentTween:Play()
                currentTween.Completed:Wait()
            end
        else
            if not currentTween or currentTween.PlaybackState ~= Enum.PlaybackState.Playing then
                local nextPoint = getRandomPoint()
                local travelDist = (nextPoint - catPos).Magnitude
                local duration = travelDist / config.speed
                
                local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut)
                currentTween = TweenService:Create(CatImage, tweenInfo, {
                    Position = UDim2.new(0, nextPoint.X, 0, nextPoint.Y)
                })
                currentTween:Play()
            end
        end
        task.wait(0.02)
    end
end)
