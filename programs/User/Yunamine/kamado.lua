-- #############
-- define functions

function initialize()
    --作業台に向いているのがホームポジション
    while (turtle.inspect())["name"] ~= "crafting_table" do
        turtle.turnLeft()
    end
end

function routine()

   turtle.turnRight()
   
   --アイテムが拾えたらまだいらない
   if turtle.suck() == nil then

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

