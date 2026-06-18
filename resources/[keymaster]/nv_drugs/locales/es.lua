Locales['es'] = {
    -- =============================================================
    -- GENERAL / ETIQUETAS COMUNES
    -- =============================================================
    ['crew'] = 'Crew',
    ['information'] = 'Información',
    ['actions'] = 'Acciones',
    ['name'] = 'Nombre',
    ['rank'] = 'Rango',
    ['yes'] = 'Sí',
    ['no'] = 'No',
    ['exclude'] = 'Excluir',
    ['no_nearby_player'] = 'No hay jugadores cercanos.',
    ['motto'] = 'Lema',
    ['recruit_someone'] = 'Reclutar a alguien',
    ['exclude_someone'] = 'Excluir a alguien',

    -- =============================================================
    -- MENÚS DE CREW / CREACIÓN / RANGOS
    -- =============================================================
    ['list_of_members'] = 'Lista de miembros',
    ['ranks_list'] = 'Lista de rangos',
    ['crew_controlled_territories'] = 'Territorios controlados',
    ['ranks'] = 'Rangos',
    ['create_crew'] = '~g~Crear el crew',
    ['enter_crew_name'] = 'Nombre del Crew',
    ['enter_crew_motto'] = 'Lema del Crew',
    ['enter_rank_name'] = 'Nombre del Rango',
    ['enter_rank_name_leader'] = 'Nombre del Rango Líder',
    ['must_fill_all_fields'] = 'Debes completar todos los campos.',
    ['create_another_rank'] = '~g~Crear otro rango',
    ['delete_rank'] = '~r~Eliminar el rango',
    ['deleted_rank'] = 'Has eliminado el rango ~b~%s~s~ y expulsado a todos los miembros que lo tenían.',
    ['rename_rank'] = 'Renombrar Rango',
    ['enter_new_rank_name'] = 'Ingrese el nuevo nombre del rango',
    ['rank_name_changed'] = 'El nombre del rango ha sido cambiado a ~b~%s~s~.',
    ['rank_name_already_exists'] = 'Ya existe un rango con este nombre en este crew.',
    ['leader'] = 'Líder | %s',
    ['leader2'] = 'Jefe',

    -- =============================================================
    -- COLOR DEL CREW (PICKER)
    -- =============================================================
    ['crew_color'] = 'Color',
    ['crew_color_desc'] = 'Elige el color de tu crew.',
    ['crew_color_selected'] = 'Color seleccionado: %s',

    -- =============================================================
    -- ACCESOS / PERMISOS
    -- =============================================================
    ['access_crew_management'] = 'Acceder a la gestión del crew',
    ['access_properties'] = 'Acceder a las propiedades',
    ['access_property_chest'] = 'Acceder al cofre de las propiedades',
    ['access_vehicle_keys'] = 'Acceder a las llaves de vehículos',
    ['access_vehicle_sales'] = 'Acceder a la venta de vehículos',
    ['give_access_to'] = 'Le has dado acceso a %s con el rango ~b~%s~s~.',
    ['remove_access_from'] = 'Le has retirado el acceso a %s con el rango ~b~%s~s~.',
    ['changed_player_rank'] = 'Has asignado el rango ~b~%s~s~ a ~b~%s~s~.',

    -- =============================================================
    -- INVITACIONES / ADHESIÓN
    -- =============================================================
    ['accept_invite'] = "¿Quieres unirte al crew ~b~%s~s~?\n~g~Y~s~: Aceptar\n~r~X~s~: Rechazar",
    ['too_long_to_respond'] = 'Te has tomado demasiado tiempo para decidir.',
    ['you_declined_invite'] = 'Has rechazado unirte al crew.',
    ['you_joined_crew'] = 'Te has unido al crew ~b~%s~s~.',
    ['invited_player_to_crew'] = 'Has invitado a ~b~%s~s~ a unirse a tu crew.',
    ['accepted_crew_invite'] = '~b~%s~s~ ha aceptado unirse a tu crew.',
    ['declined_crew_invite'] = 'La persona ha rechazado unirse a tu crew.',
    ['invite_timeout'] = 'La persona se ha tomado demasiado tiempo para decidir.',
    ['invite_expired'] = 'La invitación ha expirado.',

    -- =============================================================
    -- MIEMBROS / ESTADO DEL CREW
    -- =============================================================
    ['you_created_crew'] = 'Has creado el crew ~b~%s~s~ con el lema ~b~%s~s~ y ~b~%d~s~ rangos.',
    ['you_left_crew'] = 'Has decidido ~r~dejar~s~ tu crew.',
    ['not_in_crew'] = 'No perteneces a ningún crew.',
    ['already_in_crew'] = 'Ya estás en un crew.',
    ['player_already_in_crew'] = 'La persona ya está en un crew.',
    ['you_were_kicked'] = 'Has sido ~b~expulsado~s~ de tu crew.',
    ['cannot_kick_creator'] = 'No puedes ~b~expulsar~s~ al creador del crew.',
    ['kicked_player'] = 'Has ~b~expulsado~s~ a la persona de tu crew.',

    -- Creación de crew (modo grado/discord)
    ['cannot_create_crew'] = '~r~No puedes crear un crew.',
    ['creation_restricted_admin'] = '~r~Solo los administradores pueden crear un crew.',
    ['creation_restricted_discord_config_missing'] = '~r~Configuración de Discord incompleta. Contacta a un administrador.',
    ['no_discord_linked'] = '~r~Tu cuenta de Discord no está vinculada (identificador de Discord faltante).',
    ['discord_role_missing'] = '~r~No tienes el rol de Discord requerido para crear un crew.',

    -- =============================================================
    -- TERRITORIOS / MAPA / RECLAMOS
    -- =============================================================
    ['territory'] = 'Territorio',
    ['ranking'] = 'Clasificación - ~b~%s',
    ['claim_territory'] = '~r~Reclamar %s',
    ['claim_territory_desc'] = 'Reclamar este territorio para tu ~b~crew',
    ['must_be_in_crew'] = 'Debes estar en un crew para abrir este menú.',
    ['no_controlled_territories'] = 'Tu crew no controla ningún territorio.',
    ['not_enough_members_to_claim'] = 'No sois suficientes para reclamar este territorio.',
    ['leaders_not_present'] = 'Los líderes no parecen estar presentes... inténtalo más tarde.',
    ['not_in_territory'] = 'No estás en un territorio.',
    ['you_already_claimed_today'] = 'Ya has reclamado una zona hoy.',
    ['crew_claimed_territory'] = 'Tu crew ha reclamado el territorio de ~b~%s~s~ y ha ganado ~g~%d puntos~s~.',

    -- Tooltip (NUI)
    ['tooltip_frequentation'] = 'Frecuencia',
    ['tooltip_competition'] = 'Competencia',
    ['tooltip_crew_leader'] = 'Líder de Crew',
    ['level_low'] = 'Baja',
    ['level_normal'] = 'Normal',
    ['level_high'] = 'Alta',
    ['none'] = 'Ninguna',

    -- Descripciones de territorios (usadas por el tooltip vía id)
    ['territory_desc_vespucci_plage_sud'] = 'Playa icónica inspirada en Santa Mónica: Muscle Sands, skate-park y mercado frente al mar atraen turistas y artistas de día. De noche, las tiendas cierran y el lugar se vuelve íntimo, con algunas fogatas o hipsters en la arena.',
    ['territory_desc_vespucci_plage_nord'] = 'Zona más refinada con marina, canales y pequeñas tiendas: ambiente tranquilo ideal para pasar desapercibido. Menos turistas, perfecto para encuentros discretos o reagruparse lejos de miradas.',
    ['territory_desc_aeroport'] = 'Aeropuerto Internacional de Los Santos: grandes terminales, pistas seguras y tráfico constante. Pese a la seguridad, los hangares laterales y accesos múltiples permiten operar bajo el radar.',
    ['territory_desc_wardogs'] = 'En los muelles industriales: camiones y almacenes durante el día. Por la noche, el lugar se vacía y las sombras mandan — terreno ideal para maniobras clandestinas.',
    ['territory_desc_mazebank'] = 'Alrededor del Maze Bank Arena: rodajes de “Fame or Shame” o carreras del Arena War. Calles anchas, aparcamientos enormes y accesos discretos; perfecto para mezclarse o desaparecer según la afluencia.',
    ['territory_desc_sud_de_los_santos'] = 'Sector urbano denso con garajes, viviendas modestas y arterias principales. Actividad constante y tráfico pesado; presencia policial variable — ideal para operaciones rápidas y emboscadas.',
    ['territory_desc_centre_ville'] = 'Centro de Los Santos con rascacielos y sedes corporativas. Entre torres: aparcamientos y accesos de servicio — perfecto para vigilancia discreta o intercambios fuera del radar.',
    ['territory_desc_little_seoul'] = 'Barrio denso de inspiración coreana, callejones estrechos y tiendas locales. Gran flujo peatonal y parkings subterráneos: atajos, zonas de sombra y escondites naturales.',
    ['territory_desc_universite'] = 'Campus verde con bibliotecas y residencias. Calma aparente, flujo regular; múltiples accesos secundarios — idóneo para seguimientos o encuentros furtivos.',
    ['territory_desc_vinewood'] = 'Villas lujosas y vistas espectaculares. Carreteras serpenteantes y miradores estratégicos — perfecto para vigilar o desaparecer sin dejar rastro.',
    ['territory_desc_mirror_park'] = 'Remanso de paz con lago, cafés y pequeñas tiendas. El chapoteo del agua crea un ambiente ideal para citas discretas u observación tranquila.',

    -- =============================================================
    -- VENTA DE DROGAS / INTERACCIONES NPC
    -- =============================================================
    ['press_to_sell_drugs'] = 'Presiona ~INPUT_CONTEXT~ para ~b~vender tus drogas~s~.',
    ['sell_drugs_to_ped'] = 'Vender drogas',
    ['sell_drugs_notification'] = 'Has vendido ~b~x(%d) %s~s~ por ~g~%d$~s~.',
    ['not_enough_drugs'] = 'No tienes más drogas.',
    ['activated_drug_sale'] = 'Has ~b~activado~s~ la venta de drogas.',
    ['deactivated_drug_sale'] = 'Has ~r~desactivado~s~ la venta de drogas.',
    ['no_drugs'] = 'Debes tener drogas contigo.',
    ['person_doesnt_want_drugs'] = 'La persona no quiere tu mercancía.',
    ['someone_selling_drugs'] = '¿Hola!? Es %s, %s ~r~%s~s~!',

    -- Variantes de alertas (reclamos y ventas)
    ['crew_claiming_territory'] = '¿Hola!? Es %s, %s ~r~%s~s~!',
    ['alert_deal_ming'] = 'Hay gente vendiendo en',
    ['alert_claim_ming'] = 'Un crew está reclamando',
    ['alert_deal_dante'] = 'Estoy seguro de haber visto drogas circulando en',
    ['alert_claim_dante'] = '¿Lo viste? Un crew está tomando el control de',
    ['alert_deal_flores'] = 'Hermano, hay tipos sospechosos vendiendo en',
    ['alert_claim_flores'] = 'Alguien está intentando reclamar',
    ['alert_deal_majo'] = 'Hay paletos vendiendo en',
    ['alert_claim_majo'] = 'Un crew ha reclamado el territorio de',

    -- =============================================================
    -- ERRORES / DEBUG / CONFIG
    -- =============================================================
    ['error_money_nil'] = "Error: la variable 'money' es nula.",
    ['error_xplayer_item_nil'] = 'Error: xPlayer o el objeto es nulo.',
    ['error_creating_leader_rank'] = 'Error al crear el rango líder.',
    ['error_fetching_crew_id'] = 'Error al obtener el ID del crew.',
    ['crew_name_already_exists'] = 'Ya existe un crew con ese nombre.',
    ['no_drug_command_defined'] = 'No se ha definido ningún comando de venta de drogas en la configuración.',

    -- RESTAURAR / REINICIO DE TERRITORIOS (INFO)
    ['last_reset_timestamp'] = 'Marca de tiempo del último reinicio: %s',
    ['time_difference'] = 'Diferencia de tiempo: %s segundos',
    ['updated_last_reset'] = 'Fecha del último reinicio actualizada.',
    ['deleted_territory_rows'] = '%d filas eliminadas de la tabla de territorios.',

    -- =============================================================
    -- NIVELES / XP DEL CREW
    -- =============================================================
    ['crew_level_not_enough'] = 'Tu crew no tiene el nivel necesario para realizar esta acción.',

    -- =============================================================
    -- GESTIÓN DE TERRITORIOS (ADMIN)
    -- =============================================================
    ['territory_management'] = 'Gestión de territorios',
    ['existing_territories'] = 'Territorios existentes',
    ['create_new_territory'] = '~g~Crear un nuevo territorio',
    ['no_territories_found'] = '~r~No se encontraron territorios',
    ['loading'] = '~y~Cargando...',
    ['territory_configuration'] = 'Configuración del territorio',
    ['territory_name'] = 'Nombre',
    ['territory_name_desc'] = 'Introduce el ~b~nombre~s~ de tu territorio.',
    ['territory_id'] = 'ID',
    ['territory_id_desc'] = 'Introduce el nombre de la ~b~imagen~s~ del territorio.',
    ['territory_description'] = 'Descripción',
    ['territory_description_desc'] = 'Introduce la ~b~descripción~s~ de tu territorio.',
    ['territory_frequentation'] = 'Frecuencia',
    ['territory_frequentation_low'] = '~y~baja~s~',
    ['territory_frequentation_normal'] = '~g~normal~s~',
    ['territory_frequentation_high'] = '~r~alta~s~',
    ['continue_to_creation'] = '~g~Continuar a la creación',
    ['continue_to_creation_desc'] = 'Proceder al posicionamiento de puntos',
    ['name_and_id_required'] = '~r~Nombre e ID requeridos',
    ['polygon_construction'] = 'Construcción del polígono',
    ['add_point'] = 'Añadir un punto (posición del jugador).',
    ['add_point_desc'] = 'Añade tu posición ~b~XY~s~ al polígono',
    ['point_added'] = 'Punto #%d añadido',
    ['create_territory'] = '~g~Crear el territorio',
    ['create_territory_desc'] = '¿Realmente quieres ~g~guardar~s~ el territorio?',
    ['minimum_3_points'] = '~r~Mínimo 3 puntos',
    ['territory_editing'] = 'Edición del territorio',
    ['modify_points'] = '~o~Modificar puntos',
    ['current_points'] = 'Puntos actuales:~g~ %d',
    ['validate'] = '~g~Validar',
    ['validate_desc'] = 'Guardar modificaciones',
    ['delete'] = '~r~Eliminar',
    ['delete_desc'] = '¿Realmente quieres ~r~eliminar~s~ este territorio?',
    ['point_modification'] = 'Modificación de puntos',
    ['click_to_replace'] = 'Hacer clic para ~b~reemplazar~s~ con tu posición',
    ['point_updated'] = 'Punto #%d actualizado',
    ['validate_modifications'] = '~g~Validar modificaciones',
    ['validate_modifications_desc'] = 'Volver al menú de edición',
    ['access_denied_admin'] = '~r~Acceso denegado (solo admin)',
    ['territory_saved'] = '~g~Territorio guardado',
    ['territory_updated'] = '~g~Territorio actualizado',
    ['territory_deleted'] = '~g~Territorio eliminado',
    ['error'] = '~r~Error: %s',
    
    -- Comandos setcrew
    ['setcrew_access_denied'] = '~r~Acceso denegado (solo admin)',
    ['setcrew_usage'] = '~r~Uso: /setcrew [ID_JUGADOR] [NOMBRE_CREW] [RANGO]',
    ['setcrew_invalid_id'] = '~r~ID de jugador inválido',
    ['setcrew_player_not_found'] = '~r~Jugador no encontrado',
    ['setcrew_crew_not_found'] = '~r~Crew "%s" no encontrado',
    ['setcrew_grade_not_found'] = '~r~Grado "%s" no encontrado en el crew "%s"',
    ['setcrew_success'] = '~g~Jugador %s añadido al crew "%s" con grado "%s"',
    ['setcrew_success_target'] = '~g~Has sido añadido al crew "%s" con grado "%s"',
    ['setcrew_error'] = '~r~Error al añadir jugador al crew',
    
    -- Comandos deletecrew
    ['deletecrew_access_denied'] = '~r~Acceso denegado (líder de crew o admin únicamente)',
    ['deletecrew_usage'] = '~r~Uso: /deletecrew [NOMBRE_CREW] (solo admin)',
    ['deletecrew_not_in_crew'] = '~r~No estás en un crew',
    ['deletecrew_not_leader'] = '~r~No eres el líder de tu crew',
    ['deletecrew_crew_not_found'] = '~r~Crew "%s" no encontrado',
    ['deletecrew_success'] = '~g~Crew "%s" eliminado con éxito',
    ['deletecrew_success_leader'] = '~g~Tu crew "%s" ha sido eliminado',
    ['deletecrew_error'] = '~r~Error al eliminar crew',
    
    -- Mensajes de error para tgiann-inventory
    ['error_removing_item'] = "Error al eliminar el objeto",
    ['error_adding_money'] = "Error al agregar dinero",
    
    -- Mensajes para el comando setownercrew
    ['setownercrew_no_permission'] = "~r~No tienes permisos para usar este comando",
    ['setownercrew_usage'] = "~r~Uso: /setownercrew [ID_JUGADOR] [NOMBRE_CREW_O_ID]",
    ['setownercrew_invalid_id'] = "~r~ID de jugador inválido",
    ['setownercrew_player_not_found'] = "~r~Jugador no encontrado",
    ['setownercrew_already_in_crew'] = "~r~Este jugador ya está en un crew",
    ['setownercrew_crew_not_found'] = "~r~Crew no encontrado",
    ['setownercrew_no_grades'] = "~r~No se encontraron rangos para este crew",
    ['setownercrew_success'] = "~g~Jugador agregado al crew \"%s\" con el rango más alto",
    ['setownercrew_target_notification'] = "~g~Has sido agregado al crew \"%s\"",
    ['setownercrew_error'] = "~r~Error al agregar al crew",
}
