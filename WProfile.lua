
function WProfile ( pName, pCommands )
    local self = VGLObject ()

    -- public variables
    self.name = pName
    self.commands = pCommands
    

    function self.eval( )
        for key,value in pairs(self.commands) do -- all commands
            if value.name != nil then -- one command
                printDebug("name "..value.name.."\n")
                local frameIdMap = {}
                local commandToEval = value.name.."("
                local currentId = ""
                local attributes = {}
                if value.attributes != nil then
                    for key1,value1 in pairs(value.attributes) do
                        printDebug (key1.." = "..value1.." ")
                        --~ printDebug(value1.name.." = "..value1.value.." ")
                        local attrValue = value1
                        
                        -- store the current id for the frame id map
                        if key1 == "id" then
                            currentId = value1
                        end
                        
                        -- transform the color if needed
                        if testColor(value1) == true then
                            attrValue = toColor(value1)
                        end
                        
                        -- replace the xml id by the pointer to the actual created frame
                        if key1 == "frame" then
                            --if attrValue == "" then -- TODO a regexp on all empty values, or the frame shall references an xml id (2 passes shall be necessary)
                                --attrValue = "nil"
                            --end
                            if attrValue != "" then
                                attrValue = frameIdMap[attrValue]
                            end 
                            if attrValue == nil then
                                attrValue = "nil"
                            end 
                        end

                        value.attributes[key1] = attrValue
                        
                        --commandToEval = commandToEval..attrValue
                        --local sep = ", "
                        --if key1 == #value.attributes then
                            --sep = ")"
                        --end
                        --commandToEval = commandToEval..sep
                    end

                    --commandToEval = commandToEval..value.attributes
                end

                -- get the widget command pointer by its name
                cmdName = loadstring("return "..value.name)
                --printDebug("cmdName "..tostring(cmdName).."\n") 

                -- create the widget
                local res = cmdName(value.attributes)
                --printDebug("res "..tostring(res).."\n") 
                frameIdMap[currentId] = res
            end
            
        end
        --printDebug("\n")
    end
    
    --function self.eval( )
        --for key,value in pairs(self.commands) do -- all commands
            --if value.name != nil then -- one command
                ----local f = loadstring(value.name.."()")
            --end
            ----local res = load(value)()
            
        --end
        ----printDebug("\n")
    --end
    
    -- return the instance
    return self
end
