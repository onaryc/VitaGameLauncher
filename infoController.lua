function InfoController()
    local self = {}

    self.vitaFilters = {'^PCS.*'}
    self.snesFilters = {"sfc"}
    self.appInfos = {}

    function self.refreshInfo()
        self.gatherVitaInfo("ux0:/app")
        self.gatherRomInfo("snes", "ux0:/roms/snes")
    end

    -- get vita application information in a specified directories
    function self.gatherVitaInfo ( pPath )
        local directories = listDirectories(pPath)
        
        for key,value in pairs(directories) do
            local test = false
            
            for key1,value1 in pairs(self.vitaFilters) do
                local testFilter = string.match(value.name, value1)

                if testFilter != nil then
                    test = true
                    break
                end
            end 
            
            if test == true then
                local gameObject = GameObject("PSVita", value.name, value.path)
                --tmpInfo = {id = value.name, path = value.path, title = gameInfo.TITLE, region = gameInfo.REGION, version = gameInfo.APP_VER}
                table.insert(self.appInfos, gameObject)
            end
        end
    end

    -- gather roms information from retro systems (snes, nes, ...)
    -- the directories shall follow the following hierarchy :
    -- ux0:/roms/<system name>
    -- The id of the info is the id of the retroarch vpk corresponding of the system name
    function self.gatherRomInfo ( pPlateform, pPath )
        local files = files.listfiles(pPath)

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
                local title = computeTitle()
                local region = computeRegion(value.name)
                local version = computeVersion()
                local genre = computeGenre(value.name, pPath)
                
                local gameObject = GameObject(pPlateform, value.name, value.path, title, region, version)
                
                table.insert(self.appInfos, gameObject)
            end
        end
    end

    --local function computeInfo (pName, pPath)
--
    --end

    local function computeTitle( pName )
        local title = ""
        
        title = string.gsub(pName, "\(.*\)", "")
        
        return title
    end

    local function computeRegion( pName )
        local region = ""

        --string.find (s, pattern [, init [, plain]])
        
        local testFilter = string.match(value.name, '.*\(USA\).*')
        if testFilter == true then
            region = "USA"
        else
            testFilter = string.match(value.name, '.*\(Europe\).*')
            if testFilter == true then
                region = "Europe"
            else
                testFilter = string.match(value.name, '.*\(Japan\).*')
                if testFilter == true then
                    region = "Japan"
                else
                    testFilter = string.match(value.name, '.*\(World\).*')
                    if testFilter == true then
                        region = "World"
                    else
                        region = "Unk"
                    end
                end
            end
        end

        return region
    end
    
    local function computeVersion( pName )
        local version = ""
        
        return version
    end

    
    local function computeGenre( pName, pPath )
        local genre = ""

        return genre
    end

    --function self.writeToXml()
        --for key,value in pairs(appInfos) do
            ----value.id
        --end
    --end

    --function self.readFromXml()

    --end

    -- return the instance
    return self
end
