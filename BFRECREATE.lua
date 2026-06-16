local KavoLib = loadstring(game:HttpGet("https://githubusercontent.com"))()
local Window = KavoLib.CreateLib("Fruit Hub | Delta Mobile", "BloodTheme")

local players = game:GetService("Players")
local player = players.LocalPlayer
local runService = game:GetService("RunService")
local workspace = game:GetService("Workspace")

local flySpeed = 50
local flying = false
local espEnabled = true
local bodyVelocity, bodyGyro

local MainTab = Window:NewTab("Функции")
local MainSection = MainTab:NewSection("Основные читы")

MainSection:NewToggle("Безопасный Полет (Fly)", "Позволяет летать туда, куда смотрит камера", function(state)
    flying = state
    local character = player.Character
    local root = character and character:FindFirstChild("HumanoidRootPart")
    
    if flying and root then
        bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.MaxForce = Vector3.new(1e6, 1e6, 1e6)
        bodyVelocity.Velocity = Vector3.new(0, 0, 0)
        bodyVelocity.Parent = root

        bodyGyro = Instance.new("BodyGyro")
        bodyGyro.MaxTorque = Vector3.new(1e6, 1e6, 1e6)
        bodyGyro.CFrame = root.CFrame
        bodyGyro.Parent = root

        task.spawn(function()
            while flying and root and root.Parent do
                local camera = workspace.CurrentCamera
                local moveDirection = camera.CFrame.LookVector
                if character:FindFirstChildOfClass("Humanoid").MoveDirection.Magnitude > 0 then
                    bodyVelocity.Velocity = moveDirection * flySpeed
                else
                    bodyVelocity.Velocity = Vector3.new(0, 0.1, 0)
                end
                bodyGyro.CFrame = camera.CFrame
                runService.RenderStepped:Wait()
            end
        end)
    else
        if bodyVelocity then bodyVelocity:Destroy() end
        if bodyGyro then bodyGyro:Destroy() end
    end
end)

local function createFruitESP(object)
    if string.find(object.Name, "Fruit") or object:FindFirstChild("Fruit") or string.find(object.Name, "Physical") then
        local handle = object:FindFirstChild("Handle") or object:WaitForChild("Handle", 5)
        if not handle then return end

        local billboard = Instance.new("BillboardGui")
        billboard.Size = UDim2.new(0, 100, 0, 40)
        billboard.AlwaysOnTop = true
        billboard.Adornee = handle
        billboard.Name = "FruitESP"
        billboard.Parent = player:WaitForChild("PlayerGui")

        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1, 0, 1, 0)
        label.BackgroundTransparency = 1
        label.TextColor3 = Color3.fromRGB(255, 0, 120)
        label.TextSize = 14
        label.Font = Enum.Font.GothamBold
        label.Parent = billboard

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

MainSection:NewToggle("ESP на Фрукты (Notifier)", "Подсвечивает фрукты сквозь стены", function(state)
    espEnabled = state
    if espEnabled then
        for _, child in pairs(workspace:GetChildren()) do createFruitESP(child) end
    else
        for _, v in pairs(player.PlayerGui:GetChildren()) do
            if v.Name == "FruitESP" then v:Destroy() end
        end
    end
end)

workspace.ChildAdded:Connect(createFruitESP)
for _, child in pairs(workspace:GetChildren()) do createFruitESP(child) end
