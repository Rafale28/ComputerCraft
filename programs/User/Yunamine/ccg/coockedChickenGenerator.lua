-- 動き
-- 1. チキン狩り発動までの残り時間をファイルから確認　初期は20分=1200sec
-- 2. 1で確認した時間待機(しつつ残り時間をファイルに更新していく)
-- 3. チキン狩り(全滅するまで)
-- 4. 卵発射(なくなるまで？)
-- 5. 1に戻る

-- #############
-- define functions
logname="coockedChickenGenerator.log"
chickenHuntingTime=10
estimate = 0
estimateInit=1200

function updateLog(e)

    if fs.exists(logname) then
        fs.delete(logname)
    end

    log = fs.open(logname, 'w')
    log.write(e)
    log.close()

end

function initialize()

    print("----initializing----")

    print("STEP1:Open the log file")
    -- 1. チキン狩り発動までの残り時間をファイルから確認
    --ある場合は残り時間を更新
    if fs.exists(logname) then
        log = fs.open(logname, 'r')
        estimate=tonumber(log.readLine())
        log.close()

        --ない場合は0でつくる
    else
        log = fs.open(logname, 'w')
        log.write("0")
        estimate=0
        log.close()
    end
end
 
function routine()
-- 2. 1で確認した時間待機(しつつ残り時間をファイルに更新していく)
    print("STEP2:Wait for the chickens grow up")
    for i=estimate,0,-1 do 
        sleep(1)
        updateLog(i)
        print(i.."secs")
    end

-- 3. チキン狩り(全滅するまで)
    print("STEP3:Hunting the chickens")
    exist=true
    while exist do
        local res,x=turtle.attack()
        exist=res
    end

-- 4. 卵発射(なくなるまで？)
    print("STEP4:Launch the eggs")
    for i = 1, 16 do
        turtle.select(i)
        local itm = turtle.getItemDetail(i)
        if itm then
            turtle.dropUp(itm["count"])
        end
    end
    estimate = estimateInit
end

-- #############
-- Main

-- initialize
initialize()

while true do
    routine()
    sleep(1)
end

