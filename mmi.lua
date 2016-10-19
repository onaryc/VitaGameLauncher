function Mmi(pScreenWidth, pScreenHeight)
    local self = {}

    local touch_alfa_top = {0,0,0,0,0,0}
    local touch_alfa_back = {0,0,0,0,0,0}
    local touch_col = {color.white, color.green, color.blue, color.red, color.yellow, color.orange, color.cyan}

    local screenWidth = pScreenWidth
    local screenHeight = pScreenHeight
    
    function self.initialization ()
        --splashScreen()

        loadpalette()

        wSystemInfo = WSystemInfo(screenWidth, screenHeight)
        wAppInfo = WAppInfo(screenWidth, screenHeight)
        wBackground = WBackground()
    end

    function self.update( pAppInfos, pCurrentAppIndex, pDebug )
        --platformWheel("left", 150, 544, true)
        --filterWheel("right", 150, 544, true)
        --local fps = screen.fps()
        
        wBackground.update(pAppInfos, pCurrentAppIndex, "appBackground", 255, pDebug)
        wSystemInfo.update(pDebug)
        wAppInfo.update(pAppInfos, pCurrentAppIndex, pDebug)

        -- specific debug info
        if pDebug  == true then
            --printScreen (tostring(fps), 1, 1)

            self.touchDebug()
        end

        screenFlip()
    end

    function self.touchDebug( pDebug )
        -- debug info with back and front touch pad
        if pDebug == true then
            for i=1,6 do
                printScreen2("+", buttons.touchf[i].x,buttons.touchf[i].y,1,touch_col[i]:a(touch_alfa_top[i]))
                --screen.print(buttons.touchf[i].x,buttons.touchf[i].y, "+",1,touch_col[i]:a(touch_alfa_top[i]))
                if buttons.touchf[i].moved then
                    touch_alfa_top[i] = 255
                elseif touch_alfa_top[i] > 0 then
                    touch_alfa_top[i] -= 2
                end
            end

            for i=1,4 do
                printScreen2("X", buttons.touchb[i].x,buttons.touchb[i].y,1,touch_col[i]:a(touch_alfa_back[i]))
                --screen.print(buttons.touchb[i].x,buttons.touchb[i].y, "X",1,touch_col[i]:a(touch_alfa_back[i]))
                if buttons.touchb[i].moved then
                    touch_alfa_back[i] = 255
                elseif touch_alfa_back[i] > 0 then
                    touch_alfa_back[i] -= 2
                end
            end
        end
    end

    self.initialization()

    -- return the instance
    return self
end
