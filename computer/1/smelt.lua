--[[
  CC:Tweaked Single Furnace Automation Script

  This script automates the smelting process for a single furnace.
  The turtle is expected to start on top of the furnace.

  The automation sequence is as follows:
  1.  Place a smeltable item into the furnace from its top.
  2.  Move from the top to the front of the furnace.
  3.  Place fuel into the furnace from its front.
  4.  Move below the furnace.
  5.  Wait for a specified duration for smelting to complete.
  6.  Collect the smelted item from the bottom of the furnace.
  7.  Move back to the initial starting position (on top of the furnace).

  Assumptions:
  -   The turtle starts one block directly on top of the furnace.
  -   There are no obstacles in the turtle's immediate path (up, down, forward, back).
  -   The turtle has smeltable items in `SMELTABLE_SLOT` and fuel in `FUEL_SLOT`.
  -   The turtle has sufficient inventory space for the smelted output.
--]]

-- Configuration Variables
local SMELTABLE_SLOT = 1 -- Inventory slot containing items to be smelted
local FUEL_SLOT = 2 -- Inventory slot containing fuel (e.g., coal, charcoal)
local SMELT_TIME_SECONDS = 20 -- Time to wait for smelting (adjust based on furnace speed)

-- Helper function to print status messages
local function log(message)
	print("[smelt] " .. message)
end

-- Function to ensure a turtle movement is successful
local function move_and_check(action, move_name)
	local success, reason = action()
	if not success then
		log("Failed to " .. move_name .. ": " .. (reason or "Unknown reason"))
		error("Aborting due to critical movement failure.") -- Stop the script on failure
	end
	return success
end

-- Main automation function
local function automateSmelting()
	log("Starting single furnace automation sequence...")

	-- Initial checks for items and fuel
	if turtle.getItemCount(SMELTABLE_SLOT) == 0 then
		log("Warning: No smeltable items found in slot " .. SMELTABLE_SLOT .. ". Script may not place items.")
	end
	if turtle.getItemCount(FUEL_SLOT) == 0 then
		log("Warning: No fuel found in slot " .. FUEL_SLOT .. ". Script may not fuel furnace.")
	end

	-- 1. Place Smeltable Item (from top)
	log("Placing smeltable item into furnace top.")
	turtle.select(SMELTABLE_SLOT)
	if turtle.getItemCount(SMELTABLE_SLOT) > 0 then
		local placed = turtle.dropDown()
		if not placed then
			log("Failed to place smeltable item. Is the furnace top blocked or full?")
		end
	else
		log("No smeltable items left in slot " .. SMELTABLE_SLOT .. ". Skipping item placement.")
	end

	-- 2. Move to Front of Furnace
	log("Moving from top to front of furnace.")
	move_and_check(turtle.back, "move off furnace top") -- Move one block back from furnace
	move_and_check(turtle.down, "move down to furnace level") -- Move down to the same level as furnace front

	-- 3. Put Fuel In (from front)
	log("Placing fuel into furnace front.")
	turtle.select(FUEL_SLOT)
	if turtle.getItemCount(FUEL_SLOT) > 0 then
		local placed = turtle.drop()
		if not placed then
			log("Failed to place fuel. Is the furnace front blocked or full?")
		end
	else
		log("No fuel left in slot " .. FUEL_SLOT .. ". Skipping fuel placement.")
	end

	-- 4. Move Below Furnace
	log("Moving below furnace.")
	move_and_check(turtle.down, "move down below furnace")
	move_and_check(turtle.forward, "move under furnace")

	-- 5. Wait for Smelting
	log("Waiting " .. SMELT_TIME_SECONDS .. " seconds for smelting to complete.")
	sleep(SMELT_TIME_SECONDS)

	-- 6. Pick Up Result (from bottom)
	log("Collecting smelted item from furnace bottom.")
	local sucked = turtle.suckUp()
	if not sucked then
		log("Failed to suck item from furnace bottom. Is the furnace empty or turtle inventory full?")
	else
		log("Smelted item collected.")
	end

	-- 7. Move Back to Top
	log("Moving back to initial position on top of furnace.")
	move_and_check(turtle.back, "move back from furnace front") -- Move back one block from furnace front
	move_and_check(turtle.up, "move up to furnace level") -- Back to furnace level, one block back
	move_and_check(turtle.up, "move up to top level") -- Move up to the top level
	move_and_check(turtle.forward, "move forward onto furnace top") -- Move forward onto the furnace

	log("Single furnace automation completed!")
end

-- Call the main function to start the automation
automateSmelting()
