-- // Move & Ultimate Names
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local hotbar = playerGui:WaitForChild("Hotbar")
local backpack = hotbar:WaitForChild("Backpack")
local hotbarFrame = backpack:WaitForChild("Hotbar")

-- Define move names
local moveNames = {"Omni-Punch", "Mach Speed Dash", "Ground Shatter", "Energy Field"}

-- Set the text for each move button
for i = 1, #moveNames do
    local button = hotbarFrame:FindFirstChild(tostring(i))
    if button and button:IsA("Frame") then
        local baseButton = button:FindFirstChild("Base")
        if baseButton and baseButton:IsA("ImageButton") then
            local toolName = baseButton:FindFirstChild("ToolName")
            if toolName and toolName:IsA("TextLabel") then
                toolName.Text = moveNames[i]
            end
        end
    end
end

-- Set the ultimate name
local function setUltimateName(ultimateName)
    local screenGui = playerGui:FindFirstChild("ScreenGui")
    if screenGui then
        local magicHealthFrame = screenGui:FindFirstChild("MagicHealth")
        if magicHealthFrame and magicHealthFrame:IsA("Frame") then
            local textLabel = magicHealthFrame:FindFirstChild("TextLabel")
            if textLabel and textLabel:IsA("TextLabel") then
                textLabel.Text = ultimateName
            end
        end
    end
end

-- Initial call to set the ultimate name (you might want to set this based on character data)
setUltimateName("Planet Buster")

-- Listen for ScreenGui to be added in case it loads late
playerGui.DescendantAdded:Connect(function(descendant)
    if descendant.Name == "ScreenGui" then
        setUltimateName("Planet Buster") -- Call again when ScreenGui is added
    end
end)

-- // Animations
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local animator = humanoid:WaitForChild("Animator")

local function playAnimation(animationId, speed, timePosition, stopAfter)
    local animation = Instance.new("Animation")
    animation.AnimationId = "rbxassetid://" .. animationId
    local animationTrack = animator:LoadAnimation(animation)

    -- Stop all currently playing animations on the humanoid
    for _, track in pairs(humanoid:GetPlayingAnimationTracks()) do
        track:Stop()
    end

    if speed then
        animationTrack:AdjustSpeed(speed)
    end
    if timePosition then
        animationTrack.TimePosition = timePosition
    end

    animationTrack:Play()

    if stopAfter then
        delay(stopAfter, function()
            animationTrack:Stop()
        end)
    end
end

-- // Omni-Punch Animation (Move 1)
local move1TriggerAnimId = 10468665991 -- Replace with animation ID for initiating the Omni-Punch
local move1VisualAnimId = 17838006839 -- Replace with animation ID for the rapid punches

humanoid.AnimationPlayed:Connect(function(animationTrack)
    if animationTrack.Animation.AnimationId == "rbxassetid://" .. move1TriggerAnimId then
        playAnimation(move1VisualAnimId, 1.2, 0, nil) -- Increased speed for rapid punches
    end
end)

-- // Mach Speed Dash Animation (Move 2)
local move2TriggerAnimId = 10466974800 -- Replace with animation ID for initiating the dash
local move2VisualAnimId = 18181589384 -- Replace with animation ID for the fast dash movement

humanoid.AnimationPlayed:Connect(function(animationTrack)
    if animationTrack.Animation.AnimationId == "rbxassetid://" .. move2TriggerAnimId then
        playAnimation(move2VisualAnimId, 2, 0, 0.6) -- Very fast, short duration dash
    end
end)

-- // Ground Shatter Animation (Move 3)
local move3TriggerAnimId = 10471336737 -- Replace with animation ID for initiating the ground slam
local move3VisualAnimId = 17838619895 -- Replace with animation ID for the ground cracking effect

humanoid.AnimationPlayed:Connect(function(animationTrack)
    if animationTrack.Animation.AnimationId == "rbxassetid://" .. move3TriggerAnimId then
        playAnimation(move3VisualAnimId, 0.8, 0.2, 1.5) -- Emphasize the impact and lingering effect
    end
end)

