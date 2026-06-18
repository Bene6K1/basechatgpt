ESX = nil

local Weapons = {}
local AmmoTypes = {}

local PlayerData = nil
local AmmoInClip = {}

local CurrentWeapon = nil

local IsShooting = false
local AmmoBefore = 0
local ManualWeaponSwitch = false
local AmmoUsedWhileShooting = 0
local LastWeaponSwitch = 0
local LastRebuildTime = 0
local RebuildCooldown = 500

for name,item in pairs(Config.Weapons) do
  Weapons[GetHashKey(name)] = item
end

for name,item in pairs(Config.AmmoTypes) do
  AmmoTypes[GetHashKey(name)] = item
end

CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Wait(200)
  end

  while not ESX.IsPlayerLoaded() do
    Wait(100)
  end

  PlayerData = ESX.GetPlayerData()
end)

function GetAmmoItemFromHash(hash)
  for name,item in pairs(Config.Weapons) do
    if hash == GetHashKey(item.name) then
      if item.ammo then
        return item.ammo
      else
        return nil
      end
    end
  end
  return nil
end

function GetInventoryItem(name)
  if not PlayerData or not PlayerData.inventory then return nil end
  local inventory = PlayerData.inventory
  for i=1, #inventory, 1 do
    if inventory[i].name == name then
      return inventory[i]
    end
  end
  return nil
end

function RebuildLoadout()
  local currentTime = GetGameTimer()
  if currentTime - LastRebuildTime < RebuildCooldown then
    return
  end
  LastRebuildTime = currentTime
  
  while not PlayerData or not ESX do
    Wait(200)
  end
  
  local playerPed = PlayerPedId()
  if not DoesEntityExist(playerPed) then return end

  for weaponHash,v in pairs(Weapons) do
    local item = GetInventoryItem(v.item)
    if item and item.count > 0 then
      local ammo = 0
      local ammoType = GetPedAmmoTypeFromWeapon(playerPed, weaponHash)

      if ammoType and AmmoTypes[ammoType] then
        local ammoItem = GetInventoryItem(AmmoTypes[ammoType].item)
        if ammoItem then
          ammo = ammoItem.count
        end
      end

      if item.name == "fireextinguisher" then
        ammo = 1000
      end
      
      if HasPedGotWeapon(playerPed, weaponHash, false) then
        local currentAmmo = GetAmmoInPedWeapon(playerPed, weaponHash)
        if currentAmmo ~= ammo then
          SetPedAmmo(playerPed, weaponHash, ammo)
          if CurrentWeapon == weaponHash then
            AmmoBefore = ammo
          end
        end
      else
        GiveWeaponToPed(playerPed, weaponHash, ammo, false, false)
        if CurrentWeapon == weaponHash then
          AmmoBefore = ammo
        end
      end
    elseif HasPedGotWeapon(playerPed, weaponHash, false) then
      local weaponItem = GetInventoryItem(v.item)
      if not weaponItem or weaponItem.count <= 0 then
        RemoveWeaponFromPed(playerPed, weaponHash)
        if CurrentWeapon == weaponHash then
          CurrentWeapon = GetHashKey('WEAPON_UNARMED')
          AmmoBefore = 0
        end
      else
        SetPedAmmo(playerPed, weaponHash, 0)
        if CurrentWeapon == weaponHash then
          AmmoBefore = 0
        end
      end
    end
  end
end

exports("RebuildLoadout", RebuildLoadout)

function RemoveUsedAmmo()  
  local playerPed = PlayerPedId()
  if not DoesEntityExist(playerPed) or not CurrentWeapon then return 0 end
  
  local AmmoAfter = GetAmmoInPedWeapon(playerPed, CurrentWeapon)
  local ammoType = AmmoTypes[GetPedAmmoTypeFromWeapon(playerPed, CurrentWeapon)]
  
  if ammoType and ammoType.item then
    local ammoDiff = AmmoBefore - AmmoAfter
    if ammoDiff > 0 then
      TriggerServerEvent('esx:discardInventoryItem', ammoType.item, ammoDiff)
    end
  end

  return AmmoAfter
