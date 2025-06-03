-- Function to check and display the turtle's fuel level.
local function checkFuelLevel()
    print("Checking turtle's fuel level...")

    local currentFuel = turtle.getFuelLevel() -- Get the current fuel level
    local fuelLimit = turtle.getFuelLimit()   -- Get the maximum fuel capacity

    if currentFuel == "unlimited" then
        print("Fuel: Unlimited (Creative Mode or similar)")
    else
        print("Current Fuel: " .. currentFuel)
        print("Fuel Limit: " .. fuelLimit)

        if fuelLimit > 0 then
            local fuelPercentage = (currentFuel / fuelLimit) * 100
            print(string.format("Fuel Percentage: %.2f%%", fuelPercentage))

            if currentFuel < (fuelLimit * 0.2) then -- Example: less than 20% fuel
                print("Warning: Fuel level is low!")
            elseif currentFuel == 0 then
                print("Critical: Turtle has no fuel!")
            end
        else
            print("Fuel limit is 0, which might indicate an issue or a special turtle type.")
        end
    end
end

-- Make the function globally accessible
_G.checkFuelLevel = checkFuelLevel

-- Example usage:
-- Call this function whenever you want to see the turtle's fuel status.
checkFuelLevel()