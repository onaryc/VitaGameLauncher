-- display a list of app name
-- TODO :
-- * center the selection!!!
-- * scrollbar ?
-- * highlight selection
-- * sort by name, release date, ... => ask the infoController
function WAppList( pX, pY, pWidth, pHeight )
    local self = {}

    -- list widget coordinates
    local xWAppList = pX
    local yWAppList = pY
    local wWAppList = pWidth
    local hWAppList = pHeight

    local xShift = 10
    local yShift = 10

    -- list coordinates/move/font/color
    local xList = xWAppList + xShift
    local yList = yWAppList + yShift
    local currentX = xList
    local currentY = yList
    local cumulateY = 0

    local selectionColor = color.orange
    local selectionSize = 1.2
    local listFontColor = color.blue
    local listFontSize = 1.2
    local lineSeparator = 35

    -- launch button coordinates
    local lbWidth = wWAppList / 3
    local lbHeight = hWAppList / 2
    local lbX = wWAppList - lbWidth - xShift
    local lbY = yWAppList + (lbHeight / 2)

    function self.update ( )
        local appInfos = infoController.appInfos
        
        local currentAppIndex = inputManager.currentAppIndex 
        local currentCategory = inputManager.currentCategory 
        local currentPlateform = inputManager.currentPlateform

        local debugLevel = inputManager.debug
         
        if appInfos[currentPlateform][currentCategory] then
            local appObject = appInfos[currentPlateform][currentCategory][currentAppIndex]

            local nbAppInfo = #appInfos[currentPlateform][currentCategory]

            -- limit end and atart of the list
            currentY = currentY + inputManager.shiftY[1]
            cumulateY = cumulateY + inputManager.shiftY[1]
            if currentAppIndex == 1 then
                if inputManager.shiftY[1] > 0 then
                    currentY = yList
                    cumulateY = 0
                end
            elseif currentAppIndex == nbAppInfo then
                if inputManager.shiftY[1] < 0 then
                    currentY = yList
                    cumulateY = 0
                end
            end
            
            -- change app selection
            if math.abs(cumulateY) > lineSeparator then
                if cumulateY < 0 then
                    currentAppIndex = currentAppIndex + 1
                    if currentAppIndex > nbAppInfo then
                        currentAppIndex = currentAppIndex - 1
                    end
                else
                    currentAppIndex = currentAppIndex - 1
                    if currentAppIndex < 1 then
                        currentAppIndex = 1
                    end
                end

                currentY = yList
                cumulateY = 0
                inputManager.indexByContext[currentPlateform][currentCategory] = currentAppIndex
            end

            -- display the launch button
            local startupImage = appObject.startupImage
            imageResize(startupImage, lbWidth, lbHeight) -- shall be scale in order to respect aspect ratio!!!
            --imageScale(startupImage, 2.0)
            imageBlit(startupImage, lbX, lbY)
            
            -- display the list
            local i = currentAppIndex
            local cpt = 1
            while true do
                local y = currentY + (cpt - 1) * lineSeparator

                local fontSize = listFontSize
                local fontColor = listFontColor
                if i == currentAppIndex then
                    fontSize = selectionSize
                    fontColor = selectionColor
                end
                
                self.printLine (appObject, currentX, y, fontSize, fontColor)

                i = i + 1
                cpt = cpt + 1
                if appInfos[currentPlateform][currentCategory][i] then
                    appObject = appInfos[currentPlateform][currentCategory][i]
                else
                    break
                end
            end
        end

        if debugLevel == true then
            drawRectangle(xWAppList, yWAppList+1, wWAppList, hWAppList-2, color.orange)
            drawRectangle(lbX, lbY, lbWidth, lbHeight, color.orange)
            --printScreen ("shiftX "..tostring(inputManager.shiftX[1]), 800, 200)
            --printScreen ("shiftY "..tostring(inputManager.shiftY[1]), 800, 220)
            --printScreen ("cumulateY "..tostring(cumulateY), 800, 240)
        end
    end

    function self.printLine ( pAppObject, pX, pY, pFontSize, pFontColor )
        -- display icon
        local plateformIcon = pAppObject.plateformIcon
        imageBlit(plateformIcon, pX, pY)

        -- display title
        local title = pAppObject.title
        printScreen2(title, pX + 40, pY, pFontSize, pFontColor)
    end
    
    return self
end
