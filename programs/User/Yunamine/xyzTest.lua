require "xyzAPI"

FUEL_SLOT   = 16

function fuelCheck(min)

    fuel = turtle.getFuelLevel()
    print("fuelLevel"..fuel)
    while fuel < min do
        turtle.select(FUEL_SLOT)
        turtle.suck(64)
        turtle.refuel(64)
        fuel = turtle.getFuelLevel()
        print("Refuel now:"..fuel.." min:"..min)
    end
end

xyz=XyzApi.new()

fuelCheck(150)

xyz:moveTo(1,1,1)
sleep(3)
xyz:moveToRelative(-1,-1,-1)
sleep(3)
xyz:moveToRelative(-1,-1,-1)
sleep(3)
xyz:moveTo(-1,-1,-1)
sleep(3)
xyz:moveTo(0,0,0)

