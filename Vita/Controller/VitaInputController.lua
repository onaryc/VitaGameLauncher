function VitaInputController(pArg)
    local self = VGLInputController(pArg)
    
    function self.update ( )
        buttons.read()
        touch.read()
        
        -- generic input action
        self.genericInputAction()

        -- compute digital state
        self.computeDigital()

        -- compute analog state
        self.computeAnalog()

        -- compute touch shift, ...
        self.computeFTouch()
    end

    function self.genericInputAction()
        -- launching game
        if buttons.cross then
            --printScreen("Launching game : "..pAppInfos[self.currentPlateform][self.currentCategory][currentAppIndex].id, 400, 10)
            --launchGame(pAppInfos[self.currentPlateform][self.currentCategory][currentAppIndex].id)
            local currentApp = api.getCurrentApp()
            if currentApp != nil then
                launchGame(currentApp.id)
            end
        end

        -- exit app
        if buttons.released.start then
            os.exit()
        end

        -- manage debug level
        if buttons.held.select then
            api.setDebug(true)
        end

        if buttons.released.select then
            api.setDebug(false)
        end
    end

    function self.computeDigital()
        --printScreen(tostring(repeatButton:time()), 30, 0)
        if buttons.held.up then
            if repeatButton:time() >= repeatInterval then
                repeatButton:reset()
                repeatButton:start()

                self.up = true
            else
                self.up = false
            end
        end
        
        if buttons.released.up then
            self.up = false
        end
        
        if buttons.held.down then
            if repeatButton:time() >= repeatInterval then
                repeatButton:reset()
                repeatButton:start()

                self.down = true
            else
                self.down = false
            end        
        end

        if buttons.released.down then
            self.down = false
        end

        if buttons.held.left then
            if repeatButton:time() >= repeatInterval then
                repeatButton:reset()
                repeatButton:start()

                self.left = true
            else
                self.left = false
            end
        end

        if buttons.released.left then
            self.left = false
        end
        
        if buttons.held.right then
            if repeatButton:time() >= repeatInterval then
                repeatButton:reset()
                repeatButton:start()

                self.right = true
            else
                self.right = false
            end
        end

        if buttons.released.right then
            self.right = false
        end
    end
    
    function self.computeFTouch ( )
        --printScreen("FTouch", 30, 0)
        for i=1,6 do --touch.front.count 
            self.tfX[i] = touch.front[i].x
            self.tfY[i] = touch.front[i].y
            if touch.front[i].pressed == true then
                previousFX[i] = self.tfX[i]
                previousFY[i] = self.tfY[i]
            elseif touch.front[i].released == true then -- if the touch.front.count var is used to max the loop, it will be 0 when the touch is released and this part of the code never taken into account 
                self.tfX[i] = -1
                self.tfY[i] = -1

                if self.shiftDelay == true then
                    shiftTimer:reset()
                    shiftTimer:start()
                else
                    self.shiftTFX[i] = 0
                    self.shiftTFY[i] = 0
                end
            elseif touch.front[i].held == true then
                -- compute shift
                self.shiftTFX[i] = self.tfX[i] - previousFX[i]
                self.shiftTFY[i] = self.tfY[i] - previousFY[i]

                -- update previous coordinates
                previousFX[i] = self.tfX[i]
                previousFY[i] = self.tfY[i]
            end

            if self.shiftDelay == true then
                -- decrease the shifth over time
                if shiftTimer:time() >= shiftDInterval then
                    self.shiftTFX[i] = self.shiftTFX[i] * shiftDRatio
                    self.shiftTFY[i] = self.shiftTFY[i] * shiftDRatio

                    if self.shiftTFX[i] < 1 and self.shiftTFX[i] > -1 then
                        self.shiftTFX[i] = 0
                    end
                    
                    if self.shiftTFY[i] < 1 and self.shiftTFY[i] > -1 then
                        self.shiftTFY[i] = 0
                    end

                    -- shift still need to decrease
                    if (self.shiftTFX[i] != 0) or (self.shiftTFY[i] != 0) then
                        shiftTimer:reset()
                        shiftTimer:start()
                    end                    
                end
            end
        end
    end

    function self.computeAnalog ( )
        if buttons.analogly > analogDeadzone then -- left analog up
            if self.analogLUpReleased == true then
                self.analogLUpPressed = true
                self.analogLUpReleased = false
            else
                self.analogLUpPressed = false
            end
        else
            self.analogLUpPressed = false
            self.analogLUpReleased = true
        end

        if buttons.analogly < -analogDeadzone then -- left analog down
            if self.analogLDownReleased == true then
                self.analogLDownPressed = true
                self.analogLDownReleased = false
            else
                self.analogLDownPressed = false
            end
        else
            self.analogLDownPressed = false
            self.analogLDownReleased = true
        end

        if buttons.analogry > analogDeadzone then -- right analog up
            if self.analogRUpReleased == true then
                self.analogRUpPressed = true
                self.analogRUpReleased = false
            else
                self.analogRUpPressed = false
            end
        else
            self.analogRUpPressed = false
            self.analogRUpReleased = true
        end

        if buttons.analogry < -analogDeadzone then -- right analog down
            if self.analogRDownReleased == true then
                self.analogRDownPressed = true
                self.analogRDownReleased = false
            else
                self.analogRDownPressed = false
            end
        else
            self.analogRDownPressed = false
            self.analogRDownReleased = true
        end
    end
    
    -- return the instance
    return self
end

vitaInputController = VitaInputController()
api.addController(vitaInputController)
