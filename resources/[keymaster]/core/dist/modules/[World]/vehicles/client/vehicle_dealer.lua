local Concess = {
    inService = false,
}

local Config = {
    Dealers = {
        ['cardealer'] = {
            label = 'Concessionnaire Automobile',
            value = 'car',
            type = 'car',
            management = vector3(-1407.2321, 6.2029, 22.325941085815),
            actions = vector3(-1407.5360107422, -995.17462158203, 6.2028660774231),
            spawn = vec3(-1404.2551269531, -972.84552001953, 6.2028679847717),
            heading = 306.41128540039,
            blips = {
                category = nil,
                position = vector3(-43.123493, -1109.828613, 26.439724),
                sprite = 523,
                display = 4,
                scale = 0.5,
                color = 0,
            },
            catalogue = {
                vec3(-1410.5891113281, -985.73773193359, 6.2028651237488),
            },
            catalogueSpawn = {
                {pos = vec3(-1415.0782470703, -977.95111083984, 6.2028722763062), heading = 130.06915283203},
            },
			pedPositions = {
				{ pos = vector3(-1410.2975, -986.1862, 6.2029), heading = 33.4820 }
			},
			cameraPositions = {
				face = {x = 0, y = 3, z = 1},
				side = {x = -3.5, y = 0, z = 1.5}
			}
        },
        
        ['motodealer'] = {
            label = 'Concessionnaire Moto',
            value = 'motorcycles',
            type = 'car',
            management = vector3(-873.64392089844, -183.2370300293, 37.837226867676),
            actions = vector3(-866.30859375, -203.33352661133, 37.837188720703),
            spawn = vector3(-863.26202392578, -182.82144165039, 37.762825012207),
            heading = 28.764806747437,
            blips = {
                category = nil,
                position = vector3(-871.12652587891, -198.19049072266, 37.837242126465),
                sprite = 348,
                display = 4,
                scale = 0.5,
                color = 0,
            },
            catalogue = vector3(-871.90881347656, -190.2784576416, 37.83723449707),
			catalogueSpawn = {pos = vector3(-870.36614990234, -186.91523742676, 37.869018554688), heading = 151.38259887695},
			ped = { pos = vector3(-871.4599, -189.9299, 37.8372), heading = 117.8521 },
			cameraPositions = {
				face = {x = 0, y = -3.5, z = 1.5},
				side = {x = -2.5, y = 0, z = 1}
			}
        },
        
        ['boatdealer'] = {
            label = 'Concessionnaire Bateau',
            value = 'boat',
            type = 'boat',
            management = vector3(-787.6028, -1350.234, 5.178339),
            actions = vector3(-805.872131, -1368.619629, 5.178345),
            spawn = vector3(-856.894348, -1378.569092, -0.474778),
            heading = 219.56527709961,
            blips = {
                category = nil,
                position = vector3(-811.447, -1349.703, 5.178345),
                sprite = 410,
                display = 4,
                scale = 0.5,
                color = 0,
            },
            catalogue = vector3(-812.4463, -1359.794, 5.178348),
			catalogueSpawn = {pos = vector3(-814.9863, -1360.8, 5.257283), heading = 202.52919006348},
			ped = { pos = vector3(-812.9274, -1359.9972, 5.1783), heading = 294.5486 },
			cameraPositions = {
				face = {x = 0, y = -6, z = 3},
				side = {x = -4.5, y = 0, z = 2}
			}
        },
        
        ['airdealer'] = {
            label = 'Concessionnaire Aérien',
            value = 'aircraft',
            type = 'aircraft',
            management = vector3(-900.6086, -2979.218, 19.8454),
            actions = vector3(-941.1509, -2954.363, 13.94509),
            spawn = vector3(-1017.146, -2973.552, 13.94877),
            heading = 58.533008575439,
            blips = {
                category = nil,
                position = vector3(-962.8713, -2989.817, 13.94509),
                sprite = 423,
                display = 4,
                scale = 0.5,
                color = 0,
            },
            catalogue = vector3(-956.3844, -2919.216, 13.95992),
			catalogueSpawn = {pos = vec3(-960.748779, -2933.915527, 13.949288), heading = 344.86596679688},
			ped = { pos = vector3(-956.0697, -2918.5361, 13.9591), heading = 150.6474 },
			cameraPositions = {
				face = {x = 0, y = -7, z = 4},
				side = {x = -5.5, y = 0, z = 3}
			}
        }
    },
    
    Categories = {
        ['cardealer'] = {
            {id = 'all', name = 'Tous', icon = 'fas fa-th'},
            {id = 'sport', name = 'Sport', icon = 'fas fa-bolt'},
            {id = 'sedan', name = 'Sedan', icon = 'fas fa-car'},
            {id = 'suv', name = 'SUV', icon = 'fas fa-truck'},
            {id = 'classic', name = 'Classic', icon = 'fas fa-star'},
            {id = 'luxury', name = 'Luxury', icon = 'fas fa-gem'},
            {id = 'compact', name = 'Compact', icon = 'fas fa-compress-arrows-alt'},
            {id = 'other', name = 'Autres', icon = 'fas fa-question'}
        },
        
        ['motodealer'] = {
            {id = 'all', name = 'Tous', icon = 'fas fa-th'},
            {id = 'sport', name = 'Sport', icon = 'fas fa-bolt'},
            {id = 'cruiser', name = 'Cruiser', icon = 'fas fa-motorcycle'},
            {id = 'other', name = 'Autres', icon = 'fas fa-question'}
        },
        
        ['boatdealer'] = {
            {id = 'all', name = 'Tous', icon = 'fas fa-th'},
            {id = 'speedboat', name = 'Speedboat', icon = 'fas fa-ship'},
            {id = 'yacht', name = 'Yacht', icon = 'fas fa-anchor'},
            {id = 'other', name = 'Autres', icon = 'fas fa-question'}
        },
        
        ['airdealer'] = {
            {id = 'all', name = 'Tous', icon = 'fas fa-th'},
            {id = 'helicopter', name = 'Hélicoptère', icon = 'fas fa-helicopter'},
            {id = 'plane', name = 'Avion', icon = 'fas fa-plane'},
            {id = 'other', name = 'Autres', icon = 'fas fa-question'}
        }
    },
    
    VehicleCategories = {
        compact = {
            'asbo', 'blista', 'brioso', 'brioso2', 'brioso3', 'club', 'dilettante', 'dilettante2', 
            'issi2', 'issi3', 'issi4', 'issi5', 'issi6', 'kanjo', 'panto', 'prairie', 'rhapsody', 'weevil'
        },
        
        sedan = {
            'asea', 'asea2', 'asterope', 'asterope2', 'cinquemila', 'cog55', 'cog552', 'cognoscenti', 
            'cognoscenti2', 'emperor', 'emperor2', 'emperor3', 'fugitive', 'glendale', 'glendale2', 
            'ingot', 'intruder', 'limo2', 'premier', 'primo', 'primo2', 'regina', 'romero', 'schafter2', 
            'schafter3', 'schafter4', 'schafter5', 'schafter6', 'stanier', 'stratum', 'stretch', 'superd', 
            'surge', 'tailgater', 'tailgater2', 'warrener', 'washington'
        },
        
        suv = {
            'baller', 'baller2', 'baller3', 'baller4', 'baller5', 'baller6', 'bjxl', 'cavalcade', 
            'cavalcade2', 'contender', 'dubsta', 'dubsta2', 'dubsta3', 'fq2', 'granger', 'granger2', 
            'habanero', 'huntley', 'landstalker', 'landstalker2', 'mesa', 'mesa2', 'mesa3', 'patriot', 
            'patriot2', 'patriot3', 'radi', 'rebla', 'rocoto', 'seminole', 'seminole2', 'serrano', 
            'squaddie', 'toros', 'xls', 'xls2'
        },
        
        sport = {
            'alpha', 'banshee', 'banshee2', 'bestiagts', 'blista2', 'blista3', 'buffalo', 'buffalo2', 
            'buffalo3', 'buffalo4', 'carbonizzare', 'comet2', 'comet3', 'comet4', 'comet5', 'comet6', 
            'coquette', 'coquette2', 'coquette3', 'coquette4', 'drafter', 'elegy', 'elegy2', 'feltzer2', 
            'flashgt', 'furoregt', 'fusilade', 'futo', 'futo2', 'gb200', 'hotring', 'imorgon', 'infernus2', 
            'italigtb', 'italigtb2', 'jester', 'jester2', 'jester3', 'jester4', 'khamelion', 'kuruma', 
            'kuruma2', 'locust', 'lynx', 'massacro', 'massacro2', 'neo', 'neon', 'ninef', 'ninef2', 
            'omnis', 'paragon', 'paragon2', 'pariah', 'penumbra', 'penumbra2', 'raiden', 'rapidgt', 
            'rapidgt2', 'rapidgt3', 'raptor', 'revolter', 'schafter3', 'schafter4', 'schafter5', 
            'schafter6', 'schlagen', 'schwarzer', 'sentinel3', 'seven70', 'specter', 'specter2', 
            'streiter', 'sultan', 'sultan2', 'sultan3', 'sultan4', 'surano', 'tampa2', 'tropos', 
            'verlierer2', 'vstr', 'zr350', 'zr380', 'zr3802', 'zr3803'
        },
        
        luxury = {
            'adder', 'autarch', 'bullet', 'cheetah', 'cyclone', 'entity2', 'entityxf', 'emerus', 
            'fmj', 'furia', 'gp1', 'infernus', 'italigtb', 'italigtb2', 'krieger', 'le7b', 'nero', 
            'nero2', 'osiris', 'penetrator', 'pfister811', 'prototipo', 'reaper', 's80', 'sc1', 
            'sheava', 't20', 'taipan', 'tempesta', 'tezeract', 'thrax', 'tigon', 'turismor', 
            'tyrant', 'tyrus', 'vacca', 'vagner', 'vigilante', 'visione', 'voltic', 'voltic2', 
            'xa21', 'zentorno', 'zorrusso'
        },
        
        classic = {
            'monroe', 'stinger', 'stingergt'
        },
        
        cruiser = {
            'bagger', 'bobber', 'chimera', 'daemon', 'daemon2', 'faggio', 'faggio2', 'faggio3', 
            'sovereign', 'avarus', 'bagger2', 'bobber2', 'chimera2', 'cliffhanger2', 'daemon3', 
            'defiler2', 'diablous3', 'double2', 'enduro2', 'faggio4', 'gargoyle2', 'hakuchou3', 
            'hexer2', 'innovation2', 'lectro2', 'nemesis2', 'pcj2', 'ruffian2', 'sanchez3', 
            'sovereign2', 'thrust2', 'vader2', 'vindicator2', 'vortex3', 'wolfsbane3', 'zombiea3', 
            'zombieb3', 'fcr3', 'esskey2', 'manchez3', 'reever2', 'shinobi2', 'stryder2'
        },
        
        speedboat = {
            'dinghy', 'dinghy2', 'dinghy3', 'dinghy4', 'jetmax', 'seashark', 'seashark2', 'seashark3', 
            'speeder', 'speeder2', 'squalo', 'submersible', 'submersible2', 'suntrap', 'tropic', 'tropic2',
            'longfin', 'kosatka', 'patrolboat', 'technical3', 'technical2', 'technical', 'insurgent3',
            'insurgent2', 'insurgent', 'nightshark', 'menacer', 'dune3', 'dune2', 'dune', 'brawler',
            'kalahari', 'rebel', 'rebel2', 'sandking', 'sandking2', 'trophytruck', 'trophytruck2',
            'kamacho', 'riata', 'caracara', 'caracara2', 'dubsta3', 'marshall', 'monster', 'monster3',
            'monster4', 'monster5', 'phantom3', 'phantom2', 'phantom', 'hauler', 'hauler2', 'packer',
            'mule', 'mule2', 'mule3', 'mule4', 'mule5', 'pounder', 'benson', 'boxville', 'boxville2',
            'boxville3', 'boxville4', 'boxville5', 'burrito', 'burrito2', 'burrito3', 'burrito4',
            'burrito5', 'minivan', 'minivan2', 'paradise', 'rumpo', 'rumpo2', 'rumpo3', 'speedo',
            'speedo2', 'speedo4', 'surfer', 'surfer2', 'taco', 'youga', 'youga2', 'youga3', 'youga4'
        },
        
        yacht = {
            'marquis', 'predator', 'toro', 'toro2', 'yacht', 'yacht2', 'superyacht', 'luxury_yacht',
            'yacht_mega', 'yacht_luxury', 'yacht_super', 'yacht_elite', 'yacht_premium'
        },
        
        helicopter = {
            'buzzard', 'buzzard2', 'cargobob', 'cargobob2', 'cargobob3', 'cargobob4', 'frogger', 
            'frogger2', 'havok', 'hunter', 'maverick', 'polmav', 'savage', 'seasparrow', 'seasparrow2', 
            'seasparrow3', 'skylift', 'supervolito', 'supervolito2', 'swift', 'swift2', 'valkyrie', 
            'valkyrie2', 'volatus', 'akula', 'annihilator', 'annihilator2', 'buzzard3', 'cargobob5',
            'conada', 'crusader', 'defender', 'hunter2', 'khanjali', 'khanjali2', 'lazer2', 'oppressor',
            'oppressor2', 'oppressor3', 'oppressor4', 'oppressor5', 'patrolboat', 'patrolboat2',
            'rhino', 'rhino2', 'savage2', 'seasparrow4', 'seasparrow5', 'skylift2', 'supervolito3',
            'swift3', 'valkyrie3', 'volatus2', 'wastelander', 'wastelander2'
        },
        
        plane = {
            'alphaz1', 'avenger', 'avenger2', 'besra', 'blimp', 'blimp2', 'blimp3', 'bombushka', 
            'cargoplane', 'cuban800', 'dodo', 'duster', 'howard', 'hydra', 'jet', 'lazer', 'luxor', 
            'luxor2', 'mammatus', 'miljet', 'mogul', 'molotok', 'nimbus', 'nokota', 'pyro', 'rogue', 
            'seabreeze', 'shamal', 'starling', 'stunt', 'titan', 'tula', 'velum', 'velum2', 'vestra', 
            'volatol', 'alkonost', 'annihilator3', 'b11', 'b11_strikeforce', 'besra2', 'bombushka2',
            'cargoplane2', 'cuban8002', 'dodo2', 'duster2', 'howard2', 'hydra2', 'jet2', 'lazer3',
            'luxor3', 'mammatus2', 'miljet2', 'mogul2', 'molotok2', 'nimbus2', 'nokota2', 'pyro2',
            'rogue2', 'seabreeze2', 'shamal2', 'starling2', 'stunt2', 'titan2', 'tula2', 'velum3',
            'vestra2', 'volatol2', 'alkonost2', 'annihilator4', 'b11_2', 'besra3', 'bombushka3'
        }
    },
    
    General = {
        maxDistance = 10.0,
        defaultHeading = 90.0,
        vehicleColors = {255, 255},
        freezeVehicle = true,
        enableCamera = true,
        enableRotation = false
    }
}

