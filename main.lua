-- tool files
dofile(app0.."slaxml.lua")
dofile(app0.."tools.lua")
dofile(app0.."sfoTools.lua")

-- model files
dofile(app0.."VGLObject.lua")
dofile(app0.."gameObject.lua")
dofile(app0.."gameVitaObject.lua")
dofile(app0.."gameRomObject.lua")

-- controllers file
dofile(app0.."gameController.lua")
dofile(app0.."ftpController.lua")
dofile(app0.."inputManager.lua")
dofile(app0.."ProfileController.lua")

-- view/widget middleware
dofile(app0.."Widget.lua")
dofile(app0.."WFrame.lua")
dofile(app0.."WList.lua")
dofile(app0.."WImage.lua")
dofile(app0.."WButton.lua")
dofile(app0.."WProfile.lua")

-- view/widget files
dofile(app0.."wSystemInfo.lua")
dofile(app0.."wAppInfo.lua")
dofile(app0.."wBackground.lua")
dofile(app0.."WList.lua")
dofile(app0.."wAppLaunch.lua")
dofile(app0.."mmi.lua")

function main ( )
    --~ splashScreen()
	initDebug()

    -- create data folder if they does not exists
    dataFolder = "ux0:/data/VGLauncher"
    if not filesExists(dataFolder) then
        files.mkdir(dataFolder)
    end
    
    profileFolder = dataFolder.."/Profiles"
    if not filesExists(profileFolder) then
        files.mkdir(profileFolder)
    end
    
    -- create main controllers
    ftpController = FtpController()
    gameController = GameController()
    profileController = ProfileController(profileFolder)
    inputManager = InputManager()

    -- initialize controllers
    ftpController.initialize()
    profileController.initialize()

    -- gather or compute all info needed on game/applications    
    gameController.refreshInfo()
    
    local appInfos = gameController.appInfos
    local categories = gameController.categories
    local plateforms = gameController.plateforms

    mmi = Mmi(960, 544, categories, plateforms)
    
    if appInfos then
         
        while true do
            ftpController.update()
            inputManager.update(appInfos)
            mmi.update()
        end
    end
    
    stopDebug()
end
