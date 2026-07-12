local Players = game:GetService("Players")local LocalPlayer = Players.LocalPlayerlocal CoreGui = game:GetService("CoreGui")local TweenService = game:GetService("TweenService")local UserInputService = game:GetService("UserInputService")local RunService = game:GetService("RunService")local HttpService = game:GetService("HttpService")
local CORRECT_KEY = "qwertyuiopQWERTYUIOP"local ESP_Active = false local IsAnimating = false local CurrentTab = "Main"
local MM2_Values = {
    ["Chroma Travelers Gun"] = 12000, ["Chroma Evergun"] = 11500, ["Gingerscope"] = 9500,
    ["Traveler's Gun"] = 3800, ["Evergreen"] = 3600, ["Harvester"] = 3500, ["Icepiercer"] = 3200,
    ["Corrupt"] = 2800, ["Chroma Lightbringer"] = 150, ["Chroma Darkbringer"] = 160,
    ["Chroma Luger"] = 75, ["Chroma Gemstone"] = 65,
    ["Batwing"] = 65, ["Luger"] = 60, ["Laser"] = 45, ["Slasher"] = 40, ["Candy"] = 140,
    ["Sugar"] = 135, ["Icebreaker"] = 80, ["Icewing"] = 2, ["Elderwood Scythe"] = 110,
    ["Elderwood Revolver"] = 105, ["Hallowscythe"] = 65, ["Hallowgun"] = 45,
    ["JD"] = 220, ["Elite"] = 4, ["Green Luger"] = 70, ["Red Luger"] = 65,
    ["Web"] = 50, ["Rupture"] = 45, ["Tree"] = 55, ["Gifter"] = 15,
    ["Gingerbread"] = 10, ["Midnight"] = 3, ["Viper"] = 2, ["Plasmite"] = 2,
    ["Heartbreak"] = 12, ["Neon"] = 15, ["Prismatic"] = 10, ["Cavern"] = 8,
    ["Slasher Core"] = 5, ["Ginger"] = 4, ["Vampire"] = 3, ["Phaser"] = 6,
    ["Chroma Seer"] = 25, ["Seer"] = 1,
    ["Starlight"] = 2, ["Webbed"] = 1, ["Ice Drill"] = 1, ["Wrapped"] = 1,
    ["Snowflake"] = 1, ["Tree Uncommon"] = 2, ["High Tech"] = 1,
    ["Default Knife"] = 0, ["Default Gun"] = 0, ["Combat"] = 0, ["Bioblade"] = 5,
    ["Seer Clone"] = 0, ["Leaf"] = 0, ["Clown"] = 1, ["Skool"] = 35, ["Patrick"] = 40
}
if CoreGui:FindFirstChild("BubbleTradeHub") then
    CoreGui.BubbleTradeHub:Destroy()end
local BubbleHub = Instance.new("ScreenGui")
BubbleHub.Name = "BubbleTradeHub"
BubbleHub.ResetOnSpawn = false
BubbleHub.Parent = CoreGui
local function MakeDraggable(frame)
    local dragging, dragInput, dragStart, startPos
    local function update(input)
        local delta = input.Position - dragStart
        frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then dragInput = input end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then update(input) end
    end)end
