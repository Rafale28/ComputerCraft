-- #############
-- define functions

function rowAction()

    turtle.select(1)

    turtle.suckUp()
    itemdetail=turtle.getItemDetail(1)
                    
    if itemdetail ~= nil then          
    
        if itemdetail["name"] ~= "minecraft:chicken" then

            --冷めたチキン以外なら前のチェストに格納
            print("gomi...")
            turtle.drop()
        else

            --冷めたチキンは下で暖める
            print("chicken!")
            turtle.dropDown()
        end
    end
end

function routine()

    rowAction()

end

-- #############
-- Main


while true do
    routine()
    sleep(1)
end

