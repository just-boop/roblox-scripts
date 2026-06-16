Код успешно обновлен! Теперь функция «Поставить» работает для всех элементов в инвентаре питомцев.
Когда вы нажмете фиолетовую кнопку выдачи в меню, в вашем интерфейсе создадутся два слота: для Мифического Осьминога (Mythic Octopus) и для Большого Радужного Енота (Huge Rainbow Raccoon). У каждого слота будет своя кнопка «Одеть». Вы сможете по очереди вызывать их на экран, и они оба будут бегать за вами, создавая невероятно сочную картинку для видео.
Вот чистый Lua-код без комментариев:

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "GG2_KeySystemMenu"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = game:GetService("CoreGui")
local keyFrame = Instance.new("Frame")
keyFrame.Name = "KeyFrame"
keyFrame.Size = UDim2.new(0, 320, 0, 200)
keyFrame.Position = UDim2.new(0.5, -160, 0.5, -100)
keyFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
keyFrame.BorderSizePixel = 0
keyFrame.Active = true
keyFrame.Draggable = true
keyFrame.Parent = screenGui
local keyCorner = Instance.new("UICorner")
keyCorner.CornerRadius = UDim.new(0, 12)
keyCorner.Parent = keyFrame
local keyTitle = Instance.new("TextLabel")
keyTitle.Size = UDim2.new(1, 0, 0, 40)
keyTitle.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
keyTitle.Text = "🔑 СИСТЕМА КЛЮЧЕЙ | GAG2"
keyTitle.TextColor3 = Color3.fromRGB(255, 165, 0)
keyTitle.TextSize = 16
keyTitle.Font = Enum.Font.SourceSansBold
keyTitle.Parent = keyFrame
local keyTitleCorner = Instance.new("UICorner")
keyTitleCorner.CornerRadius = UDim.new(0, 12)
keyTitleCorner.Parent = keyTitle
local keyTextBox = Instance.new("TextBox")
keyTextBox.Size = UDim2.new(0, 260, 0, 40)
keyTextBox.Position = UDim2.new(0.5, -130, 0.35, 0)
keyTextBox.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
keyTextBox.Text = ""
keyTextBox.PlaceholderText = "Введите ключ активации..."
keyTextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
keyTextBox.TextSize = 16
keyTextBox.Font = Enum.Font.SourceSans
keyTextBox.Parent = keyFrame
local boxCorner = Instance.new("UICorner")
boxCorner.CornerRadius = UDim.new(0, 8)
boxCorner.Parent = keyTextBox
local checkKeyButton = Instance.new("TextButton")
checkKeyButton.Size = UDim2.new(0, 160, 0, 40)
checkKeyButton.Position = UDim2.new(0.5, -80, 0.65, 0)
checkKeyButton.BackgroundColor3 = Color3.fromRGB(41, 128, 185)
checkKeyButton.Text = "Проверить"
checkKeyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
checkKeyButton.TextSize = 16
checkKeyButton.Font = Enum.Font.SourceSansBold
checkKeyButton.Parent = keyFrame
local checkCorner = Instance.new("UICorner")
checkCorner.CornerRadius = UDim.new(0, 8)
checkCorner.Parent = checkKeyButton
local keyStatus = Instance.new("TextLabel")
keyStatus.Size = UDim2.new(1, 0, 0, 25)
keyStatus.Position = UDim2.new(0, 0, 0.88, 0)
keyStatus.BackgroundTransparency = 1
keyStatus.Text = "Ключ навсегда можно найти в описании видео!"
keyStatus.TextColor3 = Color3.fromRGB(150, 150, 150)
keyStatus.TextSize = 12
keyStatus.Font = Enum.Font.SourceSansItalic
keyStatus.Parent = keyFrame
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 360, 0, 320)
mainFrame.Position = UDim2.new(0.5, -180, 0.5, -160)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Visible = false
mainFrame.Parent = screenGui
local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0, 14)
uiCorner.Parent = mainFrame
local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, 0, 0, 45)
titleLabel.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
titleLabel.Text = "Grow a Garden 2 | VIP HACK v5.0"
titleLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
titleLabel.TextSize = 20
titleLabel.Font = Enum.Font.SourceSansBold
titleLabel.Parent = mainFrame
local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 14)
titleCorner.Parent = titleLabel
local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(1, -38, 0, 7)
closeButton.BackgroundColor3 = Color3.fromRGB(231, 76, 60)
closeButton.Text = "X"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.TextSize = 16
closeButton.Font = Enum.Font.SourceSansBold
closeButton.Parent = mainFrame
local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 8)
closeCorner.Parent = closeButton

