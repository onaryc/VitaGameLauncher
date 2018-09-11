function Mmi(pScreenWidth, pScreenHeight, pCategories, pPlateforms)
    local self = {}

    self.screenWidth = pScreenWidth
    self.screenHeight = pScreenHeight

    self.debug = false

    self.regionIcons = {}
    self.plateformIcons = {}
    self.categoryIcons = {}

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
    local appLaunchWidth = self.screenWidth / 4
    --local appLaunchHeight = self.screenHeight / 2
    local appLaunchHeight = appLaunchWidth
    local appLaunchX = self.screenWidth - appLaunchWidth - 20
    local appLaunchY = sysInfoHeight + ((self.screenHeight - sysInfoHeight - appInfoHeight) / 2) - appLaunchHeight / 2
    
    function self.initialization ( )
        --splashScreen()
        loadpalette()

        -- input manager
        --inputManager = InputManager()

        -- profile loading
        -- widget creation
        profileController.evalProfile()
        wMainFrame = WFrame("main", nil, 0, 0, self.screenWidth, self.screenHeight, color.yellow)
        wGamesFrame = WFrame("games", wMainFrame, 0, 0, self.screenWidth, self.screenHeight, color.yellow)
        wSystemInfo = WSystemInfo("sysInfo", wGamesFrame, sysInfoX, sysInfoY, sysInfoWidth, sysInfoHeight, color.yellow)
        wAppInfo = WAppInfo("appInfo", wGamesFrame, appInfoX, appInfoY, appInfoWidth, appInfoHeight, color.blue)
        wBackground = WBackground("appBackground", wGamesFrame, 0, 0, self.screenWidth, self.screenHeight, "appBackground", 100, "")
        wList = WList("appList", wGamesFrame, appListX, appListY, appListWidth, appListHeight, "center", 10, color.orange, 1.2, color.white, 1.2, 35, color.orange)
        wAppLaunch = WAppLaunch("appLaunch", wGamesFrame, appLaunchX, appLaunchY, appLaunchWidth, appLaunchHeight, color.orange)

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
        wMainFrame.update()

        screenFlip()
    end

    function self.getRegionIcon( pRegion )
        local regionIcon = nil    

        regionIcon = self.regionIcons[pRegion]
        
        return regionIcon
    end

    function self.getPlateformeIcon( pPlateform )
        local plateformIcon = nil    

        plateformIcon = self.plateformIcons[pPlateform]
        
        return plateformIcon
    end
    
    function self.getCategoryIcon( pCategory )
        local categoryIcon = nil    

        categoryIcon = self.categoryIcons[pCategory]
        
        return categoryIcon
    end

    self.initialization()

    -- return the instance
    return self
end
