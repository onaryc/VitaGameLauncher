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
        wMainFrame = WFrame{id="main", frame=nil, x=0, y=0, width=self.screenWidth, height=self.screenHeight, debugColor=color.yellow}
        wGamesFrame = WFrame{id="games", frame=wMainFrame, x=0, y=0, width=self.screenWidth, height=self.screenHeight, debugColor=color.yellow}
        wSystemInfo = WSystemInfo{id="sysInfo", frame=wGamesFrame, x=sysInfoX, y=sysInfoY, width=sysInfoWidth, height=sysInfoHeight, debugColor=color.yellow}
        wAppInfo = WAppInfo{id="appInfo", frame=wGamesFrame, x=appInfoX, y=appInfoY, width=appInfoWidth, height=appInfoHeight, debugColor=color.blue}
        wBackground = WBackground{id="appBackground", frame=wGamesFrame, x=0, y=0, width=self.screenWidth, height=self.screenHeight, type="appBackground", alpha=100}
        wList = WList{id="appList", frame=wGamesFrame, x=appListX, y=appListY, width=appListWidth, height=appListHeight, mode="center", xIdent=10, selectionColor=color.orange, selectionSize=1.2, fontColor=color.white, fontSize=1.2, lineSeparator=35, debugColor=color.orange}
        wAppLaunch = WAppLaunch{id="appLaunch", frame=wGamesFrame, x=appLaunchX, y=appLaunchY, width=appLaunchWidth, height=appLaunchHeight, shape="circle", bordure=5, debugColor=color.orange}

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
