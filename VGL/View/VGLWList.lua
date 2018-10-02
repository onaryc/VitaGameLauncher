-- display a list of app name
-- TODO :

-- * separate the pure list features in WList (in order to reuse it) and the app specific parts in WAppList
-- * scrollbar ?
-- * sort by name, release date, ... => ask the gameController

-- DONE :
-- * center the selection!!!
-- * highlight selection

function VGLWList( pArg )
    local self = VGLWFrame(pArg)

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

    local parentUpdate = self.update -- in order to reuse parent function
    function self.update ( )         
        -- sort the list if needed
        local sortedApps = api.appsSortBy("title")
        if sortedApps then
            -- update current selection
            self.updateCurrentSelection(sortedApps)
            
            -- display the list
            self.displayList(sortedApps)
        end

        parentUpdate()
        --if api.getDebug() then
            --drawRectangle(self.x, self.y+1, self.w, self.h-2, color.orange)
            ----drawRectangle(lbX, lbY, lbWidth, lbHeight, color.orange)
        --end
    end

    function self.updateCurrentSelection ( pAppList )
        local currentCategory = api.getCurrentCategory() 
        local currentPlateform = api.getCurrentPlateform()
        local nbAppInfo = #pAppList

        -- get the current app index
        local currentAppIndex = api.getCurrentAppIndex()

        local shiftTFY1 = api.getShiftTouchFrontY(1)
        -- limit end and start of the list
        if self.mode != "center" then
            currentY = currentY + shiftTFY1
        end

        -- compute the current app index
        cumulateY = cumulateY + shiftTFY1
        if currentAppIndex == 1 then
            if shiftTFY1 > 0 then
                currentY = initListY
                cumulateY = 0
            end
        elseif currentAppIndex == nbAppInfo then
            if shiftTFY1 < 0 then
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

        if api.getDigitalUp() then
            currentAppIndex = currentAppIndex - 1
            if currentAppIndex < 1 then
                currentAppIndex = 1
            end
        end

        if api.getDigitalDown() then
            currentAppIndex = currentAppIndex + 1
            if currentAppIndex > nbAppInfo then
                currentAppIndex = currentAppIndex - 1
            end
        end

        if api.getDigitalLeft() then
            currentAppIndex = currentAppIndex - nbAppDisplay + 1
            if currentAppIndex < 1 then
                currentAppIndex = 1
            end
        end

        if api.getDigitalRight() then
            currentAppIndex = currentAppIndex + nbAppDisplay - 1
            if currentAppIndex > nbAppInfo then
                currentAppIndex = nbAppInfo
            end
        end

        api.setCurrentAppIndex(currentAppIndex)
        api.setCurrentApp (pAppList[currentAppIndex])

        -- plateform selection
        if api.getAnalogLUpPressed() then
            currentPlateformIndex = currentPlateformIndex - 1
            if currentPlateformIndex < 1 then
                currentPlateformIndex = 1
            end
        end
        
        if api.getAnalogLDownPressed() then
            currentPlateformIndex = currentPlateformIndex + 1
            if currentPlateformIndex > #api.getPlateforms() then
                currentPlateformIndex = currentPlateformIndex - 1
            end
        end

        api.setCurrentPlateform(currentPlateformIndex)

        -- category selection
        if api.getAnalogRUpPressed() then -- right analog up
            currentCatIndex = currentCatIndex - 1
            if currentCatIndex < 1 then
                currentCatIndex = 1
            end
        end

        if api.getAnalogRDownPressed() then -- right analog down
            currentCatIndex = currentCatIndex + 1
            if currentCatIndex > #api.getCategories() then
                currentCatIndex = currentCatIndex - 1
            end
        end

        api.setCurrentCategory(currentCatIndex)
    end

    function self.displayList ( pAppList )
        local currentAppIndex = api.getCurrentAppIndex()
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
        self.printLine (api.getCurrentApp(), currentX, y, self.selectionSize, self.selectionColor)
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
        local currentCategory = api.getCurrentCategory() 
        local currentPlateform = api.getCurrentPlateform()

        local xShift = 0

        if currentPlateform == "All" then
            -- display plateform icon
            local plateformIcon = api.getPlateformeIcon(pAppObject.plateform)
            imageBlit(plateformIcon, pX + xShift, pY)
            xShift = xShift + 40
        end

        -- display region icon
        --local regionIcon = api.getRegionIcon(pAppObject.region)
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
