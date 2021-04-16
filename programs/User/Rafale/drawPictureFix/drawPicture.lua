local mon = peripheral.wrap("back")
local dir = "drawPictureFix/"
local pic = dir.."kasumi.nfp"
local cmd = dir.."kasumi.clist"

mon.setTextScale(0.5)

print("set color.")
local setColorFile = fs.open(cmd)
shell.run(setColorFile)

print("print util")
term.redirect(mon)
img = paintutils.loadImage(fname)
paintutils.drawImage(img, 1, 1)
