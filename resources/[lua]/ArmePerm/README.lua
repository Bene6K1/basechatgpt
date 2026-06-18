
--[[
SI VOUS CHANGEZ LE NOM DE LA RESOURCES ALORS CHANGEZ LE NOM DANS L'EXPORT AUSSI

]]--


POUR AJOUTER DES OBJETS/ARMES PERMS FAITES LE EN UTILISANT


xPlayer.addInventoryItemPerm(name, count)

--[[
Ce trigger ne checkera pas si le joueurs tente de se donner une arme perm et protegera donc tout vos codes existant des gives items non securisé. 
Faites en sorte de sécuriser votre boutique et ainsi vous ne devriez pas avoir d'item perm sur des cheater si vous n'utilisez ce code uniquement sur votre boutique


Un item perm ne peut pas etre perdu, ne faites pas un consomable en item perm

]]--

-----------------------------------------
-- /es_extended/server/classes/player.lua
-- /es_extended/server/classes/player.lua
-- /es_extended/server/classes/player.lua
-- /es_extended/server/classes/player.lua
-- /es_extended/server/classes/player.lua
-- /es_extended/server/classes/player.lua
-----------------------------------------

--REPLACE ( RECHERCHER  self.removeInventoryItem = function(name, count) et remplacer le code )
	self.removeInventoryItem = function(name, count)
		local item = self.getInventoryItem(name)
		local check = exports['ArmePerm']:sv_isitemperm(name)
		if check == false then 
			if item then
				count = ESX.Math.Round(count)
				local newCount = item.count - count
				
				if newCount >= 0 then
					item.count = newCount
					self.weight = self.weight - (item.weight * count)

					TriggerEvent('esx:onRemoveInventoryItem', self.source, item.name, item.count)
					self.triggerEvent('esx:removeInventoryItem', item.name, item.count)
				end
			end
		else
			self.showNotification("Ceci est un objet perm!")
		end
	end

--REPLACE ( RECHERCHER  self.addInventoryItem = function(name, count) et remplacer le code )
self.addInventoryItem = function(name, count)
	local item = self.getInventoryItem(name)
	local check = exports['ArmePerm']:sv_isitemperm(name)
	if check == false then 

		if item then
			count = ESX.Math.Round(count)
			item.count = item.count + count
			self.weight = self.weight + (item.weight * count)

			TriggerEvent('esx:onAddInventoryItem', self.source, item.name, item.count)
			self.triggerEvent('esx:addInventoryItem', item.name, item.count)
		end
	else
		self.showNotification("Ceci est un objet perm!")
	end
end


-- AJOUT ( EN DESSOUSOUS DU CODE self.addInventoryItem = function(name, count) )

self.addInventoryItemPerm = function(name, count)
	local item = self.getInventoryItem(name)


		if item then
			count = ESX.Math.Round(count)
			item.count = item.count + count
			self.weight = self.weight + (item.weight * count)

			TriggerEvent('esx:onAddInventoryItem', self.source, item.name, item.count)
			self.triggerEvent('esx:addInventoryItemPerm', item.name, item.count)
		end
end



-------------------------------
--/es_extended/server/main.lua
--/es_extended/server/main.lua
--/es_extended/server/main.lua
--/es_extended/server/main.lua
--/es_extended/server/main.lua
--/es_extended/server/main.lua
-------------------------------




