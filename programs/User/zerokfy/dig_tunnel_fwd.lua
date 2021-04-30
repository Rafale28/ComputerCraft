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
-- 縦2マスの空間をガラスで囲う
--
iter = arg[1]

-- スロット番号16の燃料をすべて補給
turtle.select(16)
turtle.refuel()
turtle.select(1)


for i = 1, iter do
  -- 正面に進む
  turtle.dig()
  turtle.forward()
  
  -- 下段から上段(rise)
  if (i % 2) == 1 then
    place_lower()
    
    turtle.digUp()
    turtle.up()
    
    place_upper()

  -- 上段から下段(fall)
  else
    -- 上段の設置
    place_upper()

    -- 下段に移動
    turtle.digDown()
    turtle.down()

    -- 下段の設置
    place_lower()

  end
end

-- 終了処理
-- 前2マスを埋める
if (iter % 2) == 0 then
  turtle.place()
  turtle.up()
  turtle.place()
else
  turtle.place()
  turtle.down()
  turtle.place()
end

