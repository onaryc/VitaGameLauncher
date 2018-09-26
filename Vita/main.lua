-- load the wrapper
dofile(app0.."Vita/Tools/libWrapperOne.lua")

-- tool files
dofile(app0.."VGL/Tools/slaxml.lua")
dofile(app0.."VGL/Tools/VGLTools.lua")
dofile(app0.."VGL/Tools/VGLSFOTools.lua")

-- model files
dofile(app0.."VGL/Model/VGLObject.lua")
dofile(app0.."VGL/Model/VGLGameObject.lua")
dofile(app0.."VGL/Model/VGLRetroGameObject.lua")
dofile(app0.."Vita/Model/VitaGameObject.lua")

-- controllers file
dofile(app0.."VGL/Controller/VGLAPIController.lua")
-- create the api controller. Now the others controller can registerd themselves to the api controller
api = VGLAPIController()

dofile(app0.."VGL/Controller/VGLFtpController.lua")
dofile(app0.."VGL/Controller/VGLGameController.lua")
dofile(app0.."VGL/Controller/VGLInputController.lua")
dofile(app0.."VGL/Controller/VGLProfileController.lua")
dofile(app0.."Vita/Controller/VitaGameController.lua")
dofile(app0.."Vita/Controller/VitaInputController.lua")

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
    --ftpController = FtpController()
    --gameController = GameController()
    --profileController = ProfileController(profileFolder)
    --inputManager = InputManager()

    -- initialize controllers
    --ftpController.initialize()
    --profileController.initialize()

    api.initialize()

    -- gather or compute all info needed on game/applications    
    api.refreshAppData()
    
    mmi = VitaMmi(960, 544)
    
    while true do
        ftpController.update()
        inputManager.update()
        mmi.update()
    end
    
    stopDebug()
end
