-- tool files
dofile(app0.."slaxml.lua")
dofile(app0.."tools.lua")
dofile(app0.."sfoTools.lua")

-- model files
dofile(app0.."gameObject.lua")
dofile(app0.."gameVitaObject.lua")
dofile(app0.."gameRomObject.lua")

-- controllers file
--dofile(app0.."buttonController.lua")
dofile(app0.."gameController.lua")
dofile(app0.."ftpController.lua")

dofile(app0.."inputManager.lua")

-- view/widget files
dofile(app0.."wSystemInfo.lua")
dofile(app0.."wAppInfo.lua")
dofile(app0.."wBackground.lua")
dofile(app0.."wAppList.lua")
dofile(app0.."wAppLaunch.lua")
dofile(app0.."mmi.lua")

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
