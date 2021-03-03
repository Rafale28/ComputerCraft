XyzApi = {}

function XyzApi.new()
    return{
        x = 0
        y = 0
        z = 0
        direction = "front"

        function getX(self)
            return X
        end

        function getY(self)
            return X
        end

        function getZ(self)
            return X
        end

        function getDirection(self)
            return direction
        end

        function getXYZ(self)

            return {x,y,z,direction}

        end

        local function incrementXYZ(self,n)

            if direction == "front" then
                y=y+n
            elseif direction == "right" then
                x=x+1
            elseif direction == "left" then
                x=x-1
            elseif direction == "behind" then
                y=y-1
            end
        end

        function forward(self,n)

            moved=0

            for i=1,n do 

                --動けなかったとき
                if turtle.forward() == false then
                    return moved
                else
                    moved = moved + 1
                    incrementXYZ(1)
                end
            end

            return moved
        end

        function back(self,n)

            moved=0

            for i=1,n do 

                --動けなかったとき
                if turtle.back() == false then
                    return moved
                else
                    moved = moved + 1
                    incrementXYZ(-1)
                end
            end

            return moved
        end

        function up(self,n)

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
        end

        function down(self,n)

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
        end

        function turn(self,d)

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
        end

        --front or back based on sign of n
        local function frontBack(self,n)

            if n == 0 then
                --do noting
            elseif n > 0 then
                forward(n)
            elseif n < 0 then
                back(-n)
            end
        end

        --up or down based on sign of n
        local function upDown(self,n)

            if n == 0 then
                --do noting
            elseif n > 0 then
                up(n)
            elseif n < 0 then
                down(-n)
            end
        end

        function moveTo(self,tx,ty,tz)

            mx = tx - x
            my = ty - y
            mz = tz - z

            if mx  == 0 then
                -- do nothing 
            else then
                turn("right")
                frontBack(mx)
            end

            if my  == 0 then
                -- do nothing 
            else then
                turn("front")
                frontBack(my)
            end

            if mz  == 0 then
                -- do nothing 
            else then
                updown(mz)
            end
        end

        function moveToRelative(self,tx,ty,tz)

            mx = tx
            my = ty
            mz = tz

            if mx  == 0 then
                -- do nothing 
            else then
                turn("right")
                frontBack(mx)
            end

            if my  == 0 then
                -- do nothing 
            else then
                turn("front")
                frontBack(my)
            end

            if mz  == 0 then
                -- do nothing 
            else then
                updown(mz)
            end
        end
    }
end

