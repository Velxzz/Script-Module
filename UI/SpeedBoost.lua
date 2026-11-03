_G.UIElements = {}
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local oldGui = LocalPlayer:WaitForChild("PlayerGui"):FindFirstChild("BoostSystemGui")
if oldGui then oldGui:Destroy() end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BoostSystemGui"
ScreenGui.ResetOnSpawn = false
ScreenGui.DisplayOrder = 9
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
_G.UIElements.ScreenGui = ScreenGui

local MenuShortcut = Instance.new("ImageButton", ScreenGui)
MenuShortcut.Name = "MenuShortcut"
MenuShortcut.Size = UDim2.new(0, 45, 0, 45)
MenuShortcut.Position = UDim2.new(0, 15, 0, 15)
MenuShortcut.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MenuShortcut.BackgroundTransparency = 0.3
MenuShortcut.Image = "rbxassetid://130705104438925"
MenuShortcut.Active = true
MenuShortcut.Draggable = true
Instance.new("UICorner", MenuShortcut).CornerRadius = UDim.new(0, 12)
_G.UIElements.MenuShortcut = MenuShortcut

local MenuStroke = Instance.new("UIStroke", MenuShortcut)
MenuStroke.Thickness = 1.2
MenuStroke.Transparency = 0

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 220, 0, 310)
MainFrame.Position = UDim2.new(0, 15, 0, 70)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
MainFrame.BackgroundTransparency = 0.3
MainFrame.Visible = true
MainFrame.Active = true
MainFrame.Draggable = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 14)
_G.UIElements.MainFrame = MainFrame

local FrameStroke = Instance.new("UIStroke", MainFrame)
FrameStroke.Thickness = 1.5
FrameStroke.Transparency = 0

RunService.RenderStepped:Connect(function()
    local t = math.sin(tick() * 2) * 0.5 + 0.5
    local cosmicPurple = Color3.fromRGB(138, 43, 226)
    local cosmicCyan = Color3.fromRGB(0, 255, 220)
    local animatedColor = cosmicPurple:Lerp(cosmicCyan, t)
    FrameStroke.Color = animatedColor
    MenuStroke.Color = animatedColor
end)

local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 0, 28)
Title.Position = UDim2.new(0, 0, 0, 4)
Title.BackgroundTransparency = 1
Title.Text = "BOOST V5.0 PRO"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 12

RunService.RenderStepped:Connect(function()
    local hue = (tick() % 5) / 5
    Title.TextColor3 = Color3.fromHSV(hue, 1, 1)
end)

local ScrollFrame = Instance.new("ScrollingFrame", MainFrame)
ScrollFrame.Size = UDim2.new(1, -8, 1, -36)
ScrollFrame.Position = UDim2.new(0, 4, 0, 32)
ScrollFrame.BackgroundTransparency = 1
ScrollFrame.BorderSizePixel = 0
ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 470)
ScrollFrame.ScrollBarThickness = 3

local function createToggle(name, yPos)
    local Label = Instance.new("TextLabel", ScrollFrame)
    Label.Size = UDim2.new(0, 130, 0, 24)
    Label.Position = UDim2.new(0, 5, 0, yPos)
    Label.BackgroundTransparency = 1
    Label.Text = name
    Label.TextColor3 = Color3.fromRGB(220, 220, 220)
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Font = Enum.Font.GothamSemibold
    Label.TextSize = 10

    local Btn = Instance.new("TextButton", ScrollFrame)
    Btn.Size = UDim2.new(0, 60, 0, 22)
    Btn.Position = UDim2.new(0, 138, 0, yPos + 1)
    Btn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    Btn.BackgroundTransparency = 0.3
    Btn.Text = "OFF"
    Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    Btn.Font = Enum.Font.GothamBold
    Btn.TextSize = 10
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 5)
    return Btn
end

local function createConfigRow(name, defaultVal1, defaultVal2, yPos, isDouble)
    local Label = Instance.new("TextLabel", ScrollFrame)
    Label.Size = UDim2.new(0, 130, 0, 24)
    Label.Position = UDim2.new(0, 5, 0, yPos)
    Label.BackgroundTransparency = 1
    Label.Text = name
    Label.TextColor3 = Color3.fromRGB(200, 200, 200)
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Font = Enum.Font.GothamSemibold
    Label.TextSize = 9

    if not isDouble then
        local Box = Instance.new("TextBox", ScrollFrame)
        Box.Size = UDim2.new(0, 60, 0, 22)
        Box.Position = UDim2.new(0, 138, 0, yPos + 1)
        Box.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
        Box.TextColor3 = Color3.fromRGB(255, 255, 255)
        Box.Text = tostring(defaultVal1)
        Box.Font = Enum.Font.GothamBold
        Box.TextSize = 9
        Instance.new("UICorner", Box).CornerRadius = UDim.new(0, 5)
        return Box
    else
        local Box1 = Instance.new("TextBox", ScrollFrame)
        Box1.Size = UDim2.new(0, 28, 0, 22)
        Box1.Position = UDim2.new(0, 138, 0, yPos + 1)
        Box1.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
        Box1.TextColor3 = Color3.fromRGB(255, 255, 255)
        Box1.Text = tostring(defaultVal1)
        Box1.Font = Enum.Font.GothamBold
        Box1.TextSize = 8
        Instance.new("UICorner", Box1).CornerRadius = UDim.new(0, 5)

        local Box2 = Instance.new("TextBox", ScrollFrame)
        Box2.Size = UDim2.new(0, 28, 0, 22)
        Box2.Position = UDim2.new(0, 170, 0, yPos + 1)
        Box2.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
        Box2.TextColor3 = Color3.fromRGB(255, 255, 255)
        Box2.Text = tostring(defaultVal2)
        Box2.Font = Enum.Font.GothamBold
        Box2.TextSize = 8
        Instance.new("UICorner", Box2).CornerRadius = UDim.new(0, 5)
        return Box1, Box2
    end
