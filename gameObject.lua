function GameObject( pPlateform, pId, pPath, pTitle, pRegion, pVersion, pGenre )
    local self = {}

    -- public variables
    self.plateform = pPlateform
    self.id = pId
    self.path = pPath
    self.title = pTitle
    self.region = pRegion
    self.version = pVersion
    self.genre = pGenre

    if self.plateform == "PSVita" then
        local bkFile = self.path.."/sce_sys/pic0.png"
                    
        self.appBgImage = imageLoad(bkFile)
    else
        self.appBgImage = nil
    end

    self.plateformBgImage = nil
    self.genreBgImage = nil
    
    -- return the instance
    return self
end
