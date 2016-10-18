function WSystemInfo( pScreenWidth, pScreenHeight )
    local self = {}

    -- private variables
    local screenWidth = pScreenWidth
    local screenHeight = pScreenHeight
    
    local width = screenWidth -1
    local height = 40
    local xULP = 1
    local yULP = 1

    local batteryImg = imageLoad("app0:/images/battery.png")
    local batteryLowImg = imageLoad("app0:/images/batteryLow.png")
    local chargeImg = imageLoad("app0:/images/charge.png")
    local chargingImg = imageLoad("app0:/images/charging.png")
    
    function self.update( pDebug )
        if pDebug == true then
            draw.fillrect(xULP, yULP, width, height, color.black)  
            drawRectangle(xULP, yULP, width, height, color.yellow)
        end

        -- battery info
        batteryDisplay()

        -- wifi info
        wifiDisplay()
    end

    local function batteryDisplay ()
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

            --printScreen ("bat charge "..tostring(batteryCharge), 1, 400)
            --printScreen ("width "..tostring(width), 1, 420)
            --printScreen ("height "..tostring(height), 1, 440)
            --printScreen ("imgWidth "..tostring(imgWidth), 1, 460)
            
            imageBlit(batteryImg, x, y)
            imageBlitPart(imgTmp, x, y, xi, yi, width, height)
            --imageBlit(imgTmp, x, y)
        end
    end

    local function wifiDisplay ()
        if wlan.isconnected() == true then
            local status = wlan.status()
            local strength = wlan.strength()
        end
    end

    -- return the instance
    return self
end
