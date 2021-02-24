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

----弓の作り方
--糸: 1, 5, 9
--枝: 2, 7,10

----チェストの配置
--糸:左
--枝:右
--品:後
--目:上

function place(id,pos)

    --アイテムを確保
    turtle.select(pos)

    --ひとつづつ作る
    turtle.suck(1) 

    --拾ったアイテムを分析
    itemdetail=turtle.getItemDetail(pos)
                    
    --そもそも拾えたかどうか
    if itemdetail ~= nil then    
        
        --idのアイテムじゃないとき
        if itemdetail["name"] ~= id then

            print("it isn't a "..id)

            --上に格納
            turtle.dropUp()

            --idのアイテムじゃないならNG
            ok=false
        else
            --idのアイテムならok
            ok=true
        end
    else

        print("no items")

        --拾えてなければNG
        ok=false
    end

    return not ok
end

function bowCraft(t)

    --糸を配置
    initialize()
    turtle.turnLeft()
    while place("minecraft:string",1) do sleep(t) end
    while place("minecraft:string",5) do sleep(t) end
    while place("minecraft:string",9) do sleep(t) end

    --枝を配置
    initialize()
    turtle.turnRight()
    while place("minecraft:stick",2) do sleep(t) end
    while place("minecraft:stick",7) do sleep(t) end
    while place("minecraft:stick",10) do sleep(t) end

    --クラフト
    turtle.select(3)
    turtle.craft()

    --弓を格納
    initialize()
    turtle.turnLeft()
    turtle.turnLeft()
    turtle.drop()

end

function routine()

    bowCraft(1)

end

-- #############
-- Main

-- initialize
initialize()

while true do
    routine()
    sleep(10)
end

