-- 両脇にガラスを置く
function place_block_sides()
  -- 左側
  turtle.turnLeft()
  turtle.dig()
  turtle.place()
  
  -- 右側(振り返る)
  for i = 1, 2 do
    turtle.turnLeft()
  end
  turtle.dig()
  turtle.place()

  -- 正面に向きなおる
  turtle.turnLeft()
end

-- 下段のガラス設置
function place_lower()
  -- 真下
  turtle.digDown()
  turtle.placeDown()
  
  -- 両脇
  place_block_sides()
end

-- 上段のガラス設置
function place_upper()
  -- 真上
  turtle.digUp()
  turtle.placeUp()
  
  -- 両脇
  place_block_sides()
end

--
-- 縦2マスの空間をガラスで囲う(下り版)
-- ガラスはスロット1に置くこと
-- 土はスロット5に置くこと
--
iter = arg[1]

-- スロット番号16の燃料をすべて補給
turtle.select(16)
turtle.refuel()
turtle.select(1)


for i = 1, iter do
  -- 正面(中段)を掘る
  turtle.dig()
  turtle.forward()
  place_block_sides()
  
  -- 上部を掘る
  turtle.digUp()
  turtle.up()
  place_upper()

  -- 中段に戻る
  turtle.down()

  -- 下段を掘る
  turtle.digDown()
  turtle.down()
  place_lower()

end

-- ガラス設置終了処理
-- 正面を下段から上段へ埋めていく
turtle.place()
turtle.up()
turtle.place()
turtle.up()
turtle.place()

-- 土で水源を埋める
-- 最初だけ中段に戻って下段を埋める
turtle.select(5)
turtle.down()
turtle.placeDown()

-- 後戻りしつつ前方を埋めていく
for i = 1, iter do
  turtle.back()
  turtle.place()
  turtle.up()
  turtle.place()
end


