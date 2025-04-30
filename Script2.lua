--[[Character Setup]]

local player = game.Players.LocalPlayer
local playerGui = player.PlayerGui
local hotbar = playerGui:FindFirstChild("Hotbar")
local backpack = hotbar:FindFirstChild("Backpack")
local hotbarFrame = backpack:FindFirstChild("Hotbar")

-- Tool Names for Custom Character
local baseButton1 = hotbarFrame:FindFirstChild("1").Base
local ToolName1 = baseButton1.ToolName
ToolName1.Text = "CustomMove1"

local baseButton2 = hotbarFrame:FindFirstChild("2").Base
local ToolName2 = baseButton2.ToolName
ToolName2.Text = "CustomMove2"

local baseButton3 = hotbarFrame:FindFirstChild("3").Base
local ToolName3 = baseButton3.ToolName
ToolName3.Text = "CustomMove3"

local baseButton4 = hotbarFrame:FindFirstChild("4").Base
local ToolName4 = baseButton4.ToolName
ToolName4.Text = "CustomMove4"

-- Update Ultimate Name
local function findGuiAndSetText()
    local screenGui = playerGui:FindFirstChild("ScreenGui")
    if screenGui then
        local magicHealthFrame = screenGui:FindFirstChild("MagicHealth")
        if magicHealthFrame then
            local textLabel = magicHealthFrame:FindFirstChild("TextLabel")
            if textLabel then
                textLabel.Text = "CustomHeroUltimate"
            end
        end
    end
end

playerGui.DescendantAdded:Connect(findGuiAndSetText)
findGuiAndSetText()

--[[Custom Animations]]

--[[Custom Move 1]]
local animationId1 = 180431276 -- Public Animation: Roblox Default Attack Animation

local function onAnimationPlayed1(animationTrack)
    if animationTrack.Animation.AnimationId == "rbxassetid://" .. animationId1 then
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoid = character:WaitForChild("Humanoid")
        for _, animTrack in pairs(humanoid:GetPlayingAnimationTracks()) do
            animTrack:Stop()
        end
        
        local AnimAnim = Instance.new("Animation")
        AnimAnim.AnimationId = "rbxassetid://180431276" -- Default Attack Animation
        local Anim = humanoid:LoadAnimation(AnimAnim)
        Anim:Play()
        Anim:AdjustSpeed(1)
    end
end

--[[Move 2]]
local animationId2 = 507776185 -- Public Animation: Roblox Default Idle Animation

local function onAnimationPlayed2(animationTrack)
    if animationTrack.Animation.AnimationId == "rbxassetid://" .. animationId2 then
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoid = character:WaitForChild("Humanoid")
        for _, animTrack in pairs(humanoid:GetPlayingAnimationTracks()) do
            animTrack:Stop()
        end
        
        local AnimAnim = Instance.new("Animation")
        AnimAnim.AnimationId = "rbxassetid://507776185" -- Default Idle Animation
        local Anim = humanoid:LoadAnimation(AnimAnim)
        Anim:Play()
        Anim:AdjustSpeed(1)
    end
end

--[[Move 3]]
local animationId3 = 180431276 -- Public Animation: Another Default Attack Animation

local function onAnimationPlayed3(animationTrack)
    if animationTrack.Animation.AnimationId == "rbxassetid://" .. animationId3 then
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoid = character:WaitForChild("Humanoid")
        for _, animTrack in pairs(humanoid:GetPlayingAnimationTracks()) do
            animTrack:Stop()
        end
        
        local AnimAnim = Instance.new("Animation")
        AnimAnim.AnimationId = "rbxassetid://180431276" -- Default Attack Animation
        local Anim = humanoid:LoadAnimation(AnimAnim)
        Anim:Play()
        Anim:AdjustSpeed(1)
    end
end

--[[Move 4]]
local animationId4 = 507776185 -- Public Animation: Another Default Idle Animation

local function onAnimationPlayed4(animationTrack)
    if animationTrack.Animation.AnimationId == "rbxassetid://" .. animationId4 then
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoid = character:WaitForChild("Humanoid")
        for _, animTrack in pairs(humanoid:GetPlayingAnimationTracks()) do
            animTrack:Stop()
        end
        
        local AnimAnim = Instance.new("Animation")
        AnimAnim.AnimationId = "rbxassetid://507776185" -- Default Idle Animation
        local Anim = humanoid:LoadAnimation(AnimAnim)
        Anim:Play()
        Anim:AdjustSpeed(1)
    end
end

--[[Ultimate Activation]]
local animationIdUltimate = 1005147654 -- Public Animation: Roblox Ultimate Animation

local function onAnimationPlayedUltimate(animationTrack)
    if animationTrack.Animation.AnimationId == "rbxassetid://" .. animationIdUltimate then
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoid = character:WaitForChild("Humanoid")
        for _, animTrack in pairs(humanoid:GetPlayingAnimationTracks()) do
            animTrack:Stop()
        end
        
        local AnimAnim = Instance.new("Animation")
        AnimAnim.AnimationId = "rbxassetid://1005147654" -- Ultimate Animation
        local Anim = humanoid:LoadAnimation(AnimAnim)
        Anim:Play()
        Anim:AdjustSpeed(1)
    end
end

--[[Connect Animation Listeners]]
local humanoid = player.Character:WaitForChild("Humanoid")
humanoid.AnimationPlayed:Connect(onAnimationPlayed1)
humanoid.AnimationPlayed:Connect(onAnimationPlayed2)
humanoid.AnimationPlayed:Connect(onAnimationPlayed3)
humanoid.AnimationPlayed:Connect(onAnimationPlayed4)
humanoid.AnimationPlayed:Connect(onAnimationPlayedUltimate)

--[[Adding Custom Chat Messages]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local messages = {"Welcome, CustomHero!", "Unleashing Custom Power!", "Prepare for Custom Moves!"}

local function sendMessage(text)
    ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(text, "All")
end

for _, message in ipairs(messages) do
    sendMessage(message)
    wait(1.7)
end

--[[Idle Animation for Custom Character]]
local animationIdIdle = "rbxassetid://507776185" -- Default Idle Animation
local idleAnimation = Instance.new("Animation")
idleAnimation.AnimationId = animationIdIdle
local idleTrack = humanoid:LoadAnimation(idleAnimation)

local function isMoving()
    return humanoid.MoveDirection.Magnitude > 0
end

while true do
    if not isMoving() and not idleTrack.IsPlaying then
        idleTrack:Play()
    elseif isMoving() and idleTrack.IsPlaying then
        idleTrack:Stop()
    end
    wait(0.1)
end
