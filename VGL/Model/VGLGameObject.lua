function VGLGameObject( pArg )
    local self = VGLObject ( pArg )

    -- public variables
    self.plateform = pArg.plateform
    self.id = pArg.id
    self.path = pArg.path
    self.title = pArg.title
    self.region = pArg.region
    self.version = pArg.version
    self.date = pArg.date
    self.description = pArg.description
    self.category = pArg.category
    self.nbPlayer = 1

    -- background image (use by wBackground)
    self.appBgImage = nil

    -- startup image (use by WList)
    self.startupImage = nil

    function self.loadData ()
        self.appBgImage = self.computeAppBgImage()

        self.startupImage = self.computeAppStartupImage()
    end

    function self.freeData ()
        self.appBgImage = nil

        self.startupImage = nil
    end

    function self.computeAppBgImage ( )
        local bgImage = nil

        local bgImageFile = ""

        if self.plateform == "PSVita" then
            bgImageFile = "ur0:appmeta/"..self.id.."/pic0.png"
        else
            if self.title and self.plateform then
                bgImageFile = app0.."images/"..self.plateform.."/"..self.title..".png"
            end
        end
        
        bgImage = imageLoad(bgImageFile)
        --bgImage = game.bg0("ux0:/app/"..self.id)

        return bgImage
    end
    
    function self.computeAppStartupImage ( )
        local startUpImage = nil

        local startUpImageFile = nil
        
        if self.plateform == "PSVita" then
            startUpImageFile = "ur0:appmeta/"..self.id.."/icon0.png"
        else
            if self.title and self.plateform then
                startUpImageFile = app0.."images/"..self.plateform.."/"..self.title..".png"
            end
        end
        
        startUpImage = imageLoad(startUpImageFile)
        --startUpImage = game.startup("ur0:appmeta/"..self.id.."/")

        return startUpImage
    end
    
    --function self.computeCategoryImage ( )
        --local bgImage = nil

        --local bgFile = nil
        --if self.category then
            --bgFile = app0.."images/"..self.category..".png"
        --end
        
        ----if not filesExists(bgFile) then
            ----bgFile = app0.."images/missing.png"
        ----end
        
        --if filesExists(bgFile) then
            --bgImage = imageLoad(bgFile)
        --end

        --return bgImage
    --end

    function self.serialize2 ( pType )
        local xml = ""

        xml = xml.." id="..self.id
        xml = xml.." path="..self.path

        if self.title then
            xml = xml.." title="..self.title
        end
        
        if self.region then
            xml = xml.." region="..self.region
        end
        
        if self.version then
            xml = xml.." version="..self.version
        end
        
        if self.category then
            xml = xml.." category="..self.category
        end
        
        if self.date then
            xml = xml.." date="..self.date
        end
        
        if self.description then
            xml = xml.." description="..self.description
        end

        return xml
    end
    
    -- return the instance
    return self
end
