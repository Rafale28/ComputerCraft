mon = peripheral.find("monitor")
mon.clear()

while true do
    mon.setTextScale(5)
    time = os.time()
    day  = os.day()
    str = textutils.formatTime(time)
    
    mon.setCursorPos(1,1)
    mon.clearLine()
    mon.write(str)

    mon.setCursorPos(1,2)
    mon.clearLine()
    mon.write(day.."days")
        
    sleep(1)
end
