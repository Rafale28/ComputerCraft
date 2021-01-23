-- ########################
-- cultivate <n>
-- ########################

-- #############
-- config
CARROT_SLOT  = 1
FUEL_SLOT   = 13

function chargeFuelFromChest()
    for i = 1, 3 do
        turtle.select(FUEL_SLOT)
        res = turtle.compareTo(FUEL_SLOT + i)
        if res == false then
            turtle.select(FUEL_SLOT + i)
            turtle.suckUp()
        end
    end
end

function fuelCheck(x)
    fuelSlot1 = FUEL_SLOT + 1 
    fuelSlot2 = FUEL_SLOT + 2 
    fuel = turtle.getFuelLevel()
    print("fuelLevel"..fuel)
    if fuel < x then
        turtle.select(fuelSlot1)
        turtle.refuel(64)
        turtle.select(fuelSlot2)
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

function toStoreCarrot(lane)
    for i = 1, 16 do
        turtle.select(CARROT_SLOT)
        if i ~= CARROT_SLOT then
            res = turtle.compareTo(i)
            if res == true then
                turtle.select(i)
                turtle.drop()
            end
        end
    end
    turtle.select(CARROT_SLOT + 1)
    for i=1, lane do
        turtle.suck()
        turtle.suck()
    end
end

function plantCarrot()
    for i = 1, 16 do
        turtle.select(CARROT_SLOT)
        if i ~= CARROT_SLOT then
            res = turtle.compareTo(i)
            if res == true then
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
        print(i,'/',MAX)
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
    fmin = 64 * 2 * lane
    fuelCheck(fmin)

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
    chargeFuelFromChest(lane)
end
-- #############
-- Main
-- Laneの数を指定(1Laneは32*4のブロック)
hLane = 2
routine(hLane)
--local minute = 60
--while true do
--    for i=40, 0, -1 do
--        print(i.."min...")
--        sleep(minute)
--    end
--    routine(hLane)
--end
