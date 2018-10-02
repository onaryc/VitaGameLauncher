function VGLWSystemInfo( pArg )
    local self = VGLWFrame(pArg)

    --~ self.w = self.w - 1

    local batteryWidth = 50

    local baseUpdate = self.update -- in order to reuse parent function
    function self.update( pDebug )
        baseUpdate()
        --if api.getDebug() == true then
            --draw.fillrect(self.x, self.y, self.w, self.h, color.black)  
            --drawRectangle(self.x, self.y, self.w, self.h, color.yellow)
        --end

        -- battery info
        self.batteryDisplay()

        -- wifi info
        self.wifiDisplay()

        -- time info
        self.timeDisplay()

        -- ftp state display
        self.ftpDisplay()
    end

    function self.timeDisplay ()
        --local currentTime = os.time()
        local currentTime = os.date("%H:%M - %d %b %Y")

        local textWidth = screen.textwidth(currentTime)

        -- center the time in the upper part of the screen
        local x = self.w / 2 - textWidth / 2
        local y = 10

        printScreen (tostring(currentTime), x, y)
    end

    function self.ftpDisplay()
        local ftpState = ftp.state()

        if ftpState then
            local ftpImage = api.getFtpImage()
            local x = self.w - batteryWidth - 30
            local y = 10

            imageBlit(ftpImage, x, y)
        end
    end

    function self.batteryDisplay ()
        if batteryExists() == true then
            local batterySprite = api.getBatterySprite()
            local batteryLowSprite = api.getBatteryLowSprite()
            local batteryChargingSprite = api.getBatteryChargingSprite()
            local spriteTmp = nil
            local anim = 0
            local batteryCharge = batteryCharge()
            
            if isBatteryCharging() == true then
                -- battery is charging
                if batteryChargingSprite.timer:time() > batteryChargingSprite.speed then
                    batteryChargingSprite.timer:reset()
                    batteryChargingSprite.timer:start()
                    
                    if batteryChargingSprite.direction == "left" then
                        batteryChargingSprite.anim += 1
                        if batteryChargingSprite.anim == (batteryChargingSprite.nbAnim - 1) then
                            batteryChargingSprite.direction = "right"
                            --batteryChargingSprite.anim = batteryChargingSprite.nbAnim - 1
                        end
                    else
                        batteryChargingSprite.anim -= 1
                        if batteryChargingSprite.anim == 0 then
                            batteryChargingSprite.direction = "left"
                            --batteryChargingSprite.anim += 2
                        end
                    end                    
                end

                spriteTmp = batteryChargingSprite.sprite
                anim = batteryChargingSprite.anim
            elseif isBatteryLow() == true then
                -- battery is low
                if batteryLowSprite.timer:time() > batteryLowSprite.speed then
                    batteryLowSprite.timer:reset(); batteryLowSprite.timer:start();

                    batteryLowSprite.anim += 1
                    if batteryLowSprite.anim > 5 then
                        batteryLowSprite.anim = 0
                    end
                end

                spriteTmp = batterySprite.sprite
                anim = batteryLowSprite.anim
            end

            batterySprite.anim = math.floor(-5 * batteryCharge + 5)

            --local x = screenWidth - imgWidth - 10
            local x = self.w - batteryWidth
            local y = 10

            spriteBlit(batterySprite.sprite,x,y,batterySprite.anim)
            spriteBlit(spriteTmp,x,y,anim)
        end
    end
    
    function self.batteryDisplay2 ()
        if batteryExists() == true then
            local imgTmp = nil
            
            -- battery is charging
            if batteryCharging() == true then
                imgTmp = chargingImg
            elseif batteryLow() == true then
                imgTmp = batteryLowImg
            else
                imgTmp = chargeImg
            end

            -- battery charge
            local batteryCharge = batteryCharge()

            local imgWidth = imageGetWidth(imgTmp)
            local imgHeight = imageGetHeight(imgTmp)

            local x = self.w - imgWidth - 10
            local y = 10
            local xi = 0
            local yi = 0
            
            local width = imgWidth * batteryCharge
            local height = imgHeight

            printScreen ("bat charge "..tostring(batteryCharge), 1, 400)
            --printScreen ("width "..tostring(width), 1, 420)
            --printScreen ("height "..tostring(height), 1, 440)
            --printScreen ("imgWidth "..tostring(imgWidth), 1, 460)
            
            imageBlit(batteryImg, x, y)
            imageBlitPart(imgTmp, x, y, xi, yi, width, height)
            --imageBlit(imgTmp, x, y)
        end
    end

    function self.wifiDisplay ()
        if wlan.isconnected() == true then
            local wifiSprite = api.getWifiSprite() 
            local status = wlan.status()
            local strength = wlan.strength()

            --printScreen ("wifi status "..tostring(status), 800, 400)
            --printScreen ("wifi strength "..tostring(strength), 800, 420)

            local x = 10
            local y = 10
            
            wifiSprite.anim = 3 - status
            
            spriteBlit(wifiSprite.sprite, x, y, wifiSprite.anim)
        end
    end

    -- return the instance
    return self
end
