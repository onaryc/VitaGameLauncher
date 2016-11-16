-- display app background image
function WBackground( pAlpha )
    local self = {}

    local alpha = pAlpha

    local defaultBgFile = "app0:/images/missing.png"
    local defaultBgImage = nil

    function self.initialization ()
        if filesExists(defaultBgFile) then
            defaultBgImage = imageLoad(defaultBgFile)
        end
    end
    
    function self.update( pType )
        local appInfos = infoController.appInfos
        
        local currentAppIndex = inputManager.currentAppIndex 
        local currentCategory = inputManager.currentCategory 
        local currentPlateform = inputManager.currentPlateform

        --local debugLevel = inputManager.debug
        
        local bgImage = nil
        
        if appInfos[currentPlateform][currentCategory] then
            local appObject = appInfos[currentPlateform][currentCategory][currentAppIndex]
            
            if pType == "appBackground" then
                bgImage = appObject.appBgImage
            elseif pType == "plateformBackground" then
                bgImage = appObject.plateformBgImage
            elseif pType == "categoryBackground" then
                bgImage = appObject.genreBgImage
            end
        else
            bgImage = defaultBgImage
        end
        
        imageBlit(bgImage, 0, 0, alpha)
    end

    self.initialization()
    
    -- return the instance
    return self
end