local MAX_DISTANCE = Config.General.maxDistance

local VehicleDealer = {
    data = {},
    position = {},
    CategorieList = {},
    VehicleListCategorieList = {},
    VehicleIndex = 1,
    VehicleIndexData = {'Sortir', 'Vendre le véhicule'},
    LastVehicle = nil,
    LastVehicle2 = nil,
    Price = 0,
    label = nil,
}

for dealerId, dealerData in pairs(Config.Dealers) do
    VehicleDealer.data[dealerId] = {
        label = dealerData.label,
        value = dealerData.value,
        type = dealerData.type
    }
    
    VehicleDealer.position[dealerId] = {
        management = dealerData.management,
        actions = dealerData.actions,
        spawn = dealerData.spawn,
        heading = dealerData.heading,
        blips = dealerData.blips,
        catalogue = dealerData.catalogue,
        catalogueSpawn = dealerData.catalogueSpawn
    }
end

local CardealerUI = {
    isOpen = false,
    currentJob = nil,
    currentPosition = nil,
    lastVehicle = nil,
    lastVehicle2 = nil,
    price = 0,
    label = nil,
    vehicles = {},
    categories = {},
    filteredVehicles = {},
    camera = nil,
	cameraMode = 1, -- 1: face, 2: côté
    cameraPositions = {}
}

