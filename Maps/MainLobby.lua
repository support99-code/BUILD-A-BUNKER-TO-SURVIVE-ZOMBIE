-- MAIN LOBBY
-- Zombie Survival Game

local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")

-- Create the lobby container
local Lobby = Instance.new("Folder")
Lobby.Name = "MainLobby"
Lobby.Parent = Workspace

-- Helper function to create parts
local function createPart(name, size, position, color, material)
    local part = Instance.new("Part")
    part.Name = name
    part.Size = size
    part.Position = position
    part.Anchored = true
    part.Color = color
    part.Material = material
    part.Parent = Lobby
    return part
end

-- FLOOR
createPart(
    "ConcreteFloor",
    Vector3.new(160, 2, 160),
    Vector3.new(0, 0, 0),
    Color3.fromRGB(55, 58, 62),
    Enum.Material.Concrete
)

-- MAIN WALLS
local wallColor = Color3.fromRGB(38, 42, 48)

createPart("BackWall", Vector3.new(160, 45, 3),
    Vector3.new(0, 23, -80), wallColor, Enum.Material.Metal)

createPart("LeftWall", Vector3.new(3, 45, 160),
    Vector3.new(-80, 23, 0), wallColor, Enum.Material.Metal)

createPart("RightWall", Vector3.new(3, 45, 160),
    Vector3.new(80, 23, 0), wallColor, Enum.Material.Metal)

-- LIGHTING
Lighting.ClockTime = 0
Lighting.Brightness = 1
Lighting.Ambient = Color3.fromRGB(65, 70, 85)

print("MAIN LOBBY CREATED!")
