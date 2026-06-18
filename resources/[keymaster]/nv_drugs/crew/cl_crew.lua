
if Config and Config.ESXMode == "old" then
  ESX = ESX or nil
  TriggerEvent("esx:getSharedObject", function(obj)
      ESX = obj
  end)
else
  ESX = exports.es_extended:getSharedObject()
end


MenuData = {
  SlideRang = 1,
  SlideExclure = 1,
  GetMembres = {},
  GetAllRang = {},
  InfosCrew = {},
  GetInfoGrade = {},
  ShowXPBar = true,
  Level = nil,
  openedMenu = false
}


local bannerCrew = Config.BannerCrew
local bannerTerritories = Config.BannerTerritories
local bannerTexture = "interaction_bgd2"


if bannerCrew and bannerCrew ~= "without" then
  MenuData.mainMenu = RageUI.CreateMenu("", " ", nil, 100, bannerCrew, bannerTexture)
  MenuData.subMenuInfos = RageUI.CreateSubMenu(MenuData.mainMenu, "", _U("information"), nil, 100, bannerCrew, bannerTexture)
  MenuData.subMenuListeMembres = RageUI.CreateSubMenu(MenuData.mainMenu, "", _U("list_of_members"), nil, 100, bannerCrew, bannerTexture)
  MenuData.subMenuEditMembres = RageUI.CreateSubMenu(MenuData.subMenuListeMembres, "", _U("crew"), nil, 100, bannerCrew, bannerTexture)
  MenuData.subMenuEditRang = RageUI.CreateSubMenu(MenuData.mainMenu, "", _U("crew"), nil, 100, bannerCrew, bannerTexture)
  MenuData.subMenuActions = RageUI.CreateSubMenu(MenuData.mainMenu, "", _U("actions"), nil, 100, bannerCrew, bannerTexture)

  if bannerTerritories and bannerTerritories ~= "without" then
      MenuData.subMenuTerritoires = RageUI.CreateSubMenu(MenuData.mainMenu, "", _U("crew_controlled_territories"), nil, 100, bannerTerritories, bannerTexture)
  else
      MenuData.subMenuTerritoires = RageUI.CreateSubMenu(MenuData.mainMenu, "", _U("crew_controlled_territories"), nil, 100, bannerCrew, bannerTexture)
  end

  MenuData.subMenuListeRang = RageUI.CreateSubMenu(MenuData.mainMenu, "", _U("ranks_list"), nil, 100, bannerCrew, bannerTexture)
  MenuData.subMenuEditPermsRang = RageUI.CreateSubMenu(MenuData.subMenuListeRang, "", _U("crew"), nil, 100, bannerCrew, bannerTexture)
else
  MenuData.mainMenu = RageUI.CreateMenu(_U("crew"), _U("crew"))
  MenuData.subMenuInfos = RageUI.CreateSubMenu(MenuData.mainMenu, _U("crew"), _U("information"))
  MenuData.subMenuListeMembres = RageUI.CreateSubMenu(MenuData.mainMenu, _U("crew"), _U("list_of_members"))
  MenuData.subMenuEditMembres = RageUI.CreateSubMenu(MenuData.subMenuListeMembres, _U("crew"), _U("crew"))
  MenuData.subMenuEditRang = RageUI.CreateSubMenu(MenuData.mainMenu, _U("crew"), _U("crew"))
  MenuData.subMenuActions = RageUI.CreateSubMenu(MenuData.mainMenu, _U("crew"), _U("actions"))
  MenuData.subMenuTerritoires = RageUI.CreateSubMenu(MenuData.mainMenu, _U("crew"), _U("crew_controlled_territories"))
  MenuData.subMenuListeRang = RageUI.CreateSubMenu(MenuData.mainMenu, _U("crew"), _U("ranks_list"))
  MenuData.subMenuEditPermsRang = RageUI.CreateSubMenu(MenuData.subMenuListeRang, _U("crew"), _U("crew"))
end


local menuBannerColor = Config.MenuBannerColor or {r = 139, g = 0, b = 0, a = 180}
local territoryMenuColor = Config.TerritoryMenuColor or {r = 0, g = 100, b = 0, a = 180}


