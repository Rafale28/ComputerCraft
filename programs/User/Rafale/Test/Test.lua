print("Hello World!!")
h = fs.open("time.txt", "r")
if h then
    num = h.readline()
    h.close()
else
    num = 0
end
print("start N="..num)
while true do
    h = fs.open("time.txt", "w")
    num = num + 1
    print("N="..num)
    h.writeLine(num)
    h.flush()
    h.close()
    sleep(1)
end