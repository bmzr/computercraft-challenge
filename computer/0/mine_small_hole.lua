-- Define the digging pattern for one "level"
local function dig()
    -- Dig a plus-shaped area around the turtle
    for i = 1, 4 do
        turtle.dig()        -- Dig the block in front
        turtle.turnRight()  -- Turn right to face the next block in the 2x2 square
    end
    turtle.digDown()    -- Dig the block directly below the turtle
    turtle.down()       -- Move the turtle down to the newly dug space
end

-- Function to get a valid integer Y-level input from the user
local function get_y_level_input()
    local y_level_input = nil
    while y_level_input == nil do
        io.write("Please enter the current Y-level: ") -- Prompt for current Y-level
        local input_str = io.read()                     -- Read user input as a string
        local converted_num = tonumber(input_str)       -- Attempt to convert string to a number

        -- Validate the input
        if converted_num == nil then
            print("Invalid input. Please enter a whole number (integer).")
        elseif converted_num < 0 then
            print("Y-level cannot be negative. Please enter a non-negative integer.")
        else
            y_level_input = math.floor(converted_num) -- Use math.floor to ensure it's an integer
        end
    end
    return y_level_input
end

-- --- Main Script Logic ---

-- Get the current Y-level from the user
local current_y_level = get_y_level_input()

-- Initialize counters and variables
local y_levels_dug = 0
-- The original code used 10 fuel per level, so we'll stick to that for consistency
-- with the "keep the functionality the same" request, but note it might be higher
-- than strictly necessary for just movement/digging.
local fuel_per_level = 10
local estimated_fuel_required = 0

print("\n--- Starting Digging Operation ---")
print("Current Y-level entered: " .. current_y_level)

-- Calculate the number of levels to dig and estimated fuel
-- The original loop `for i = 5, y_level do` implies digging from Y=5 *up to* y_level.
-- This interpretation seems more likely for a "mining down" script where you specify
-- a target depth, rather than a current Y-level.
-- Let's assume the user's `y_level` input is the *target* Y-level to dig *down to*.
-- If the user enters `60` as the current Y-level, and we want to dig down to Y=5,
-- then the loop should go from `current_y_level` down to `5`.

-- Re-interpreting the original loop: `for i = 5, y_level do dig() end`
-- This implies `y_level` is the *target* Y-level to dig *down to*.
-- If `y_level` is 60, and `i` goes from 5 to 60, it means it's digging 56 levels.
-- This is confusing. Let's assume the user's input `y_level` is the *current* Y-level,
-- and the goal is to dig down to Y=5.

-- Let's re-evaluate the original loop: `for i = 5, y_level do dig() end`
-- If `y_level` is the *current* Y, and we want to dig *down* from it,
-- the loop should iterate `y_level - 5` times.
-- For example, if `y_level` is 10, it digs for i=5,6,7,8,9,10 (6 times).
-- This means it digs from Y=10 down to Y=5.

-- Number of levels to dig: from `current_y_level` down to `5`.
-- If `current_y_level` is 10, levels are 10, 9, 8, 7, 6, 5. That's `10 - 5 + 1 = 6` levels.
local levels_to_dig = math.max(0, current_y_level - 5 + 1) -- Ensure non-negative levels

-- If current_y_level is less than 5, no digging occurs.
if current_y_level < 5 then
    print("Current Y-level (" .. current_y_level .. ") is below the target Y-level (5). No digging will occur.")
    levels_to_dig = 0
end

estimated_fuel_required = levels_to_dig * fuel_per_level

print("Estimated levels to dig (down to Y=5): " .. levels_to_dig)
print("Estimated fuel required: " .. estimated_fuel_required .. " fuel units.")

-- Perform the digging
for i = 1, levels_to_dig do
    print("Digging level " .. (current_y_level - i + 1) .. "...")
    dig()
    y_levels_dug = y_levels_dug + 1
end

print("\n--- Digging Complete ---")
print("Total Y-levels dug: " .. y_levels_dug)

-- Return to original Y-level
if y_levels_dug > 0 then
    print("Returning to original Y-level...")
    for i = 1, y_levels_dug do
        turtle.up() -- Move the turtle up one level
    end
    print("Returned to original Y-level.")
else
    print("No levels were dug, so no need to return up.")
end

print("Script finished.")
