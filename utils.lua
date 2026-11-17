require("data")

local utils = {}

function utils:getVictim()

    local ok, result = iup.GetParam(
        "Qual a vítima?",
        nil,
        "Selecione: %l|Lise Meitner|Rosalind Franklin|\n",
        0
    )
    
    if ok then
        return data.Victims[result+1]
    end

end



function utils:verifyCode(victim, onVerify)

    local correctPassphrase = victim.Code

    local inputLabel = iup.label({title = "Insira o código: "})
    local inputBox = iup.text({size = "100x"})
    local outputLabel = iup.label({title = ""})

    local sendBtn = iup.button({title = "Confirmar"})

    local hintsLabel = iup.label({
        title = [[
            São 5 as partes da chave final. Encontre-as e obtenha acesso às evidências finais.
        ]],
        expand = "HORIZONTAL",
        
    })
    local hints = iup.vbox({
        gap = "5",
        expand = "HORIZONTAL",
    })

    for i, hintTxt in ipairs(victim.Hints) do
       
        local hint = iup.label({
            title = hintTxt,
        })
        hints.append(hints, hint)
    end


    local dlg = iup.dialog{

        iup.vbox{
            
            iup.frame{
                iup.vbox{
                    hintsLabel,
                    hints,
                    expand = "HORIZONTAL",
                    gap = 5,
                    margin = "8x8",
                }
            },

            inputLabel,
            inputBox,
            outputLabel,
            sendBtn,
            

            margin = "10x10",
            gap = "8",
            expand = "HORIZONTAL",
            alignment = "ACENTER"
            -- size = "150x"
        },

        -- expand = "HORIZONTAL",
        -- alignment = "ACENTER",

        title = "Investigação",
        size = "400x"
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