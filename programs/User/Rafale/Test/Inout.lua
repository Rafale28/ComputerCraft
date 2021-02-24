LOG_FILE = "mylog"

function fwrite(TEXT)
    fh = fs.open(LOG_FILE, 'a')
    fh.writeLine("-- "..TEXT)
    fh.close()
end

for i=1, 10 do
    curtime =  os.day()*24 + os.time()
    fwrite(tostring(curtime))
    sleep(1)
    print(i)
end
