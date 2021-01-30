FUEL_SLOT   = 16
FIRST_SLOT  = 1

function fuelCheck(min)
    fuel = turtle.getFuelLevel()
    print("fuelLevel"..fuel)
    while fuel < min do
        turtle.select(FUEL_SLOT)
        turtle.suck()
        turtle.refuel(64)
        fuel = turtle.getFuelLevel()
        print("Refuel"..fuel)
    end
end

function digBlocks(n)
	fuelCheck(n)
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

function workUntilDead()
	targetHeight=5
	targetWidth=5
	for i=0, targetHeight do
		digBlocks(targetWidth)
		turtle.digUp()
		turtle.up()
		turtle.turnLeft()
		turtle.turnLeft()
	end
end
-- #############
-- Main
workUntilDead()
