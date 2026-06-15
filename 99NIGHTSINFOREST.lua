local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local ChopAuraBtn = Instance.new("TextButton")
local BringFuelBtn = Instance.new("TextButton")

ScreenGui.Parent = game.CoreGui
ScreenGui.Name = "SoftHub99N"

MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.Position = UDim2.new(0.1, 0, 0.2, 0)
MainFrame.Size = UDim2.new(0, 200, 0, 180)
MainFrame.Active = true
MainFrame.Draggable = true

Title.Name = "Title"
Title.Parent = MainFrame
Title.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Title.Size = UDim2.new(1, 0, 0, 35)
Title.Font = Enum.Font.SourceSansBold
Title.Text = "99 NIGHTS HUB"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 14

ChopAuraBtn.Name = "ChopAuraBtn"
ChopAuraBtn.Parent = MainFrame
ChopAuraBtn.BackgroundColor3 = Color3.fromRGB(150, 50, 50)
ChopAuraBtn.Position = UDim2.new(0.05, 0, 0.25, 0)
ChopAuraBtn.Size = UDim2.new(0.9, 0, 0, 40)
ChopAuraBtn.Font = Enum.Font.SourceSans
ChopAuraBtn.Text = "Chop Aura: OFF"
ChopAuraBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ChopAuraBtn.TextSize = 14

BringFuelBtn.Name = "BringFuelBtn"
BringFuelBtn.Parent = MainFrame
BringFuelBtn.BackgroundColor3 = Color3.fromRGB(150, 50, 50)
BringFuelBtn.Position = UDim2.new(0.05, 0, 0.55, 0)
BringFuelBtn.Size = UDim2.new(0.9, 0, 0, 40)
BringFuelBtn.Font = Enum.Font.SourceSans
BringFuelBtn.Text = "Magnet: OFF"
BringFuelBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
BringFuelBtn.TextSize = 14

local player = game.Players.LocalPlayer
local runService = game:GetService("RunService")
local chopActive = false
local magnetActive = false

ChopAuraBtn.MouseButton1Click:Connect(function()
    chopActive = not chopActive
    if chopActive then
        ChopAuraBtn.Text = "Chop Aura: ON"
        ChopAuraBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
    else
        ChopAuraBtn.Text = "Chop Aura: OFF"
        ChopAuraBtn.BackgroundColor3 = Color3.fromRGB(150, 50, 50)
    end
end)

BringFuelBtn.MouseButton1Click:Connect(function()
    magnetActive = not magnetActive
    if magnetActive then
        BringFuelBtn.Text = "Magnet: ON"
        BringFuelBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
    else
        BringFuelBtn.Text = "Magnet: OFF"
        BringFuelBtn.BackgroundColor3 = Color3.fromRGB(150, 50, 50)
    end
end)

runService.Heartbeat:Connect(function()
    local character = player.Character
    local root = character and character:FindFirstChild("HumanoidRootPart")
    if not root then return end

    if chopActive then
        for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("Model") and (v.Name == "Tree" or v.Name:lower():find("tree") or v.Name:lower():find("wood")) then
                local p = v.PrimaryPart or v:FindFirstChildWhichIsA("BasePart")
                if p and (root.Position - p.Position).Magnitude <= 25 then
                    local tool = character:FindFirstChildOfClass("Tool")
                    if tool then 
                        tool:Activate() 
                    end
                    local rem = game.ReplicatedStorage:FindFirstChild("Chop") or game.ReplicatedStorage:FindFirstChild("ChopTree") or (game.ReplicatedStorage:FindFirstChild("Remotes") and game.ReplicatedStorage.Remotes:FindFirstChild("ChopTree"))
                    if rem and rem:IsA("RemoteEvent") then
                        rem:FireServer(v)
                    end
                end
            end
        end
    end

    if magnetActive then
        for _, item in pairs(workspace:GetDescendants()) do
            if item:IsA("BasePart") and (item.Name == "Log" or item.Name == "Wood" or item.Name:lower():find("drop") or item.Name:lower():find("fuel")) then
                if (root.Position - item.Position).Magnitude <= 150 then
                    item.CFrame = root.CFrame * CFrame.new(0, -2, 0)
                    item.Velocity = Vector3.new(0, 0, 0)
                end
            end
        end
    end
end)
