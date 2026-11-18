local data = require("data")

local utils = {}

function utils:getVictim(onGet)

    local inputLabel = iup.label({
        title = "Insira o nome do usuário e sua senha",
        -- expand = "HORIZONTAL",
        alignment = "ACENTER",
        font = "Sans, Bold 18"
    })

    local victimsDropdown = iup.list({
        "Lise Meitner",
        "Rosalind Franklin",
        dropdown = "YES",
        value = 1,
        size = "400x",
        font = "Sans, 14",
    })

    local inputBox = iup.text({
        size = "400x",
        font = "Sans, 14",
    })

    local outputLabel = iup.label({
        title = "",
        size = "400x",
        alignment = "ACENTER",
        fgcolor = "247 42 73",
        font = "Sans, 14",
    })

    local sendBtn = iup.button({
        title = "Acessar ficha",
        size = "200x",
        font = "Sans, 14",

    })


    local dlg = iup.dialog({

        iup.vbox({
            iup.fill{},

            iup.hbox({

                iup.fill{},

                iup.frame{

                    iup.vbox{

                        inputLabel,
                        victimsDropdown,
                        inputBox,
                        outputLabel,
                        sendBtn,

                        margin = "10x10",
                        gap = "8",
                        -- expand = "HORIZONTAL",
                        alignment = "ACENTER",
                    },

                },

                size = "500x",

                iup.fill{},
            }),

            iup.fill{},


            margin = "10x10",
            gap = "8",
            -- expand = "HORIZONTAL",
            alignment = "ACENTER",
            
        }),

        title = "Fichas",
        -- size = "600x300",
        fullscreen = "YES",

    })

    function sendBtn:action()
        
        local victimValue = tonumber(victimsDropdown.value)

        local victim = data.Victims[victimValue]
        if not victim then return end

        local iptValue = inputBox.value
        if iptValue ~= victim.FirstCode then 

            outputLabel.title = "Digite a senha correta da ficha de " .. victim.Name
            return
        end

        inputBox.value = ""
        outputLabel.title = ""
        onGet(victim)

    end

    
    dlg:showxy(iup.CENTER, iup.CENTER)

end



function utils:verifyCode(victim, onVerify)

    local correctPassphrase = victim.SecondCode

    local inputLabel = iup.label({
        title = "Insira o código para confirmação: ",
        font = "Sans, 14",

    })

    local inputBox = iup.text({
        size = "200x",
        font = "Sans, 14",

    })

    local outputLabel = iup.label({
        title = "",
        fgcolor = "247 42 73",
        -- size = "200x",
        font = "Sans, 14",

    })

    local sendBtn = iup.button({
        title = "Confirmar",
        -- size = "200x",
        font = "Sans, 14",

    })

    local hintsLabel = iup.label({
        title = "São 5 os passos para formar o código final.\nEncontre-o e obtenha acesso as evidências necessárias para finalizar o caso.",
        -- size = "400x",
        font = "Sans, Bold 18",
        
    })

    local hints = iup.vbox({
        gap = "10",

        -- expand = "HORIZONTAL",
    })

    for i, hintTxt in ipairs(victim.Hints) do
       
        local hint = iup.label({
            title = hintTxt,
            font = "Sans, 14",

        })
        hints.append(hints, hint)
    end


    local firstBox = iup.vbox({

        iup.flatframe{

            iup.vbox({

                iup.label{

                    title = "A história de " .. victim.Name,
                    font = "Sans, Bold 18"
                },

                iup.label{

                    title = victim.HistoryText,
                    wordwrap = "YES",
                    font = "Sans, 14",

                },

                alignment = "ACENTER",
            }),

            bgcolor = "255 255 255",
            expand = "YES",

            size = "0x350",

        },

    })


    local secBoxHints = iup.flatframe{

        iup.vbox({

            hintsLabel,
            hints,

            gap = 30,
            margin = "8x8",
        }),

        alignment = "ACENTER",
        framewidth = 0,
                    
    }


    local secBoxSend = iup.flatframe{

        iup.hbox({

            iup.fill{},

            iup.vbox({

                inputLabel,
                inputBox,
                outputLabel,
                sendBtn,

                alignment = "ACENTER",
            }),

            iup.fill{},
        }),

        framewidth = 0,
                    
    }

    local secondBox = iup.vbox({
    
        iup.flatframe{ 
            
            iup.vbox({

                secBoxHints,
                secBoxSend,

            }),
    
            bgcolor = "255 255 255",
            -- expand = "YES",

            size = "600x350",
        },
            
        
    })


    local dlg = iup.dialog{

        iup.vbox({

            iup.fill{},

            iup.hbox({

                iup.hbox({

                    iup.fill{},

                    firstBox,
                    secondBox,

                    gap = 15,
                    -- homogeneous = "YES",
                    iup.fill{},

                }),

            }),

            

            iup.fill{},
            -- expandchildren = "NO",

            margin = "10x10",
            gap = "8",

        }),

        title = "Investigação",
        fullscreen = "YES",
    }

    function sendBtn:action()

        local passphrase = inputBox.value

        if passphrase:lower() ~= correctPassphrase:lower() then
            outputLabel.title = "Código incorreto"
            return
        end

        dlg:destroy()
        onVerify(victim)
    end

    dlg:showxy(iup.CENTER, iup.CENTER)

end


return utils