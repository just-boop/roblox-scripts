if game:GetService("CoreGui"):FindFirstChild("BabftComboGui") then
    game:GetService("CoreGui").BabftComboGui:Destroy()
end

local Player = game:GetService("Players").LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local isBroken = false
local autoFarming = false
local savedMotors = {}
local zeroVelocityConnection = nil

-- FAKE DEATH LOGIC
local function breakJoints(char)
    table.clear(savedMotors)
    for _, v in pairs(char:GetDescendants()) do
        if v:IsA("Motor6D") then 
            table.insert(savedMotors, {
                Parent = v.Parent,
                Name = v.Name,
                Part0 = v.Part0,
                Part1 = v.Part1,
                C0 = v.C0,
                C1 = v.C1
            })
            v:Destroy()
        end
    end
end

local function toggleFakeDeath(button)
    local Character = Player.Character or Player.CharacterAdded:Wait()
    local Humanoid = Character:FindFirstChildOfClass("Humanoid")
    local HRP = Character:FindFirstChild("HumanoidRootPart")
    if not Character or not Humanoid or Humanoid.Health <= 0 or not HRP then return end
    if autoFarming then return end
    
    isBroken = not isBroken
    
    if isBroken then
        Humanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
        breakJoints(Character)
        
        zeroVelocityConnection = RunService.RenderStepped:Connect(function()
            if not isBroken then return end
            for _, part in pairs(Character:GetChildren()) do
                if part:IsA("BasePart") then
                    part.Velocity = Vector3.new(0, -1, 0)
                    part.RotVelocity = Vector3.new(0, 0, 0)
                end
            end
        end)
        
        button.Text = "ASSEMBLE"
        button.BackgroundColor3 = Color3.fromRGB(231, 76, 60)
    else
        if zeroVelocityConnection then 
            zeroVelocityConnection:Disconnect() 
            zeroVelocityConnection = nil
        end
        
        for _, part in pairs(Character:GetChildren()) do
            if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                part.CFrame = HRP.CFrame
                part.Velocity = Vector3.new(0, 0, 0)
            end
        end
        
        task.wait(0.05)
        
        for _, data in pairs(savedMotors) do
            if data.Parent then
                local motor = Instance.new("Motor6D")
                motor.Name = data.Name
                motor.Part0 = data.Part0
                motor.Part1 = data.Part1
                motor.C0 = data.C0
                motor.C1 = data.C1
                motor.Parent = data.Parent
            end
        end
        
        Humanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, true)
        Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
        
        button.Text = "DISASSEMBLE"
        button.BackgroundColor3 = Color3.fromRGB(46, 204, 113)
    end
end

-- AUTO FARM LOGIC
local function startAutoFarm(button)
    autoFarming = not autoFarming
    
    if autoFarming then
        button.Text = "STOP FARM"
        button.BackgroundColor3 = Color3.fromRGB(231, 76, 60)
        
        task.spawn(function()
            while autoFarming do
                local Character = Player.Character
                local HRP = Character and Character:FindFirstChild("HumanoidRootPart")
                local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
                
                if HRP and Humanoid and Humanoid.Health > 0 then
                    if isBroken then toggleFakeDeath(button.Parent.FakeBtn) end
                    
                    -- Safe bypass stages setup
                    for i = 1, 10 do
                        if not autoFarming then break end
                        local stage = workspace:FindFirstChild("BoatStages") 
                            and workspace.BoatStages:FindFirstChild("NormalStages") 
                            and workspace.BoatStages.NormalStages:FindFirstChild("CaveStage"..i)
                        
                        local darkness = stage and stage:FindFirstChild("DarknessPart")
                        if darkness then
                            HRP.CFrame = darkness.CFrame
                            task.wait(0.25)
                        end
                    end
                    
                    -- Teleport to the end chest
                    if autoFarming then
                        local endZone = workspace:FindFirstChild("BoatStages") 
                            and workspace.BoatStages:FindFirstChild("NormalStages") 
                            and workspace.BoatStages.NormalStages:FindFirstChild("TheEnd")
                        
                        local goldenChest = endZone and endZone:FindFirstChild("GoldenChest")
                        if goldenChest and goldenChest:FindFirstChild("ChestTop") then
                            HRP.CFrame = goldenChest.ChestTop.CFrame * CFrame.new(0, 2, 0)
                            task.wait(3)
                        end
                    end
                end
                task.wait(1)
            end
        end)
    else
        button.Text = "START AUTO FARM"
        button.BackgroundColor3 = Color3.fromRGB(52, 152, 219)
    end
end

-- UI INTERFACE
local Gui = Instance.new("ScreenGui", game:GetService("CoreGui"))
Gui.Name = "BabftComboGui"

local MainFrame = Instance.new("Frame", Gui)
MainFrame.Size = UDim2.new(0, 220, 0, 160)
MainFrame.Position = UDim2.new(0.35, 0, 0.35, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Instance.new("UICorner", MainFrame)

local FakeBtn = Instance.new("TextButton", MainFrame)
FakeBtn.Name = "FakeBtn"
FakeBtn.Size = UDim2.new(0, 180, 0, 40)
FakeBtn.Position = UDim2.new(0.09, 0, 0.15, 0)
FakeBtn.BackgroundColor3 = Color3.fromRGB(46, 204, 113)
FakeBtn.Text = "DISASSEMBLE"
FakeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
FakeBtn.Font = Enum.Font.SourceSansBold
FakeBtn.TextSize = 16
Instance.new("UICorner", FakeBtn)

local FarmBtn = Instance.new("TextButton", MainFrame)
FarmBtn.Size = UDim2.new(0, 180, 0, 40)
FarmBtn.Position = UDim2.new(0.09, 0, 0.55, 0)
FarmBtn.BackgroundColor3 = Color3.fromRGB(52, 152, 219)
FarmBtn.Text = "START AUTO FARM"
FarmBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
FarmBtn.Font = Enum.Font.SourceSansBold
FarmBtn.TextSize = 16
Instance.new("UICorner", FarmBtn)

FakeBtn.MouseButton1Click:Connect(function()
    toggleFakeDeath(FakeBtn)
end)

FarmBtn.MouseButton1Click:Connect(function()
    startAutoFarm(FarmBtn)
end)

-- Mobile dragging
local dragging, dragInput, dragStart, startPos
MainFrame.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.Touch then
        dragging = true dragStart = i.Position startPos = MainFrame.Position
        i.Changed:Connect(function() if i.UserInputState == Enum.UserInputState.End then dragging = false end end)
    end
end)
game:GetService("UserInputService").InputChanged:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.Touch and dragging then
        local d = i.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y)
    end
end)
