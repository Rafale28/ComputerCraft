XyzApi = {}

function XyzApi.new()
    return{
        x = 0,
        y = 0,
        z = 0,
        direction = "front",

        getX=function(self)
            return X
        end,

        getY=function(self)
            return y
        end,

        getZ=function(self)
            return z
        end,

        getDirection=function(self)
            return direction
        end,

        getXYZ=function(self)

            return {x,y,z,direction}

        end,

        incrementXYZ=function(self,n)

            if direction == "front" then
                y=y+n
            elseif direction == "right" then
                x=x+1
            elseif direction == "left" then
                x=x-1
            elseif direction == "behind" then
                y=y-1
            end
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
                    z=z+1
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
                    z=z-1
                end
            end
            return moved
        end,

        turn=function(self,d)

            if direction == "front" then
                if d == "front" then
                    --do nothing
                elseif d == "right" then
                    turtle.turnRight()
                    direction = "right"
                elseif d == "behind" then
                    turtle.turnRight()
                    direction = "right"
                    turtle.turnRight()
                    direction = "behind"
                end
            elseif direction == "right" then
                if d == "right" then
                    --do nothing
                elseif d == "behind" then
                    turtle.turnRight()
                    direction = "behind"
                elseif d == "left" then
                    turtle.turnRight()
                    direction = "behind"
                    turtle.turnRight()
                    direction = "left"
                end
            elseif direction == "left" then
                if d == "left" then
                    --do nothing
                elseif d == "front" then
                    turtle.turnRight()
                    direction = "front"
                elseif d == "right" then
                    turtle.turnRight()
                    direction = "front"
                    turtle.turnRight()
                    direction = "right"
                end
            elseif direction == "behind" then
                if d == "behind" then
                    --do nothing
                elseif d == "left" then
                    turtle.turnRight()
                    direction = "left"
                elseif d == "front" then
                    turtle.turnRight()
                    direction = "left"
                    turtle.turnRight()
                    direction = "front"
                end
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
        end,

        moveToRelative=function(self,tx,ty,tz)

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
        end
    }
end

