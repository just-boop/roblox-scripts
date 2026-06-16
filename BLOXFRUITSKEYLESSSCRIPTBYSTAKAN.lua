local players = game:GetService("Players")
local player = players.LocalPlayer
local runService = game:GetService("RunService")
local tweenService = game:GetService("TweenService")
local workspace = game:GetService("Workspace")

local flySpeed = 50
local flying = false
local espEnabled = true
local espMarkers = {}

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "FruitNotifierGui"
ScreenGui.ResetOnSpawn = false
pcall(function() ScreenGui.IgnoreGuiInset = true end)
ScreenGui.Parent = player:WaitForChild("PlayerGui")

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 220, 0, 160)
MainFrame.Position = UDim2.new(0.5, -110, 0.4, -80)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -60, 0, 30)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.Text = "Fruit Hub | Delta"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 14
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.BackgroundTransparency = 1
Title.Parent = MainFrame

local OpenButton = Instance.new("TextButton")
OpenButton.Name = "OpenButton"
OpenButton.Size = UDim2.new(0, 45, 0, 45)
OpenButton.Position = UDim2.new(0, 20, 0, 50)
OpenButton.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
OpenButton.Text = "🍇"
OpenButton.TextSize = 20
OpenButton.TextColor3 = Color3.fromRGB(255, 255, 255)
OpenButton.Visible = false
OpenButton.Parent = ScreenGui

local OpenCorner = Instance.new("UICorner")
OpenCorner.CornerRadius = UDim.new(1, 0)
OpenCorner.Parent = OpenButton
OpenButton.Draggable = true

local WarnFrame = Instance.new("Frame")
WarnFrame.Name = "WarnFrame"
WarnFrame.Size = UDim2.new(0, 200, 0, 110)
WarnFrame.Position = UDim2.new(0.5, -100, 0.4, -55)
WarnFrame.BackgroundColor3 = Color3.fromRGB(40, 20, 20)
WarnFrame.BorderSizePixel = 0
WarnFrame.Visible = false
WarnFrame.Parent = ScreenGui

local WarnCorner = Instance.new("UICorner")
WarnCorner.CornerRadius = UDim.new(0, 8)
WarnCorner.Parent = WarnFrame

local WarnText = Instance.new("TextLabel")
WarnText.Size = UDim2.new(1, 0, 0, 50)
WarnText.Text = "Уверены, что\nхотите закрыть?"
WarnText.TextColor3 = Color3.fromRGB(255, 255, 255)
WarnText.TextSize = 14
WarnText.Font = Enum.Font.GothamBold
WarnText.BackgroundTransparency = 1
WarnText.Parent = WarnFrame

local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Size = UDim2.new(0, 25, 0, 25)
MinimizeBtn.Position = UDim2.new(1, -55, 0, 3)
MinimizeBtn.Text = "—"
MinimizeBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
MinimizeBtn.Font = Enum.Font.GothamBold
MinimizeBtn.Parent = MainFrame
Instance.new("UICorner", MinimizeBtn).CornerRadius = UDim.new(0, 5)

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 25, 0, 25)
CloseBtn.Position = UDim2.new(1, -28, 0, 3)
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
CloseBtn.BackgroundColor3 = Color3.fromRGB(50, 30, 30)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Parent = MainFrame
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 5)

local ToggleESP = Instance.new("TextButton")
ToggleESP.Size = UDim2.new(1, -20, 0, 35)
ToggleESP.Position = UDim2.new(0, 10, 0, 45)
ToggleESP.BackgroundColor3 = Color3.fromRGB(0, 150, 100)
ToggleESP.Text = "ESP Фрукты: ВКЛ"
ToggleESP.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleESP.Font = Enum.Font.GothamBold
ToggleESP.TextSize = 12
ToggleESP.Parent = MainFrame
Instance.new("UICorner", ToggleESP).CornerRadius = UDim.new(0, 6)

local ToggleFly = Instance.new("TextButton")
ToggleFly.Size = UDim2.new(1, -20, 0, 35)
ToggleFly.Position = UDim2.new(0, 10, 0, 95)
ToggleFly.BackgroundColor3 = Color3.fromRGB(150, 50, 50)
ToggleFly.Text = "Безопасный Полет: ВЫКЛ"
ToggleFly.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleFly.Font = Enum.Font.GothamBold
ToggleFly.TextSize = 12
ToggleFly.Parent = MainFrame
Instance.new("UICorner", ToggleFly).CornerRadius = UDim.new(0, 6)

local YesBtn = Instance.new("TextButton")
YesBtn.Size = UDim2.new(0, 80, 0, 30)
YesBtn.Position = UDim2.new(0, 15, 0, 65)
YesBtn.BackgroundColor3 = Color3.fromRGB(150, 50, 50)
YesBtn.Text = "Да"
YesBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
YesBtn.Font = Enum.Font.GothamBold
YesBtn.Parent = WarnFrame
Instance.new("UICorner", YesBtn).CornerRadius = UDim.new(0, 5)

local NoBtn = Instance.new("TextButton")
NoBtn.Size = UDim2.new(0, 80, 0, 30)
NoBtn.Position = UDim2.new(1, -95, 0, 65)
NoBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
NoBtn.Text = "Нет"
NoBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
NoBtn.Font = Enum.Font.GothamBold
NoBtn.Parent = WarnFrame
Instance.new("UICorner", NoBtn).CornerRadius = UDim.new(0, 5)

local function tween(obj, info, prop)
    local t = tweenService:Create(obj, TweenInfo.new(unpack(info)), prop)
    t:Play()
    return t
end

