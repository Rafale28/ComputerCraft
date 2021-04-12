local sencho = paintutils.loadImage("sencho.nfp")
local fbk = paintutils.loadImage("fbk.nfp")
local mon = peripheral.wrap("back")

mon.setTextScale(0.5)
term.redirect(mon)

while true do

    paintutils.drawImage(sencho, 1, 1)
    sleep(1)
    paintutils.drawImage(fbk, 1, 1)
    sleep(1)
end