function CardealerUI:open(job, position)
    if self.isOpen then return end
    
    self.isOpen = true
    self.currentJob = job
    self.currentPosition = position or VehicleDealer.position[job].catalogueSpawn.pos
    
    if Config.Dealers[job] and Config.Dealers[job].cameraPositions then
        self.cameraPositions = Config.Dealers[job].cameraPositions
    else
		self.cameraPositions = {
			face = {x = 0, y = -4, z = 2},
			side = {x = -3, y = 0, z = 1.5}
		}
    end
    
    SetNuiFocus(true, true)
    DisplayRadar(false)
    DisplayHud(false)
    
    pcall(function() TriggerEvent('hud:hide') end)
    pcall(function() TriggerEvent('lyozz:Hud:StateStatus', false) end)
    pcall(function() TriggerEvent('zstatus:hide') end)
    pcall(function() TriggerEvent('zstatus:toggle', false) end)
    pcall(function() exports.zhud:toggle(false) end)
    pcall(function() exports.zstatus:toggle(false) end)
    pcall(function() exports.core_nui:SetHudVisible(false) end)
    
    CreateThread(function()
        while self.isOpen do
            for i = 0, 22 do HideHudComponentThisFrame(i) end
            Wait(0)
        end
    end)
    
    self:loadCategories()
