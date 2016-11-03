function InfoController()
    local self = {}

    self.vitaFilters = {'^PCS.*'}
    self.snesFilters = {"sfc"}
    self.appInfos = {}
    --self.appInfos = nil
    self.plateforms = {"All"}
    self.categories = {"All"}
    
    function self.refreshInfo()
        self.gatherVitaInfo("ux0:/app")
        self.gatherRomInfo("snes", "ux0:/roms/snes")

        --self.getGamesCategory("PSVita")
        
        --self.writeToXml()
    end

    -- get vita application information in a specified directories
    function self.gatherVitaInfo ( pPath )
        local directories = listDirectories(pPath)

        insertTable(self.plateforms, "PSVita")
        
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

                insertMatrix2(self.appInfos, "All", "All", gameObject)
                insertMatrix2(self.appInfos, "PSVita", "All", gameObject)
                if gameObject.category then
                    insertMatrix2(self.appInfos, "All", gameObject.category, gameObject)
                    insertMatrix2(self.appInfos, "PSVita", gameObject.category, gameObject)
                    insertTable(self.categories, gameObject.category)
                end
            end
        end
    end

    -- gather roms information from retro systems (snes, nes, ...)
    -- the directories shall follow the following hierarchy :
    -- ux0:/roms/<system name>
    function self.gatherRomInfo ( pPlateform, pPath, pCategory )
        local files = files.listfiles(pPath)

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
                local gameObject = GameRomObject(pPlateform, value.name, value.path, pCategory)

                insertMatrix2(self.appInfos, "All", "All", gameObject)
                insertMatrix2(self.appInfos, pPlateform, "All", gameObject)
                if gameObject.category then
                    insertMatrix2(self.appInfos, "All", gameObject.category, gameObject)
                    insertMatrix2(self.appInfos, pPlateform, gameObject.category, gameObject)
                    insertTable(self.categories, gameObject.category)
                end
            end
        end

        -- consider sub directory as category
        local directories = listDirectories(pPath)
        for key,value in pairs(directories) do
            self.gatherRomInfo(pPlateform, value.path, value.name)
        end 
    end

    function self.getGamesCategory ( pPlateform )
        local catFile = ""

        if pPlateform == "PSVita" then
            catFile = "ux0:/data/VGLauncher/catver.ini"
        else
            catFile = "ux0:/roms/"..pPlateform.."/catver.ini"
        end

        if filesExists(catFile) then
            local fd = io.open (catFile, "r")

            local line = read(fd, "l") -- read line by line, nil on eof

            while line != nil do
                local i, j = string.find(line, "=", 0, true)

                if i != nil then
                    local gameTitle = string.sub(pName, 0, i-1)

                    local gameCategory = string.sub(pName, i)

                    if self.appInfos[gameTitle] then
                        self.appInfos[gameTitle].category = gameCategory
                    end
                end
                
                line = read (fd, "l")
            end
        end
    end

    function writeGamesCategory ( pPlateform )
        local catFile = ""

        if pPlateform == "PSVita" then
             catFile = "ux0:/data/VGLauncher/catver.ini"
        else
            catFile = "ux0:/roms/"..pPlateform.."/catver.ini"
        end

        local fd = io.open(catFile, "w")

        io.write(fd, "[Category]")
        
        for title,gameObject in pairs(self.appInfos) do
            io.write(fd, title.." = "..gameObject.category)
        end

        io.close(fd)
    end
    
    function self.writeToXml ()
        xmlFilename = "ux0:/data/VGLauncher/gamesInfo.xml"
        fd = io.open (xmlFilename, "w")

        io.write(fd, "<gamesInfo>")
        
        for key,value in pairs(self.appInfos) do
            --value.id
            xmlInfo = value.serialize("xml")
            io.write(fd, "   "..xmlInfo)
        end

        io.write(fd, "</gamesInfo>")

        io.close(fd)
    end

    function self.readFromXml()
        xmlFilename = "ux0:/data/VGLauncher/gamesInfo.xml"

        SLAXML:parse(xmlFilename)
        
        --parser = SLAXML:parser{
          --startElement = function(name,nsURI,nsPrefix)       end, -- When "<foo" or <x:foo is seen
          --attribute    = function(name,value,nsURI,nsPrefix) end, -- attribute found on current element
          --closeElement = function(name,nsURI)                end, -- When "</foo>" or </x:foo> or "/>" is seen
          --text         = function(text)                      end, -- text and CDATA nodes
          --comment      = function(content)                   end, -- comments
          --pi           = function(target,content)            end, -- processing instructions e.g. "<?yes mon?>"
        --}

        ---- Ignore whitespace-only text nodes and strip leading/trailing whitespace from text
        ---- (does not strip leading/trailing whitespace from CDATA)
        --parser:parse(xmlFilename,{stripWhitespace=true})
    end

    -- return the instance
    return self
end
