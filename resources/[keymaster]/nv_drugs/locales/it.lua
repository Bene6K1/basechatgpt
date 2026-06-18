Locales['it'] = {
    -- =============================================================
    -- GENERALE / ETICHETTE COMUNI
    -- =============================================================
    ['crew'] = 'Crew',
    ['information'] = 'Informazioni',
    ['actions'] = 'Azioni',
    ['name'] = 'Nome',
    ['rank'] = 'Grado',
    ['yes'] = 'Sì',
    ['no'] = 'No',
    ['exclude'] = 'Escludi',
    ['no_nearby_player'] = 'Nessun giocatore nelle vicinanze.',
    ['motto'] = 'Motto',
    ['recruit_someone'] = 'Reclutare qualcuno',
    ['exclude_someone'] = 'Escludere qualcuno',

    -- =============================================================
    -- MENU CREW / CREAZIONE / GRADI
    -- =============================================================
    ['list_of_members'] = 'Elenco dei membri',
    ['ranks_list'] = 'Elenco dei ranghi',
    ['crew_controlled_territories'] = 'Territori controllati',
    ['ranks'] = 'Gradi',
    ['create_crew'] = '~g~Crea il crew',
    ['enter_crew_name'] = 'Nome del Crew',
    ['enter_crew_motto'] = 'Motto del Crew',
    ['enter_rank_name'] = 'Nome del Grado',
    ['enter_rank_name_leader'] = 'Nome del Grado Capo',
    ['must_fill_all_fields'] = 'Devi riempire tutti i campi.',
    ['create_another_rank'] = '~g~Crea un altro grado',
    ['delete_rank'] = '~r~Elimina il grado',
    ['deleted_rank'] = 'Hai eliminato il grado ~b~%s~s~ ed espulso tutti i membri che avevano quel grado.',
    ['rename_rank'] = 'Rinomina Grado',
    ['enter_new_rank_name'] = 'Inserisci il nuovo nome del grado',
    ['rank_name_changed'] = 'Il nome del grado è stato cambiato in ~b~%s~s~.',
    ['rank_name_already_exists'] = 'Esiste già un grado con questo nome in questo crew.',
    ['leader'] = 'Leader | %s',
    ['leader2'] = 'Capo',

    -- =============================================================
    -- COLORE DEL CREW (PICKER)
    -- =============================================================
    ['crew_color'] = 'Colore',
    ['crew_color_desc'] = 'Scegli il colore del tuo crew.',
    ['crew_color_selected'] = 'Colore selezionato: %s',

    -- =============================================================
    -- ACCESSI / PERMESSI
    -- =============================================================
    ['access_crew_management'] = 'Accesso alla gestione del Crew',
    ['access_properties'] = 'Accesso alle proprietà',
    ['access_property_chest'] = 'Accesso alla cassaforte delle proprietà',
    ['access_vehicle_keys'] = 'Accesso alle chiavi dei veicoli',
    ['access_vehicle_sales'] = 'Accesso alla vendita dei veicoli',
    ['give_access_to'] = 'Hai dato accesso a %s al grado ~b~%s~s~.',
    ['remove_access_from'] = 'Hai rimosso l\'accesso a %s dal grado ~b~%s~s~.',
    ['changed_player_rank'] = 'Hai assegnato il grado ~b~%s~s~ a ~b~%s~s~.',

    -- =============================================================
    -- INVITI / ADESIONE
    -- =============================================================
    ['accept_invite'] = "Vuoi unirti al crew ~b~%s~s~?\n~g~Y~s~: Accetta\n~r~X~s~: Rifiuta",
    ['too_long_to_respond'] = 'Hai impiegato troppo tempo per scegliere.',
    ['you_declined_invite'] = 'Hai rifiutato di unirti al crew.',
    ['you_joined_crew'] = 'Sei stato reclutato nel crew ~b~%s~s~.',
    ['invited_player_to_crew'] = 'Hai invitato ~b~%s~s~ a unirsi al tuo crew.',
    ['accepted_crew_invite'] = '~b~%s~s~ ha accettato di unirsi al tuo crew.',
    ['declined_crew_invite'] = 'La persona ha rifiutato di unirsi al tuo crew.',
    ['invite_timeout'] = 'La persona ha impiegato troppo tempo per scegliere.',
    ['invite_expired'] = 'L\'invito è scaduto.',

    -- =============================================================
    -- MEMBRI / STATO DEL CREW
    -- =============================================================
    ['you_created_crew'] = 'Hai creato il crew ~b~%s~s~ con il motto ~b~%s~s~ e ~b~%d~s~ gradi.',
    ['you_left_crew'] = 'Hai deciso di ~r~lasciare~s~ il tuo crew.',
    ['not_in_crew'] = 'Non fai parte di nessun crew.',
    ['already_in_crew'] = 'Sei già in un crew.',
    ['player_already_in_crew'] = 'La persona è già in un crew.',
    ['you_were_kicked'] = 'Sei stato ~b~espulso~s~ dal tuo crew.',
    ['cannot_kick_creator'] = 'Non puoi ~b~espellere~s~ il creatore del crew.',
    ['kicked_player'] = 'Hai ~b~espulso~s~ la persona dal tuo crew.',

    -- Creazione crew (modalità grado/discord)
    ['cannot_create_crew'] = '~r~Non puoi creare un crew.',
    ['creation_restricted_admin'] = '~r~Solo gli amministratori possono creare un crew.',
    ['creation_restricted_discord_config_missing'] = '~r~Configurazione Discord incompleta. Contatta un amministratore.',
    ['no_discord_linked'] = '~r~Il tuo account Discord non è collegato (ID Discord mancante).',
    ['discord_role_missing'] = '~r~Non hai il ruolo Discord richiesto per creare un crew.',

    -- =============================================================
    -- TERRITORI / MAPPA / CLAIMS
    -- =============================================================
    ['territory'] = 'Territorio',
    ['ranking'] = 'Classifica - ~b~%s',
    ['claim_territory'] = '~r~Rivendica %s',
    ['claim_territory_desc'] = 'Rivendica questo territorio per il tuo ~b~crew',
    ['must_be_in_crew'] = 'Devi essere in un crew per aprire questo menu.',
    ['no_controlled_territories'] = 'Il tuo crew non controlla alcun territorio.',
    ['not_enough_members_to_claim'] = 'Non siete abbastanza per rivendicare questo territorio.',
    ['leaders_not_present'] = 'I leader non sembrano presenti.. riprova più tardi.',
    ['not_in_territory'] = 'Non sei su un territorio.',
    ['you_already_claimed_today'] = 'Hai già rivendicato una zona oggi.',
    ['crew_claimed_territory'] = 'Il tuo crew ha rivendicato il territorio di ~b~%s~s~ e ha guadagnato ~g~%d punti~s~.',

    -- Tooltip (NUI)
    ['tooltip_frequentation'] = 'Frequenza',
    ['tooltip_competition'] = 'Concorrenza',
    ['tooltip_crew_leader'] = 'Capo Crew',
    ['level_low'] = 'Bassa',
    ['level_normal'] = 'Normale',
    ['level_high'] = 'Alta',
    ['none'] = 'Nessuna',

    -- Descrizioni dei territori (usate nel tooltip via id)
    ['territory_desc_vespucci_plage_sud'] = 'Spiaggia iconica ispirata a Santa Monica: Muscle Sands, skate-park e mercato sul lungomare richiamano gente di giorno. Di notte i negozi chiudono e l\'area diventa intima, con qualche falò o hipster sulla sabbia.',
    ['territory_desc_vespucci_plage_nord'] = 'Zona più raffinata con marina, canali e piccole botteghe: atmosfera tranquilla, ideale per passare inosservati. Meno turisti — perfetta per incontri discreti o per raggrupparsi lontano da occhi indiscreti.',
    ['territory_desc_aeroport'] = 'Aeroporto Internazionale di Los Santos: grandi terminal, piste sicure e traffico costante. Nonostante la sicurezza, hangar periferici e accessi multipli permettono di operare sotto copertura.',
    ['territory_desc_wardogs'] = 'Nel cuore dei moli industriali: camion e magazzini di giorno. Di notte l\'area si svuota e le ombre prendono il sopravvento — terreno ideale per manovre clandestine.',
    ['territory_desc_mazebank'] = 'Attorno alla Maze Bank Arena: riprese di “Fame or Shame” o gare dell\'Arena War. Viali larghi, parcheggi immensi e accessi discreti — perfetto per mescolarsi o sparire a seconda dell\'affluenza.',
    ['territory_desc_sud_de_los_santos'] = 'Settore urbano denso tra officine, case modeste e arterie principali. Attività costante e traffico pesante; presenza di polizia variabile — ideale per blitz rapidi e imboscate.',
    ['territory_desc_centre_ville'] = 'Centro di Los Santos con grattacieli e sedi aziendali. Tra le torri: parcheggi e accessi di servizio — perfetti per sorveglianze discrete o scambi fuori radar.',
    ['territory_desc_little_seoul'] = 'Quartiere denso di impronta coreana: vicoli stretti, minimarket e locali. Grande flusso pedonale e parcheggi sotterranei creano scorciatoie, zone d\'ombra e nascondigli naturali.',
    ['territory_desc_universite'] = 'Campus verde con biblioteche e residenze. Calma solo apparente: flusso regolare e molti accessi secondari — ottimo per pedinamenti o incontri furtivi.',
    ['territory_desc_vinewood'] = 'Ville eleganti e panorami mozzafiato. Strade tortuose e punti panoramici strategici — terreno perfetto per osservare o sparire senza lasciare tracce.',
    ['territory_desc_mirror_park'] = 'Oasi di tranquillità con lago, caffè e negozi. Lo sciabordio dell\'acqua crea un contesto ideale per incontri discreti o osservazioni tranquille.',

    -- =============================================================
    -- VENDITA DROGHE / INTERAZIONI NPC
    -- =============================================================
    ['press_to_sell_drugs'] = 'Premi ~INPUT_CONTEXT~ per ~b~vendere la tua droga~s~.',
    ['sell_drugs_to_ped'] = 'Vendi droga',
    ['sell_drugs_notification'] = 'Hai venduto ~b~x(%d) %s~s~ per ~g~%d$~s~.',
    ['not_enough_drugs'] = 'Non hai più droghe.',
    ['activated_drug_sale'] = 'Hai ~b~attivato~s~ la vendita di droghe.',
    ['deactivated_drug_sale'] = 'Hai ~r~disattivato~s~ la vendita di droghe.',
    ['no_drugs'] = 'Devi avere della droga con te.',
    ['person_doesnt_want_drugs'] = 'La persona non vuole la tua merce.',
    ['someone_selling_drugs'] = 'Ciao!? Sono %s, %s ~r~%s~s~!',

    -- Varianti di allerta (claim & deal)
    ['crew_claiming_territory'] = 'Ciao!? Sono %s, %s ~r~%s~s~!',
    ['alert_deal_ming'] = 'ci sono persone che spacciano a',
    ['alert_claim_ming'] = 'Un crew sta rivendicando',
    ['alert_deal_dante'] = 'sono sicuro di aver visto della droga girare a',
    ['alert_claim_dante'] = 'Hai visto? Un crew sta prendendo il controllo di',
    ['alert_deal_flores'] = 'Hermano, ci sono persone losche che spacciano a',
    ['alert_claim_flores'] = 'Qualcuno sta cercando di rivendicare',
    ['alert_deal_majo'] = 'ci sono dei tipi che vendono a',
    ['alert_claim_majo'] = 'Un crew ha rivendicato il territorio di',

    -- =============================================================
    -- ERRORI / DEBUG / CONFIG
    -- =============================================================
    ['error_money_nil'] = "Errore: la variabile 'money' è nulla.",
    ['error_xplayer_item_nil'] = 'Errore: xPlayer è nullo o l\'oggetto è nullo.',
    ['error_creating_leader_rank'] = 'Errore durante la creazione del grado capo.',
    ['error_fetching_crew_id'] = 'Errore durante il recupero dell\'ID del crew.',
    ['crew_name_already_exists'] = 'Un crew con questo nome esiste già.',
    ['no_drug_command_defined'] = 'Nessun comando di vendita droga è stato definito nella configurazione.',

    -- RIPRISTINO / RESET TERRITORI (INFO)
    ['last_reset_timestamp'] = 'Timestamp dell\'ultima reimpostazione: %s',
    ['time_difference'] = 'Differenza di tempo: %s secondi',
    ['updated_last_reset'] = 'Data dell\'ultima reimpostazione aggiornata.',
    ['deleted_territory_rows'] = '%d righe sono state eliminate dalla tabella dei territori.',

    -- =============================================================
    -- LIVELLI / XP CREW
    -- =============================================================
    ['crew_level_not_enough'] = 'Il tuo crew non ha il livello richiesto per questa azione.',

    -- =============================================================
    -- GESTIONE TERRITORI (ADMIN)
    -- =============================================================
    ['territory_management'] = 'Gestione territori',
    ['existing_territories'] = 'Territori esistenti',
    ['create_new_territory'] = '~g~Crea un nuovo territorio',
    ['no_territories_found'] = '~r~Nessun territorio trovato',
    ['loading'] = '~y~Caricamento...',
    ['territory_configuration'] = 'Configurazione territorio',
    ['territory_name'] = 'Nome',
    ['territory_name_desc'] = 'Inserisci il ~b~nome~s~ del tuo territorio.',
    ['territory_id'] = 'ID',
    ['territory_id_desc'] = 'Inserisci il nome dell\'~b~immagine~s~ del territorio.',
    ['territory_description'] = 'Descrizione',
    ['territory_description_desc'] = 'Inserisci la ~b~descrizione~s~ del tuo territorio.',
    ['territory_frequentation'] = 'Frequenza',
    ['territory_frequentation_low'] = '~y~bassa~s~',
    ['territory_frequentation_normal'] = '~g~normale~s~',
    ['territory_frequentation_high'] = '~r~alta~s~',
    ['continue_to_creation'] = '~g~Continua alla creazione',
    ['continue_to_creation_desc'] = 'Procedi al posizionamento dei punti',
    ['name_and_id_required'] = '~r~Nome e ID richiesti',
    ['polygon_construction'] = 'Costruzione poligono',
    ['add_point'] = 'Aggiungi un punto (posizione giocatore).',
    ['add_point_desc'] = 'Aggiungi la tua posizione ~b~XY~s~ al poligono',
    ['point_added'] = 'Punto #%d aggiunto',
    ['create_territory'] = '~g~Crea il territorio',
    ['create_territory_desc'] = 'Vuoi davvero ~g~salvare~s~ il territorio?',
    ['minimum_3_points'] = '~r~Minimo 3 punti',
    ['territory_editing'] = 'Modifica territorio',
    ['modify_points'] = '~o~Modifica punti',
    ['current_points'] = 'Punti attuali:~g~ %d',
    ['validate'] = '~g~Valida',
    ['validate_desc'] = 'Salva modifiche',
    ['delete'] = '~r~Elimina',
    ['delete_desc'] = 'Vuoi davvero ~r~eliminare~s~ questo territorio?',
    ['point_modification'] = 'Modifica punti',
    ['click_to_replace'] = 'Clicca per ~b~sostituire~s~ con la tua posizione',
    ['point_updated'] = 'Punto #%d aggiornato',
    ['validate_modifications'] = '~g~Valida modifiche',
    ['validate_modifications_desc'] = 'Torna al menu di modifica',
    ['access_denied_admin'] = '~r~Accesso negato (solo admin)',
    ['territory_saved'] = '~g~Territorio salvato',
    ['territory_updated'] = '~g~Territorio aggiornato',
    ['territory_deleted'] = '~g~Territorio eliminato',
    ['error'] = '~r~Errore: %s',
    
    -- Comandi setcrew
    ['setcrew_access_denied'] = '~r~Accesso negato (solo admin)',
    ['setcrew_usage'] = '~r~Uso: /setcrew [ID_GIOCATORE] [NOME_CREW] [RANGO]',
    ['setcrew_invalid_id'] = '~r~ID giocatore non valido',
    ['setcrew_player_not_found'] = '~r~Giocatore non trovato',
    ['setcrew_crew_not_found'] = '~r~Crew "%s" non trovato',
    ['setcrew_grade_not_found'] = '~r~Grado "%s" non trovato nel crew "%s"',
    ['setcrew_success'] = '~g~Giocatore %s aggiunto al crew "%s" con grado "%s"',
    ['setcrew_success_target'] = '~g~Sei stato aggiunto al crew "%s" con grado "%s"',
    ['setcrew_error'] = '~r~Errore nell\'aggiungere il giocatore al crew',
    
    -- Comandi deletecrew
    ['deletecrew_access_denied'] = '~r~Accesso negato (solo leader crew o admin)',
    ['deletecrew_usage'] = '~r~Uso: /deletecrew [NOME_CREW] (solo admin)',
    ['deletecrew_not_in_crew'] = '~r~Non sei in un crew',
    ['deletecrew_not_leader'] = '~r~Non sei il leader del tuo crew',
    ['deletecrew_crew_not_found'] = '~r~Crew "%s" non trovato',
    ['deletecrew_success'] = '~g~Crew "%s" eliminato con successo',
    ['deletecrew_success_leader'] = '~g~Il tuo crew "%s" è stato eliminato',
    ['deletecrew_error'] = '~r~Errore nell\'eliminazione del crew',
    
    -- Messaggi di errore per tgiann-inventory
    ['error_removing_item'] = "Errore nella rimozione dell'oggetto",
    ['error_adding_money'] = "Errore nell'aggiunta del denaro",
    
    -- Messaggi per il comando setownercrew
    ['setownercrew_no_permission'] = "~r~Non hai il permesso di usare questo comando",
    ['setownercrew_usage'] = "~r~Uso: /setownercrew [ID_GIOCATORE] [NOME_CREW_O_ID]",
    ['setownercrew_invalid_id'] = "~r~ID giocatore non valido",
    ['setownercrew_player_not_found'] = "~r~Giocatore non trovato",
    ['setownercrew_already_in_crew'] = "~r~Questo giocatore è già in un crew",
    ['setownercrew_crew_not_found'] = "~r~Crew non trovato",
    ['setownercrew_no_grades'] = "~r~Nessun grado trovato per questo crew",
    ['setownercrew_success'] = "~g~Giocatore aggiunto al crew \"%s\" con il grado più alto",
    ['setownercrew_target_notification'] = "~g~Sei stato aggiunto al crew \"%s\"",
    ['setownercrew_error'] = "~r~Errore nell'aggiunta al crew",
}