end

local function createFeatureBtn(name, btnText, yPos, color)
    local Lbl = Instance.new("TextLabel", ScrollFrame)
    Lbl.Size = UDim2.new(0, 130, 0, 24)
    Lbl.Position = UDim2.new(0, 5, 0, yPos)
    Lbl.BackgroundTransparency = 1
    Lbl.Text = name
    Lbl.TextColor3 = Color3.fromRGB(200, 200, 200)
    Lbl.TextXAlignment = Enum.TextXAlignment.Left
    Lbl.Font = Enum.Font.GothamSemibold
    Lbl.TextSize = 10

    local Btn = Instance.new("TextButton", ScrollFrame)
    Btn.Size = UDim2.new(0, 60, 0, 22)
    Btn.Position = UDim2.new(0, 138, 0, yPos + 1)
    Btn.BackgroundColor3 = color or Color3.fromRGB(0, 170, 255)
    Btn.BackgroundTransparency = 0.3
    Btn.Text = btnText or "EXEC"
    Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    Btn.Font = Enum.Font.GothamBold
    Btn.TextSize = 9
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 5)
    return Btn
end

_G.UIElements.ActiveFeaturesBtn = createToggle("Active Features:", 5)
_G.UIElements.FastToggleBtn = createToggle("Fast boost :", 32)
_G.UIElements.FastSpeedBox = createConfigRow("Fast Spd:", 100, nil, 58, false)
_G.UIElements.SmoothToggleBtn = createToggle("Smooth boost :", 85)
_G.UIElements.SmoothBox1, _G.UIElements.SmoothBox2 = createConfigRow("Smooth Bst:", 3.5, 0.03, 111, true)
_G.UIElements.SmoothReverseToggleBtn = createToggle("Smooth brake :", 138)
_G.UIElements.BrakeBox1, _G.UIElements.BrakeBox2 = createConfigRow("Brake Brk:", 4, 0.0225, 164, true)

_G.UIElements.CarLabel = (function()
    local lbl = Instance.new("TextLabel", ScrollFrame)
    lbl.Size = UDim2.new(0, 190, 0, 20)
    lbl.Position = UDim2.new(0, 5, 0, 191)
    lbl.BackgroundTransparency = 1
    lbl.Text = "Car: None"
    lbl.TextColor3 = Color3.fromRGB(0, 255, 220)
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Font = Enum.Font.GothamBold
    lbl.TextSize = 9
    return lbl
end)()

_G.UIElements.MaxFrictionBtn = createFeatureBtn("Max Friction:", "EXEC", 215, Color3.fromRGB(0, 170, 255))
_G.UIElements.ResetFrictionBtn = createFeatureBtn("Reset Friction:", "RESET", 242, Color3.fromRGB(255, 120, 0))
_G.UIElements.RemoveWheelieBtn = createFeatureBtn("Del Wheelie Data:", "EXEC", 269, Color3.fromRGB(0, 170, 255))
_G.UIElements.GripToggleBtn = createToggle("Toggle Grip :", 296)
_G.UIElements.LockToggleBtn = createToggle("Lock button :", 323)
_G.UIElements.GiveBtn = createFeatureBtn("Teleport Tool:", "EXEC", 350, Color3.fromRGB(0, 170, 255))
_G.UIElements.FlyBtn = createFeatureBtn("Fly GUI:", "EXEC", 377, Color3.fromRGB(0, 170, 255))

_G.UIElements.FastFloatBtn = (function()
    local btn = Instance.new("TextButton", ScreenGui)
    btn.Size = UDim2.new(0, 50, 0, 50)
    btn.Position = UDim2.new(1, -245, 1, -270)
    btn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    btn.BackgroundTransparency = 0.4
    btn.Text = "🚀"
    btn.TextSize = 20
    btn.Visible = false
    btn.Active = true
    btn.Draggable = true
    Instance.new("UICorner", btn).CornerRadius = UDim.new(1, 0)
    return btn
end)()

_G.UIElements.SmoothFloatBtn = (function()
    local btn = Instance.new("TextButton", ScreenGui)
    btn.Size = UDim2.new(0, 50, 0, 50)
    btn.Position = UDim2.new(1, -220, 1, -195)
    btn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    btn.BackgroundTransparency = 0.4
    btn.Text = "⚡"
    btn.TextSize = 20
    btn.Visible = false
    btn.Active = true
    btn.Draggable = true
    Instance.new("UICorner", btn).CornerRadius = UDim.new(1, 0)
    return btn
end)()

_G.UIElements.SmoothReverseFloatBtn = (function()
    local btn = Instance.new("TextButton", ScreenGui)
    btn.Size = UDim2.new(0, 50, 0, 50)
    btn.Position = UDim2.new(1, -220, 1, -120)
    btn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    btn.BackgroundTransparency = 0.4
    btn.Text = "🛑"
    btn.TextSize = 20
    btn.Visible = false
    btn.Active = true
    btn.Draggable = true
    Instance.new("UICorner", btn).CornerRadius = UDim.new(1, 0)
    return btn
end)()

_G.UIElements.ActiveFeaturesBtn.Text = "ON"
_G.UIElements.ActiveFeaturesBtn.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