end

function CardealerUI:close()
    if not self.isOpen then return end
    
    self.isOpen = false
    SetNuiFocus(false, false)
    DisplayRadar(true)
    DisplayHud(true)
    
    pcall(function() TriggerEvent('hud:show') end)
    pcall(function() TriggerEvent('lyozz:Hud:StateStatus', true) end)
    pcall(function() TriggerEvent('zstatus:show') end)
    pcall(function() TriggerEvent('zstatus:toggle', true) end)
    pcall(function() exports.zhud:toggle(true) end)
    pcall(function() exports.zstatus:toggle(true) end)
    pcall(function() exports.core_nui:SetHudVisible(true) end)
    
    SendNUIMessage({ action = "close" })
    self:cleanupVehicle()
    
    self.currentJob = nil
    self.currentPosition = nil
    self.vehicles = {}
    self.categories = {}
    self.filteredVehicles = {}
    self.cameraMode = 1
end

function CardealerUI:loadCategories()
    ESX.TriggerServerCallback('sunny:vehicle_dealer:sendCategorieList', function(cb)
        if cb then
            self.categories = cb
            self:loadVehicles()
        end
    end, VehicleDealer.data[self.currentJob].value)
end

function CardealerUI:loadVehicles()
    local allVehicles = {}
    local loadedCategories = 0
    local totalCategories = #self.categories
    
    if totalCategories == 0 then
        self:openUI()
        return
    end
    
    for k, category in pairs(self.categories) do
        ESX.TriggerServerCallback('sunny:vehicle_dealer:sendVehicleWithCategorie', function(vehicles)
            if vehicles then
                for _, vehicle in pairs(vehicles) do
                    table.insert(allVehicles, {
                        model = vehicle.model,
                        name = vehicle.name,
                        price = math.floor(vehicle.price / 100 * 135),
                        category = self:getVehicleCategory(vehicle.model)
                    })
                end
            end
            
            loadedCategories = loadedCategories + 1
            if loadedCategories >= totalCategories then
                self.vehicles = allVehicles
                self.filteredVehicles = allVehicles
                self:openUI()
            end
        end, category.name)
    end
end

function CardealerUI:openUI()
    local availableCategories = self:getAvailableCategories()
    SendNUIMessage({
        action = "open",
        vehicles = self.vehicles,
        currentRental = nil,
        playerBankBalance = 0,
        categories = availableCategories
    })
end

function CardealerUI:getAvailableCategories()
    if Config.Categories[self.currentJob] then
        return Config.Categories[self.currentJob]
    else
        return {
            {id = 'all', name = 'Tous', icon = 'fas fa-th'},
            {id = 'other', name = 'Autres', icon = 'fas fa-question'}
        }
    end
end

function CardealerUI:getVehicleCategory(model)
    for category, vehicles in pairs(Config.VehicleCategories) do
        for _, vehicleModel in pairs(vehicles) do
            if model == vehicleModel then
                return category
            end
        end
    end
    
    return 'other'
end


