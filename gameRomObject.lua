function GameRomObject( pPlateform, pFilename, pPath, pTitle, pRegion, pVersion, pCategory, pDate, pDescription)
    local self = GameObject(pPlateform, pId, pPath, pTitle, pRegion, pVersion, pCategory, pDate, pDescription)
    
    -- specific game rom
    self.filename = pFilename

    function self.initialization ()
        -- The id of the info is the id of the retroarch vpk corresponding of the system name
        self.id = self.computeId(pPlateform)
        self.title = self.computeRomTitle(pFilename)
        self.region = self.computeRomRegion(pFilename)
        self.version = self.computeRomVersion(pFilename)

        self.initialization2()
    end
    
    function self.computeRomTitle( pName )
        local title = nil

        local i, j = string.find(pName, "(", 0, true)

        if i != nil then
            title = string.sub(pName, 0, i-1)
        end
        
        return title
    end

    function self.computeRomRegion( pName )
        local region = nil

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
    
    function self.computeRomVersion( pName )
        local version = nil
        
        return version
    end

    function self.computeId( pPlateform )
        local id = "RETROVITA"

        --if pPlateform == "snes" then
            --id = "RETR00031"
        --elseif pPlateform == "megadrive" then
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
