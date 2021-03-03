os.loadAPI("/TurtleAPI/logging.lua")

function turnTo(dir)
    print("turn to "..dir)
    while dir ~= logging.MY_DIRECTION do
        logging.turnRight()
    end
end
function backToHome(x, y, z, dir)
    print("back to home")
    if x < logging.MY_POSITION.X then
        turnTo(logging.DIRECTION.SOUTH)
        while X ~= logging.MY_POSITION.X do
            logging.forward()
        end
    elseif X > logging.MY_POSITION.X then
        turnTo(logging.DIRECTION.NORTH)
        while X ~= logging.MY_POSITION.X do
            logging.forward()
        end
    end

    if Y < logging.MY_POSITION.Y then
        turnTo(logging.DIRECTION.EAST)
        while Y ~= logging.MY_POSITION.Y do
            logging.forward()
        end
    elseif Y > logging.MY_POSITION.Y then
        turnTo(logging.DIRECTION.WEST)
        while Y ~= logging.MY_POSITION.Y do
            logging.forward()
        end
    end

    if Z < logging.MY_POSITION.Z then
        while Z ~= logging.MY_POSITION.Z do
            logging.down()
        end
    elseif Z > logging.MY_POSITION.Z then
        while Z ~= logging.MY_POSITION.Z do
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
    backToHome(0, 0, 0, logging.DIRECTION.NORTH)
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