-- display app background image
function WBackground()
    local self = {}

    function self.update( pAppInfos, pCurrentAppIndex, pCurrentPlateform, pCurrentCategory, pType, pAlpha, pDebug )
        local bgImage = nil
        
        if pType == "appBackground" then
            bgImage = pAppInfos[pCurrentPlateform][pCurrentCategory][pCurrentAppIndex].appBgImage
        elseif pType == "plateformBackground" then
            bgImage = pAppInfos[pCurrentPlateform][pCurrentCategory][pCurrentAppIndex].plateformBgImage
        elseif pType == "categoryBackground" then
            bgImage = pAppInfos[pCurrentPlateform][pCurrentCategory][pCurrentAppIndex].genreBgImage
        end

        imageBlit(bgImage, 0, 0, pAlpha)
    end
    
    -- return the instance
    return self
end
