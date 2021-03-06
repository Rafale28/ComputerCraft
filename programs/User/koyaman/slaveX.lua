FUEL_SLOT   = 16	-- high to low number
FIRST_SLOT  = 1		-- low to high number

function fuelCheck(min)
    fuel = turtle.getFuelLevel()
	fuelSlot = FUEL_SLOT

	-- FIXME: loop condition
    while fuel < min do
        turtle.select(fuelSlot)
		-- FIXME: check if empty
        turtle.suck()
        turtle.refuel(64)
        fuel = turtle.getFuelLevel()
		fuelSlot = fuelSlot - 1
    end
end

function dig()
	turtle.select(FIRST_SLOT)
	turtle.dig()
	os.sleep(0.5)	-- wait until sand drops
	while turtle.detect() do	-- dig sand
		turtle.dig()
		os.sleep(0.5)	-- wait until sand drops
	end
	turtle.forward()
	-- FIXME: fuel is zero OR block is present
end

function workUntilDead()
	targetX=3
	targetY=3
	targetZ=3

	fuelCheck(targetX*targetY*targetZ)
	for x=0, targetX-1 do
		for y=0, targetY-1 do
			for z=0, targetZ-1 do	-- FIXME: 1回多い?
				dig()
				print(x, y, z)
			end
			if (y ~= targetY-1) then
				turtle.digUp()	-- FIXME: sand
			end
			turtle.up()
			turtle.turnRight()
			turtle.turnRight()
		end
		for y=targetY-1, 0, -1 do
			turtle.down()
		end
		if (x % 2 == 0) and (targetY % 2 ~= 0) then
			turtle.turnLeft()
			dig()
			turtle.turnRight()
		else
			turtle.turnRight()
			dig()
			turtle.turnLeft()
		end
	end
end

-- #############
-- Main
workUntilDead()
