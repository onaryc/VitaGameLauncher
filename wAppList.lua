-- display a list of app name
-- TODO :

-- * scrollbar ?
-- * sort by name, release date, ... => ask the infoController

-- DONE :
-- * center the selection!!!
-- * highlight selection

function WAppList( pX, pY, pWidth, pHeight )
    local self = {}

    local mode = "center" -- center, scroll
    
    -- list widget coordinates
    local xWAppList = pX
    local yWAppList = pY
    local wWAppList = pWidth
    local hWAppList = pHeight

    local xShift = 10
    local yShift = 10

    -- list coordinates/move/font/color
    local xList = xWAppList + xShift
    --local yList = yWAppList + yShift
    local yList = yWAppList
    local wList = wWAppList
    local hList = hWAppList

    local initListY = yList
    if mode == "center" then
        initListY = yList + hWAppList / 2
    end
    
    local currentX = xList
    local currentY = initListY
    local cumulateY = 0

    local selectionColor = color.orange
    local selectionSize = 1.2
    --local listFontColor = color.blue
    local listFontColor = color.white
    local listFontSize = 1.2
    local lineSeparator = 35

    -- launch button coordinates
    local lbWidth = wWAppList / 3
    local lbHeight = hWAppList / 2
    local lbX = wWAppList - lbWidth - xShift
    local lbY = yWAppList + (lbHeight / 2)

    local currentApp = nil

    function self.update ( )
        local currentCategory = inputManager.currentCategory 
        local currentPlateform = inputManager.currentPlateform
         
        -- sort the list if needed
        local sortedAppInfos = infoController.sortBy("title", currentPlateform, currentCategory)
        if sortedAppInfos then
            -- update current selection
            self.updateCurrentSelection(sortedAppInfos)
            
            -- display the list
            self.displayList(sortedAppInfos)

            -- display the launch button
            self.displayLaunchButton()
        end

        if inputManager.debug == true then
            drawRectangle(xWAppList, yWAppList+1, wWAppList, hWAppList-2, color.orange)
            drawRectangle(lbX, lbY, lbWidth, lbHeight, color.orange)
            --printScreen ("shiftX "..tostring(inputManager.shiftTFX[1]), 800, 200)
            --printScreen ("shiftY "..tostring(inputManager.shiftTFY[1]), 800, 220)
            --printScreen ("cumulateY "..tostring(cumulateY), 800, 240)
        end
    end

    function self.updateCurrentSelection ( pAppList )
        local currentCategory = inputManager.currentCategory 
        local currentPlateform = inputManager.currentPlateform
        local nbAppInfo = #pAppList

        -- get the current app index
        local currentAppIndex = inputManager.indexByContext[currentPlateform][currentCategory]
        
        -- limit end and start of the list
        if mode != "center" then
            currentY = currentY + inputManager.shiftTFY[1]
        end
        
        cumulateY = cumulateY + inputManager.shiftTFY[1]
        if currentAppIndex == 1 then
            if inputManager.shiftTFY[1] > 0 then
                currentY = initListY
                cumulateY = 0
            end
        elseif currentAppIndex == nbAppInfo then
            if inputManager.shiftTFY[1] < 0 then
                currentY = initListY
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

            currentY = initListY
            cumulateY = 0
            inputManager.indexByContext[currentPlateform][currentCategory] = currentAppIndex
        end

        currentApp = pAppList[currentAppIndex]
    end

    function self.displayLaunchButton ( )
        local startupImage = currentApp.startupImage
        if startupImage then
            imageResize(startupImage, lbWidth, lbHeight) -- shall be scale in order to respect aspect ratio!!!
            --imageScale(startupImage, 2.0)
            imageBlit(startupImage, lbX, lbY)

             -- launch app if needed : shall be somewhere else, callback system??
            if inputManager.tfX[1] > lbX and inputManager.tfX[1] < lbX + lbWidth and inputManager.tfY[1] > lbY and inputManager.tfY[1] < lbY + lbHeight then
                launchGame(currentApp.id)
            end
        end
    end

    function self.displayList ( pAppList )
        local currentCategory = inputManager.currentCategory 
        local currentPlateform = inputManager.currentPlateform
        
        local currentAppIndex = inputManager.indexByContext[currentPlateform][currentCategory]
        local appObject = ""
        local y = 0
        
        -- display the list under the selection
        local i = currentAppIndex - 1
        local cpt = 1
        while true do
            -- if there is no app left to display, exit 
            if pAppList[i] then
                appObject = pAppList[i]
            else
                break
            end
            
            y = currentY - cpt * lineSeparator

            -- if there is no space left on the screen, exit
            if y < yList then
                break
            end

            -- print the app line
            self.printLine (appObject, currentX, y, listFontSize, listFontColor)

            -- update the counters
            i = i - 1
            cpt = cpt + 1
        end
        
        -- display the selection
        y = currentY
        self.printLine (currentApp, currentX, y, selectionSize, selectionColor)
        
        -- display the list above the selection
        i = currentAppIndex + 1
        cpt = 1
        while true do
            -- if there is no app left to display, exit 
            if pAppList[i] then
                appObject = pAppList[i]
            else
                break
            end
            
            y = currentY + cpt * lineSeparator

            -- if there is no space left on the screen, exit
            if y > hList + yList then
                break
            end

            -- print the app line
            self.printLine (appObject, currentX, y, listFontSize, listFontColor)

            -- update the counters
            i = i + 1
            cpt = cpt + 1
        end
    end

    function self.printLine ( pAppObject, pX, pY, pFontSize, pFontColor )
        local currentCategory = inputManager.currentCategory 
        local currentPlateform = inputManager.currentPlateform

        local xShift = 0

        if currentPlateform == "All" then
            -- display plateform icon
            --local plateformIcon = pAppObject.plateformIcon
            local plateformIcon = mmi.getPlateformeIcon(pAppObject.plateform)
            imageBlit(plateformIcon, pX + xShift, pY)
            xShift = xShift + 40
        end

        -- display region icon
        local regionIcon = mmi.getRegionIcon(pAppObject.region)
        imageBlit(regionIcon, pX + xShift, pY)
        xShift = xShift + 40

        -- display title
        local title = pAppObject.title
        local titleWidth = screen.textwidth(title, pFontSize)

        if titleWidth + xShift > lbX then

        end
        
        printScreen2(title, pX + xShift, pY, pFontSize, pFontColor)
    end
    
    return self
end
