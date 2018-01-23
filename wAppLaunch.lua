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
            screen.clip(lbX,lbY, 128/2)
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
