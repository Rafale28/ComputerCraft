local mon = peripheral.wrap("back")
mon.setTextScale(0.5)

while true do
    paintutils.drawFilledBox(1, 1, 256, 256, colors.black)
    for i=1,64 do
        fname = "marine/marine_"
        fname = fname..string.format("%04d", i)..".nfp"
        img = paintutils.loadImage(fname)
        print(fname)
        term.redirect(mon)
        paintutils.drawImage(img, 1, 1)
        term.restore()
        sleep(0)
      end
end
