-- This script instructs a turtle to navigate a specified X by Z area
-- in a snake-like pattern, flattening the entire area.

-- Function to handle moving the turtle forward,
-- including attempting to dig if an obstacle is encountered.
local function moveForward()
    -- Try to move forward. If it fails, an obstacle is present.
    if not turtle.forward() then
        print("Obstacle detected. Attempting to dig...")
        -- Try to dig the block in front.
        if turtle.dig() then
            sleep(0.5) -- Give a small delay for the block to break
            -- After digging, try to move forward again.
            if not turtle.forward() then
                error("Failed to move forward even after digging. Aborting.")
            end
        else
            -- If digging also failed, it means the block couldn't be broken.
            error("Failed to dig obstacle. Aborting.")
        end
    end
end

-- Function to check for and mine any block directly above the turtle.
local function mineBlockAbove() -- Renamed from mineBlockAbove to reflect broader functionality
    local movedUpCount = 0 -- Keep track of how many levels the turtle moved up

    print("Checking for blocks above...")
    while true do
        local success, blockData = turtle.inspectUp() -- Inspect the block directly above

        -- Check if inspection was successful and if a block exists
        if success and blockData then
            print("Block detected above. Digging...")
            if turtle.digUp() then
                sleep(0.5) -- Give a small delay for the block to break
                print("Block broken. Moving up...")
                if turtle.up() then
                    movedUpCount = movedUpCount + 1 -- Increment count for moved levels
                    sleep(0.2) -- Small delay after moving
                else
                    -- This case should ideally not happen if digUp succeeded, but good to handle
                    print("Failed to move up after digging block. Continuing to check for more blocks.")
                    break -- Exit loop if cannot move up
                end
            else
                print("Failed to dig block above. Stopping overhead mining.")
                break -- Exit loop if digging failed
            end
        else
            -- No block detected, or inspection failed, or no block present
            print("No more blocks detected above.")
            break -- Exit the loop
        end
    end

    -- Move back down to the original height
    if movedUpCount > 0 then
        print("Moving back down to original level...")
        for i = 1, movedUpCount do
            if not turtle.down() then
                print("Warning: Failed to move down completely.")
                break -- Stop trying to move down if it fails
            end
            sleep(0.2) -- Small delay after moving down
        end
        print("Returned to original level.")
    end
end

-- Clear the terminal and set cursor for user input
term.clear()
term.setCursorPos(1,1)

-- Get X dimension (width) from the user
io.write("Enter X dimension (width of the area): ")
local xDim = tonumber(io.read())

-- Get Z dimension (depth) from the user
io.write("Enter Z dimension (depth of the area): ")
local zDim = tonumber(io.read())

-- Validate user input
if not xDim or not zDim or xDim < 1 or zDim < 1 then
    error("Invalid dimensions. Please enter positive numbers for both X and Z.")
end

print("\nStarting navigation...")
print("Please ensure your turtle has enough fuel!")

-- 'goingRight' tracks the current horizontal direction of movement.
-- True means moving along positive X, false means moving along negative X.
local goingRight = true

-- Main loop to cover the Z dimension (depth)
for z = 1, zDim do
    if goingRight then
        -- Move right (positive X direction) for 'xDim' blocks
        for x = 1, xDim do
            print(string.format("Moving X: %d/%d, Z: %d/%d (right)", x, xDim, z, zDim))
            moveForward()
            mineBlockAbove()
            sleep(0.05) -- Small delay for visual feedback
        end
        
        -- After completing an X row, check if there's more Z to cover
        if z < zDim then
            turtle.turnRight() -- Turn to face the positive Z direction
            print(string.format("Moving Z: %d/%d (down)", z, zDim))
            moveForward()      -- Move one block in the Z direction
            mineBlockAbove()
            turtle.turnRight() -- Turn to face the negative X direction for the next row
            goingRight = false -- Set direction for the next row
        end
    else
        -- Move left (negative X direction) for 'xDim' blocks
        for x = 1, xDim do
            print(string.format("Moving X: %d/%d, Z: %d/%d (left)", x, xDim, z, zDim))
            moveForward()
            mineBlockAbove()
            sleep(0.05) -- Small delay for visual feedback
        end
        
        -- After completing an X row, check if there's more Z to cover
        if z < zDim then
            turtle.turnLeft()  -- Turn to face the positive Z direction
            print(string.format("Moving Z: %d/%d (down)", z, zDim))
            moveForward()      -- Move one block in the Z direction
            mineBlockAbove()
            turtle.turnLeft()  -- Turn to face the positive X direction for the next row
            goingRight = true  -- Set direction for the next row
        end
    end
    sleep(0.1) -- Slightly longer delay after each Z row
end

print("Flattening complete!")
