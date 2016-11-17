-- TODO
-- left/right : jump in list
-- if up/down pressed => quick navigating
-- step for plateform and category
-- touch interaction for plateform/category

function InputManager()
    local self = {}

    self.currentAppIndex = 1
    self.currentCategory = "All"
    self.currentPlateform = "All"
    self.debug = false

    self.shiftTFX = {[1]=0, [2]=0, [3]=0, [4]=0, [5]=0, [6]=0}
    self.shiftTFY = {[1]=0, [2]=0, [3]=0, [4]=0, [5]=0, [6]=0}
    self.tfX = {[1]=-1, [2]=-1, [3]=-1, [4]=-1, [5]=-1, [6]=-1}
    self.tfY = {[1]=-1, [2]=-1, [3]=-1, [4]=-1, [5]=-1, [6]=-1}
    
    self.indexByContext = {}
    
    local categories = {"All"}
    local plateforms = {"All"}
    
    local currentCatIndex = 1
    local currentPlateformIndex = 1
    local analogDeadzone = 30

    local previousFState = {[1]="released", [2]="released", [3]="released", [4]="released", [5]="released", [6]="released"}
    local previousFX = {[1]=0, [2]=0, [3]=0, [4]=0, [5]=0, [6]=0}
    local previousFY = {[1]=0, [2]=0, [3]=0, [4]=0, [5]=0, [6]=0}
    
    function self.update ( pAppInfos, pDebug )
        local currentAppIndex = self.indexByContext[self.currentPlateform][self.currentCategory]
        local debugLevel = pDebug

        buttons.read()

        -- launching game
        if buttons.cross then
            --printScreen("Launching game : "..pAppInfos[self.currentPlateform][self.currentCategory][currentAppIndex].id, 400, 10)
            launchGame(pAppInfos[self.currentPlateform][self.currentCategory][currentAppIndex].id)
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

        self.indexByContext[self.currentPlateform][self.currentCategory] = currentAppIndex

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

        -- compute touch shift, ...
        self.computeFTouch ()

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

    function self.computeFTouch ( )
        for i=1,6 do
            if buttons.touchf[i].moved == true then
                if previousFState[i] == "released" then -- first touch, shift shall be equal to 0
                    previousFX[i] = buttons.touchf[i].x
                    previousFY[i] = buttons.touchf[i].y
                end

                -- set touch x and Y
                self.tfX[i] = buttons.touchf[i].x
                self.tfY[i] = buttons.touchf[i].y

                -- compute shift
                self.shiftTFX[i] = buttons.touchf[i].x - previousFX[i]
                self.shiftTFY[i] = buttons.touchf[i].y - previousFY[i]

                -- update previous coordinates
                previousFX[i] = buttons.touchf[i].x
                previousFY[i] = buttons.touchf[i].y

                previousFState[i] = "moved"
            else
                self.tfX[i] = -1
                self.tfY[i] = -1
                
                self.shiftTFX[i] = 0
                self.shiftTFY[i] = 0

                previousFState[i] = "released"
            end
        end
    end
    
    function self.initialize ( pCategories, pPlateforms )
        -- set instance variable
        plateforms = pPlateforms
        categories = pCategories

        -- intialize a list which contains current app index for each category
        self.indexByContext = {}
        for key,value in pairs(plateforms) do
            self.indexByContext[value] = {}
            for key1,value1 in pairs(categories) do
                self.indexByContext[value][value1] = 1
            end
        end
    end
    
    -- return the instance
    return self
end
