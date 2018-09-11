function WImage ( pId, pParent, pX, pY, pWidth, pHeight, pImage, pAlpha, pDebugColor )
    local self = WFrame(pId, pParent, pX, pY, pWidth, pHeight, pDebugColor)

    -- public variables
    self.image = pImage
    self.alpha = pAlpha
    
    local baseUpdate = self.update -- in order to reuse parent function
    function self.update ( )
        imageBlit(self.image, self.x, self.y, self.alpha)
        
        --baseUpdate()
    end
    
    -- return the instance
    return self
end
