local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BangBangBangGui"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = player:WaitForChild("PlayerGui")

local MainButton = Instance.new("TextButton")
MainButton.Size = UDim2.new(0, 130, 0, 50)
MainButton.Position = UDim2.new(0.1, 0, 0.4, 0)
MainButton.BackgroundColor3 = Color3.fromRGB(240, 40, 40)
MainButton.Text = "💥 BANG!"
MainButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MainButton.TextSize = 20
MainButton.Font = Enum.Font.GothamBold
MainButton.ClipsDescendants = true
MainButton.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = MainButton

local dragging, dragStart, startPos
MainButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainButton.Position
    end
end)

MainButton.InputChanged:Connect(function(input)
    if (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) and dragging then
        local delta = input.Position - dragStart
        MainButton.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

local isPlaying = false
local currentSound = nil
local currentPart = nil

local function stopAll()
    if currentSound then currentSound:Destroy() currentSound = nil end
    if currentPart then currentPart:Destroy() currentPart = nil end
    MainButton.Text = "💥 BANG!"
    MainButton.BackgroundColor3 = Color3.fromRGB(240, 40, 40)
    isPlaying = false
end

local function playBangBangBang()
    local char = player.Character
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    local root = char:FindFirstChild("HumanoidRootPart")
    if not hum or not root then return end

    if isPlaying then
        stopAll()
        return
    end

    isPlaying = true
    MainButton.Text = "🛑 STOP"
    MainButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)

    local attachBone = char:FindFirstChild("UpperTorso") or char:FindFirstChild("Torso")

    currentPart = Instance.new("Part")
    currentPart.Name = "BangBoombox"
    currentPart.Size = Vector3.new(3, 0.5, 3)
    currentPart.Material = Enum.Material.Neon
    currentPart.Color = Color3.fromRGB(255, 0, 50)
    currentPart.CanCollide = false
    currentPart.Position = root.Position - Vector3.new(0, 2.5, 0)
    currentPart.Parent = char

    local weld = Instance.new("Weld")
    weld.Part0 = currentPart
    weld.Part1 = attachBone
    weld.C0 = CFrame.new(0, -2.5, 0)
    weld.Parent = currentPart

    currentSound = Instance.new("Sound")
    currentSound.SoundId = "rbxassetid://82555479370279"
    currentSound.Volume = 8
    currentSound.Looped = true
    currentSound.Parent = currentPart
    currentSound:Play()

    pcall(function()
        game:GetService("Players"):PlayEmoteAndContainId(82555479370279)
    end)
    pcall(function()
        game:GetService("Players"):PlayEmoteAndContainId(138754234660406)
    end)

    local chatEvent = game:GetService("ReplicatedStorage"):FindFirstChild("DefaultChatSystemChatEvents")
    if chatEvent then
        local msgRequest = chatEvent:FindFirstChild("SayMessageRequest")
        if msgRequest then
            msgRequest:FireServer("/e dance", "All")
        end
    end
end

MainButton.MouseButton1Click:Connect(playBangBangBang)
player.CharacterAdded:Connect(stopAll)