if not bannerCrew or bannerCrew == "without" then
  MenuData.mainMenu:SetRectangleBanner(menuBannerColor.r, menuBannerColor.g, menuBannerColor.b, menuBannerColor.a)
  MenuData.subMenuInfos:SetRectangleBanner(menuBannerColor.r, menuBannerColor.g, menuBannerColor.b, menuBannerColor.a)
  MenuData.subMenuListeMembres:SetRectangleBanner(menuBannerColor.r, menuBannerColor.g, menuBannerColor.b, menuBannerColor.a)
  MenuData.subMenuEditMembres:SetRectangleBanner(menuBannerColor.r, menuBannerColor.g, menuBannerColor.b, menuBannerColor.a)
  MenuData.subMenuEditRang:SetRectangleBanner(menuBannerColor.r, menuBannerColor.g, menuBannerColor.b, menuBannerColor.a)
  MenuData.subMenuActions:SetRectangleBanner(menuBannerColor.r, menuBannerColor.g, menuBannerColor.b, menuBannerColor.a)
  MenuData.subMenuListeRang:SetRectangleBanner(menuBannerColor.r, menuBannerColor.g, menuBannerColor.b, menuBannerColor.a)
  MenuData.subMenuEditPermsRang:SetRectangleBanner(menuBannerColor.r, menuBannerColor.g, menuBannerColor.b, menuBannerColor.a)

  if not bannerTerritories or bannerTerritories == "without" then
      MenuData.subMenuTerritoires:SetRectangleBanner(menuBannerColor.r, menuBannerColor.g, menuBannerColor.b, menuBannerColor.a)
  end
end


if bannerCrew and bannerCrew ~= "without" then
  MenuData.mainMenu:DisplayGlare(false)
  MenuData.subMenuInfos:DisplayGlare(false)
  MenuData.subMenuListeMembres:DisplayGlare(false)
  MenuData.subMenuEditMembres:DisplayGlare(false)
  MenuData.subMenuEditRang:DisplayGlare(false)
  MenuData.subMenuActions:DisplayGlare(false)
  MenuData.subMenuTerritoires:DisplayGlare(false)
  MenuData.subMenuListeRang:DisplayGlare(false)
  MenuData.subMenuEditPermsRang:DisplayGlare(false)
end


local crewMenuKey = Config.CrewMenuKey or 168


MenuData.mainMenu.Closed = function()
  MenuData.openedMenu = false
  TriggerEvent("crew:HideExpBar")
end


function KeyboardInput(prompt, maxLength)
  AddTextEntry("Message", prompt)
  DisplayOnscreenKeyboard(1, "Message", "", "", "", "", "", maxLength)
  blockinput = true

  while true do
      local status = UpdateOnscreenKeyboard()
      if status == 1 or status == 2 then
          break
      end
      Citizen.Wait(0)
  end

  if UpdateOnscreenKeyboard() ~= 2 then
      local result = GetOnscreenKeyboardResult()
      Citizen.Wait(500)
      blockinput = false
      return result
  else
      Citizen.Wait(500)
      blockinput = false
      return nil
  end
end

function GetNearbyPlayer(maxDistance)
  local playerPed = PlayerPedId()
  local playerCoords = GetEntityCoords(playerPed)
  local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

  if closestPlayer ~= -1 then
      maxDistance = maxDistance or 3.0
      if closestDistance <= maxDistance then
          return GetPlayerServerId(closestPlayer)
      end
  else
      ESX.ShowNotification(_U("no_nearby_player"))
      return nil
  end
end