function CardealerUI:previewVehicle(vehicle)
    self:cleanupVehicle()
    
    Wait(500)
    
    if not ESX.Game.IsSpawnPointClear(self.currentPosition, 2) then
        CreateThread(function()
            ESX.Game.DeleteVehicle(self.lastVehicle)
        end)
        return
    end
    
    Wait(500)
    
    local heading = Config.General.defaultHeading
    if VehicleDealer.position[self.currentJob] and VehicleDealer.position[self.currentJob].catalogueSpawn then
        if type(VehicleDealer.position[self.currentJob].catalogueSpawn) == "table" and VehicleDealer.position[self.currentJob].catalogueSpawn.heading then
            heading = VehicleDealer.position[self.currentJob].catalogueSpawn.heading
        elseif type(VehicleDealer.position[self.currentJob].catalogueSpawn) == "table" and VehicleDealer.position[self.currentJob].catalogueSpawn[1] and VehicleDealer.position[self.currentJob].catalogueSpawn[1].heading then
            heading = VehicleDealer.position[self.currentJob].catalogueSpawn[1].heading
        end
    end
    
    ESX.Game.SpawnLocalVehicle(vehicle.model, self.currentPosition, heading, function(veh)
        if Config.General.freezeVehicle then
            FreezeEntityPosition(veh, true)
        end
        SetVehicleColours(veh, Config.General.vehicleColors[1], Config.General.vehicleColors[2])
        self.lastVehicle = veh
        self.lastVehicle2 = vehicle.model
        self.price = vehicle.price
        self.label = vehicle.name
        
        self:setupCamera()
    end)
end

function CardealerUI:setupCamera()
    if not self.lastVehicle or not DoesEntityExist(self.lastVehicle) then return end
    
    local vehiclePos = GetEntityCoords(self.lastVehicle)
    local vehicleHeading = GetEntityHeading(self.lastVehicle)
    
    self.camera = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
    
    local pos = self.cameraPositions.face
    local camPos = vector3(
        vehiclePos.x + pos.x,
        vehiclePos.y + pos.y,
        vehiclePos.z + pos.z
    )
    
    SetCamCoord(self.camera, camPos.x, camPos.y, camPos.z)
	local rad = math.rad(vehicleHeading)
	local cos = math.cos(rad)
	local sin = math.sin(rad)
	local rightX = -sin
	local rightY = cos
	local lookOffset = -0.8
	local targetX = vehiclePos.x + rightX * lookOffset
	local targetY = vehiclePos.y + rightY * lookOffset
	PointCamAtCoord(self.camera, targetX, targetY, vehiclePos.z)
    SetCamActive(self.camera, true)
    RenderScriptCams(true, true, 1000, true, true)
end

function CardealerUI:changeCamera(mode)
    if not self.camera or not self.lastVehicle or not DoesEntityExist(self.lastVehicle) then return end
    
	if mode == 3 then mode = 1 end
	self.cameraMode = mode
    local vehiclePos = GetEntityCoords(self.lastVehicle)
    local vehicleHeading = GetEntityHeading(self.lastVehicle)
    local pos = nil
    
    if mode == 1 then
        pos = self.cameraPositions.face
    elseif mode == 2 then
        pos = self.cameraPositions.side
    else
        return
    end
    
    local rad = math.rad(vehicleHeading)
    local cos = math.cos(rad)
    local sin = math.sin(rad)
    
    local camPos = vector3(
        vehiclePos.x + (pos.x * cos - pos.y * sin),
        vehiclePos.y + (pos.x * sin + pos.y * cos),
        vehiclePos.z + pos.z
    )
    
	SetCamCoord(self.camera, camPos.x, camPos.y, camPos.z)
	if mode == 1 then
		local rad = math.rad(vehicleHeading)
		local cos = math.cos(rad)
		local sin = math.sin(rad)
		local rightX = -sin
		local rightY = cos
		local lookOffset = -0.8
		local targetX = vehiclePos.x + rightX * lookOffset
		local targetY = vehiclePos.y + rightY * lookOffset
		PointCamAtCoord(self.camera, targetX, targetY, vehiclePos.z)
	else
		PointCamAtEntity(self.camera, self.lastVehicle, 0.0, 0.0, 0.0, true)
	end
end

function CardealerUI:cleanupCamera()
    if self.camera then
        RenderScriptCams(false, true, 1000, true, true)
        DestroyCam(self.camera, false)
        self.camera = nil
    end
end

function CardealerUI:cleanupVehicle()
    self:cleanupCamera()
    if self.lastVehicle and DoesEntityExist(self.lastVehicle) then
        DeleteEntity(self.lastVehicle)
    end
    self.lastVehicle = nil
    self.lastVehicle2 = nil
    self.price = 0
    self.label = nil
end

RegisterNUICallback('close', function(data, cb)
    CardealerUI:close()
    cb({})
end)

RegisterNUICallback('previewVehicle', function(data, cb)
    if data.model and data.vehicleData then
        CardealerUI:previewVehicle(data.vehicleData)
    end
    cb({})
end)

RegisterNUICallback('changeCamera', function(data, cb)
    if data.mode then
        CardealerUI:changeCamera(data.mode)
    end
    cb({})
end)

RegisterNUICallback('selectCategory', function(data, cb)
    cb({})
end)

RegisterNUICallback('playSound', function(data, cb)
    PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
    cb({})
end)

