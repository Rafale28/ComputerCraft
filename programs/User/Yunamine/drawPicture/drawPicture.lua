local sencho = paintutils.loadImage("sencho.nfp")
local fbk = {
    paintutils.loadImage("fbk/1.nfp"),
    --paintutils.loadImage("fbk/2.nfp"),
    paintutils.loadImage("fbk/3.nfp"),
    --paintutils.loadImage("fbk/4.nfp"),
    paintutils.loadImage("fbk/5.nfp"),
    --paintutils.loadImage("fbk/6.nfp"),
    paintutils.loadImage("fbk/7.nfp"),
    --paintutils.loadImage("fbk/8.nfp"),
    paintutils.loadImage("fbk/9.nfp"),
    --paintutils.loadImage("fbk/10.nfp"),
    paintutils.loadImage("fbk/11.nfp"),
    --paintutils.loadImage("fbk/12.nfp"),
    paintutils.loadImage("fbk/13.nfp"),
    --paintutils.loadImage("fbk/14.nfp"),
    paintutils.loadImage("fbk/15.nfp"),
    --paintutils.loadImage("fbk/16.nfp"),
    paintutils.loadImage("fbk/17.nfp"),
    --paintutils.loadImage("fbk/18.nfp"),
    paintutils.loadImage("fbk/19.nfp"),
    --paintutils.loadImage("fbk/20.nfp"),
    paintutils.loadImage("fbk/21.nfp"),
    --paintutils.loadImage("fbk/22.nfp"),
    paintutils.loadImage("fbk/23.nfp"),
    --paintutils.loadImage("fbk/24.nfp"),
    paintutils.loadImage("fbk/25.nfp"),
    --paintutils.loadImage("fbk/26.nfp"),
    paintutils.loadImage("fbk/27.nfp"),
    --paintutils.loadImage("fbk/28.nfp"),
    paintutils.loadImage("fbk/29.nfp"),
    --paintutils.loadImage("fbk/30.nfp"),
    paintutils.loadImage("fbk/31.nfp"),
    --paintutils.loadImage("fbk/32.nfp"),
    paintutils.loadImage("fbk/33.nfp"),
    --paintutils.loadImage("fbk/34.nfp"),
    paintutils.loadImage("fbk/35.nfp"),
    --paintutils.loadImage("fbk/36.nfp"),
    paintutils.loadImage("fbk/37.nfp"),
    --paintutils.loadImage("fbk/38.nfp"),
    paintutils.loadImage("fbk/39.nfp"),
    --paintutils.loadImage("fbk/40.nfp"),
    paintutils.loadImage("fbk/41.nfp"),
    --paintutils.loadImage("fbk/42.nfp"),
    paintutils.loadImage("fbk/43.nfp"),
    --paintutils.loadImage("fbk/44.nfp"),
    paintutils.loadImage("fbk/45.nfp"),
    --paintutils.loadImage("fbk/46.nfp"),
    paintutils.loadImage("fbk/47.nfp"),
    --paintutils.loadImage("fbk/48.nfp"),
    paintutils.loadImage("fbk/49.nfp"),
    --paintutils.loadImage("fbk/50.nfp"),
    paintutils.loadImage("fbk/51.nfp"),
    --paintutils.loadImage("fbk/52.nfp"),
    paintutils.loadImage("fbk/53.nfp"),
    --paintutils.loadImage("fbk/54.nfp"),
    paintutils.loadImage("fbk/55.nfp"),
    --paintutils.loadImage("fbk/56.nfp"),
    paintutils.loadImage("fbk/57.nfp"),
    --paintutils.loadImage("fbk/58.nfp"),
    paintutils.loadImage("fbk/59.nfp"),
    --paintutils.loadImage("fbk/60.nfp"),

}
local mon = peripheral.wrap("back")

mon.setTextScale(0.5)
term.redirect(mon)

while true do
    paintutils.drawFilledBox(1, 1, 256, 256, colors.black)
    paintutils.drawImage(sencho, 1, 1)
    sleep(2)
    paintutils.drawFilledBox(1, 1, 256, 256, colors.black)

    for i=1,30 do
        paintutils.drawImage(fbk[i], 1, 1)
        sleep(0)
      end
end