function openCrew()
  if MenuData.openedMenu then
      MenuData.openedMenu = false
      RageUI.Visible(MenuData.mainMenu, false)
      TriggerEvent("crew:HideExpBar")
  else
      MenuData.openedMenu = true
      RageUI.Visible(MenuData.mainMenu, true)

      ESX.TriggerServerCallback("GetCrewExperience", function(experience)
          if experience then
              MenuData.Level = experience.level
              if MenuData.ShowXPBar then
                  TriggerEvent("crew:ShowExpBar", experience.name, experience.xp)
              end
          end
      end)

      Citizen.CreateThread(function()
          while MenuData.openedMenu do
              RageUI.IsVisible(MenuData.mainMenu, function()
                  RageUI.Button(_U("information"), nil, {RightLabel = "→"}, true, {
                      onSelected = function()
                          ESX.TriggerServerCallback("InfosCrew", function(crewInfo)
                              MenuData.InfosCrew = crewInfo
                          end)
                          ESX.TriggerServerCallback("GetAllRang", function(ranks)
                              MenuData.GetAllRang = ranks
                          end)
                          Wait(150)
                          RageUI.CloseAll()
                          RageUI.Visible(MenuData.subMenuInfos, true)
                      end
                  })

                  RageUI.Button(_U("actions"), nil, {RightLabel = "→"}, true, {}, MenuData.subMenuActions)

                  RageUI.Button(_U("list_of_members"), nil, {RightLabel = "→"}, true, {
                      onSelected = function()
                          ESX.TriggerServerCallback("ListeMembres", function(members)
                              MenuData.GetMembres = members
                          end)
                          Wait(150)
                          RageUI.CloseAll()
                          RageUI.Visible(MenuData.subMenuListeMembres, true)
                      end
                  })

                  RageUI.Button(_U("ranks_list"), nil, {RightLabel = "→"}, true, {
                      onSelected = function()
                          ESX.TriggerServerCallback("GetAllRang", function(ranks)
                              MenuData.GetAllRang = ranks
                          end)
                          Wait(150)
                          RageUI.CloseAll()
                          RageUI.Visible(MenuData.subMenuListeRang, true)
                      end
                  })

                  RageUI.Button(_U("crew_controlled_territories"), nil, {RightLabel = "→"}, true, {
                      onSelected = function()
                          MenuData.GetTerritoires = {}
                          MenuData.NextClaimTime = nil
                          ESX.TriggerServerCallback("GetCrewTerritories", function(territories, nextClaim)
                              MenuData.GetTerritoires = territories or {}
                              MenuData.NextClaimTime = nextClaim
                          end)
                          Wait(150)
                          RageUI.CloseAll()
                          RageUI.Visible(MenuData.subMenuTerritoires, true)
                      end
                  })
              end)

              RageUI.IsVisible(MenuData.subMenuTerritoires, function()
                  if MenuData.NextClaimTime then
                      RageUI.Separator("Dispo Revendication : ~b~" .. MenuData.NextClaimTime)
                  end

                  if MenuData.GetTerritoires and #MenuData.GetTerritoires > 0 then
                      for _, territory in pairs(MenuData.GetTerritoires) do
                          RageUI.Button(territory.name, nil, {RightLabel = "~g~" .. territory.points .. " points"}, true, {})
                      end
                  else
                      RageUI.Separator(_U("no_controlled_territories"))
                  end
              end)

              RageUI.IsVisible(MenuData.subMenuActions, function()
                  RageUI.Button(_U("recruit_someone"), nil, {}, true, {
                      onSelected = function()
                          local targetId = GetNearbyPlayer()
                          if targetId then
                              TriggerServerEvent("RecrutThePlayer", targetId)
                          end
                      end
                  })

                  RageUI.Button(_U("exclude_someone"), nil, {RightLabel = "→"}, true, {
                      onSelected = function()
                          local targetId = GetNearbyPlayer(2.0)
                          if targetId then
                              TriggerServerEvent("FireTarget", targetId)
                          end
                      end
                  })


                  print("[DEBUG] Drawing Actions Menu")

                  RageUI.Button("Revendiquer Territoire", "Nécessite ".. (Config.ClaimRequirements and Config.ClaimRequirements.MinOnlineToClaim or 4) .." membres connectés.", {RightLabel = "→"}, true, {
                      onSelected = function()
                          if IsPlayerInTerritory then
                              local inTerritory, territoryName = IsPlayerInTerritory()
                              if inTerritory and territoryName then
                                  TriggerServerEvent("cDrugs:ClaimTerritory", territoryName)
                              else
                                  ESX.ShowNotification("Vous n'êtes pas sur un territoire.")
                              end
                          else
                              print("^1[ERROR] IsPlayerInTerritory definition missing^0")
                          end
                      end
                  })

                  RageUI.Button("Modifier Couleur", nil, {RightLabel = "→"}, true, {
                      onSelected = function()
                           local input = lib.inputDialog('Couleur du Crew', {
                                {type = 'color', label = 'Couleur (HEX)', default = '#FFFFFF', format = 'hex'},
                            })

                            if input and input[1] then
                                TriggerServerEvent("crew:updateColor", input[1])
                            end
                      end
                  })
              end)

              RageUI.IsVisible(MenuData.subMenuListeRang, function()
                  RageUI.Button(_U("create_another_rank"), nil, {RightLabel = "→"}, true, {
                      onSelected = function()
                          local rankName = KeyboardInput(_U("enter_rank_name"), 30)
                          if rankName ~= nil then
                              TriggerServerEvent("AddNewRang", rankName)
                              RageUI.GoBack()
                          end
                      end
                  })

                  for _, rank in pairs(MenuData.GetAllRang) do
                      RageUI.Button(rank.name, nil, {RightLabel = rank.rang}, true, {
                          onSelected = function(hovered)
                              GradeName = rank.name
                              GradeRang = rank.rang
                              GradeID = rank.id_grade
                              AccesGestion = rank.gestion
                              AccesChest = rank.acces_chest
                              AccesProperty = rank.acces_property
                              AccesSellVeh = rank.sell_vehicle
                              AccesKeyVeh = rank.key_vehicle

                              MenuData.CheckboxGestion = (AccesGestion == 1)
                              MenuData.CheckboxChest = (AccesChest == 1)
                              MenuData.CheckboxProperty = (AccesProperty == 1)
                              MenuData.CheckboxSellVeh = (AccesSellVeh == 1)
                              MenuData.CheckboxKeyVeh = (AccesKeyVeh == 1)

                              Wait(150)
                              RageUI.CloseAll()
                              RageUI.Visible(MenuData.subMenuEditPermsRang, true)
                          end
                      })
                  end
              end)

              RageUI.IsVisible(MenuData.subMenuEditPermsRang, function()
                  if GradeRang == 1 then
                      RageUI.Button(_U("access_crew_management"), nil, {}, false, {})

                      if Config.nvProperty == true then
                          RageUI.Button(_U("access_properties"), nil, {}, false, {})
                          RageUI.Button(_U("access_property_chest"), nil, {}, false, {})
                      end

                      if Config.nvvehKeys == true then
                          RageUI.Button(_U("access_vehicle_keys"), nil, {}, false, {})
                          RageUI.Button(_U("access_vehicle_sales"), nil, {}, false, {})
                      end
                  else
                      RageUI.Button(_U("rename_rank"), nil, {RightLabel = GradeName}, true, {
                          onSelected = function()
                              local newName = KeyboardInput(_U("enter_new_rank_name"), 30)
                              if newName and newName ~= "" then
                                  ESX.TriggerServerCallback("CheckAndRenameGrade", function(success)
                                      if success then
                                          ESX.ShowNotification(_U("rank_name_changed", newName))
                                          GradeName = newName
                                          ESX.TriggerServerCallback("GetAllRang", function(ranks)
                                              MenuData.GetAllRang = ranks
                                          end)
                                      else
                                          ESX.ShowNotification(_U("rank_name_already_exists"))
                                      end
                                  end, newName, GradeID)
                              end
                          end
                      })

                      RageUI.Checkbox(_U("access_crew_management"), false, MenuData.CheckboxGestion, {}, {
                          onChecked = function()
                              TriggerServerEvent("UpdateAccesGestionCrew", 1, GradeID)
                              Wait(150)
                              ESX.TriggerServerCallback("GetAllRang", function(ranks)
                                  MenuData.GetAllRang = ranks
                              end)
                              ESX.ShowNotification(_U("give_access_to", _U("access_crew_management"), GradeName))
                          end,
                          onUnChecked = function()
                              TriggerServerEvent("UpdateAccesGestionCrew", 0, GradeID)
                              Wait(150)
                              ESX.TriggerServerCallback("GetAllRang", function(ranks)
                                  MenuData.GetAllRang = ranks
                              end)
                              ESX.ShowNotification(_U("remove_access_from", _U("access_crew_management"), GradeName))
                          end,
                          onSelected = function(checked)
                              MenuData.CheckboxGestion = checked
                          end
                      })

                      if Config.nvProperty == true then
                          RageUI.Checkbox(_U("access_properties"), false, MenuData.CheckboxProperty, {}, {
                              onChecked = function()
                                  TriggerServerEvent("UpdateAccesPropertyCrew", 1, GradeID)
                                  Wait(150)
                                  ESX.TriggerServerCallback("GetAllRang", function(ranks)
                                      MenuData.GetAllRang = ranks
                                  end)
                                  ESX.ShowNotification(_U("give_access_to", _U("access_properties"), GradeName))
                              end,
                              onUnChecked = function()
                                  TriggerServerEvent("UpdateAccesPropertyCrew", 0, GradeID)
                                  Wait(150)
                                  ESX.TriggerServerCallback("GetAllRang", function(ranks)
                                      MenuData.GetAllRang = ranks
                                  end)
                                  ESX.ShowNotification(_U("remove_access_from", _U("access_properties"), GradeName))
                              end,
                              onSelected = function(checked)
                                  MenuData.CheckboxProperty = checked
                              end
                          })

                          RageUI.Checkbox(_U("access_property_chest"), false, MenuData.CheckboxChest, {}, {
                              onChecked = function()
                                  TriggerServerEvent("UpdateAccesChestPropertyCrew", 1, GradeID)
                                  Wait(150)
                                  ESX.TriggerServerCallback("GetAllRang", function(ranks)
                                      MenuData.GetAllRang = ranks
                                  end)
                                  ESX.ShowNotification(_U("give_access_to", _U("access_property_chest"), GradeName))
                              end,
                              onUnChecked = function()
                                  TriggerServerEvent("UpdateAccesChestPropertyCrew", 0, GradeID)
                                  Wait(150)
                                  ESX.TriggerServerCallback("GetAllRang", function(ranks)
                                      MenuData.GetAllRang = ranks
                                  end)
                                  ESX.ShowNotification(_U("remove_access_from", _U("access_property_chest"), GradeName))
                              end,
                              onSelected = function(checked)
                                  MenuData.CheckboxChest = checked
                              end
                          })
                      end

                      if Config.nvvehKeys == true then
                          RageUI.Checkbox(_U("access_vehicle_keys"), false, MenuData.CheckboxKeyVeh, {}, {
                              onChecked = function()
                                  TriggerServerEvent("UpdateAccesKeyVehicleCrew", 1, GradeID)
                                  Wait(150)
                                  ESX.TriggerServerCallback("GetAllRang", function(ranks)
                                      MenuData.GetAllRang = ranks
                                  end)
                                  ESX.ShowNotification(_U("give_access_to", _U("access_vehicle_keys"), GradeName))
                              end,
                              onUnChecked = function()
                                  TriggerServerEvent("UpdateAccesKeyVehicleCrew", 0, GradeID)
                                  Wait(150)
                                  ESX.TriggerServerCallback("GetAllRang", function(ranks)
                                      MenuData.GetAllRang = ranks
                                  end)
                                  ESX.ShowNotification(_U("remove_access_from", _U("access_vehicle_keys"), GradeName))
                              end,
                              onSelected = function(checked)
                                  MenuData.CheckboxKeyVeh = checked
                              end
                          })

                          RageUI.Checkbox(_U("access_vehicle_sales"), false, MenuData.CheckboxSellVeh, {}, {
                              onChecked = function()
                                  TriggerServerEvent("UpdateAccesSellVehicleCrew", 1, GradeID)
                                  Wait(150)
                                  ESX.TriggerServerCallback("GetAllRang", function(ranks)
                                      MenuData.GetAllRang = ranks
                                  end)
                                  ESX.ShowNotification(_U("give_access_to", _U("access_vehicle_sales"), GradeName))
                              end,
                              onUnChecked = function()
                                  TriggerServerEvent("UpdateAccesSellVehicleCrew", 0, GradeID)
                                  Wait(150)
                                  ESX.TriggerServerCallback("GetAllRang", function(ranks)
                                      MenuData.GetAllRang = ranks
                                  end)
                                  ESX.ShowNotification(_U("remove_access_from", _U("access_vehicle_sales"), GradeName))
                              end,
                              onSelected = function(checked)
                                  MenuData.CheckboxSellVeh = checked
                              end
                          })
                      end

                      RageUI.Button(_U("delete_rank"), nil, {RightLabel = GradeName}, true, {
                          onSelected = function()
                              TriggerServerEvent("DeleteGrade", GradeID)
                              ESX.ShowNotification(_U("deleted_rank", GradeName))
                              RageUI.GoBack()
                          end
                      })
                  end
              end)

              RageUI.IsVisible(MenuData.subMenuInfos, function()
                  for _, crewInfo in pairs(MenuData.InfosCrew) do
                      RageUI.Button(_U("name"), nil, {RightLabel = crewInfo.name}, true, {})
                      RageUI.Button(_U("motto"), nil, {RightLabel = crewInfo.devise}, true, {})
                      RageUI.Button("ID " .. _U("crew"), nil, {RightLabel = crewInfo.id_crew}, true, {})
                  end

                  RageUI.Checkbox("Afficher l'expérience", nil, MenuData.ShowXPBar, {}, {
                      onChecked = function()
                          MenuData.ShowXPBar = true
                          ESX.TriggerServerCallback("GetCrewExperience", function(experience)
                              if experience then
                                  TriggerEvent("crew:ShowExpBar", experience.name, experience.xp)
                              end
                          end)
                      end,
                      onUnChecked = function()
                          MenuData.ShowXPBar = false
                          TriggerEvent("crew:HideExpBar")
                      end,
                      onSelected = function(checked)
                      end
                  })
              end)

              RageUI.IsVisible(MenuData.subMenuListeMembres, function()
                  for _, member in pairs(MenuData.GetMembres) do
                      RageUI.Button(member.label, nil, {RightLabel = member.label_grade}, true, {
                          onSelected = function()
                              Identifier = member.identifier
                              Label = member.label
                              IdCrew = member.id_crew
                              LabelGrade = member.label_grade
                              RangGrade = member.rang_grade
                              Wait(150)
                              RageUI.CloseAll()
                              RageUI.Visible(MenuData.subMenuEditMembres, true)
                          end
                      })
                  end
              end)

              RageUI.IsVisible(MenuData.subMenuEditMembres, function()
                  RageUI.Button(_U("name"), nil, {RightLabel = Label}, true, {})

                  if RangGrade ~= 1 then
                      RageUI.Button(_U("rank"), nil, {}, true, {
                          onSelected = function(hovered)
                              ESX.TriggerServerCallback("GetAllRang", function(ranks)
                                  MenuData.GetAllRang = ranks
                              end)
                              Wait(150)
                              RageUI.CloseAll()
                              RageUI.Visible(MenuData.subMenuEditRang, true)
                          end
                      })

                      RageUI.List(_U("exclude"), {_U("no"), _U("yes")}, MenuData.SlideExclure, nil, {}, true, {
                          onListChange = function(index)
                              MenuData.SlideExclure = index
                          end,
                          onSelected = function(index)
                              if index == 2 then
                                  TriggerServerEvent("FireThePlayer", Identifier)
                                  ESX.ShowNotification(_U("kicked_player"))
                                  RageUI.CloseAll()
                                  MenuData.openedMenu = false
                              end
                          end
                      })
                  else
                      RageUI.Button(_U("rank"), nil, {}, false, {})
                      RageUI.Button(_U("exclude"), nil, {}, false, {})
                  end
              end)

              RageUI.IsVisible(MenuData.subMenuEditRang, function()
                  for _, rank in pairs(MenuData.GetAllRang) do
                      if rank.rang == 1 then
                          RageUI.Button(rank.name, nil, {RightLabel = rank.rang}, false, {})
                      else
                          RageUI.Button(rank.name, nil, {RightLabel = rank.rang}, true, {
                              onSelected = function(hovered)
                                  TriggerServerEvent("EditRang", Identifier, rank.id_grade, rank.name, rank.rang)
                                  ESX.ShowNotification(_U("changed_player_rank", rank.name, Label))
                                  RageUI.CloseAll()
                                  MenuData.openedMenu = false
                              end
                          })
                      end
                  end
              end)

              Wait(1)
          end
      end)
  end