-- // Energy Field Animation (Move 4)
local move4TriggerAnimId = 12510170988 -- Replace with animation ID for initiating the energy field
local move4VisualAnimId = 16515850153 -- Replace with animation ID for the character generating a field

humanoid.AnimationPlayed:Connect(function(animationTrack)
    if animationTrack.Animation.AnimationId == "rbxassetid://" .. move4TriggerAnimId then
        playAnimation(move4VisualAnimId, 1, 0, nil) -- Animation for generating the field
        -- You would likely need additional scripting here to create the actual energy field object
    end
end)

-- // Wall Combo Animation (unchanged for now)
local wallComboAnimationId = 15955393872
local wallComboReplacementAnimId = 15943915877

humanoid.AnimationPlayed:Connect(function(animationTrack)
    if animationTrack.Animation.AnimationId == "rbxassetid://" .. wallComboAnimationId then
        playAnimation(wallComboReplacementAnimId, 1, 0.05, nil)
    end
end)

-- // Ult Activation Animation
local ultActivationAnimationId = 12447707844 -- Replace with animation ID for initiating the ultimate
local ultActivationReplacementAnimId = 17106858586 -- Replace with animation ID for the power-up animation

humanoid.AnimationPlayed:Connect(function(animationTrack)
    if animationTrack.Animation.AnimationId == "rbxassetid://" .. ultActivationAnimationId then
        playAnimation(ultActivationReplacementAnimId, 0.9, 0, 2) -- Longer animation to emphasize the ultimate charging
        -- You would need significant additional scripting here to implement the "Planet Buster" ultimate's effects
    end
end)

-- // Dash Animation (renamed to "Quick Evasion" conceptually, but using original IDs)
local dashAnimationId = 10479335397
local dashReplacementAnimId = 13294790250

humanoid.AnimationPlayed:Connect(function(animationTrack)
    if animationTrack.Animation.AnimationId == "rbxassetid://" .. dashAnimationId then
        playAnimation(dashReplacementAnimId, 1.5, 0, 0.5) -- Faster, shorter evasion
    end
end)

-- // Uppercut Animation (unchanged for now)
local uppercutAnimationId = 10503381238
local uppercutReplacementAnimId = 14900168720

humanoid.AnimationPlayed:Connect(function(animationTrack)
    if animationTrack.Animation.AnimationId == "rbxassetid://" .. uppercutAnimationId then
        playAnimation(uppercutReplacementAnimId, 0.7, 1.3, nil)
    end
end)

-- // Downslam Animation (unchanged for now)
local downslamAnimationId = 10470104242
local downslamReplacementAnimId = 12447247483

humanoid.AnimationPlayed:Connect(function(animationTrack)
    if animationTrack.Animation.AnimationId == "rbxassetid://" .. downslamAnimationId then
        wait(0.2)
        playAnimation(downslamReplacementAnimId, 6, 0, nil)
    end
end)

-- // Punch Animations (Omni-Punch will handle basic punches now)
local animationIdsToStop = {
    [17859015788] = true, -- downslam finisher
    [10469493270] = true, -- punch1
    [10469630950] = true, -- punch2
    [10469639222] = true, -- punch3
    [10469643643] = true, -- punch4
}

local replacementAnimations = {
    ["10469493270"] = "rbxassetid://17889458563", -- punch1 (can be part of Omni-Punch visual)
    ["10469630950"] = "rbxassetid://17889461810", -- punch2 (can be part of Omni-Punch visual)
    ["10469639222"] = "rbxassetid://17889471098", -- punch3 (can be part of Omni-Punch visual)
    ["10469643643"] = "rbxassetid://17889290569", -- punch4 (can be part of Omni-Punch visual)
    ["17859015788"] = "rbxassetid://12684185971", -- downslam finisher
    ["11365563255"] = "rbxassetid://14516273501", -- punch idk
}

local queue = {}
local isAnimating = false

