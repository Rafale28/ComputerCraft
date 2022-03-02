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
while true do
    play(playdata)
end