-- #############
-- define functions

function initialize()
    --Airに向いているのがホームポジション
    while true do
        status, itm = turtle.inspect()
        if itm["name"] ~= "minecraft:air" then
            turtle.turnLeft()
        else
            break
        end
    end
end

function rowAction(start)

    for i = start, start+2 do

        turtle.select(i)
        turtle.suck()
        itemdetail=turtle.getItemDetail(i)
                        
        if itemdetail ~= nil then          
            if itemdetail["name"] ~= "minecraft:iron_ingot" then

                --鉄インゴット以外なら奥のチェストに格納
                print("Poppy...")

                turtle.turnRight()
                turtle.drop()
                turtle.turnLeft()
                
                --もう一回同じ場所でトライ
                i=i-1
            end
        else

            --アイテムが取れなかったとき --> 鉄インゴットが不足している
            --60秒待機してもう一回
            print("iron ingot is not enough to craft a block")
            print("sleep 60secs")
            sleep(60)
            i=i-1
        end
        print(i..":ok")
    end

end

function routine()

   turtle.turnRight()
   
    --鉄を並べる(ポピーは奥のチェストにしまう)
    --  1  2  3
    --  5  6  7
    --  9 10 11
    rowAction(1)
    rowAction(5)
    rowAction(9)

    print("ready to craft")
    turtle.craft()
    
    --格納
    turtle.turnRight()
    turtle.turnRight()
    turtle.select(1)
    turtle.drop()
    print("a block crafted")

end

-- #############
-- Main

-- initialize
initialize()

while true do
    routine()
    sleep(1)
end
