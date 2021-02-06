-- Main

local interval = 60
local timing = 20
local stacks = 1
local source = "front"
local destination = "up"
local path = "down"

i=1

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
   
    if i < timing then
    
        --through
        print("through...")
        for i = 1, 16 do
            turtle.select(i)
        
            if path == "up" then
                print("drop up")
                turtle.dropUp()
            elseif path == "down" then
                print("drop down")
                turtle.dropDown()
            elseif path == "front" then
                print("drop front")
                turtle.drop()
            end        
        
        end

        i=i+1

    else

        --delivery
        print("delivery!!")
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

        i=1
    end

    -- sleep
    unit = 10
    for i = interval/unit, 1 ,-1 do

        print(i*unit.."secs...")
        sleep(unit)

    end

end

