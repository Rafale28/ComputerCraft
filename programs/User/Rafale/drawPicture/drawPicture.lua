local image = paintutils.loadImage("test.nfp")
local mon = peripheral.wrap("back")

mon.setTextScale(0.5)
term.redirect(mon)
paintutils.drawImage(image, 1, 1)