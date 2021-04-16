local mon = peripheral.wrap("back")
local dir = "drawPictureFix/"
local senchoPic = dir.."sencho.nfp"
local kasumiPic = dir.."kasumi.nfp"
local aquaPic = dir.."aqua.nfp"
local testPic = dir.."test.nfp"
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
function kasumiColor()
  term.setPaletteColour(colors.white, 0xC8BFC8)
  term.setPaletteColour(colors.orange, 0xCCADA9)
  term.setPaletteColour(colors.magenta, 0xE5DFDB)
  term.setPaletteColour(colors.lightBlue, 0xF9F4EC)
  term.setPaletteColour(colors.yellow, 0xAC9E93)
  term.setPaletteColour(colors.lime, 0x3C4B9A)
  term.setPaletteColour(colors.pink, 0x8A7669)
  term.setPaletteColour(colors.gray, 0x883179)
  term.setPaletteColour(colors.lightGray, 0xB1609F)
  term.setPaletteColour(colors.cyan, 0x232B67)
  term.setPaletteColour(colors.purple, 0x493848)
  term.setPaletteColour(colors.blue, 0x6C625B)
  term.setPaletteColour(colors.brown, 0x978975)
  term.setPaletteColour(colors.green, 0x65AEC4)
  term.setPaletteColour(colors.red, 0xBBBC6D)
  term.setPaletteColour(colors.black, 0x729744)
end
function aquaColor()
  term.setPaletteColour(colors.white, 0xFBF9F6)
  term.setPaletteColour(colors.orange, 0xB8C7DE)
  term.setPaletteColour(colors.magenta, 0xDFD3DA)
  term.setPaletteColour(colors.lightBlue, 0xE2AFD2)
  term.setPaletteColour(colors.yellow, 0xADB1CE)
  term.setPaletteColour(colors.lime, 0xD397C6)
  term.setPaletteColour(colors.pink, 0xA46A99)
  term.setPaletteColour(colors.gray, 0x6B4F65)
  term.setPaletteColour(colors.lightGray, 0xC26FB1)
  term.setPaletteColour(colors.cyan, 0x6D8FB0)
  term.setPaletteColour(colors.purple, 0x442A44)
  term.setPaletteColour(colors.blue, 0xAB94A8)
  term.setPaletteColour(colors.brown, 0xD59DAE)
  term.setPaletteColour(colors.green, 0xEACFAE)
  term.setPaletteColour(colors.red, 0x945D63)
  term.setPaletteColour(colors.black, 0xBA9C52)
end


mon.setTextScale(0.5)
--print("set color.")
--local setColorFile = fs.open(cmd)
--shell.run(setColorFile)

term.redirect(mon)

img = paintutils.loadImage(testPic)
paintutils.drawImage(img, 1, 1)
sleep(20)

while true do
  --print("set color.")
  senchoColor()
  --print("print util")
  img = paintutils.loadImage(senchoPic)
  paintutils.drawImage(img, 1, 1)
  sleep(2)

  kasumiColor()
  img = paintutils.loadImage(kasumiPic)
  paintutils.drawImage(img, 1, 1)
  sleep(2)

  aquaColor()
  img = paintutils.loadImage(aquaPic)
  paintutils.drawImage(img, 1, 1)
  sleep(2)
end