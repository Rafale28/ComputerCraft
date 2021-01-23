print("Hello World!!")
h = fs.open("time.txt", "r")
num = h.readline()
if num == nil then
    num = 0
end
h.close()
print("start N="..num)
while true do
    h = fs.open("time.txt", "w")
    num = num + 1
    print("N="..num)
    h.writeLine(num)
    h.flush()
end