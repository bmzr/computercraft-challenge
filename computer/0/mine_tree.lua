local logNames = {
    "minecraft:oak_log",
    "minecraft:spruce_log",
    "minecraft:birch_log",
    "minecraft:jungle_log",
    "minecraft:acacia_log",
    "minecraft:dark_oak_log",
    "minecraft:mangrove_log",
    "minecraft:cherry_log",
    "minecraft:crimson_stem", -- Nether "logs"
    "minecraft:warped_stem"   -- Nether "logs"
    -- Add any other log types you want to detect (e.g., modded logs)
}

-- Function to check if a block is a log
local function isLog(block)
    if block and block.name then
        for _, logName in ipairs(logNames) do
            if block.name == logName then
                return true
            end
        end
    end
    return false
end

if turtle.detect() then
    local blockAhead = turtle.inspect()
    if isLog(blockAhead) then
        turtle.dig()
        if turtle.forward() then
            -- mine all logs above
            while turtle.detectUp() do
                local blockAbove = turtle.inspectUp()
                if isLog(blockAbove) then
                    turtle.digUp()
                    turtle.up()
                else
                    break -- Stop if it's not a log
                end
            end
            -- Return to original Y level (or just above the next block)
            while not (turtle.detectDown()) do
                turtle.down()
            end
        end
    end
end