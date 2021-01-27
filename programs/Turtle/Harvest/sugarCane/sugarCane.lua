-- ########################
-- cultivate <n>
-- ########################

-- #############
-- config
SUGAR_SLOT  = 1
FUEL_SLOT   = 16

function fuelCheck(lane)
    fmin = 16 * 2 * lane 
    fmin = fmin + 10
    fuel = turtle.getFuelLevel()
    print("fuelLevel"..fuel)
    while fuel < fmin do
        turtle.select(FUEL_SLOT)
        turtle.suckDown()
        turtle.refuel(64)
        fuel = turtle.getFuelLevel()
        print("Refuel"..fuel)
    end
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
    while res do
        print(i)
        harvest()
        res =  turtle.forward()
        i = i + 1
    end
    turtle.digDown()
    print("Harvest Line Finished.")
end

function harvestleftShift()
    turtle.turnLeft()
    turtle.dig() 
    res =  turtle.forward()
    turtle.dig() 
    res =  turtle.forward()
    turtle.turnLeft()
end
--
--function harvestrightShift()
--    turtle.turnRight()
--    turtle.dig() 
--    res =  turtle.forward()
--    turtle.turnRight()
--end
--
--function suckStack(num)
--    for i=1, num do
--        turtle.select(i)
--        turtle.suck()
--        while turtle.getItemCount(i) < 64 do
--            turtle.suck()
--        end
--    end
--    for i=(num + 1), 16 do
--        turtle.select(i)
--        turtle.drop()
--    end
--end

sugarCane  = "minecraft:sugar_cane"
function toStoreSugar()
    for i = 1, 16 do
        turtle.select(i)
        local itm = turtle.getItemDetail(i)
        if itm then
            if itm["name"] == sugarCane then
                turtle.select(i)
                turtle.drop(itm["count"])
            end
        end
    end
    turtle.turnLeft()
    turtle.forward()
    turtle.forward()
    turtle.turnLeft()
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
-- Main
-- Laneの数を指定(1Laneは32*4のブロック)
hLane = 1
local minute = 60
local interval = 30

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