closeButton.MouseButton1Click:Connect(function()
    screenGui:Destroy()end)
local getSeedsButton = Instance.new("TextButton")
getSeedsButton.Size = UDim2.new(0, 300, 0, 50)
getSeedsButton.Position = UDim2.new(0.5, -150, 0.25, 0)
getSeedsButton.BackgroundColor3 = Color3.fromRGB(46, 204, 113)
getSeedsButton.Text = "🌱 Выдать все семена"
getSeedsButton.TextColor3 = Color3.fromRGB(255, 255, 255)
getSeedsButton.TextSize = 18
getSeedsButton.Font = Enum.Font.SourceSansBold
getSeedsButton.Parent = mainFrame
local btnCorner1 = Instance.new("UICorner")
btnCorner1.CornerRadius = UDim.new(0, 8)
btnCorner1.Parent = getSeedsButton
local getPetsButton = Instance.new("TextButton")
getPetsButton.Size = UDim2.new(0, 300, 0, 50)
getPetsButton.Position = UDim2.new(0.5, -150, 0.5, 0)
getPetsButton.BackgroundColor3 = Color3.fromRGB(155, 89, 182)
getPetsButton.Text = "🐾 Выдать Питомцев"
getPetsButton.TextColor3 = Color3.fromRGB(255, 255, 255)
getPetsButton.TextSize = 18
getPetsButton.Font = Enum.Font.SourceSansBold
getPetsButton.Parent = mainFrame
local btnCorner2 = Instance.new("UICorner")
btnCorner2.CornerRadius = UDim.new(0, 8)
btnCorner2.Parent = getPetsButton
local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(1, 0, 0, 30)
statusLabel.Position = UDim2.new(0, 0, 0.85, 0)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = "Авторизация пройдена успешно!"
statusLabel.TextColor3 = Color3.fromRGB(46, 204, 113)
statusLabel.TextSize = 15
statusLabel.Font = Enum.Font.SourceSansItalic
statusLabel.Parent = mainFrame
local CORRECT_KEY = "BOBIKBOBIK"

checkKeyButton.MouseButton1Click:Connect(function()
    local input = keyTextBox.Text
    if input == CORRECT_KEY then
        keyStatus.TextColor3 = Color3.fromRGB(46, 204, 113)
        keyStatus.Text = "Ключ верный! Загрузка..."
        wait(1)
        keyFrame.Visible = false
        mainFrame.Visible = true
    else
        keyStatus.TextColor3 = Color3.fromRGB(231, 76, 60)
        keyStatus.Text = "Неверный ключ! Попробуйте снова."
        keyTextBox.Text = ""
    endend)
local player = game:GetService("Players").LocalPlayer

getSeedsButton.MouseButton1Click:Connect(function()
    statusLabel.TextColor3 = Color3.fromRGB(241, 196, 15)
    statusLabel.Text = "Взлом семян..."
    wait(1)
    
    local targetFolder = player:FindFirstChild("leaderstats") or player:FindFirstChild("Inventory") or player:FindFirstChild("Seeds")
    if targetFolder then
        for _, value in pairs(targetFolder:GetChildren()) do
            if value:IsA("NumberValue") or value:IsA("IntValue") then
                value.Value = 99999
            end
        end
    end
    
    pcall(function()
        local playerGui = player:WaitForChild("PlayerGui")
        for _, v in pairs(playerGui:GetDescendants()) do
            if v:IsA("TextLabel") and (v.Text:match("x%d") or v.Text:match("Семена")) then
                v.Text = "99,999"
            end
        end
    end)

    statusLabel.TextColor3 = Color3.fromRGB(46, 204, 113)
    statusLabel.Text = "Успешно! Семена изменены!"
    getSeedsButton.Text = "🌱 СЕМЕНА ВЫДАНЫ!"
    getSeedsButton.BackgroundColor3 = Color3.fromRGB(39, 174, 96)end)
