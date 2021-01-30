FUEL_SLOT = 16
FIRST_SLOT = 1

function getFuel(fuelSlotEnd)
	turtle.select(FUEL_SLOT)
	turtle.suckUp()
	turtle.refuel(64)
    fuel = turtle.getFuelLevel()
    print("fuelLevel"..fuel)
end

function dig()
	while turtle.dig() do
		os.sleep(0.5)
	end
	return turtle.forward()
end

function digBlocks(len)
	for i=0, len do
		s = dig()
	end
	return s
end

function workUntilDead()
	getFuel()
	for i=1, 32 do
		turtle.select(FIRST_SLOT)
		dig()
		while turtle.detectUp() do
			turtle.up()
			dig()
		end
		while turtle.detectDown() ~= 0 do
			turtle.down()
		end

		if turtle.getFuelLevel() == 0 then
			break
		end
	end
	print("Dead: (No fuel)")
end

-- #############
-- Main
workUntilDead()
