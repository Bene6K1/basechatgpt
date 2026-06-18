local densitySettings = Config.Density

local function UpdateDensity(settings)
    densitySettings = settings
end

RegisterNetEvent('es_extended:updateDensity')
AddEventHandler('es_extended:updateDensity', UpdateDensity)

Citizen.CreateThread(function()
    while true do
        SetPedDensityMultiplierThisFrame(densitySettings.Peds)
        SetVehicleDensityMultiplierThisFrame(densitySettings.Vehicles)
        SetParkedVehicleDensityMultiplierThisFrame(densitySettings.ParkedVehicles)
        SetRandomVehicleDensityMultiplierThisFrame(densitySettings.RandomVehicles)

        SetCreateRandomCops(densitySettings.EnableCops)
        SetCreateRandomCopsNotOnScenarios(densitySettings.EnableCops)
        SetCreateRandomCopsOnScenarios(densitySettings.EnableCops)

        Citizen.Wait(100)
    end
end)

local bannedVehicles = {
    "rhino", "apc", "halftrack", "dune3", "technical", "technical2", "technical3",
    "insurgent", "insurgent2", "insurgent3", "kuruma2", "barrage", "chernobog",
    "khanjali", "minitank", "scarab", "scarab2", "scarab3",
    "police", "police2", "police3", "police4", "policeb", "policeold1", "policeold2",
    "policet", "riot", "riot2", "fbi", "fbi2", "sheriff", "sheriff2", "pranger", "polmav",
    "buzzard", "buzzard2", "hunter", "savage", "valkyrie", "valkyrie2", "akula", "annihilator",
    "cargobob", "cargobob2", "cargobob3", "cargobob4", "seasparrow", "seasparrow2", "seasparrow3",
    "hydra", "lazer", "strikeforce", "b11", "molotok", "nokota", "pyro", "rogue", "starling",
    "titan", "bombushka", "alkonost", "volatol", "luxor", "luxor2", "shamal", "miljet",
    "jet", "besra", "dodo", "howard", "alphaz1", "nimbus", "velum", "velum2", "vestra",
    "cuban800", "duster", "mallard", "stunt", "frogger", "frogger2", "maverick",
    "supervolito", "supervolito2", "volatus", "swift", "swift2"
}

Citizen.CreateThread(function()
    for _, vehicle in ipairs(bannedVehicles) do
        SetVehicleModelIsSuppressed(GetHashKey(vehicle), true)
    end
    
    -- while true do
    --     SetAmbientVehicleRangeMultiplierThisFrame(0.0)
    --     SetParkedVehicleDensityMultiplierThisFrame(0.0)
    --     SetRandomVehicleDensityMultiplierThisFrame(0.0)
        
    --     SetCreateRandomCops(false)
    --     SetCreateRandomCopsNotOnScenarios(false) 
    --     SetCreateRandomCopsOnScenarios(false)
        
    --     Citizen.Wait(0)
    -- end
end)

AddEventHandler('entityCreated', function(entity)
    Citizen.Wait(0)
    if IsEntityAVehicle(entity) then
        local model = GetEntityModel(entity)
        local vehicleClass = GetVehicleClass(entity)
        
        local bannedVehicles = {
            GetHashKey("rhino"), GetHashKey("apc"), GetHashKey("halftrack"), GetHashKey("dune3"),
            GetHashKey("technical"), GetHashKey("technical2"), GetHashKey("technical3"),
            GetHashKey("insurgent"), GetHashKey("insurgent2"), GetHashKey("insurgent3"),
            GetHashKey("kuruma2"), GetHashKey("barrage"), GetHashKey("chernobog"),
            GetHashKey("khanjali"), GetHashKey("minitank"), GetHashKey("scarab"),
            GetHashKey("scarab2"), GetHashKey("scarab3"),
            
            GetHashKey("police"), GetHashKey("police2"), GetHashKey("police3"), GetHashKey("police4"),
            GetHashKey("policeb"), GetHashKey("policeold1"), GetHashKey("policeold2"), GetHashKey("policet"),
            GetHashKey("riot"), GetHashKey("riot2"), GetHashKey("fbi"), GetHashKey("fbi2"),
            GetHashKey("sheriff"), GetHashKey("sheriff2"), GetHashKey("pranger"), GetHashKey("polmav"),
            
            GetHashKey("buzzard"), GetHashKey("buzzard2"), GetHashKey("hunter"), GetHashKey("savage"),
            GetHashKey("valkyrie"), GetHashKey("valkyrie2"), GetHashKey("akula"), GetHashKey("annihilator"),
            GetHashKey("cargobob"), GetHashKey("cargobob2"), GetHashKey("cargobob3"), GetHashKey("cargobob4"),
            GetHashKey("seasparrow"), GetHashKey("seasparrow2"), GetHashKey("seasparrow3"),
            
            GetHashKey("hydra"), GetHashKey("lazer"), GetHashKey("strikeforce"), GetHashKey("b11"),
            GetHashKey("molotok"), GetHashKey("nokota"), GetHashKey("pyro"), GetHashKey("rogue"),
            GetHashKey("starling"), GetHashKey("titan"), GetHashKey("bombushka"), GetHashKey("alkonost"),
            GetHashKey("volatol"),
            
            GetHashKey("luxor"), GetHashKey("luxor2"), GetHashKey("shamal"), GetHashKey("miljet"),
            GetHashKey("jet"), GetHashKey("besra"), GetHashKey("dodo"), GetHashKey("howard"),
            GetHashKey("alphaz1"), GetHashKey("nimbus"), GetHashKey("velum"), GetHashKey("velum2"),
            GetHashKey("vestra"), GetHashKey("cuban800"), GetHashKey("duster"), GetHashKey("mallard"),
            GetHashKey("stunt"),
            
            GetHashKey("frogger"), GetHashKey("frogger2"), GetHashKey("maverick"), GetHashKey("supervolito"),
            GetHashKey("supervolito2"), GetHashKey("volatus"), GetHashKey("swift"), GetHashKey("swift2")
        }
        
        local shouldDelete = false
        
        for _, bannedHash in ipairs(bannedVehicles) do
            if model == bannedHash then
                shouldDelete = true
                break
            end
        end
        
        if vehicleClass == 15 or
           vehicleClass == 16 or
           vehicleClass == 18 then
            shouldDelete = true
        end
        
        if shouldDelete then
            SetEntityAsMissionEntity(entity, true, true)
            DeleteEntity(entity)
        end
    end
end)
