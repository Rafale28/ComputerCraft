-- #############
-- define functions

function initialize()

end

----はさみの作り方
--  鉄： 3,5

function place(pos)

    --アイテムを確保
    turtle.select(pos)

    --ひとつづつ作る
    turtle.suckUp(1) 

    --拾ったアイテムを分析
    itemdetail=turtle.getItemDetail(pos)
                    
    --そもそも拾えたかどうか
    if itemdetail ~= nil then    
     
        OK=true
     
    else

        print("no items")

        --拾えてなければNG
        ok=false
    end

    return not ok
end

function craft(t)

    --鉄1を配置
    print("a")
    while place(3) do sleep(t) end
    print("b")

    --鉄2を配置
    while place(5) do sleep(t) end

    --クラフト
    turtle.select(4)
    turtle.craft()

    --ハサミを格納
    turtle.dropDown()

end

function routine()

    craft(1)

end

function startCondition()

    turtle.select(9)
    local res,x=turtle.suck()

    --下のホッパーにアイテムがあったとき
    if res then
        turtle.drop()
        return false
    else
        return true
    end

end

-- #############
-- Main

-- initialize
initialize()

while true do
    if startCondition() then
        routine()
    end
    sleep(10)
end

