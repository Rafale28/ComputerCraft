local mon = peripheral.wrap("back")
local dir = "drawPictureFix/"
local pic = dir.."sencho.nfp"
--local cmd = dir.."kasumi.clist"


function senchoColor()
  term.setPaletteColour(colors.white, 0xFDFDFB)
  term.setPaletteColour(colors.orange, 0xFAEBD8)
  term.setPaletteColour(colors.magenta, 0xE0D2D0)
  term.setPaletteColour(colors.lightBlue, 0xD6A6A2)
  term.setPaletteColour(colors.yellow, 0xB97287)
  term.setPaletteColour(colors.lime, 0xAD556B)
  term.setPaletteColour(colors.pink, 0x8E3552)
  term.setPaletteColour(colors.gray, 0x752A48)
  term.setPaletteColour(colors.lightGray, 0x631722)
  term.setPaletteColour(colors.cyan, 0x8D2632)
  term.setPaletteColour(colors.purple, 0xAC9B9E)
  term.setPaletteColour(colors.blue, 0xA45767)
  term.setPaletteColour(colors.brown, 0xCEBEC0)
  term.setPaletteColour(colors.green, 0xC56979)
  term.setPaletteColour(colors.red, 0x889786)
  term.setPaletteColour(colors.black, 0x413230)
end

mon.setTextScale(0.5)
--print("set color.")
--local setColorFile = fs.open(cmd)
--shell.run(setColorFile)

while true do
  print("set color.")
  senchoColor()
  print("print util")
  term.redirect(mon)
  img = paintutils.loadImage(pic)
  paintutils.drawImage(img, 1, 1)
  sleep(5)
end