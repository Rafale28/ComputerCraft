local dfpwm = require("cc.audio.dfpwm")

function play(src)
    local speaker = peripheral.find("speaker")
    local decoder = dfpwm.make_decoder()
    --for chunk in io.lines("itagaki/speaker/data/ego_rock.dfpwm", 16 * 1024) do
    for chunk in io.lines(src, 16 * 1024) do
        local buffer = decoder(chunk)

        while not speaker.playAudio(buffer) do
            os.pullEvent("speaker_audio_empty")
        end
    end
end

playdata = arg[1]
direction = arg[2]
played=false
while true do
    if redstone.getInput(direction) then
        if played == false then
            play(playdata)
            played = true
        end
    else
        played = false
    end
    sleep(0)
end