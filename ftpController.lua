function FtpController()
    local self = {}

    function self.initialize()
        ftpInit()
    end

    function self.update()
        if not wlan.isconnected() and ftp.state() then -- return from sleep and not have wifi, but ftp is ON, turn ftp OFF.
            ftpTerm()
        end

        if wlan.isconnected() and not ftp.state() then -- return from sleep or wifi is back, ftp is OFF, turn ftp ON.
           ftpInit()
        end
    end
    
    -- return the instance
    return self
end

