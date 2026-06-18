Locales['de'] = {
    -- =============================================================
    -- ALLGEMEIN / ALLGEMEINE BEZEICHNUNGEN
    -- =============================================================
    ['crew'] = 'Crew',
    ['information'] = 'Informationen',
    ['actions'] = 'Aktionen',
    ['name'] = 'Name',
    ['rank'] = 'Rang',
    ['yes'] = 'Ja',
    ['no'] = 'Nein',
    ['exclude'] = 'Ausschließen',
    ['no_nearby_player'] = 'Kein Spieler in der Nähe.',
    ['motto'] = 'Motto',
    ['recruit_someone'] = 'Jemanden rekrutieren',
    ['exclude_someone'] = 'Jemanden ausschließen',

    -- =============================================================
    -- CREW MENÜS / ERSTELLUNG / RÄNGE
    -- =============================================================
    ['list_of_members'] = 'Mitgliederliste',
    ['ranks_list'] = 'Rangliste',
    ['crew_controlled_territories'] = 'Kontrollierte Gebiete',
    ['ranks'] = 'Ränge',
    ['create_crew'] = '~g~Crew erstellen',
    ['enter_crew_name'] = 'Crew-Name',
    ['enter_crew_motto'] = 'Crew-Motto',
    ['enter_rank_name'] = 'Rang-Name',
    ['enter_rank_name_leader'] = 'Name des Anführerrangs',
    ['must_fill_all_fields'] = 'Du musst alle Felder ausfüllen.',
    ['create_another_rank'] = '~g~Einen weiteren Rang erstellen',
    ['delete_rank'] = '~r~Rang löschen',
    ['deleted_rank'] = 'Du hast den Rang ~b~%s~s~ gelöscht und alle Mitglieder, die diesen Rang hatten, ausgeschlossen.',
    ['rename_rank'] = 'Rang umbenennen',
    ['enter_new_rank_name'] = 'Gib den neuen Rangnamen ein',
    ['rank_name_changed'] = 'Der Rangname wurde in ~b~%s~s~ geändert.',
    ['rank_name_already_exists'] = "~r~Ein Rang mit diesem Namen existiert bereits in dieser Crew.",
    ['leader'] = 'Anführer | %s',
    ['leader2'] = 'Chef',

    -- =============================================================
    -- CREW FARBE (PICKER)
    -- =============================================================
    ['crew_color'] = 'Farbe',
    ['crew_color_desc'] = 'Wähle die Farbe deiner Crew.',
    ['crew_color_selected'] = 'Ausgewählte Farbe: %s',

    -- =============================================================
    -- ZUGRIFFE / BERECHTIGUNGEN
    -- =============================================================
    ['access_crew_management'] = 'Zugriff auf Crew-Management',
    ['access_properties'] = 'Zugriff auf Immobilien',
    ['access_property_chest'] = 'Zugriff auf den Immobilientresor',
    ['access_vehicle_keys'] = 'Zugriff auf Fahrzeugschlüssel',
    ['access_vehicle_sales'] = 'Zugriff auf Fahrzeugverkäufe',
    ['give_access_to'] = 'Du hast dem Rang ~b~%s~s~ Zugriff auf %s gewährt.',
    ['remove_access_from'] = 'Du hast dem Rang ~b~%s~s~ den Zugriff auf %s entzogen.',
    ['changed_player_rank'] = 'Du hast ~b~%s~s~ den Rang ~b~%s~s~ zugewiesen.',

    -- =============================================================
    -- EINLADUNGEN / BEITRITT
    -- =============================================================
    ['accept_invite'] = "Möchtest du der Crew ~b~%s~s~ beitreten?\n~g~Y~s~: Annehmen\n~r~X~s~: Ablehnen",
    ['too_long_to_respond'] = 'Du hast zu lange gebraucht, um zu antworten.',
    ['you_declined_invite'] = 'Du hast abgelehnt, der Crew beizutreten.',
    ['you_joined_crew'] = 'Du wurdest in die Crew ~b~%s~s~ rekrutiert.',
    ['invited_player_to_crew'] = 'Du hast ~b~%s~s~ eingeladen, deiner Crew beizutreten.',
    ['accepted_crew_invite'] = '~b~%s~s~ hat die Einladung in deine Crew angenommen.',
    ['declined_crew_invite'] = 'Die Person hat die Einladung in deine Crew abgelehnt.',
    ['invite_timeout'] = 'Die Person hat zu lange gebraucht, um zu wählen.',
    ['invite_expired'] = 'Die Einladung ist abgelaufen.',

    -- =============================================================
    -- MITGLIEDER / CREW-STATUS
    -- =============================================================
    ['you_created_crew'] = 'Du hast die Crew ~b~%s~s~ mit dem Motto ~b~%s~s~ und ~b~%d~s~ Rängen erstellt.',
    ['you_left_crew'] = 'Du hast dich entschieden, deine Crew zu ~r~verlassen~s~.',
    ['not_in_crew'] = 'Du bist in keiner Crew.',
    ['already_in_crew'] = 'Du bist bereits in einer Crew.',
    ['player_already_in_crew'] = 'Die Person ist bereits in einer Crew.',
    ['you_were_kicked'] = 'Du wurdest ~b~aus deiner Crew ausgeschlossen~s~.',
    ['cannot_kick_creator'] = 'Du kannst den ~b~Ersteller der Crew~s~ nicht ausschließen.',
    ['kicked_player'] = 'Du hast die Person aus deiner Crew ~b~ausgeschlossen~s~.',

    -- Crew-Erstellung (grade/discord)
    ['cannot_create_crew'] = '~r~Du kannst keine Crew erstellen.',
    ['creation_restricted_admin'] = '~r~Nur Administratoren können eine Crew erstellen.',
    ['creation_restricted_discord_config_missing'] = '~r~Discord-Konfiguration unvollständig. Bitte Admin kontaktieren.',
    ['no_discord_linked'] = '~r~Dein Discord-Konto ist nicht verknüpft (fehlende Discord-ID).',
    ['discord_role_missing'] = '~r~Du hast nicht die erforderliche Discord-Rolle, um eine Crew zu erstellen.',

    -- =============================================================
    -- GEBIETE / KARTE / BEANSPRUCHEN
    -- =============================================================
    ['territory'] = 'Gebiet',
    ['ranking'] = 'Rangliste - ~b~%s',
    ['claim_territory'] = '~r~Beanspruche %s',
    ['claim_territory_desc'] = 'Beanspruche dieses Gebiet für deine ~b~Crew',
    ['must_be_in_crew'] = 'Du musst in einer Crew sein, um dieses Menü zu öffnen.',
    ['no_controlled_territories'] = 'Deine Crew kontrolliert keine Gebiete.',
    ['not_enough_members_to_claim'] = 'Ihr seid nicht genug, um dieses Gebiet zu beanspruchen.',
    ['leaders_not_present'] = 'Die Anführer scheinen nicht anwesend zu sein.. versuche es später erneut.',
    ['not_in_territory'] = 'Du befindest dich nicht in einem Gebiet.',
    ['you_already_claimed_today'] = 'Du hast heute bereits eine Zone beansprucht.',
    ['crew_claimed_territory'] = 'Deine Crew hat das Gebiet von ~b~%s~s~ beansprucht und ~g~%d Punkte~s~ gewonnen.',

    -- Tooltip (NUI)
    ['tooltip_frequentation'] = 'Frequentierung',
    ['tooltip_competition'] = 'Konkurrenz',
    ['tooltip_crew_leader'] = 'Crew Leader',
    ['level_low'] = 'Niedrig',
    ['level_normal'] = 'Normal',
    ['level_high'] = 'Hoch',
    ['none'] = 'Keine',

    -- Gebiets-Beschreibungen (im Tooltip via id)
    ['territory_desc_vespucci_plage_sud'] = 'Ikonischer Strand nach Santa Monica: Muscle Sands, Skatepark und Ufermarkt ziehen tagsüber Besucher an. Nachts schließen die Läden, es wird intimer – nur ein paar Lagerfeuer oder Hipster bleiben am Strand.',
    ['territory_desc_vespucci_plage_nord'] = 'Ruhigere, edlere Zone mit Marina, Kanälen und kleinen Läden: ideale Umgebung, um unterzutauchen. Weniger Touristen – perfekt für diskrete Treffen oder Rückzugspunkte.',
    ['territory_desc_aeroport'] = 'Flughafen Los Santos: große Terminals, gesicherte Pisten und stetiger Verkehr. Trotz Sicherheit bieten Nebenhangars, Servicerouten und viele Zugänge Möglichkeiten für verdeckte Aktionen.',
    ['territory_desc_wardogs'] = 'In den Industriedocks: Lastwagen und Lagerhäuser am Tag. Nachts leert sich das Areal und die Schatten übernehmen – ideal für verdeckte Manöver.',
    ['territory_desc_mazebank'] = 'Rund um die Maze Bank Arena: Drehs von „Fame or Shame“ oder Arena-War-Rennen. Breite Wege, große Parkplätze und diskrete Zugänge – perfekt, um in der Menge zu verschwinden.',
    ['territory_desc_sud_de_los_santos'] = 'Dichtes Stadtgebiet mit Werkstätten, einfachen Wohnungen und Hauptstraßen. Stete Aktivität, viel Verkehr; wechselnde Polizeipräsenz – geeignet für schnelle Aktionen und Hinterhalte.',
    ['territory_desc_centre_ville'] = 'Zentrum von Los Santos mit Wolkenkratzern und Firmenzentralen. Zwischen den Türmen: Parkplätze und Servicezugänge – ideal für diskrete Beobachtung oder verdeckte Übergaben.',
    ['territory_desc_little_seoul'] = 'Dichtes Viertel mit koreanischem Flair: enge Gassen, kleine Läden, Lokale. Hoher Fußverkehr und Tiefgaragen schaffen Abkürzungen, Schattenzonen und natürliche Verstecke.',
    ['territory_desc_universite'] = 'Grüner Campus mit Bibliotheken und Wohnheimen. Ruhe mit regelmäßigem Fußverkehr; viele Nebenwege – ideal für Beschattungen und unauffällige Treffen.',
    ['territory_desc_vinewood'] = 'Gehobene Villen und tolle Aussicht. Kurvige Straßen und strategische Aussichtspunkte – perfekt zum Beobachten oder lautlosen Verschwinden.',
    ['territory_desc_mirror_park'] = 'Ruhige Parklandschaft mit See, Cafés und Läden. Das leise Plätschern des Wassers – ideal für diskrete Treffen oder entspannte Beobachtung.',

    -- =============================================================
    -- DROGENVERKAUF / NPC-INTERAKTIONEN
    -- =============================================================
    ['press_to_sell_drugs'] = 'Drücke ~INPUT_CONTEXT~, um deine ~b~Drogen zu verkaufen~s~.',
    ['sell_drugs_to_ped'] = 'Drogen verkaufen',
    ['sell_drugs_notification'] = 'Du hast ~b~x(%d) %s~s~ für ~g~%d$~s~ verkauft.',
    ['not_enough_drugs'] = 'Du hast keine Drogen mehr.',
    ['activated_drug_sale'] = 'Du hast den Drogenverkauf ~b~aktiviert~s~.',
    ['deactivated_drug_sale'] = 'Du hast den Drogenverkauf ~r~deaktiviert~s~.',
    ['no_drugs'] = 'Du musst Drogen bei dir haben.',
    ['person_doesnt_want_drugs'] = 'Die Person will deine Ware nicht.',
    ['someone_selling_drugs'] = 'Hallo!? Das ist %s, %s ~r~%s~s~!',

    -- Alarm-Varianten (Claims & Deals)
    ['crew_claiming_territory'] = 'Hallo!? Das ist %s, %s ~r~%s~s~!',
    ['alert_deal_ming'] = 'da sind Leute, die bei',
    ['alert_claim_ming'] = 'Eine Crew beansprucht',
    ['alert_deal_dante'] = 'ich bin mir sicher, dass ich bei',
    ['alert_claim_dante'] = 'Hast du das gesehen? Eine Crew übernimmt die Kontrolle über',
    ['alert_deal_flores'] = 'Hermano, da sind zwielichtige Typen, die bei',
    ['alert_claim_flores'] = 'Jemand versucht, das Gebiet zu beanspruchen bei',
    ['alert_deal_majo'] = 'da sind Typen, die bei',
    ['alert_claim_majo'] = 'Eine Crew hat das Gebiet von',

    -- =============================================================
    -- FEHLER / DEBUG / KONFIG
    -- =============================================================
    ['error_money_nil'] = "Fehler: Die Variable 'money' ist null.",
    ['error_xplayer_item_nil'] = 'Fehler: xPlayer ist null oder der Gegenstand ist null.',
    ['error_creating_leader_rank'] = 'Fehler beim Erstellen des Anführerrangs.',
    ['error_fetching_crew_id'] = 'Fehler beim Abrufen der Crew-ID.',
    ['crew_name_already_exists'] = 'Eine Crew mit diesem Namen existiert bereits.',
    ['no_drug_command_defined'] = 'Kein Drogenverkaufsbefehl wurde in der Konfiguration definiert.',

    -- RESTORE / RESET GEBIETE (INFO)
    ['last_reset_timestamp'] = 'Zeitstempel der letzten Zurücksetzung: %s',
    ['time_difference'] = 'Zeitunterschied: %s Sekunden',
    ['updated_last_reset'] = 'Datum der letzten Zurücksetzung aktualisiert.',
    ['deleted_territory_rows'] = '%d Zeilen wurden aus der Territorien-Tabelle gelöscht.',

    -- =============================================================
    -- LEVELS / CREW-XP
    -- =============================================================
    ['crew_level_not_enough'] = 'Deine Crew hat nicht das erforderliche Level für diese Aktion.',

    -- =============================================================
    -- GEBIETSVERWALTUNG (ADMIN)
    -- =============================================================
    ['territory_management'] = 'Gebietsverwaltung',
    ['existing_territories'] = 'Bestehende Gebiete',
    ['create_new_territory'] = '~g~Neues Gebiet erstellen',
    ['no_territories_found'] = '~r~Keine Gebiete gefunden',
    ['loading'] = '~y~Laden...',
    ['territory_configuration'] = 'Gebietskonfiguration',
    ['territory_name'] = 'Name',
    ['territory_name_desc'] = 'Gib den ~b~Namen~s~ deines Gebiets ein.',
    ['territory_id'] = 'ID',
    ['territory_id_desc'] = 'Gib den Namen des Gebiets-~b~Bildes~s~ ein.',
    ['territory_description'] = 'Beschreibung',
    ['territory_description_desc'] = 'Gib die ~b~Beschreibung~s~ deines Gebiets ein.',
    ['territory_frequentation'] = 'Frequenz',
    ['territory_frequentation_low'] = '~y~niedrig~s~',
    ['territory_frequentation_normal'] = '~g~normal~s~',
    ['territory_frequentation_high'] = '~r~hoch~s~',
    ['continue_to_creation'] = '~g~Zur Erstellung fortfahren',
    ['continue_to_creation_desc'] = 'Zur Punktplatzierung übergehen',
    ['name_and_id_required'] = '~r~Name und ID erforderlich',
    ['polygon_construction'] = 'Polygon-Konstruktion',
    ['add_point'] = 'Einen Punkt hinzufügen (Spielerposition).',
    ['add_point_desc'] = 'Füge deine ~b~XY~s~-Position zum Polygon hinzu',
    ['point_added'] = 'Punkt #%d hinzugefügt',
    ['create_territory'] = '~g~Gebiet erstellen',
    ['create_territory_desc'] = 'Möchtest du das Gebiet wirklich ~g~speichern~s~?',
    ['minimum_3_points'] = '~r~Mindestens 3 Punkte',
    ['territory_editing'] = 'Gebietsbearbeitung',
    ['modify_points'] = '~o~Punkte bearbeiten',
    ['current_points'] = 'Aktuelle Punkte:~g~ %d',
    ['validate'] = '~g~Bestätigen',
    ['validate_desc'] = 'Änderungen speichern',
    ['delete'] = '~r~Löschen',
    ['delete_desc'] = 'Möchtest du dieses Gebiet wirklich ~r~löschen~s~?',
    ['point_modification'] = 'Punktbearbeitung',
    ['click_to_replace'] = 'Klicken, um mit deiner Position zu ~b~ersetzen~s~',
    ['point_updated'] = 'Punkt #%d aktualisiert',
    ['validate_modifications'] = '~g~Änderungen bestätigen',
    ['validate_modifications_desc'] = 'Zur Bearbeitungsmenü zurückkehren',
    ['access_denied_admin'] = '~r~Zugriff verweigert (nur Admin)',
    ['territory_saved'] = '~g~Gebiet gespeichert',
    ['territory_updated'] = '~g~Gebiet aktualisiert',
    ['territory_deleted'] = '~g~Gebiet gelöscht',
    ['error'] = '~r~Fehler: %s',
    
    -- setcrew Befehle
    ['setcrew_access_denied'] = '~r~Zugriff verweigert (nur Admin)',
    ['setcrew_usage'] = '~r~Verwendung: /setcrew [SPIELER_ID] [CREW_NAME] [RANG]',
    ['setcrew_invalid_id'] = '~r~Ungültige Spieler-ID',
    ['setcrew_player_not_found'] = '~r~Spieler nicht gefunden',
    ['setcrew_crew_not_found'] = '~r~Crew "%s" nicht gefunden',
    ['setcrew_grade_not_found'] = '~r~Rang "%s" nicht in Crew "%s" gefunden',
    ['setcrew_success'] = '~g~Spieler %s zu Crew "%s" mit Rang "%s" hinzugefügt',
    ['setcrew_success_target'] = '~g~Du wurdest zu Crew "%s" mit Rang "%s" hinzugefügt',
    ['setcrew_error'] = '~r~Fehler beim Hinzufügen des Spielers zur Crew',
    
    -- deletecrew Befehle
    ['deletecrew_access_denied'] = '~r~Zugriff verweigert (nur Crew-Leader oder Admin)',
    ['deletecrew_usage'] = '~r~Verwendung: /deletecrew [CREW_NAME] (nur Admin)',
    ['deletecrew_not_in_crew'] = '~r~Du bist in keiner Crew',
    ['deletecrew_not_leader'] = '~r~Du bist nicht der Leader deiner Crew',
    ['deletecrew_crew_not_found'] = '~r~Crew "%s" nicht gefunden',
    ['deletecrew_success'] = '~g~Crew "%s" erfolgreich gelöscht',
    ['deletecrew_success_leader'] = '~g~Deine Crew "%s" wurde gelöscht',
    ['deletecrew_error'] = '~r~Fehler beim Löschen der Crew',
    
    -- Fehlermeldungen für tgiann-inventory
    ['error_removing_item'] = "Fehler beim Entfernen des Items",
    ['error_adding_money'] = "Fehler beim Hinzufügen von Geld",
    
    -- Nachrichten für setownercrew Befehl
    ['setownercrew_no_permission'] = "~r~Du hast keine Berechtigung, diesen Befehl zu verwenden",
    ['setownercrew_usage'] = "~r~Verwendung: /setownercrew [SPIELER_ID] [CREW_NAME_ODER_ID]",
    ['setownercrew_invalid_id'] = "~r~Ungültige Spieler-ID",
    ['setownercrew_player_not_found'] = "~r~Spieler nicht gefunden",
    ['setownercrew_already_in_crew'] = "~r~Dieser Spieler ist bereits in einer Crew",
    ['setownercrew_crew_not_found'] = "~r~Crew nicht gefunden",
    ['setownercrew_no_grades'] = "~r~Keine Ränge für diese Crew gefunden",
    ['setownercrew_success'] = "~g~Spieler zu Crew \"%s\" mit höchstem Rang hinzugefügt",
    ['setownercrew_target_notification'] = "~g~Du wurdest zu Crew \"%s\" hinzugefügt",
    ['setownercrew_error'] = "~r~Fehler beim Hinzufügen zur Crew",
}
