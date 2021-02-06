require "/TurtleAPI/itemIdList"

function initialize() 
    while true do
        local status, itm = turtle.inspect()
        if status then
            if itm["name"] == ID.chest then
                return true
            end
        end
        turtle.turnRight()
    end
end

function suck()
    for i = 1, 16 do
        turtle.select(i)
        turtle.suck()
    end
end

function store(ITEMID)
    for i = 1, 16 do
        turtle.select(i)
        local itm = turtle.getItemDetail(i)
        if itm then
            if itm["name"] == ITEMID then
                turtle.turnRight()
                turtle.drop()
                turtle.turnLeft()
            else
                turtle.dropUp()
            end
        end
    end
end

initialize()
while true do
    suck()
    store(ID.birchSapling)
    sleep(5)
end