end

RegisterCommand("crew", function()
  ESX.TriggerServerCallback("GetPermGestion", function(hasPermission)
      if hasPermission == true then
          openCrew()
      end
  end)
end)

function CalculateCrewLevel(xp)
  local currentLevel = 1
  local xpCurrentLevel = 0
  local xpNextLevel = 0

  for level, xpRequired in pairs(Config.CrewLevels) do
      if xpRequired <= xp then
          currentLevel = level
      else
          break
      end
  end

  xpCurrentLevel = Config.CrewLevels[currentLevel] or 0
  xpNextLevel = Config.CrewLevels[currentLevel + 1] or xpCurrentLevel

  return currentLevel, xpCurrentLevel, xpNextLevel
end

RegisterNetEvent("crew:ShowExpBar")
AddEventHandler("crew:ShowExpBar", function(crewName, xp)
end)

RegisterNetEvent("crew:HideExpBar")
AddEventHandler("crew:HideExpBar", function()
end)

Citizen.CreateThread(function()
  Wait(1000)
  SendNUIMessage({action = "hide"})
end)


CrewCreationData = {
  GetMembres = {},
  GetPerms = {},
  GetPerms2 = {},
  TableGrade = {},
  RangDefault = 1,
  openedMenu = false,
  Color = "#50B4FF"
}

