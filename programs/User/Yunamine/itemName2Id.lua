function n2i(itemName)

    --変換用のテキストを読み込む
    f = io.open("itemIdList.txt","r")

    next = false
    for line in f:lines() do

        --見つかった次の行がid
        if line == itemName then
            next=true
        elseif next then
            return line
        end


    end
    return nil
end