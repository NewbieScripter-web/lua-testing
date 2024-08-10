local player = game.Players.LocalPlayer
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local followConnection
local standActive = true

local function GetPlayer(Name)
    Name = Name:lower()
    for _, x in next, Players:GetPlayers() do
        if x ~= player then
            if x.Name:lower():match("^" .. Name) then
                return x
            elseif x.DisplayName:lower():match("^" .. Name) then
                return x
            end
        end
    end
    return nil
end

local SkidFling = function(TargetPlayer)
    local Character = player.Character
    local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
    local RootPart = Humanoid and Humanoid.RootPart

    local TCharacter = TargetPlayer.Character
    local THumanoid
    local TRootPart
    local THead
    local Accessory
    local Handle

    if TCharacter:FindFirstChildOfClass("Humanoid") then
        THumanoid = TCharacter:FindFirstChildOfClass("Humanoid")
    end
    if THumanoid and THumanoid.RootPart then
        TRootPart = THumanoid.RootPart
    end
    if TCharacter:FindFirstChild("Head") then
        THead = TCharacter.Head
    end
    if TCharacter:FindFirstChildOfClass("Accessory") then
        Accessory = TCharacter:FindFirstChildOfClass("Accessory")
    end
    if Accessory and Accessory:FindFirstChild("Handle") then
        Handle = Accessory.Handle
    end

    if Character and Humanoid and RootPart then
        if RootPart.Velocity.Magnitude < 50 then
            getgenv().OldPos = RootPart.CFrame
        end
        if THumanoid and THumanoid.Sit and not AllBool then
        end
        if THead then
            workspace.CurrentCamera.CameraSubject = THead
        elseif not THead and Handle then
            workspace.CurrentCamera.CameraSubject = Handle
        elseif THumanoid and TRootPart then
            workspace.CurrentCamera.CameraSubject = THumanoid
        end
        if not TCharacter:FindFirstChildWhichIsA("BasePart") then
            return
        end

        local FPos = function(BasePart, Pos, Ang)
            RootPart.CFrame = CFrame.new(BasePart.Position) * Pos * Ang
            Character:SetPrimaryPartCFrame(CFrame.new(BasePart.Position) * Pos * Ang)
            RootPart.Velocity = Vector3.new(9e7, 9e7 * 10, 9e7)
            RootPart.RotVelocity = Vector3.new(9e8, 9e8, 9e8)
        end

        local SFBasePart = function(BasePart)
            local TimeToWait = 2
            local Time = tick()
            local Angle = 0

            repeat
                if RootPart and THumanoid then
                    if BasePart.Velocity.Magnitude < 50 then
                        Angle = Angle + 100

                        FPos(BasePart, CFrame.new(0, 1.5, 0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(0, -1.5, 0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(2.25, 1.5, -2.25) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(-2.25, -1.5, 2.25) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(0, 1.5, 0) + THumanoid.MoveDirection, CFrame.Angles(math.rad(Angle), 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(0, -1.5, 0) + THumanoid.MoveDirection, CFrame.Angles(math.rad(Angle), 0, 0))
                        task.wait()
                    else
                        FPos(BasePart, CFrame.new(0, 1.5, THumanoid.WalkSpeed), CFrame.Angles(math.rad(90), 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(0, -1.5, -THumanoid.WalkSpeed), CFrame.Angles(0, 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(0, 1.5, THumanoid.WalkSpeed), CFrame.Angles(math.rad(90), 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(0, 1.5, TRootPart.Velocity.Magnitude / 1.25), CFrame.Angles(math.rad(90), 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(0, -1.5, -TRootPart.Velocity.Magnitude / 1.25), CFrame.Angles(0, 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(0, 1.5, TRootPart.Velocity.Magnitude / 1.25), CFrame.Angles(math.rad(90), 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(math.rad(90), 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(0, 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(math.rad(-90), 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(0, 0, 0))
                        task.wait()
                    end
                else
                    break
                end
            until BasePart.Velocity.Magnitude > 500 or BasePart.Parent ~= TargetPlayer.Character or TargetPlayer.Parent ~= Players or not TargetPlayer.Character == TCharacter or Humanoid.Health <= 0 or tick() > Time + TimeToWait
        end

        workspace.FallenPartsDestroyHeight = 0/0

        local BV = Instance.new("BodyVelocity")
        BV.Name = "EpixVel"
        BV.Parent = RootPart
        BV.Velocity = Vector3.new(9e8, 9e8, 9e8)
        BV.MaxForce = Vector3.new(1/0, 1/0, 1/0)

        Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false)

        if TRootPart and THead then
            if (TRootPart.CFrame.p - THead.CFrame.p).Magnitude > 5 then
                SFBasePart(THead)
            else
                SFBasePart(TRootPart)
            end
        elseif TRootPart and not THead then
            SFBasePart(TRootPart)
        elseif not TRootPart and THead then
            SFBasePart(THead)
        elseif not TRootPart and not THead and Accessory and Handle then
            SFBasePart(Handle)
        else
            return Message("Error Occurred", "Target is missing everything", 5)
        end

        BV:Destroy()
        Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
        workspace.CurrentCamera.CameraSubject = Humanoid

        repeat
            RootPart.CFrame = getgenv().OldPos * CFrame.new(0, .5, 0)
            Character:SetPrimaryPartCFrame(getgenv().OldPos * CFrame.new(0, .5, 0))
            Humanoid:ChangeState("GettingUp")
            table.foreach(Character:GetChildren(), function(_, x)
                if x:IsA("BasePart") then
                    x.Velocity, x.RotVelocity = Vector3.new(), Vector3.new()
                end
            end)
            task.wait()
        until (RootPart.Position - getgenv().OldPos.p).Magnitude < 25
        workspace.FallenPartsDestroyHeight = getgenv().FPDH
    else
        return Message("Error Occurred", "Random error", 5)
    end
end

local function followTarget(target)
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

    local followDistance = 5
    local leftOffset = 2
    local upOffset = 2

    local humanoid = character:WaitForChild("Humanoid")
    humanoid.PlatformStand = true

    local bodyPosition = Instance.new("BodyPosition")
    bodyPosition.MaxForce = Vector3.new(4000, 4000, 4000)
    bodyPosition.P = 5000
    bodyPosition.Parent = humanoidRootPart

    followConnection = RunService.RenderStepped:Connect(function()
        if standActive and target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
            local targetRoot = target.Character.HumanoidRootPart
            local targetPosition = targetRoot.Position

            local backwardDirection = -targetRoot.CFrame.LookVector
            local leftDirection = targetRoot.CFrame.RightVector
            local standPosition = targetPosition + backwardDirection * followDistance + leftDirection * leftOffset + Vector3.new(0, upOffset, 0)

            bodyPosition.Position = standPosition
            humanoidRootPart.CFrame = CFrame.new(standPosition, targetPosition)
            game.Workspace.CurrentCamera.CFrame = CFrame.new(standPosition + Vector3.new(0, 2, -10), standPosition)
        end
    end)


 
    target.CharacterRemoving:Connect(function()
      
        target.CharacterAdded:Wait()
        followTarget(target) 
    end)
end

local function Message(_Title, _Text, Time)
    game:GetService("StarterGui"):SetCore("SendNotification", { Title = _Title, Text = _Text, Duration = Time })
end
  

local function onPlayerAdded(target)
    if target.Name == targetPlayerName then
        followTarget(target)
    end
end
local function GetPlayerFromName(name)
    for _, player in pairs(game.Players:GetPlayers()) do
        if player.Name:lower():find(name:lower()) or player.DisplayName:lower():find(name:lower()) then
            return player
        end
    end
    return nil
end





local targetPlayer = GetPlayer(targetPlayerName)

targetPlayer.Chatted:Connect(function(message)
    if message:lower():sub(1, 6) == ".fling" then
        local playerName = message:sub(8):match("^%s*(.-)%s*$")

        standActive = false
        followConnection:Disconnect()
        local targetPlayerToFling = GetPlayer(playerName)

        local success, err = pcall(function()
            SkidFling(targetPlayerToFling)
        end)

        if not success then
            Message("Error Occurred", err, 5)
        end

        standActive = true
        followTarget(targetPlayer)
    elseif message:lower():sub(1, 6) == ".bring" then
        local playerName = message:sub(8):match("^%s*(.-)%s*$")
        print("Player to bring: " .. playerName)
        print(playerName)
        standActive = false
        followConnection:Disconnect()
        local target = GetPlayerFromName(tostring(playerName))

        local oldPos = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame

        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame * CFrame.new(4,0,4)
        task.wait(0.16)

        local args = {
            [1] = {
                ["Tool"] = game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Crushing Pull"),
                ["CrushingPull"] = target.Character,
                ["Goal"] = "Console Move",
                ["ToolName"] = "Crushing Pull"
            }
        }

        game:GetService("Players").LocalPlayer.Character.Communicate:FireServer(unpack(args))

        task.wait(0.15)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = oldPos
        
        standActive = true
        followTarget(targetPlayer)
    elseif message:lower():sub(1, 5) == ".void" then
        local playerName = message:sub(7):match("^%s*(.-)%s*$")
        print("Player to void: " .. playerName)
        print(playerName)
        standActive = false
        followConnection:Disconnect()
        local target = GetPlayerFromName(tostring(playerName))

        local oldPos = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame

        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame * CFrame.new(4,0,4)
        task.wait(0.16)

        local args = {
            [1] = {
                ["Tool"] = game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Crushing Pull"),
                ["CrushingPull"] = target.Character,
                ["Goal"] = "Console Move",
                ["ToolName"] = "Crushing Pull"
            }
        }

        game:GetService("Players").LocalPlayer.Character.Communicate:FireServer(unpack(args))

        task.wait(0.15)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1000,1000,1000)
        task.wait(1)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = oldPos
        
        standActive = true
        followTarget(targetPlayer)
    end
end)

local args = {
    [1] = "Hey "..GetPlayerFromName(tostring(targetPlayer)).DisplayName.."! I am now your stand, you are now able to use these commands:",
    [2] = "All"
}

game:GetService("ReplicatedStorage"):WaitForChild("DefaultChatSystemChatEvents"):WaitForChild("SayMessageRequest"):FireServer(unpack(args))
task.wait(1)
local args = {
    [1] = ".void {plr}",
    [2] = "All"
}

game:GetService("ReplicatedStorage"):WaitForChild("DefaultChatSystemChatEvents"):WaitForChild("SayMessageRequest"):FireServer(unpack(args))

local args = {
    [1] = ".bring {plr}",
    [2] = "All"
}

game:GetService("ReplicatedStorage"):WaitForChild("DefaultChatSystemChatEvents"):WaitForChild("SayMessageRequest"):FireServer(unpack(args))

local args = {
    [1] = ".fling {plr}",
    [2] = "All"
}

game:GetService("ReplicatedStorage"):WaitForChild("DefaultChatSystemChatEvents"):WaitForChild("SayMessageRequest"):FireServer(unpack(args))


if targetPlayer then
    followTarget(targetPlayer)
else
    Players.PlayerAdded:Connect(onPlayerAdded)
end
