local function ShowHelpNotification(text)
    BeginTextCommandDisplayHelp("STRING")
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandDisplayHelp(0, false, true, -1)
end

if Config.RagdollEnabled then
    RegisterCommand('+ragdoll', function() 
        Ragdoll() 
    end, false)
    RegisterKeyMapping("+ragdoll", "Ragdoll your character", "keyboard", Config.RagdollKeybind)

    local isRagdool = false

    function Ragdoll()
        if isRagdool then return end
        isRagdool = true
        CreateThread(function()
            while isRagdool do
                Wait(0)
                SetPedToRagdoll(PlayerPedId(), 1000, 1000, 0, 0, 0, 0)
                SetEntityInvincible(PlayerPedId(), false) -- Désactiver l'invincibilité
                ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour ~g~se relever.")
                if IsControlJustPressed(0, 51) then
                    isRagdool = false
                    SetPedToRagdoll(PlayerPedId(), 0, 0, 0, 0, 0, 0)
                end
            end
        end)
    end
end