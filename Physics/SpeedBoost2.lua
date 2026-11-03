local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local UI = _G.UIElements
local Logic = _G.LogicState

local defaultFrictionVal = nil
local defaultFrictionWeightVal = nil

local function getCurrentVehicle()
    local char = LocalPlayer.Character
    if not char then return nil, nil end

    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum then return nil, nil end

    local seat = hum.SeatPart
    if seat and (seat:IsA("VehicleSeat") or seat:IsA("Seat")) then
        local carModel = seat:FindFirstAncestorOfClass("Model")
        return seat, carModel
    end

    return nil, nil
end

local function getVehicleTargetParts(seat)
    local parts = {}
    if not seat then return parts end

    local carModel = seat:FindFirstAncestorOfClass("Model")
    if not carModel then return parts end

    local char = LocalPlayer.Character

    for _, part in ipairs(carModel:GetDescendants()) do
        if part:IsA("BasePart") then
            if not (char and part:IsDescendantOf(char)) then
                local name = part.Name:lower()
                if name:find("wheel") or name:find("roda") or part == seat then
                    table.insert(parts, part)
                end
            end
        end
    end
    return parts
end

UI.MaxFrictionBtn.MouseButton1Click:Connect(function()
    local seat = getCurrentVehicle()
    if seat then
        for _, part in ipairs(getVehicleTargetParts(seat)) do
            local prop = part.CustomPhysicalProperties or PhysicalProperties.new(part.Material)
            part.CustomPhysicalProperties = PhysicalProperties.new(
                prop.Density,
                1.5,
                prop.Elasticity,
                10,
                prop.ElasticityWeight
            )
        end
        UI.MaxFrictionBtn.Text = "APPLIED!"
        UI.MaxFrictionBtn.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
        task.wait(1.5)
        UI.MaxFrictionBtn.Text = "EXEC"
        UI.MaxFrictionBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
    end
end)

UI.ResetFrictionBtn.MouseButton1Click:Connect(function()
    local seat = getCurrentVehicle()
    if seat then
        local targetFriction = defaultFrictionVal or 0.3
        local targetFrictionWeight = defaultFrictionWeightVal or 1

        for _, part in ipairs(getVehicleTargetParts(seat)) do
            local prop = part.CustomPhysicalProperties or PhysicalProperties.new(part.Material)
            part.CustomPhysicalProperties = PhysicalProperties.new(
                prop.Density,
                targetFriction,
                prop.Elasticity,
                targetFrictionWeight,
                prop.ElasticityWeight
            )
        end
        UI.ResetFrictionBtn.Text = "RESET!"
        UI.ResetFrictionBtn.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
        task.wait(1.5)
        UI.ResetFrictionBtn.Text = "RESET"
        UI.ResetFrictionBtn.BackgroundColor3 = Color3.fromRGB(255, 120, 0)
    end
end)

UI.RemoveWheelieBtn.MouseButton1Click:Connect(function()
    local _, carModel = getCurrentVehicle()
    local deletedCount = 0

    if carModel then
        for _, item in ipairs(carModel:GetDescendants()) do
            if item.Name:lower():find("wheelie") then
                item:Destroy()
                deletedCount = deletedCount + 1
            end
        end
    end

    if deletedCount > 0 then
        UI.RemoveWheelieBtn.Text = "DEL ("..deletedCount..")"
        UI.RemoveWheelieBtn.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
    else
        UI.RemoveWheelieBtn.Text = "NOT FOUND"
        UI.RemoveWheelieBtn.BackgroundColor3 = Color3.fromRGB(255, 100, 0)
    end

    task.wait(1.5)
    UI.RemoveWheelieBtn.Text = "EXEC"
    UI.RemoveWheelieBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
end)

