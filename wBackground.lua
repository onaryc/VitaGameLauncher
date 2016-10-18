-- display app background image
function WBackground()
    local self = {}

    --local previousAppIndex = -1

    function self.update( pAppInfos, pCurrentAppIndex, pType, pAlpha, pDebug )
        local bgImage = nil
        
        if pType == "appBackground" then
            --if pCurrentAppIndex == previousAppIndex then
--
            --else
                bgImage = pAppInfos[pCurrentAppIndex].appBgImage
            --end
        elseif pType == "plateformBackground" then
            bgImage = pAppInfos[pCurrentAppIndex].plateformBgImage
        elseif pType == "genreBackground" then
            bgImage = pAppInfos[pCurrentAppIndex].genreBgImage
        end

        imageBlit(bgImage, 0, 0, pAlpha)

        --previousAppIndex = pCurrentAppIndex
    end
    
    -- return the instance
    return self
end