MinimizeBtn.MouseButton1Click:Connect(function()
    local t = tween(MainFrame, {0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.In}, {
        Size = UDim2.new(0, 0, 0, 0),
        Position = UDim2.new(0, 20, 0, 50),
        BackgroundTransparency = 1
    })
    t.Completed:Connect(function()
        MainFrame.Visible = false
        OpenButton.Visible = true
        MainFrame.Size = UDim2.new(0, 220, 0, 160)
        MainFrame.BackgroundTransparency = 0
    end)
end)

OpenButton.MouseButton1Click:Connect(function()
    MainFrame.Size = UDim2.new(0, 0, 0, 0)
    MainFrame.Position = OpenButton.Position
    MainFrame.Visible = true
    OpenButton.Visible = false
    
    tween(MainFrame, {0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out}, {
        Size = UDim2.new(0, 220, 0, 160),
        Position = UDim2.new(0.5, -110, 0.4, -80)
    })
end)

CloseBtn.MouseButton1Click:Connect(function()
    local t = tween(MainFrame, {0.4, Enum.EasingStyle.Back, Enum.EasingDirection.In}, {
        Position = UDim2.new(MainFrame.Position.X.Scale, MainFrame.Position.X.Offset, -0.5, 0)
    })
    t.Completed:Connect(function()
        MainFrame.Visible = false
        WarnFrame.Visible = true
        WarnFrame.Size = UDim2.new(0, 0, 0, 0)
        tween(WarnFrame, {0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out}, {
            Size = UDim2.new(0, 200, 0, 110)
        })
    end)
end)

NoBtn.MouseButton1Click:Connect(function()
    WarnFrame.Visible = false
    MainFrame.Position = UDim2.new(0.5, -110, -0.5, 0)
    MainFrame.Visible = true
    tween(MainFrame, {0.4, Enum.EasingStyle.Out, Enum.EasingDirection.Quad}, {
        Position = UDim2.new(0.5, -110, 0.4, -80)
    })
end)

YesBtn.MouseButton1Click:Connect(function()
    flying = false
    espEnabled = false
    for _, marker in pairs(espMarkers) do
        if marker then marker:Destroy() end
    end
    ScreenGui:Destroy()
end)

local function createFruitESP(object)
    if not object:IsA("Tool") and not object:IsA("Model") then return end
    if string.find(object.Name, "Fruit") or object:FindFirstChild("Fruit") or (object:IsA("Tool") and string.find(object.Name, "Physical")) then
        local handle = object:FindFirstChild("Handle") or object:WaitForChild("Handle", 5)
        if not handle then return end

        local billboard = Instance.new("BillboardGui")
        billboard.Size = UDim2.new(0, 100, 0, 40)
        billboard.AlwaysOnTop = true
        billboard.Adornee = handle
        billboard.Parent = ScreenGui

        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1, 0, 1, 0)
        label.BackgroundTransparency = 1
        label.TextColor3 = Color3.fromRGB(255, 0, 120)
        label.TextSize = 14
        label.Font = Enum.Font.GothamBold
        label.Parent = billboard

        table.insert(espMarkers, billboard)

        local connection
        connection = runService.RenderStepped:Connect(function()
            if not espEnabled or not object.Parent or not handle.Parent then
                billboard:Destroy()
                connection:Disconnect()
                return
            end
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                local distance = math.floor((player.Character.HumanoidRootPart.Position - handle.Position).Magnitude)
                label.Text = "🍎 " .. object.Name:gsub("Physical", ""):gsub("Fruit", "") .. "\n[" .. distance .. "m]"
            end
        end)
    end
end

for _, child in pairs(workspace:GetChildren()) do createFruitESP(child) end
workspace.ChildAdded:Connect(createFruitESP)

ToggleESP.MouseButton1Click:Connect(function()
    espEnabled = not espEnabled
    if espEnabled then
        ToggleESP.Text = "ESP Фрукты: ВКЛ"
        ToggleESP.BackgroundColor3 = Color3.fromRGB(0, 150, 100)
        for _, child in pairs(workspace:GetChildren()) do createFruitESP(child) end
    else
        ToggleESP.Text = "ESP Фрукты: ВЫКЛ"
        ToggleESP.BackgroundColor3 = Color3.fromRGB(150, 50, 50)
    end
end)

local bodyVelocity, bodyGyro

ToggleFly.MouseButton1Click:Connect(function()
    flying = not flying
    local character = player.Character
    local root = character and character:FindFirstChild("HumanoidRootPart")
    
    if flying and root then
        ToggleFly.Text = "Безопасный Полет: ВКЛ"
        ToggleFly.BackgroundColor3 = Color3.fromRGB(0, 150, 100)

        bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.MaxForce = Vector3.new(1e6, 1e6, 1e6)
        bodyVelocity.Velocity = Vector3.new(0, 0, 0)
        bodyVelocity.Parent = root

        bodyGyro = Instance.new("BodyGyro")
        bodyGyro.MaxTorque = Vector3.new(1e6, 1e6, 1e6)
        bodyGyro.CFrame = root.CFrame
        bodyGyro.Parent = root

        task.spawn(function()
while flying and root and root.Parent dolocal camera = workspace.CurrentCameralocal moveDirection = camera.CFrame.LookVectorif character:FindFirstChildOfClass("Humanoid").MoveDirection.Magnitude > 0 thenbodyVelocity.Velocity = moveDirection * flySpeedelsebodyVelocity.Velocity = Vector3.new(0, 0.1, 0)endbodyGyro.CFrame = camera.CFramerunService.RenderStepped:Wait()endend)elseToggleFly.Text = "Безопасный Полет: ВЫКЛ"ToggleFly.BackgroundColor3 = Color3.fromRGB(150, 50, 50)if bodyVelocity then bodyVelocity:Destroy() endif bodyGyro then bodyGyro:Destroy() endendend)
