function VGLIniController( pArg )
    local self = VGLInstanceController(pArg)

    -- public variables
    self.iniFile = pArg.iniFile
    
    function self.initializeIniFile ()

    end
    
    function self.writeIniFile ()
		for key,value in pairs(self.iniFile.sections) do
            
        end
    end

    function self.readIniFile ()
    end
    
    -- return the instance
    return self
end

vglIniController = VGLIniController()
api.addController(vglIniController)

