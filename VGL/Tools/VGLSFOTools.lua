function SfoInformation ( )
    local self = {}

    --local sfoFilename = pFilename
    --local id = pId
    --self.sfoInfos = {}

    function self.analyze ( pFilename )
		printDebug("analyze "..pFilename.."\n")
        sfoInfos = {}

        --printScreen ("file "..pFilename, 1, 20)
        
        local test = filesExists(pFilename)
        if test == true then
            local fd = assert(io.open(pFilename, "rb")) -- open param.sfo in binary format
            local all = fd:read("*a")
            sfoContent = {all:byte(1, #all)} -- conversion automatique des valeurs en decimal 
            fd:close()

            local keyTableOffset = self.getValue (sfoContent,8,4) -- 0x08, offset start of the param name
            local dataTableOffset = self.getValue (sfoContent,12,4) -- 0x0C, offset start of the param value
            local nbParam = self.getValue (sfoContent,16,4) -- 0x10, offset start of the param nb

            local offsetParamTable = 20 -- 0x14
            for i=1,nbParam do
                -- get the param name offset
                local paramNameOffset = self.getValue (sfoContent,(i-1)*16 + offsetParamTable,2)

                -- get the param format
                local paramFormat = self.getValue (sfoContent,(i-1)*16 + offsetParamTable+2,2)

                -- get the param length
                local paramLength =self.getValue (sfoContent,(i-1)*16 + offsetParamTable+4,2)
                
                -- get the param max length
                local paramMaxLength = self.getValue (sfoContent,(i-1)*16 + offsetParamTable+8,2)
                
                -- get the param value offset
                local paramValOffset = self.getValue (sfoContent,(i-1)*16 + offsetParamTable+12,2)
                
                -- get the param name
                local paramName = self.getParamName(sfoContent,keyTableOffset+paramNameOffset)

				printDebug("paramname "..paramName.."\n")
                if paramName == "APP_VER" or
                    paramName == "PARENTAL_LEVEL" or
                    paramName == "PSP2_SYSTEM_VER" or
                    paramName == "PUBTOOLINFO" or
                    paramName == "SAVEDATA_MAX_SIZE" or
                    paramName == "TITLE" or
                    paramName == "TITLE_ID" or
                    string.match(paramName, '^STITLE.*') != nil
                then
                    -- get the param value
                    local paramValue = self.getString(sfoContent,dataTableOffset+paramValOffset,paramLength)
                    local paramValue = self.getString(sfoContent,dataTableOffset+paramValOffset,paramMaxLength)

                    sfoInfos[paramName] = paramValue
                end
            end
        end

        return sfoInfos
    end

    function self.getParamName ( pTable, pOffset )
        paramName = ""

        offset = pOffset + 1
        i = 1
        tmp = pTable[offset]
        while tmp != 0 do
            paramName = paramName..string.char(tonumber(tmp))

            tmp = pTable[offset+i]
            i = i + 1
        end
         
        return paramName
    end
    
    function self.getString ( pTable, pOffset, pLength )
        str = ""
        
        for i=1,pLength do
            tmp = pTable[pOffset+i]
            tmp = string.char(tonumber(tmp))
            if tmp then
                str = str..tmp
            end
        end
        
        return str
    end

    function self.getValue ( pTable, pOffset, pLength )
        val = ""

        offset = pOffset + 1

        for i=1,pLength do
            tmp = pTable[offset+pLength-i]
            tmp = string.format('%02x',tmp) -- value automatically converted to dec, retransform it into hex
            if tmp then
                val = val..tmp
            end
        end

        if val != "" then
            val = tonumber(val,16)
        end

        return val
    end

    return self
end

