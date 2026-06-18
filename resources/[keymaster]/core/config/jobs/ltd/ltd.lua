 SunnyLTD = {
 ------ LTD -----
    ltdCFG = {
        blip = {
            sprite = 59,
            display = 4,
            scale = 0.5,
            color = 4,
        },
    
        vipsItems = {
         --   ["radiobox"] = true
        },
    
        labels = {
            ["ciseaux"] = "Ciseaux", --
            ["bread"] = "Pain", --
            ["water"] = "Bouteille d'eau", --
            ["wire"] = 'Fil de fer',
            ["soudeuse"] = 'Poste à souder',
            ["oblivionPill"] = 'Pillule d\'oublie',
            ["jumelles"] = "Jumelles",
            ["phone"] = "Téléphone",
            ["radio"] = "Radio",
            ["lockpick"] = "Lockpick",
            ["tournevis"] = "Tournevis",

            -- Drugs
            ["kq_acetone"] = "Acétone",
            ["kq_ethanol"] = "Éthanol",
            ["kq_lithium"] = "Pack de lithium",
            ["gasoline"] = "Essence",
            --["ballonbasket"] = "Ballon de basket",
            --["basketball_hoop"] = "Panier de basket",
            --["cutting_glass"] = "Découpeuse de vitres",
            --["hacking_laptop"] = "PC Portable (Piratage)",
            --["drill"] = "Perceuse",
            --["mobilier"] = "Mobilier",
            ["repair_kit"] = "Kit de réparation",
           -- ["radiobox"] = "Radio portative",
           -- ["hazmat"] = "Tenue Hazmat",
           -- ["spray"] = "Graffiti",
            --["WEAPON_ANTIDOTE"] = "Antidote Gazeuse",
            --["WEAPON_PETROLCAN"] = "Bidon d'essence",
           -- ["spray_remover"] = "Spray nettoyage",
          --  ['recharge_gaz'] = "Recharge Gazeuse",
           -- ['recharge_antidote'] = "Recharge Antidote Gazeuse",
          --  ["bidon_acide"] = "Bidon d'acide",
            ["ocean_lures"] = "Appât tropical",
            ["mer_lures"] = "Appât de mer",
            ["douce_lures"] = "Appât d'eau douce",
            ["canneapechecarbonne"] = "Canne en carbone",
            ["canneapeche"] = "Canne en bois"
        },
    
        societies = {
            ["ltd_littleseoul"] = {
                label = "LTD Little Seoul",
                catalogId = 1,
                catalogMenu = {
                    vec3(-706.727783, -915.324768, 19.215584),
                    vec3(-706.923889, -913.719482, 19.215584), 
                },
                
                historyMenu = vec3(-709.800964, -907.351990, 19.215590),
                bossMenu = vec3(-710.252930, -905.345215, 19.215584),
                jobMenu = {
                    name = 'ltd_littleseoul',
                    badge = true, 
                    billing = false,
                    announce = true,
                    maxBillsAmount = 0
                },
            },
    
            ["ltd_paletobay"] = {
                label = "LTD Paleto Bay",
                catalogId = 2,
                catalogMenu = {
                    vec3(162.300003, 6641.904297, 31.698874),
                    vec3(160.921677, 6640.590820, 31.698874)
                },
                
                historyMenu = vector3(167.431000, 6644.682129, 31.698866),
                bossMenu = vector3(168.56745910645, 6643.0024414063, 31.667392730713),
                jobMenu = {
                    name = 'ltd_paletobay',
                    badge = true, 
                    badgeprops = `p_ld_id_card_002`, 
                    badgeposition = {0.13, 0.03, -0.04, 80.0, 350.0, 180.0}, 
                    billing = false,
                    announce = true,
                    maxBillsAmount = 0
                },
            },
    
            ["ltd_f4l"] = {
                label = "LTD Forum Drive",
                catalogId = 2,
                catalogMenu = {
                    vec3(27.415138244629, -1341.5855712891, 29.494094848633),
                    vec3(28.954427719116, -1341.5750732422, 29.494300842285),
                },
                
                historyMenu = vec3(27.180799, -1340.273926, 29.496960),
                bossMenu = vec3(28.690731, -1338.762329, 29.497032),
                jobMenu = {
                    name = 'ltd_f4l',
                    badge = true, 
                    badgeprops = `p_ld_id_card_002`, 
                    badgeposition = {0.13, 0.03, -0.04, 80.0, 350.0, 180.0}, 
                    billing = false,
                    announce = true,
                    maxBillsAmount = 0
                },
            },

            ["ltd_arena"] = {
                label = "LTD Arena",
                catalogId = 2,
                catalogMenu = {
                    vec3(-346.08636474609, -1477.3419189453, 30.747936248779),
                    vec3(-344.05117797852, -1477.3132324219, 30.747976303101),
                },
                
                historyMenu = vec3(27.180799, -1340.273926, 29.496960),
                bossMenu = vec3(28.690731, -1338.762329, 29.497032),
                jobMenu = {
                    name = 'ltd_arena',
                    badge = true, 
                    badgeprops = `p_ld_id_card_002`, 
                    badgeposition = {0.13, 0.03, -0.04, 80.0, 350.0, 180.0}, 
                    billing = false,
                    announce = true,
                    maxBillsAmount = 0
                },
            },

            ["ltd_paletobay"] = {
                label = "LTD Paleto Bay",
                catalogId = 2,
                catalogMenu = {
                    vec3(172.10018920898, 6641.9018554688, 31.698598861694)
                },
                
                historyMenu = vec3(27.180799, -1340.273926, 29.496960),
                bossMenu = vec3(28.690731, -1338.762329, 29.497032),
                jobMenu = {
                    name = 'ltd_paletobay',
                    badge = true, 
                    badgeprops = `p_ld_id_card_002`, 
                    badgeposition = {0.13, 0.03, -0.04, 80.0, 350.0, 180.0}, 
                    billing = false,
                    announce = true,
                    maxBillsAmount = 0
                },
            },
    
            ["ltd_ballas"] = {
                label = "LTD Grove Street",
                catalogId = 2,
                catalogMenu = {
                    vec3(-48.044823, -1759.120361, 29.420790),
                    vec3(-47.079075, -1757.508911, 29.420790),
                },
                
                historyMenu = vec3(-45.546295, -1750.749878, 29.423548),
                bossMenu = vec3(-44.524887, -1748.912598, 29.420790),
                jobMenu = {
                    name = 'ltd_ballas',
                    badge = true, 
                    badgeprops = `p_ld_id_card_002`, 
                    badgeposition = {0.13, 0.03, -0.04, 80.0, 350.0, 180.0}, 
                    billing = false,
                    announce = true,
                    maxBillsAmount = 0
                },
            }
        },
    
        catalogs = {
            {
                ["bread"] = 50,
                ["ciseaux"] = 250,
                ["water"] = 50,
                ["lockpick"] = 1200,
                ["wire"] = 250,
                ["soudeuse"] = 2400,
                ["oblivionPill"] = 350,
                ["jumelles"] = 200,
                ["phone"] = 500,
                ["radio"] = 500,
              --  ["radiobox"] = 7500,
                ["repair_kit"] = 3000,
                ["tournevis"] = 1400,
                ["kq_acetone"] = 300,
                ["kq_ethanol"] = 4,
                ["kq_lithium"] = 8,
                ["gasoline"] = 36,
              --  ["ballonbasket"] = 50000,
              --  ["basketball_hoop"] = 150000,
             --   ["cutting_glass"] = 180000,
             ---   ["hacking_laptop"] = 212000,
             --   ["drill"] = 50000,
             --   ["mobilier"] = 30000,
                --["hazmat"] = 100000,
             --   ["spray"] = 4000,
            --    ["spray_remover"] = 500,
            --    ["WEAPON_ANTIDOTE"] = 50000,
            --    ["WEAPON_PETROLCAN"] = 50000,
            --    ['recharge_gaz'] = 10000,
            --    ['recharge_antidote'] = 50000,
            --    ["bidon_acide"] = 500,
                ["ocean_lures"] = 200,
                ["mer_lures"] = 200,
                ["douce_lures"] = 200,
                ["canneapeche"] = 7500,
                ["canneapechecarbonne"] = 15000,
            },
    
            {
                ["bread"] = 50,
                ["ciseaux"] = 250,
                ["water"] = 50,
                ["lockpick"] = 1200,
                ["wire"] = 250,
                ["soudeuse"] = 2400,
                ["oblivionPill"] = 350,
                ["jumelles"] = 200,
                ["phone"] = 500,
                ["radio"] = 500,
              --  ["radiobox"] = 7500,
                ["repair_kit"] = 3000,
                ["tournevis"] = 1400,
                ["kq_acetone"] = 300,
                ["kq_ethanol"] = 4,
                ["kq_lithium"] = 8,
                ["gasoline"] = 36,
              --  ["ballonbasket"] = 50000,
              --  ["basketball_hoop"] = 150000,
             --   ["cutting_glass"] = 180000,
             ---   ["hacking_laptop"] = 212000,
             --   ["drill"] = 50000,
             --   ["mobilier"] = 30000,
                --["hazmat"] = 100000,
             --   ["spray"] = 4000,
            --    ["spray_remover"] = 500,
            --    ["WEAPON_ANTIDOTE"] = 50000,
            --    ["WEAPON_PETROLCAN"] = 50000,
            --    ['recharge_gaz'] = 10000,
            --    ['recharge_antidote'] = 50000,
            --    ["bidon_acide"] = 500,
                ["ocean_lures"] = 200,
                ["mer_lures"] = 200,
                ["douce_lures"] = 200,
                ["canneapeche"] = 7500,
                ["canneapechecarbonne"] = 15000,
            }
        },
    
        types = {
            
            ["bread"] = "NOURRITURE",
            ["water"] = "BOISSON",
            ["lockpick"] = "OBJET",
            ["ciseaux"] = "OBJET",
            ["wire"] = "OBJET",
            ["soudeuse"] = "OBJET",
            ["oblivionPill"] = "OBJET",
            ["jumelles"] = "OBJET",
            ["phone"] = "OBJET",
            ["radio"] = "OBJET",
         --   ["radiobox"] = "OBJET",
            ["repair_kit"] = "OBJET",
            ["tournevis"] = "OBJET",
            ["kq_acetone"] = "OBJET",
            ["kq_ethanol"] = "OBJET",
            ["kq_lithium"] = "OBJET",
            ["gasoline"] = "OBJET",
         --   ["ballonbasket"] = "OBJET",
         --   ["basketball_hoop"] = "OBJET",
         --   ["cutting_glass"] = "OBJET",
         --   ["hacking_laptop"] = "OBJET",
          --  ["drill"] = "OBJET",
        --    ["mobilier_canape"] = "OBJET",
        --    ["mobilier_chaise"] = "OBJET",
        --    ["mobilier_lits"] = "OBJET",
        --    ["mobilier_general"] = "OBJET",
       --     ["mobilier_petit"] = "OBJET",
        --    ["mobilier_campement"] = "OBJET",
       --     ["mobilier_stockage"] = "OBJET",
        --    ["mobilier_electronique"] = "OBJET",
         --   ["mobilier_eclairage"] = "OBJET",
        --    ["mobilier_tables"] = "OBJET",
       --     ["mobilier_meubles"] = "OBJET",
        --    ["mobilier_plantes"] = "OBJET",
       --     ["mobilier_plage"] = "OBJET",
       --     ["mobilier_cuisine"] = "OBJET",
        --    ["mobilier_salledebain"] = "OBJET",
        --    ["mobilier_medical"] = "OBJET",
        --    ["mobilier_garage"] = "OBJET",
      --      ["mobilier_illegal"] = "OBJET",
        --    ["mobilier_course"] = "OBJET",
       ---     ["mobilier_jobs"] = "OBJET",
            --["hazmat"] = "OBJET",
         --   ["spray"] = "OBJET",
         --   ["spray_remover"] = "OBJET",
        --    ["WEAPON_ANTIDOTE"] = "ARME",
        ---    ["WEAPON_PETROLCAN"] = "ARME",
        --    ['recharge_gaz'] = "OBJET",
        --    ['recharge_antidote'] = "OBJET",
        --    ["bidon_acide"] = "OBJET",
            ["canneapeche"] = "OBJET",
            ["canneapechecarbonne"] = "OBJET",
            ["ocean_lures"] = "OBJET",
            ["mer_lures"] = "OBJET",
            ["douce_lures"] = "OBJET",
        },
    },
}