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

for i = 1, 5 do
  -- 正面に進む
  turtle.dig()
  turtle.forward()
  
  -- 下段から上段(rise)
  if (i % 2) == 0 then
    -- 下段の設置
    place_lower()
    
    -- 上段に移動
    turtle.digUp()
    turtle.up()
    
    -- 上段の設置
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

