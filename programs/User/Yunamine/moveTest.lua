-- Main

local interval = arg[1]
local stacks = arg[2]
local source = arg[3]
local destination = arg[4]

while true do

    --suck
    for i = 1, stacks do
        turtle.select(i)
        
        if source == "up" then
            turtle.suckUp()
        else if source == "down" then
            turtle.suckDown()
        else if source == "front" then
            turtle.suck()
        end
        
    end
    
    --drop
    for i = 1, 16 do
        turtle.select(i)
    
        if destination == "up" then
            turtle.dropUp()
        else if destination == "down" then
            turtle.dropDown()
        else if destination == "front" then
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