function VehicleDealer:openConcessMenu(job)
    local main = nil
    if job == 'boatdealer' then
        main = RageUI.CreateMenu('', 'Actions Disponibles')
    elseif job == 'cardealer' then
        main = RageUI.CreateMenu('', 'Actions Disponibles')
    elseif job == 'motodealer' then
        main = RageUI.CreateMenu('', 'Actions Disponibles')
    elseif job == 'airdealer' then
        main = RageUI.CreateMenu('', 'Actions Disponibles')
    end
    local categorieList = RageUI.CreateSubMenu(main, '', 'Actions Disponibles')
    local vehicleListWithCategorie = RageUI.CreateSubMenu(categorieList, '', 'Actions Disponibles')

    vehicleListWithCategorie.Closed = function()
        DeleteEntity(VehicleDealer.LastVehicle)
    end

    RageUI.Visible(main, not RageUI.Visible(main))
    -- FreezeEntityPosition(PlayerPedId(), true)
    while main do 
        Wait(1)
        local playerPed = PlayerPedId()
        local playerPos = GetEntityCoords(playerPed)
        local dx = playerPos.x - VehicleDealer.position[job].actions.x
        local dy = playerPos.y - VehicleDealer.position[job].actions.y
        local dz = playerPos.z - VehicleDealer.position[job].actions.z
        local distance = math.sqrt(dx * dx + dy * dy + dz * dz)

        if distance > MAX_DISTANCE then
            ESX.ShowNotification("Vous vous êtes trop éloigné du point de vente.")
            RageUI.CloseAll()
            main = nil
            DeleteEntity(VehicleDealer.LastVehicle)
            return
        end

        RageUI.IsVisible(main, function()
            RageUI.Button('Liste des catégories', nil, {}, true, {
                onSelected = function()
                    ESX.TriggerServerCallback('sunny:vehicle_dealer:sendCategorieList', function(cb)
                        if cb then
                            VehicleDealer.CategorieList = cb

                            RageUI.Visible(categorieList, true)
                        end
                    end, VehicleDealer.data[job].value)
                end
            })
        end)

        RageUI.IsVisible(categorieList, function()
            for k,v in pairs(VehicleDealer.CategorieList) do
                RageUI.Button(('%s %s'):format('Catégorie', v.label), nil, {RightLabel = '>'}, true, {
                    onSelected = function()
                        ESX.TriggerServerCallback('sunny:vehicle_dealer:sendVehicleWithCategorie', function(cb)
                            if cb then
                                VehicleDealer.VehicleListCategorieList = cb
                                RageUI.Visible(vehicleListWithCategorie, true)
                            end
                        end, v.name)
                    end
                })
            end
        end)

        RageUI.IsVisible(vehicleListWithCategorie, function()
            for k,v in pairs(VehicleDealer.VehicleListCategorieList) do
                RageUI.List(('%s'):format(v.name), VehicleDealer.VehicleIndexData, VehicleDealer.VehicleIndex, nil, {}, true, {
                    onActive = function()
                        RageUI.Info('Informations Véhicule', {'Prix d\'usine', 'Prix à la vente'}, {('~y~%s$~s~'):format(ESX.Math.GroupDigits(v.price/100*100)), ('~y~%s$~s~'):format(ESX.Math.GroupDigits(v.price/100*135))})
                    end, 
                    onListChange = function(Index)
                        VehicleDealer.VehicleIndex = Index
                    end,
                    onSelected = function()
                        if VehicleDealer.VehicleIndex == 1 then
                            DeleteEntity(VehicleDealer.LastVehicle)

                            Wait(500)

                            if not ESX.Game.IsSpawnPointClear(VehicleDealer.position[job].spawn, 2) then
                                CreateThread(function()
                                    ESX.Game.DeleteVehicle(VehicleDealer.LastVehicle)
                                end)

                                return
                            end 

                            Wait(500)

                            ESX.Game.SpawnVehicle(v.model, VehicleDealer.position[job].spawn, VehicleDealer.position[job].heading, function(vehicle)
                                FreezeEntityPosition(vehicle, true)
                                SetVehicleColours(vehicle, 255, 255)
                                VehicleDealer.LastVehicle = vehicle
                                VehicleDealer.LastVehicle2 = v.model
                                VehicleDealer.Price = tonumber(v.price)
                                VehicleDealer.label = v.name
                            end)
                        elseif VehicleDealer.VehicleIndex == 2 then
                            if VehicleDealer.LastVehicle == nil then return ESX.ShowNotification('Aucun véhicule de sortie') end
                            local player, distance = ESX.Game.GetClosestPlayer()
                            if distance == -1 or distance > 3 then return ESX.ShowNotification('Aucun joueur proche') end

                            ESX.ShowNotification('~g~Facture envoyée avec succès~s~')
                            
                                
                            ESX.TriggerServerCallback('sunny:vehicle_dealer:sendBill', function(cb)

                            end, v.price, v.price, GetPlayerServerId(player))
                        end
                    end
                })
            end
        end)

        if not RageUI.Visible(main) and not RageUI.Visible(categorieList) and not RageUI.Visible(vehicleListWithCategorie) then
            main = RMenu:DeleteType('main')
            DeleteEntity(VehicleDealer.LastVehicle)
        end
    end
end

