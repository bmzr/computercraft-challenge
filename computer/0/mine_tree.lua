if turtle.detect() then
	turtle.dig()
	if turtle.forward() then
		while turtle.detectUp() do
			turtle.dig()
		end
	end
end