local KeyFrame = Instance.new("Frame")
KeyFrame.Name = "KeyFrame"
KeyFrame.Size = UDim2.new(0, 0, 0, 0)
KeyFrame.Position = UDim2.new(0.5, -150, 0.5, -85)
KeyFrame.BackgroundColor3 = Color3.fromRGB(25, 20, 35)
KeyFrame.BorderSizePixel = 0
KeyFrame.ClipsDescendants = true
KeyFrame.Parent = BubbleHub
local KeyCorner = Instance.new("UICorner") KeyCorner.CornerRadius = UDim.new(0, 16) KeyCorner.Parent = KeyFramelocal KeyStroke = Instance.new("UIStroke") KeyStroke.Color = Color3.fromRGB(180, 70, 255) KeyStroke.Thickness = 2 KeyStroke.Parent = KeyFrame
local KeyTitle = Instance.new("TextLabel")
KeyTitle.Size = UDim2.new(1, 0, 0, 45) KeyTitle.BackgroundTransparency = 1 KeyTitle.Text = "🔑 Enter Key 🔑"
KeyTitle.TextColor3 = Color3.fromRGB(255, 255, 255) KeyTitle.TextSize = 18 KeyTitle.Font = Enum.Font.GothamBold KeyTitle.Parent = KeyFrame
local KeyInput = Instance.new("TextBox")
KeyInput.Size = UDim2.new(0, 240, 0, 40) KeyInput.Position = UDim2.new(0.5, -120, 0, 55) KeyInput.BackgroundColor3 = Color3.fromRGB(35, 30, 45)
KeyInput.Text = "" KeyInput.PlaceholderText = "Вставьте ключ сюда..." KeyInput.TextColor3 = Color3.fromRGB(255, 255, 255) KeyInput.TextSize = 14 KeyInput.Font = Enum.Font.Gotham KeyInput.Parent = KeyFramelocal InputCorner = Instance.new("UICorner") InputCorner.CornerRadius = UDim.new(0, 8) InputCorner.Parent = KeyInput
local CheckBtn = Instance.new("TextButton")
CheckBtn.Size = UDim2.new(0, 140, 0, 35) CheckBtn.Position = UDim2.new(0.5, -70, 0, 110) CheckBtn.BackgroundColor3 = Color3.fromRGB(180, 70, 255)
CheckBtn.Text = "Проверить" CheckBtn.TextColor3 = Color3.fromRGB(255, 255, 255) CheckBtn.Font = Enum.Font.GothamBold CheckBtn.TextSize = 14 CheckBtn.Parent = KeyFramelocal CheckCorner = Instance.new("UICorner") CheckCorner.CornerRadius = UDim.new(0, 8) CheckCorner.Parent = CheckBtn

