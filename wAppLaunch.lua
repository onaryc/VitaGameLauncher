function WAppLaunch ( pX, pY, pWidth, pHeight )
    local self = {}

    local lbWidth = pWidth
    local lbHeight = pHeight
    local lbX = pX
    local lbY = pY
    
    function self.update ( )
        local startupImage = gameController.getCurrentApp().startupImage
        if startupImage then
            imageResize(startupImage, lbWidth, lbHeight) -- shall be scale in order to respect aspect ratio!!!
            --imageScale(startupImage, 2.0)
            --screen.clip(lbX,lbY, 128/2)
            local minLength = math.min(lbWidth,lbHeight)
            local clipRadius = minLength / 2
            local clipX = lbX + clipRadius
            local clipY = lbY + clipRadius

            draw.circle(clipX, clipY, clipRadius+5, color.gray, 30)
            
            screen.clip(clipX, clipY, clipRadius)
            imageBlit(startupImage, lbX, lbY)
            screen.clip()

             -- launch app if needed : shall be somewhere else, callback system??
            if (inputManager.tfX[1] > lbX) and (inputManager.tfX[1] < lbX + lbWidth) and (inputManager.tfY[1] > lbY) and (inputManager.tfY[1] < lbY + lbHeight) then
                launchGame(gameController.getCurrentApp().id)
            end
        end

        if mmi.debug then
            drawRectangle(lbX, lbY, lbWidth, lbHeight, color.orange)
        end
    end
    
    return self
end
