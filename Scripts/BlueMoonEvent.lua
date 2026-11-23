local Lighting = game:GetService("Lighting")

local BlueMoonEvent = {}

local NORMAL_CLOCK_TIME = 0
local BLUE_MOON_DURATION = 180 -- 3 minutes

function BlueMoonEvent.Start()
    if Lighting:GetAttribute("BlueMoonActive") then
        return
    end

    Lighting:SetAttribute("BlueMoonActive", true)

    -- Turn the sky blue and spooky
    Lighting.ClockTime = NORMAL_CLOCK_TIME
    Lighting.Brightness = 1
    Lighting.Ambient = Color3.fromRGB(20, 40, 110)
    Lighting.OutdoorAmbient = Color3.fromRGB(10, 20, 70)
    Lighting.FogColor = Color3.fromRGB(15, 35, 120)
    Lighting.FogStart = 20
    Lighting.FogEnd = 180

    print("🌕 THE BLUE MOON HAS RISEN!")

    task.wait(BLUE_MOON_DURATION)

    BlueMoonEvent.End()
end

function BlueMoonEvent.End()
    Lighting:SetAttribute("BlueMoonActive", false)

    -- Restore normal lighting
    Lighting.Brightness = 2
    Lighting.Ambient = Color3.fromRGB(128, 128, 128)
    Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
    Lighting.FogStart = 0
    Lighting.FogEnd = 100000

    print("The Blue Moon has ended.")
end

return BlueMoonEvent
