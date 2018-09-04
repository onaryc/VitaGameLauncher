function Widget ( pId, pX, pY, pWidth, pHeight, pDebugColor )
    local self = {}

    -- public variables
    self.id = pId
    self.x = pX
    self.y = pY
    self.w = pWidth
    self.h = pHeight
    self.debugColor = pDebugColor

    function self.update( )
        if mmi.debug == true then
            drawRectangle(self.x, self.y, self.w, self.h, self.debugColor)
        end
    end
    
    -- return the instance
    return self
end
