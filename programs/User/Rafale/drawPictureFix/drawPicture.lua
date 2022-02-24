local mon = peripheral.wrap("back")
local dir = "drawPictureFix/"
--local testPic = dir.."test.nfp"
local dennisPic = dir.."dennis.nfp"
local dennisCmd = dir.."dennis.clist"
--local cmd = dir.."kasumi.clist"
local dennisMvf = dir.."dennis.mvf"
local rinaMvf = dir.."rina.mvf"
local tsunomakiMvf = dir.."tsunomaki.mvf"
local aquaMvf = dir.."cinderella_aqua.mvf"
local ncpMvf = dir.."ncp.mvf"
local stlMvf = dir.."stl.mvf"
local egoMvf = dir.."egorock.mvf"

function setColorPalette(cmdf)
  local fh = fs.open(cmdf, 'r')
  repeat
    cln = fh.readLine()
    if cln ~= nil then
      coln = fh.readLine()
      term.setPaletteColour(tonumber(cln), tonumber(coln))
    end
  until cln == nil
  fh.close()
end
function drawPixelInternal( xPos, yPos, clr)
    term.setCursorPos( xPos, yPos )
    --term.write(" ")
    term.blit(" ", clr, clr)
end

function drawOneFrame(fh, xPos, yPos)
  colorNum = fh.readLine()
  fLine    = fh.readLine()
  for i=1, tonumber(colorNum) do
    cln = fh.readLine()
    coln = fh.readLine()
    term.setPaletteColour(tonumber(cln), tonumber(coln))
  end
  for y=1, tonumber(fLine) do
    local px    = fh.readLine()
    for x=1, string.len(px) do
      --term.setBackgroundColor(tonumber(string.sub(px,x,x)))
      drawPixelInternal(x + xPos - 1, y + yPos - 1, string.sub(px,x,x))
      --end
    end
  end
end

function drawMvfImage(mvfPath, xPos, yPos)
  local fh = fs.open(mvfPath, 'r')
  frameNum = fh.readLine()
  for i=1, tonumber(frameNum) do
    drawOneFrame(fh, xPos, yPos)
    sleep(0.1)
  end
  fh.close()
end

mon.setTextScale(0.5)
term.redirect(mon)

term.setPaletteColour(colors.black, 0x000000)
paintutils.drawFilledBox(1, 1, 256, 256, colors.black)
--img = paintutils.loadImage(testPic)
--paintutils.drawImage(img, 1, 1)
--sleep(2)

while true do
  --drawMvfImage(tsunomakiMvf, 1, 1)
  drawMvfImage(egoMvf, 1, 1)
  --drawMvfImage(stlMvf, 1, 1)
  --drawMvfImage(ncpMvf, 1, 1)
  --setColorPalette(dennisCmd)
  --img = paintutils.loadImage(dennisPic)
  --paintutils.drawImage(img, 1, 1)
  sleep(1)
end