--REPLACE ( RECHERCHER  RegisterNetEvent('esx:removeInventoryItem') et remplacer le code )
RegisterNetEvent('esx:removeInventoryItem')
AddEventHandler('esx:removeInventoryItem', function(type, itemName, itemCount)
	local _source = source
	local playerId = _source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local check = exports['ArmePerm']:sv_isitemperm(itemName)

	if check == false then 
		if type == 'item_standard' then
			if itemCount == nil or itemCount < 1 then
				xPlayer.showNotification(_U('imp_invalid_quantity'))
			else
				local xItem = xPlayer.getInventoryItem(itemName)

				if (itemCount > xItem.count or xItem.count < 1) then
					xPlayer.showNotification(_U('imp_invalid_quantity'))
				else
					xPlayer.removeInventoryItem(itemName, itemCount)
					local pickupLabel = ('~y~%s~s~ [~b~%s~s~]'):format(xItem.label, itemCount)
					ESX.CreatePickup('item_standard', itemName, itemCount, pickupLabel, playerId)
					xPlayer.showNotification(_U('threw_standard', itemCount, xItem.label))

				end
			end
		elseif type == 'item_account' then
			if itemCount == nil or itemCount < 1 then
				xPlayer.showNotification(_U('imp_invalid_amount'))
			else
				local account = xPlayer.getAccount(itemName)

				if (itemCount > account.money or account.money < 1) then
					xPlayer.showNotification(_U('imp_invalid_amount'))
				else
					xPlayer.removeAccountMoney(itemName, itemCount)
					local pickupLabel = ('~y~%s~s~ [~g~%s~s~]'):format(account.label, _U('locale_currency', ESX.Math.GroupDigits(itemCount)))
					ESX.CreatePickup('item_account', itemName, itemCount, pickupLabel, playerId)
					xPlayer.showNotification(_U('threw_account', ESX.Math.GroupDigits(itemCount), string.lower(account.label)))
					Wait(1)
					print("jete argent")

				end
			end
		elseif type == 'item_weapon' then
			itemName = string.upper(itemName)

			if xPlayer.hasWeapon(itemName) then
				local _, weapon = xPlayer.getWeapon(itemName)
				local _, weaponObject = ESX.GetWeapon(itemName)
				local components, pickupLabel = ESX.Table.Clone(weapon.components)
				xPlayer.removeWeapon(itemName)
				

				if weaponObject.ammo and weapon.ammo > 0 then
					local ammoLabel = weaponObject.ammo.label
					pickupLabel = ('~y~%s~s~ [~g~%s~s~ %s]'):format(weapon.label, weapon.ammo, ammoLabel)
					xPlayer.showNotification(_U('threw_weapon_ammo', weapon.label, weapon.ammo, ammoLabel))
				else
					pickupLabel = ('~y~%s~s~'):format(weapon.label)
					xPlayer.showNotification(_U('threw_weapon', weapon.label))
				end

				ESX.CreatePickup('item_weapon', itemName, weapon.ammo, pickupLabel, playerId, components, weapon.tintIndex)

			end
		end
	else
		sourceXPlayer.showNotification("Ceci est un objet perm!")
	end
end)




--REPLACE ( RECHERCHER  RegisterNetEvent('esx:giveInventoryItem') et remplacer le code )

