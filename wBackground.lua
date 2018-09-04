-- display app background image
function WBackground( pId, pX, pY, pWidth, pHeight, pAlpha, pDebugColor )
    local self = WImage(pId, pX, pY, pWidth, pHeight, "", pAlpha, pDebugColor)

    local baseUpdate = self.update -- in order to reuse parent function
    function self.update( pType )
        self.image = nil
        
        local appObject = gameController.getCurrentApp()
        if appObject then
            if pType == "appBackground" then
                self.image = appObject.appBgImage
                --if self.image != nil then
                    --self.image = image.fxold(self.image)
                --end
            elseif pType == "plateformBackground" then
                self.image = appObject.plateformBgImage
            elseif pType == "categoryBackground" then
                self.image = appObject.genreBgImage
            end
        end

        baseUpdate()
    end
    
    -- return the instance
    return self
end
