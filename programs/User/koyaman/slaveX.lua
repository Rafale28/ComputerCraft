FUEL_SLOT   = 16	-- high to low number
FIRST_SLOT  = 1		-- low to high number

function fuelCheck(min)
    fuel = turtle.getFuelLevel()
	fuelSlot = FUEL_SLOT

    while fuel < min do
        turtle.select(fuelSlot)
        if not turtle.suck()
			break	-- empty item
		end
        turtle.refuel(64)
        fuel = turtle.getFuelLevel()
		fuelSlot -= 1
    end
end

function digBlocks(n)
	for i=1, n do
		turtle.select(FIRST_SLOT)
		turtle.dig()
		os.sleep(0.5)
		if turtle.forward() then
			while turtle.detect() do
				turtle.dig()
			end
			turtle.forward()
		end
		if turtle.getFuelLevel() == 0 then
			break
		end
	end
end
function dig()
	digBlocks(1)
end

function workUntilDead()
	targetHeight=5
	targetWidth=5
	targetLength=5

	fuelCheck(targetHeight*targetWidth*targetLength)
	for x=0, targetWidth do
		for y=0, targetHeight do
			digBlocks(targetLength)
			turtle.digUp()
			turtle.up()	-- 砂だったら良くない
			turtle.turnLeft()
			turtle.turnLeft()
		end
		for y=targetHeight, 0, y-=1 do
			turtle.down()
		end
		if x ~= targetWidth do
			turtle.turnLeft()
			dig()
			turtle.forward()
			turtle.turnRight()
		end
	end
	for y=0, targetHeight do
		turtle.up()
	end
	for x=targetWidth do
		turtle.turnLeft()
		turtle.turnLeft()
		turtle.forward()
	end
end

-- #############
-- Main
workUntilDead()
