-- ���e�ɃK���X��u��
function place_block_sides()
  -- ����
  turtle.turnLeft()
  turtle.dig()
  turtle.place()
  
  -- �E��(�U��Ԃ�)
  for i = 1, 2 do
    turtle.turnLeft()
  end
  turtle.dig()
  turtle.place()

  -- ���ʂɌ����Ȃ���
  turtle.turnLeft()
end

-- ���i�̃K���X�ݒu
function place_lower()
  -- �^��
  turtle.digDown()
  turtle.placeDown()
  
  -- ���e
  place_block_sides()
end

-- ��i�̃K���X�ݒu
function place_upper()
  -- �^��
  turtle.digUp()
  turtle.placeUp()
  
  -- ���e
  place_block_sides()
end

--
-- �c2�}�X�̋�Ԃ��K���X�ň͂�
--

for i = 1, 5 do
  -- ���ʂɐi��
  turtle.dig()
  turtle.forward()
  
  -- ���i�����i(rise)
  if (i % 2) == 0 then
    -- ���i�̐ݒu
    place_lower()
    
    -- ��i�Ɉړ�
    turtle.digUp()
    turtle.up()
    
    -- ��i�̐ݒu
    place_upper()

  -- ��i���牺�i(fall)
  else
    -- ��i�̐ݒu
    place_upper()

    -- ���i�Ɉړ�
    turtle.digDown()
    turtle.down()

    -- ���i�̐ݒu
    place_lower()

  end
end

