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
    end
end

function digBlocks(n)
	for i=1, n do
		turtle.select(FIRST_SLOT)
		turtle.dig()
		os.sleep(0.5)	-- wait until sand drops
		if turtle.forward() then
			while turtle.detect() do
				turtle.dig()
			end
			turtle.forward()
		else
			-- FIXME: fuel is zero OR block is present
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
	for x=0, targetWidth-1 do
		for y=0, targetHeight do
			digBlocks(targetLength)
			turtle.digUp()
			turtle.up()	-- FIXME: 砂だったら良くない
			-- 180 回転
			turtle.turnLeft()
			turtle.turnLeft()
		end
		for y=targetHeight-1, 0, -1 do
			turtle.down()
		end
		if x ~= targetWidth then
			turtle.turnRight()
			dig()
			turtle.turnLeft()
		end
	end
	for y=0, targetHeight-1 do
		turtle.up()
	end
	-- 180 回転
	turtle.turnRight()
	turtle.turnRight()
	for x=0, targetWidth do
		turtle.forward()
	end
end

-- #############
-- Main
workUntilDead()
