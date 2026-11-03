_G.LogicState = {}
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local UI = _G.UIElements

local isFeaturesActive = true
local isLocked = false
local isSmoothBoosting = false
local isSmoothReversing = false
local isGripActive = false

UI.MenuShortcut.MouseButton1Click:Connect(function() 
    UI.MainFrame.Visible = not UI.MainFrame.Visible 
end)

UI.ActiveFeaturesBtn.MouseButton1Click:Connect(function()
    isFeaturesActive = not isFeaturesActive
    UI.ActiveFeaturesBtn.Text = isFeaturesActive and "ON" or "OFF"
    UI.ActiveFeaturesBtn.BackgroundColor3 = isFeaturesActive and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(255, 50, 50)

    if not isFeaturesActive then
        isSmoothBoosting = false
        isSmoothReversing = false
    end
end)

UI.FastToggleBtn.MouseButton1Click:Connect(function()
    local newState = not UI.FastFloatBtn.Visible
    UI.FastFloatBtn.Visible = newState
    UI.FastToggleBtn.Text = newState and "ON" or "OFF"
    UI.FastToggleBtn.BackgroundColor3 = newState and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(255, 50, 50)
end)

UI.SmoothToggleBtn.MouseButton1Click:Connect(function()
    local newState = not UI.SmoothFloatBtn.Visible
    UI.SmoothFloatBtn.Visible = newState
    UI.SmoothToggleBtn.Text = newState and "ON" or "OFF"
    UI.SmoothToggleBtn.BackgroundColor3 = newState and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(255, 50, 50)

    if not newState then
        isSmoothBoosting = false
        UI.SmoothFloatBtn.Text = "⚡"
    end
end)

UI.SmoothReverseToggleBtn.MouseButton1Click:Connect(function()
    local newState = not UI.SmoothReverseFloatBtn.Visible
    UI.SmoothReverseFloatBtn.Visible = newState
    UI.SmoothReverseToggleBtn.Text = newState and "ON" or "OFF"
    UI.SmoothReverseToggleBtn.BackgroundColor3 = newState and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(255, 50, 50)

    if not newState then
        isSmoothReversing = false
        UI.SmoothReverseFloatBtn.Text = "🛑"
    end
end)

UI.GripToggleBtn.MouseButton1Click:Connect(function()
    isGripActive = not isGripActive
    UI.GripToggleBtn.Text = isGripActive and "ON" or "OFF"
    UI.GripToggleBtn.BackgroundColor3 = isGripActive and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(255, 50, 50)
    Workspace.Gravity = isGripActive and 250 or 196.2
end)

UI.LockToggleBtn.MouseButton1Click:Connect(function()
    isLocked = not isLocked
    UI.LockToggleBtn.Text = isLocked and "ON" or "OFF"
    UI.LockToggleBtn.BackgroundColor3 = isLocked and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(255, 50, 50)
    UI.FastFloatBtn.Draggable = not isLocked
    UI.SmoothFloatBtn.Draggable = not isLocked
    UI.SmoothReverseFloatBtn.Draggable = not isLocked
end)

UI.GiveBtn.MouseButton1Click:Connect(function()
    local t = Instance.new("Tool", LocalPlayer:WaitForChild("Backpack"))
    t.Name = "Teleport Tool"
    t.RequiresHandle = false
    t.Activated:Connect(function()
        if Mouse.Hit and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Mouse.Hit.Position + Vector3.new(0, 5, 0))
        end
    end)
end)

UI.FlyBtn.MouseButton1Click:Connect(function()
    loadstring(game:HttpGet('https://raw.githubusercontent.com/Velxzz/Velxx/refs/heads/main/Fly' .. '?t=' .. tick()))()
end)

_G.LogicState.GetFeaturesActive = function() return isFeaturesActive end
_G.LogicState.GetSmoothBoosting = function() return isSmoothBoosting end
_G.LogicState.SetSmoothBoosting = function(v) isSmoothBoosting = v end
_G.LogicState.GetSmoothReversing = function() return isSmoothReversing end
_G.LogicState.SetSmoothReversing = function(v) isSmoothReversing = v end
