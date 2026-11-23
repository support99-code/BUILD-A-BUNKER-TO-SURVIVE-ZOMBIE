local Players = game:GetService("Players")
local Teams = game:GetService("Teams")
local Lighting = game:GetService("Lighting")

local Infection = {}

local zombieTeam = Teams:FindFirstChild("Zombies")

if not zombieTeam then
    zombieTeam = Instance.new("Team")
    zombieTeam.Name = "Zombies"
    zombieTeam.TeamColor = BrickColor.new("Bright blue")
    zombieTeam.AutoAssignable = false
    zombieTeam.Parent = Teams
end

local function infectCharacter(player, character)
    local humanoid = character:WaitForChild("Humanoid")

    humanoid.WalkSpeed = 21
    humanoid.MaxHealth = 150
    humanoid.Health = 150

    humanoid.DisplayName = "INFECTED"

    -- Give the infected player a blue glow
    local glow = Instance.new("Highlight")
    glow.FillColor = Color3.fromRGB(0, 100, 255)
    glow.OutlineColor = Color3.fromRGB(100, 200, 255)
    glow.Parent = character
end

function Infection.InfectPlayer(player)
    if player:GetAttribute("IsZombie") then
        return
    end

    player:SetAttribute("IsZombie", true)
    player.Team = zombieTeam

    -- Remove weapons: infected players fight with claws only
    local backpack = player:FindFirstChildOfClass("Backpack")
    if backpack then
        backpack:ClearAllChildren()
    end

    local character = player.Character
    if character then
        for _, item in ipairs(character:GetChildren()) do
            if item:IsA("Tool") then
                item:Destroy()
            end
        end

        infectCharacter(player, character)
    end

    -- Keep the infection after respawning
    player.CharacterAdded:Connect(function(newCharacter)
        if player:GetAttribute("IsZombie") then
            infectCharacter(player, newCharacter)
        end
    end)
end

return Infection
