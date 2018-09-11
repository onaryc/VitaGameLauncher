
function WProfile ( pName, pCommands )
    local self = {}

    -- public variables
    self.name = pName
    --self.commands = {}
    self.commands = pCommands
    

    function self.eval( )
        for key,value in pairs(self.commands) do
            for key1,value1 in pairs(value) do
                printDebug(key1.." = "..value1.." ")
            end
                printDebug("\n")
            --printDebug("key "..key.."value "..value.."\n")
            
            --local res = load(value)()
            
        end
    end
    
    --function self.serialize( )
        
    --end
    
    --function self.deserialize( )
        
    --end
    
    -- return the instance
    return self
end
