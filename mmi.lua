function Mmi(pScreenWidth, pScreenHeight)
    local self = {}

    self.screenWidth = pScreenWidth
    self.screenHeight = pScreenHeight

    local touch_alfa_top = {0,0,0,0,0,0}
    local touch_alfa_back = {0,0,0,0,0,0}
    local touch_col = {color.white, color.green, color.blue, color.red, color.yellow, color.orange, color.cyan}

    -- system info coordinates 
    local sysInfoWidth = self.screenWidth
    local sysInfoHeight = 40
    local sysInfoX = 1
    local sysInfoY = 1

    -- app info coordinates
    local appInfoWidth = self.screenWidth
    local appInfoHeight = 60
    local appInfoX = 1
    local appInfoY = self.screenHeight - appInfoHeight

    -- app list coordinates
    local appListX = 1
    local appListY = sysInfoHeight
    local appListWidth = self.screenWidth - appListX
    local appListHeight = self.screenHeight - sysInfoHeight - appInfoHeight

    function self.initialization ()
        --splashScreen()

        loadpalette()

        wSystemInfo = WSystemInfo(sysInfoX, sysInfoY, sysInfoWidth, sysInfoHeight)
        wAppInfo = WAppInfo(appInfoX, appInfoY, appInfoWidth, appInfoHeight)
        wBackground = WBackground()
        wAppList = WAppList(appListX, appListY, appListWidth, appListHeight)
    end

    function self.update( pAppInfos, pCurrentAppIndex, pCurrentPlateform, pCurrentCategory, pDebug )
        --local fps = screen.fps()
        
        wBackground.update(pAppInfos, pCurrentAppIndex, pCurrentPlateform, pCurrentCategory, "appBackground", 255, pDebug)
        wSystemInfo.update(pDebug)
        wAppInfo.update(pAppInfos, pCurrentAppIndex, pCurrentPlateform, pCurrentCategory, pDebug)
        wAppList.update(pAppInfos, pCurrentAppIndex, pCurrentPlateform, pCurrentCategory, pDebug)
        
        -- specific debug info
        if pDebug  == true then
            --printScreen (tostring(fps), 1, 1)
            --printScreen ("App index : "..tostring(pCurrentAppIndex), 100, 100)
            --printScreen ("Current Plateform : "..tostring(pCurrentPlateform), 100, 120)
            --printScreen ("Current Category : : "..tostring(pCurrentCategory), 100, 140)

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
