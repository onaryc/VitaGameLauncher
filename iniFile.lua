function iniFile( pPath, pSections )
    local self = {}

    -- public variables
    self.path = pPath
    self.sections = pSections
        
    -- return the instance
    return self
end