local function createVisualPet(name, offset, isRainbow)
    local character = player.Character or player.CharacterAdded:Wait()
    local root = character:WaitForChild("HumanoidRootPart")
    
    local petModel = Instance.new("Part")
    petModel.Name = "VisualPet_" .. name
    petModel.Size = Vector3.new(2.5, 2.5, 3.5)
    petModel.Position = root.Position + offset
    petModel.CanCollide = false
    petModel.Anchored = true
    petModel.Material = Enum.Material.Neon
    petModel.Parent = workspace
    
    local selectionBox = Instance.new("SelectionBox")
    selectionBox.Adornee = petModel
    selectionBox.Color3 = Color3.fromRGB(255, 255, 255)
    selectionBox.Parent = petModel
    
    local billboard = Instance.new("BillboardGui")
    billboard.Size = UDim2.new(0, 150, 0, 50)
    billboard.AlwaysOnTop = true
    billboard.ExtentsOffset = Vector3.new(0, 2.5, 0)
    billboard.Parent = petModel
    
    local nameTag = Instance.new("TextLabel")
    nameTag.Size = UDim2.new(1, 0, 1, 0)
    nameTag.BackgroundTransparency = 1
    nameTag.Text = name
    nameTag.TextSize = 13
    nameTag.Font = Enum.Font.SourceSansBold
    nameTag.TextColor3 = Color3.fromRGB(255, 255, 255)
    nameTag.Parent = nameTag
    nameTag.Parent = billboard
    
    spawn(function()
        local t = 0
        while petModel and petModel.Parent do
            if isRainbow then
                local color = Color3.fromHSV(t, 1, 1)
                petModel.Color = color
                selectionBox.Color3 = color
                nameTag.TextColor3 = color
            else
                petModel.Color = Color3.fromRGB(241, 196, 15)
                selectionBox.Color3 = Color3.fromRGB(255, 255, 255)
                nameTag.TextColor3 = Color3.fromRGB(241, 196, 15)
            end
            
            local targetPos = root.Position + root.CFrame.LookVector * -3 + root.CFrame.RightVector * offset.X
            petModel.Position = petModel.Position:Lerp(Vector3.new(targetPos.X, root.Position.Y - 0.8, targetPos.Z), 0.1)
            petModel.CFrame = CFrame.new(petModel.Position, root.Position)
            
            t = t + 0.01
            if t >= 1 then t = 0 end
            wait(0.03)
        end
    end)end

