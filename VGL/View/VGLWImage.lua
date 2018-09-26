function VGLWImage ( pArg )
    local self = VGLWFrame(pArg)

    -- public variables
    self.image = pArg.image
    self.alpha = pArg.alpha
    
    local baseUpdate = self.update -- in order to reuse parent function
    function self.update ( )
        imageBlit(self.image, self.x, self.y, self.alpha)
        
        --baseUpdate()
    end
    
    -- return the instance
    return self
end
