FUEL_SLOT = 16
FIRST_SLOT = 1

function workUntilDead()
	while true do
		turtle.select(FIRST_SLOT)
		turtle.dig()
		turtle.forward()
	end
	print("Dead: (No fuel)")
end
