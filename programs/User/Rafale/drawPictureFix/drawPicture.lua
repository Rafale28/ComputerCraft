local mon = peripheral.wrap("back")
local dir = "drawPictureFix/"
local pic = dir.."sencho.nfp"
--local cmd = dir.."kasumi.clist"

mon.setTextScale(0.5)

function senchoColor()
  term.setTextColour(colors.white, 0xFDFDFB)
  term.setTextColour(colors.orange, 0xFAEBD8)
  term.setTextColour(colors.magenta, 0xE0D2D0)
  term.setTextColour(colors.lightBlue, 0xD6A6A2)
  term.setTextColour(colors.yellow, 0xB97287)
  term.setTextColour(colors.lime, 0xAD556B)
  term.setTextColour(colors.pink, 0x8E3552)
  term.setTextColour(colors.gray, 0x752A48)
  term.setTextColour(colors.lightGray, 0x631722)
  term.setTextColour(colors.cyan, 0x8D2632)
  term.setTextColour(colors.purple, 0xAC9B9E)
  term.setTextColour(colors.blue, 0xA45767)
  term.setTextColour(colors.brown, 0xCEBEC0)
  term.setTextColour(colors.green, 0xC56979)
  term.setTextColour(colors.red, 0x889786)
  term.setTextColour(colors.black, 0x413230)
end

--print("set color.")
--local setColorFile = fs.open(cmd)
--shell.run(setColorFile)

print("print util")
term.redirect(mon)
img = paintutils.loadImage(pic)
paintutils.drawImage(img, 1, 1)
