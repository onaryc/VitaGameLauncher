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
                local gameObject = GameVitaObject(value.name, value.path)

                table.insert(self.appInfos, gameObject)
            end
        end
    end

    -- gather roms information from retro systems (snes, nes, ...)
    -- the directories shall follow the following hierarchy :
    -- ux0:/roms/<system name>
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
                local gameObject = GameRomObject(pPlateform, value.name, value.path)
                
                table.insert(self.appInfos, gameObject)
            end
        end
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
