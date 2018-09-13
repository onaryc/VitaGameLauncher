-- display a list of app name
-- TODO :

-- * separate the pure list features in WList (in order to reuse it) and the app specific parts in WAppList
-- * scrollbar ?
-- * sort by name, release date, ... => ask the gameController

-- DONE :
-- * center the selection!!!
-- * highlight selection

function WList( pArg )
    local self = WFrame(pArg)

    -- public variables
    self.mode = pArg.mode -- center, scroll
    self.xIndent = pArg.xIdent
    self.selectionColor = pArg.selectionColor
    self.selectionSize = pArg.selectionSize
    --self.listFontColor = color.blue
    self.listFontColor = pArg.fontColor
    self.listFontSize = pArg.fontSize
    self.lineSeparator = pArg.lineSeparator
    
    -- list coordinates/move/font/color
    local initListY = self.y
    if self.mode == "center" then
        initListY = self.y + self.h / 2
    end
    
    local currentX = self.x + self.xIndent
    local currentY = initListY
    local cumulateY = 0

    local nbAppDisplay = 0

    local currentCatIndex = 1
    local currentPlateformIndex = 1

    local baseUpdate = self.update -- in order to reuse parent function
    function self.update ( )
        local currentCategory = gameController.currentCategory 
        local currentPlateform = gameController.currentPlateform
         
        -- sort the list if needed
        local sortedAppInfos = gameController.sortBy("title", currentPlateform, currentCategory)
        if sortedAppInfos then
            -- update current selection
            self.updateCurrentSelection(sortedAppInfos)
            
            -- display the list
            self.displayList(sortedAppInfos)
        end

        baseUpdate()
        --if mmi.debug then
            --drawRectangle(self.x, self.y+1, self.w, self.h-2, color.orange)
            ----drawRectangle(lbX, lbY, lbWidth, lbHeight, color.orange)
        --end
    end

    function self.updateCurrentSelection ( pAppList )
        local currentCategory = gameController.currentCategory 
        local currentPlateform = gameController.currentPlateform
        local nbAppInfo = #pAppList

        -- get the current app index
        --local currentAppIndex = gameController.indexByContext[currentPlateform][currentCategory]
        local currentAppIndex = gameController.getCurrentIndex()
        
        -- limit end and start of the list
        if self.mode != "center" then
            currentY = currentY + inputManager.shiftTFY[1]
        end

        -- compute the current app index
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
        if math.abs(cumulateY) > self.lineSeparator then
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
        end

        if inputManager.up then
            currentAppIndex = currentAppIndex - 1
            if currentAppIndex < 1 then
                currentAppIndex = 1
            end
        end

        if inputManager.down then
            currentAppIndex = currentAppIndex + 1
            if currentAppIndex > nbAppInfo then
                currentAppIndex = currentAppIndex - 1
            end
        end

        if inputManager.left then
            currentAppIndex = currentAppIndex - nbAppDisplay + 1
            if currentAppIndex < 1 then
                currentAppIndex = 1
            end
        end

        if inputManager.right then
            currentAppIndex = currentAppIndex + nbAppDisplay - 1
            if currentAppIndex > nbAppInfo then
                currentAppIndex = nbAppInfo
            end
        end

        gameController.indexByContext[currentPlateform][currentCategory] = currentAppIndex

        gameController.setCurrentApp (pAppList[currentAppIndex])

        -- plateform selection
        if inputManager.analogLUpPressed then
            currentPlateformIndex = currentPlateformIndex - 1
            if currentPlateformIndex < 1 then
                currentPlateformIndex = 1
            end
        end
        
        if inputManager.analogLDownPressed then
            currentPlateformIndex = currentPlateformIndex + 1
            if currentPlateformIndex > #gameController.plateforms then
                currentPlateformIndex = currentPlateformIndex - 1
            end
        end

        gameController.setCurrentPlateform(currentPlateformIndex)

        -- category selection
        if inputManager.analogRUpPressed then -- right analog up
            currentCatIndex = currentCatIndex - 1
            if currentCatIndex < 1 then
                currentCatIndex = 1
            end
        end

        if inputManager.analogRDownPressed then -- right analog down
            currentCatIndex = currentCatIndex + 1
            if currentCatIndex > #gameController.categories then
                currentCatIndex = currentCatIndex - 1
            end
        end

        gameController.setCurrentCategory(currentCatIndex)
    end

    --function self.displayLaunchButton ( )
        --local startupImage = gameController.currentApp.startupImage
        --if startupImage then
            --imageResize(startupImage, lbWidth, lbHeight) -- shall be scale in order to respect aspect ratio!!!
            ----imageScale(startupImage, 2.0)
            --imageBlit(startupImage, lbX, lbY)

             ---- launch app if needed : shall be somewhere else, callback system??
            --if inputManager.tfX[1] > lbX and inputManager.tfX[1] < lbX + lbWidth and inputManager.tfY[1] > lbY and inputManager.tfY[1] < lbY + lbHeight then
                --launchGame(gameController.currentApp.id)
            --end
        --end
    --end

    function self.displayList ( pAppList )
        --local currentCategory = gameController.currentCategory 
        --local currentPlateform = gameController.currentPlateform
        
        --local currentAppIndex = gameController.indexByContext[currentPlateform][currentCategory]
        local currentAppIndex = gameController.getCurrentIndex()
        local appObject = ""
        local y = 0

        nbAppDisplay = 0
        
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
            
            y = currentY - cpt * self.lineSeparator

            -- if there is no space left on the screen, exit
            if y < self.y then
                break
            end

            -- print the app line
            self.printLine (appObject, currentX, y, self.listFontSize, self.listFontColor)

            -- update the counters
            i = i - 1
            cpt = cpt + 1
        end

        nbAppDisplay = nbAppDisplay + cpt - 1
        
        -- display the selection
        y = currentY
        self.printLine (gameController.getCurrentApp(), currentX, y, self.selectionSize, self.selectionColor)
        nbAppDisplay = nbAppDisplay + 1
        
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
            
            y = currentY + cpt * self.lineSeparator

            -- if there is no space left on the screen, exit
            if y > self.h + self.y then
                break
            end

            -- print the app line
            self.printLine (appObject, currentX, y, self.listFontSize, self.listFontColor)

            -- update the counters
            i = i + 1
            cpt = cpt + 1
        end

        nbAppDisplay = nbAppDisplay + cpt - 1
    end

    function self.printLine ( pAppObject, pX, pY, pFontSize, pFontColor )
        local currentCategory = gameController.currentCategory 
        local currentPlateform = gameController.currentPlateform

        local xShift = 0

        if currentPlateform == "All" then
            -- display plateform icon
            local plateformIcon = mmi.getPlateformeIcon(pAppObject.plateform)
            imageBlit(plateformIcon, pX + xShift, pY)
            xShift = xShift + 40
        end

        -- display region icon
        --local regionIcon = mmi.getRegionIcon(pAppObject.region)
        --imageBlit(regionIcon, pX + xShift, pY)
        --xShift = xShift + 40

        -- display title
        local title = pAppObject.title

        -- reduce title if needed
        --local titleWidth = screen.textwidth(title, pFontSize)
        --if titleWidth + xShift > lbX then
--
        --end
        
        printScreen2(title, pX + xShift, pY, pFontSize, pFontColor)
        --xShift = xShift + titleWidth
        
    end
    
    return self
end
