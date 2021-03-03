os.loadAPI("/TurtleAPI/logging.lua")

function turnTo(dir)
    print("turn to "..dir)
    while dir ~= logging.getDir() do
        logging.turnRight()
    end
end
function backToHome(x, y, z, dir)
    print("back to home")
    if x < logging.getPosX() then
        turnTo(logging.DIRECTION.SOUTH)
        while X ~= logging.getPosX() do
            logging.forward()
        end
    elseif X > logging.getPosX() then
        turnTo(logging.DIRECTION.NORTH)
        while X ~= logging.getPosX() do
            logging.forward()
        end
    end

    if Y < logging.getPosY() then
        turnTo(logging.DIRECTION.EAST)
        while Y ~= logging.getPosY() do
            logging.forward()
        end
    elseif Y > logging.getPosY() then
        turnTo(logging.DIRECTION.WEST)
        while Y ~= logging.getPosY() do
            logging.forward()
        end
    end

    if Z < logging.getPosZ() then
        while Z ~= logging.getPosZ() do
            logging.down()
        end
    elseif Z > logging.getPosZ() then
        while Z ~= logging.getPosZ() do
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