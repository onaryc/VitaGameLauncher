function VGLGameController()
    local self = VGLInstanceController()

    self.currentCategory = "All"
    self.currentPlateform = "All"

    self.appData = {}
    self.plateforms = {"All"}
    self.categories = {"All"}
    self.regions = {"All"}

    self.currentApp = nil
    self.previousApp = nil
    self.indexByContext = {}

    -- retro extension filters
    self.snesFilters = {"sfc", "smc"}

    function self.initialize()
        api.register(self.getAppData, "getAppData")
        api.register(self.getCategories, "getCategories")
        api.register(self.getCurrentCategory, "getCurrentCategory")
        api.register(self.getPlateforms, "getPlateforms")
        api.register(self.getCurrentPlateform, "getCurrentPlateform")
        api.register(self.getRegions, "getRegions")
        api.register(self.refreshAppData, "refreshAppData")
        api.register(self.appsSortBy, "appsSortBy")
        api.register(self.getCurrentAppIndex, "getCurrentAppIndex")
        api.register(self.setCurrentAppIndex, "setCurrentAppIndex")
        api.register(self.getCurrentApp, "getCurrentApp")
        api.register(self.setCurrentApp, "setCurrentApp")
        api.register(self.setCurrentPlateform, "setCurrentPlateform")
        api.register(self.setCurrentCategory, "setCurrentCategory")
    end

    -- api functions --

    function self.getAppData()
        return self.appData
    end
    
    function self.getCategories()
        return self.categories
    end
    
    function self.getCurrentCategory()
        return self.currentCategory
    end

    function self.getPlateforms()
        return self.plateforms
    end

    function self.getCurrentPlateform()
        return self.currentPlateform
    end
    
    function self.getRegions()
        return self.regions
    end

    function self.refreshAppData()
        --to be defined byt the game controller specialization
    end

    function self.appsSortBy ( pMode )
        local sortedApps = nil
            
        if testTable2(self.appData, self.plateforms, self.categories) then
            sortedApps = self.appData[self.plateforms][self.categories]

            if pMode == "title" then
                table.sort(sortedApps, self.sortByTitle)
            end
        end

        return sortedApps
    end

    function self.getCurrentAppIndex ()
        return self.indexByContext[self.currentPlateform][self.currentCategory]
    end
    
    function self.setCurrentAppIndex ( pIndex )
        self.indexByContext[self.currentPlateform][self.currentCategory] = pIndex
    end

    function self.getCurrentApp ()
        return self.currentApp
    end

    function self.setCurrentApp ( pCurrentApp )
        -- initialize values
        if self.previousApp == nil then
            self.previousApp = self.currentApp
            self.currentApp = pCurrentApp
        end

        -- test if the new value is indeed different from the previous one
        if pCurrentApp != self.previousApp then
            self.loadBGImageTimer:reset()
            self.loadBGImageTimer:start()
        
            self.previousApp = self.currentApp
            self.currentApp = pCurrentApp

            -- recompute app data in order to preserve memory
            self.previousApp.freeData()
        else
            if self.loadBGImageTimer:time() >= 300 then
                self.currentApp.loadData()
                self.loadBGImageTimer:reset() -- if the timer is not reset, the data are continusly loaded
            end
        end
    end

    function self.setCurrentPlateform ( pIndex )
        self.currentPlateform = self.plateforms[pIndex]
    end

    function self.setCurrentCategory ( pIndex )
        self.currentCategory = self.categories[pIndex]
    end

    -- other functions --
    function self.initIndex()
        -- intialize a list which contains current app index for each category
        self.indexByContext = {}
        for key,value in pairs(self.plateforms) do
            self.indexByContext[value] = {}
            for key1,value1 in pairs(self.categories) do
                self.indexByContext[value][value1] = 1
            end
        end
    end

    -- gather roms information from retro systems (snes, nes, ...)
    -- the directories shall follow the following hierarchy :
    -- ux0:/roms/<system name>
    function self.gatherRomInfo ( pPlateform, pPath, pCategory )
        local files = files.listfiles(pPath)
        
        if files != nil then

			insertTable(self.plateforms, pPlateform)
			
			if pPlateform == "snes" then
				filters = self.snesFilters
			else
				filters = ".*"
			end
			
			for key,value in pairs(files) do
				local test = false
				
				for key1,ext in pairs(filters) do
					if ext == value.ext then
						test = true
						break
					end 
				end
				
				if test == true then
					local gameObject = GameRomObject(pPlateform, value.name, value.path)
					--gameObject.plateformIcon = pPlateformIcon
					--gameObject.regionIcon = self.getAppRegionIcon(gameObject.region)

					insertMatrix2(self.appData, "All", "All", gameObject)
					insertMatrix2(self.appData, pPlateform, "All", gameObject)
					if gameObject.category then
						insertMatrix2(self.appData, "All", gameObject.category, gameObject)
						insertMatrix2(self.appData, pPlateform, gameObject.category, gameObject)
						insertTable(self.categories, gameObject.category)
					end

					if gameObject.region then
						insertTable(self.regions, gameObject.region)
					end
				end
			end

			-- consider sub directory as category
			local directories = listDirectories(pPath)
			for key,value in pairs(directories) do
				self.gatherRomInfo(pPlateform, value.path, value.name)
			end
		end
    end

    function self.sortByTitle (pA, pB)
        return string.lower(pA.title) < string.lower(pB.title)
    end

    -- return the instance
    return self
end
