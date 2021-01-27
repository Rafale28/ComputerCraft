print("Hello World!!")
print("Test2")
for i=1, 16 do
    turtle.select(i)
    print(textutils.serialise(turtle.getItemDetail()))
end