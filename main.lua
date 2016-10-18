function main ( pDebug )
    local mmi = Mmi(960, 544)
    local infoController = InfoController()
    local buttonController = ButtonController()

    -- gather or compute all info needed on game/applications    
    infoController.refreshInfo()
    local appInfos = infoController.appInfos

    if appInfos != {} then
        local currentAppIndex = 1
        local debugLevel = pDebug
        while true do 
            -- read buttons state
            --currentAppIndex = buttonController.update(appInfos, currentAppIndex, pDebug)
            buttonController.update(appInfos, currentAppIndex, debugLevel)

            currentAppIndex = buttonController.currentAppIndex
            debugLevel = buttonController.debug
            
            -- display widgets
            mmi.update(appInfos, currentAppIndex, debugLevel)
        end
    end
end
