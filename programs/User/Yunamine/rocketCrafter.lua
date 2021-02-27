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

----ロケット花火の作り方
--  紙: 1
--火薬: 6

----チェストの配置
--　紙:左
--火薬:右
--  品:上

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

function craft(t)

    --紙を配置
    initialize()
    turtle.turnLeft()
    while place("minecraft:paper",1) do sleep(t) end

    --火薬を配置
    initialize()
    turtle.turnRight()
    while place("minecraft:gunpowder",6) do sleep(t) end

    --クラフト
    turtle.select(4)
    turtle.craft()

    --花火を格納
    turtle.dropUp()

end

function routine()

    craft(1)

end

-- #############
-- Main

-- initialize
initialize()

while true do
    routine()
    sleep(10)
end

