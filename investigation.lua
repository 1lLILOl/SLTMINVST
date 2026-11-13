require("iuplua")
require("iupluacontrols")

local victims = {

    --Lise
    {
        Code = "MS8519",

        Hints = {

            [[Para a primeira chave, eterniza-se a cientista
            no nome de um metal;]],

            [[Para a segunda chave, nomeia-se o refúgio
            durante o terceiro Reich;]],

            [[Para a terceira chave, conta-se a soma das
            lombadas dos interesses da imperatriz austríaca;
            procure-a na sala]],

            [[Para a quarta chave, conta-se o par de dígitos
            da foto roubada da colega química;]],

            [[Para a quinta chave, conta-se o número atômico
            do resultado da fissão nuclear; procure-a na
            sala]],

        }

    },


    --Franklin 
    {
        Code = "CL9449",
        
        Hints = {

            [[Para a primeira chave, \n 
            nomeia-se a técnica que decifrou o DNA;]],

            [[Para a segunda chave, \n
            nomeia-se o primeiro nome da colega cientista de semelhante destino;]],

            [[Para a terceira chave, \n
            conta-se a soma das colunas dos interesses da imperatriz austríaca; procure na sala]],

            [[Para a quarta chave, \n
            conta-se a diferença de tempo entre a morte precoce e o roubo;]],

            [[Para a quinta chave, \n
            (trabalho em progresso)]],
        }

    }
}

local function getVictim()

    local ok, result = iup.GetParam(
        "Qual a vítima?",
        nil,
        "Selecione: %l|Lise Meitner|Rosalind Franklin|\n",
        0
    )
    
    if ok then
        return victims[result+1]
    end

end


local function login(victim, onLogin)

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
        onLogin(victim)
    end

    dlg:showxy(iup.CENTER, iup.CENTER)

end


local function showText()

    iup.Message("Sucesso!", "Arquivo verificado com sucesso; Fale com um monitor para obter acesso")

end

local function main()

    local victim = getVictim()
    if not victim then print("drouga") return end

    login(victim, showText)
    iup.MainLoop()

end

main()