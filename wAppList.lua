-- display a list of app name
-- TODO : 
-- * an icon is displayed before the name
-- * scrollbar ?
-- * highlight selection
-- * sort by name, release date, ... => ask the infoController
function WAppList( pScreenWidth, pScreenHeight, pX, pY, pNbItem )
    local self = {}

    local screenWidth = pScreenWidth
    local screenHeight = pScreenHeight

    --local halfNbItem = pNbItem / 2
    local nbItem = pNbItem
    
    local xList = pX
    local yList = pY
    
    function self.update ( pAppInfos, pCurrentAppIndex, pCurrentPlateform, pCurrentCategory, pDebug )
        local title = ""
        local index = 0
        local plateformIcon = nil
        local x = xList
        local y = yList
        
        for i=1,nbItem do
            index = pCurrentAppIndex + i - nbItem / 2 -1  

            -- display icon
            plateformIcon = pAppInfos[pCurrentPlateform][pCurrentCategory][index].plateformIcon
            imageBlit(plateformIcon, x, y)

            -- display title
            title = pAppInfos[pCurrentPlateform][pCurrentCategory][index].title
            printScreen(title, x + 40, y)

            -- highlight the title
            if index == pCurrentAppIndex then

            end

            y = y + 20
        end
        
    end
    
    return self
end
