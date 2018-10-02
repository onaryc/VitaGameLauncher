function splashScreen ()
    
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
    --~ return batt.exists()
    return true
end

function batteryCharge ()
    local res =  System.getBatteryPercentage() / 100
    
    return res
end

function isBatteryLow ()
	local res = false
	 
	if batteryCharge () < 0.1 then
		res = true
	end
	
    return res
end

function isBatteryCharging ()
    return System.isBatteryCharging()
end

-- files
function listDirectories ( pPath )
    local res = System.listDirectory(pPath)

    return res
end

function filesExists ( pFilename )
    local res = false 

    if pFilename then
        res = System.doesFileExist(pFilename)
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
