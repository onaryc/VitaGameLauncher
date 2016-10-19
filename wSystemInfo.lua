function WSystemInfo( pScreenWidth, pScreenHeight )
    local self = {}

    -- private variables
    local screenWidth = pScreenWidth
    local screenHeight = pScreenHeight
    
    local width = screenWidth -1
    local height = 40
    local xULP = 1
    local yULP = 1

    local battery = {
        sprite = spriteLoad("app0:/images/battery.png", 40, 20),
        anim = 0,
    }

    local batteryLow = {
        timer = timer.new(),
        sprite = spriteLoad("app0:/images/batteryLow.png", 40, 20),
        anim = 0,
        nbAnim = 5,
        speed = 200,
        direction = "left",
    }
    
    local batteryCharging = {
        timer = timer.new(),
        sprite = spriteLoad("app0:/images/batteryCharging.png", 40, 20),
        anim = 0,
        nbAnim = 5,
        speed = 200,
        direction = "left",
    }

    local wifi = {
        sprite = spriteLoad("app0:/images/wifi.png", 20, 20),
        anim = 0,
    }
    
    function self.update( pDebug )
        if pDebug == true then
            draw.fillrect(xULP, yULP, width, height, color.black)  
            drawRectangle(xULP, yULP, width, height, color.yellow)
        end

        -- battery info
        self.batteryDisplay()

        -- wifi info
        self.wifiDisplay()
    end

    function self.batteryDisplay ()
        if batteryExists() == true then
            local spriteTmp = nil
            local anim = 0
            local batteryCharge = batteryCharge()
            
            if isBatteryCharging() == true then
                -- battery is charging
                if batteryCharging.timer:time() > batteryCharging.speed then
                    batteryCharging.timer:reset(); batteryCharging.timer:start();

                    if batteryCharging.direction == "left" then
                        batteryCharging.anim += 1
                        if batteryCharging.anim > batteryCharging.nbAnim then
                            batteryCharging.direction "right"
                            batteryCharging.anim -= 2
                        end
                    else
                        batteryCharging.anim -= 1
                        if batteryCharging.anim < 0 then
                            batteryCharging.direction "left"
                            batteryCharging.anim += 2
                        end
                    end                    
                end

                spriteTmp = batteryCharging.sprite
                anim = batteryCharging.anim
            elseif isBatteryLow() == true then
                -- battery is low
                if batteryLow.timer:time() > batteryLow.speed then
                    batteryLow.timer:reset(); batteryLow.timer:start();

                    batteryLow.anim += 1
                    if batteryLow.anim > 5 then
                        batteryLow.anim = 0
                    end
                end

                spriteTmp = battery.sprite
                anim = batteryLow.anim
            end

            battery.anim = batteryCharge / 5

            --local x = screenWidth - imgWidth - 10
            local x = screenWidth - 50
            local y = 10

            spriteBlit(battery.sprite,x,y,battery.anim)
            spriteBlit(spriteTmp,x,y,anim)

            printScreen ("bat charge "..tostring(batteryCharge), 1, 380)
            --printScreen ("width "..tostring(width), 1, 420)
            --printScreen ("height "..tostring(height), 1, 440)
            --printScreen ("imgWidth "..tostring(imgWidth), 1, 460)

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

            local x = screenWidth - imgWidth - 10
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
            local status = wlan.status()
            local strength = wlan.strength()

            printScreen ("wifi status "..tostring(status), 1, 420)
            --printScreen ("wifi strength "..tostring(strength), 1, 420)

            local x = screenWidth - 30
            local y = 10

            spriteBlit(wifi.sprite, x, y,status)
            --wifi.anim = $strength / 4
            --wifi.sprite:blitsprite(x,y,wifi.anim)
        end
    end

    -- return the instance
    return self
end
