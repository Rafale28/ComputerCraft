function checkIthem(slotVal) 
    x = {}
    x = turtle.getItemDetail(slotVal)
    if x then
        print(x["count"])
        print(x["name"])
    end
end
print("Hello World!!")
for i=1, 16 do
    x = turtle.getItemDetail(slotVal)
    if x then
        print(x["name"])

        if x["name"] == "minecraft:poisonous_potato" then
            print("Unko!")
            print(x["count"])
            print(x["name"])
        end
    end
end