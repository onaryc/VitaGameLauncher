function Mmi(pScreenWidth, pScreenHeight, pAppInfos, pCategories, pPlateforms)
    local self = {}

    self.screenWidth = pScreenWidth
    self.screenHeight = pScreenHeight

    self.debug = false

    self.regionIcons = {}
    self.plateformIcons = {}
    self.categoryIcons = {}

    local appInfos = pAppInfos
    local categories = pCategories
    local plateforms = pPlateforms

    local touch_alfa_top = {0,0,0,0,0,0}
    local touch_alfa_back = {0,0,0,0,0,0}
    local touch_col = {color.white, color.green, color.blue, color.red, color.yellow, color.orange, color.cyan}

    -- system info coordinates
    local sysInfoWidth = self.screenWidth
    local sysInfoHeight = 40
    local sysInfoX = 1
    local sysInfoY = 1

    -- app info coordinates
    local appInfoWidth = self.screenWidth
    local appInfoHeight = 60
    local appInfoX = 1
    local appInfoY = self.screenHeight - appInfoHeight

    -- app list coordinates
    local appListX = 1
    local appListY = sysInfoHeight
    --local appListWidth = self.screenWidth - appListX
    local appListWidth = self.screenWidth * (2 / 3)
    local appListHeight = self.screenHeight - sysInfoHeight - appInfoHeight

    -- app launch coordinates
    local appLaunchWidth = self.screenWidth / 3
    local appLaunchHeight = self.screenHeight / 2
    local appLaunchX = appListWidth
    local appLaunchY = sysInfoHeight + (appLaunchHeight / 4)
    
    function self.initialization ( )
        --splashScreen()
        loadpalette()

        -- input manager
        inputManager = InputManager()

        -- widget creation
        wSystemInfo = WSystemInfo(sysInfoX, sysInfoY, sysInfoWidth, sysInfoHeight)
        wAppInfo = WAppInfo(appInfoX, appInfoY, appInfoWidth, appInfoHeight)
        wBackground = WBackground(100)
        wAppList = WAppList(appListX, appListY, appListWidth, appListHeight)
        wAppLaunch = WAppLaunch(appLaunchX, appLaunchY, appLaunchWidth, appLaunchHeight)

        -- mmi icons
        self.initCategoryIcons()
        self.initPlateformIcons()
        self.initRegionIcons()
    end

    function self.initCategoryIcons ()
        for key,value in pairs(categories) do
            self.categoryIcons[value] = loadPlateformIcon(app0.."images/",value)
        end
    end
    
    function self.initPlateformIcons ()
        for key,value in pairs(plateforms) do
            self.plateformIcons[value] = loadPlateformIcon(app0.."images/",value)
        end
    end

    function self.initRegionIcons ()
        for key,value in pairs(gameController.regions) do
            self.regionIcons[value] = loadPlateformIcon(app0.."images/",value)
        end
    end


    function self.update( )
        -- global input management
        inputManager.update(appInfos)

        wBackground.update("appBackground")
        wAppList.update()
        wAppLaunch.update()
        wSystemInfo.update()
        wAppInfo.update()

        -- specific debug info
        if self.debug  == true then
            local threadID = gameController.getRefreshThread ()
            printScreen (tostring(threadID).." status: "..tostring(threadID:state()), 1, 1)
            printScreen (tostring(thread.geterror(threadID)), 1, 30)
            --local fps = screen.fps()
            --printScreen (tostring(fps), 1, 1)
            --printScreen ("App index : "..tostring(pCurrentAppIndex), 100, 100)
            --printScreen ("Current Plateform : "..tostring(pCurrentPlateform), 100, 120)
            --printScreen ("Current Category : : "..tostring(pCurrentCategory), 100, 140)

            --self.touchDebug()
            --ramVal1, ramVal2, ramVal3, ramVal4 = os.ram()
            --printScreen ("ramVal1 : "..tostring(ramVal1), 600, 100)
            --printScreen ("ramVal2 : "..tostring(ramVal2), 600, 120)
            --printScreen ("ramVal3 : "..tostring(ramVal3), 600, 140)
            --printScreen ("ramVal4 : "..tostring(ramVal4), 600, 160)
        end

        screenFlip()
    end

    function self.getRegionIcon( pRegion )
        local regionIcon = nil    

        regionIcon = self.regionIcons[pRegion]
        --if pRegion == "USA" then
            --regionIcon = self.usaIcon
        --elseif pRegion == "Japan" then
            --regionIcon = self.japanIcon
        --elseif pRegion == "Europe" then
            --regionIcon = self.europeIcon
        --elseif pRegion == "World" then
            --regionIcon = self.worldIcon
        --end
        
        return regionIcon
    end

    function self.getPlateformeIcon( pPlateform )
        local plateformIcon = nil    

        plateformIcon = self.plateformIcons[pPlateform]

        --if pPlateform == "PSVita" then
            --plateformIcon = self.vitaIcon
        --elseif pPlateform == "snes" then
            --plateformIcon = self.snesIcon
        --end
        
        return plateformIcon
    end
    
    function self.getCategoryIcon( pCategory )
        local categoryIcon = nil    

        categoryIcon = self.categoryIcons[pCategory]
        --if pCategory == "action" then
            --categoryIcon = self.actionIcon
        --elseif pCategory == "actionPlateformer" then
            --categoryIcon = self.actionPlateformerIcon
        --end
        
        return categoryIcon
    end

    function self.touchDebug( )
        for i=1,6 do
            printScreen2("+", buttons.touchf[i].x,buttons.touchf[i].y,1,touch_col[i]:a(touch_alfa_top[i]))

            if buttons.touchf[i].moved then
                touch_alfa_top[i] = 255
            elseif touch_alfa_top[i] > 0 then
                touch_alfa_top[i] -= 2
            end
        end

        for i=1,4 do
            printScreen2("X", buttons.touchb[i].x,buttons.touchb[i].y,1,touch_col[i]:a(touch_alfa_back[i]))

            if buttons.touchb[i].moved then
                touch_alfa_back[i] = 255
            elseif touch_alfa_back[i] > 0 then
                touch_alfa_back[i] -= 2
            end
        end
    end

    self.initialization()

    -- return the instance
    return self
end
