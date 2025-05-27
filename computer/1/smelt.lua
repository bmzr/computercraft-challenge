function InteractWithFurnace()
	-- put in item to smelt
	turtle.select(1)
	for i = 1, turtle.getItemCount() do
		turtle.dropDown()
	end
	-- move to front of furnace
	turtle.back()
	turtle.down()
	-- put in fuel to burn
	turtle.select(16)
	for i = 1, turtle.getItemCount() do
		turtle.drop()
	end
	-- pick up result
	turtle.down()
	turtle.forward()
	sleep(30)
	turtle.suckUp()

	-- return to top
	turtle.back()
	turtle.up()
	turtle.up()
	turtle.forward()
end

for i = 1, 3 do
	InteractWithFurnace()
end
