function getEdge(pos, num)
    while rs.getAnalogInput(pos) ~= num do
        if rs.getAnalogInput(pos) == num then
            break
        elseif rs.getAnalogInput("top") == 15 then
            break
        end
        sleep(0.1)
    end
end

count=1
rs.setAnalogOutput("front", 15)
while true do
    print(count)
    while rs.getAnalogInput("top") == 15 do
        print("OFF")
        sleep(0.1)
    end
    if count ==3 then
        rs.setAnalogOutput("front", 0)
        getEdge("left", 15)
        count = 1
        getEdge("left", 0)
    else
        rs.setAnalogOutput("front", 15)
        getEdge("right", 15)
        count = count + 1
        getEdge("right", 0)
    end
end