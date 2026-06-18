NuiOpen = false
local mugshotResource = Config.MugshotResource or "MugShotBase64"

local function getHeadshotTexture()
  if mugshotResource and GetResourceState(mugshotResource) == "started" then
    local success, texture = pcall(function()
      local _, mugshot = exports[mugshotResource]:GetMugshotBase64(PlayerPedId(), false)
      return mugshot
    end)

    if success and texture and texture ~= "" then
      return ("data:image/png;base64,%s"):format(texture)
    end
  end

  return nil
end

function UpdateProfilePicture()
  local headshotTexture = getHeadshotTexture()
  
  if headshotTexture then
    SendNUIMessage({
      action = "updateProfilePicture",
      imageUrl = headshotTexture
    })
  else
    print("Failed to create a headshot texture.")
  end
end

function openCraftingUI()
  SetNuiFocus(true, true)
  SendNUIMessage({
    type = "OPEN_NUI"
  })
  NuiOpen = true
  UpdateProfilePicture()
end

function closeCraftingUI()
  SetNuiFocus(false, false)
  NuiOpen = false
end

function closeUIManual()
  SetNuiFocus(false, false)
  SendNUIMessage({
    type = "CLOSE_NUI"
  })
  NuiOpen = false
end

RegisterNUICallback("closeNUI", function(data, callback)
  if data.close == true then
    closeCraftingUI()
  end
  callback("ok")
end)

RegisterNUICallback("checkRequirements", function(data, callback)
  if data == nil then
    print("Data is nil!")
    callback("")
    return
  end
  
  local itemRequirements = data.itemReqs
  local craftAmount = data.amount
  
  if not itemRequirements then
    return
  end
  
  if #itemRequirements == 0 then
    print("No items to check.")
    return
  end
  
  TriggerServerEvent("nv-crafting:server:checkItemRequirements", itemRequirements, craftAmount)
  callback("ok")
end)

RegisterNUICallback("checkCanCraft", function(data, callback)
  if data == nil then
    print("Data is nil!")
    callback("")
    return
  end
  
  local items = data.items
  
  if not items then
    return
  end
  
  if #items == 0 then
    print("No items to check.")
    return
  end
  
  TriggerServerEvent("nv-crafting:server:checkCanCraft", items)
  callback("ok")
end)

RegisterNetEvent("returnCanCraft")
AddEventHandler("returnCanCraft", function(craftableItems)
  SendNUIMessage({
    type = "CAN_CRAFT",
    craftableItems = craftableItems
  })
end)

RegisterNetEvent("nv-crafting:client:updateXP")
AddEventHandler("nv-crafting:client:updateXP", function(playerLevel, playerXP)
  SendNUIMessage({
    type = "UPDATE_XP",
    playerLevel = playerLevel,
    playerXP = playerXP
  })
end)

RegisterNetEvent("returnItemRequirements")
AddEventHandler("returnItemRequirements", function(itemsMetCriteria, allRequirementsMet)
  SendNUIMessage({
    type = "GET_INV_STATUS",
    itemsMetCriteria = itemsMetCriteria,
    allRequirementsMet = allRequirementsMet
  })
end)