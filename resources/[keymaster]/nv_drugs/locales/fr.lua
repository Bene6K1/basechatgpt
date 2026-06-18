Locales['fr'] = {
    -- =============================================================
    -- GÉNÉRAL / LIBELLÉS COMMUNS
    -- =============================================================
    ['crew'] = 'Organisation',
    ['information'] = 'Informations',
    ['actions'] = 'Actions',
    ['name'] = 'Nom',
    ['rank'] = 'Rang',
    ['yes'] = 'Oui',
    ['no'] = 'Non',
    ['exclude'] = 'Exclure',
    ['no_nearby_player'] = "Aucun joueur proche.",
    ['motto'] = 'Devise',
    ['recruit_someone'] = 'Recruter quelqu\'un',
    ['exclude_someone'] = 'Exclure quelqu\'un',

    -- =============================================================
    -- MENUS CREW / CRÉATION / RANGS
    -- =============================================================
    ['list_of_members'] = 'Liste des membres',
    ['ranks_list'] = 'Liste des rangs',
    ['crew_controlled_territories'] = 'Territoires contrôlés (organisation)',
    ['ranks'] = "Grades",
    ['create_crew'] = "~g~Créer l'organisation",
    ['enter_crew_name'] = "Nom de l'organisation",
    ['enter_crew_motto'] = "Devise de l'organisation",
    ['enter_rank_name'] = "Nom du Grade",
    ['enter_rank_name_leader'] = "Nom du Grade Chef",
    ['must_fill_all_fields'] = "Vous devez remplir tous les champs.",
    ['create_another_rank'] = '~g~Créer un autre grade',
    ['delete_rank'] = "~r~Supprimer le grade",
    ['deleted_rank'] = "Vous avez supprimé le grade ~b~%s~s~ et expulsé tous les membres qui avaient le grade.",
    ['rename_rank'] = 'Renommer le grade',
    ['enter_new_rank_name'] = "Entrez le nouveau nom du grade",
    ['rank_name_changed'] = "Le nom du grade a été changé en ~b~%s~s~.",
    ['rank_name_already_exists'] = "~r~Un grade avec ce nom existe déjà dans ce crew.",
    ['leader'] = "Leader | %s",
    ['leader2'] = "Chef",

    -- =============================================================
    -- COULEUR DU CREW (PICKER)
    -- =============================================================
    ['crew_color'] = 'Couleur',
    ['crew_color_desc'] = 'Choisissez la couleur de votre organisation.',
    ['crew_color_selected'] = 'Couleur sélectionnée: %s',

    -- =============================================================
    -- ACCÈS / PERMISSIONS
    -- =============================================================
    ['access_crew_management'] = "Accès à la gestion de l'organisation",
    ['access_properties'] = "Accès aux propriétés",
    ['access_property_chest'] = "Accès au coffre des propriétés",
    ['access_vehicle_keys'] = "Accès aux clés des véhicules",
    ['access_vehicle_sales'] = "Accès à la vente des véhicules",
    ['give_access_to'] = "Vous avez donné l'accès à %s au grade ~b~%s~s~.",
    ['remove_access_from'] = "Vous avez retiré l'accès à %s au grade ~b~%s~s~.",
    ['changed_player_rank'] = "Vous avez attribué le rang ~b~%s~s~ à ~b~%s~s~.",

    -- =============================================================
    -- INVITATIONS / ADHÉSION
    -- =============================================================
    ['accept_invite'] = "Voulez-vous rejoindre l'organisation ~b~%s~s~ ?\n~g~Y~s~ : Accepter\n~r~X~s~ : Refuser",
    ['too_long_to_respond'] = "~r~Vous avez mis trop de temps à choisir.",
    ['you_declined_invite'] = "~r~Vous avez refusé de rejoindre le crew.",
    ['you_joined_crew'] = "Vous avez été recruté dans l'organisation ~b~%s~s~.",
    ['invited_player_to_crew'] = "Vous avez proposé à ~b~%s~s~ de rejoindre votre organisation.",
    ['accepted_crew_invite'] = "~b~%s~s~ a accepté de rejoindre votre organisation.",
    ['declined_crew_invite'] = "~r~La personne a refusé de rejoindre votre organisation.",
    ['invite_timeout'] = "~r~La personne a mis trop de temps à choisir.",
    ['invite_expired'] = 'L\'invitation a expiré.',

    -- =============================================================
    -- MEMBRES / ÉTAT DU CREW
    -- =============================================================
    ['you_created_crew'] = "Vous avez créé l'organisation ~b~%s~s~ avec la devise ~b~%s~s~ et ~b~%d~s~ grades.",
    ['you_left_crew'] = "Vous avez pris la décision de ~r~quitter~s~ votre organisation.",
    ['not_in_crew'] = "~r~Vous ne faites partie d'aucune organisation.",
    ['already_in_crew'] = "Vous faites déjà partie d'une organisation.",
    ['player_already_in_crew'] = "~r~La personne est déjà dans une organisation.",
    ['you_were_kicked'] = "Vous avez été ~b~expulsé~s~ de votre organisation.",
    ['cannot_kick_creator'] = "Vous ne pouvez pas ~b~expulser~s~ le créateur de l'organisation.",
    ['kicked_player'] = "Vous avez ~b~expulsé~s~ la personne de votre organisation.",

    -- Création Crew (modes grade/discord)
    ['cannot_create_crew'] = "~r~Vous ne pouvez pas créer une organisation.",
    ['creation_restricted_admin'] = "~r~Seuls les administrateurs peuvent créer une organisation.",
    ['creation_restricted_discord_config_missing'] = "~r~Configuration Discord incomplète. Contactez un administrateur.",
    ['no_discord_linked'] = "~r~Votre compte Discord n'est pas lié (identifiant Discord manquant).",
    ['discord_role_missing'] = "~r~Vous n'avez pas le rôle Discord requis pour créer une organisation.",

    -- =============================================================
    -- TERRITOIRES / CARTE / CLAIMS
    -- =============================================================
    ['territory'] = "Territoire",
    ['ranking'] = "Classement - ~b~%s",
    ['claim_territory'] = "~r~Revendiquer %s",
    ['claim_territory_desc'] = "Revendiquer ce territoire pour votre ~b~organisation",
    ['must_be_in_crew'] = "~r~Vous devez être dans une organisation pour ouvrir ce menu.",
    ['no_controlled_territories'] = "~r~Votre organisation ne contrôle aucun territoire.",
    ['territory_influence_gained'] = "Influence territoire ~g~+%s~s~ (%s)",
    ['not_enough_members_to_claim'] = "~r~Vous devez être au moins %d membres connectés pour revendiquer.",
    ['leaders_not_present'] = "~r~Les leaders ne semblent pas présent.. réessaye plus tard.",
    ['not_in_territory'] = "~r~Vous n'êtes pas sur un territoire.",
    ['you_already_claimed_today'] = "~r~Vous avez déjà revendiqué une zone aujourd'hui.",
    ['crew_claimed_territory'] = "Votre organisation a revendiqué le territoire de ~b~%s~s~ et a gagné ~g~%d points~s~.",

    -- Tooltip (NUI)
    ['tooltip_frequentation'] = 'Fréquentation',
    ['tooltip_competition'] = 'Concurrence',
    ['tooltip_crew_leader'] = 'Crew Leader',
    ['level_low'] = 'Faible',
    ['level_normal'] = 'Normal',
    ['level_high'] = 'Forte',
    ['none'] = 'Aucune',

    -- Descriptions de territoires (utilisées dans le tooltip via id)
    ['territory_desc_vespucci_plage_sud'] = "Une plage iconique inspirée de Santa Monica : Muscle Sands, le skate-park et le marché en bord de mer attirent touristes et artistes en journée. La nuit, la foule s’efface, les commerces ferment et l’endroit gagne en intimité, où seuls quelques feux de camp ou hipsters persistent sur le sable.",
    ['territory_desc_vespucci_plage_nord'] = "Zone plus raffinée avec marina, canaux et petites boutiques : une ambiance paisible idéale pour se fondre dans le décor. Le quartier, moins exposé à l’agitation touristique, offre un cadre parfait pour des rencontres discrètes ou des regroupements à l'écart.",
    ['territory_desc_aeroport'] = "Aéroport international de Los Santos, avec de vastes terminaux, pistes sécurisées, zones de fret et traffic constant. Malgré une sécurité renforcée, les hangars périphériques, les routes de service et les points d’accès multiples en font un lieu parfait pour opérer sous couvert.",
    ['territory_desc_wardogs'] = "Au cœur des docks industriels, les quais bruissent de l’activité des poids lourds et des entrepôts. Le jour, l’endroit est un ballet organisé de camions et d’ouvriers. La nuit, l’usine se vide, les hangars se ferment, et les ombres prennent le relais, offrant un terrain propice aux manœuvres clandestines.",
    ['territory_desc_mazebank'] = "Secteur autour de l’Arena de Maze Bank, lieu de tournage pour les auditions de 'Fame or Shame' ou les courses de l’Arena War. Allées larges, parkings vastes et accès discrets créent une toile de fond idéale pour se mêler à la foule ou disparaître selon l'affluence.",
    ['territory_desc_sud_de_los_santos'] = "Secteur urbain dense mêlant garages, habitations modestes et artères routières. Activité constante et circulation lourde; présence policière variable — parfait pour opérations rapides et embuscades.",
    ['territory_desc_centre_ville'] = "Cœur de Los Santos, gratte‑ciel, sièges de firmes et rues animées. Entre les tours: parkings et accès de service, parfaits pour une surveillance discrète ou des échanges sous le radar.",
    ['territory_desc_little_seoul'] = "Quartier dense d’inspiration coréenne, ruelles étroites, supérettes et restos. Flux piétonnier soutenu et parkings souterrains: multiples raccourcis, zones d’ombre et cachettes naturelles.",
    ['territory_desc_universite'] = "Campus verdoyant, bibliothèques et résidences. Calme apparent mais circulation régulière: accès secondaires propices aux filatures et rencontres furtives.",
    ['territory_desc_vinewood'] = "Villas cossues et panoramas. Routes en lacets et points de vue stratégiques — un terrain privilégié pour surveiller ou disparaître sans trace.",
    ['territory_desc_mirror_park'] = "Havre de sérénité autour d’un lac, cafés et petites boutiques. Calme ponctué par le clapotis de l’eau — idéal pour rendez‑vous discrets ou observation paisible.",

    -- =============================================================
    -- VENTES DE DROGUES / INTERACTIONS PNJ
    -- =============================================================
    ['press_to_sell_drugs'] = "Appuyez sur ~INPUT_CONTEXT~ pour ~b~vendre votre drogue~s~.",
    ['sell_drugs_to_ped'] = "Vendre de la drogue",
    ['sell_drugs_notification'] = "Vous avez vendu ~b~x(%d) %s~s~ pour ~g~%d$~s~.",
    ['not_enough_drugs'] = "~r~Vous n'avez plus de drogues.",
    ['activated_drug_sale'] = "Vous avez ~b~activé~s~ la vente de drogues.",
    ['deactivated_drug_sale'] = "Vous avez ~r~désactivé~s~ la vente de drogues.",
    ['no_drugs'] = "~r~Vous devez avoir de la drogue sur vous.",
    ['person_doesnt_want_drugs'] = "~r~La personne ne veut pas de votre marchandise.",
    ['must_be_in_territory_to_sell'] = "~r~Vous devez être sur un territoire pour vendre de la drogue.",
    ['someone_selling_drugs'] = "Allô !? C'est %s, %s ~r~%s~s~!",

    -- PNJ/ALERTES VARIANTES (CLAIMS & DEALS)
    ['crew_claiming_territory'] = "Allô !? C'est %s, %s ~r~%s~s~!",
    ['alert_deal_ming'] = "y'a du monde qui deal à",
    ['alert_claim_ming'] = "Une organisation revendique",
    ['alert_deal_dante'] = "je suis sûr d'avoir vu de la drogue circuler à",
    ['alert_claim_dante'] = "T'as vu ça ? Une organisation prend le contrôle de",
    ['alert_deal_flores'] = "Hermano y'a des types louches qui deal à",
    ['alert_claim_flores'] = "Quelqu'un essaie de revendiquer",
    ['alert_deal_majo'] = "y'a des pequenots qui vendent à",
    ['alert_claim_majo'] = "Une organisation a revendiqué le territoire de",

    -- =============================================================
    -- ERREURS / DEBUG / CONFIG
    -- =============================================================
    ['error_money_nil'] = "Erreur : la variable 'money' est nulle.",
    ['error_xplayer_item_nil'] = "Erreur : xPlayer est nul ou l'item est nul.",
    ['error_creating_leader_rank'] = "Erreur lors de la création du grade chef.",
    ['error_fetching_crew_id'] = "Erreur lors de la récupération de l'ID du crew.",
    ['crew_name_already_exists'] = "Un crew avec ce nom existe déjà.",
    ['no_drug_command_defined'] = 'Aucune commande de vente de drogue n\'a été définie dans la configuration.',

    -- RESTORE / RESET TERRITOIRES (INFO)
    ['last_reset_timestamp'] = "Horodatage de la dernière réinitialisation : %s",
    ['time_difference'] = "Différence de temps : %s secondes",
    ['updated_last_reset'] = "Date de la dernière réinitialisation mise à jour.",
    ['deleted_territory_rows'] = "%d lignes ont été supprimées de la table territoires.",

    -- =============================================================
    -- NIVEAUX / XP CREW
    -- =============================================================
    ['crew_level_not_enough'] = "~r~Votre organisation n'a pas le niveau nécessaire pour faire cette action.",

    -- =============================================================
    -- GESTION DES TERRITOIRES (ADMIN)
    -- =============================================================
    ['territory_management'] = 'Gestion des territoires',
    ['existing_territories'] = 'Territoires existants',
    ['create_new_territory'] = '~g~Créer un nouveau territoire',
    ['no_territories_found'] = '~r~Aucun territoire trouvé',
    ['loading'] = '~y~Chargement...',
    ['territory_configuration'] = 'Configuration du territoire',
    ['territory_name'] = 'Nom',
    ['territory_name_desc'] = 'Entrer le ~b~nom~s~ de votre territoire.',
    ['territory_id'] = 'ID',
    ['territory_id_desc'] = 'Entrer le nom de la ~b~photo~s~ du territoire.',
    ['territory_description'] = 'Description',
    ['territory_description_desc'] = 'Entrer la ~b~description~s~ de votre territoire.',
    ['territory_frequentation'] = 'Fréquentation',
    ['territory_frequentation_low'] = '~y~low~s~',
    ['territory_frequentation_normal'] = '~g~normal~s~',
    ['territory_frequentation_high'] = '~r~high~s~',
    ['continue_to_creation'] = '~g~Continuer vers la création',
    ['continue_to_creation_desc'] = 'Passer au placement des points',
    ['name_and_id_required'] = '~r~Nom et ID requis',
    ['polygon_construction'] = 'Construction du polygone',
    ['add_point'] = 'Ajouter un point (position joueur).',
    ['add_point_desc'] = 'Ajoute votre position ~b~XY~s~ au polygone',
    ['point_added'] = 'Point #%d ajouté',
    ['create_territory'] = '~g~Créer le territoire',
    ['create_territory_desc'] = 'Voulez-vous vraiment ~g~enregistrer~s~ le territoire ?',
    ['minimum_3_points'] = '~r~Minimum 3 points',
    ['territory_editing'] = 'Édition du territoire',
    ['modify_points'] = '~o~Modifier les points',
    ['current_points'] = 'Points actuels:~g~ %d',
    ['validate'] = '~g~Valider',
    ['validate_desc'] = 'Sauvegarder les modifications',
    ['delete'] = '~r~Supprimer',
    ['delete_desc'] = 'Voulez-vous vraiment ~r~supprimer~s~ ce territoire ?',
    ['point_modification'] = 'Modification des points',
    ['click_to_replace'] = 'Cliquer pour ~b~remplacer~s~ par votre position',
    ['point_updated'] = 'Point #%d mis à jour',
    ['validate_modifications'] = '~g~Valider les modifications',
    ['validate_modifications_desc'] = 'Retourner au menu d\'édition',
    ['access_denied_admin'] = '~r~Accès refusé (admin uniquement)',
    ['territory_saved'] = '~g~Territoire enregistré',
    ['territory_updated'] = '~g~Territoire modifié',
    ['territory_deleted'] = '~g~Territoire supprimé',
    ['error'] = '~r~Erreur: %s',
    
    -- Commandes setcrew
    ['setcrew_access_denied'] = '~r~Accès refusé (admin uniquement)',
    ['setcrew_usage'] = '~r~Usage: /setcrew [ID_JOUEUR] [NOM_ORGA] [RANG]',
    ['setcrew_invalid_id'] = '~r~ID du joueur invalide',
    ['setcrew_player_not_found'] = '~r~Joueur non trouvé',
    ['setcrew_crew_not_found'] = '~r~Organisation "%s" non trouvée',
    ['setcrew_grade_not_found'] = '~r~Grade "%s" non trouvé dans l\'organisation "%s"',
    ['setcrew_success'] = '~g~Joueur %s ajouté à l\'organisation "%s" avec le grade "%s"',
    ['setcrew_success_target'] = '~g~Vous avez été ajouté à l\'organisation "%s" avec le grade "%s"',
    ['setcrew_error'] = '~r~Erreur lors de l\'ajout du joueur à l\'organisation',
    
    -- Commandes deletecrew
    ['deletecrew_access_denied'] = '~r~Accès refusé (chef d\'organisation ou admin uniquement)',
    ['deletecrew_usage'] = '~r~Usage: /deletecrew [NOM_ORGA] (admin uniquement)',
    ['deletecrew_not_in_crew'] = '~r~Vous n\'êtes pas dans une organisation',
    ['deletecrew_not_leader'] = '~r~Vous n\'êtes pas le chef de votre organisation',
    ['deletecrew_crew_not_found'] = '~r~Organisation "%s" non trouvée',
    ['deletecrew_success'] = '~g~Organisation "%s" supprimée avec succès',
    ['deletecrew_success_leader'] = '~g~Votre organisation "%s" a été supprimée',
    ['deletecrew_error'] = '~r~Erreur lors de la suppression de l\'organisation',
    
    -- Messages d'erreur pour tgiann-inventory
    ['error_removing_item'] = "Erreur lors de la suppression de l'item",
    ['error_adding_money'] = "Erreur lors de l'ajout de l'argent",
    
    -- Messages pour la commande setownercrew
    ['setownercrew_no_permission'] = "~r~Vous n'avez pas les permissions pour utiliser cette commande",
    ['setownercrew_usage'] = "~r~Usage: /setownercrew [ID_JOUEUR] [NOM_ORGA_OU_ID]",
    ['setownercrew_invalid_id'] = "~r~ID du joueur invalide",
    ['setownercrew_player_not_found'] = "~r~Joueur introuvable",
    ['setownercrew_already_in_crew'] = "~r~Ce joueur est déjà dans une organisation",
    ['setownercrew_crew_not_found'] = "~r~Organisation introuvable",
    ['setownercrew_no_grades'] = "~r~Aucun grade trouvé pour cette organisation",
    ['setownercrew_success'] = "~g~Joueur ajouté à l'organisation \"%s\" avec le grade le plus élevé",
    ['setownercrew_target_notification'] = "~g~Vous avez été ajouté à l'organisation \"%s\"",
    ['setownercrew_error'] = "~r~Erreur lors de l'ajout à l'organisation",
}
