function ProfileController( pPath )
    local self = {}

    self.path = pPath -- folder where all profiles are listed
    --self.selectedProfile = nil
    self.profiles = {}

    local SLAXML = require 'slaxml'
    function self.profileParse( pXml )
        local profileCommands = {}
        local profileCommand = {}
        local commandAttributes = {}

        local firstTag = true
        local rootTag = ""
        local currentTag = ""
        local profileName = ""

        local builder = SLAXML:parser{
            startElement = function(name,nsURI) -- name is the opening tag
                currentTag = name
                if firstTag == true then
                    rootTag = name
                    firstTag = false
                end
                
                if currentTag != rootTag then
                    profileCommand["name"] = name
                end
            end,
            attribute = function(name,value,nsURI) -- name : the attribute name, value : the attribute value
                if currentTag != rootTag then
					--table.insert(commandAttributes, { name = name, value = value })
					--table.insert(commandAttributes, name, value)
                    commandAttributes[name] = value
                else
                    profileName = value
                end
            end,	
            closeElement = function(name) -- name is the closing tag
                if name != rootTag then
                    if profileCommand != {} then
						profileCommand["attributes"] = commandAttributes
                        table.insert(profileCommands, profileCommand)
                    end

                    -- reinit values for further commands
                    profileCommand = {}
                    commandAttributes = {}
                end
            end,
        }
        builder:parse(pXml)
        return profileName, profileCommands
    end

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

		--~ renderDebug ()
        --~ screenFlip()
        --~ buttons.waitforkey() 
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

                -- get the profile name and command
                local name, commands = self.profileParse(fId)

                -- create the profile
                res = WProfile(name, commands)

            end
        end

        return res
    end

    function self.evalProfile( )
        printDebug("evalProfile\n")
        for key,value in pairs(self.profiles) do
            --local res = load(value)()
            --printDebug("key "..key.." profile name "..value.name.."\n")
            printDebug("profile "..key.."\n")
            value.eval()
            
        end

        renderDebug ()
        screenFlip()
        buttons.waitforkey() 
    end
    
    -- return the instance
    return self
end
