XyzApi = {}

function split(str, ts)
    -- 引数がないときは空tableを返す
    if ts == nil then return {} end
  
    local t = {} ; 
    i=1
    for s in string.gmatch(str, "([^"..ts.."]+)") do
      t[i] = s
      i = i + 1
    end
  
    return t
  end

logname="xyz.log"

function XyzApi.new()

    --すでにログがあるか確認
    --ある場合は座標を更新
    if fs.exists(logname) then
        log = fs.open(logname, 'r')
        line=log.readLine()
        log.close()
        xyzd=split(line,",")

        --ない場合は0,0,0,frontでつくる
    else
        log = fs.open(logname, 'w')
        log.write("0,0,0,front")
        log.close()
        xyzd={"0","0","0","front"}
    end

    log = fs.open(logname, 'a')
    return{
        x = tonumber(xyzd[1]),
        y = tonumber(xyzd[2]),
        z = tonumber(xyzd[3]),
        direction = xyzd[4],

        updateLog=function(self)

            if fs.exists(logname) then
                fs.delete(logname)
            end

            log = fs.open(logname, 'w')
            log.write(self.x..","..self.y..","..self.z..","..self.direction)
            log.close()
        end,

        getX=function(self)
            return self.X
        end,

        getY=function(self)
            return self.y
        end,

        getZ=function(self)
            return self.z
        end,

        getDirection=function(self)
            return self.direction
        end,

        getXYZ=function(self)

            return {self.x,self.y,self.z,self.direction}

        end,

        incrementXYZ=function(self,n)

            if self.direction == "front" then
                self.y=self.y+n
            elseif self.direction == "right" then
                self.x=self.x+n
            elseif self.direction == "left" then
                self.x=self.x-n
            elseif self.direction == "behind" then
                self.y=self.y-n
            end
            self:updateLog()
        end,

        forward=function(self,n)

            moved=0

            for i=1,n do 

                --動けなかったとき
                if turtle.forward() == false then
                    return moved
                else
                    moved = moved + 1
                    self:incrementXYZ(1)
                end
            end

            return moved
        end,

        back=function(self,n)

            moved=0

            for i=1,n do 

                --動けなかったとき
                if turtle.back() == false then
                    return moved
                else
                    moved = moved + 1
                    self:incrementXYZ(-1)
                end
            end

            return moved
        end,

        up=function(self,n)

            moved=0

            for i=1,n do 

                --動けなかったとき
                if turtle.up() == false then
                    return moved
                else
                    moved = moved + 1
                    self.z=self.z+1
                    self:updateLog()
                end
            end
            return moved
        end,

        down=function(self,n)

            moved=0

            for i=1,n do 

                --動けなかったとき
                if turtle.down() == false then
                    return moved
                else
                    moved = moved + 1
                    self.z=self.z-1
                    self:updateLog()
                end
            end
            return moved
        end,

        turn=function(self,d)

            if self.direction == "front" then
                if d == "front" then
                    --do nothing
                elseif d == "right" then
                    turtle.turnRight()
                    self.direction = "right"
                    self:updateLog()
                elseif d == "behind" then
                    turtle.turnRight()
                    self.direction = "right"
                    self:updateLog()
                    turtle.turnRight()
                    self.direction = "behind"
                    self:updateLog()
                elseif d == "left" then
                    turtle.turnLeft()
                    self.direction = "left"
                    self:updateLog()
                end
            elseif self.direction == "right" then
                if d == "right" then
                    --do nothing
                elseif d == "behind" then
                    turtle.turnRight()
                    self.direction = "behind"
                    self:updateLog()
                elseif d == "left" then
                    turtle.turnRight()
                    self.direction = "behind"
                    self:updateLog()
                    turtle.turnRight()
                    self.direction = "left"
                    self:updateLog()
                elseif d == "front" then
                    turtle.turnLeft()
                    self.direction = "front"
                    self:updateLog()
                end
            elseif self.direction == "left" then
                if d == "left" then
                    --do nothing
                elseif d == "front" then
                    turtle.turnRight()
                    self.direction = "front"
                    self:updateLog()
                elseif d == "right" then
                    turtle.turnRight()
                    self.direction = "front"
                    self:updateLog()
                    turtle.turnRight()
                    self.direction = "right"
                    self:updateLog()
                elseif d == "behind" then
                    turtle.turnLeft()
                    self.direction = "behind"
                    self:updateLog()
                end
            elseif self.direction == "behind" then
                if d == "behind" then
                    --do nothing
                elseif d == "left" then
                    turtle.turnRight()
                    self.direction = "left"
                    self:updateLog()
                elseif d == "front" then
                    turtle.turnRight()
                    self.direction = "left"
                    self:updateLog()
                    turtle.turnRight()
                    self.direction = "front"
                    self:updateLog()
                elseif d == "right" then
                    turtle.turnLeft()
                    self.direction = "right"
                    self:updateLog()
                end
            end
        end,

        turnLeft=function(self)

            if self.direction == "front" then
                self:turn("left")
            elseif self.direction == "right" then
                self:turn("front")
            elseif self.direction == "left" then
                self:turn("behind")
            elseif self.direction == "behind" then
                self:turn("right")
            end

        end,

        turnRight=function(self)

            if self.direction == "front" then
                self:turn("right")
            elseif self.direction == "right" then
                self:turn("behind")
            elseif self.direction == "left" then
                self:turn("front")
            elseif self.direction == "behind" then
                self:turn("left")
            end

        end,

        --front or back based on sign of n
        frontBack=function(self,n)

            if n == 0 then
                --do noting
            elseif n > 0 then
                self:forward(n)
            elseif n < 0 then
                self:back(-n)
            end
        end,

        --up or down based on sign of n
        upDown=function(self,n)

            if n == 0 then
                --do noting
            elseif n > 0 then
                self:up(n)
            elseif n < 0 then
                self:down(-n)
            end
        end,

        moveTo=function(self,tx,ty,tz)

            print("START:"..self.x..","..self.y..","..self.z.." "..self.direction)

            mx = tx - self.x
            my = ty - self.y
            mz = tz - self.z

            if mx  == 0 then
                -- do nothing 
            else
                self:turn("right")
                self:frontBack(mx)
            end

            if my  == 0 then
                -- do nothing 
            else
                self:turn("front")
                self:frontBack(my)
            end

            if mz  == 0 then
                -- do nothing 
            else
                self:upDown(mz)
            end

            print(" END :"..self.x..","..self.y..","..self.z.." "..self.direction)
        end,

        moveToRelative=function(self,tx,ty,tz)

            print("START:"..self.x..","..self.y..","..self.z.." "..self.direction)

            mx = tx
            my = ty
            mz = tz

            if mx  == 0 then
                -- do nothing 
            else
                self:turn("right")
                self:frontBack(mx)
            end

            if my  == 0 then
                -- do nothing 
            else
                self:turn("front")
                self:frontBack(my)
            end

            if mz  == 0 then
                -- do nothing 
            else
                self:upDown(mz)
            end

            print(" END :"..self.x..","..self.y..","..self.z.." "..self.direction)

        end
    }
end

