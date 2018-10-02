function VGLIniFile( pArg )
    local self = VGLObject()

    -- public variables
    self.path = pArg.path
    self.sections = pArg.sections
        
    -- return the instance
    return self
end
