local mon = peripheral.wrap("back")
local dir = "drawPictureFix/"
--local testPic = dir.."test.nfp"
local dennisPic = dir.."dennis.nfp"
local dennisCmd = dir.."dennis.clist"
--local cmd = dir.."kasumi.clist"
local dennisMvf = dir.."dennis.mvf"

function setColorPalette(cmdf)
  local fh = fs.open(cmdf, 'r')
  repeat
    cln = fh.readLine()
    if cln ~= nil then
      coln = fh.readLine()
      term.setPaletteColour(tonumber(cln), tonumber(coln))
    end
  until line == nil
  fh.close()
end
mon.setTextScale(0.5)
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
end