function WFrame ( pId, pParent, pX, pY, pWidth, pHeight, pDebugColor )
    local self = Widget(pId, pX, pY, pWidth, pHeight, pDebugColor)

    -- public variables
    self.parent = pParent
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
