print("Hello World!!")
print("Test")
for i=1, 16 do
    turtle.select(i)
    print(textutils.serialise(turtle.getItemDetail()))
end