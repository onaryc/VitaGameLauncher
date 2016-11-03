-- display app background image
function WBackground()
    local self = {}

    local defaultBgFile = "app0:/images/missing.png"
    local defaultBgImage = nil

    function self.initialization ()
        if filesExists(defaultBgFile) then
            defaultBgImage = imageLoad(defaultBgFile)
        end
    end
    
    function self.update( pAppInfos, pCurrentAppIndex, pCurrentPlateform, pCurrentCategory, pType, pAlpha, pDebug )
        local bgImage = nil
        
        if pAppInfos[pCurrentPlateform][pCurrentCategory] then
            if pType == "appBackground" then
                bgImage = pAppInfos[pCurrentPlateform][pCurrentCategory][pCurrentAppIndex].appBgImage
            elseif pType == "plateformBackground" then
                bgImage = pAppInfos[pCurrentPlateform][pCurrentCategory][pCurrentAppIndex].plateformBgImage
            elseif pType == "categoryBackground" then
                bgImage = pAppInfos[pCurrentPlateform][pCurrentCategory][pCurrentAppIndex].genreBgImage
            end
        else
            bgImage = defaultBgImage
        end
        
        imageBlit(bgImage, 0, 0, pAlpha)
    end

    self.initialization()
    
    -- return the instance
    return self
end
