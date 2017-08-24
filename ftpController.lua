function FtpController()
    local self = {}

    function self.initialize()
        ftp.init()
    end

    function self.update()
        if not wlan.isconnected() and ftp.state() then -- return from sleep and not have wifi, but ftp is ON, turn ftp OFF.
            ftp.term()
        end

        if wlan.isconnected() and not ftp.state() then -- return from sleep or wifi is back, ftp is OFF, turn ftp ON.
           ftp.init()
        end
    end
    
    -- return the instance
    return self
end

