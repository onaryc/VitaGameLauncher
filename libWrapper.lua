function listDirectories ( pPath )
    local res = files.listdirs(pPath)

    return res
end

function splashScreen ()
    splash.gekihen()
end

function printScreen ( pString, pX, pY )
    if pString then
        screen.print(pX,pY,pString)
    else
        screen.print(pX,pY,"nil value")
    end
end

function printScreen2 ( pString, pX, pY, pSize, pColor )
    if pString then
        screen.print(pX,pY,pString, pSize, pColor)
    else
        screen.print(pX,pY,"nil value")
    end
end

function printAppTable ( pTable, pDebug )
    local nbCol = 1
    local xText = 10
    local yText = 30

    if pDebug == true then
        printScreen("Print Table : "..#appInfos.." items", 400, 10)
    end

    for key,value in pairs(appInfos) do
        printScreen("dir : "..value.id, xText,yText)
        yText += 20

        if yText > 544 then
            nbCol += 1
            xText = nbCol * 150
            yText = 30
        end
    end
end

function drawRectangle ( pX, pY, pWidth, pHeight, pColor )
    draw.rect(pX, pY, pWidth, pHeight, pColor)
end

function screenFlip ()
    screen.flip()
end

function loadpalette ()
    color.loadpalette()
end

-- battery
function batteryExists ()
    return batt.exists()
end

function batteryCharge ()
    local res = batt.lifepercent() / 100
    
    return res
end

function isBatteryLow ()
    return batt.low()
end

function isBatteryCharging ()
    return batt.charging()
end

-- files
function filesExists ( pFilename )
    local res = false 

    if pFilename then
        res = files.exists(pFilename)
    end
    
    return res
end

-- image
function imageLoad ( pFilename )
    local res = nil
    
    local test = filesExists(pFilename)
    if test == true then
        res = image.load(pFilename)
    end
        
    return res
end

function spriteLoad ( pFilename, pWidth, pHeight )
    local res = nil
    
    local test = filesExists(pFilename)
    if test == true then
        res = image.load(pFilename, pWidth, pHeight)
    end
        
    return res
end

function imageBlit ( pImage, pX, pY, pAlpha )
    if pImage != nil then
        if pAlpha != nil then
            pImage:blit(pX, pY, pAlpha)
        else
            pImage:blit(pX, pY)
        end 
    end
end

function imageBlitPart ( pImage, pX, pY, pXi, pXi, pWidth, pHeight )
    if pImage != nil then 
        pImage:blit(pX, pY, pXi, pXi, pWidth, pHeight)
    end
end

function spriteBlit ( pSprite, pX, pY, pAnim )
    if pSprite != nil then 
        pSprite:blitsprite(pX,pY,pAnim)
    end
end

function imageGetWidth ( pImage )
    res = 0
    
    if pImage != nil then 
        res = pImage:getw()
    end

    return res
end

function imageGetHeight ( pImage )
    res = 0
    
    if pImage != nil then 
        res = pImage:geth()
    end

    return res
end
