function main ( )
    --~ splashScreen()
	initDebug()
	
    -- create main controllers
    ftpController = FtpController()
    gameController = GameController()

    -- initialize controllers
    ftpController.initialize()

    if not filesExists("ux0:/data/VGLauncher") then
        files.mkdir("ux0:/data/VGLauncher")
    end

    -- gather or compute all info needed on game/applications    
    gameController.refreshInfo()
    
    local appInfos = gameController.appInfos
    local categories = gameController.categories
    local plateforms = gameController.plateforms

    mmi = Mmi(960, 544, appInfos, categories, plateforms)
    
    if appInfos then
        -- 
        while true do
            ftpController.update()
            mmi.update()
        end
    end
    
    stopDebug()
end