CrewCreationData.mainMenu = RageUI.CreateMenu(_U("crew"), _U("crew"))
CrewCreationData.CreateGradesCrew = RageUI.CreateSubMenu(CrewCreationData.mainMenu, _U("rank"), _U("rank"))

CrewCreationData.mainMenu.Closed = function()
  CrewCreationData.openedMenu = false
  SendNUIMessage({action = "hideColorPicker"})
  SetNuiFocus(false, false)
end

function openCreaCrew()
  if CrewCreationData.openedMenu then
      CrewCreationData.openedMenu = false
      RageUI.Visible(CrewCreationData.mainMenu, false)
      SendNUIMessage({action = "hideColorPicker"})
      SetNuiFocus(false, false)
      return
  else
      CrewCreationData.openedMenu = true
      RageUI.Visible(CrewCreationData.mainMenu, true)

      Citizen.CreateThread(function()
          while CrewCreationData.openedMenu do
              RageUI.IsVisible(CrewCreationData.mainMenu, function()
                  RageUI.Button(_U("enter_crew_name"), nil, {RightLabel = CrewCreationData.Name}, true, {
                      onSelected = function()
                          local name = KeyboardInput(_U("enter_crew_name"), 30)
                          if name ~= nil then
                              CrewCreationData.Name = name
                          end
                      end
                  })

                  RageUI.Button(_U("enter_crew_motto"), nil, {RightLabel = CrewCreationData.DeviseCrew}, true, {
                      onSelected = function()
                          local motto = KeyboardInput(_U("enter_crew_motto"), 30)
                          if motto ~= nil then
                              CrewCreationData.DeviseCrew = motto
                          end
                      end
                  })

                  RageUI.Button(_U("ranks"), nil, {RightLabel = "→"}, true, {}, CrewCreationData.CreateGradesCrew)

                  RageUI.Button(_U("crew_color"), _U("crew_color_desc"), {RightLabel = CrewCreationData.Color or "#50B4FF"}, true, {
                      onSelected = function()
                          SendNUIMessage({
                              action = "showColorPicker",
                              initial = CrewCreationData.Color or "#50B4FF"
                          })
                          SetNuiFocus(true, true)
                      end
                  })

                  RageUI.Button(_U("create_crew"), nil, {RightLabel = "→"}, true, {
                      onSelected = function()
                          if CrewCreationData.Name ~= nil and CrewCreationData.DeviseCrew ~= nil and CrewCreationData.TableGrade ~= nil then
                              TriggerServerEvent("CreateCrew", CrewCreationData.Name, CrewCreationData.DeviseCrew, CrewCreationData.NomGradeChef or "Chef", CrewCreationData.TableGrade, CrewCreationData.Color or "#50B4FF")
                              RageUI.CloseAll()
                              MenuData.openedMenu = false
                              SendNUIMessage({action = "hideColorPicker"})
                              SetNuiFocus(false, false)
                          else
                              ESX.ShowNotification(_U("must_fill_all_fields"))
                          end
                      end
                  })
              end)

              RageUI.IsVisible(CrewCreationData.CreateGradesCrew, function()
                  RageUI.Button(_U("create_another_rank"), nil, {RightLabel = "→"}, true, {
                      onSelected = function()
                          local rankName = KeyboardInput(_U("enter_rank_name"), 30)
                          if rankName ~= nil then
                              CrewCreationData.RangDefault = CrewCreationData.RangDefault + 1
                              table.insert(CrewCreationData.TableGrade, {
                                  name = rankName,
                                  rang = CrewCreationData.RangDefault
                              })
                          end
                      end
                  })

                  RageUI.Button(CrewCreationData.NomGradeChef or _U("leader2"), nil, {RightLabel = "1"}, true, {
                      onSelected = function()
                          local leaderName = KeyboardInput(_U("enter_rank_name_leader"), 30)
                          if leaderName ~= nil then
                              CrewCreationData.NomGradeChef = leaderName
                          end
                      end
                  })

                  for _, rank in pairs(CrewCreationData.TableGrade) do
                      RageUI.Button(rank.name, nil, {RightLabel = rank.rang}, true, {})
                  end
              end)

              Wait(1)
          end
      end)
  end
