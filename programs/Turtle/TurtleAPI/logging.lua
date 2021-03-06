--############################
-- logging API
-- ###########################
-- config
LOG_FILE = "mylog"
POS_FILE = "myposition"
CURRENT_TIME = os.day()*24 + os.time()

DIRECTION = {
    NORTH = 0,
    EAST  = 1,
    SOUTH = 2,
    WEST  = 3
}
MOVE = {
    FORWARD = 0,
    BACK    = 1,
    RIGHT   = 2,
    LEFT    = 3,
    UP      = 4,
    DOWN    = 5
}

MY_DIRECTION = DIRECTION.NORTH
MY_POSITION = {
    X = 0,
    Y = 0,
    Z = 0
}

-- ###########################
-- functions
 
function getDir()
    return MY_DIRECTION
end
function getPosX()
    return MY_POSITION.X
end
function getPosY()
    return MY_POSITION.Y
end
function getPosZ()
    return MY_POSITION.Z
end

local function split(str, ts)
    -- 引数がないときは空tableを返す
    if ts == nil then return {} end

    local t = {} ; 
    i=1
    for s in string.gmatch(str, "([^"..ts.."]+)") do
      t[i] = s
      i = i + 1
    end
  
    return t
end
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
function write()
  local fh = fs.open(LOG_FILE, "w")
  local fp = fs.open(POS_FILE, "a")

  message = string.format("X,%d,Y,%d,Z,%d,DIR,%d", MY_POSITION.X, MY_POSITION.Y, MY_POSITION.Z, MY_DIRECTION)

  fh.writeLine(message)
  fp.writeLine(message)

  fh.close()
  fp.close()
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
 
function perseMyPosition(filename)
    local fh = fs.open(filename, 'r')
    local line = fh.readLine()
    line_splited = split(line, ",")
  
    for i=1, table.getn(line_splited) do
        if line_splited[i]     == "X" then
            MY_POSITION.X   = tonumber(line_splited[i + 1])
        elseif line_splited[i] == "Y" then
            MY_POSITION.Y   = tonumber(line_splited[i + 1])
        elseif line_splited[i] == "Z" then
            MY_POSITION.Z   = tonumber(line_splited[i + 1])
        elseif line_splited[i] == "DIR" then
            MY_DIRECTION    = tonumber(line_splited[i + 1])
        end
    end
end

function showMyPosition()
  message = string.format("X, %d, Y, %d, Z, %d", MY_POSITION.X, MY_POSITION.Y, MY_POSITION.Z)
  print(message)
  local D = "N/A"
  if MY_DIRECTION == DIRECTION.NORTH then
    D = "NORTH"
  elseif MY_DIRECTION == DIRECTION.EAST then
    D = "EAST"
  elseif MY_DIRECTION == DIRECTION.SOUTH then
    D = "SOUTH"
  elseif MY_DIRECTION == DIRECTION.WEST then
    D = "WEST"
  end
  message = string.format("DIR %s", D)
  print(message)
end
 
function myPosition(mov)
    if      mov == MOVE.FORWARD then
        if  MY_DIRECTION == DIRECTION.NORTH then
            MY_POSITION.X = MY_POSITION.X + 1
        elseif  MY_DIRECTION == DIRECTION.EAST then
            MY_POSITION.Y = MY_POSITION.Y - 1
        elseif  MY_DIRECTION == DIRECTION.SOUTH then
            MY_POSITION.X = MY_POSITION.X - 1
        elseif  MY_DIRECTION == DIRECTION.WEST then
            MY_POSITION.Y = MY_POSITION.Y + 1
        end
    elseif  mov == MOVE.BACK then
        if  MY_DIRECTION == DIRECTION.NORTH then
            MY_POSITION.X = MY_POSITION.X - 1
        elseif  MY_DIRECTION == DIRECTION.EAST then
            MY_POSITION.Y = MY_POSITION.Y + 1
        elseif  MY_DIRECTION == DIRECTION.SOUTH then
            MY_POSITION.X = MY_POSITION.X + 1
        elseif  MY_DIRECTION == DIRECTION.WEST then
            MY_POSITION.Y = MY_POSITION.Y - 1
        end
    elseif  mov == MOVE.RIGHT then
        MY_DIRECTION = MY_DIRECTION + 1
        if MY_DIRECTION > DIRECTION.WEST then
            MY_DIRECTION = DIRECTION.NORTH
        end
    elseif  mov == MOVE.LEFT then
        MY_DIRECTION = MY_DIRECTION - 1
        if MY_DIRECTION < DIRECTION.NORTH then
            MY_DIRECTION = DIRECTION.WEST
        end
    elseif  mov == MOVE.UP then
        MY_POSITION.Z = MY_POSITION.Z + 1
    elseif  mov == MOVE.DOWN then
        MY_POSITION.Z = MY_POSITION.Z - 1
    end
end
-- return a function which writes succeeded/failed msg to a logfile
--function createLoggedFunc(func, succeeded_log, failed_log)
function createLoggedFunc(func, mov)
  -- failed_log = failed_log or succeeded_log
  return function(...)
    local status, error_msg = func(...)
    --writeTimeStamp()
    if status then
        myPosition(mov)
        write()
    end
    return status, error_msg
  end
end
 
-- redefine six movement functions in Turtle API
forward     = createLoggedFunc(turtle.forward,   MOVE.FORWARD )
back        = createLoggedFunc(turtle.back,      MOVE.BACK    )
up          = createLoggedFunc(turtle.up,        MOVE.UP      )
down        = createLoggedFunc(turtle.down,      MOVE.DOWN    )
turnRight   = createLoggedFunc(turtle.turnRight, MOVE.RIGHT   )
turnLeft    = createLoggedFunc(turtle.turnLeft,  MOVE.LEFT    )
--forward = createLoggedFunc(turtle.forward, "turtle.forward()", "-- turtle.forward()")
--back = createLoggedFunc(turtle.back, "turtle.back()", "-- turtle.back()")
--up = createLoggedFunc(turtle.up, "turtle.up()", "-- turtle.up()")
--down = createLoggedFunc(turtle.down, "turtle.down()", "-- turtle.down()")
--turnRight = createLoggedFunc(turtle.turnRight, "turtle.turnRight()")
--turnLeft = createLoggedFunc(turtle.turnLeft, "turtle.turnLeft()")