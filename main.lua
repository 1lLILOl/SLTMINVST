local projectPath = debug.getinfo(1, "S").source:match("^@(.*/)") or "./"

package.path = projectPath .. "?.lua;" 
                .. package.path

require("iuplua")
require("iupluacontrols")
local data = require("data")
local utils = require("utils")



local function showText()

    iup.Message("Sucesso!", "Arquivo verificado com sucesso; Fale com um monitor para obter acesso")

end

local function main()

    local function onVerify(victim)
        showText(victim)
    end

    local function onGetVictim(victim)
        
        if not victim then print("drouga") return end

        utils:verifyCode(victim, onVerify) 
    end

    utils:getVictim(onGetVictim)

    iup.MainLoop()
end

main()