-- this controller is the "supercontroller", it contains all controllers's api
-- and the pointer to the controller themselves : each of the has to register
-- itself to be taken into account
function VGLAPIController(pArg)
    local self = VGLController(pArg)

    self.controllers = {}

    function self.initialize()
        -- initialize all the controllers
        for key,value in pairs(self.controllers) do
            value.initialize()
        end
    end
    
    -- each controller's api has to be registerd through this function
    function self.register( pFunction, pName )

    end

    function self.addController( pId )
        insertTable(self.controllers, pId)
    end
    
    -- return the instance
    return self
end

-- create the api controller. Now the others controller can registerd themselves to the api controller
api = VGLAPIController()
