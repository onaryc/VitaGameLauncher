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

-- view/widget model files
dofile(app0.."Widget.lua")
dofile(app0.."WFrame.lua")
dofile(app0.."WList.lua")
dofile(app0.."WImage.lua")
dofile(app0.."WButton.lua")
dofile(app0.."WProfile.lua")

dofile(app0.."wSystemInfo.lua")
dofile(app0.."wAppInfo.lua")
dofile(app0.."wBackground.lua")
dofile(app0.."wAppLaunch.lua")

-- controllers file
dofile(app0.."VGL/Controller/VGLAPIController.lua")
dofile(app0.."VGL/Controller/VGLFtpController.lua")
dofile(app0.."VGL/Controller/VGLGameController.lua")
dofile(app0.."VGL/Controller/VGLInputController.lua")
dofile(app0.."VGL/Controller/VGLProfileController.lua")
dofile(app0.."VGL/Controller/VGLViewController.lua")
dofile(app0.."Vita/Controller/VitaGameController.lua")
dofile(app0.."Vita/Controller/VitaInputController.lua")


--dofile(app0.."mmi.lua")

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

    -- profile data initialization
    screenWidth = 960
    screenHeight = 544
    imageDirectory = app0.."VGL/Resources/Images/"
    
    -- create main controllers
    --inputManager = InputManager()

    -- initialize controllers
    api.initialize()

    -- gather or compute all info needed on game/applications    
    api.refreshAppData()
    
    while true do
        api.update()
    end
    
    stopDebug()
end