end

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  Wait(500)
  PlayerData = xPlayer
  CurrentWeapon = GetHashKey('WEAPON_UNARMED')
  AmmoBefore = 0
  RebuildLoadout()
end)

RegisterNetEvent('esx:modelChanged')
AddEventHandler('esx:modelChanged', function()
  Wait(500)
  RebuildLoadout()
end)

AddEventHandler('playerSpawned', function()
  Wait(500)
  CurrentWeapon = GetHashKey('WEAPON_UNARMED')
  AmmoBefore = 0
  RebuildLoadout()
end)

AddEventHandler('skinchanger:modelLoaded', function()
  Wait(500)
  RebuildLoadout()
end)

RegisterNetEvent('esx:addInventoryItem')
AddEventHandler('esx:addInventoryItem', function(name, count)
  Wait(200)
  PlayerData = ESX.GetPlayerData()
  
  if CurrentWeapon and CurrentWeapon ~= GetHashKey('WEAPON_UNARMED') then
    local playerPed = PlayerPedId()
    local ammoType = AmmoTypes[GetPedAmmoTypeFromWeapon(playerPed, CurrentWeapon)]
    
    if ammoType and ammoType.item == name then
      local ammoItem = GetInventoryItem(name)
      if ammoItem then
        SetPedAmmo(playerPed, CurrentWeapon, ammoItem.count)
        AmmoBefore = ammoItem.count
      end
    end
  end
end)

RegisterNetEvent('esx:removeInventoryItem')
AddEventHandler('esx:removeInventoryItem', function(name, count)
  Wait(200)
  PlayerData = ESX.GetPlayerData()
  
  if CurrentWeapon and CurrentWeapon ~= GetHashKey('WEAPON_UNARMED') then
    local playerPed = PlayerPedId()
    local ammoType = AmmoTypes[GetPedAmmoTypeFromWeapon(playerPed, CurrentWeapon)]
    
    if ammoType and ammoType.item == name then
      local ammoItem = GetInventoryItem(name)
      local newAmmo = ammoItem and ammoItem.count or 0
      SetPedAmmo(playerPed, CurrentWeapon, newAmmo)
      AmmoBefore = newAmmo
    end
  end
end)

Citizen.CreateThread(function()
  local lastWeaponCheck = 0
  local lastAmmoCheck = 0
  local checkInterval = 500
  
  while true do
    local currentTime = GetGameTimer()
    local playerPed = PlayerPedId()
    
    if DoesEntityExist(playerPed) then
      local selectedWeapon = GetSelectedPedWeapon(playerPed)
      
      if CurrentWeapon ~= selectedWeapon then
        local previousWeapon = CurrentWeapon
        
        LastWeaponSwitch = currentTime
        
        if ManualWeaponSwitch then
          ManualWeaponSwitch = false
          IsShooting = false
          CurrentWeapon = selectedWeapon
          if CurrentWeapon and CurrentWeapon ~= GetHashKey('WEAPON_UNARMED') then
            AmmoBefore = GetAmmoInPedWeapon(playerPed, CurrentWeapon)
          else
            AmmoBefore = 0
          end
        elseif selectedWeapon == GetHashKey('WEAPON_UNARMED') and previousWeapon ~= GetHashKey('WEAPON_UNARMED') then
          IsShooting = false
          CurrentWeapon = selectedWeapon
          AmmoBefore = 0
        else
          if selectedWeapon and selectedWeapon ~= GetHashKey('WEAPON_UNARMED') then
            local ammoType = GetPedAmmoTypeFromWeapon(playerPed, selectedWeapon)
            if ammoType and AmmoTypes[ammoType] and AmmoTypes[ammoType].item then
              local ammoItem = GetInventoryItem(AmmoTypes[ammoType].item)
              local inventoryAmmo = ammoItem and ammoItem.count or 0
              SetPedAmmo(playerPed, selectedWeapon, inventoryAmmo)
            end
          end
          
          IsShooting = false
          CurrentWeapon = selectedWeapon
          if CurrentWeapon and CurrentWeapon ~= GetHashKey('WEAPON_UNARMED') then
            AmmoBefore = GetAmmoInPedWeapon(playerPed, CurrentWeapon)
          else
            AmmoBefore = 0
          end
        end
      end

      if CurrentWeapon and CurrentWeapon ~= GetHashKey('WEAPON_UNARMED') and (currentTime - lastAmmoCheck) > 200 then
        local currentAmmo = GetAmmoInPedWeapon(playerPed, CurrentWeapon)
        
        if AmmoBefore then
          if currentAmmo < AmmoBefore then
            local ammoDiff = AmmoBefore - currentAmmo
            
            local ammoType = AmmoTypes[GetPedAmmoTypeFromWeapon(playerPed, CurrentWeapon)]
            if ammoType and ammoType.item then
              local ammoItem = GetInventoryItem(ammoType.item)
              if ammoItem and ammoItem.count > 0 then
                TriggerServerEvent('esx:discardInventoryItem', ammoType.item, ammoDiff)
                Wait(100)
                PlayerData = ESX.GetPlayerData()
              end
            end
            
            AmmoBefore = currentAmmo
          elseif currentAmmo > AmmoBefore then
            AmmoBefore = currentAmmo
          end
        else
          AmmoBefore = currentAmmo
        end
        
        lastAmmoCheck = currentTime
      end

      if IsPedShooting(playerPed) and not IsShooting then
        IsShooting = true
      elseif IsShooting and IsControlJustReleased(0, 24) then
        IsShooting = false
      elseif not IsShooting and IsControlJustPressed(0, 45) then
        if CurrentWeapon and CurrentWeapon ~= GetHashKey('WEAPON_UNARMED') then
          AmmoBefore = GetAmmoInPedWeapon(playerPed, CurrentWeapon)
        else
          AmmoBefore = 0
        end
      end
    end
    
    Wait(checkInterval)
  end
end)