UI.FastFloatBtn.MouseButton1Click:Connect(function()
    if not Logic.GetFeaturesActive() then return end
    local seat = getCurrentVehicle()
    if seat then
        local customSpeed = tonumber(UI.FastSpeedBox.Text) or 100
        local currentVel = seat.AssemblyLinearVelocity
        local forwardDir = seat.CFrame.LookVector
        seat.AssemblyLinearVelocity = (forwardDir * (currentVel.Magnitude + customSpeed)) + Vector3.new(0, math.clamp(currentVel.Y, -5, 3), 0)
    end
end)

UI.SmoothFloatBtn.MouseButton1Click:Connect(function()
    if not Logic.GetFeaturesActive() then return end
    local newState = not Logic.GetSmoothBoosting()
    Logic.SetSmoothBoosting(newState)
    UI.SmoothFloatBtn.Text = newState and "🔥" or "⚡"

    if newState then
        task.spawn(function()
            while Logic.GetSmoothBoosting() and Logic.GetFeaturesActive() do
                local seat = getCurrentVehicle()
                if seat and seat:IsA("BasePart") then
                    local addPower = tonumber(UI.SmoothBox1.Text) or 3.5
                    local delayVal = tonumber(UI.SmoothBox2.Text) or 0.03
                    local curVel = seat.AssemblyLinearVelocity
                    seat.AssemblyLinearVelocity = (curVel + (seat.CFrame.LookVector * addPower)) + Vector3.new(0, math.clamp(curVel.Y, -5, 3), 0)
                    task.wait(delayVal)
                else
                    Logic.SetSmoothBoosting(false)
                    UI.SmoothFloatBtn.Text = "⚡"
                    break
                end
            end
        end)
    end
end)

UI.SmoothReverseFloatBtn.MouseButton1Click:Connect(function()
    if not Logic.GetFeaturesActive() then return end
    local newState = not Logic.GetSmoothReversing()
    Logic.SetSmoothReversing(newState)
    UI.SmoothReverseFloatBtn.Text = newState and "💥" or "🛑"

    if newState then
        task.spawn(function()
            while Logic.GetSmoothReversing() and Logic.GetFeaturesActive() do
                local seat = getCurrentVehicle()
                if seat and seat:IsA("BasePart") then
                    local brakePower = tonumber(UI.BrakeBox1.Text) or 4
                    local delayVal = tonumber(UI.BrakeBox2.Text) or 0.0225
                    local currentVel = seat.AssemblyLinearVelocity
                    local forwardSpeed = currentVel:Dot(seat.CFrame.LookVector)

                    if forwardSpeed > 0 then
                        local newVel = currentVel - (seat.CFrame.LookVector * brakePower)
                        seat.AssemblyLinearVelocity = Vector3.new(newVel.X, math.clamp(newVel.Y, -5, 3), newVel.Z)
                    elseif forwardSpeed > -1 then
                        seat.AssemblyLinearVelocity = Vector3.new(0, math.clamp(currentVel.Y, -5, 3), 0)
                    end
                    task.wait(delayVal)
                else
                    Logic.SetSmoothReversing(false)
                    UI.SmoothReverseFloatBtn.Text = "🛑"
                    break
                end
            end
        end)
    end
end)

RunService.Stepped:Connect(function()
    if not Logic.GetFeaturesActive() then return end

    local seat, carModel = getCurrentVehicle()

    if seat and carModel then
        local vel = seat.AssemblyLinearVelocity

        if vel.Y > 8 or vel.Y < -15 then
            seat.AssemblyLinearVelocity = Vector3.new(vel.X, math.clamp(vel.Y, -10, 5), vel.Z)
        end

        UI.CarLabel.Text = "Car: " .. carModel.Name

        if defaultFrictionVal == nil then
            local currentProp = seat.CustomPhysicalProperties or PhysicalProperties.new(seat.Material)
            defaultFrictionVal = currentProp.Friction
            defaultFrictionWeightVal = currentProp.FrictionWeight
        end
    else
        UI.CarLabel.Text = "Car: None"
        defaultFrictionVal = nil
        defaultFrictionWeightVal = nil
    end
end)
