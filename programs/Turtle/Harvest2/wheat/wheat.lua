require "Yunamine/xyzAPI"
-- ########################
-- cultivate <n>
-- ########################

-- #############
-- config
WHEAT_SLOT  = 1
FUEL_SLOT   = 16
xyz=XyzApi.new()

WHEAT_ID = "minecraft:wheat"
SEED_ID  = "minecraft:wheat_seeds"

function fuelCheck(lane)
    fmin = 1000
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

-- #############
-- define functions
function harvest()
    turtle.select(WHEAT_SLOT)
    turtle.dig()
end

function harvestLine()
    res = true
    i = 1
    while res~=0 do
        print(i,'/',MAX)
        harvest()
        res =  xyz:forward(1)
        i = i + 1
    end
    print("Harvest Line Finished.")
end

function harvestleftShift()
    xyz:turnLeft()
    turtle.dig() 
    res =  xyz:forward(1)
    xyz:turnLeft()
end

function harvestrightShift()
    xyz:turnRight()
    turtle.dig() 
    res =  xyz:forward(1)
    xyz:turnRight()
end

function toStoreWheat(lane)
    for i = 1, 16 do
        turtle.select(i)
        local itm = turtle.getItemDetail(i)
        if itm then
            if itm["name"] == WHEAT_ID then
                turtle.select(i)
                turtle.drop(itm["count"])
            elseif itm["name"] == SEED_ID then
                turtle.select(i)
                turtle.dropUp(itm["count"])
            end
        end
    end
    turtle.select(1)
    for i=1, lane do
        turtle.suckUp()
        turtle.suckUp()
    end
end

function plantSeed()
    for i = 1, 16 do
        local itm = turtle.getItemDetail(i)
        if itm then
            if itm["name"] == SEED_ID then
                turtle.select(i)
                break
            end
        end
    end
    turtle.place()
end

function plowAndPlant()
    turtle.dig()
    plantSeed()
end

function plowLine()
    res = true
    i = 1
    while res~=0 do
        print(i,'/',MAX)
        plowAndPlant()
        res =  xyz:back(1)
        i = i + 1
    end
    print("Plow Line Finished.")
end

function plowleftShift()
    xyz:turnRight()
    res =  xyz:back(1)
    plowAndPlant()
    
    xyz:turnRight()
end

function plowtrightShift()
    xyz:turnLeft()
    res =  xyz:back(1)
    plowAndPlant()
    xyz:turnLeft()
end

function switch2LeftLane()
    xyz:turnRight()
    turtle.dig() 
    res =  xyz:forward(1)
    turtle.dig() 
    res =  xyz:forward(1)
    xyz:turnRight()
end

function switch2RightLane()
    xyz:turnLeft()
    res =  xyz:back(1)
    plowAndPlant()
    res =  xyz:back(1)
    xyz:turnLeft()
end

function routine(lane)
    -- #############
    -- fuelcheck
    fuelCheck(lane)

    -- #############
    -- harvest
    for i=1, lane do
        harvestLine()
        harvestleftShift()

        harvestLine()
        harvestrightShift()

        harvestLine()
        harvestleftShift()

        harvestLine()
        if i < lane then
            switch2LeftLane()
        end
    end

    toStoreWheat(lane)
    -- #############
    -- plow and plant
    for i=1, lane do
        plowLine()
        plowleftShift()

        plowLine()
        plowtrightShift()

        plowLine()
        plowleftShift()

        plowLine()
        if i < lane then
            switch2RightLane()
        end
    end
end
-- #############

-- Initialize

-- to avoid anything on the initialize path, 
-- the turtle will move up a block
xyz:moveToRelative(0,0,1)

-- to trhough under the chest 
xyz:moveTo(0,1,1)
xyz:moveToRelative(0,0,-1)
xyz:moveTo(0,0,0)
xyz:turn("front")

--check initialized position
xyz:turn("behind")

--keep back while a half block detected
while not(turtle.detect()) do
    turtle.forward()
    print("back...")    
end

xyz:turn("front")

-- Main
-- Laneの数を指定(1Laneは32*4のブロック)
hLane = 2
local minute = 60
debug = arg[1]
ftime = arg[2]
if debug ~= 'd' then
    if debug == 't' then
        for i=ftime, 1, -1 do
            print(i.."min...")
            sleep(minute)
        end
        routine(hLane)
    end
    while true do
        routine(hLane)
        for i=40, 0, -1 do
            print(i.."min...")
            sleep(minute)
        end
    end
else
    print("debug...")
    routine(hLane)
end
