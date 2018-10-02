function VGLWidget ( pArg )
    local self = VGLObject ()

    local functionName = debug.getinfo(1, "n").name
    
    -- check mandatory options
    local errorMessage = functionName.." : "
    if type(pArg.x) ~= "number" then
        error(errorMessage.."x attribute")
    elseif type(pArg.y) ~= "number" then
        error(errorMessage.."y attribute")
    elseif type(pArg.width) ~= "number" then
        error(errorMessage.."width attribute")
    elseif type(pArg.height) ~= "number" then
        error(errorMessage.."height attribute")
    end
      
    -- public variables
    self.id = pArg.id
    self.x = pArg.x
    self.y = pArg.y
    self.w = pArg.width
    self.h = pArg.height
    self.debugColor = pArg.debugColor

    function self.update( )
        if api.getDebug() == true then
            drawRectangle(self.x, self.y, self.w, self.h, self.debugColor)
        end
    end
    
    -- return the instance
    return self
end
