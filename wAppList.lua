-- display a list of app name
-- TODO : 
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

    local currentY = 0
    
    local selectionColor = color.orange
    local selectionSize = 1.2
    local listFontColor = color.blue
    local listFontSize = 1.2
    local lineSeparator = 35

    local nbItem = math.floor((hList - yShift) / lineSeparator) - 1
    
    function self.update ( pAppInfos, pCurrentAppIndex, pCurrentPlateform, pCurrentCategory, pDebug )
        local title = ""
        local plateformIcon = nil

        local sizeToAdd = 0
        
        local fontSize = listFontSize
        local fontColor = listFontColor
        
        if pAppInfos[pCurrentPlateform][pCurrentCategory] then
            local nbApps = #pAppInfos[pCurrentPlateform][pCurrentCategory]
            for i=1,nbApps do
                --update x and y position of the app
                local xLine = pAppInfos[pCurrentPlateform][pCurrentCategory][i].x
                local yLine = pAppInfos[pCurrentPlateform][pCurrentCategory][i].y
                
                xLine = xList + xShift
                pAppInfos[pCurrentPlateform][pCurrentCategory][i].x = xLine
                
                yLine = yLine + inputManager.shiftY[1]
                pAppInfos[pCurrentPlateform][pCurrentCategory][i].y = yLine

                -- display the list item
                if yLine > -lineSeparator and yLine < mmi.screenHeight then -- start to draw outside the screen
                    -- display icon
                    plateformIcon = pAppInfos[pCurrentPlateform][pCurrentCategory][i].plateformIcon
                    imageBlit(plateformIcon, xLine, yLine)

                    -- display title
                    title = pAppInfos[pCurrentPlateform][pCurrentCategory][i].title
                    printScreen2(title, xLine + 40, yLine, fontSize, fontColor)
                end
            end
        end

        if pDebug == true then
            drawRectangle(xList, yList, wList, hList, color.orange)
            printScreen ("shiftX "..tostring(inputManager.shiftX[1]), 800, 200)
            printScreen ("shiftY "..tostring(inputManager.shiftY[1]), 800, 220)
        end
    end

    function self.initAppCoordinates ( pAppInfos, pCategories, pPlateforms )
        plateforms = pPlateforms
        categories = pCategories

        -- intialize coordinates for app according to plateform/category
        for key,plateform in pairs(plateforms) do
            for key1,category in pairs(categories) do
                if pAppInfos[plateform][category] then
                    local nbApps = #pAppInfos[plateform][category]
                    for i=1,nbApps do
                        --compute x and y position of the app
                        pAppInfos[plateform][category][i].x = xList + xShift
                        pAppInfos[plateform][category][i].y = (i - 1) * lineSeparator
                    end
                end
            end
        end
    end
    
    function self.update2 ( pAppInfos, pCurrentAppIndex, pCurrentPlateform, pCurrentCategory, pDebug )
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
    
    return self
end
