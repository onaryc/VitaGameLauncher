-- display app information on the screen : version, region, genre, ...
function WAppInfo( pScreenWidth, pScreenHeight, pX, pY, pHeight )
    local self = {}

    local screenWidth = pScreenWidth
    local screenHeight = pScreenHeight
    local width = screenWidth -1
    local height = pHeight
    
    local xULP = pX
    local yULP = pY

    local xPart = {}
    local yPart = {}
    local nbPart = 4
    local partWidth = width / nbPart
    
    function self.initialization ()
        --part coordaintes
        for i=1,nbPart do
            xPart[i] = (i -1) * partWidth
            yPart[i] = yULP
        end
    end
    
    function self.update( pAppInfos, pCurrentAppIndex, pCurrentPlateform, pCurrentCategory, pDebug )        
        if pDebug == true then
            --printScreen("Game Selected : "..pAppInfos[pCurrentAppIndex].id, xULP, yULP)
            --printScreen("Game Path : "..pAppInfos[pCurrentAppIndex].path, xULP, yULP + 20)

            draw.fillrect(xULP, yULP, width, height, color.black)
            for i=1,nbPart do
                drawRectangle(xPart[i], yPart[i], partWidth, height, color.blue)
            end

            printScreen(pAppInfos[pCurrentPlateform][pCurrentCategory][pCurrentAppIndex].plateform, xPart[1], yPart[1])
            printScreen(pAppInfos[pCurrentPlateform][pCurrentCategory][pCurrentAppIndex].id, xPart[1], yPart[1] + 20)

            printScreen(pAppInfos[pCurrentPlateform][pCurrentCategory][pCurrentAppIndex].region, xPart[2], yPart[2])
            printScreen(pAppInfos[pCurrentPlateform][pCurrentCategory][pCurrentAppIndex].title, xPart[2], yPart[2] + 20)

            printScreen(pAppInfos[pCurrentPlateform][pCurrentCategory][pCurrentAppIndex].category, xPart[3], yPart[3])
            printScreen(pCurrentPlateform, xPart[3], yPart[3]+20)
            printScreen(pAppInfos[pCurrentPlateform][pCurrentCategory][pCurrentAppIndex].version, xPart[4], yPart[4])
            printScreen(pCurrentCategory, xPart[4], yPart[4]+20)
        end
    end

    self.initialization()
    
    -- return the instance
    return self
end
