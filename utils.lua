local data = require("data")

local utils = {}

function utils:getVictim(onGet)

    local inputLabel = iup.label({
        title = "Insira o nome do usuário e sua senha",
        -- expand = "HORIZONTAL",
        alignment = "ACENTER",
        font = "Sans, Bold 16"
    })

    local victimsDropdown = iup.list({
        "Lise Meitner",
        "Rosalind Franklin",
        dropdown = "YES",
        value = 1,
        size = "400x"
    })

    local inputBox = iup.text({size = "400x"})

    local outputLabel = iup.label({
        title = "",
        size = "400x",
        alignment = "ACENTER",
        fgcolor = "247 42 73"
    })

    local sendBtn = iup.button({title = "Acessar ficha", size = "200x"})


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
        title = "Insira o código: ",
        alignment = "ACENTER",
        size = "600x"
    })

    local inputBox = iup.text({
        size = "200x"
    })

    local outputLabel = iup.label({
        title = "",
        fgcolor = "247 42 73",
        size = "200x",
        alignment = "ACENTER",
    })

    local sendBtn = iup.button({
        title = "Confirmar",
        size = "200x",
    })

    local hintsLabel1 = iup.label({
        title = "São 5 as partes da chave final.",
        -- expand = "HORIZONTAL",
        size = "400x",
        alignment = "ACENTER",
        font = "Sans, Bold 16"
        
    })
    local hintsLabel2 = iup.label({
        title = "Encontre-as e obtenha acesso às evidências finais.",
        -- expand = "HORIZONTAL",
        -- size = "400x",
        -- alignment = "ACENTER",
        font = "Sans, Bold 16"
        
    })
    local hints = iup.vbox({
        gap = "10",
        expand = "HORIZONTAL",
        -- alignment = "ACENTER",
    })

    for i, hintTxt in ipairs(victim.Hints) do
       
        local hint = iup.label({
            title = hintTxt,
        })
        hints.append(hints, hint)
    end



    local dlg = iup.dialog{

        iup.vbox({

            iup.fill{},

            iup.hbox({

                iup.fill{},

                iup.frame{

                    iup.vbox({
    
                        iup.frame{

                            iup.vbox({
                                iup.vbox({
                                    hintsLabel1,
                                    hintsLabel2,

                                    -- size = "400x",
                                    alignment = "ACENTER",
                                }),
                                
                                hints,

                                expand = "HORIZONTAL",
                                gap = 30,
                                margin = "8x8",
                                alignment = "ACENTER",
                            }),

                            size = "600x200",
                            alignment = "ACENTER",
                        },

                        iup.vbox({

                            inputLabel,
                            inputBox,
                            outputLabel,
                            sendBtn,


                            alignment = "ACENTER",
                            expand = "HORIZONTAL",
                        }),
                        

                    }),

                    -- size = "600x350"
                },

                iup.fill{},

                alignment = "ACENTER",
            }),

            iup.fill{},
            

            margin = "10x10",
            gap = "8",
            -- expand = "HORIZONTAL",
            alignment = "ACENTER"
            -- size = "150x"
        }),

        -- expand = "HORIZONTAL",
        -- alignment = "ACENTER",

        title = "Investigação",
        -- size = "700x400"
        fullscreen = "YES",

    }

    function sendBtn:action()

        local passphrase = inputBox.value

        if passphrase ~= correctPassphrase then
            outputLabel.title = "Senha incorreta"
            return
        end

        dlg:destroy()
        onVerify(victim)
    end

    dlg:showxy(iup.CENTER, iup.CENTER)

end


return utils