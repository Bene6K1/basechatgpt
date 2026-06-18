local shopOpen = false

function stateShop()
  shopOpen = not shopOpen
  
  if shopOpen then
    DisplayRadar(false)
    playTabletAnimation()
    SetNuiFocus(true, true)
    StartScreenEffect("MenuMGIn", 1, true)
    SetNuiFocus(shopOpen, shopOpen)
    TriggerServerEvent("nevaShop:getScannedCases")
    TriggerServerEvent("GetPlayerCredits")
    TriggerServerEvent("GetCodeBoutique")
    TriggerServerEvent("nevaShop:getOfferEndDate")
    SendNUIMessage({
      type = "open",
      config = Config
    })
  else
    DisplayRadar(true)
    playTabletAnimation()
    SetNuiFocus(false, false)
    StopScreenEffect("MenuMGIn")
    SetNuiFocus(shopOpen, shopOpen)
  end
end

RegisterNetEvent("nevaShop:receiveScannedCases", function(scannedCases)
  SendNUIMessage({
    type = "scannedCases",
    scannedCases = scannedCases
  })
end)

RegisterCommand(Config.Commands.shop, function()
  stateShop()
end)

RegisterNUICallback("close", function(data, cb)
  stateShop()
  cb("ok")
end)

RegisterKeyMapping(Config.Commands.shop, "Ouvrir la boutique", "keyboard", "F1")
