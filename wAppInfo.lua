-- display app information on the screen : version, region, genre, ...
function WAppInfo( pScreenWidth, pScreenHeight )
    local self = {}

    local screenWidth = pScreenWidth
    local screenHeight = pScreenHeight
    local width = screenWidth -1
    local height = 60
    
    local xULP = 1
    local yULP = screenHeight - height

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
    
    function self.update( pAppInfos, pCurrentAppIndex, pDebug )        
        if pDebug == true then
            --printScreen("Game Selected : "..pAppInfos[pCurrentAppIndex].id, xULP, yULP)
            --printScreen("Game Path : "..pAppInfos[pCurrentAppIndex].path, xULP, yULP + 20)

            draw.fillrect(xULP, yULP, width, height, color.black)
            for i=1,nbPart do
                drawRectangle(xPart[i], yPart[i], partWidth, height, color.blue)
            end

            printScreen(pAppInfos[pCurrentAppIndex].plateform, xPart[1], yPart[1])
            printScreen(pAppInfos[pCurrentAppIndex].id, xPart[2], yPart[2])
            printScreen(pAppInfos[pCurrentAppIndex].region, xPart[3], yPart[3])
        end
    end

    self.initialization()
    
    -- return the instance
    return self
end
