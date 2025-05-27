function MoveForwardTurnRight(action_function)
	turtle.turnRight()
	turtle.forward()
	action_function()
	turtle.turnRight()
end

function MoveForwardTurnLeft(action_function)
	turtle.turnLeft()
	turtle.forward()
	action_function()
	turtle.turnLeft()
end

function FarmLayer(x, z, action_function)
	for i = 1, z do
		ForwardAction(x, action_function)
		if i ~= z then
			if (i % 2) == 0 then
				MoveForwardTurnRight(action_function)
			else
				MoveForwardTurnLeft(action_function)
			end
		end
	end
	turtle.turnLeft()
	turtle.turnLeft()
end

function farm()
	if not turtle.detectDown() then
		turtle.placeDown()
	end
end

function ForwardAction(count, action_function)
	for i = 1, count do
		action_function()
		if i < count then
			turtle.forward()
		end
	end
end

function PromptInput()
	io.write("size of x?")
	local x = tonumber(io.read())
	io.write("size of z?")
	local z = tonumber(io.read())
	FarmLayer(x, z, farm)
end

PromptInput()
