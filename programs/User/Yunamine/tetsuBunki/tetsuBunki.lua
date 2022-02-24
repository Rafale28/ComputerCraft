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

function routine()

    --ないと思うがとりま15,16スロットル目をあける
    --16スロット目で鉄インゴットの有無を調べるがアイテムが詰まってたらやばいので捨てとく
    --15も捨てるのは動いている間にまた16スロット目にアイテムが入らないように
    turtle.select(15)
    turtle.drop()
    turtle.select(16)
    turtle.drop()

    --タートルのインベントリを1マスずつ
    for i = 1, 15 do
        turtle.select(i)

        itemdetail=turtle.getItemDetail(i)
                            
        if itemdetail ~= nil then          
            if itemdetail["name"] = "minecraft:iron_ingot" then

                --鉄インゴットなら後ろのチェストに空きがあるか確認
                print("iron")



                turtle.turnRight()
                turtle.turnRight()
                turtle.select(16)
                local res,x=turtle.suck()

                --アイテムが入っていたら
                if res then
                    --そのまま戻す
                    turtle.drop()

                    --本流に鉄を流す
                    turtle.turnLeft()
                    turtle.select(i)
                    turtle.drop()

                    turtle.turnLeft()

                else
                    --鉄インゴットを入れる
                    turtle.select(i)
                    turtle.drop()

                    turtle.turnLeft()
                    turtle.turnLeft()
                end
            else
                
            --ポピーとかの時
            
            turtle.turnRight()
            turtle.drop()
            turtle.turnLeft()

            end
        end            
    end
end

-- #############
-- Main

-- initialize
initialize()

while true do
    routine()
    sleep(60)
end

