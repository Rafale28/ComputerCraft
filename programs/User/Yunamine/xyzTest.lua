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

xyz:moveTo(10,10,10)
sleep(10)
xyz:moveToRelative(-5,-5,-5)
sleep(10)
xyz:moveToRelative(-6,-6,-6)
sleep(10)
xyz:moveTo(-5,-5,-5)
sleep(10)
xyz:moveTo(0,0,0)

