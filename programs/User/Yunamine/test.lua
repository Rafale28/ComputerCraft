-- ########################
-- cultivate <n>
-- ########################

-- #############
-- config
FUEL_SLOT   = 16

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
-- #############
-- define functions

function suckChest()

    for i = 1, 15 do
        turtle.select(i)
        turtle.suckDown()
    end

end

function store(item)
    for i = 1, 15 do
        turtle.select(i)
        local itm = turtle.getItemDetail(i)
        if itm then
            if itm["name"] == item then
                turtle.select(i)
                turtle.dropDown(itm["count"])
            end
        end
    end
end

function storeAll()
    for i = 1, 15 do
        turtle.select(i)
        turtle.dropDown()
    end
end

function gotoPotato()
    print("Going to a chest for Potatos")
    turtle.up()
    turtle.up()
    turtle.up()
    turtle.up()
    turtle.up()
    turtle.up()
    turtle.up()
    turtle.back()

 end

function gotoCarrot()
    print("Going to a chest for Carrots")
    turtle.back()
    turtle.back()

end

function gotoWheat()
    print("Going to a chest for Wheats")
    turtle.back()
    turtle.back()

end

function gotoEtc()
    print("Going to a chest for e.t.c")
    turtle.back()
    turtle.back()

end

function gotoChest()
    print("Returning to a chest")
    turtle.forward()
    turtle.forward()
    turtle.forward()
    turtle.forward()
    turtle.forward()
    turtle.forward()
    turtle.down()
    turtle.down()
    turtle.down()
    turtle.down()
    turtle.down()
    turtle.down()
    turtle.down()

end

function routine()
    -- #############
    -- fuelcheck
    fuelCheck(32)

    -- #############
    -- itemmove
    gotoPotato()
    store("minecraft:potato")
    gotoCarrot()
    store("minecraft:carrot")
    gotoWheat()
    store("minecraft:wheat")
    gotoEtc()
    storeAll()
    gotoChest()
end
-- #############
-- Main
-- Laneの数を指定(1Laneは32*4のブロック)
local minute = 60
local interval = 1

while true do
    for i=interval, 1, -1 do
        print(i.."min...")
        sleep(minute)
    end
    routine()
end

