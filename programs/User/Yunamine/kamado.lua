-- #############
-- define functions

function initialize()
    --作業台に向いているのがホームポジション
    while true do
        status, itm = turtle.inspect()
        if itm["name"] ~= "minecraft:crafting_table" then
            turtle.turnLeft()
        else
            break
        end
    end
end

function routine()

   turtle.turnRight()
   
   --アイテムが拾えたらまだいらない
   if turtle.suck() == nil then

        print("Delivery")

        turtle.turnLeft()
        turtle.turnLeft()
        turtle.suck()
        turtle.turnRight()
        turtle.turnRight()
        turtle.drop()
        turtle.turnLeft()
   end
end

-- #############
-- Main

-- initialize
initialize()

while true do
    routine()
end