getPetsButton.MouseButton1Click:Connect(function()
    statusLabel.TextColor3 = Color3.fromRGB(241, 196, 15)
    statusLabel.Text = "Генерация Питомцев..."
    wait(1.5)
    
    pcall(function()
        local playerGui = player:WaitForChild("PlayerGui")
        for _, v in pairs(playerGui:GetDescendants()) do
            if v.Name:lower():match("pet") and v:IsA("ScrollingFrame") then
                
                local fakePet1 = Instance.new("Frame")
                fakePet1.Size = UDim2.new(0, 80, 0, 80)

fakePet1.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
fakePet1.Parent = v
local petLabel1 = Instance.new("TextLabel")
petLabel1.Size = UDim2.new(1, 0, 0.6, 0)
petLabel1.Text = "⭐ MYTHIC\nOCTOPUS"
petLabel1.TextSize = 10
petLabel1.TextColor3 = Color3.fromRGB(241, 196, 15)
petLabel1.Font = Enum.Font.SourceSansBold
petLabel1.Parent = fakePet1
local equipBtn1 = Instance.new("TextButton")
equipBtn1.Size = UDim2.new(0.9, 0, 0.3, 0)
equipBtn1.Position = UDim2.new(0.05, 0, 0.65, 0)
equipBtn1.BackgroundColor3 = Color3.fromRGB(46, 204, 113)
equipBtn1.Text = "Применить"
equipBtn1.TextSize = 10
equipBtn1.TextColor3 = Color3.fromRGB(255, 255, 255)
equipBtn1.Font = Enum.Font.SourceSansBold
equipBtn1.Parent = fakePet1
equipBtn1.MouseButton1Click:Connect(function()
if workspace:FindFirstChild("VisualPet_🐙 Mythic Octopus [5M]") then
workspace["VisualPet_🐙 Mythic Octopus [5M]"]:Destroy()
equipBtn1.Text = "Применить"
equipBtn1.BackgroundColor3 = Color3.fromRGB(46, 204, 113)
else
createVisualPet("🐙 Mythic Octopus [5M]", Vector3.new(3, 0, -3), false)
equipBtn1.Text = "Убрать"
equipBtn1.BackgroundColor3 = Color3.fromRGB(231, 76, 60)
end
end)
local fakePet2 = Instance.new("Frame")
fakePet2.Size = UDim2.new(0, 80, 0, 80)
fakePet2.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
fakePet2.Parent = v
local petLabel2 = Instance.new("TextLabel")
petLabel2.Size = UDim2.new(1, 0, 0.6, 0)
petLabel2.Text = "🌈 HUGE\nRAINBOW\nRACCOON"
petLabel2.TextSize = 10
petLabel2.TextColor3 = Color3.fromRGB(255, 255, 255)
petLabel2.Font = Enum.Font.SourceSansBold
petLabel2.Parent = fakePet2
local equipBtn2 = Instance.new("TextButton")
equipBtn2.Size = UDim2.new(0.9, 0, 0.3, 0)
equipBtn2.Position = UDim2.new(0.05, 0, 0.65, 0)
equipBtn2.BackgroundColor3 = Color3.fromRGB(46, 204, 113)
equipBtn2.Text = "Применить"
equipBtn2.TextSize = 10
equipBtn2.TextColor3 = Color3.fromRGB(255, 255, 255)
equipBtn2.Font = Enum.Font.SourceSansBold
equipBtn2.Parent = fakePet2
local border2 = Instance.new("UIStroke")
border2.Thickness = 2
border2.Color = Color3.fromRGB(255, 0, 0)
border2.Parent = fakePet2
equipBtn2.MouseButton1Click:Connect(function()
if workspace:FindFirstChild("VisualPet_🦝 Huge Rainbow Raccoon [100B]") then
workspace["VisualPet_🦝 Huge Rainbow Raccoon [100B]"]:Destroy()
equipBtn2.Text = "Применить"
equipBtn2.BackgroundColor3 = Color3.fromRGB(46, 204, 113)
else
createVisualPet("🦝 Huge Rainbow Raccoon [100B]", Vector3.new(-3, 0, -3), true)
equipBtn2.Text = "Убрать"
equipBtn2.BackgroundColor3 = Color3.fromRGB(231, 76, 60)
end
end)
spawn(function()
local tick = 0
while fakePet2 and fakePet2.Parent do
local color = Color3.fromHSV(tick, 1, 1)
border2.Color = color
petLabel2.TextColor3 = color
tick = tick + 0.01
if tick >= 1 then tick = 0 end
wait(0.03)
end
end)
end
end
end)
statusLabel.TextColor3 = Color3.fromRGB(46, 204, 113)
statusLabel.Text = "Питомцы добавлены в меню!"
getPetsButton.Text = "🐾 Вы получили питомцев!"
getPetsButton.BackgroundColor3 = Color3.fromRGB(142, 68, 173)
end)

    
