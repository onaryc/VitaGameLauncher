function WAppLaunch ( pId, pX, pY, pWidth, pHeight, pDebugColor )
    local self = WButton(pId, pX, pY, pWidth, pHeight, "", "circle", 5, pDebugColor)

    local baseUpdate = self.update -- in order to reuse parent function
    function self.update ( )
        self.image = gameController.getCurrentApp().startupImage
        
        baseUpdate()

        -- launch app if needed : shall be somewhere else, callback system??
        if (inputManager.tfX[1] > self.x) and (inputManager.tfX[1] < self.x + self.w) and (inputManager.tfY[1] > self.y) and (inputManager.tfY[1] < self.y + self.h) then
            launchGame(gameController.getCurrentApp().id)
        end
        
    end
    
    return self
end
