
-- ZOMBIE FOREST SURVIVAL
-- MAIN BUNKER GENERATOR

local Workspace = game:GetService("Workspace")

local oldBase = Workspace:FindFirstChild("ZombieBase")
if oldBase then
    oldBase:Destroy()
end

local base = Instance.new("Model")
base.Name = "ZombieBase"
base.Parent = Workspace

local function makePart(name, size, position, color, material)
    local part = Instance.new("Part")
    part.Name = name
    part.Size = size
    part.Position = position
    part.Anchored = true
    part.Color = color
    part.Material = material or Enum.Material.Concrete
    part.Parent = base
    return part
end

-- MAIN GROUND
makePart("Bunker Ground",
    Vector3.new(100, 2, 100),
    Vector3.new(0, 0, 0),
    Color3.fromRGB(75, 75, 75))

-- BUNKER BUILDING
makePart("Main Bunker",
    Vector3.new(38, 16, 30),
    Vector3.new(0, 9, -15),
    Color3.fromRGB(95, 100, 105))

-- ROOF
makePart("Bunker Roof",
    Vector3.new(42, 3, 34),
    Vector3.new(0, 18, -15),
    Color3.fromRGB(55, 60, 65))

-- FRONT ENTRANCE
makePart("Entrance Door",
    Vector3.new(12, 10, 1),
    Vector3.new(0, 8, 0.5),
    Color3.fromRGB(80, 55, 40),
    Enum.Material.Metal)

-- DEFENSIVE WALLS
local wallColor = Color3.fromRGB(90, 90, 90)

makePart("Back Wall",
    Vector3.new(100, 12, 4),
    Vector3.new(0, 7, -50), wallColor)

makePart("Left Wall",
    Vector3.new(4, 12, 100),
    Vector3.new(-50, 7, 0), wallColor)

makePart("Right Wall",
    Vector3.new(4, 12, 100),
    Vector3.new(50, 7, 0), wallColor)

-- FRONT WALL WITH GATE OPENING
makePart("Front Wall Left",
    Vector3.new(40, 12, 4),
    Vector3.new(-30, 7, 50), wallColor)

makePart("Front Wall Right",
    Vector3.new(40, 12, 4),
    Vector3.new(30, 7, 50), wallColor)

makePart("Main Gate",
    Vector3.new(20, 10, 3),
    Vector3.new(0, 6, 50),
    Color3.fromRGB(65, 65, 65),
    Enum.Material.Metal)

-- FOUR WATCHTOWERS
local function makeTower(x, z, number)
    makePart("Tower Base " .. number,
        Vector3.new(10, 3, 10),
        Vector3.new(x, 2, z),
        Color3.fromRGB(75, 65, 50))

    makePart("Tower Support " .. number,
        Vector3.new(2, 17, 2),
        Vector3.new(x, 11, z),
        Color3.fromRGB(95, 65, 40),
        Enum.Material.Wood)

    makePart("Tower Platform " .. number,
        Vector3.new(13, 2, 13),
        Vector3.new(x, 20, z),
        Color3.fromRGB(100, 70, 45),
        Enum.Material.Wood)

    local lamp = makePart("Tower Light " .. number,
        Vector3.new(2, 2, 2),
        Vector3.new(x, 23, z),
        Color3.fromRGB(255, 210, 100),
        Enum.Material.Neon)

    local light = Instance.new("PointLight")
    light.Brightness = 2
    light.Range = 35
    light.Parent = lamp
end

makeTower(-43, -43, 1)
makeTower(43, -43, 2)
makeTower(-43, 43, 3)
makeTower(43, 43, 4)

-- CENTRAL CAMPFIRE
local campfire = makePart("Campfire",
    Vector3.new(5, 1, 5),
    Vector3.new(0, 2, 25),
    Color3.fromRGB(85, 45, 20),
    Enum.Material.Wood)

local fire = Instance.new("Fire")
fire.Size = 12
fire.Heat = 8
fire.Parent = campfire

local glow = Instance.new("PointLight")
glow.Color = Color3.fromRGB(255, 130, 35)
glow.Brightness = 3
glow.Range = 35
glow.Parent = campfire

print("ZOMBIE SURVIVAL BUNKER CREATED!")
