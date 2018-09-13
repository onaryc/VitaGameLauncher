-- display app background image
function WBackground( pArg )
    local self = WImage(pArg)

    self.type = pArg.type
    
    local baseUpdate = self.update -- in order to reuse parent function
    function self.update( )
        self.image = nil
        
        local appObject = gameController.getCurrentApp()
        if appObject then
            if self.type == "app" then
                self.image = appObject.appBgImage
                --if self.image != nil then
                    --self.image = image.fxold(self.image)
                --end
            elseif self.type == "plateform" then
                self.image = appObject.plateformBgImage
            elseif self.type == "category" then
                self.image = appObject.genreBgImage
            end
        end

        baseUpdate()
    end
    
    -- return the instance
    return self
end