RegisterNetEvent('sunny:vehicle_dealer:spawnVehicle', function(player)
    CreateThread(function()
        ESX.Game.DeleteVehicle(VehicleDealer.LastVehicle)

        TriggerServerEvent('sunny:admin:delVeh', VehicleDealer.LastVehicle)

        Wait(1000)

        VehicleDealer.LastVehicle = nil
        ESX.Game.SpawnVehicle(VehicleDealer.LastVehicle2, VehicleDealer.position[ESX.PlayerData.job.name].spawn, VehicleDealer.position[ESX.PlayerData.job.name].heading, function(vehicle)
            VehicleDealer.LastVehicle2 = nil

            local plate = GeneratePlate()
            local veh = lib.getVehicleProperties(vehicle)
            veh.plate = plate
            SetVehicleNumberPlateText(vehicle, plate)

            local vehicleData = { 
                vehicle = veh,
                plate = veh.plate,
                label = VehicleDealer.label,
                price = VehicleDealer.Price,
                type = VehicleDealer.data[ESX.PlayerData.job.name].type
            }

            TriggerServerEvent('sunny:vehicle_dealer:sendVehicleKey', player, vehicleData)
        end)

        ESX.ShowNotification('💲 La personne a bien payé la ~g~facture~s~')
    end)
end)

RegisterNetEvent('sunny:vehicle_dealer:giveKeys', function(plate)
    CreateThread(function()
        Wait(500)
        
        local attempts = 0
        while (not Bridge or not Bridge.CarKeys or not Bridge.CarKeys.CreateKeys) and attempts < 20 do
            Wait(100)
            attempts = attempts + 1
        end
        
        if Bridge and Bridge.CarKeys and Bridge.CarKeys.CreateKeys then
            local success = pcall(function()
                Bridge.CarKeys.CreateKeys(plate, nil)
            end)
            
            if not success then
                local vehicles = GetAllVehicles()
                for _, vehicle in ipairs(vehicles) do
                    if DoesEntityExist(vehicle) then
                        local vehiclePlate = GetVehicleNumberPlateText(vehicle)
                        if vehiclePlate == plate then
                            pcall(function()
                                Bridge.CarKeys.CreateKeys(plate, vehicle)
                            end)
                            break
                        end
                    end
                end
            end
        end
    end)
end)

function VehicleDealer:openIntercationMenu(job)
    local main = nil
    if job == 'boatdealer' then
        main = RageUI.CreateMenu('', 'Actions Disponibles')
    elseif job == 'cardealer' then
        main = RageUI.CreateMenu('', 'Actions Disponibles')
    elseif job == 'motodealer' then
        main = RageUI.CreateMenu('', 'Actions Disponibles')
    elseif job == 'airdealer' then
        main = RageUI.CreateMenu('', 'Actions Disponibles')
    end
    
    RageUI.Visible(main, not RageUI.Visible(main))
    
    while main do 
        Wait(1)
        RageUI.IsVisible(main, function()
            RageUI.Checkbox('Statut de l\'entreprise', 'Quand cette case est cochée votre ENTREPRISE est notée comme ouverte', Society.List[ESX.PlayerData.job.name].state, {}, {
                onChecked = function()
                    TriggerServerEvent('sunny:jobs:updateSocietyStatus', true)
                end,
                onUnChecked = function()
                    TriggerServerEvent('sunny:jobs:updateSocietyStatus', false)
                end
            })
            
            RageUI.Checkbox('Service', nil, Concess.inService, {}, {
                onChecked = function()
                    Concess.inService = true
                    TriggerServerEvent('sunny:concess:service')
                end,
                onUnChecked = function()
                    Concess.inService = false
                    TriggerServerEvent('sunny:concess:service')
                end
            })
            
            if Concess.inService then
                RageUI.Button('Faire une facture', nil, {}, true, {
                    onSelected = function()
                        local player, distance = ESX.Game.GetClosestPlayer()
                        if distance == -1 or distance > 3 then 
                            return ESX.ShowNotification('Personne aux alentours') 
                        end
                        
                        KeyboardUtils.use('Montant', function(data)
                            local data = tonumber(data)
                            if data == nil or data <= 0 then return end
                            TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(player), ('society_%s'):format(job), VehicleDealer.data[job].label, data)
                        end)
                    end
                })
                
                RageUI.Line()
                
                RageUI.Button('Faire une annonce personnaliser', nil, {}, true, {
                    onSelected = function()
                        local jobName = ESX.PlayerData.job.name
                        KeyboardUtils.use('Contenu', function(msg)
                            if msg == nil then return end
                            TriggerServerEvent('monjob:annoncer', msg, jobName)
                        end)
                    end
                })
            end
        end)
        
        if not RageUI.Visible(main) then
            main = RMenu:DeleteType('main')
        end
    end
end

local catalogueSearch = nil
local catalogueVehiclesList = {}

function VehicleDealer:openCatalogue(job, position)
    if position == nil then
        position = VehicleDealer.position[job].catalogueSpawn.pos
    end
    
    CardealerUI:open(job, position)
end


