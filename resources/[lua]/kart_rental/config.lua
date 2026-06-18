Config = {}

Config.NPCPosition = vector3(-321.873169, -82.995499, 34.205212)
Config.NPCHeding = 200.0
Config.NPCModel = "a_m_m_business_01"

Config.KartSpawnPoints = {
    vector4(-309.260406, -82.784950, 33.438259, 70.0),
    vector4(-304.124237, -81.864662, 33.438789, 70.0),
    vector4(-300.787689, -85.845650, 33.438168, 70.0),
    vector4(-295.812805, -84.881989, 33.438911, 70.0),
    vector4(-292.481934, -88.778168, 33.438614, 70.0),
    vector4(-287.475189, -87.878075, 33.438370, 70.0),
    vector4(-284.145325, -91.826569, 33.438583, 70.0),
    vector4(-279.062988, -90.992409, 33.438889, 70.0)
}

Config.KartModel = "veto2"
Config.KartPrice = 250
Config.RentalDuration = 15

Config.SocietyName = "garage_lscustom"

Config.Messages = {
    ['rental_started'] = 'Location de kart commencée pour $%s. Durée: %s minutes',
    ['insufficient_money'] = 'Vous n\'avez pas assez d\'argent. Prix: $%s',
    ['spawn_blocked'] = 'Point de spawn bloqué, tentative du point suivant...',
    ['time_warning_10'] = 'Il reste 10 minutes de location',
    ['time_warning_5'] = 'Il reste 5 minutes de location',
    ['time_warning_3'] = 'Il reste 3 minutes de location',
    ['time_warning_1'] = 'Il reste 1 minute de location',
    ['rental_ended'] = 'Location terminée, le kart va être supprimé',
    ['press_to_rent'] = 'pour louer un kart ($%s)'
}