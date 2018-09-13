function WFrame ( pArg )
    local self = Widget(pArg)

    -- public variables
    self.parent = pArg.frame
    self.children = {}
    
    function self.updateParent()
        if self.parent != nil then
            insertTable(self.parent.children, self)
        end
        
    end

    local baseUpdate = self.update -- in order to reuse parent function
    function self.update( )
        baseUpdate()
        for key,value in pairs(self.children) do
            value.update()
        end 
    end

    -- update the parent
    self.updateParent()
    
    -- return the instance
    return self
end
