function ProfileController( pPath )
    local self = {}

    self.path = pPath -- folder where all profiles are listed
    --self.selectedProfile = nil
    self.profiles = {}

    local SLAXML = require 'slaxml'
    function self.profileParse( pXml )
        local profileCommands = {}
        local profileString = ""
        local attributes = {}
        local root = true
        local builder = SLAXML:parser{
            startElement = function(name,nsURI)
                if root != true then
                    profileString = name.."("
                end
            end,
            attribute = function(name,value,nsURI)
                if root != true then
                    table.insert(attributes, value)
                end
            end,
            closeElement = function(name)
                if root != true then
                    local attrStr = table.concat(attributes, ",")
                    profileString = profileString..attrStr..")"
                    printDebug("profileString "..profileString.."\n")
                    table.insert(profileCommands, profileString)

                    -- reinit values for further commands
                    profileString = ""
                    attributes = {}
                else
                    root = false
                end
            end,
        }
        builder:parse(pXml)
        return profileCommands
    end

    --local parser = SLAXML:parser{
        --startElement = function(name,nsURI,nsPrefix) printDebug("startElement "..name.."\n")      end, -- When "<foo" or <x:foo is seen
        --attribute    = function(name,value,nsURI,nsPrefix) printDebug("attribute "..name.." "..value.."\n") end, -- attribute found on current element
        --closeElement = function(name,nsURI) printDebug("closeElement "..name.."\n")               end, -- When "</foo>" or </x:foo> or "/>" is seen
        --text         = function(text)                      end, -- text and CDATA nodes
        --comment      = function(content)                  end, -- comments
        --pi           = function(target,content)            end, -- processing instructions e.g. "<?yes mon?>"
    --}

    function self.initialize()
        printDebug("loading profiles\n")
        --printDebug("path "..self.path.."\n")
        local directories = listDirectories(self.path)
        for key,value in pairs(directories) do
            --printDebug("filename "..value.name.."\n")
            --printDebug("path "..value.path.."\n")

            -- create the profile from the layout file
            local profile = self.createProfile(value.path)

            -- add the profile
            if profile != nil then
                self.profiles[profile.name] = profile
            end
        end

        renderDebug ()
        screenFlip()
        buttons.waitforkey() 
    end
    
    --function self.select( pProfile )
        --self.selectedProfile = pProfile
    --end
    
    function self.createProfile( pPath )
        local res = nil
        if pPath != nil then
            local profileLayout = pPath.."/layout.xml"
            if filesExists(profileLayout) then
                local fId = io.open(profileLayout):read('*all')

                local commands = self.profileParse(fId)

                -- get the profile name
                local name = ""
                
                -- make the command strings to
                --local commands = ""

                -- create the profile
                local res = WProfile(name, commands)

            end
        end

        return res
    end
    
    -- return the instance
    return self
end
