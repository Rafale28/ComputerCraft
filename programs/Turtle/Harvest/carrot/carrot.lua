-- ########################
-- cultivate <n>
-- ########################

-- #############
-- config
CARROT_SLOT  = 1
FUEL_SLOT   = 16

function fuelCheck(lane)
    fmin = 64 * 4 * lane 
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
-- #############
-- define functions
function harvest()
    turtle.select(CARROT_SLOT + 1)
    turtle.dig()
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
    print("Harvest Line Finished.")
end

function harvestleftShift()
    turtle.turnLeft()
    turtle.dig() 
    res =  turtle.forward()
    turtle.turnLeft()
end

function harvestrightShift()
    turtle.turnRight()
    turtle.dig() 
    res =  turtle.forward()
    turtle.turnRight()
end


carrot     = "minecraft:carrot"
potato     = "minecraft:potato"
pisPotato  = "minecraft:poisonous_potato"
function toStoreCarrot(lane)
    for i = 1, 16 do
        turtle.select(i)
        local itm = turtle.getItemDetail(i)
        if itm then
            if itm["name"] == carrot then
                turtle.select(i)
                turtle.drop(itm["count"])
            elseif itm["name"] == potato then
                turtle.select(i)
                turtle.drop(itm["count"])
            elseif itm["name"] == pisPotato then
                turtle.select(i)
                turtle.dropUp(itm["count"])
            end
        end
    end
    turtle.select(1)
    for i=1, lane do
        turtle.suck()
        turtle.suck()
    end
end

function plantCarrot()
    for i = 1, 16 do
        local itm = turtle.getItemDetail(i)
        if itm then
            if itm["name"] == potato then
                turtle.select(i)
                break
            elseif itm["name"] == carrot then
                turtle.select(i)
                break
            end
        end
    end
    turtle.place()
end

function plowAndPlant()
    turtle.dig()
    plantCarrot()
end

function plowLine()
    res = true
    i = 1
    while res do
        print(i)
        plowAndPlant()
        res =  turtle.back()
        i = i + 1
    end
    print("Plow Line Finished.")
end

function plowleftShift()
    turtle.turnRight()
    res =  turtle.back()
    plowAndPlant()
    
    turtle.turnRight()
end

function plowtrightShift()
    turtle.turnLeft()
    res =  turtle.back()
    plowAndPlant()
    turtle.turnLeft()
end

function switch2LeftLane()
    turtle.turnRight()
    turtle.dig() 
    res =  turtle.forward()
    turtle.dig() 
    res =  turtle.forward()
    turtle.turnRight()
end

function switch2RightLane()
    turtle.turnLeft()
    res =  turtle.back()
    plowAndPlant()
    res =  turtle.back()
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
        harvestrightShift()

        harvestLine()
        harvestleftShift()

        harvestLine()
        if i < lane then
            switch2LeftLane()
        end
    end
    toStoreCarrot(lane)
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
        for i=40, 0, -1 do
            print(i.."min...")
            sleep(minute)
        end
        routine(hLane)
    end
else
    print("debug...")
    routine(hLane)
end
