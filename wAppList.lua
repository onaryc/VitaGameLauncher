-- display a list of app name
-- TODO : 
-- * an icon is displayed before the name
-- * scrollbar ?
-- * highlight selection
-- * sort by name, release date, ... => ask the infoController
function WAppList( pX, pY, pWidth, pHeight )
    local self = {}

    local xList = pX
    local yList = pY
    local wList = pWidth
    local hList = pHeight

    local xShift = 10
    local yShift = 10

    local selectionColor = color.orange
    local selectionSize = 1.2
    local listFontColor = color.blue
    local listFontSize = 1.2
    local lineSeparator = 35

    local nbItem = math.floor((hList - yShift) / lineSeparator) - 1
    
    function self.update ( pAppInfos, pCurrentAppIndex, pCurrentPlateform, pCurrentCategory, pDebug )
        local title = ""
        local index = 0
        local plateformIcon = nil
        local x = xList + xShift
        local y = yList + yShift

        local sizeToAdd = 0
        
        --local fontSize = 1
        local fontColor = listFontColor
        
        if pAppInfos[pCurrentPlateform][pCurrentCategory] then
            local i = 0
            while y < hList do
                --index = pCurrentAppIndex + i - nbItem / 2 - 1  
                index = pCurrentAppIndex + i  
                
                if pAppInfos[pCurrentPlateform][pCurrentCategory][index] then
                    -- display icon
                    plateformIcon = pAppInfos[pCurrentPlateform][pCurrentCategory][index].plateformIcon
                    printScreen ("icon "..tostring(plateformIcon), 500, y)
                    imageBlit(plateformIcon, x, y)

                    -- display title
                    title = pAppInfos[pCurrentPlateform][pCurrentCategory][index].title
                    --printScreen(title, x + 40, y)

                    -- highlight the current title
                    if index == pCurrentAppIndex then
                        fontSize = selectionSize
                        fontColor = selectionColor
                    else
                        fontSize = listFontSize
                        fontColor = listFontColor
                    end

                    sizeToAdd = fontSize * lineSeparator

                    printScreen2(title, x + 40, y, fontSize, fontColor)
                end

                y = y + sizeToAdd
                i = i + 1
            end
        end

        if pDebug == true then
            drawRectangle(xList, yList, wList, hList, color.orange)

            --printScreen ("nbItem "..nbItem, 800, 200)
        end
    end
    
    function self.updateOld ( pAppInfos, pCurrentAppIndex, pCurrentPlateform, pCurrentCategory, pDebug )
        local title = ""
        local index = 0
        local plateformIcon = nil
        local x = xList + xShift
        local y = yList + yShift

        local sizeToAdd = 0
        
        --local fontSize = 1
        local fontColor = listFontColor
        
        if pAppInfos[pCurrentPlateform][pCurrentCategory] then
            for i=0,nbItem-1 do
                --index = pCurrentAppIndex + i - nbItem / 2 - 1  
                index = pCurrentAppIndex + i  
                
                if pAppInfos[pCurrentPlateform][pCurrentCategory][index] then
                    -- display icon
                    plateformIcon = pAppInfos[pCurrentPlateform][pCurrentCategory][index].plateformIcon
                    imageBlit(plateformIcon, x, y)

                    -- display title
                    title = pAppInfos[pCurrentPlateform][pCurrentCategory][index].title
                    --printScreen(title, x + 40, y)

                    -- highlight the current title
                    if index == pCurrentAppIndex then
                        fontSize = selectionSize
                        fontColor = selectionColor
                    else
                        fontSize = listFontSize
                        fontColor = listFontColor
                    end

                    sizeToAdd = fontSize * lineSeparator

                    printScreen2(title, x + 40, y, fontSize, fontColor)
                end

                y = y + sizeToAdd
            end
        end

        if pDebug == true then
            drawRectangle(xList, yList, wList, hList, color.orange)

            printScreen ("nbItem "..nbItem, 800, 200)
        end
    end
    
    return self
end
