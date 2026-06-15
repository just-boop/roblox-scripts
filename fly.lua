if game:GetService("CoreGui"):FindFirstChild("FakeDeathMenuGui") then
    game:GetService("CoreGui").FakeDeathMenuGui:Destroy()
end

local Player = game:GetService("Players").LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")

local isDead = false

local function toggleFakeDeath(button)
    if not Character or not Humanoid or Humanoid.Health <= 0 then return end
    
    isDead = not isDead
    
    if isDead then
        Humanoid:SetStateEnabled(Enum.HumanoidStateType.GettingUp, false)
        Humanoid:ChangeState(Enum.HumanoidStateType.Ragdoll)
        
        local hrp = Character:FindFirstChild("HumanoidRootPart")
        if hrp then
            hrp.Velocity = Vector3.new(math.random(-5, 5), 3, math.random(-5, 5))
        end
        
        button.Text = "REVIVE"
        button.BackgroundColor3 = Color3.fromRGB(231, 76, 60)
    else
        Humanoid:SetStateEnabled(Enum.HumanoidStateType.GettingUp, true)
        Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
        
        button.Text = "FAKE DEATH"
        button.BackgroundColor3 = Color3.fromRGB(46, 204, 113)
    end
end

local MenuGui = Instance.new("ScreenGui")
MenuGui.Name = "FakeDeathMenuGui"
MenuGui.Parent = game:GetService("CoreGui")
MenuGui.ResetOnSpawn = false

local OpenButton = Instance.new("TextButton")
OpenButton.Name = "OpenButton"
OpenButton.Parent = MenuGui
OpenButton.Position = UDim2.new(0.05, 0, 0.15, 0)
OpenButton.Size = UDim2.new(0, 60, 0, 30)
OpenButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
OpenButton.Text = "MENU"
OpenButton.TextColor3 = Color3.fromRGB(255, 255, 255)
OpenButton.Font = Enum.Font.SourceSansBold
OpenButton.TextSize = 14

local OpenCorner = Instance.new("UICorner")
OpenCorner.CornerRadius = UDim.new(0, 6)
OpenCorner.Parent = OpenButton

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = MenuGui
MainFrame.Position = UDim2.new(0.3, 0, 0.3, 0)
MainFrame.Size = UDim2.new(0, 220, 0, 140)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BorderSizePixel = 0
MainFrame.Visible = true

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 10)
MainCorner.Parent = MainFrame

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Name = "TitleLabel"
TitleLabel.Parent = MainFrame
TitleLabel.Size = UDim2.new(1, 0, 0, 35)
TitleLabel.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
TitleLabel.Text = "  FAKE DEATH BY DELTA"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.Font = Enum.Font.SourceSansBold
TitleLabel.TextSize = 16
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 10)
TitleCorner.Parent = TitleLabel

local ActionButton = Instance.new("TextButton")
ActionButton.Name = "ActionButton"
ActionButton.Parent = MainFrame
ActionButton.Position = UDim2.new(0.1, 0, 0.45, 0)
ActionButton.Size = UDim2.new(0, 176, 0, 45)
ActionButton.BackgroundColor3 = Color3.fromRGB(46, 204, 113)
ActionButton.Text = "FAKE DEATH"
ActionButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ActionButton.Font = Enum.Font.SourceSansBold
ActionButton.TextSize = 18

local ActionCorner = Instance.new("UICorner")
ActionCorner.CornerRadius = UDim.new(0, 8)
ActionCorner.Parent = ActionButton

OpenButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

ActionButton.MouseButton1Click:Connect(function()
    toggleFakeDeath(ActionButton)
end)

local UserInputService = game:GetService("UserInputService")
local dragging, dragInput, dragStart, startPos

local function update(input)
    local delta = input.Position - dragStart
    MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

MainFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)

Humanoid.Died:Connect(function()
    MenuGui:Destroy()
end)
