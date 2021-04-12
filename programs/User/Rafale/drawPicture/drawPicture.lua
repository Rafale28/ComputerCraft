local mon = peripheral.wrap("back")
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
while true do
  playMovie("marine/marine_", 64)
  playMovie("fbk/fbk_", 203)
end
