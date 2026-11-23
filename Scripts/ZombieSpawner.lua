
local ServerStorage = game:GetService("ServerStorage")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")

local ZombieSpawner = {}

local MAX_ZOMBIES = 12
local NORMAL_SPAWN_DELAY = 12
local BLUE_MOON_SPAWN_DELAY = 5

local activeZombies = {}
local running = false
local nightNumber = 0

local function getSpawnPoints()
    local folder = Workspace:FindFirstChild("ZombieSpawnPoints")

    if not folder then
        warn("Missing ZombieSpawnPoints folder!")
        return {}
    end

    local points = {}

    for _, object in ipairs(folder:GetChildren()) do
        if object:IsA("BasePart") then
            table.insert(points, object)
        end
    end

    return points
end

local function countZombies()
    local count = 0

    for _, zombie in ipairs(activeZombies) do
        if zombie and zombie.Parent then
            count += 1
        end
    end

    return count
end

local function spawnZombie()
    local template = ServerStorage:FindFirstChild("Zombie")
    local points = getSpawnPoints()

    if not template then
        warn("Put a Zombie model inside ServerStorage!")
        return
    end

    if #points == 0 then
        warn("Add spawn point Parts to ZombieSpawnPoints!")
        return
    end

    local zombie = template:Clone()
    local spawnPoint = points[math.random(1, #points)]

    zombie.Parent = Workspace
    zombie:PivotTo(spawnPoint.CFrame + Vector3.new(0, 3, 0))

    table.insert(activeZombies, zombie)
end

function ZombieSpawner.StartNight()
    if running then
        return
    end

    running = true
    nightNumber += 1

    print("NIGHT " .. nightNumber .. " HAS BEGUN!")

    task.spawn(function()
        while running do
            local isBlueMoon = Lighting:GetAttribute("BlueMoonActive") == true
            local spawnDelay = isBlueMoon
                and BLUE_MOON_SPAWN_DELAY
                or NORMAL_SPAWN_DELAY

            if countZombies() < MAX_ZOMBIES then
                spawnZombie()
            end

            task.wait(spawnDelay)
        end
    end)
end

function ZombieSpawner.EndNight()
    running = false

    for _, zombie in ipairs(activeZombies) do
        if zombie and zombie.Parent then
            zombie:Destroy()
        end
    end

    table.clear(activeZombies)

    print("DAYTIME! THE ZOMBIES HAVE RETREATED!")
end

return ZombieSpawner