end

RegisterNetEvent("SolutionJoinCrew")
AddEventHandler("SolutionJoinCrew", function(crewName)
  local timeRemaining = 1100
  ESX.ShowNotification(_U("accept_invite", crewName))

  while true do
      Wait(1)
      timeRemaining = timeRemaining - 1

      if timeRemaining <= 0 then
          ESX.ShowNotification(_U("too_long_to_respond"))
          TriggerServerEvent("AlertJoinCrew", 1)
          break
      end

      if IsControlJustPressed(1, 73) then
          ESX.ShowNotification(_U("you_declined_invite"))
          TriggerServerEvent("AlertJoinCrew", 2)
          break
      end

      if IsControlJustPressed(1, 246) then
          ESX.ShowNotification(_U("you_joined_crew", crewName))
          TriggerServerEvent("JoinCrew")
          TriggerServerEvent("AlertJoinCrew", 3)
          break
      end
  end
end)


RegisterCommand("createcrew", function()
  ESX.TriggerServerCallback("crew:canCreateCrew", function(canCreate, reason)
      if canCreate then
          openCreaCrew()
      elseif reason == "already_in_crew" then
          ESX.ShowNotification(_U("already_in_crew"))
      elseif reason == "creation_restricted_admin" then
          ESX.ShowNotification(_U("creation_restricted_admin"))
      elseif reason == "creation_restricted_discord_config_missing" then
          ESX.ShowNotification(_U("creation_restricted_discord_config_missing"))
      elseif reason == "no_discord_linked" then
          ESX.ShowNotification(_U("no_discord_linked"))
      elseif reason == "discord_role_missing" then
          ESX.ShowNotification(_U("discord_role_missing"))
      else
          ESX.ShowNotification(_U("cannot_create_crew"))
      end
  end)
end)

RegisterNUICallback("crewColorPicked", function(data, cb)
  local hexColor = data and data.hex or nil

  if type(hexColor) == "string" and string.sub(hexColor, 1, 1) == "#" and #hexColor == 7 then
      CrewCreationData.Color = string.upper(hexColor)
      ESX.ShowNotification(string.format(_U("crew_color_selected"), CrewCreationData.Color))
  end

  SendNUIMessage({action = "hideColorPicker"})
  if cb then cb("ok") end
end)

RegisterNUICallback("crewReleaseFocus", function(data, cb)
  SetNuiFocus(false, false)
  if cb then cb("ok") end
end)

RegisterCommand("leavecrew", function()
  TriggerServerEvent("LeaveCrew")
end)