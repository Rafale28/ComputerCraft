function checkIthem(slotVal) 
    x = turtle.getItemDetail(slotVal)
    for k, v in pairs(x) do
        print(k,v)
    end
end
print("Hello World!!")
for i=1, 16 do
    checkIthem(i)
end