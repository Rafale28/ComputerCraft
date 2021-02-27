os.loadAPI("/TurtleAPI/logging.lua")

print("Hello World!!")
for i=1, 10 do
    print("fwd")
    logging.forward()
end

local rev_file = logging.makeRevFile()
shell.run(rev_file)
