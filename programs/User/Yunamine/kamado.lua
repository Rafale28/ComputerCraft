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

   turtle.turnLeft()
   
   --アイテムが拾えたらまだいらない
   if turtle.suck() == nil then

        turtle.turnRight()
        turtle.turnRight()
        turtle.suck()
        turtle.turnLeft()
        turtle.turnLeft()
        turtle.drop()
        turtle.turnRight()
   end
end

-- #############
-- Main

-- initialize
initialize()

while true do
    routine()
end

