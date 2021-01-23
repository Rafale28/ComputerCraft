print("Hello World!!")
for i=1, 16 do
    turtle.select(i)
    print(textutils.serialise(turtle.getItemDetail()))
end