CreateThread(function()
    while not ESXLoaded do Wait(1) end

    for k,v in pairs(VehicleDealer.data) do
        RegisterCommand(k, function()
            if ESX.PlayerData.job.name == k then
                VehicleDealer:openIntercationMenu(k)
            end
        end)

        RegisterKeyMapping(k, ('Menu Concess (%s)'):format(v.label),'keyboard', 'F6')

        AddZones(k, {
            Position = VehicleDealer.position[k].actions,
            Dist = 10,
            Public = false,
            Job = {[k] = true},
            Job2 = {},
            GradesJob = {},
            InVehicleDisable = true,
            Blip = {},
            ActionText = 'CONCESSIONNAIRE',
            Action = function()
                VehicleDealer:openConcessMenu(k)
            end
        })
        -- AddZones(k..'_boss', {
        --     Position = VehicleDealer.position[k].management,
        --     Dist = 10,
        --     Public = false,
        --     Job = {[k] = true},
        --     Job2 = {},
        --     GradesJob = {['boss'] = true},
        --     GradesJobRequire = true,
        --     InVehicleDisable = true,
        --     Blip = {},
        --     ActionText = 'CONCESSIONNAIRE',
        --     Action = function()
        --         VehicleDealer:openBossMenu(k)
        --     end
        -- })
    end

   -- for k,v in pairs(VehicleDealer.data) do
    --    if VehicleDealer.position[k] == nil then goto continue end

     --   ESX.addBlips({
     --       name = ("%s"):format(k),
    --        label = v.label,
    ---        category = nil,
    ----        position = VehicleDealer.position[k].blips.position,
    --        sprite = VehicleDealer.position[k].blips.sprite,
    ---        display = VehicleDealer.position[k].blips.display,
   --         scale = VehicleDealer.position[k].blips.scale,
    --        color = VehicleDealer.position[k].blips.color,
    --    })

    --    ::continue::
 --   end

	for k,v in pairs(VehicleDealer.data) do
		if type(VehicleDealer.position[k].catalogue) == "table" then
			for i,p in pairs(VehicleDealer.position[k].catalogue) do
				local heading = 0.0
				local pedPos = p
				if Config.Dealers[k] and Config.Dealers[k].pedPositions and Config.Dealers[k].pedPositions[i] then
					local cfg = Config.Dealers[k].pedPositions[i]
					if cfg.pos then pedPos = cfg.pos end
					if cfg.heading then heading = cfg.heading end
				elseif VehicleDealer.position[k].catalogueSpawn and VehicleDealer.position[k].catalogueSpawn[i] and VehicleDealer.position[k].catalogueSpawn[i].heading then
					heading = VehicleDealer.position[k].catalogueSpawn[i].heading
				end
				_PEDS.addPed(('dealer_catalogue_%s_%s'):format(k, i), {
					model = 'a_m_y_smartcaspat_01',
					position = vector3(pedPos.x, pedPos.y, pedPos.z),
					heading = heading,
					scenario = {
						active = true,
						name = 'WORLD_HUMAN_CLIPBOARD',
						count = 0,
					},
					weapon = {
						active = false,
						weaponName = 'musket',
					},
					floatingText = {
						active = true,
						text = VehicleDealer.data[k].label or 'Concession',
						color = 34,
					},
				})
				AddZones('c_'..i, {
					Position = p,
					Dist = 10,
					Public = true,
					Job = nil,
					Job2 = nil,
					GradesJob = nil,
					InVehicleDisable = true,
					Blip = {},
					ActionText = 'CONCESSIONNAIRE',
					Action = function()
						VehicleDealer:openCatalogue(k, VehicleDealer.position[k].catalogueSpawn[i].pos)
					end
				})
			end
		else
			local p = VehicleDealer.position[k].catalogue
			local heading = VehicleDealer.position[k].heading or 0.0
			local pedPos = p
			if Config.Dealers[k] and Config.Dealers[k].ped then
				local cfg = Config.Dealers[k].ped
				if cfg.pos then pedPos = cfg.pos end
				if cfg.heading then heading = cfg.heading end
			end
			_PEDS.addPed(('dealer_catalogue_%s'):format(k), {
				model = 'a_m_y_smartcaspat_01',
				position = vector3(pedPos.x, pedPos.y, pedPos.z),
				heading = heading,
				scenario = {
					active = true,
					name = 'WORLD_HUMAN_CLIPBOARD',
					count = 0,
				},
				weapon = {
					active = false,
					weaponName = 'musket',
				},
				floatingText = {
					active = true,
					text = VehicleDealer.data[k].label or 'Concession',
					color = 34,
				},
			})
			AddZones('c_'..k, {
				Position = VehicleDealer.position[k].catalogue,
				Dist = 10,
				Public = true,
				Job = nil,
				Job2 = nil,
				GradesJob = nil,
				InVehicleDisable = true,
				Blip = {},
				ActionText = 'CONCESSIONNAIRE',
				Action = function()
					VehicleDealer:openCatalogue(k)
				end
			})
		end
	end
end)

RegisterNetEvent('sunny:vehicle_dealer:sendBill', function(vendeur, price2, price)
    ESX.ShowNotification(('Vous avez recus une facture (~y~%s$~s~)\n\n~g~Y~s~ pour accepter\n~r~N~s~ pour refuser'):format(ESX.Math.GroupDigits(price/100*135)))

    CreateThread(function()
        local time = 20000
        while time > 0 do 
            Wait(1)

            if IsControlJustPressed(0, 246) then
                time = 0
                TriggerServerEvent('sunny:vehicle_dealer_paybill', vendeur, price, price2)
                break
            end

            if IsControlJustPressed(0, 306) then
                time = 0
                TriggerServerEvent('sunny:vehicle_dealer_refuseBill', vendeur)
                break
            end

            time = time - 1

            if time <= 0 then
                break
            end
        end
    end)
end)