RegisterNetEvent('esx:giveInventoryItem')
AddEventHandler('esx:giveInventoryItem', function(target, type, itemName, itemCount)
	local _source = source
	local playerId = source
	local sourceXPlayer = ESX.GetPlayerFromId(playerId)
	local targetXPlayer = ESX.GetPlayerFromId(target)
	local check = exports['ArmePerm']:sv_isitemperm(itemName)

	if check == false then 

		if type == 'item_standard' then
			local sourceItem = sourceXPlayer.getInventoryItem(itemName)

			if itemCount > 0 and sourceItem.count >= itemCount then
				if targetXPlayer.canCarryItem(itemName, itemCount) then
					sourceXPlayer.removeInventoryItem(itemName, itemCount)
					targetXPlayer.addInventoryItem   (itemName, itemCount)

										sourceXPlayer.showNotification(_U('gave_item', itemCount, sourceItem.label, targetXPlayer.name))
					targetXPlayer.showNotification(_U('received_item', itemCount, sourceItem.label, sourceXPlayer.name))
				else
					sourceXPlayer.showNotification(_U('ex_inv_lim', targetXPlayer.name))
				end
			else
				sourceXPlayer.showNotification(_U('imp_invalid_quantity'))
			end
		elseif type == 'item_account' then
			if itemCount > 0 and sourceXPlayer.getAccount(itemName).money >= itemCount then
				sourceXPlayer.removeAccountMoney(itemName, itemCount)
				targetXPlayer.addAccountMoney   (itemName, itemCount)

				

				sourceXPlayer.showNotification(_U('gave_account_money', ESX.Math.GroupDigits(itemCount), Config.Accounts[itemName], targetXPlayer.name))
				targetXPlayer.showNotification(_U('received_account_money', ESX.Math.GroupDigits(itemCount), Config.Accounts[itemName], sourceXPlayer.name))
			else
				sourceXPlayer.showNotification(_U('imp_invalid_amount'))
			end
		elseif type == 'item_weapon' then
			if sourceXPlayer.hasWeapon(itemName) then
				local weaponLabel = ESX.GetWeaponLabel(itemName)

				if not targetXPlayer.hasWeapon(itemName) then
					local _, weapon = sourceXPlayer.getWeapon(itemName)
					local _, weaponObject = ESX.GetWeapon(itemName)
					itemCount = weapon.ammo

					sourceXPlayer.removeWeapon(itemName)
					targetXPlayer.addWeapon(itemName, itemCount)



					if weaponObject.ammo and itemCount > 0 then
						local ammoLabel = weaponObject.ammo.label
						sourceXPlayer.showNotification(_U('gave_weapon_withammo', weaponLabel, itemCount, ammoLabel, targetXPlayer.name))
						targetXPlayer.showNotification(_U('received_weapon_withammo', weaponLabel, itemCount, ammoLabel, sourceXPlayer.name))
						
					else
						sourceXPlayer.showNotification(_U('gave_weapon', weaponLabel, targetXPlayer.name))
						targetXPlayer.showNotification(_U('received_weapon', weaponLabel, sourceXPlayer.name))
						
					end
				else
					sourceXPlayer.showNotification(_U('gave_weapon_hasalready', targetXPlayer.name, weaponLabel))
					targetXPlayer.showNotification(_U('received_weapon_hasalready', sourceXPlayer.name, weaponLabel))
				end
			end
		elseif type == 'item_ammo' then
			if sourceXPlayer.hasWeapon(itemName) then
				local weaponNum, weapon = sourceXPlayer.getWeapon(itemName)

				if targetXPlayer.hasWeapon(itemName) then
					local _, weaponObject = ESX.GetWeapon(itemName)

					if weaponObject.ammo then
						local ammoLabel = weaponObject.ammo.label

						if weapon.ammo >= itemCount then
							sourceXPlayer.removeWeaponAmmo(itemName, itemCount)
							targetXPlayer.addWeaponAmmo(itemName, itemCount)

							

							sourceXPlayer.showNotification(_U('gave_weapon_ammo', itemCount, ammoLabel, weapon.label, targetXPlayer.name))
							targetXPlayer.showNotification(_U('received_weapon_ammo', itemCount, ammoLabel, weapon.label, sourceXPlayer.name))
						end
					end
				else
					sourceXPlayer.showNotification(_U('gave_weapon_noweapon', targetXPlayer.name))
					targetXPlayer.showNotification(_U('received_weapon_noweapon', sourceXPlayer.name, weapon.label))
				end
			end
		end
	end
end)



-- DANS VOTRE WEAPONSYNC AJOUTER CECI COTE CLIENT.LUA
-- DANS VOTRE WEAPONSYNC AJOUTER CECI COTE CLIENT.LUA
-- DANS VOTRE WEAPONSYNC AJOUTER CECI COTE CLIENT.LUA
-- DANS VOTRE WEAPONSYNC AJOUTER CECI COTE CLIENT.LUA
-- DANS VOTRE WEAPONSYNC AJOUTER CECI COTE CLIENT.LUA
-- DANS VOTRE WEAPONSYNC AJOUTER CECI COTE CLIENT.LUA


function RebuildLoadout(bool)
  
	while not PlayerData do
	 Wait(200)
	end
	
	if not bool then
	  Wait(10000)
	end
	
	local playerPed = PlayerPedId()
	
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
		  if GetAmmoInPedWeapon(playerPed, weaponHash) ~= ammo then
			SetPedAmmo(playerPed, weaponHash, ammo)
		  end
		else
		  -- Weapon is missing, give it to the player
		  GiveWeaponToPed(playerPed, weaponHash, ammo, false, false)
		end
	  elseif HasPedGotWeapon(playerPed, weaponHash, false) then
		-- Weapon doesn't belong in loadout
		RemoveWeaponFromPed(playerPed, weaponHash)
	  end
	end
  
  end


  RegisterNetEvent('weaponsync:Rebuild')
AddEventHandler('weaponsync:Rebuild', function()
 Wait(1) -- Wait a tick to make sure ESX has updated PlayerData
  PlayerData = ESX.GetPlayerData()
  RebuildLoadout()
end)