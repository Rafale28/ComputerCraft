require "Yunamine/xyzAPI"

xyz=XyzApi.new()

while true do
    for i = 1, 16 do
        turtle.select(i)
        local itm = turtle.getItemDetail(i)
        if itm then
            if  itm["name"] == "minecraft:shear" then
                xyz:turn("right")
            else
                xyz:turn("front")
            end
            turtle.drop()
        end
    end
    sleep(10)
end