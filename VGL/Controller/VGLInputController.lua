-- TODO
-- left/right : jump in list
-- if up/down pressed => quick navigating
-- step for plateform and category
-- touch interaction for plateform/category

function VGLInputController(pArg)
    local self = VGLController(pArg)

    -- touch
    self.shiftTFX = {[1]=0, [2]=0, [3]=0, [4]=0, [5]=0, [6]=0}
    self.shiftTFY = {[1]=0, [2]=0, [3]=0, [4]=0, [5]=0, [6]=0}
    self.tfX = {[1]=-1, [2]=-1, [3]=-1, [4]=-1, [5]=-1, [6]=-1}
    self.tfY = {[1]=-1, [2]=-1, [3]=-1, [4]=-1, [5]=-1, [6]=-1}

    --local previousFState = {[1]="released", [2]="released", [3]="released", [4]="released", [5]="released", [6]="released"}
    local previousFX = {[1]=0, [2]=0, [3]=0, [4]=0, [5]=0, [6]=0}
    local previousFY = {[1]=0, [2]=0, [3]=0, [4]=0, [5]=0, [6]=0}

    -- digital
    self.up = false
    self.down = false
    self.left = false
    self.right = false

    -- analogic
    self.analogLUpPressed = false
    self.analogLUpReleased = true

    self.analogLDownPressed = false
    self.analogLDownReleased = true

    self.analogRUpPressed = false
    self.analogRUpReleased = true

    self.analogRDownPressed = false
    self.analogRDownReleased = true

    self.shiftDelay = true
    
    local analogDeadzone = 30

    local repeatButton = timer.new()
    repeatButton:start()
    local repeatInterval = 150

    local shiftTimer = timer.new()
    shiftTimer:start()
    local shiftDRatio = 0.3
    local shiftDInterval = 130
    --buttons.interval(10, 7)

    function self.initialize()
        api.register(self.getTouchFrontX, "getTouchFrontX")
        api.register(self.getTouchFrontY, "getTouchFrontY")
        api.register(self.getShiftTouchFrontY, "getShiftTouchFrontY")
        api.register(self.getDigitalUp, "getDigitalUp")
        api.register(self.getDigitalDown, "getDigitalDown")
        api.register(self.getDigitalLeft, "getDigitalLeft")
        api.register(self.getDigitalRight, "getDigitalRight")
        api.register(self.getAnalogLUpPressed, "getAnalogLUpPressed")
        api.register(self.getAnalogLDownPressed, "getAnalogLDownPressed")
        api.register(self.getAnalogRUpPressed, "getAnalogRUpPressed")
        api.register(self.getAnalogRDownPressed, "getAnalogRDownPressed")
    end

    function self.update()

    end

    function self.getTouchFrontX ( pIndex )
        return self.tfX[pIndex]
    end
    
    function self.getTouchFrontY ( pIndex )
        return self.tfY[pIndex]
    end
    
    function self.getShiftTouchFrontY ( pIndex )
        return self.shiftTFY[pIndex]
    end
    
    function self.getDigitalUp ( )
        return self.up
    end
    
    function self.getDigitalDown ( )
        return self.down
    end
    
    function self.getDigitalLeft ( )
        return self.left
    end
    
    function self.getDigitalRight ( )
        return self.right
    end
    
    function self.getAnalogLUpPressed ( )
        return self.analogLUpPressed
    end
    
    function self.getAnalogLDownPressed ( )
        return self.analogLDownPressed
    end
    
    function self.getAnalogRUpPressed ( )
        return self.analogRUpPressed
    end
    
    function self.getAnalogRDownPressed ( )
        return self.analogRDownPressed
    end
    
    -- return the instance
    return self
end
