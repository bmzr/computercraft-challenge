-- Function to refuel the turtle from its inventory.
local function refuelTurtle()
    print("Attempting to refuel turtle...")
    local refueled = false

    -- Define a list of fuel items that the turtle can use
    local fuelItems = {
        "minecraft:coal",
        "minecraft:charcoal",
        "minecraft:coal_block",
        "minecraft:bamboo"
    }

    -- Iterate through all inventory slots (1 to 16 for a standard turtle)
    for slot = 1, 16 do
        local item = turtle.getItemDetail(slot) -- Get details of the item in the current slot

        if item then
            -- Check if the item in the slot is one of the defined fuel items
            for _, fuelName in ipairs(fuelItems) do
                if item.name == fuelName then
                    print("Found " .. item.count .. " " .. item.name .. " in slot " .. slot)
                    turtle.select(slot) -- Select the slot containing the fuel

                    -- Attempt to refuel with all items in the stack
                    -- turtle.refuel() without arguments refuels with the currently selected stack
                    if turtle.refuel() then
                        print("Successfully refueled with " .. item.name .. " from slot " .. slot .. ".")
                        refueled = true
                        -- Break from the inner loop and continue to the next slot
                        break
                    else
                        print("Failed to refuel with " .. item.name .. " from slot " .. slot .. ".")
                    end
                end
            end
        end
    end

    if not refueled then
        print("No suitable fuel found in inventory or failed to refuel.")
    else
        print("Refueling attempt complete.")
    end

    -- Always re-select slot 1 after refueling attempts to return to a default state
    turtle.select(1)
end

-- Call this function whenever you want the turtle to refuel
refuelTurtle()
