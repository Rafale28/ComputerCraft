local sencho = paintutils.loadImage("sencho.nfp")
local fbk = {
    paintutils.loadImage("fbk/1.nfp"),
    paintutils.loadImage("fbk/2.nfp"),
    paintutils.loadImage("fbk/3.nfp"),
    paintutils.loadImage("fbk/4.nfp"),
    paintutils.loadImage("fbk/5.nfp"),
    paintutils.loadImage("fbk/6.nfp"),
    paintutils.loadImage("fbk/7.nfp"),
    paintutils.loadImage("fbk/8.nfp"),



}
local mon = peripheral.wrap("back")

mon.setTextScale(0.5)
term.redirect(mon)

while true do
    paintutils.drawFilledBox(1, 1, 256, 256, colors.black)
    paintutils.drawImage(sencho, 1, 1)
    sleep(2)
    paintutils.drawFilledBox(1, 1, 256, 256, colors.black)

    for i=1,1,8 do
        paintutils.drawImage(fbk[i], 1, 1)
        sleep(0.1)
      end
end
