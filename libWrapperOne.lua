function splashScreen ()
    splash.gekihen()
end

-- games
function listGames ()
	return game.list()
end

-- debug info
function printScreen ( pString, pX, pY )
    if pString == nil then
        pString = "nil value"
    end
    
    screen.print(pX,pY,pString) 
end

function printScreen2 ( pString, pX, pY, pSize, pColor )
    if pString == nil then
        pString = "nil value"
    end
    
    screen.print(pX,pY,pString, pSize, pColor)
end

-- should not be here
function printAppTable ( pTable, pDebug )
    local nbCol = 1
    local xText = 10
    local yText = 30

    if pDebug == true then
        printScreen("Print Table : "..#pTable.." items", 400, 10)
    end

    for key,value in pairs(pTable) do
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
function listDirectories ( pPath )
    local res = files.listdirs(pPath)

    return res
end

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

function imageResize ( pImage, pWidth, pHeight )
    --local resizedImage = nil
    
    if pImage != nil then
        resizedImage = image.resize(pImage, pWidth, pHeight) 
    end

    --return resizedImage
end

function imageScale ( pImage, pPercent )
    --local scaledImage = nil
    
    if pImage != nil then
        scaledImage = image.scale(pImage, pPercent) 
    end

    --return scaledImage
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

function launchGame ( pId )
    game.launch(pId)
end

-- debug console
function initDebug ()
	console.init()
end

function printDebug ( pText )
	console.print(pText)
end

function renderDebug ()
	console.render()
end

function clearDebug ()
	console.clear(color.black)
end

function stateDebug ()
	return console.state()
end

function stopDebug ()
	console.term()
end

-- ftp
function ftpInit ()
    ftp.init()
end

function ftpTerm ()
    ftp.term()
end

function toColor ( pColor )
	local color = "color."..pColor
	
	return color
end
