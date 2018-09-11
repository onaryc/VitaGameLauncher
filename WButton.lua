function WButton ( pId, pParent, pX, pY, pWidth, pHeight, pImage, pShape, pBordure, pDebugColor )
    local self = WFrame(pId, pParent, pX, pY, pWidth, pHeight, pDebugColor)

    -- public variables
    self.image = pImage
    self.shape = pShape
    self.bordure = pBordure
    
    local baseUpdate = self.update -- in order to reuse parent function
    function self.update ( )
        if self.image then
            imageResize(self.image, self.w, self.h) -- shall be scale in order to respect aspect ratio!!!
            --imageScale(startupImage, 2.0)
            --screen.clip(self.x,self.y, 128/2)
            if self.shape == "circle" then
                local minLength = math.min(self.w, self.h)
                local clipRadius = minLength / 2
                local clipX = self.x + clipRadius
                local clipY = self.y + clipRadius

                draw.circle(clipX, clipY, clipRadius+self.bordure, color.gray, 30)
                
                screen.clip(clipX, clipY, clipRadius)
            end

            imageBlit(self.image, self.x, self.y)
            screen.clip()
        end
        
        baseUpdate()
    end
    
    -- return the instance
    return self
end
