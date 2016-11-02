function main ( pDebug )
    local mmi = Mmi(960, 544)
    local infoController = InfoController()
    local buttonController = ButtonController()

    if not filesExists("ux0:/data/VGLauncher") then
        files.mkdir("ux0:/data/VGLauncher")
    end
     
    -- gather or compute all info needed on game/applications    
    infoController.refreshInfo()
    
    local appInfos = infoController.appInfos
    local categories = infoController.categories
    local plateforms = infoController.plateforms

    buttonController.initialize(categories, plateforms)
    
    if appInfos then -- the emptiness of appInfos does not appear to be correctly tested
        local currentAppIndex = 1
        local currentCategory = "All"
        local debugLevel = pDebug
        
        while true do 
            -- read buttons state
            buttonController.update(appInfos, debugLevel)

            currentAppIndex = buttonController.currentAppIndex
            currentCategory = buttonController.currentCategory
            currentPlateform = buttonController.currentPlateform
            debugLevel = buttonController.debug
            
            -- display widgets
            mmi.update(appInfos, currentAppIndex, currentPlateform, currentCategory, debugLevel)
        end
    end
end
