print("Hello World!!")
for i=1, 16 do
    x = turtle.getItemDetail(i)
    if x then
        print(x["name"])

        if x["name"] == "minecraft:poisonous_potato" then
            print("Unko!")
            print(x["count"])
            print(x["name"])
            turtle.select(i)
            turtle.dropUp(x["count"])
        end
    end
end