function main ( )
    ftp.init()
    
    infoController = InfoController()

    if not filesExists("ux0:/data/VGLauncher") then
        files.mkdir("ux0:/data/VGLauncher")
    end
     
    -- gather or compute all info needed on game/applications    
    infoController.refreshInfo()
    
    local appInfos = infoController.appInfos
    local categories = infoController.categories
    local plateforms = infoController.plateforms

    mmi = Mmi(960, 544, appInfos, categories, plateforms)
    
    if appInfos then
        -- 
        while true do             
            mmi.update()
        end
    end
end
