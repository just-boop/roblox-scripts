local OrionLib = loadstring(game:HttpGet(('https://githubusercontent.com')))()
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local SilentAimEnabled = false
local FOVRadius = 120
local FOVVisible = true
local ESPEnabled = false

local Window = OrionLib:MakeWindow({Name = "Thunder Hub | Sniper Arena", HidePremium = true, SaveConfig = false, ConfigFolder = "ThunderHubSA"})

local HomeTab = Window:MakeTab({
    Name = "Home",
    Icon = "rbxassetid://4483345998",
    Premium = false
})

local userId = LocalPlayer.UserId
local thumbType = Enum.ThumbnailType.HeadShot
local thumbSize = Enum.ThumbnailSize.Size150x150
local avatarUrl, isReady = Players:GetUserThumbnailAsync(userId, thumbType, thumbSize)

HomeTab:AddParagraph("Welcome to Thunder Hub!", "Script successfully loaded for Sniper Arena.")

if isReady then
    HomeTab:AddLabel("Player: " .. LocalPlayer.Name)
    HomeTab:AddParagraph("Your Profile:", "Display Name: " .. LocalPlayer.DisplayName .. " (@" .. LocalPlayer.Name .. ")")
end

local ExploitsTab = Window:MakeTab({
    Name = "Exploits",
    Icon = "rbxassetid://4483345998",
    Premium = false
})

ExploitsTab:AddSection({ Name = "--- SILENT AIM ---" })

ExploitsTab:AddToggle({
    Name = "Enable Silent Aim",
    Default = false,
    Callback = function(Value)
        SilentAimEnabled = Value
    end
})

ExploitsTab:AddToggle({
    Name = "Show FOV Radius",
    Default = true,
    Callback = function(Value)
        FOVVisible = Value
    end
})

ExploitsTab:AddSlider({
    Name = "FOV Radius Size",
    Min = 30,
    Max = 400,
    Default = 120,
    Color = Color3.fromRGB(255, 215, 0),
    Increment = 5,
    ValueName = "px",
    Callback = function(Value)
        FOVRadius = Value
    end
})

ExploitsTab:AddSection({ Name = "--- ESP ---" })

ExploitsTab:AddToggle({
    Name = "Enable ESP Boxes",
    Default = false,
    Callback = function(Value)
        ESPEnabled = Value
        if not Value then
            for _, p in pairs(Players:GetPlayers()) do
                if p.Character and p.Character:FindFirstChild("Highlight") then
                    p.Character.Highlight:Destroy()
                end
            end
        end
    end
})

local FOVCircle = Drawing.new("Circle")
FOVCircle.Thickness = 2
FOVCircle.Color = Color3.fromRGB(255, 215, 0)
FOVCircle.Filled = false
FOVCircle.Transparency = 0.7

local function GetClosestTarget()
    local closestPlayer = nil
    local shortestDistance = math.huge
    local screenCenter = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Head") and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0 then
            local pos, onScreen = Camera:WorldToViewportPoint(player.Character.Head.Position)
            if onScreen then
                local distance = (Vector2.new(pos.X, pos.Y) - screenCenter).Magnitude
                if distance < shortestDistance and distance <= FOVRadius then
                    closestPlayer = player
                    shortestDistance = distance
                end
            end
        end
    end
    return closestPlayer
end

RunService.RenderStepped:Connect(function()
    FOVCircle.Radius = FOVRadius
    FOVCircle.Visible = FOVVisible
    FOVCircle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    
    if ESPEnabled then
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0 then
                if not player.Character:FindFirstChild("Highlight") then
                    local highlight = Instance.new("Highlight")
                    highlight.Parent = player.Character
                    highlight.FillColor = Color3.fromRGB(255, 0, 0)
                    highlight.FillTransparency = 0.5
                    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                end
            end
        end
    end
end)

local Metatable = getrawmetatable(game)
local OldNamecall = Metatable.__namecall
setreadonly(Metatable, false)

Metatable.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    
    if SilentAimEnabled and (method == "FindPartOnRayWithIgnoreList" or method == "FindPartOnRay" or method == "Raycast") then
        local target = GetClosestTarget()
        if target and target.Character and target.Character:FindFirstChild("Head") then
            return target.Character.Head, target.Character.Head.Position, Vector3.new(0,0,0), target.Character.Head.Material
        end
    end
    
    return OldNamecall(self, ...)
end)
setreadonly(Metatable, true)

OrionLib:Init()

local CoreGui = game:GetService("CoreGui")
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ThunderHubCircleButtonGui"
ScreenGui.Parent = CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local ToggleButton = Instance.new("TextButton")
ToggleButton.Name = "ToggleButton"
ToggleButton.Parent = ScreenGui
ToggleButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
ToggleButton.BorderSizePixel = 0
ToggleButton.Position = UDim2.new(0.05, 0, 0.2, 0)
ToggleButton.Size = UDim2.new(0, 60, 0, 60)
ToggleButton.Font = Enum.Font.SourceSansBold
ToggleButton.Text = "TH"
ToggleButton.TextColor3 = Color3.fromRGB(255, 215, 0)
ToggleButton.TextSize = 22.000

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(1, 0)
UICorner.Parent = ToggleButton

local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(255, 215, 0)
UIStroke.Thickness = 2
UIStroke.Parent = ToggleButton

local dragging
local dragInput
local dragStart
local startPos

local function update(input)
    local delta = input.Position - dragStart
    local endPos = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    TweenService:Create(ToggleButton, TweenInfo.new(0.1), {Position = endPos}):Play()
end

ToggleButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = ToggleButton.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

ToggleButton.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)

ToggleButton.MouseButton1Click:Connect(function()
    local targetGui = CoreGui:FindFirstChild("Orion")
    if targetGui then
        targetGui.Enabled = not targetGui.Enabled
    end
end)
