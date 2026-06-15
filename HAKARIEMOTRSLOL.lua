local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

local animationId = "rbxassetid://15968650406"
local musicId = "rbxassetid://1841443579"

local anim = Instance.new("Animation")
anim.AnimationId = animationId
local playAnim = humanoid:LoadAnimation(anim)

local sound = Instance.new("Sound")
sound.SoundId = musicId
sound.Volume = 2
sound.Looped = true
sound.Parent = character:WaitForChild("HumanoidRootPart")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "HakariDanceGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

local button = Instance.new("TextButton")
button.Size = UDim2.new(0, 70, 0, 70)
button.Position = UDim2.new(0.75, 0, 0.65, 0)
button.BackgroundColor3 = Color3.fromRGB(34, 177, 76)
button.Text = "HAKARI"
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.TextSize = 14
button.Font = Enum.Font.SourceSansBold
button.Parent = screenGui

local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(1, 0)
uiCorner.Parent = button

local active = false

button.MouseButton1Click:Connect(function()
    active = not active
    if active then
        button.BackgroundColor3 = Color3.fromRGB(237, 28, 36)
        playAnim:Play()
        playAnim.Looped = true
        sound:Play()
    else
        button.BackgroundColor3 = Color3.fromRGB(34, 177, 76)
        playAnim:Stop()
        sound:Stop()
    end
end)

player.CharacterAdded:Connect(function(newCharacter)
    character = newCharacter
    humanoid = character:WaitForChild("Humanoid")
    playAnim = humanoid:LoadAnimation(anim)
    sound.Parent = character:WaitForChild("HumanoidRootPart")
    if active then
        playAnim:Play()
        playAnim.Looped = true
        sound:Play()
    end
end)
