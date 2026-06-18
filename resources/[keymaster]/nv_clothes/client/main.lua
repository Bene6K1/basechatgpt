ESX = nil
local hairToggled = false

local clothingPatternMap = {
	{pattern = '^tshirt_%d+', key = 'clothes_tshirt'},
	{pattern = '^torso_%d+', key = 'clothes_torso'},
	{pattern = '^pants_%d+', key = 'clothes_pants'},
	{pattern = '^shoes_%d+', key = 'clothes_shoes'},
	{pattern = '^arms_%d+', key = 'clothes_arms'},
	{pattern = '^chains_%d+', key = 'clothes_chain'},
	{pattern = '^mask_%d+', key = 'clothes_mask'},
	{pattern = '^bags_%d+', key = 'clothes_bag'},
	{pattern = '^hat_%d+', key = 'clothes_hat'},
	{pattern = '^glasses_%d+', key = 'clothes_glasses'},
	{pattern = '^earrings_%d+', key = 'clothes_ears'},
	{pattern = '^watches_%d+', key = 'clothes_watch'},
}

local function cloneTable(tbl)
	if type(tbl) ~= 'table' then return nil end
	local copy = {}
	for k, v in pairs(tbl) do
		copy[k] = v
	end
	return copy
end

local function getClothingConfig(itemName)
	if not itemName then return nil end

	if Config.ClothingSlots[itemName] then
		return Config.ClothingSlots[itemName]
	end

	for _, entry in ipairs(clothingPatternMap) do
		if string.match(itemName, entry.pattern) then
			return Config.ClothingSlots[entry.key]
		end
	end

	return nil
end

local function resolveSkinDataFromItem(item)
	if not item or not item.name then return nil end

	local metadata = item.metadata or {}
	if metadata.skin and next(metadata.skin) then
		return cloneTable(metadata.skin)
	end

	local clothingConfig = getClothingConfig(item.name)
	if not clothingConfig then return nil end

	local sex = 'male'
	TriggerEvent('skinchanger:getSkin', function(currentSkin)
		if currentSkin and currentSkin.sex ~= nil then
			sex = (currentSkin.sex == 0) and 'male' or 'female'
		end
	end)

	local defaults = clothingConfig.defaultSkin and clothingConfig.defaultSkin[sex]
	return defaults and cloneTable(defaults) or nil
end

CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Wait(0)
	end
end)

local function useClothingItem(data, slot)
	if not data then
		return
	end
	
	local itemName = data.name or (type(slot) == 'table' and slot.name) or nil
	
	if not itemName then
		return
	end
	
	local clothingConfig = getClothingConfig(itemName)
	
	if not clothingConfig then
		return
	end
	
	local skinData = nil
	
	if data.metadata and data.metadata.skin then
		skinData = data.metadata.skin
	elseif type(slot) == 'table' and slot.metadata and slot.metadata.skin then
		skinData = slot.metadata.skin
	else
		skinData = {}
	end
	
	if not next(skinData) then
		TriggerEvent('skinchanger:getSkin', function(currentSkin)
			local sex = (currentSkin and currentSkin.sex == 0) and 'male' or 'female'
			skinData = clothingConfig.defaultSkin[sex] or {}
			
			for _, component in ipairs(clothingConfig.components) do
				local value = skinData[component.name]
				if value then
					TriggerEvent('skinchanger:change', component.name, value)
				end
			end
			
			TriggerEvent('skinchanger:getSkin', function(skin)
				TriggerServerEvent('esx_skin:save', skin)
			end)
			
			TriggerEvent('nv_clothes:updatePedPreview')
		end)
		
		return
	end
	
	for componentName, value in pairs(skinData) do
		TriggerEvent('skinchanger:change', componentName, value)
	end
	
	TriggerEvent('skinchanger:getSkin', function(skin)
		TriggerServerEvent('esx_skin:save', skin)
	end)
	
	TriggerEvent('nv_clothes:updatePedPreview')
end

local function useOutfit(data, slot)
	if not data or not data.metadata or not data.metadata.clothes then
		return
	end
	
	local outfitName = data.metadata.name or 'Tenue'
	local clothesData = data.metadata.clothes
	
	TriggerEvent('skinchanger:getSkin', function(currentSkin)
		local savedHair = {
			hair_1 = currentSkin.hair_1,
			hair_2 = currentSkin.hair_2,
			hair_color_1 = currentSkin.hair_color_1,
			hair_color_2 = currentSkin.hair_color_2
		}
		
		for _, piece in ipairs(clothesData) do
			if piece.name and piece.number then
				TriggerEvent('skinchanger:change', piece.name, piece.number)
			elseif piece.type and piece.skin then
				for componentName, value in pairs(piece.skin) do
					TriggerEvent('skinchanger:change', componentName, value)
				end
			end
		end
		
		TriggerEvent('skinchanger:getSkin', function(skin)
			TriggerEvent('skinchanger:change', 'hair_1', savedHair.hair_1)
			TriggerEvent('skinchanger:change', 'hair_2', savedHair.hair_2)
			TriggerEvent('skinchanger:change', 'hair_color_1', savedHair.hair_color_1)
			TriggerEvent('skinchanger:change', 'hair_color_2', savedHair.hair_color_2)
			
			TriggerServerEvent('esx_skin:save', skin)
		end)
	end)
	
	TriggerEvent('nv_clothes:updatePedPreview')
end

local function toggleHair(data, slot)
	TriggerEvent('skinchanger:getSkin', function(skin)
		local sex = (skin.sex == 0) and 'male' or 'female'
		local toggleConfig = Config.ToggleHair[sex]
		
		if hairToggled then
			TriggerEvent('skinchanger:change', 'hair_1', skin.hair_1)
			TriggerEvent('skinchanger:change', 'hair_2', skin.hair_2)
			hairToggled = false
			
			if exports.notif and GetResourceState('notif') == 'started' then
				exports.notif:Send('Cheveux affichés', 3, 'info')
			end
		else
			TriggerEvent('skinchanger:change', 'hair_1', toggleConfig[1])
			TriggerEvent('skinchanger:change', 'hair_2', toggleConfig[2])
			hairToggled = true
			
			if exports.notif and GetResourceState('notif') == 'started' then
				exports.notif:Send('Cheveux cachés', 3, 'info')
			end
		end
		
		TriggerEvent('skinchanger:getSkin', function(newSkin)
			TriggerServerEvent('esx_skin:save', newSkin)
		end)
		
		TriggerEvent('nv_clothes:updatePedPreview')
	end)
end

exports('useClothingItem', useClothingItem)
exports('useOutfit', useOutfit)
exports('toggleHair', toggleHair)

function ApplyNevaClothes(skinData)
	if not skinData then return end
	
	for componentName, value in pairs(skinData) do
		TriggerEvent('skinchanger:change', componentName, value)
	end
	
	TriggerEvent('skinchanger:getSkin', function(skin)
		TriggerServerEvent('esx_skin:save', skin)
	end)
	
	TriggerEvent('nv_clothes:updatePedPreview')
end

exports('ApplyClothes', ApplyNevaClothes)

RegisterNetEvent('nv_clothes:previewItem', function(item)
	if not Config.ShowPedPreview then return end
	if not PedPreview or not PedPreview.applySkinData then return end
	if not item or not item.name then return end

	local skinData = resolveSkinDataFromItem(item)

	if skinData then
		PedPreview.applySkinData(skinData)
	else
		PedPreview.update()
	end
end)

RegisterNetEvent('nv_clothes:clearPreview', function()
	if PedPreview and PedPreview.update then
		PedPreview.update()
	end
end)

