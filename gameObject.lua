function GameObject( pPlateform, pId, pPath )
    local self = {}

    -- public variables
    self.plateform = pPlateform
    self.id = pId
    self.path = pPath
    self.title = nil
    self.region = nil
    self.version = nil
    self.category = nil
    self.date = nil
    self.description = nil
    self.appBgImage = nil
    self.plateformBgImage = nil
    self.categoryBgImage = nil
    
    -- return the instance
    return self
end

function GameVitaObject( pId, pPath )
    local self = GameObject("PSVita", pId, pPath)

    -- private
    local bkFile = self.path.."/sce_sys/pic0.png"
    local paramSfoFile = self.path.."/sce_sys/param.sfo"
    local sfoInformation = SfoInformation()
    
    -- public
    self.region = self.computeVitaRegion(pId)
    self.title, self.region = self.getVitaInfo(pPath)
    self.dumperVersion = nil
    self.appBgImage = imageLoad(bkFile)

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

    function self.getVitaInfo ( pPath )
        local title, version  = ""

        res = sfoInformation.analyze(paramSfoFile)
        title = res.TITLE
        
        -- remove uppercase (exept for word beginning) and useless char ;)
        title = string.gsub (title, "™", "")
        title = string.gsub (title, "®", "")
        title = string.gsub (title, "³", " 3")

        title = string.gsub (title, "%a(%u)", string.lower(%1))
        --title = string.lower(title)

        -- get app version
        version = res.APP_VER
        
        return title, version
    end

    --function self.getVitaCategory ( pName )
        --local category = ""
--
        --return category
    --end

    return self
end

function GameRomObject( pPlateform, pFilename, pPath )
    local self = GameObject(pPlateform, pId, pPath)

    -- The id of the info is the id of the retroarch vpk corresponding of the system name
    self.id = self.computeId(pPlateform)
    self.filename = pFilename
    self.title = self.computeRomTitle(pFilename)
    self.region = self.computeRomRegion(pFilename)
    self.version = self.computeRomVersion(pFilename)
    
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

    
    --function self.computeCategory( pName, pPath )
        --local category = ""
--
        --return category
    --end

    return self
end
