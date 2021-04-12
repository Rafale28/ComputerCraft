local mon = peripheral.wrap("back")
local jankenPic = "TsunomakiJanken/janken.nfp"
mon.setTextScale(0.5)
term.redirect(mon)

function playMovie(dir, num)
    paintutils.drawFilledBox(1, 1, 256, 256, colors.black)
    for i=1, num do
        fname = dir..string.format("%04d", i)..".nfp"
        img = paintutils.loadImage(fname)
        print(fname)
        paintutils.drawImage(img, 1, 1)
        sleep(0)
    end
end
function trig()
  return rs.getInput("left")
end
local jankenArray = {
  "rock",
  "paper",
  "scissors"
}
old = false;
while true do
  paintutils.drawImage(jankenPic, 1, 1)
  btn = trig()
  if (btn ~= old and btn == true) then
    jankenres = math.random(1,3)
    jankenStr = jankenArray[jankenres]
    fileName = "TsunomakiJanken/"..jankenStr.."/"..jankenStr.."_"
    playMovie(fileName, 171)
  end
  old = btn
  sleep(1)
end
