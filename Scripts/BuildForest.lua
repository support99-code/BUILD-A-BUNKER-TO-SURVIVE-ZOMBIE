
-- ZOMBIE FOREST SURVIVAL
-- HAUNTED FOREST GENERATOR

local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")

local oldForest = Workspace:FindFirstChild("ZombieForest")
if oldForest then
    oldForest:Destroy()
end

local forest = Instance.new("Model")
forest.Name = "ZombieForest"
forest.Parent = Workspace

local function makePart(name, size, pos, color, material, shape)
    local part = Instance.new("Part")
    part.Name = name
    part.Size = size
    part.Position = pos
    part.Anchored = true
    part.Color = color
    part.Material = material
        or Enum.Material.Concrete

    if shape then
        part.Shape = shape
    end

    part.Parent = forest
    return part
end

-- FOREST GROUND
makePart(
    "Forest Ground",
    Vector3.new(600, 2, 600),
    Vector3.new(0, -2, 0),
    Color3.fromRGB(35, 65, 35),
    Enum.Material.Grass
)

-- TREE GENERATOR
local function makeTree(x, z)
    local height = math.random(18, 32)

    makePart(
        "Tree Trunk",
        Vector3.new(3, height, 3),
        Vector3.new(x, height / 2 - 1, z),
        Color3.fromRGB(85, 52, 30),
        Enum.Material.Wood
    )

    local leaves = makePart(
        "Tree Leaves",
        Vector3.new(height, height, height),
        Vector3.new(x, height + 2, z),
        Color3.fromRGB(
            math.random(15, 35),
            math.random(55, 90),
            math.random(15, 35)
        ),
        Enum.Material.Grass,
        Enum.PartType.Ball
    )
end

-- ROCK GENERATOR
local function makeRock(x, z)
    local size = math.random(4, 9)

    makePart(
        "Forest Rock",
        Vector3.new(size, size * 0.7, size),
        Vector3.new(x, size * 0.35 - 1, z),
        Color3.fromRGB(75, 75, 75),
        Enum.Material.Slate,
        Enum.PartType.Ball
    )
end

-- RANDOM FOREST
math.randomseed(os.time())

for i = 1, 180 do
    local x = math.random(-280, 280)
    local z = math.random(-280, 280)

    -- Keep the bunker compound clear
    local distance = math.sqrt(x*x + z*z)

    -- Keep lake and plane areas clear too
    local nearLake =
        (x - 180)^2 + (z + 100)^2 < 75^2

    local nearPlane =
        (x + 180)^2 + (z + 120)^2 < 55^2

    if distance > 85
        and not nearLake
        and not nearPlane then
        makeTree(x, z)

        if i % 3 == 0 then
            makeRock(x + 5, z + 5)
        end
    end
end

-- LAKE
makePart(
    "Survival Lake",
    Vector3.new(100, 2, 90),
    Vector3.new(180, -1, -100),
    Color3.fromRGB(25, 85, 130),
    Enum.Material.Glass
).Transparency = 0.25

-- WOODEN DOCK
for i = 0, 5 do
    makePart(
        "Dock Plank",
        Vector3.new(12, 1, 6),
        Vector3.new(180, 1, -45 - i * 6),
        Color3.fromRGB(105, 70, 40),
        Enum.Material.Wood
    )
end

-- CRASHED PLANE
local planeX = -180
local planeZ = -120

makePart(
    "Plane Body",
    Vector3.new(10, 5, 40),
    Vector3.new(planeX, 4, planeZ),
    Color3.fromRGB(100, 100, 105),
    Enum.Material.Metal
)

makePart(
    "Plane Left Wing",
    Vector3.new(45, 2, 10),
    Vector3.new(planeX - 15, 4, planeZ),
    Color3.fromRGB(75, 75, 80),
    Enum.Material.Metal
)

makePart(
    "Plane Right Wing",
    Vector3.new(35, 2, 10),
    Vector3.new(planeX + 12, 4, planeZ + 5),
    Color3.fromRGB(75, 75, 80),
    Enum.Material.Metal
)

makePart(
    "Plane Tail",
    Vector3.new(3, 10, 8),
    Vector3.new(planeX, 8, planeZ + 20),
    Color3.fromRGB(85, 85, 90),
    Enum.Material.Metal
)

-- RADIO TOWER
local towerX = 180
local towerZ = 170

for i = 1, 4 do
    makePart(
        "Radio Tower Support",
        Vector3.new(2, 55, 2),
        Vector3.new(
            towerX + (i % 2) * 12 - 6,
            27,
            towerZ + math.floor((i - 1) / 2) * 12 - 6
        ),
        Color3.fromRGB(55, 55, 60),
        Enum.Material.Metal
    )
end

for y = 10, 50, 10 do
    makePart(
        "Radio Tower Platform",
        Vector3.new(16, 1, 16),
        Vector3.new(towerX, y, towerZ),
        Color3.fromRGB(70, 70, 75),
        Enum.Material.Metal
    )
end

makePart(
    "Radio Antenna",
    Vector3.new(2, 15, 2),
    Vector3.new(towerX, 63, towerZ),
    Color3.fromRGB(180, 40, 40),
    Enum.Material.Metal
)

-- SPOOKY ATMOSPHERE
Lighting.ClockTime = 0
Lighting.Brightness = 1
Lighting.FogStart = 30
Lighting.FogEnd = 350
Lighting.FogColor = Color3.fromRGB(65, 75, 80)

local atmosphere = Lighting:FindFirstChildOfClass("Atmosphere")

if not atmosphere then
    atmosphere = Instance.new("Atmosphere")
    atmosphere.Parent = Lighting
end

atmosphere.Density = 0.35
atmosphere.Haze = 3
atmosphere.Color = Color3.fromRGB(150, 160, 170)

print("HAUNTED FOREST CREATED!")
print("Trees, rocks, lake, dock, plane and radio tower ready!")
