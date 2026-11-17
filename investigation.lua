local projectPath = debug.getinfo(1, "S").source:match("^@(.*/)") or "./"

package.path = projectPath .. "?.lua;" 
                .. package.path

require("iuplua")
require("iupluacontrols")
require("data")
require("utils")

print(package.path)






local function showText()

    iup.Message("Sucesso!", "Arquivo verificado com sucesso; Fale com um monitor para obter acesso")

end

local function main()

    local victim = utils:getVictim()
    if not victim then print("drouga") return end

    utils:verifyCode(victim, showText)
    iup.MainLoop()

end

main()