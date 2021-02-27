os.loadAPI("/TurtleAPI/logging.lua")

print("Hello World!!")
if fs.exists(logging.LOG_FILE) then
    term.write("Return to home position..")
    logging.makeRevFile()
    logging.backupFile(logging.LOG_FILE)
    logging.backupFile(logging.REV_FILE)
    shell.run(logging.REV_FILE.."-bak")
    print("ok")
else -- ファイルが残っていないのは初めてこのプログラム動かすということ
    for i=1, 20 do
      logging.forward()
      print("fwd")
    end
    logging.turnRight()
    print("turn right")
    for i=1, 20 do
      logging.forward()
      print("fwd")
    end
end