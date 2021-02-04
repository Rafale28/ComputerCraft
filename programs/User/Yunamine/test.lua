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
        turtle.suck(64)
        turtle.refuel(64)
        fuel = turtle.getFuelLevel()
        print("Refuel now:"..fuel.."min:"..min)
    end
end
-- #############
-- define functions

function suckChest()

    go=false

    while go == false do

        for i = 1, 16 do
            turtle.select(i)
            turtle.suckDown()

        end
        
        go = true

        for i = 1, 16 do
            turtle.select(i)
            -- return the items that less than 64
            itemdetail=turtle.getItemDetail(i)
            
            if itemdetail ~= nil then

                if itemdetail["count"] ~= 64 then

                    turtle.dropDown(cnt)
                    -- = loop
                    go = false
                end    

            end
        end

        -- sleep for item charge
        print("items are less than 64")
        if go == false then
            interval = 10
            for i=interval, 1, -1 do
                print(i.."0secs...")
                sleep(10)
            end
        end
    end

end

function store(item)
    for i = 1, 16 do
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
    for i = 1, 16 do
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
    forward(2)

end

function gotoHopper()
    print("Going to a hopper to deriver")
    back(4)

end

function gotoChest(height)
    print("Returning to a chest")
    forward(7)
    down(height)

end

--Use mixed carpets as fuel
function storeFuel(item)

    for i = 1, 16 do
        turtle.select(i)
        local itm = turtle.getItemDetail(i)
        if itm then
            if itm["name"] == item then
                turtle.select(i)
                turtle.drop(itm["count"])
            end
        end
    end

end

--Rotten potatoes 
function throwUnnecessaryItems()

    for i = 1, 16 do
        turtle.select(i)
        local itm = turtle.getItemDetail(i)
        if itm then
            if itm["name"] == "minecraft:poisonous_potato" then
                turtle.select(i)
                turtle.dropUp(itm["count"])
            end
        end
    end 

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

    local height = 15

    -- initialize
    initialize()

    -- fuelcheck
    fuelCheck(150)

    -- itemmove

    suckChest()
    storeFuel("minecraft:white_carpet")

    gotoPotato(height)
    store("minecraft:potato")

    gotoCarrot()
    store("minecraft:carrot")
 
    throwUnnecessaryItems()
    
    gotoWheat()
    store("minecraft:wheat")
    
    gotoHopper()
    store("minecraft:potato")
    store("minecraft:carrot")

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
    routine()
end

