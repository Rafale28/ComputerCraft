-- Main

local interval = 200
local stacks = 1
local source = "up"
local destination = "front"

while true do

    --suck
    for i = 1, stacks do
        turtle.select(i)
        
        if source == "up" then
            print("suck up")
            turtle.suckUp()
        elseif source == "down" then
            print("suck down")
            turtle.suckDown()
        elseif source == "front" then
            print("suck front")
            turtle.suck()
        end
        
    end
    
    --drop
    for i = 1, 16 do
        turtle.select(i)
    
        if destination == "up" then
            print("drop up")
            turtle.dropUp()
        elseif destination == "down" then
            print("drop down")
            turtle.dropDown()
        elseif destination == "front" then
            print("drop front")
            turtle.drop()
        end        
    
    end

    -- sleep
    unit = 10
    for i = interval/unit, 1 ,-1 do

        print(i*unit.."secs...")
        sleep(unit)

    end

end

