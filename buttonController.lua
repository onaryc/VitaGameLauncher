function ButtonController()
    local self = {}

    self.currentAppIndex = 1
    self.currentCategory = "All"
    self.currentPlateform = "All"

    local indexByContext = {}
    local categories = {"All"}
    local plateforms = {"All"}
    
    self.debug = false

    local currentCatIndex = 1
    local currentPlateformIndex = 1
    local analogDeadzone = 30

    function self.update ( pAppInfos, pDebug )
        local currentAppIndex = indexByContext[self.currentPlateform][self.currentCategory]
        local debugLevel = pDebug
        
        buttons.read()

        -- launching game
        if buttons.cross then
            --printScreen("Launching game : "..pAppInfos[self.currentPlateform][self.currentCategory][currentAppIndex].id, 400, 10)
            game.launch(pAppInfos[self.currentPlateform][self.currentCategory][currentAppIndex].id)
        end

        --printScreen ("before App index : "..tostring(currentAppIndex), 100, 60)
        
        -- game selection
        if buttons.up then
            currentAppIndex = currentAppIndex - 1
            if currentAppIndex < 1 then
                currentAppIndex = 1
            end
        end

        if buttons.down then
            currentAppIndex = currentAppIndex + 1
            if currentAppIndex > #pAppInfos[self.currentPlateform][self.currentCategory] then
                currentAppIndex = currentAppIndex - 1
            end
        end

        --printScreen ("After App index : "..tostring(currentAppIndex), 100, 80)

        indexByContext[self.currentPlateform][self.currentCategory] = currentAppIndex

        self.currentAppIndex = currentAppIndex
        
        -- plateform selection
        if buttons.analogly > analogDeadzone then -- left analog up
            currentPlateformIndex = currentPlateformIndex - 1
            if currentPlateformIndex < 1 then
                currentPlateformIndex = 1
            end
        end

        if buttons.analogly < -analogDeadzone then -- left analog down
            currentPlateformIndex = currentPlateformIndex + 1
            if currentPlateformIndex > #plateforms then
                currentPlateformIndex = currentPlateformIndex - 1
            end
        end

        self.currentPlateform = plateforms[currentPlateformIndex] 
        
        -- category selection
        if buttons.analogry > analogDeadzone then -- right analog up
            currentCatIndex = currentCatIndex - 1
            if currentCatIndex < 1 then
                currentCatIndex = 1
            end
        end

        if buttons.analogry < -analogDeadzone then -- right analog down
            currentCatIndex = currentCatIndex + 1
            if currentCatIndex > #categories then
                currentCatIndex = currentCatIndex - 1
            end
        end

        self.currentCategory = categories[currentCatIndex] 
        
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

        self.debug = debugLevel
    end
    
    function self.initialize ( pCategories, pPlateforms )
        -- set instance variable
        plateforms = pPlateforms
        categories = pCategories

        -- intialize a list which contains current app index for each category
        indexByContext = {}
        for key,value in pairs(plateforms) do
            indexByContext[value] = {}
            for key1,value1 in pairs(categories) do
                indexByContext[value][value1] = 1
            end
        end
    end
    
    -- return the instance
    return self
end
