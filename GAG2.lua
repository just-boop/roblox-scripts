local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local UIS = game:GetService("UserInputService")
local player = Players.LocalPlayer

local oldGui = CoreGui:FindFirstChild("GardenStealerGui")
if oldGui then oldGui:Destroy() end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "GardenStealerGui"
ScreenGui.Parent = CoreGui

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 220, 0, 310)
MainFrame.Position = UDim2.new(0.3, 0, 0.2, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundTransparency = 1
Title.Text = "🍓 GARDEN STEALER 2"
Title.TextColor3 = Color3.fromRGB(255, 60, 60)
Title.TextSize = 18
Title.Font = Enum.Font.GothamBold
Title.Parent = MainFrame

local GardenInput = Instance.new("TextBox")
GardenInput.Size = UDim2.new(0.9, 0, 0, 40)
GardenInput.Position = UDim2.new(0.05, 0, 0.18, 0)
GardenInput.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
GardenInput.Text = ""
GardenInput.PlaceholderText = "Ник игрока (Сад)"
GardenInput.TextColor3 = Color3.fromRGB(255, 255, 255)
GardenInput.TextSize = 14
GardenInput.Font = Enum.Font.Gotham
GardenInput.Parent = MainFrame

local UICorner2 = Instance.new("UICorner")
UICorner2.CornerRadius = UDim.new(0, 6)
UICorner2.Parent = GardenInput

local FruitInput = Instance.new("TextBox")
FruitInput.Size = UDim2.new(0.9, 0, 0, 40)
FruitInput.Position = UDim2.new(0.05, 0, 0.35, 0)
FruitInput.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
FruitInput.Text = ""
FruitInput.PlaceholderText = "Название плода (en)"
FruitInput.TextColor3 = Color3.fromRGB(255, 255, 255)
FruitInput.TextSize = 14
FruitInput.Font = Enum.Font.Gotham
FruitInput.Parent = MainFrame

local UICorner3 = Instance.new("UICorner")
UICorner3.CornerRadius = UDim.new(0, 6)
UICorner3.Parent = FruitInput

local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Size = UDim2.new(0.9, 0, 0, 45)
ToggleBtn.Position = UDim2.new(0.05, 0, 0.53, 0)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
ToggleBtn.Text = "START STEAL"
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.TextSize = 16
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.Parent = MainFrame

local UICorner4 = Instance.new("UICorner")
UICorner4.CornerRadius = UDim.new(0, 6)
UICorner4.Parent = ToggleBtn

local InfoLabel = Instance.new("TextLabel")
InfoLabel.Size = UDim2.new(0.9, 0, 0, 70)
InfoLabel.Position = UDim2.new(0.05, 0, 0.72, 0)
InfoLabel.BackgroundTransparency = 1
InfoLabel.Text = "Введите ник жертвы\nи плод (напр. Apple, Tomato)\nЗатем нажмите кнопку."
InfoLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
InfoLabel.TextSize = 12
InfoLabel.Font = Enum.Font.Gotham
InfoLabel.TextWrapped = true
InfoLabel.Parent = MainFrame

local stealing = false

local function getTargetPlot(targetName)
    local lowerName = string.lower(targetName)
    for _, p in ipairs(Players:GetPlayers()) do
        if string.find(string.lower(p.Name), lowerName) or string.find(string.lower(p.DisplayName), lowerName) then
            local plots = workspace:FindFirstChild("Plots") or workspace:FindFirstChild("Gardens")
            if plots then
                local plot = plots:FindFirstChild(p.Name) or plots:FindFirstChild(p.UserId)
                if plot then return plot end
            end
        end
    end
    return nil
end

local function startLoop()
    while stealing do
        task.wait(0.5)
        local targetName = GardenInput.Text
        local fruitName = string.lower(FruitInput.Text)
        
        if targetName == "" or fruitName == "" then
            InfoLabel.Text = "Ошибка: Заполните оба поля!"
            stealing = false
            ToggleBtn.Text = "START STEAL"
            ToggleBtn.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
            break
        end
        
        local plot = getTargetPlot(targetName)
        if plot then
            local found = false
            for _, obj in ipairs(plot:GetDescendants()) do
                if obj:IsA("Model") and string.find(string.lower(obj.Name), fruitName) then
                    local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
                    local pPart = obj:FindFirstChildWhichIsA("BasePart")
                    if hrp and pPart then
                        found = true
                        InfoLabel.Text = "Кража: " .. obj.Name .. " из сада " .. targetName
                        hrp.CFrame = pPart.CFrame + Vector3.new(0, 2, 0)
                        task.wait(0.2)
                        
                        local proximity = obj:FindFirstChildWhichIsA("ProximityPrompt", true)
                        if proximity then
                            fireproximityprompt(proximity)
                        else
                            local touch = obj:FindFirstChildWhichIsA("TouchTransmitter", true)
                            if touch then
                                firetouchinterest(hrp, touch.Parent, 0)
                                firetouchinterest(hrp, touch.Parent, 1)
                            end
                        end
                    end
                end
            end
            if not found then
                InfoLabel.Text = "Плоды не найдены в этом саду."
            end
        else
            InfoLabel.Text = "Сад игрока '" .. targetName .. "' не найден."
        end
    end
end

ToggleBtn.MouseButton1Click:Connect(function()
    stealing = not stealing
    if stealing then
        ToggleBtn.Text = "STOP STEAL"
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(40, 180, 40)
        InfoLabel.Text = "Поиск плодов..."
        task.spawn(startLoop)
    else
        ToggleBtn.Text = "START STEAL"
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
        InfoLabel.Text = "Сбор урожая остановлен."
    end
end)
