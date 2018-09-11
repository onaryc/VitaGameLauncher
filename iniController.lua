function iniController( pIniFile )
    local self = {}

    -- public variables
    self.iniFile = pIniFile
    
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
