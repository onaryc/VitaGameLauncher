-- display app background image
function WBackground( pAlpha )
    local self = {}

    local alpha = pAlpha

    function self.update( pType )
        local bgImage = nil
        
        local appObject = gameController.currentApp
        if appObject then
            if pType == "appBackground" then
                bgImage = appObject.appBgImage
            elseif pType == "plateformBackground" then
                bgImage = appObject.plateformBgImage
            elseif pType == "categoryBackground" then
                bgImage = appObject.genreBgImage
            end
        end
        
        imageBlit(bgImage, 0, 0, alpha)
    end
    
    -- return the instance
    return self
end
