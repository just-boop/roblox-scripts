local X = {}
X.bone = "Head"
X.range = math.huge
X.services = {
    rep = game:GetService("ReplicatedStorage"),
    plr = game:GetService("Players"),
}
X.mod = require(X.services.rep.Modules.Utility)
X.original = X.mod.Raycast
X.cam = workspace.CurrentCamera
X.me = X.services.plr.LocalPlayer

X.mod.Raycast = function(...)
    local args = {...}
    if args[4] ~= 999 then return X.original(...) end
    local cx = X.cam.ViewportSize.X / 2
    local cy = X.cam.ViewportSize.Y / 2
    local winner, record = nil, X.range
    local pool = {}
    for _, v in workspace:GetChildren() do
        if v:FindFirstChildOfClass("Humanoid") then pool[#pool+1] = v end
        if v.Name == "HurtEffect" then
            for _, c in v:GetChildren() do
                if c.ClassName ~= "Highlight" then pool[#pool+1] = c end
            end
        end
    end
    for _, v in pool do
        if v == X.me.Character then continue end
        if not v:FindFirstChild("HumanoidRootPart") then continue end
        if not v:FindFirstChild(X.bone) then continue end
        local p, vis = X.cam:WorldToViewportPoint(v[X.bone].Position)
        if not vis then continue end
        local d = ((Vector2.new(cx, cy)) - Vector2.new(p.X, p.Y)).Magnitude
        if d < record then winner, record = v, d end
    end
    if winner and winner:FindFirstChild(X.bone) then
        args[3] = winner[X.bone].Position
    end
    return X.original(table.unpack(args))
end
