-- display app information on the screen : version, region, genre, ...
function WAppInfo( pX, pY, pWidth, pHeight )
    local self = {}

    local width = pWidth
    local height = pHeight
    
    local xULP = pX
    local yULP = pY

    local xPart = {}
    local yPart = {}
    local nbPart = 4
    local partWidth = width / nbPart
    
    function self.initialization ()
        --part coordaintes
        xPart[1] = xULP
        yPart[1] = yULP
        for i=2,nbPart do
            xPart[i] = (i - 1) * partWidth
            yPart[i] = yULP
        end
    end
    
    function self.update( )
        local appInfos = infoController.appInfos 

        local currentAppIndex = inputManager.currentAppIndex 
        local currentCategory = inputManager.currentCategory 
        local currentPlateform = inputManager.currentPlateform
        
        local debugLevel = inputManager.debug

        if appInfos[currentPlateform][currentCategory] then
            if debugLevel == true then
                --printScreen("Game Selected : "..pAppInfos[pCurrentAppIndex].id, xULP, yULP)
                --printScreen("Game Path : "..pAppInfos[pCurrentAppIndex].path, xULP, yULP + 20)

                draw.fillrect(xULP, yULP, width, height, color.black)
                for i=1,nbPart do
                    drawRectangle(xPart[i], yPart[i], partWidth, height, color.blue)
                end

                local appObject = appInfos[currentPlateform][currentCategory][currentAppIndex]

                printScreen(appObject.plateform, xPart[1], yPart[1])
                printScreen(appObject.id, xPart[1], yPart[1] + 20)

                printScreen(appObject.region, xPart[2], yPart[2])
                printScreen(appObject.title, xPart[2], yPart[2] + 20)

                printScreen(appObject.category, xPart[3], yPart[3])
                printScreen(currentPlateform, xPart[3], yPart[3]+20)
                printScreen(appObject.version, xPart[4], yPart[4])
                printScreen(currentCategory, xPart[4], yPart[4]+20)
            end
        end
    end

    self.initialization()
    
    -- return the instance
    return self
end
