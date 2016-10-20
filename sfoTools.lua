function SfoInformation ( )
    local self = {}

    --local sfoFilename = pFilename
    --local id = pId
    self.sfoInfos = {}

    function self.analyze ( pFilename )
        local test = filesExists(pFilename)
        if test == true then
            local fd = assert(io.open(pFilename, "rb")) -- open param.sfo in binary format
            --local fd = assert(io.open(pFilename, "r"))
            local all = fd:read("*a")
            a = {all:byte(1, #all)} -- en decimal
            fd:close()
            -- header
            --local hPsf = fd:read(4) -- fd:read get a string
            --local hPsf = tonumber(fd:read(4),16) -- fd:read get a string
            --hPsf = string.format('%x', hPsf)
            --local hVersion = fd:read(4)

            --fd:seek("set",8)
            --local keyTableStartOffset = fd:read(4)
            --local dataTableStartOffset = fd:read(4)
            --local indexTableEntries = fd:read(4)
--
            --keyTableStartOffset = tonumber(keyTableStartOffset,10)
            --fd:seek("set",keyTableStartOffset)
            --local tmp = fd:read(8)
            -- next part is parameter/value description
            --local nbParameter = tonumber(indexTableEntries,10)



            --local tmpInfo = {header = {psf = hPsf, version = hVersion, keyOffset = keyTableStartOffset, dataOffset = dataTableStartOffset, entries = indexTableEntries}}
--
            --table.insert(sfoInfos, tmpInfo)

            --a1 = tonumber(a[1],10)
            --a2 = tonumber(a[2],10)
            --a3 = tonumber(a[3],10)
            --a4 = tonumber(a[4],10)
            local a1 = string.format('%02x',a[1])
            local a2 = string.format('%02x',a[2])
            local a3 = string.format('%02x',a[3])
            local a4 = string.format('%02x',a[4])
            printScreen ("file "..pFilename, 1, 80)

            a2 = tonumber(a2)
            a3 = tonumber(a3)
            printScreen (a1, 1, 100)
            printScreen (a2, 1, 120)
            printScreen (tostring(a3), 1, 140)
            printScreen (a4, 1, 160)

            --local tmpString = string.char(tonumber(a1),tonumber(a2),tonumber(a3),tonumber(a4))
            local tmpString = string.char(a[1],a[2],a[3],a[4])
            printScreen ("res "..tmpString, 1, 180)
            
            --printScreen ("psf "..tostring(hPsf), 1, 100)
            --printScreen ("ver "..tostring(hVersion), 1, 120)
            --printScreen ("key offset "..keyTableStartOffset, 1, 140)
            --printScreen ("dataoffset "..dataTableStartOffset, 1, 160)
            --printScreen ("entries "..indexTableEntries, 1, 180)
            --printScreen ("nb entries "..tostring(nbParameter), 1, 200)

            screenFlip()

            buttons.read()
            buttons.waitforkey()
        end 
    end

    return self
end