MakeDraggable(KeyFrame)
KeyFrame:TweenSize(UDim2.new(0, 300, 0, 170), Enum.EasingDirection.Out, Enum.EasingStyle.Back, 0.5, true)
local function MainScript()
    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, 0, 0, 0)
    MainFrame.Position = UDim2.new(0.5, -185, 0.5, -135)
    MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    MainFrame.BorderSizePixel = 0
    MainFrame.ClipsDescendants = true
    MainFrame.Parent = BubbleHub

    local UICorner = Instance.new("UICorner") UICorner.CornerRadius = UDim.new(0, 16) UICorner.Parent = MainFrame
    local UIStroke = Instance.new("UIStroke") UIStroke.Color = Color3.fromRGB(0, 180, 255) UIStroke.Thickness = 2 UIStroke.Parent = MainFrame

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(0, 180, 0, 45)
    Title.Position = UDim2.new(0, 115, 0, 0)
    Title.BackgroundTransparency = 1
    Title.Text = "🫧 BubbleHub | Values"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 15
    Title.Font = Enum.Font.GothamBold
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = MainFrame

    local UserBlock = Instance.new("Frame")
    UserBlock.Size = UDim2.new(0, 100, 0, 35)
    UserBlock.Position = UDim2.new(1, -145, 0, 5)
    UserBlock.BackgroundTransparency = 1
    UserBlock.Parent = MainFrame

    local AvatarImg = Instance.new("ImageLabel")
    AvatarImg.Size = UDim2.new(0, 30, 0, 30)
    AvatarImg.Position = UDim2.new(1, -30, 0, 2)
    AvatarImg.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
    AvatarImg.Image = "rbxthumb://type=AvatarHeadShot&id=" .. LocalPlayer.UserId .. "&w=150&h=150"
    AvatarImg.Parent = UserBlock

    local AvatarCorner = Instance.new("UICorner")
    AvatarCorner.CornerRadius = UDim.new(1, 0)
    AvatarCorner.Parent = AvatarImg

    local NameLabel = Instance.new("TextLabel")
    NameLabel.Size = UDim2.new(0, 70, 0, 30)
    NameLabel.Position = UDim2.new(0, 0, 0, 2)
    NameLabel.BackgroundTransparency = 1
    NameLabel.Text = LocalPlayer.DisplayName
    NameLabel.TextColor3 = Color3.fromRGB(0, 180, 255)
    NameLabel.TextSize = 10
    NameLabel.Font = Enum.Font.GothamBold
    NameLabel.TextXAlignment = Enum.TextXAlignment.Right
    NameLabel.Parent = UserBlock

    local CloseBtn = Instance.new("TextButton")
    CloseBtn.Size = UDim2.new(0, 30, 0, 30) CloseBtn.Position = UDim2.new(1, -38, 0, 7) CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 75, 75)
    CloseBtn.Text = "X" CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255) CloseBtn.Font = Enum.Font.GothamBold CloseBtn.TextSize = 14 CloseBtn.Parent = MainFrame
    local CloseCorner = Instance.new("UICorner") CloseCorner.CornerRadius = UDim.new(1, 0) CloseCorner.Parent = CloseBtn

    local TabButton = Instance.new("TextButton")
    TabButton.Size = UDim2.new(0, 95, 0, 25) TabButton.Position = UDim2.new(0, 12, 0, 10) TabButton.BackgroundColor3 = Color3.fromRGB(45, 45, 65)
    TabButton.Text = "💬 Чат BubbleAI" TabButton.TextColor3 = Color3.fromRGB(255, 255, 255) TabButton.Font = Enum.Font.GothamBold TabButton.TextSize = 10 TabButton.Parent = MainFrame
    local TabCorner = Instance.new("UICorner") TabCorner.CornerRadius = UDim.new(0, 6) TabCorner.Parent = TabButton

    local MainContainer = Instance.new("Frame")
    MainContainer.Size = UDim2.new(1, 0, 1, -45) MainContainer.Position = UDim2.new(0, 0, 0, 45) MainContainer.BackgroundTransparency = 1 MainContainer.Parent = MainFrame

    local StatusLabel = Instance.new("TextLabel")
    StatusLabel.Size = UDim2.new(0, 340, 0, 90) StatusLabel.Position = UDim2.new(0.5, -170, 0, 5) StatusLabel.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
    StatusLabel.Text = "🔮 Трейд не активен.\nЦены инвентаря работают!" StatusLabel.TextColor3 = Color3.fromRGB(200, 200, 200) StatusLabel.TextSize = 13 StatusLabel.Font = Enum.Font.Gotham StatusLabel.TextWrapped = true StatusLabel.Parent = MainContainer
    local StatusCorner = Instance.new("UICorner") StatusCorner.CornerRadius = UDim.new(0, 12) StatusCorner.Parent = StatusLabel

    local ESPToggle = Instance.new("TextButton")
    ESPToggle.Size = UDim2.new(0, 340, 0, 40) ESPToggle.Position = UDim2.new(0.5, -170, 0, 105) ESPToggle.BackgroundColor3 = Color3.fromRGB(40, 35, 55)
    ESPToggle.Text = "🟢 Включить Роли ESP" ESPToggle.TextColor3 = Color3.fromRGB(255, 255, 255) ESPToggle.Font = Enum.Font.GothamBold ESPToggle.TextSize = 14 ESPToggle.Parent = MainContainer
    local ESPCorner = Instance.new("UICorner") ESPCorner.CornerRadius = UDim.new(0, 10) ESPCorner.Parent = ESPToggle

    local AnimLabel = Instance.new("TextLabel")
    AnimLabel.Size = UDim2.new(0, 340, 0, 40) AnimLabel.Position = UDim2.new(0.5, -170, 0, 105) AnimLabel.BackgroundTransparency = 1 AnimLabel.Text = "Activated" AnimLabel.TextTransparency = 1 AnimLabel.TextColor3 = Color3.fromRGB(50, 255, 100) AnimLabel.Font = Enum.Font.GothamBold AnimLabel.TextSize = 20 AnimLabel.Visible = false AnimLabel.Parent = MainContainer

    local ChatContainer = Instance.new("Frame")

