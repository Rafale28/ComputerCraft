os.loadAPI("/TurtleAPI/logging.lua")

function turnTo(dir)
    while dir ~= MY_DIRECTION do
        logging.turnRight()
    end
end
function goTo(x, y, z, dir)
    if x < MY_POSITION.X then
        turnTo(DIRECTION.SOUTH)
        while X ~= MY_POSITION.X do
            logging.forward()
        end
    elseif X > MY_POSITION.X then
        turnTo(DIRECTION.NORTH)
        while X ~= MY_POSITION.X do
            logging.forward()
        end
    end

    if Y < MY_POSITION.Y then
        turnTo(DIRECTION.EAST)
        while Y ~= MY_POSITION.Y do
            logging.forward()
        end
    elseif Y > MY_POSITION.Y then
        turnTo(DIRECTION.WEST)
        while Y ~= MY_POSITION.Y do
            logging.forward()
        end
    end

    if Z < MY_POSITION.Z then
        while Z ~= MY_POSITION.Z do
            logging.down()
        end
    elseif Z > MY_POSITION.Z then
        while Z ~= MY_POSITION.Z do
            logging.up()
        end
    end
    turnTo(dir)
end

print("Hello World!!")
if fs.exists(logging.LOG_FILE) then
    term.write("Return to home position..")
    print("ok")
    logging.perseMyPosition(logging.LOG_FILE)
    logging.showMyPosition()
    --logging.backupFile(logging.LOG_FILE, "logbak")
    goTo(0, 0, 0, DIRECTION.NORTH)
else -- ファイルが残っていないのは初めてこのプログラム動かすということ
    for i=1, 5 do
        logging.forward()
        logging.showMyPosition()
    end
    logging.turnRight()
    print("turn right")
    for i=1, 4 do
      logging.forward()
      logging.showMyPosition()
    end
    logging.up()
    logging.up()
    logging.turnRight()
    logging.forward()
    logging.down()
    logging.showMyPosition()
end