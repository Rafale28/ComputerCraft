function n2is(itemName)

    --変換用のテキストを読み込む
    fp = io.open("itemIdList.txt","r")

    next = false
    res = {}
    for line in fp:lines() do

        --見つかった次の行がid
        if string.find(line,itemName) ~= nil then
            next=true
        elseif next then
            next = false
            table.insert(res,line)
        end
    end
    io.close(fp)
    return res
end