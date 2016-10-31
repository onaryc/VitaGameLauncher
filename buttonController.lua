function ButtonController()
    local self = {}

    self.currentAppIndex = 1
    self.currentCategory = "All"
    self.currentPlateform = "All"
    
    --self.currentCatIndex = 1
    self.indexByContext = nil
    self.categories = {"All"}
    self.plateforms = {"All"}
    
    self.debug = false

    local currentCatIndex = 1
    local currentPlateformIndex = 1
    local analogDeadzone = 30
    --function self.initialization ()
    --
    --end

    function self.update ( pAppInfos, pDebug )
        local currentAppIndex = self.indexByContext[self.currentPlateform][self.currentCategory]
        --local currentAppIndex = pCurrentAppIndex
        --local currentCatIndex = self.currentCatIndex
        local debugLevel = pDebug
        
        buttons.read()

        -- launching game
        if buttons.cross then
            printScreen("Launching game : "..pAppInfos[currentAppIndex].id, 400, 10)
            game.launch(pAppInfos[currentAppIndex].id)
        end

        -- game selection
        if buttons.up then
            currentAppIndex -= 1
            if currentAppIndex < 1 then
                currentAppIndex = 1
            end
        end

        if buttons.down then
            currentAppIndex += 1
            if currentAppIndex > #pAppInfos then
                currentAppIndex -= 1
            end
        end

        self.indexByContext[self.currentPlateform][self.currentCategory] = currentAppIndex

        -- plateform selection
        if buttons.buttons.analogly > analogDeadzone then -- left analog up
            currentPlateformIndex -= 1
            if currentPlateformIndex < 1 then
                currentPlateformIndex = 1
            end
        end

        if buttons.buttons.analogly < -analogDeadzone then -- left analog down
            currentPlateformIndex += 1
            if currentPlateformIndex > #self.plateforms then
                currentPlateformIndex -= 1
            end
        end

        self.currentPlateform = self.categories[currentPlateformIndex] 
        
        -- category selection
        if buttons.buttons.analogry > analogDeadzone then -- right analog up
            currentCatIndex -= 1
            if currentCatIndex < 1 then
                currentCatIndex = 1
            end
        end

        if buttons.buttons.analogry < -analogDeadzone then -- right analog down
            currentCatIndex += 1
            if currentCatIndex > #self.categories then
                currentCatIndex -= 1
            end
        end

        self.currentCategory = self.categories[currentCatIndex] 
        
        -- exit app
        if buttons.released.start then
            os.exit()
        end

        -- manage debug level
        if buttons.held.select then
            debugLevel = true
        end

        if buttons.released.select then
            debugLevel = false
        end

        self.currentAppIndex = currentAppIndex
        self.debug = debugLevel
        
        --return currentAppIndex, tmpDebug 
    end
    
    function self.initialize ( pCategories, pPlateforms )
        -- set instance variable
        self.plateforms = pPlateforms
        self.categories = pCategories

        -- intialize a list which contains current app index for each category
        for key,value in pairs(self.plateforms) do
            for key1,value1 in pairs(self.categories) do
                self.indexByContext[value][value1] = 1
            end
        end
    end
    
    -- return the instance
    return self
end