RegisterNetEvent('weaponsync:Rebuild')
AddEventHandler('weaponsync:Rebuild', function()
  Wait(500)
  PlayerData = ESX.GetPlayerData()
  RebuildLoadout()
end)

RegisterNetEvent('kotonier:equipWeapon')
AddEventHandler('kotonier:equipWeapon', function(weaponName)
    local playerPed = PlayerPedId()
    if not DoesEntityExist(playerPed) then return end
    
    local weaponHash = GetHashKey(string.upper(weaponName))

    if not weaponHash then return end

    exports['ox_inventory']:closeInventory()
    
    if GetSelectedPedWeapon(playerPed) ~= weaponHash then
      if not HasPedGotWeapon(playerPed, weaponHash, false) then
        GiveWeaponToPed(playerPed, weaponHash, 0, false, false)
        Wait(50)
      end
      
      local ammo = 0
      local ammoType = GetPedAmmoTypeFromWeapon(playerPed, weaponHash)
      
      if ammoType and AmmoTypes[ammoType] and AmmoTypes[ammoType].item then
        local ammoItem = GetInventoryItem(AmmoTypes[ammoType].item)
        if ammoItem and ammoItem.count then
          ammo = ammoItem.count
        else
          Wait(100)
          PlayerData = ESX.GetPlayerData()
          ammoItem = GetInventoryItem(AmmoTypes[ammoType].item)
          if ammoItem and ammoItem.count then
            ammo = ammoItem.count
          end
        end
      end
      
      if Weapons[weaponHash] and Weapons[weaponHash].item then
        local weaponItem = GetInventoryItem(Weapons[weaponHash].item)
        if weaponItem and weaponItem.name == "fireextinguisher" then
          ammo = 1000
        end
      end
      
      SetPedAmmo(playerPed, weaponHash, ammo)
      SetCurrentPedWeapon(playerPed, weaponHash, true)
      
      Wait(100)
      
      local finalAmmo = GetAmmoInPedWeapon(playerPed, weaponHash)
      
      CurrentWeapon = weaponHash
      AmmoBefore = finalAmmo
    else
      ManualWeaponSwitch = true
      SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'), true)
    end
end)

CreateThread(function()
  SetWeaponsNoAutoswap(true)
  while true do
    Wait(5000)
    SetWeaponsNoAutoswap(true)
  end
end) 