local mon = peripheral.wrap("back")
local dir = "drawPictureFix/"
local senchoPic = dir.."sencho.nfp"
local kasumiPic = dir.."kasumi.nfp"
local aquaPic = dir.."aqua.nfp"
local tsunomakiPic = dir.."rock_0117.nfp"
local testPic = dir.."test.nfp"
local dennisPic = dir.."dennis.nfp"
local dennisCmd = dir.."dennis.clist"
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
function tsunomakiColor()
  term.setPaletteColour(colors.white, 0x0C1C2F)
  term.setPaletteColour(colors.orange, 0x042B4D)
  term.setPaletteColour(colors.magenta, 0x285B8E)
  term.setPaletteColour(colors.lightBlue, 0x183154)
  term.setPaletteColour(colors.yellow, 0x394055)
  term.setPaletteColour(colors.lime, 0x6C8B9D)
  term.setPaletteColour(colors.pink, 0x5F5E5C)
  term.setPaletteColour(colors.gray, 0xE6D6CF)
  term.setPaletteColour(colors.lightGray, 0xFBF7F2)
  term.setPaletteColour(colors.cyan, 0xAAA4A6)
  term.setPaletteColour(colors.purple, 0xFBF2D0)
  term.setPaletteColour(colors.blue, 0xECD4AB)
  term.setPaletteColour(colors.brown, 0xCD9F66)
  term.setPaletteColour(colors.green, 0xE4B296)
  term.setPaletteColour(colors.red, 0xBB3039)
  term.setPaletteColour(colors.black, 0xB4071D)
end

function setColorPalette(cmdf)
  local fh = fs.open(cmdf)
  repeat
    line = fh.readLine()
    term.setPaletteColour(line)
  until line == nil
  fh.close()
end
mon.setTextScale(0.5)
--print("set color.")
--local setColorFile = fs.open(cmd)
--shell.run(setColorFile)

term.redirect(mon)

term.setPaletteColour(colors.black, 0x000000)
paintutils.drawFilledBox(1, 1, 256, 256, colors.black)
img = paintutils.loadImage(testPic)
paintutils.drawImage(img, 1, 1)
sleep(2)

while true do
  setColorPalette(dennisCmd)
  img = paintutils.loadImage(dennisPic)
  paintutils.drawImage(img, 1, 1)
  sleep(2)
  --senchoColor()
  --img = paintutils.loadImage(senchoPic)
  --paintutils.drawImage(img, 1, 1)
  --sleep(2)

  --kasumiColor()
  --img = paintutils.loadImage(kasumiPic)
  --paintutils.drawImage(img, 1, 1)
  --sleep(2)

  --aquaColor()
  --img = paintutils.loadImage(aquaPic)
  --paintutils.drawImage(img, 1, 1)
  --sleep(2)

  --tsunomakiColor()
  --img = paintutils.loadImage(tsunomakiPic)
  --paintutils.drawImage(img, 1, 1)
  --sleep(2)
end