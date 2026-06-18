--[[
    ╔═══════════════════════════════════════════════════════════════════════════╗
    ║                        NV_BLACKMARKET - CONFIGURATION                      ║
    ║                              Marché Noir RP                                ║
    ╚═══════════════════════════════════════════════════════════════════════════╝

    Ce fichier contient toutes les configurations modifiables du script.
    Modifie les valeurs selon tes besoins sans toucher à la structure.
]]

XMR = {}

--[[
    ═══════════════════════════════════════════════════════════════════════════
    CONFIGURATION DU FRAMEWORK
    ═══════════════════════════════════════════════════════════════════════════

    Framework utilisé sur ton serveur.

    Options disponibles:
        - "esx"  : Pour ESX Legacy / ESX 1.x
        - "qb"   : Pour QBCore
]]
XMR.Framework = "esx"


--[[
    ═══════════════════════════════════════════════════════════════════════════
    CONFIGURATION DU PNJ (VENDEUR)
    ═══════════════════════════════════════════════════════════════════════════
]]

-- Position du PNJ vendeur
-- Format: vec4(x, y, z, heading)
-- x, y, z = coordonnées dans le monde
-- heading = direction où regarde le PNJ (0-360 degrés)
XMR.PedCoords = vec4(255.3303, 3111.3408, 42.5940, 192.1214)

-- Modèle du PNJ
-- Liste des modèles: https://docs.fivem.net/docs/game-references/ped-models/
-- Exemples courants:
--   "csb_rashcosvki"     - Personnage louche
--   "g_m_y_mexgang01"    - Gang mexicain
--   "s_m_y_dealer_01"    - Dealer
--   "a_m_m_hillbilly_01" - Redneck
--   "u_m_y_tattoo_01"    - Tatoueur
XMR.PedHash = "csb_rashcosvki"

-- Variable interne (NE PAS MODIFIER)
XMR.Ped = nil


--[[
    ═══════════════════════════════════════════════════════════════════════════
    CONFIGURATION DE L'INTERACTION
    ═══════════════════════════════════════════════════════════════════════════
]]

-- Distance d'affichage du texte (en mètres)
-- Plus la valeur est grande, plus le joueur peut voir le texte de loin
XMR.DrawDistance = 3

-- Texte affiché au-dessus du PNJ quand le joueur s'approche
-- Le "[E]" est ajouté automatiquement devant
XMR.DrawText = "Tu cherche du matos ?"

-- Message de confirmation après un achat réussi
XMR.CompleteText = "Operation effectuee avec succes ! Verifie ton sac !"


--[[
    ═══════════════════════════════════════════════════════════════════════════
    CATALOGUE DES ITEMS EN VENTE
    ═══════════════════════════════════════════════════════════════════════════

    Structure d'un item:

    ["nom_item"] = {
        label    = "Nom affiché",      -- Nom visible dans le menu
        price    = 1000,               -- Prix en argent sale (dirty money) ou cash
        imageSrc = "nom_image",        -- Nom de l'image (sans extension)
        type     = "other"             -- Type d'item (voir ci-dessous)
    },

    Types disponibles:
        - "weapon" : Armes
        - "other"  : Autres items (drogues, outils, etc.)

    Note: L'image doit correspondre au nom de l'item dans ton inventaire
          Ex: si ton item s'appelle "lockpick", l'image sera "lockpick.png"
]]

