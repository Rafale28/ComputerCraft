function checkIthem(slotVal) 
    x = {}
    x = turtle.getItemDetail(slotVal)
    print(x[1])
    print(x[3])
    --for k, v in pairs(x) do
    --    print(k,v)
    --end
end
print("Hello World!!")
for i=1, 16 do
    checkIthem(i)
end