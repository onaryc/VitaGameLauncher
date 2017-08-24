function GameVitaObject( pId, pPath, pTitle, pRegion, pVersion, pCategory, pDate, pDescription, pDumper )
    local self = GameObject("PSVita", pId, pPath, pTitle, pRegion, pVersion, pCategory, pDate, pDescription)

    -- public
    
    -- specific vita
    self.dumperVersion = pDumper

    function self.initialization ()
        --self.initialization2()

        if self.region == nil then
            self.computeVitaRegion()
        end

        if self.title == nil and self.version == nil then 
            self.computeVitaInfo()
        end

        if self.dumperVersion == nil then
            self.computeVitaDumper()
        end

        self.initialization2()
    end
    
    function self.computeVitaRegion ( )
        local region = ""

        --string.find (s, pattern [, init [, plain]])
        
        --local testFilter = string.match(pId, '.*PCS(E)|(A).*')
        local testFilter = string.match(self.id, '.*PCSE.*')
        local testFilter2 = string.match(self.id, '.*PCSA.*')
        if testFilter != nil or testFilter2 != nil then
            region = "usa"
        else
            local testFilter = string.match(self.id, '.*PCSB.*')
            local testFilter2 = string.match(self.id, '.*PCSF.*')
            if testFilter != nil or testFilter2 != nil then
                region = "europe"
            else
                testFilter = string.match(self.id, '.*PCSG.*')
                if testFilter != nil then
                    region = "japan"
                else
                    testFilter = string.match(self.id, '.*PCSH.*')
                    if testFilter != nil then
                        region = "asia"
                    else
                        region = "unk"
                    end
                end
            end
        end
        
        self.region = region
    end

    function self.computeVitaInfo ()
        local sfoInformation = SfoInformation()
        --~ local paramSfoFile = self.path.."/sce_sys/param.sfo"

        --res = sfoInformation.analyze(string.format("%s/sce_sys/param.sfo",self.path))
        res = game.info(string.format("%s/sce_sys/param.sfo",self.path))
        local title = res.TITLE
        
        if title != nil then
			-- remove uppercase (exept for word beginning) and useless char ;)
			title = string.gsub (title, "™", "")
			title = string.gsub (title, "®", "")
			title = string.gsub (title, "³", " 3")
			
			self.title = title
		end
		
        --title = string.gsub (title, "%a(%u)", string.lower("%1"))
        --title = string.lower(title)

        -- get app version
        self.version = res.APP_VER        
    end

    --function self.getVitaCategory ( pName )
        --local category = ""
--
        --return category
    --end

    function self.computeVitaDumper( )
		self.dumperVersion = nil
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
