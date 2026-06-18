function L(key)
  if Locale and Locale[key] then
    return Locale[key]
  end
  return key
end

function IsAnyCancelControlPressed()
  for _, control in pairs(Config.cancelControls) do
    if IsControlPressed(0, control) then
      return true
    end
  end
  return false
end

function IsPlayerTryingToMove()
  return IsControlPressed(0, 32) or  
         IsControlPressed(0, 33) or  
         IsControlPressed(0, 34) or  
         IsControlPressed(0, 35) or  
         IsControlPressed(0, 30) or  
         IsControlPressed(0, 31)     
end



local keyCodeToLabel = {
  b_100 = "Clic G",
  b_101 = "Clic D",
  b_102 = "Clic Milieu",
  b_103 = "Bouton souris 1",
  b_104 = "Bouton souris 2",
  b_105 = "Bouton souris 3",
  b_106 = "Bouton souris 4",
  b_107 = "Bouton souris 5",
  b_108 = "Bouton souris 6",
  b_109 = "Bouton souris 7",
  b_110 = "Bouton souris 8",
  b_115 = "Molette Haut",
  b_116 = "Molette Bas",
  b_130 = "Num -",
  b_131 = "Num +",
  b_134 = "Num *",
  b_135 = "Entrée Num",
  b_137 = "Num1",
  b_138 = "Num2",
  b_139 = "Num3",
  b_140 = "Num4",
  b_141 = "Num5",
  b_142 = "Num6",
  b_143 = "Num7",
  b_144 = "Num8",
  b_145 = "Num9",
  b_170 = "F1",
  b_171 = "F2",
  b_172 = "F3",
  b_173 = "F4",
  b_174 = "F5",
  b_175 = "F6",
  b_176 = "F7",
  b_177 = "F8",
  b_178 = "F9",
  b_179 = "F10",
  b_180 = "F11",
  b_181 = "F12",
  b_182 = "F13",
  b_183 = "F14",
  b_184 = "F15",
  b_185 = "F16",
  b_186 = "F17",
  b_187 = "F18",
  b_188 = "F19",
  b_189 = "F20",
  b_190 = "F21",
  b_191 = "F22",
  b_192 = "F23",
  b_193 = "F24",
  b_194 = "Flèche Haut",
  b_195 = "Flèche Bas",
  b_196 = "Flèche Gauche",
  b_197 = "Flèche Droite",
  b_198 = "Suppr",
  b_199 = "Échap",
  b_200 = "Inser",
  b_201 = "Fin",
  b_210 = "Suppr",
  b_211 = "Inser",
  b_212 = "Fin",
  b_1000 = "Maj",
  b_1002 = "Tab",
  b_1003 = "Entrée",
  b_1004 = "Retour arrière",
  b_1009 = "Page Haut",
  b_1008 = "Accueil",
  b_1010 = "Page Bas",
  b_1012 = "Verr Maj",
  b_1013 = "Ctrl",
  b_1014 = "Ctrl Droit",
  b_1015 = "Alt",
  b_1055 = "Accueil",
  b_1056 = "Page Haut",
  b_2000 = "Espace"
}



function GetKeyLabel(controlCode)
  local buttonString = GetControlInstructionalButton(0, controlCode | 2147483648, true)
  
  if string.find(buttonString, "t_") then
    return string.gsub(buttonString, "t_", "")
  else
    return keyCodeToLabel[buttonString] or "unknown"
  end
end




function Contains(table, value)
  for _, item in ipairs(table) do
    if item == value then
      return true
    end
  end
  return false
end



function ContainsModel(modelList, modelHash)
  for _, modelName in ipairs(modelList) do
    if GetHashKey(modelName) == modelHash then
      return true
    end
  end
  return false
end



function DoRequestModel(modelName)
  local modelHash = GetHashKey(modelName)
  
  if HasModelLoaded(modelHash) then
    return
  end
  
  RequestModel(modelHash)
  
  while not HasModelLoaded(modelHash) do
    Citizen.Wait(100)
  end
end

function Debug(...)
  if Config.debug then
    print(...)
  end
end

local sittingScenarios = {
  "WORLD_HUMAN_SEAT_LEDGE", "WORLD_HUMAN_SEAT_LEDGE_EATING", "WORLD_HUMAN_SEAT_STEPS", "WORLD_HUMAN_SEAT_WALL", 
  "WORLD_HUMAN_SEAT_WALL_EATING", "WORLD_HUMAN_SEAT_WALL_TABLET", "PROP_HUMAN_SEAT_ARMCHAIR", "PROP_HUMAN_SEAT_BAR", 
  "PROP_HUMAN_SEAT_BENCH", "PROP_HUMAN_SEAT_BENCH_FACILITY", "PROP_HUMAN_SEAT_BENCH_DRINK", "PROP_HUMAN_SEAT_BENCH_DRINK_FACILITY", 
  "PROP_HUMAN_SEAT_BENCH_DRINK_BEER", "PROP_HUMAN_SEAT_BENCH_FOOD", "PROP_HUMAN_SEAT_BENCH_FOOD_FACILITY", 
  "PROP_HUMAN_SEAT_BUS_STOP_WAIT", "PROP_HUMAN_SEAT_CHAIR", "PROP_HUMAN_SEAT_CHAIR_DRINK", "PROP_HUMAN_SEAT_CHAIR_DRINK_BEER", 
  "PROP_HUMAN_SEAT_CHAIR_FOOD", "PROP_HUMAN_SEAT_CHAIR_UPRIGHT", "PROP_HUMAN_SEAT_CHAIR_MP_PLAYER", "PROP_HUMAN_SEAT_COMPUTER", 
  "PROP_HUMAN_SEAT_COMPUTER_LOW", "PROP_HUMAN_SEAT_DECKCHAIR", "PROP_HUMAN_SEAT_DECKCHAIR_DRINK", "PROP_HUMAN_SEAT_MUSCLE_BENCH_PRESS", 
  "PROP_HUMAN_SEAT_MUSCLE_BENCH_PRESS_PRISON", "PROP_HUMAN_SEAT_SEWING", "PROP_HUMAN_SEAT_STRIP_WATCH", "PROP_HUMAN_SEAT_SUNLOUNGER"
}

function IsPlayerSittingViaChairSystem()
  local playerPed = PlayerPedId()
  for _, scenario in pairs(sittingScenarios) do
    if IsPedUsingScenario(playerPed, scenario) then
      return true
    end
  end
  return false
end