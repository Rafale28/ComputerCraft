function n2is(itemName)

    --変換用のテキストを読み込む
    f = io.open("itemIdList.txt","r")

    next = false
    res = {}
    for line in f:lines() do

        --見つかった次の行がid
        if string.find(line,itemName) ~= nil then
            next=true
        elseif next then
            next = false
            table.insert(res,line)
        end
    end
    return res
end