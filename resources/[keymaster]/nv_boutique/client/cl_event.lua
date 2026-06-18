-- NUI Callbacks for boutique shop events

RegisterNUICallback("buyItem", function(data, cb)
  SendNUIMessage({type = "close"})
  TriggerServerEvent("nevaShop:buyItem", data)
  cb("ok")
end)

RegisterNUICallback("buySpecialOffer", function(data, cb)
  TriggerServerEvent("nevaShop:buySpecialOffer")
  cb("ok")
end)

-- Network event to receive case reward
local caseReward = nil
local caseId = nil

RegisterNetEvent("nevaShop:receiveCaseReward", function(reward, id)
  caseReward = reward
  caseId = id
end)

-- NUI Callback to scan case and wait for reward
RegisterNUICallback("scanCase", function(data, cb)
  caseReward = nil
  caseId = nil
  
  TriggerServerEvent("nevaShop:scanCase", data)
  
  local waitTime = 0
  while not caseReward and waitTime < 100 do
    Citizen.Wait(100)
    waitTime = waitTime + 1
  end
  
  if not caseReward then
    cb({success = false})
    return
  end
  
  cb({
    success = true,
    reward = caseReward,
    caseId = caseId
  })
end)

-- Network events for shop updates
RegisterNetEvent("ReceivePlayerCredit", function(credits)
  SendNUIMessage({
    type = "updateCredits",
    credits = credits
  })
end)

RegisterNetEvent("ReceiveBoutiqueId", function(boutiqueId)
  SendNUIMessage({
    type = "updateBoutiqueId",
    boutiqueId = boutiqueId
  })
end)

RegisterNetEvent("nevaShop:receiveOfferEndDate", function(endDate)
  SendNUIMessage({
    type = "updateOfferEndDate",
    endDate = endDate
  })
end)
