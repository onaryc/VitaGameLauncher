function ButtonController()
    local self = {}

    self.currentAppIndex = -1
    self.debug = false
    --function self.initialization ()
    --
    --end

    function self.update ( pAppInfos, pCurrentAppIndex , pDebug )
        local currentAppIndex = pCurrentAppIndex
        local debugLevel = pDebug
        
        buttons.read()

        if buttons.cross then
            printScreen("Launching game : "..pAppInfos[currentAppIndex].id, 400, 10)
            game.launch(pAppInfos[currentAppIndex].id)
        end

        if buttons.up then
            currentAppIndex -= 1
            if currentAppIndex < 1 then
                currentAppIndex = 1
            end
        end

        if buttons.down then
            currentAppIndex += 1
            if currentAppIndex > #pAppInfos then
                currentAppIndex -= 1
            end
        end
        
        if buttons.released.start then
            os.exit()
        end

        if buttons.held.select then
            debugLevel = true
        end

        if buttons.released.select then
            debugLevel = false
        end

        self.currentAppIndex = currentAppIndex
        self.debug = debugLevel
        --return currentAppIndex, tmpDebug 
    end

    -- return the instance
    return self
end
