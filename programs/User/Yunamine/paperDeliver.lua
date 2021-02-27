-- #############
-- define functions

function initialize()
    --Air(nilになる)に向いているのがホームポジション
    print("----initializing----")
    while true do
        status, itm = turtle.inspect()
        if itm["name"] ~= nil then
            print("front:"..itm["name"])
            turtle.turnLeft()
        else
            break
        end
    end
    print("----done----")
end

----チェストの配置
--紙:左
--品:右

function routine()

    initialize()
    turtle.turnLeft()

    picked = false

    --拾えるまでまつ
    while picked == false do

        picked=turtle.suck()
        
    end 

    --拾えたら格納
    initialize()
    turtle.turnRight()
    turtle.drop()

end

-- #############
-- Main

-- initialize
initialize()

while true do

    routine()
    sleep(1)
end

