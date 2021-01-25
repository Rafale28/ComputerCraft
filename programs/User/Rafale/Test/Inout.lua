while 1 do
    if rs.getInput("left") == true then
        rs.setOutput("right",false)
        sleep(0.5)
        rs.setOutput("right",true)
        sleep(0.5)   
    else
        sleep(1)
    end
end