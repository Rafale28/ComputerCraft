-- #############
-- define functions

function rowAction()

    turtle.select(1)

    turtle.suck()
    itemdetail=turtle.getItemDetail(1)
                    
    if itemdetail ~= nil then          
        if itemdetail["name"] ~= "minecraft:chicken" then

            --鉄インゴット以外なら奥のチェストに格納
            print("Poppy...")

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

