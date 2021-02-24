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

----紙の作り方
--サトウキビ: 1,2,3

----チェストの配置
--サトウキビ:左
--品:右

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

function paperCraft(t)

    --サトウキビを配置
    initialize()
    turtle.turnLeft()
    while place("minecraft:sugar_cane",1) do sleep(t) end
    while place("minecraft:sugar_cane",2) do sleep(t) end
    while place("minecraft:sugar_cane",3) do sleep(t) end

    --クラフト
    turtle.select(4)
    turtle.craft()

    --紙を格納
    initialize()
    turtle.turnRight()
    turtle.drop()

end

function routine()

    paperCraft(1)

end

-- #############
-- Main

-- initialize
initialize()

while true do
    routine()
    sleep(10)
end

