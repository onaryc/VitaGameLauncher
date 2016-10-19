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
                local title, region, version = self.getVitaInfo(value.name)
                local category = self.getVitaCategory(value.name)
                
                local gameObject = GameObject("PSVita", value.name, value.path, title, region, version, category)

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
                local title = self.computeRomTitle(value.name)
                local region = self.computeRomRegion(value.name)
                local version = self.computeRomVersion()
                local category = self.computeCategory(value.name, pPath)
                
                local gameObject = GameObject(pPlateform, value.name, value.path, title, region, version, category)
                
                table.insert(self.appInfos, gameObject)
            end
        end
    end

    function self.getVitaInfo ( pName )
        local title, region, version  = ""

        return title, region, version
    end

    function getVitaCategory ( pName )
        local category = ""

        return category
    end

    function self.computeRomTitle( pName )
        local title = ""

        local i, j = string.find(pName, "(", 0, true)

        if i != nil then
            title = string.sub(pName, 0, i-1)
        end
        
        return title
    end

    function self.computeRomRegion( pName )
        local region = ""

        --string.find (s, pattern [, init [, plain]])
        
        local testFilter = string.match(pName, '.*USA.*')
        if testFilter != nil then
            region = "USA"
        else
            testFilter = string.match(pName, '.*Europe.*')
            if testFilter != nil then
                region = "Europe"
            else
                testFilter = string.match(pName, '.*Japan.*')
                if testFilter != nil then
                    region = "Japan"
                else
                    testFilter = string.match(pName, '.*World.*')
                    if testFilter != nil then
                        region = "World"
                    else
                        region = "Unk"
                    end
                end
            end
        end

        return region
    end

    function self.computeVitaRegion ( pId )
        local region = ""

        --string.find (s, pattern [, init [, plain]])
        
        --local testFilter = string.match(pId, '.*PCS(E)|(A).*')
        local testFilter = string.match(pId, '.*PCSE.*')
        local testFilter2 = string.match(pId, '.*PCSA.*')
        if testFilter != nil or testFilter2 != nil then
            region = "USA"
        else
            local testFilter = string.match(pId, '.*PCSB.*')
            local testFilter2 = string.match(pId, '.*PCSF.*')
            if testFilter != nil or testFilter2 != nil then
                region = "Europe"
            else
                testFilter = string.match(pId, '.*PCSG.*')
                if testFilter != nil then
                    region = "Japan"
                else
                    testFilter = string.match(pId, '.*PCSH.*')
                    if testFilter != nil then
                        region = "Asia"
                    else
                        region = "Unk"
                    end
                end
            end
        end

        return region
    end
    
    function self.computeRomVersion( pName )
        local version = ""
        
        return version
    end

    
    function self.computeCategory( pName, pPath )
        local category = ""

        return category
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
