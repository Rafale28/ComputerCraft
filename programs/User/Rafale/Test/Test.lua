os.loadAPI("/TurtleAPI/logging.lua")

print("Hello World!!")
if fs.exists(logging.LOG_FILE) then
    term.write("Return to home position..")
    print("ok")
    logging.perseMyPosition(logging.LOG_FILE)
    logging.showMyPosition()
else -- ファイルが残っていないのは初めてこのプログラム動かすということ
    for i=1, 5 do
      logging.forward()
      print("fwd")
    end
    logging.turnRight()
    print("turn right")
    for i=1, 4 do
      logging.forward()
      print("fwd")
    end
    logging.up()
    logging.up()
    logging.turnRight()
    logging.forward()
    logging.down()
end