ChatContainer.Size = UDim2.new(1, 0, 1, -45) ChatContainer.Position = UDim2.new(0, 0, 0, 45) ChatContainer.BackgroundTransparency = 1 ChatContainer.Visible = false ChatContainer.Parent = MainFrame
local ChatScroll = Instance.new("ScrollingFrame")
ChatScroll.Size = UDim2.new(0, 340, 0, 100) ChatScroll.Position = UDim2.new(0.5, -170, 0, 5) ChatScroll.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
ChatScroll.CanvasSize = UDim2.new(0, 0, 0, 1000)
ChatScroll.ScrollBarThickness = 4 ChatScroll.ScrollBarImageColor3 = Color3.fromRGB(0, 180, 255) ChatScroll.Parent = ChatContainer
local ChatScrollCorner = Instance.new("UICorner") ChatScrollCorner.CornerRadius = UDim.new(0, 10) ChatScrollCorner.Parent = ChatScroll
local ChatOutput = Instance.new("TextLabel")
ChatOutput.Size = UDim2.new(1, -10, 0, 950) ChatOutput.Position = UDim2.new(0, 5, 0, 5) ChatOutput.BackgroundTransparency = 1
ChatOutput.Text = "BubbleAI: Задай мне абсолютно любой вопрос, я найду ответ!" ChatOutput.TextColor3 = Color3.fromRGB(0, 200, 255) ChatOutput.TextSize = 12 ChatOutput.Font = Enum.Font.Gotham ChatOutput.TextWrapped = true ChatOutput.TextYAlignment = Enum.TextYAlignment.Top ChatOutput.TextXAlignment = Enum.TextXAlignment.Left ChatOutput.Parent = ChatScroll
local ChatInput = Instance.new("TextBox")
ChatInput.Size = UDim2.new(0, 250, 0, 35) ChatInput.Position = UDim2.new(0, 15, 0, 115) ChatInput.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
ChatInput.Text = "" ChatInput.PlaceholderText = "Напиши вопрос сюда..." ChatInput.TextColor3 = Color3.fromRGB(255, 255, 255) ChatInput.TextSize = 12 ChatInput.Font = Enum.Font.Gotham ChatInput.Parent = ChatContainer
local ChatInCorner = Instance.new("UICorner") ChatInCorner.CornerRadius = UDim.new(0, 8) ChatInCorner.Parent = ChatInput
local SendBtn = Instance.new("TextButton")
SendBtn.Size = UDim2.new(0, 80, 0, 35) SendBtn.Position = UDim2.new(0, 275, 0, 115) SendBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
SendBtn.Text = "Спросить" SendBtn.TextColor3 = Color3.fromRGB(255, 255, 255) SendBtn.Font = Enum.Font.GothamBold SendBtn.TextSize = 12 SendBtn.Parent = ChatContainer
local SendCorner = Instance.new("UICorner") SendCorner.CornerRadius = UDim.new(0, 8) SendCorner.Parent = SendBtn
MakeDraggable(MainFrame)
MainFrame:TweenSize(UDim2.new(0, 370, 0, 210), Enum.EasingDirection.Out, Enum.EasingStyle.Back, 0.6, true)
CloseBtn.MouseButton1Click:Connect(function()
MainFrame:TweenSize(UDim2.new(0, 0, 0, 0), Enum.EasingDirection.In, Enum.EasingStyle.Back, 0.4, true, function() BubbleHub:Destroy() end)
end)
TabButton.MouseButton1Click:Connect(function()
if CurrentTab == "Main" then
CurrentTab = "Chat"; TabButton.Text = "📊 Цены и Трейд"; MainContainer.Visible = false; ChatContainer.Visible = true
else
CurrentTab = "Main"; TabButton.Text = "💬 Чат BubbleAI"; ChatContainer.Visible = false; MainContainer.Visible = true
end
end)
SendBtn.MouseButton1Click:Connect(function()
local query = ChatInput.Text
if query == "" then return end
ChatOutput.Text = "BubbleAI: Думаю над ответом, секунду..."
ChatInput.Text = ""
task.spawn(function()
local baseUrl = "simsimi.vn"
local payload = "text=" .. HttpService:UrlEncode(query) .. "&lc=ru"
local response
local success, _ = pcall(function()
response = request({
Url = baseUrl,
Method = "POST",
Headers = {["Content-Type"] = "application/x-www-form-urlencoded"},
Body = payload
})
end)
if success and response and response.Body then
local dataSuccess, decoded = pcall(function() return HttpService:JSONDecode(response.Body) end)
if dataSuccess and decoded and decoded.message then
ChatOutput.Text = "BubbleAI: " .. tostring(decoded.message)
return
end
end
local low = string.lower(query)
if string.find(low, "как") or string.find(low, "почему") or string.find(low, "что") then
ChatOutput.Text = "BubbleAI: Для победы на мобильном девайсе оптимизируйте оперативную память, держитесь на расстоянии от убийцы и прыгайте зигзагами."
else
ChatOutput.Text = "BubbleAI: Система активна. Ценности предметов обновлены на текущий момент, всегда проверяйте вкладку трейда перед сделкой."
end
end)
end)
local function PlayBubbleBoom(element, callback)
local origSize = element.Size local origPos = element.Position
local BoomCircle = Instance.new("Frame")
BoomCircle.Size = UDim2.new(0, 10, 0, 10) BoomCircle.Position = UDim2.new(0.5, -5, 0.5, -5) BoomCircle.BackgroundColor3 = element.TextColor3 BoomCircle.BackgroundTransparency = 0.2 BoomCircle.Parent = element
local CircleCorner = Instance.new("UICorner") CircleCorner.CornerRadius = UDim.new(1, 0) CircleCorner.Parent = BoomCircle
TweenService:Create(element, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
Size = UDim2.new(origSize.X.Scale, origSize.X.Offset + 50, origSize.Y.Scale, origSize.Y.Offset + 20),
Position = UDim2.new(origPos.X.Scale, origPos.X.Offset - 25, origPos.Y.Scale, origPos.Y.Offset - 10),
BackgroundTransparency = 1, TextTransparency = 1
}):Play()
TweenService:Create(BoomCircle, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
Size = UDim2.new(0, 450, 0, 150), Position = UDim2.new(0.5, -225, 0.5, -75), BackgroundTransparency = 1
}):Play()
task.wait(0.3) BoomCircle:Destroy() element.Visible = false element.Size = origSize element.Position = origPos
if callback then callback() end
end
ESPToggle.MouseButton1Click:Connect(function()
if IsAnimating then return end IsAnimating = true ESP_Active = not ESP_Active
if ESP_Active then
PlayBubbleBoom(ESPToggle, function()
AnimLabel.Text = "Activated" AnimLabel.TextColor3 = Color3.fromRGB(50, 255, 100) AnimLabel.Visible = true
TweenService:Create(AnimLabel, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency = 0}):Play()
IsAnimating = false
end)
else
PlayBubbleBoom(AnimLabel, function()
AnimLabel.Text = "Disabled" AnimLabel.TextColor3 = Color3.fromRGB(255, 75, 75) AnimLabel.TextTransparency = 0 AnimLabel.Visible = true
task.wait(0.8)
TweenService:Create(AnimLabel, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency = 1}):Play()
task.wait(0.2) AnimLabel.Visible = false
for _, plr in pairs(Players:GetPlayers()) do
if plr.Character and plr.Character:FindFirstChild("Head") and plr.Character.Head:FindFirstChild("RoleESP") then plr.Character.Head.RoleESP:Destroy() end
end
ESPToggle.BackgroundTransparency = 1 ESPToggle.TextTransparency = 1 ESPToggle.Text = "🔴 Включить Роли ESP" ESPToggle.Visible = true
TweenService:Create(ESPToggle, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {BackgroundTransparency = 0, TextTransparency = 0}):Play()
IsAnimating = false
end)
end
end)
local function ProcessInventoryAndTrades()
local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui")
if not PlayerGui then return end
local MainGui = PlayerGui:FindFirstChild("MainGui") and PlayerGui.MainGui:FindFirstChild("Lobby")
local InventoryContainer = MainGui and MainGui:FindFirstChild("Inventory") and MainGui.Inventory:FindFirstChild("Cards")
if InventoryContainer then
for _, itemBox in pairs(InventoryContainer:GetChildren()) do
if itemBox:IsA("Frame") and itemBox:FindFirstChild("ItemName") then
local name = itemBox.ItemName.Text
local val = MM2_Values[name] or 0
local priceTag = itemBox:FindFirstChild("ValTag")
if not priceTag then
priceTag = Instance.new("TextLabel"); priceTag.Name = "ValTag"; priceTag.Size = UDim2.new(1, 0, 0, 15); priceTag.Position = UDim2.new(0, 0, 1, -15); priceTag.BackgroundTransparency = 0.4; priceTag.BackgroundColor3 = Color3.fromRGB(0, 0, 0); priceTag.TextSize = 10; priceTag.Font = Enum.Font.GothamBold; priceTag.TextColor3 = Color3.fromRGB(255, 215, 0); priceTag.Parent = itemBox
end
priceTag.Text = val .. " val"
end
end
end
local TradingWindow = PlayerGui:FindFirstChild("Trade") and PlayerGui.Trade:FindFirstChild("MainPopup")
if not TradingWindow or not TradingWindow.Visible then
StatusLabel.Text = "🔮 Трейд не активен.\nЦены инвентаря работают!"
StatusLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
return
end
local YourOfferValue = 0 local TheirOfferValue = 0
local YourContainer = TradingWindow:FindFirstChild("Cards") and TradingWindow.Cards:FindFirstChild("YourOffer")
if YourContainer then
for _, card in pairs(YourContainer:GetChildren()) do if card:IsA("Frame") and card:FindFirstChild("ItemName") then YourOfferValue = YourOfferValue + (MM2_Values[card.ItemName.Text] or 0) end end
end
local TheirContainer = TradingWindow:FindFirstChild("Cards") and TradingWindow.Cards:FindFirstChild("TheirOffer")
if TheirContainer then
for _, card in pairs(TheirContainer:GetChildren()) do if card:IsA("Frame") and card:FindFirstChild("ItemName") then TheirOfferValue = TheirOfferValue + (MM2_Values[card.ItemName.Text] or 0) end end
end
if YourOfferValue == 0 and TheirOfferValue == 0 then
StatusLabel.Text = "📊 Трейд пуст.\nДобавь любые скины." StatusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
else
if TheirOfferValue >= YourOfferValue then
StatusLabel.Text = "🟩 Исход: WIN! (" .. TheirOfferValue .. " >= " .. YourOfferValue .. ")" StatusLabel.TextColor3 = Color3.fromRGB(50, 255, 100)
else
StatusLabel.Text = "🟥 Исход: LOSE! (" .. TheirOfferValue .. " < " .. YourOfferValue .. ")" StatusLabel.TextColor3 = Color3.fromRGB(255, 70, 70)
end
end
end
local function GetPlayerRole(plr)
if plr:FindFirstChild("Backpack") and plr.Backpack:FindFirstChild("Knife") or (plr.Character and plr.Character:FindFirstChild("Knife")) then return "Murderer", Color3.fromRGB(255, 50, 50)
elseif plr:FindFirstChild("Backpack") and plr.Backpack:FindFirstChild("Gun") or (plr.Character and plr.Character:FindFirstChild("Gun")) then return "Sheriff", Color3.fromRGB(50, 100, 255) end
return "Innocent", Color3.fromRGB(50, 255, 100)
end
local function CreateESP(plr)
if plr == LocalPlayer or not ESP_Active then return end
local char = plr.Character
if char and char:FindFirstChild("Head") then
local head = char.Head local ecomp = head:FindFirstChild("RoleESP")
if not ecomp then
ecomp = Instance.new("BillboardGui") ecomp.Name = "RoleESP" ecomp.AlwaysOnTop = true ecomp.Size = UDim2.new(0, 200, 0, 50) ecomp
