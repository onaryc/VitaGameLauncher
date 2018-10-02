function VGLObject ( pArg )
    local self = {}

    -- public variables
    
    --function self.getAttributes()
        --for key,value in pairs(self) do
            
        --end 
    --end

    function self.get( pName )
        return loadstring("self."..pName)
    end
    
    function self.set( pName, pValue )
        loadstring("self."..pName.."="..pValue)
    end

    function self.debugInfo()
        --for key,value in pairs(self) do
            
        --end 
    end
    
    -- return the instance
    return self
end
