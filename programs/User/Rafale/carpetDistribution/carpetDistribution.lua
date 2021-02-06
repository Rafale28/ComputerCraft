require "/TurtleAPI/itemIdList"
FUEL_SLOT = 16

FRONT = 0
UP = 1
DOWN = 2
BACK = 3
RIGHT = 4
LEFT = 5

function fuelCheck(fmin, DIR)
    fuel = turtle.getFuelLevel()
    print("fuelLevel"..fuel)
    while fuel < fmin do
        turtle.select(FUEL_SLOT)
        if DIR == FRONT then 
            turtle.suck()
        elseif DIR == UP then
            turtle.suckUp()
        elseif DIR == DOWN then
            turtle.suckDown()
        end
        turtle.refuel(64)
        fuel = turtle.getFuelLevel()
        print("Refuel"..fuel)
    end
end

function init()
    while move(DOWN, 1) do
    end
end

function checkChest()
    local status, itm = turtle.inspect()
    if status then
        if itm["name"] == ID.chest then
            return true
        else
            return false
        end
    end
    return false
end

function move(DIR, NUM)
    ret = false
    for i=1, NUM do
        if DIR == FRONT then
            ret = turtle.forward()
        elseif DIR == UP then
            ret = turtle.up()
        elseif DIR == DOWN then
            ret = turtle.down()
        elseif DIR == BACK then
            ret = turtle.back()
        end
        if ret == false then
            return ret
        end
    end
    return ret
end
function storeCarpet()
    for i = 1, 16 do
        turtle.select(i)
        local itm = turtle.getItemDetail(i)
        if itm then
            if itm["name"] == ID.whiteCarpet then
                turtle.drop(itm["count"])
                return true
            end
        end
    end
end

local interval = 12
init()
while true do
    fuelCheck(64, DOWN)
    while move(UP, 1) do
        if checkChest() ~= false then
            storeCarpet()
        end
    end
    while move(DOWN, 1) do
    end
    for i=1, interval do
        print(((interval - i) * 10).."sec...")
        sleep(10)
    end
end