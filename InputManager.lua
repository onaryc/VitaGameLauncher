-- TODO
-- left/right : jump in list
-- if up/down pressed => quick navigating
-- step for plateform and category
-- touch interaction for plateform/category

function InputManager()
    local self = {}

    self.shiftTFX = {[1]=0, [2]=0, [3]=0, [4]=0, [5]=0, [6]=0}
    self.shiftTFY = {[1]=0, [2]=0, [3]=0, [4]=0, [5]=0, [6]=0}
    self.tfX = {[1]=-1, [2]=-1, [3]=-1, [4]=-1, [5]=-1, [6]=-1}
    self.tfY = {[1]=-1, [2]=-1, [3]=-1, [4]=-1, [5]=-1, [6]=-1}

    self.up = false
    self.down = false
    self.left = false
    self.right = false

    self.analogLUpPressed = false
    self.analogLUpReleased = true

    self.analogLDownPressed = false
    self.analogLDownReleased = true

    self.analogRUpPressed = false
    self.analogRUpReleased = true

    self.analogRDownPressed = false
    self.analogRDownReleased = true
    
    --local categories = {"All"}
    --local plateforms = {"All"}
    
    local analogDeadzone = 30

    local previousFState = {[1]="released", [2]="released", [3]="released", [4]="released", [5]="released", [6]="released"}
    local previousFX = {[1]=0, [2]=0, [3]=0, [4]=0, [5]=0, [6]=0}
    local previousFY = {[1]=0, [2]=0, [3]=0, [4]=0, [5]=0, [6]=0}

    --buttons.interval(10, 7)
    
    --local timerDir = timer.new()
    --local timerAnalogLeftDir = timer.new()
    --local timerAnalogRightDir = timer.new()

    function self.update ( pAppInfos )
        buttons.read()
        touch.read()

        -- launching game
        if buttons.cross then
            --printScreen("Launching game : "..pAppInfos[self.currentPlateform][self.currentCategory][currentAppIndex].id, 400, 10)
            --launchGame(pAppInfos[self.currentPlateform][self.currentCategory][currentAppIndex].id)
            launchGame(gameController.currentApp.id)
        end
        
        if buttons.up then
            --buttons.interval(10, 7)
            self.up = true
        end
        
        if buttons.released.up then
            --buttons.interval()
            self.up = false
        end
        
        if buttons.down then
            --buttons.interval(10, 7)
            self.down = true            
        end

        if buttons.released.down then
            --buttons.interval()
            self.down = false
        end

        if buttons.left then
            self.left = true
        end

        if buttons.released.left then
            --buttons.interval()
            self.left = false
        end
        
        if buttons.right then
            self.right = true
        end

        if buttons.released.right then
            --buttons.interval()
            self.right = false
        end

        if buttons.analogly > analogDeadzone then -- left analog up
            if self.analogLUpReleased == true then
                self.analogLUpPressed = true
                self.analogLUpReleased = false
            else
                self.analogLUpPressed = false
            end
        else
            self.analogLUpPressed = false
            self.analogLUpReleased = true
        end

        if buttons.analogly < -analogDeadzone then -- left analog down
            if self.analogLDownReleased == true then
                self.analogLDownPressed = true
                self.analogLDownReleased = false
            else
                self.analogLDownPressed = false
            end
        else
            self.analogLDownPressed = false
            self.analogLDownReleased = true
        end

        if buttons.analogry > analogDeadzone then -- right analog up
            if self.analogRUpReleased == true then
                self.analogRUpPressed = true
                self.analogRUpReleased = false
            else
                self.analogRUpPressed = false
            end
        else
            self.analogRUpPressed = false
            self.analogRUpReleased = true
        end

        if buttons.analogry < -analogDeadzone then -- right analog down
            if self.analogRDownReleased == true then
                self.analogRDownPressed = true
                self.analogRDownReleased = false
            else
                self.analogRDownPressed = false
            end
        else
            self.analogRDownPressed = false
            self.analogRDownReleased = true
        end

        -- compute touch shift, ...
        --~ self.computeFTouch ()

        -- exit app
        if buttons.released.start then
            os.exit()
        end

        -- manage debug level
        if buttons.held.select then
            mmi.debug = true
        end

        if buttons.released.select then
            mmi.debug = false
        end
    end

    function self.computeFTouch ( )
        for i=1,touch.front.count do
            if buttons.touchf[i].moved == true then
                if previousFState[i] == "released" then -- first touch, shift shall be equal to 0
                    previousFX[i] = buttons.touchf[i].x
                    previousFY[i] = buttons.touchf[i].y
                end

                -- set touch x and Y
                self.tfX[i] = buttons.touchf[i].x
                self.tfY[i] = buttons.touchf[i].y

                -- compute shift
                self.shiftTFX[i] = buttons.touchf[i].x - previousFX[i]
                self.shiftTFY[i] = buttons.touchf[i].y - previousFY[i]

                -- update previous coordinates
                previousFX[i] = buttons.touchf[i].x
                previousFY[i] = buttons.touchf[i].y

                previousFState[i] = "moved"
            else
                self.tfX[i] = -1
                self.tfY[i] = -1
                
                self.shiftTFX[i] = 0
                self.shiftTFY[i] = 0

                previousFState[i] = "released"
            end
        end
    end
        
    -- return the instance
    return self
end
