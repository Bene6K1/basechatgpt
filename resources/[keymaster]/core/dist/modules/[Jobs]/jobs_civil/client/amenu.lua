zone = {
	LifeInvaders = SunnyGlobal.JobsCivil.EmploiPos,
	Chantier = SunnyGlobal.JobsCivil.Chantier,
	Jardinier = SunnyGlobal.JobsCivil.Jardinier,
	Mine = SunnyGlobal.JobsCivil.Mine,
	Bucheron = SunnyGlobal.JobsCivil.Bucheron
}

local Jobs = {
	{
		nom = "Travailler au chantier",
		desc = "Viens travailler au chantier, avoir des muscles dans les bras est obligatoire ! Pas pour les feignants ! ~g~aucun diplôme demandé.",
		coords = zone.Chantier
	},
	{
		nom = "Nettoyer le golf",
		desc = "Viens aider les jardiniers du golf à faire leur travail ! Travail assez posé dans un environnement agréable, véhicule fourni sans diplôme demandé.",
		coords = zone.Jardinier
	},
	{
		nom = "Travailler à la mine",
		desc = "Viens travailler à la mine comme un vrai mec ! Permis des conduire pour se rendre sur place demandé !",
		coords = zone.Mine
	},
	--{
	--	nom = "Travailler en tant que bucheron",
	--	desc = "Viens travailler dans la forêt ! Permis des conduire pour se rendre sur place demandé, ~g~Nouveau travail très bien rémunéré et muscle obligatoire !",
	--	coords = zone.Bucheron
	--}
}

function openLifeinvaderMenu()
	local menu = RageUI.CreateMenu('', "Intéraction")

    RageUI.Visible(menu, not RageUI.Visible(menu))

    while menu do
        Citizen.Wait(0)
        RageUI.IsVisible(menu, function()
			for i = 1, #Jobs, 1 do
				RageUI.Button(Jobs[i].nom, Jobs[i].desc, {}, true, {
					onSelected = function()
						SetNewWaypoint(Jobs[i].coords)
						RageUI.CloseAll()
						RenderScriptCams(0, 1, 1500, 1, 1)
						DestroyCam(cam, 1)
						ESX.ShowNotification("🗺️ Point GPS ajouté.")
					end
				})
			end
		end)
		if not RageUI.Visible(menu) then
            menu = RMenu:DeleteType('menu', true)
        end
	end
end

AddEventHandler("openLifeinvaderMenu", function()
	openLifeinvaderMenu()
end)

Citizen.CreateThread(function()
	while ESX == nil do Wait(1) end
	
	    AddZones('liveinfader_zone', {
        Position = zone.LifeInvaders,
        Dist = 10,
        Public = true,
        Job = nil,
        Job2 = nil,
        GradesJobRequire = false,
        GradesJob = {},
        InVehicleDisable = true,
        Blip = {
            Active = false,
            -- Position = vector3(2745.4719238281, 3477.0629882813, 55.671112060547),
            -- BlipId = 605,
            -- Color = 46,
            -- Scale = 0.6,
            -- Text = '[SERVICE] Supermarché'
        },
        ActionText = 'Contacter LifeInvader',
        Action = function()
            TriggerEvent("openLifeinvaderMenu")
        end
    })
end)