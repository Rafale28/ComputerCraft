require "/TurtleAPI/itemIdList"
os.loadAPI("/TurtleAPI/logging.lua")
FUEL_SLOT   = 16

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

FRONT = 0
UP = 1
DOWN = 2
BACK = 3
RIGHT = 4
LEFT = 5

function checkTree(TID, DIR)
    local status, itm = turtle.inspect()
    if DIR == FRONT then
        status, itm = turtle.inspect()
    elseif DIR == UP then
        status, itm = turtle.inspectUp()
    elseif DIR == RIGHT then
        --turtle.turnRight()
        logging.turnRight()
        status, itm = turtle.inspect()
        --turtle.turnLeft()
        logging.turnLeft()
    elseif DIR == LEFT then
        --turtle.turnLeft()
        logging.turnLeft()
        status, itm = turtle.inspect()
        --turtle.turnRight()
        logging.turnRight()
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
            --ret = turtle.forward()
            ret = logging.forward()
        elseif DIR == UP then
            --ret = turtle.up()
            ret = logging.up()
        elseif DIR == DOWN then
            --ret = turtle.down()
            ret = logging.down()
        elseif DIR == BACK then
            --ret = turtle.back()
            ret = logging.back()
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

function place(SID)
    for i = 1, 16 do
        turtle.select(i)
        local itm = turtle.getItemDetail(i)
        if itm then
            if itm["name"] == SID then
                turtle.place()
            end
        end
    end
end

function felling(TID, DIR)
    local count = 0
    if DIR == RIGHT then
        --turtle.turnRight()
        logging.turnRight()
    elseif DIR == LEFT then
        --turtle.turnLeft()
        logging.turnLeft()
    end
    Dig(FRONT)
    move(FRONT, 1)
    while checkTree(TID, UP) do
        turtle.digUp()
        --turtle.up()
        logging.up()
        count = count + 1
    end
    move(DOWN, count)
    move(BACK, 1)
    place(ID.birchSapling)
    if DIR == RIGHT then
        --turtle.turnLeft()
        logging.turnLeft()
    elseif DIR == LEFT then
        --turtle.turnRight()
        logging.turnRight()
    end
end

function initialize()
    print("init")
    if fs.exists(logging.LOG_FILE) then
        term.write("Return to home position..")
        logging.makeRevFile()
        logging.backupFile(logging.LOG_FILE)
        logging.backupFile(logging.REV_FILE)
        shell.run(logging.REV_FILE.."-bak")
        print("ok")
    end
end

function routine(TID)
    while move(FRONT, 4) do
        if checkTree(TID, RIGHT) then
            felling(TID, RIGHT)
        end
    end
    --turtle.turnRight()
    logging.turnRight()
    while move(FRONT, 1) do
    end
    --turtle.turnRight()
    logging.turnRight()
    while move(FRONT, 4) do
        if checkTree(TID, RIGHT) then
            felling(TID, RIGHT)
        end
    end
    store(TID, DOWN)
    --turtle.turnRight()
    logging.turnRight()
    while move(FRONT, 1) do
    end
    --turtle.turnRight()
    logging.turnRight()
    print("finish...")
end

function saplingCheck(SID, DIR)
    if DIR == LEFT then
        --turtle.turnLeft()
        logging.turnLeft()
    elseif DIR == RIGHT then
        --turtle.turnRight()
        logging.turnRight()
    end

    for i = 1, 16 do
        turtle.select(i)
        local itm = turtle.getItemDetail(i)
        if itm then
            if itm["name"] == SID then
                turtle.drop(itm["count"])
            end
        end
    end

    turtle.select(1)
    turtle.suck()
    if DIR == LEFT then
        --turtle.turnRight()
        logging.turnRight()
    elseif DIR == RIGHT then
        --turtle.turnLeft()
        logging.turnLeft()
    end

    for i = 1, 16 do
        turtle.select(i)
        local itm = turtle.getItemDetail(i)
        if itm then
            if itm["name"] == SID and itm["count"] >=12 then
                return true
            end
        end
    end
    return false
end

local fuelNum = 800
local interval = 20
initialize()
while true do
    fuelCheck(fuelNum, DOWN)
    if saplingCheck(ID.birchSapling, LEFT) then
        routine(ID.birchLog)
    end
    fs.delete(logging.LOG_FILE)
    for i=1, interval do
        print((interval-i + 1).."min...")
        sleep(60)
    end
end