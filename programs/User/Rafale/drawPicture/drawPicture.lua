local sencho = paintutils.loadImage("sencho.nfp")
local mon = peripheral.wrap("back")

mon.setTextScale(0.5)
term.redirect(mon)

while true do
    paintutils.drawFilledBox(1, 1, 256, 256, colors.black)
    paintutils.drawImage(sencho, 1, 1)
    sleep(2)
    paintutils.drawFilledBox(1, 1, 256, 256, colors.black)
    for i=1,65 do
        fname = "marine/marine_"
        fname = fname..string.format("%04d", i)..".nfp"
        img = paintutils.loadImage(fname)
        paintutils.drawImage(img, 1, 1)
        sleep(0)
      end
end
