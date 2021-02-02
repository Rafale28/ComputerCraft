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

function up(n)

    for i = 1, n do

        turtle.up()

    end

end


function down(n)

    for i = 1, n do

        turtle.down()

    end

end

function forward(n)

    for i = 1, n do

        turtle.forward()

    end

end

function back(n)

    for i = 1, n do

        turtle.back()

    end

end

function gotoPotato(height)
    print("Going to a chest for Potatos")
    up(height)
    back(1)

 end

function gotoCarrot()
    print("Going to a chest for Carrots")
    back(2)

end

function gotoWheat()
    print("Going to a chest for Wheats")
    back(2)

end

function gotoEtc()
    print("Going to a chest for e.t.c")
    back(2)

end

function gotoChest(height)
    print("Returning to a chest")
    forward(7)
    down(height)

end

function initialize()

    --keep forwarding until noblock in front of the turtle
    while turtle.forward() do
    end
 
    --keep downing until noblock under the turtle
     while turtle.down() do
    end
end

function routine()

    local height = 14

    -- initialize
    initialize()

    -- fuelcheck
    fuelCheck(32)

    -- itemmove
    suckChest()
    gotoPotato(height)
    store("minecraft:potato")
    gotoCarrot()
    store("minecraft:carrot")
    gotoWheat()
    store("minecraft:wheat")
    gotoEtc()
    storeAll()
    gotoChest(height)
end
-- #############
-- Main
-- Laneの数を指定(1Laneは32*4のブロック)
local minute = 10
local interval = 60

while true do
    for i=interval, 1, -1 do
        print(i.."0secs...")
        sleep(minute)
    end
    routine()
end
