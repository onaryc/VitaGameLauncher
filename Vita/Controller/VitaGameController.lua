-- TODO
-- * bug : no plateform icon for snes plateform after the first folder
-- * merge psvita and rom gather info

function VitaGameController()
    local self = VGLGameController()

    self.vitaFilters = {'^PCS.*'}

    self.loadBGImageTimer = timer.new()
    self.loadBGImageTimer:reset()

    local parentInitialize = self.initialize()
    function self.initialize()
        parentInitialize()
    end
        
    function self.refreshAppData()
        self.gatherVitaInfo("ux0:/app")
        self.gatherRomInfo("snes", "ux0:/roms/snes")

        self.initIndex()
        --self.getGamesCategory("PSVita")
        
        --self.writeToXml()
    end

    -- get vita application information in a specified directories
    function self.gatherVitaInfo ( pPath )
        local games = listGames()

		--printDebug("test\n")
		--printDebug("game nb "..tostring(#games).."\n")
		--renderDebug ()
		--screenFlip()
		--buttons.waitforkey() 
        insertTable(self.plateforms, "PSVita")
        
        for key,value in pairs(games) do
            local test = false
 
            for key1,value1 in pairs(self.vitaFilters) do
                local testFilter = string.match(value.id, value1)

                if testFilter != nil then
                    test = true
                    break
                end
            end 
 
            if test == true then
                local gameObject = GameVitaObject(value.id, value.path)
                --gameObject.plateformIcon = self.vitaIcon
                --gameObject.regionIcon = self.getAppRegionIcon(gameObject.region)
                
                insertMatrix2(self.getAppData, "All", "All", gameObject)
                insertMatrix2(self.getAppData, "PSVita", "All", gameObject)
                if gameObject.category then
                    insertMatrix2(self.getAppData, "All", gameObject.category, gameObject)
                    insertMatrix2(self.getAppData, "PSVita", gameObject.category, gameObject)
                    insertTable(self.categories, gameObject.category)
                end

                if gameObject.region then
                    insertTable(self.regions, gameObject.region)
                end
            end
        end
    end

    -- work in progress functions --
    
    function self.writeToXml ()
        xmlFilename = "ux0:/data/VGLauncher/gamesInfo.xml"
        fd = io.open (xmlFilename, "w")

        io.write(fd, "<gamesInfo>")
        
        for key,value in pairs(self.getAppData) do
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

                    if self.getAppData[gameTitle] then
                        self.getAppData[gameTitle].category = gameCategory
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
        
        for title,gameObject in pairs(self.getAppData) do
            io.write(fd, title.." = "..gameObject.category)
        end

        io.close(fd)
    end


    -- return the instance
    return self
end

vitaGameController = VitaGameController()
api.addController(vitaGameController)

