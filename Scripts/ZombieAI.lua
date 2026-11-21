
-- ZOMBIE FOREST SURVIVAL
-- First Zombie AI Script

local zombie = script.Parent
local humanoid = zombie:WaitForChild("Humanoid")
local root = zombie:WaitForChild("HumanoidRootPart")

local Players = game:GetService("Players")

local DETECTION_RANGE = 100

print("Zombie AI activated!")

while humanoid.Health > 0 do
    local nearestPlayer = nil
    local shortestDistance = DETECTION_RANGE

    for _, player in pairs(Players:GetPlayers()) do
        local character = player.Character

        if character then
            local targetRoot = character:FindFirstChild("HumanoidRootPart")
            local targetHumanoid = character:FindFirstChild("Humanoid")

            if targetRoot and targetHumanoid and targetHumanoid.Health > 0 then
                local distance = (root.Position - targetRoot.Position).Magnitude

                if distance < shortestDistance then
                    shortestDistance = distance
                    nearestPlayer = targetRoot
                end
            end
        end
    end

    if nearestPlayer then
        humanoid:MoveTo(nearestPlayer.Position)
    end

    task.wait(0.5)
end
