function checkIthem(slotVal) 
    x = {}
    x = turtle.getItemDetail(slotVal)
    if x then
        print(x["count"])
        print(x["name"])
    end
    --for k, v in pairs(x) do
    --    print(k,v)
    --end
end
print("Hello World!!")
for i=1, 16 do
    checkIthem(i)
end