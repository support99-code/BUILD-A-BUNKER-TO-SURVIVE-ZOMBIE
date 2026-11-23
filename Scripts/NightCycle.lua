local Lighting = game:GetService("Lighting")

local NightCycle = {}

local DAY_LENGTH = 300 -- 5 minutes
local NIGHT_LENGTH = 180 -- 3 minutes

local nightCount = 0
local running = false

function NightCycle.Start(BlueMoonEvent)
    if running then
        return
    end

    running = true

    while running do
        -- DAYTIME
        Lighting.ClockTime = 14
        Lighting.Brightness = 2
        print("☀️ DAYTIME! Explore and collect supplies!")

        task.wait(DAY_LENGTH)

        -- NIGHTTIME
        nightCount += 1
        Lighting.ClockTime = 0
        Lighting.Brightness = 1

        print("🌙 NIGHT " .. nightCount .. "! ZOMBIES ARE COMING!")

        -- Every seventh night is a Blue Moon
        if nightCount % 7 == 0 and BlueMoonEvent then
            BlueMoonEvent.Start()
        end

        task.wait(NIGHT_LENGTH)

        if BlueMoonEvent then
            BlueMoonEvent.End()
        end
    end
end

function NightCycle.Stop()
    running = false
end

return NightCycle
