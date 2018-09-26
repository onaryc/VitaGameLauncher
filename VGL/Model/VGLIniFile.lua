function VGLIniFile( pPath, pSections )
    local self = VGLObject()

    -- public variables
    self.path = pPath
    self.sections = pSections
        
    -- return the instance
    return self
end
