--############################
-- logging API
-- version 0.5a
-- http://hevohevo.hatenablog.com/
 
-- ### how to use
--[[
os.loadAPI("logging")
 
-- backup files
logging.backupFile(LOG_FILE)
logging.backupFile(REV_FILE)
 
-- default logfile name is "mylog"
logging.forward() -- turtle.fowrard() and logging
logging.back()
logging.up()
logging.down()
logging.turnRight()
logging.turnLeft()
 
-- write a log forcibly
logging.write("-- my message!!")
 
-- write a timestamp
logging.writeTimeStamp(LOG_FILE)
 
-- createLoggedFunc(function, succeeded_log, *failed_log)
-- return a function which writes succeeded/failed msg to a logfile
-- if you omit "failed_log" argument, succeeded_log is written in true/false cases
myRefuel = logging.createLoggedFunc(turtle.refuel, "turtle.refuel()")
myRefuel()
 
-- make a reverted log file, and return start position by running REV_FILE
logging.forward()
logging.turnRight()
logging.up()
 
local rev_filename = logging.makeRevFile()
shell.run(rev_filename)
--]]
 
-- ###########################
-- config
LOG_FILE = "mylog"
REV_FILE = "myrev"
CURRENT_TIME = os.day()*24 + os.time()
 
TRANS_TBL = {}
TRANS_TBL["turtle.forward()"] = "turtle.back()"
TRANS_TBL["turtle.back()"] = "turtle.forward()"
TRANS_TBL["turtle.up()"] = "turtle.down()"
TRANS_TBL["turtle.down()"] = "turtle.up()"
TRANS_TBL["turtle.turnRight()"] = "turtle.turnLeft()"
TRANS_TBL["turtle.turnLeft()"] = "turtle.turnRight()"
 
 
-- ###########################
-- functions
 
-- backupFile("mylog")
--  ==> move to "mylog-bak"
function backupFile(filename, tail_str)
  local tail_str = tail_str or "-bak"
  if fs.exists(filename) then
    fs.delete(filename..tail_str)
    fs.move(filename, filename..tail_str)
    return true
  else
    return false, "File doesn't exist"
  end
end
 
-- write a log message as you like
function write(message, filename)
  local fh = fs.open(filename or LOG_FILE, "a")
  fh.writeLine(message)
  fh.close()
end
 
-- write a time stamp "-- daytime: 678.441"
function writeTimeStamp(filename)
  local fh = fs.open(filename or LOG_FILE, "a")
  fh.writeLine("-- daytime: "..tostring(os.day()*24+os.time()))
  fh.close()
end
 
-- readTimeStamp("-- daytime: 678.441")
-- => 678.441
-- readTimeStamp("turtle.forward()")
-- => false
local function readTimeStamp(str)
  if type(str) == "string" and #str > 14 then
--    return tonumber(string.match(str, "-- daytime: (%d+.%d+)")) or false
    return tonumber(string.sub(str, 13, -1)) or false
  else
    return false
  end
end
 
-- transrate from log messages to reverted functions
--  with confirming timestamp
local function readTrans(filename, trans_tbl)
  local fh = fs.open(filename or LOG_FILE, 'r')
  local tmp_tbl = {}
  repeat
    local line = fh.readLine()
    local time_stamp = readTimeStamp(line)
    if time_stamp and time_stamp > CURRENT_TIME then
      break
    else
      table.insert(tmp_tbl, TRANS_TBL[line])
    end
  until line == nil
  fh.close()
  return tmp_tbl
end
 
-- reverse reverted-func table, and write to REV_FILE
local function reverseWrite(my_array, filename)
  local fh = fs.open(filename or REV_FILE, 'a')
  fh.writeLine("-- "..tostring(CURRENT_TIME))
  for i=#my_array,1,-1 do
    if my_array[i] then
      fh.writeLine(my_array[i])
    end
  end
  fh.close()
end
 
-- transrate from log_file to rev_file with confirming timestamps
function makeRevFile(log_filename, rev_filename)
  local log_filename = log_filename or LOG_FILE
  local rev_filename = rev_filename or REV_FILE
  reverseWrite(readTrans(log_filename, TRANS_TBL), rev_filename)
  return rev_filename
end
 
-- return a function which writes succeeded/failed msg to a logfile
function createLoggedFunc(func, succeeded_log, failed_log)
  failed_log = failed_log or succeeded_log
  return function(...)
    local status, error_msg = func(...)
    writeTimeStamp()
    if status then
      write(succeeded_log)
    else
      write(failed_log)
    end
    return status, error_msg
  end
end
 
-- redefine six movement functions in Turtle API
forward = createLoggedFunc(turtle.forward(), "turtle.forward()", "-- turtle.forward()")
back = createLoggedFunc(turtle.back(), "turtle.back()", "-- turtle.back()")
up = createLoggedFunc(turtle.up(), "turtle.up()", "-- turtle.up()")
down = createLoggedFunc(turtle.down(), "turtle.down()", "-- turtle.down()")
turnRight = createLoggedFunc(turtle.turnRight(), "turtle.turnRight()")
turnLeft = createLoggedFunc(turtle.turnLeft(), "turtle.turnLeft()")