function GameVitaObject( pId, pPath, pTitle, pRegion, pVersion, pCategory, pDate, pDescription, pDumper )
    local self = GameObject("PSVita", pId, pPath, pTitle, pRegion, pVersion, pCategory, pDate, pDescription)

    -- public
    
    -- specific vita
    self.dumperVersion = pDumper

    function self.initialization ()
        --self.initialization2()

        if self.region == nil then
            self.region = self.computeVitaRegion(pId)
        end

        if self.title == nil and self.version == nil then 
            self.title, self.version = self.getVitaInfo(pPath)
        end

        if self.dumperVersion == nil then
            self.dumperVersion = self.computeVitaDumper(pPath)
        end

        self.initialization2()
    end
    
    function self.computeVitaRegion ( pId )
        local region = ""

        --string.find (s, pattern [, init [, plain]])
        
        --local testFilter = string.match(pId, '.*PCS(E)|(A).*')
        local testFilter = string.match(pId, '.*PCSE.*')
        local testFilter2 = string.match(pId, '.*PCSA.*')
        if testFilter != nil or testFilter2 != nil then
            region = "usa"
        else
            local testFilter = string.match(pId, '.*PCSB.*')
            local testFilter2 = string.match(pId, '.*PCSF.*')
            if testFilter != nil or testFilter2 != nil then
                region = "europe"
            else
                testFilter = string.match(pId, '.*PCSG.*')
                if testFilter != nil then
                    region = "japan"
                else
                    testFilter = string.match(pId, '.*PCSH.*')
                    if testFilter != nil then
                        region = "asia"
                    else
                        region = "unk"
                    end
                end
            end
        end

        return region
    end

    function self.getVitaInfo ( pPath )
        local title, version  = ""

        local sfoInformation = SfoInformation()
        local paramSfoFile = self.path.."/sce_sys/param.sfo"

        res = sfoInformation.analyze(paramSfoFile)
        title = res.TITLE
        
        -- remove uppercase (exept for word beginning) and useless char ;)
        title = string.gsub (title, "™", "")
        title = string.gsub (title, "®", "")
        title = string.gsub (title, "³", " 3")

        --title = string.gsub (title, "%a(%u)", string.lower("%1"))
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

    function self.computeVitaDumper( pPath )

    end
    
    function self.serialize ( pType )
        xml = "<GameVitaObject"

        xml = xml..self.serialize2(pType)
        
        if self.dumperVersion then
            xml = xml.." dumperVersion="..self.dumperVersion
        end

        xml = xml.." />"

        return xml
    end

    self.initialization()

    return self
end
