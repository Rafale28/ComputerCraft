require "Yunamine/xyzAPI"
-- ########################
-- cultivate <n>
-- ########################

-- #############
-- config
SUGAR_SLOT  = 1
FUEL_SLOT   = 16
xyz=XyzApi.new()

function fuelCheck(lane)
    fmin = 16 * 2 * lane *2
    fmin = fmin + 10
    fuel = turtle.getFuelLevel()
    print("fuelLevel"..fuel)
    turtle.select(FUEL_SLOT)
    turtle.suckDown()
    turtle.refuel(64)
    turtle.select(FUEL_SLOT)
    turtle.dropDown()

    fuel = turtle.getFuelLevel()
    print("Refuel"..fuel)
end
-- #############
-- define functions
function harvest()
    turtle.select(SUGAR_SLOT)
    turtle.dig()
    turtle.digDown()
end

function harvestLine()
    res = true
    i = 1
    while res~= 0 do
        print(i)
        harvest()
        res =  xyz:forward(1)
        i = i + 1
    end
    turtle.digDown()
    print("Harvest Line Finished.")
end

function harvestleftShift()
    xyz:turnLeft()
    turtle.dig() 
    res =  xyz:forward(1)
    turtle.dig() 
    res =  xyz:forward(1)
    xyz:turnLeft()
end

sugarCane  = "minecraft:sugar_cane"
function toStoreSugar()
    for i = 1, 16 do
        turtle.select(i)
        local itm = turtle.getItemDetail(i)
        if itm then
            if itm["name"] == sugarCane then
                turtle.select(i)
                turtle.dropDown(itm["count"])
            end
        end
    end
    xyz:turnLeft()
    xyz:forward(1)
    xyz:forward(1)
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
        --if i < lane then
        --    switch2LeftLane()
        --end
    end
    toStoreSugar()
end
-- #############

-- Initialize

-- to forward on the center path,
-- the turtle will move left a block
xyz:moveToRelative(-1,0,0)

xyz:moveTo(0,0,0)
xyz:turn("front")

-- Main
-- Laneの数を指定(1Laneは32*4のブロック)
hLane = 1
local minute = 60
local interval = 15 

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
        for i=interval, 0, -1 do
            print(i.."min...")
            sleep(minute)
        end
        routine(hLane)
    end
else
    print("debug...")
    routine(hLane)
end
