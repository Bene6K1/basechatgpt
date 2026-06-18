-- Checks if ox_inventory resource is started
local function isOxInventoryStarted()
  return GetResourceState("ox_inventory") == "started"
end

-- Gives a weapon (and ammo) to a player, using ox_inventory or ESX depending on what's available
local function GiveWeapon(playerId, weaponName)
  local player = ESX.GetPlayerFromId(playerId)
  if not player then return end

  local isPermanent = false
  if GetResourceState("ArmePerm") == "started" then
    isPermanent = exports.ArmePerm:sv_isitemperm(weaponName)
  end

  local weaponItemName = weaponName
  if isOxInventoryStarted() then
    if not string.match(weaponName, "^WEAPON_") then
      weaponItemName = "WEAPON_" .. string.upper(weaponName)
    end
  end

  if isOxInventoryStarted() then
    local success, errorMsg = exports.ox_inventory:AddItem(playerId, weaponItemName, 1)
    if success then
      print(("[Boutique] Arme permanente ajoutée: %s au joueur %s"):format(weaponItemName, playerId))
    else
      print(("[Boutique] Erreur lors de l'ajout de l'arme: %s au joueur %s - %s"):format(weaponItemName, playerId, errorMsg or "unknown"))
      TriggerClientEvent("esx:showNotification", playerId, "~r~Erreur lors de l'ajout de l'arme")
      return
    end
  else
    if isPermanent and player.addInventoryItemPerm then
      player.addInventoryItemPerm(weaponName, 1)
    else
      player.addInventoryItem(weaponName, 1)
    end
  end

  local ammoItem = Config.WeaponAmmo[weaponName]
  if ammoItem then
    if isOxInventoryStarted() then
      exports.ox_inventory:AddItem(playerId, ammoItem, Config.DefaultAmmo)
    else
      player.addInventoryItem(ammoItem, Config.DefaultAmmo)
    end
  end
end

GiveWeapon = GiveWeapon
