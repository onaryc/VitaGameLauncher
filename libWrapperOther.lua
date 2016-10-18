function listDirectories ( pPath )
    for dir in io.popen([[dir pPath /b /ad]]):lines() do
        print(dir)
    end

    return pPath
end

function splashScreen ()
    print("Splash")
end

function printScreen ( pString, pX, pY )
    print(pString)
end

function printTable ( pTable )
    local xText = 10
    local yText = 30

    for key,value in pairs(appInfos) do
        print("dir : "..value)
        yText = yText + 20
    end
end