XMR.Items = {

    --[[ ══════════════════════════════════════════════════════════════════════
         ARMES
         Décommente les armes que tu veux activer
    ══════════════════════════════════════════════════════════════════════ ]]

    -- ["weapon_pistol"] = {
    --     label    = "Pistolet",
    --     price    = 5000,
    --     imageSrc = "weapon_pistol",
    --     type     = "weapon"
    -- },

    -- ["weapon_heavypistol"] = {
    --     label    = "Pistolet Lourd",
    --     price    = 8000,
    --     imageSrc = "weapon_heavypistol",
    --     type     = "weapon"
    -- },

    -- ["weapon_microsmg"] = {
    --     label    = "Micro SMG",
    --     price    = 15000,
    --     imageSrc = "weapon_microsmg",
    --     type     = "weapon"
    -- },

    -- ["weapon_smg"] = {
    --     label    = "SMG",
    --     price    = 25000,
    --     imageSrc = "weapon_smg",
    --     type     = "weapon"
    -- },

    -- ["weapon_assaultrifle"] = {
    --     label    = "Fusil d'Assaut",
    --     price    = 50000,
    --     imageSrc = "weapon_assaultrifle",
    --     type     = "weapon"
    -- },

    -- ["weapon_pumpshotgun"] = {
    --     label    = "Fusil a Pompe",
    --     price    = 20000,
    --     imageSrc = "weapon_pumpshotgun",
    --     type     = "weapon"
    -- },

    -- ["weapon_knife"] = {
    --     label    = "Couteau",
    --     price    = 500,
    --     imageSrc = "weapon_knife",
    --     type     = "weapon"
    -- },

    -- ["weapon_bat"] = {
    --     label    = "Batte de Baseball",
    --     price    = 300,
    --     imageSrc = "weapon_bat",
    --     type     = "weapon"
    -- },


    --[[ ══════════════════════════════════════════════════════════════════════
         MUNITIONS
         Décommente les munitions que tu veux activer
    ══════════════════════════════════════════════════════════════════════ ]]

    -- ["ammo-9"] = {
    --     label    = "Munitions 9mm",
    --     price    = 50,
    --     imageSrc = "ammo-9",
    --     type     = "other"
    -- },

    -- ["ammo-rifle"] = {
    --     label    = "Munitions Fusil",
    --     price    = 100,
    --     imageSrc = "ammo-rifle",
    --     type     = "other"
    -- },

    -- ["ammo-shotgun"] = {
    --     label    = "Munitions Shotgun",
    --     price    = 75,
    --     imageSrc = "ammo-shotgun",
    --     type     = "other"
    -- },


    --[[ ══════════════════════════════════════════════════════════════════════
         OUTILS ILLEGAUX
    ══════════════════════════════════════════════════════════════════════ ]]

    ["crochetage_kit"] = {
        label    = "Kit de Crochetage",
        price    = 10000,
        imageSrc = "crochetage_kit",
        type     = "other"
    },

    ["hack_laptop"] = {
        label    = "Ordinateur Portable",
        price    = 1000,
        imageSrc = "hack_laptop",
        type     = "other"
    },

    ["hack_phone"] = {
        label    = "Telephone Jailbreak",
        price    = 2000,
        imageSrc = "hack_phone",
        type     = "other"
    },

    -- ["lockpick"] = {
    --     label    = "Lockpick",
    --     price    = 3000,
    --     imageSrc = "lockpick",
    --     type     = "other"
    -- },

    -- ["electronickit"] = {
    --     label    = "Kit Electronique",
    --     price    = 5000,
    --     imageSrc = "electronickit",
    --     type     = "other"
    -- },


    --[[ ══════════════════════════════════════════════════════════════════════
         DROGUES & FABRICATION
    ══════════════════════════════════════════════════════════════════════ ]]

    ["kq_meth_lab_kit"] = {
        label    = "Kit de Cuisson",
        price    = 25000,
        imageSrc = "kq_meth_lab_kit",
        type     = "other"
    },

    ["kq_meth_pills"] = {
        label    = "Pseudoephedrine",
        price    = 5,
        imageSrc = "kq_meth_pills",
        type     = "other"
    },

    ["hydrochloric_acid"] = {
        label    = "Acide Chlorhydrique",
        price    = 4,
        imageSrc = "hydrochloric_acid",
        type     = "other"
    },

    -- ["weed_seed"] = {
    --     label    = "Graine de Weed",
    --     price    = 500,
    --     imageSrc = "weed_seed",
    --     type     = "other"
    -- },

    -- ["cocaine_brick"] = {
    --     label    = "Brique de Cocaine",
    --     price    = 10000,
    --     imageSrc = "cocaine_brick",
    --     type     = "other"
    -- },


    --[[ ══════════════════════════════════════════════════════════════════════
         EQUIPEMENT & PROTECTION
    ══════════════════════════════════════════════════════════════════════ ]]

    -- ["armor"] = {
    --     label    = "Gilet Pare-balles",
    --     price    = 10000,
    --     imageSrc = "armor",
    --     type     = "other"
    -- },

    -- ["bandage"] = {
    --     label    = "Bandage",
    --     price    = 3000,
    --     imageSrc = "bandage",
    --     type     = "other"
    -- },

    -- ["medikit"] = {
    --     label    = "Kit Medical",
    --     price    = 5000,
    --     imageSrc = "medikit",
    --     type     = "other"
    -- },

    -- ["binoculars"] = {
    --     label    = "Jumelles",
    --     price    = 3000,
    --     imageSrc = "binoculars",
    --     type     = "other"
    -- },

    -- ["radio"] = {
    --     label    = "Radio",
    --     price    = 2000,
    --     imageSrc = "radio",
    --     type     = "other"
    -- },


    --[[ ══════════════════════════════════════════════════════════════════════
         CONSOMMABLES
    ══════════════════════════════════════════════════════════════════════ ]]

    ["water"] = {
        label    = "Eau",
        price    = 50,
        imageSrc = "water",
        type     = "other"
    },

    -- ["sandwich"] = {
    --     label    = "Sandwich",
    --     price    = 75,
    --     imageSrc = "sandwich",
    --     type     = "other"
    -- },

    -- ["energy_drink"] = {
    --     label    = "Boisson Energisante",
    --     price    = 100,
    --     imageSrc = "energy_drink",
    --     type     = "other"
    -- },

}


--[[
    ═══════════════════════════════════════════════════════════════════════════
    FIN DE LA CONFIGURATION
    ═══════════════════════════════════════════════════════════════════════════

    Pour ajouter un nouvel item:
    1. Copie un bloc existant
    2. Change le nom entre crochets ["nom_item"]
    3. Modifie le label, price, imageSrc et type
    4. Assure-toi que l'item existe dans ton inventaire !

    Pour changer la position du PNJ:
    1. Va en jeu et trouve l'emplacement souhaité
    2. Utilise une commande comme /coords pour obtenir tes coordonnées
    3. Remplace les valeurs dans XMR.PedCoords

    Besoin d'aide ? Contacte @NEVA
]]
