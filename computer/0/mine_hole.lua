function MineDown()
	if turtle.detectDown() then
		turtle.digDown()
		turtle.suckDown()
	end
end

function ForwardDig(count)
	for i = 1, count do
		MineDown()
		if i < count then
			turtle.forward()
		end
	end
end

function MoveForwardTurnLeft()
	turtle.turnLeft()
	turtle.forward()
	MineDown()
	turtle.turnLeft()
end

function MoveForwardTurnRight()
	turtle.turnRight()
	turtle.forward()
	MineDown()
	turtle.turnRight()
end

function DigLayer(x, z)
	for i = 1, z do
		ForwardDig(x)
		if i ~= z then
			if (i % 2) == 0 then
				MoveForwardTurnRight()
			else
				MoveForwardTurnLeft()
			end
		end
		-- MoveForwardTurnLeft()
		-- ForwardDig(x)
		-- MoveForwardTurnRight()
		-- ForwardDig(x)
	end
	turtle.turnLeft()
	turtle.turnLeft()
	turtle.down()
end

function DigHole(x, y, z)
	for i = 1, y do
		-- pass through one y-level of the grid
		DigLayer(x, z)
	end
end

function PromptInput()
	io.write("size of x?")
	local x = io.read()
	io.write("size of y?")
	local y = io.read()
	io.write("size of z?")
	local z = io.read()
	DigHole(tonumber(x), tonumber(y), tonumber(z))
end

PromptInput()
