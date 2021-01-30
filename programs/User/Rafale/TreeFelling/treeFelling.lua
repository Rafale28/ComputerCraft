BIRCH_LOG_ID = "minecraft:birch_log"
FUEL_SLOT   = 16

function fuelCheck(lane)
    fmin = 32 * lane 
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

FRONT = 0
UP = 1
DOWN = 2

function checkTree(TID, DIR)
    if DIR == FRONT then
        itm = turtle.inspect()
    elseif DIR == UP then
        itm = turtle.inspectUp()
    end
    if itm then
        if itm["name"] == TID then
            return true 
        else
            return false
        end
    end
end

function frontDig()
    turtle.dig()
    turtle.forward()
end

function drop(SNUM, DIR, CNT)
    turtle.select(SNUM)
    if DIR == FRONT then
        turtle.drop(CNT)
    elseif DIR == UP then
        turtle.dropUp(CNT)
    end
end

function store(TID, DIR)
    for i = 1, 16 do
        turtle.select(i)
        local itm = turtle.getItemDetail(i)
        if itm then
            if itm["name"] == TID then
                drop(i, DIR, itm["count"])
            end
        end
    end
end

function routine(TID)
    local count = 0
    fuelCheck(1)
    frontDig()
    while checkTree(BIRCH_LOG_ID, UP) do
        turtle.digUp()
        turtle.up()
        count = count + 1
    end

    for i=1, count do
        turtle.down()
    end
    turtle.back()
    store(BIRCH_LOG_ID, DOWN)
end

while true do
    sleep(1)
    if checkTree(BIRCH_LOG_ID, FRONT) then
        routine(BIRCH_LOG_ID)
    end
end