-- ########################
-- cultivate <n>
-- ########################

-- #############
-- config
FUEL_SLOT   = 16

function fuelCheck(min)

    fuel = turtle.getFuelLevel()
    print("fuelLevel"..fuel)
    while fuel < min do
        turtle.select(FUEL_SLOT)
        turtle.suck(64)
        turtle.refuel(64)
        fuel = turtle.getFuelLevel()
        print("Refuel now:"..fuel.." min:"..min)
    end
end
-- #############
-- define functions

--右(タートル視点だと前)からアイテムをとる前提
--仕分け前のアイテム類をとる
function suckChest()

    --アイテムが取れた時だけ動作させる
    pickedup = false

    for i = 1, 16 do
        turtle.select(i)
        pickedup = pickedup or turtle.suck()
    end

    return pickedup
end

-- initialize
function initialize()



end

function routine()

    local height = 15

    -- initialize
    initialize()

    -- itemmove
    picked=suckChest()

    if pickedup then

        print("item found!!")

        -- fuelcheck
        fuelCheck(150)

        --最初はバック(true)、折り返しが前進(false)
        back = true

        -- 一歩前進/後退
        if back then
            res=turtle.back()
        else
            res=turtle.forward()
        end
        
        --格納
        if res then
            
            -- 格納対象のアイテムIDを取得し持ってたら格納
            id = getTaggedItemId("up")
            items=suckItems(id)
            print(id...":"...items)
 
        --折り返し/終了
        else
 
            -- 折り返し
            if back then

                --チェストx2分 + 1つ
                turtle.down()
                turtle.down()
                turtle.down()

                back=false

            -- 終了
            else

                --チェストx2分 + 1つ
                turtle.up()
                turtle.up()
                turtle.up()

                back=true

        end
    end
end
-- #############
-- Main
while true do
    routine()
end

