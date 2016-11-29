function GameObject( pPlateform, pId, pPath, pCategory, pTitle, pRegion, pVersion, pDate, pDescription )
    local self = {}

    -- public variables
    self.plateform = pPlateform
    self.id = pId
    self.path = pPath
    self.title = pTitle
    self.region = pRegion
    self.version = pVersion
    self.date = pDate
    self.description = pDescription
    self.category = pCategory
    self.nbPlayer = 1

    -- background image (use by wBackground)
    self.appBgImage = nil
    --self.plateformBgImage = nil
    --self.categoryBgImage = nil

    -- plateform icon (use by wApplist)
    --self.plateformIcon = nil
    --self.regionIcon = nil

    -- startup image (use by wApplist)
    self.startupImage = nil

    function self.initialization2 ()
        self.appBgImage = self.computeAppBgImage()
        --self.plateformBgImage = self.computePlateformBgImage()
        --self.categoryBgImage = self.computeCategoryImage()
        --
        --self.plateformIcon = self.computePlateformIcon()

        self.startupImage = self.computeStartupImage()
    end
    
    --function self.computePlateformBgImage( )
        --local bgImage = nil

        --local bgFile = nil
        --if self.plateform then
            --bgFile = app0.."images/"..self.plateform.."BG.png"
        --end
        
        ----if not filesExists(bgFile) then
            ----bgFile = app0.."images/missing.png"
        ----end
        
        --if filesExists(bgFile) then
            --bgImage = imageLoad(bgFile)
        --end

        --return bgImage
    --end
    
    --function self.computePlateformIcon( )
        --local bgImage = nil

        --local bgFile = nil
        --if self.plateform then
            --bgFile = app0.."images/"..self.plateform..".png"
        --end
        
        ----if not filesExists(bgFile) then
            ----bgFile = app0.."images/iconError.png"
        ----end
        
        --if filesExists(bgFile) then
            --bgImage = imageLoad(bgFile)
        --end

        --return bgImage
    --end

    function self.computeAppBgImage ( )
        local bgImage = nil

        local bgFile = nil
        if self.plateform == "PSVita" then
            bgFile = self.path.."/sce_sys/pic0.png"
        else
            if self.title and self.plateform then
                bgFile = app0.."images/"..self.plateform.."/"..self.title..".png"
            end
        end
        
        --if not filesExists(bgFile) then
            --bgFile = app0.."images/missing.png"
        --end
        
        if filesExists(bgFile) then
            bgImage = imageLoad(bgFile)
        end

        return bgImage
    end
    
    function self.computeStartupImage ( )
        local bgImage = nil

        local bgFile = nil
        if self.plateform == "PSVita" then
            bgFile = self.path.."/sce_sys/icon0.png"
        else
            if self.title and self.plateform then
                bgFile = app0.."images/"..self.plateform.."/"..self.title..".png"
            end
        end

        --if not filesExists(bgFile) then
            --bgFile = app0.."images/missing.png"
        --end
        
        if filesExists(bgFile) then
            bgImage = imageLoad(bgFile)
        end

        return bgImage
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
