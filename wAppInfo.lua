-- display app information on the screen : version, region, genre, ...
function WAppInfo( pId, pParent, pX, pY, pWidth, pHeight, pDebugColor )
    local self = WFrame(pId, pParent, pX, pY, pWidth, pHeight, pDebugColor)

    local xPart = {}
    local yPart = {}
    local nbPart = 4
    local partWidth = self.w / nbPart
    
    function self.initialization ()
        --part coordaintes
        xPart[1] = self.x
        yPart[1] = self.y
        for i=2,nbPart do
            xPart[i] = (i - 1) * partWidth
            yPart[i] = self.y
        end
    end

    local baseUpdate = self.update -- in order to reuse parent function
    function self.update( )
        local appInfos = gameController.appInfos 

        local currentCategory = gameController.currentCategory 
        local currentPlateform = gameController.currentPlateform

        local appObject = gameController.getCurrentApp()
        if appObject then
            if mmi.debug == true then
                --printScreen("Game Selected : "..pAppInfos[pCurrentAppIndex].id, self.x, self.y)
                --printScreen("Game Path : "..pAppInfos[pCurrentAppIndex].path, self.x, self.y + 20)

                draw.fillrect(self.x, self.y, self.w, self.h, color.black)
                for i=1,nbPart do
                    drawRectangle(xPart[i], yPart[i], partWidth, self.h, self.debugColor)
                end

                printScreen(appObject.plateform, xPart[1], yPart[1])
                printScreen(appObject.id, xPart[1], yPart[1] + 20)

                printScreen(appObject.region, xPart[2], yPart[2])
                printScreen(appObject.title, xPart[2], yPart[2] + 20)

                printScreen(appObject.category, xPart[3], yPart[3])
                printScreen("Plat "..currentPlateform, xPart[3], yPart[3]+20)
                printScreen(appObject.version, xPart[4], yPart[4])
                printScreen("Cat "..currentCategory, xPart[4], yPart[4]+20)
            end
            
            local xShift = 0
            local yShift = self.h / 2
            
            -- display plateform icon
            local plateformIcon = mmi.getPlateformeIcon(appObject.plateform)
            imageBlit(plateformIcon, xPart[1] + xShift, yPart[1] + yShift)
            xShift = xShift + 40

            -- display region icon
            local regionIcon = mmi.getRegionIcon(appObject.region)
            imageBlit(regionIcon, xPart[1] + xShift, yPart[1] + yShift)
            xShift = xShift + 40
            
            -- display category icon
            local categoryIcon = mmi.getCategoryIcon(appObject.category)
            imageBlit(categoryIcon, xPart[1] + xShift, yPart[1] + yShift)
            xShift = xShift + 40
            
            -- display the number player if available

            -- display the version
        end
    end

    self.initialization()
    
    -- return the instance
    return self
end
