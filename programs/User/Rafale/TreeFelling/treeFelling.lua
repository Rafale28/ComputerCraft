BIRCH_LOG_ID = "minecraft:birch_log"
FUEL_SLOT   = 16

function fuelCheck(lane, DIR)
    fmin = 32 * lane 
    fmin = fmin + 10
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

FRONT = 0
UP = 1
DOWN = 2
BACK = 3
RIGHT = 4
LEFT = 4

function checkTree(TID, DIR)
    local status, itm = turtle.inspect()
    if DIR == FRONT then
        status, itm = turtle.inspect()
    elseif DIR == UP then
        status, itm = turtle.inspectUp()
    elseif DIR == RIGHT then
        turtle.turnRight()
        status, itm = turtle.inspect()
        turtle.turnLeft()
    elseif DIR == LEFT then
        turtle.turnLeft()
        status, itm = turtle.inspect()
        turtle.turnRight()
    end

    if status then
        if itm["name"] == TID then
            print("block is "..TID)
            return true 
        else
            return false
        end
    end
end

function Dig(DIR)
    if DIR == FRONT then
        turtle.dig()
    elseif DIR == UP then
        turtle.digUp()
    elseif DIR == DOWN then
        turtle.digDown()
    end
end

function drop(SNUM, DIR, CNT)
    turtle.select(SNUM)
    if DIR == FRONT then
        turtle.drop(CNT)
    elseif DIR == UP then
        turtle.dropUp(CNT)
    elseif DIR == DOWN then
        turtle.dropDown(CNT)
    end
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

function place()
end
function felling(TID, DIR)
    local count = 0
    if DIR == RIGHT then
        turtle.turnRight()
    elseif DIR == LEFT then
        turtle.turnLeft()
    end
    Dig(FRONT)
    move(FRONT, 1)
    while checkTree(BIRCH_LOG_ID, UP) do
        turtle.digUp()
        turtle.up()
        count = count + 1
    end
    move(DOWN, count)
    move(BACK, 1)
    place()
    if DIR == RIGHT then
        turtle.turnLeft()
    elseif DIR == LEFT then
        turtle.turnRight()
    end
end

function initialize()
    print("init")
end

function routine(TID)
    move(FRONT, 1)
    if checkTree(TID, RIGHT) then
        felling(TID, RIGHT)
    end
    move(FRONT, 4)
    if checkTree(TID, RIGHT) then
        felling(TID, RIGHT)
    end
    move(FRONT, 4)
    if checkTree(TID, RIGHT) then
        felling(TID, RIGHT)
    end
    while move(FRONT, 1) do
    end
    turtle.turnRight()
    while move(FRONT, 1) do
    end
    turtle.turnRight()
    move(FRONT, 2)
    if checkTree(TID, RIGHT) then
        felling(TID, RIGHT)
    end
    move(FRONT, 4)
    if checkTree(TID, RIGHT) then
        felling(TID, RIGHT)
    end
    move(FRONT, 4)
    if checkTree(TID, RIGHT) then
        felling(TID, RIGHT)
    end
    while move(FRONT, 1) do
    end
    store(BIRCH_LOG_ID, DOWN)
    turtle.turnRight()
    while move(FRONT, 1) do
    end
    turtle.turnRight()
    print("finish...")
end

local fuelNum = 2
initialize()
while true do
    fuelCheck(fuelNum, DOWN)
    routine(BIRCH_LOG_ID)
    sleep(60 * 30)
end