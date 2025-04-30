-- // Move & Ultimate Names
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local hotbar = playerGui:WaitForChild("Hotbar")
local backpack = hotbar:WaitForChild("Backpack")
local hotbarFrame = backpack:WaitForChild("Hotbar")

-- Define move names
local moveNames = {"Omni-Punch", "Mach Speed Dash", "Gravity Well", "Energy Shield"}

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

-- Initial call to set the ultimate name
setUltimateName("Planet Buster")

-- Listen for ScreenGui to be added
playerGui.DescendantAdded:Connect(function(descendant)
    if descendant.Name == "ScreenGui" then
        setUltimateName("Planet Buster")
    end
end)

-- // Animations & New Mechanics
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local animator = humanoid:WaitForChild("Animator")

local function playAnimation(animationId, speed, timePosition, stopAfter)
    local animation = Instance.new("Animation")
    animation.AnimationId = "rbxassetid://" .. animationId
    local animationTrack = animator:LoadAnimation(animation)

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

    return animationTrack -- Return the track so we can potentially monitor it
end

-- // Omni-Punch (Move 1): Rapid multi-hit with potential for a finisher
local move1TriggerAnimId = 10468665991 -- Trigger animation
local move1PunchAnimIds = {17889458563, 17889461810, 17889471098, 17889290569} -- Multiple punch animations
local move1FinisherAnimId = 12684185971 -- Optional powerful finisher

local isOmniPunching = false
local punchCount = 0

humanoid.AnimationPlayed:Connect(function(animationTrack)
    if animationTrack.Animation.AnimationId == "rbxassetid://" .. move1TriggerAnimId and not isOmniPunching then
        isOmniPunching = true
        punchCount = 0
        local function playNextPunch()
            if not isOmniPunching then return end
            punchCount += 1
            if punchCount <= #move1PunchAnimIds then
                local punchAnim = playAnimation(move1PunchAnimIds[punchCount], 1.5, 0, 0.2)
                if punchAnim then
                    punchAnim.Stopped:Connect(playNextPunch)
                end
            else
                -- Optionally play a finisher animation
                playAnimation(move1FinisherAnimId, 1, 0, 0.5)
                isOmniPunching = false
            end
        end
        playNextPunch()
        -- You'd need to add hit detection and damage logic for each punch
    end
end)

-- // Mach Speed Dash (Move 2): High-speed movement with a damaging trail
local move2TriggerAnimId = 10466974800 -- Trigger animation
local move2DashAnimId = 18181589384 -- Visual dash animation

humanoid.AnimationPlayed:Connect(function(animationTrack)
    if animationTrack.Animation.AnimationId == "rbxassetid://" .. move2TriggerAnimId then
        local dashTrack = playAnimation(move2DashAnimId, 2.5, 0, 0.4)
        -- While the dash animation is playing, you'd need to:
        -- 1. Increase the player's velocity significantly in their movement direction.
        -- 2. Potentially create a visual trail effect.
        -- 3. Implement hit detection for enemies the player passes through, dealing damage.
        -- 4. Revert the player's speed after the dash ends.
    end
end)

-- // Gravity Well (Move 3): Creates a localized gravity field pulling enemies in
local move3TriggerAnimId = 10471336737 -- Trigger animation
local move3VisualAnimId = 17838619895 -- Animation for creating the field

humanoid.AnimationPlayed:Connect(function(animationTrack)
    if animationTrack.Animation.AnimationId == "rbxassetid://" .. move3TriggerAnimId then
        playAnimation(move3VisualAnimId, 1, 0, 1)
        -- When this animation plays, you'd need to:
        -- 1. Create an invisible force field object in front of the player.
        -- 2. For any enemy characters within a certain radius of this field, apply a force pulling them towards the center of the field.
        -- 3. Potentially deal damage over time to enemies within the field.
        -- 4. Destroy the force field object after a short duration.
    end
end)

-- // Energy Shield (Move 4): Creates a temporary damage-absorbing shield
local move4TriggerAnimId = 12510170988 -- Trigger animation
local move4VisualAnimId = 16515850153 -- Animation for generating the shield

humanoid.AnimationPlayed:Connect(function(animationTrack)
    if animationTrack.Animation.AnimationId == "rbxassetid://" .. move4TriggerAnimId then
        playAnimation(move4VisualAnimId, 1, 0, 1.5)
        -- While this animation (or shortly after), you'd need to:
        -- 1. Create a visual shield effect around the player's character.
        -- 2. Implement logic that reduces or negates incoming damage while the shield is active.
        -- 3. Potentially have the shield break after absorbing a certain amount of damage or after a set duration.
        -- 4. Destroy the shield effect.
    end
end)

-- // Planet Buster (Ultimate): Massive AoE damage after a charge
local ultTriggerAnimId = 12447707844 -- Trigger animation
local ultChargeAnimId = 17106858586 -- Charging animation
local ultReleaseAnimId = 0 -- Replace with animation for the actual blast

humanoid.AnimationPlayed:Connect(function(animationTrack)
    if animationTrack.Animation.AnimationId == "rbxassetid://" .. ultTriggerAnimId then
        local chargeTrack = playAnimation(ultChargeAnimId, 0.8, 0, 3)
        if chargeTrack then
            chargeTrack.Stopped:Connect(function()
                playAnimation(ultReleaseAnimId, 1, 0, 1)
                -- When the release animation plays, you'd need to:
                -- 1. Create a massive visual effect in a large radius around the player.
                -- 2. Implement hit detection for all enemy characters within that radius.
                -- 3. Deal a significant amount of damage to those enemies.
                -- 4. Potentially apply a knockdown or other status effect.
            end)
        end
    end
end)

-- // Wall Combo (unchanged animation, but could have new mechanics)
local wallComboAnimationId = 15955393872
local wallComboReplacementAnimId = 15943915877

humanoid.AnimationPlayed:Connect(function(animationTrack)
    if animationTrack.Animation.AnimationId == "rbxassetid://" .. wallComboAnimationId then
        playAnimation(wallComboReplacementAnimId, 1, 0.05, nil)
        -- You could add a mechanic where this combo deals extra damage if the opponent is near a wall.
    end
end)

-- // Dash (Quick Evasion) - Could add a brief invulnerability window
local dashAnimationId = 10479335397
local dashReplacementAnimId = 13294790250

humanoid.AnimationPlayed:Connect(function(animationTrack)
    if animationTrack.Animation.AnimationId == "rbxassetid://" .. dashAnimationId then
        playAnimation(dashReplacementAnimId, 1.5, 0, 0.5)
        -- You could add a brief period where the player is immune to damage during the dash.
    end
end)

-- // Other animations (Uppercut, Downslam, Punch) - Mechanics could be added here too
-- ... (rest of your animation handling)

-- // Prevent Y-axis movement from BodyVelocity (remains the same)
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

-- // Idle and Run Animations (remain the same)
-- ... (rest of your idle and run animation handling)
