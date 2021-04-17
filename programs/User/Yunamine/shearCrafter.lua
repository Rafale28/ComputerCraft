--鉄インゴットの場所
IRONINGOT_SLOT = 2

--ハサミを置く場所
SHEAR_SLOT = 3

--待機時間(s)
WAITING = 10

function unzipIron(n)

    wait = true
    while wait do

        --アイテムがとれたら
        if turtle.suck(n) then

            --IRONINGOTの位置に完成品を入れる
            turtle.select(IRONINGOT_SLOT)
            turtle.craft()
            wait=false
            print("2 IronBrocks are detected!")
        else

            print("2 IronBrocks are not detected.")
            sleep(WAITING)
        
        end

    end

end

function makeShear(n)

    --鉄を並べる
    --  1  2  3
    --  5  6  7
    --  9 10 11
    -- 2と5にいれる

    turtle.select(IRONINGOT_SLOT)
    transferTo(5,n)

    turtle.select(SHEAR_SLOT)
    turtle.craft()

end

function dropShear()

    turtle.select(SHEAR_SLOT)
    turtle.dropDown()

end

function routine()

    --鉄ブロックを解凍(2個=>18)
    --鉄ブロックがなければここで待機
    unzipIron(2)

    --解凍した鉄インゴット18個ではさみを9こつくる
    makeShear(9)

    dropShear()
end

-- #############
-- Main
while true do
    routine()
end

