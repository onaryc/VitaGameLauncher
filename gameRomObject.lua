function GameRomObject( pPlateform, pFilename, pPath, pTitle, pRegion, pVersion, pCategory, pDate, pDescription)
    local self = GameObject(pPlateform, pId, pPath, pTitle, pRegion, pVersion, pCategory, pDate, pDescription)
    
    -- specific game rom
    self.filename = pFilename

    function self.initialization ()
        -- The id of the info is the id of the retroarch vpk corresponding of the system name
        self.id = self.computeId()
        self.title = self.computeRomTitle()
        self.region = self.computeRomRegion()
        self.version = self.computeRomVersion()

        self.initialization2()
    end
    
    function self.computeRomTitle( )
        local title = self.filename

        local i, j = string.find(title, "(", 0, true)

        if i != nil then
            title = string.sub(title, 0, i-1)
        end
        
        return title
    end

    function self.computeRomRegion( )
        local region = nil

        --string.find (s, pattern [, init [, plain]])
        
        local testFilter = string.match(self.filename, '.*USA.*')
        if testFilter != nil then
            region = "usa"
        else
            testFilter = string.match(self.filename, '.*Europe.*')
            if testFilter != nil then
                region = "europe"
            else
                testFilter = string.match(self.filename, '.*Japan.*')
                if testFilter != nil then
                    region = "japan"
                else
                    testFilter = string.match(self.filename, '.*World.*')
                    if testFilter != nil then
                        region = "world"
                    else
                        region = "unk"
                    end
                end
            end
        end

        return region
    end
    
    function self.computeRomVersion( )
        local version = nil
        
        return version
    end

    function self.computeId( )
        local id = "RETROVITA"

        --if self.plateform == "snes" then
            --id = "RETR00031"
        --elseif self.plateform == "megadrive" then
            --id = "RETR00026"
        --end
        
        return id
    end

    function self.serialize ( pType )
        xml = "<GameRomObject"

        xml = xml..self.serialize2(pType)
        
        if self.filename then
            xml = xml.." filename="..self.filename
        end
        
        xml = xml.." />"

        return xml
    end

    self.initialization()
    
    return self
end