local function playQueuedAnimation(animationId)
    isAnimating = true
    local replacementAnimationId = replacementAnimations[tostring(animationId)]
    if replacementAnimationId then
        local AnimAnim = Instance.new("Animation")
        AnimAnim.AnimationId = replacementAnimationId
        local Anim = humanoid:LoadAnimation(AnimAnim)
        Anim:Play()

        Anim.Stopped:Connect(function()
            isAnimating = false
            if #queue > 0 then
                local nextAnimationId = table.remove(queue, 1)
                playQueuedAnimation(nextAnimationId)
            end
        end)
    else
        isAnimating = false
    end
end

local function onPunchAnimationPlayed(animationTrack)
    local animationId = tonumber(animationTrack.Animation.AnimationId:match("%d+"))
    if animationIdsToStop[animationId] then
        -- Stop specific animations
        for _, track in ipairs(humanoid:GetPlayingAnimationTracks()) do
            local currentAnimId = tonumber(track.Animation.AnimationId:match("%d+"))
            if animationIdsToStop[currentAnimId] then
                track:Stop()
            end
        end
        animationTrack:Stop()

        local replacementAnimationId = replacementAnimations[tostring(animationId)]
        if replacementAnimationId then
            if isAnimating then
                table.insert(queue, animationId)
            else
                playQueuedAnimation(animationId)
            end
        end
    end
end

humanoid.AnimationPlayed:Connect(onPunchAnimationPlayed)

-- // Prevent Y-axis movement from BodyVelocity
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

local function onBodyVelocityAdded(bodyVelocity)
    if bodyVelocity:IsA("BodyVelocity") then
        bodyVelocity.Velocity = Vector3.new(bodyVelocity.Velocity.X, 0, bodyVelocity.Velocity.Z)
    end
end

character.DescendantAdded:Connect(onBodyVelocityAdded)

for _, descendant in pairs(character:GetDescendants()) do
    onBodyVelocityAdded(descendant)
end

player.CharacterAdded:Connect(function(newCharacter)
    character = newCharacter
    humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    character.DescendantAdded:Connect(onBodyVelocityAdded)

    for _, descendant in pairs(character:GetDescendants()) do
        onBodyVelocityAdded(descendant)
    end
end)

-- // Adding Quote or Message when Executed (Consider triggering these based on new moves)
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Messages to send
local messages = {"Unleashing power!", "Feel the force!", "Crushing blow!", "Shield activated!"}

local function sendMessage(text)
    ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(text, "All")
end

-- Example of triggering messages (you'd need to tie this to your move activation logic)
-- humanoid.AnimationPlayed:Connect(function(animationTrack)
--     if animationTrack.Animation.AnimationId == "rbxassetid://" .. move1TriggerAnimId then
--         sendMessage(messages[1])
--     elseif animationTrack.Animation.AnimationId == "rbxassetid://" .. move2TriggerAnimId then
--         sendMessage(messages[2])
--     -- ... and so on for other moves
--     end
-- end)

-- // Idle Animation
local idleAnimationId = "rbxassetid://15099756132" -- Replace with your animation ID
local idleAnimation = Instance.new("Animation")
idleAnimation.AnimationId = idleAnimationId
local idleAnimationTrack = animator:LoadAnimation(idleAnimation)

local function isMoving()
    return humanoid.MoveDirection.Magnitude > 0.01 -- Use a small threshold to account for slight movement
end

game:GetService("RunService").RenderStepped:Connect(function()
    if not isMoving() then
        if not idleAnimationTrack.IsPlaying then
            idleAnimationTrack:Play()
        end
    else
        if idleAnimationTrack.IsPlaying then
            idleAnimationTrack:Stop()
        end
    end
end)

-- // Run Animation
local runAnimationId = "rbxassetid://15962326593" -- Replace with your animation ID
local runAnimation = Instance.new("Animation")
runAnimation.AnimationId = runAnimationId
local runAnimationTrack = animator:LoadAnimation(runAnimation)
local isRunning = false

local function onMoveDirectionChanged()
    if humanoid.MoveDirection.Magnitude > 0.01 then
        if not isRunning then
            isRunning = true
            runAnimationTrack:Play()
        end
    else
        if isRunning then
            isRunning = false
            runAnimationTrack:Stop()
        end
    end
end

humanoid:GetPropertyChangedSignal("MoveDirection"):Connect(onMoveDirectionChanged)
onMoveDirectionChanged()
