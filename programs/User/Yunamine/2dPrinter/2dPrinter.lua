require "Yunamine/xyzAPI"

-- ########## config
CHEST_SLOT  = 1
FUEL_SLOT   = 2
CSV_NAME = "design.csv"

xyz=XyzApi.new()

-- ########## function

function loadCSV()
    --CSVがあるか確認
    if fs.exists(CSV_NAME) then
        csv = fs.open(CSV_NAME, 'r')
    else
        print("design.csv not found!")
        while true do
            sleep(1)
        end
    end

    return csv

end

function itemCheck()

    print("")
    print("")
    print("---PHASE:Item Check---")

    -- requires 17 chests and 64 carpet

    print("")
    print("Place 17 chests on the slot "..CHEST_SLOT)
    chestWait=true    
    while chestWait do
        turtle.select(CHEST_SLOT)
        local itm = turtle.getItemDetail(CHEST_SLOT)
        if itm then
            if itm["count"] == 17 then
                chestWait = false
                print("Chest:OK")
            end
        else
            print("Chest:NG")
            sleep(5)
        end
    end

    print("")
    print("Place 64 carpets on the slot "..FUEL_SLOT)
    chestWait=true    
    while chestWait do
        turtle.select(FUEL_SLOT)
        local itm = turtle.getItemDetail(FUEL_SLOT)
        if itm then
            if itm["count"] == 64 then
                chestWait = false
                print("Carpet:OK")
            end
        else
            print("Carpet:NG")
            sleep(5)
        end
    end

    print("")
    print("---Item Check:Done---")

end

function placeChests()

    print("")
    print("")
    print("---PHASE:Place Chests---")

    xyz:moveTo(0,0,0)

    --refuel
    turtle.select(FUEL_SLOT)
    turtle.refuel(64)
    print("Refuel:OK")

    --place fuel chest
    turtle.select(CHEST_SLOT)
    turtle.placeDown()
    print("FuelChest:OK")

    --place 16 colors of watame chests
    xyz:turn("right")
    for i=1,16 do

        turtle.select(CHEST_SLOT)
        turtle.place()
        xyz:up(1)
        print("ColorChest"..i..":OK")

    end

    xyz:moveTo(0,0,0)
    xyz:turn("front")
    print("")
    print("---Place Chests:Done---")

end

function printing(csv)

    print("")
    print("")
    print("---PHASE:Printing---")

    --line
    ii=0
    while true do

        --load a line
        line=csv.readLine()

        --end of line
        if line == nil then
            break
        end

        refuel()
        print("Refuel:OK")

        reWatame()
        print("Rewatame:OK")

        xyz:moveTo(0,0,ii)

        --printing
        xyz:turn("front")
        --parse the csv a line

        col=split(line,",")
        for j,c in pairs(col) do

            xyz:moveTo(j,0,ii)

            -- alpha channel
            if c == -1 then
                --donothing
            else
                --c will be  0 - 15
                turtle.select(c+1)
                turtle.placeDown()
            end
            print(ii..","..j..":OK")

        end
        ii=ii+1
        xyz:moveTo(0,0,ii)
    end

    csv.close()
    xyz:moveTo(0,0,0)
    print("")
    print("---Printing:Done---")

end

function refuel()

    xyz:moveTo(0,0,0)

    fmin = 1000
    fuel = turtle.getFuelLevel()
    while fuel < fmin do
        turtle.select(FUEL_SLOT)
        turtle.suckDown()
        turtle.refuel(64)
        fuel = turtle.getFuelLevel()
        print("Refuel"..fuel)
    end
end

function reWatame()

    xyz:moveTo(0,0,0)
    xyz:turn("right")

    for i=1,16 do

        turtle.select(i)

        watameWait=true
        while watameWait do

            turtle.suck()
            local itm = turtle.getItemDetail(i)
            if itm then
                if itm["count"] == 64 then
                watameWait = false
                print("Color"..i..":OK")
                end
            else
                print("Color"..i..":NG")
                sleep(5)
            end
        end

        xyz:up(1)

    end

    xyz:moveTo(0,0,0)
    xyz:turn("front")

end

-- ########## routine
csv=loadCSV()
itemCheck()
placeChests()
printing(csv)