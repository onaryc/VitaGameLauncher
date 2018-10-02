function VGLWAppLaunch ( pArg )
    local self = VGLWButton(pArg)

    local baseUpdate = self.update -- in order to reuse parent function
    function self.update ( )
        self.image = api.getCurrentApp().startupImage
        
        baseUpdate()

        -- launch app if needed : shall be somewhere else, callback system??
        local tFX1 = api.getTouchFrontX(1)
        local tFY1 = api.getTouchFrontY(1)
        if (tFX1 > self.x) and (tFX1 < self.x + self.w) and (tFY1 > self.y) and (tFY1 < self.y + self.h) then
            launchGame(api.getCurrentApp().id)
        end
        
    end
    
    return self
end
