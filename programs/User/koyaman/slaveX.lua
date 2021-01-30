FUEL_SLOT = 16
FIRST_SLOT = 1

function getFuel(fuelSlotEnd)
	turtle.select(FUEL_SLOT)
	turtle.suckUp()
	turtle.refuel(64)
    fuel = turtle.getFuelLevel()
    print("fuelLevel"..fuel)
end

function workUntilDead()
	getFuel()
	for i=1, 10 do
		turtle.select(FIRST_SLOT)
		turtle.dig()
		turtle.forward()

		if turtle.getFuelLevel() = 0 then
			break
		end
	end
	print("Dead: (No fuel)")
end

-- #############
-- Main
workUntilDead()
