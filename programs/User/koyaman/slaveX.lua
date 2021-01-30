FUEL_SLOT = 16
FIRST_SLOT = 1

function fuelCheck(lane)
    fmin = 64 * 4 * lane 
    fmin = fmin + 10
    fuel = turtle.getFuelLevel()
    print("fuelLevel"..fuel)
    while fuel < fmin do
        turtle.select(FUEL_SLOT)
        turtle.suckUp()
        turtle.refuel(64)
        fuel = turtle.getFuelLevel()
        print("Refuel"..fuel)
    end
end

function workUntilDead()
	for i=1, 10 do
		fuelCheck(0)
		turtle.select(FIRST_SLOT)
		turtle.dig()
		turtle.forward()
	end
	print("Dead: (No fuel)")
end
