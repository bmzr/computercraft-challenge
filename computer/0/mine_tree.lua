if turtle.detect() then
	turtle.dig()
	if turtle.forward() then
		-- mine all logs above
		while turtle.detectUp() do
			turtle.digUp()
			turtle.up()
		end
		while not (turtle.detectDown()) do
			turtle.down()
		end
	end
end
