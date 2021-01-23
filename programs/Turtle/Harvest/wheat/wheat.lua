-- ########################
-- cultivate <n>
-- ########################

-- #############
-- config
WHEAT_SLOT  = 1
SEED_SLOT   = 5
FUEL_SLOT   = 13

function chargeFuelFromChest()
    for i = 1, 2 do
        turtle.select(FUEL_SLOT)
        res = turtle.compareTo(FUEL_SLOT + i)
        if res == false then
            turtle.select(FUEL_SLOT + i)
            turtle.suckUp()
        end
    end
end

function fuelCheck(x)
    fuelSlot1 = 14
    fuelSlot2 = 15
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
    turtle.select(WHEAT_SLOT + 1)
    turtle.dig()
end
function harvestLine()
    res = true
    i = 1
    while res do
        print(i,'/',MAX)
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

function toStoreWheat()
    for i = 1, 16 do
        turtle.select(WHEAT_SLOT)
        if i ~= WHEAT_SLOT then
            res = turtle.compareTo(i)
            if res == true then
                turtle.select(i)
                turtle.drop()
            end
        end
    end
end

function toStoreSeed()
    for i = 1, 16 do
        turtle.select(SEED_SLOT)
        if i ~= SEED_SLOT then
            res = turtle.compareTo(i)
            if res == true then
                turtle.select(i)
                turtle.dropUp()
            end
        end
    end
    turtle.select(SEED_SLOT + 1)
    turtle.suckUp()
    turtle.suckUp()
end

function plantSeed()
    for i = 1, 16 do
        turtle.select(SEED_SLOT)
        if i ~= SEED_SLOT then
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
    plantSeed()
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

function routine()
-- #############
-- fuelcheck
fuelCheck(250)

-- #############
-- harvest
harvestLine()
harvestleftShift()

harvestLine()
harvestrightShift()

harvestLine()
harvestleftShift()

harvestLine()

toStoreWheat()
toStoreSeed()
-- #############
-- plow and plant
plowLine()
plowleftShift()

plowLine()
plowtrightShift()

plowLine()
plowleftShift()

plowLine()
chargeFuelFromChest()
end
-- #############
-- Main

local minute = 60
while true do
    for i=40, 0, -1 do
        print(i.."min...")
        sleep(minute)
    end
    routine()
end