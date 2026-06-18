-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : dim. 22 fév. 2026 à 21:14
-- Version du serveur : 10.4.32-MariaDB
-- Version de PHP : 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `neva`
--

-- --------------------------------------------------------

--
-- Structure de la table `addon_account`
--

CREATE TABLE `addon_account` (
  `name` varchar(60) NOT NULL,
  `label` varchar(100) NOT NULL,
  `shared` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `addon_account`
--

INSERT INTO `addon_account` (`name`, `label`, `shared`) VALUES
('society_airdealer', 'Concessionnaire Aérien', 1),
('society_ambulance', 'EMS', 1),
('society_ambulancesandy', 'Ambulance Sandy', 1),
('society_bar_beachclub', 'Beach Club', 1),
('society_bar_mojitoinn', 'Mojito Inn', 1),
('society_bar_salieris', 'Salieris', 1),
('society_bar_tequila', 'Tequila', 1),
('society_boatdealer', 'Concessionnaire Bateau', 1),
('society_boite_pacific', 'Pacific Bluffs', 1),
('society_boite_unicorn', 'Unicorn', 1),
('society_boite_wiwang', 'Wiwang', 1),
('society_cardealer', 'Concessionnaire', 1),
('society_Cartel De Cayo', 'Cartel de Cayo', 1),
('society_Cartel de Sinaloa', 'Cartel de Sinaloa', 1),
('society_Duggan', 'Duggan', 1),
('society_Duggan crime family', 'Duggan crime family', 1),
('society_garage_driveline', 'Driveline Garage', 1),
('society_garage_eastcustoms', 'East Customs', 1),
('society_garage_lscustom', 'LsCustoms', 1),
('society_garage_octacyp', 'Octa Cyp Garage', 1),
('society_garage_paletocustoms', 'Paleto Customs', 1),
('society_garage_speedhunters', 'Speed Hunters', 1),
('society_gouvernement', 'Gouvernement', 1),
('society_hornys', 'Horny\'s', 1),
('society_le_ferailleur', 'Le Férailleur', 1),
('society_ltd_arena', 'LTD Arena', 1),
('society_ltd_ballas', 'LTD Grove Street', 1),
('society_ltd_f4l', 'LTD Forum Drive', 1),
('society_ltd_littleseoul', 'LTD Little Seoul', 1),
('society_ltd_paletobay', 'LTD Paleto Bay', 1),
('society_Madrazo', 'Madrazo', 1),
('society_McReary', 'McReary', 1),
('society_mecano', 'Benny\'s', 1),
('society_motodealer', 'Concessionnaire Moto', 1),
('society_off_ambulance', 'EMS - Off duty', 1),
('society_off_police', 'LSPD - Off duty', 1),
('society_petitpecheur', 'Petit Pêcheur', 1),
('society_police', 'LSPD', 1),
('society_realestateagent', 'Agent Immobilier', 1),
('society_restau_burgershot', 'Burgershot', 1),
('society_restau_catcafe', 'CatCafe', 1),
('society_restau_pearls', 'Pearls', 1),
('society_restau_pops', 'Pop\'s Diner', 1),
('society_saspn', 'BCSO', 1),
('society_tabac', 'Tabac', 1),
('society_taxi', 'Taxi', 1),
('society_unemployed', 'Chomeur', 1),
('society_unemployed2', 'Chomeur', 1),
('society_Vagos', 'Vagos', 1),
('society_vangelico', 'Vangelico', 1),
('society_vigne', 'Vigneron', 1),
('society_weazelnews', 'Weazle News', 1);

-- --------------------------------------------------------

--
-- Structure de la table `addon_account_data`
--

CREATE TABLE `addon_account_data` (
  `id` int(11) NOT NULL,
  `account_name` varchar(100) DEFAULT NULL,
  `money` int(11) NOT NULL,
  `owner` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `addon_account_data`
--

INSERT INTO `addon_account_data` (`id`, `account_name`, `money`, `owner`) VALUES
(1, 'society_off_ambulance', 0, NULL),
(2, 'society_off_police', 0, NULL),
(3, 'society_ltd_f4l', 0, NULL),
(4, 'society_vigne', 0, NULL),
(5, 'society_boatdealer', 0, NULL),
(6, 'society_hornys', 0, NULL),
(7, 'society_le_ferailleur', 0, NULL),
(8, 'society_bar_mojitoinn', 0, NULL),
(9, 'society_boite_unicorn', 0, NULL),
(10, 'society_ambulance', 0, NULL),
(11, 'society_airdealer', 0, NULL),
(12, 'society_bar_beachclub', 0, NULL),
(13, 'society_Cartel de Sinaloa', 0, NULL),
(14, 'society_cardealer', 0, NULL),
(15, 'society_restau_catcafe', 0, NULL),
(16, 'society_boite_wiwang', 0, NULL),
(17, 'society_Madrazo', 0, NULL),
(18, 'society_gouvernement', 0, NULL),
(19, 'society_Vagos', 0, NULL),
(20, 'society_realestateagent', 0, NULL),
(21, 'society_restau_pops', 0, NULL),
(22, 'society_bar_tequila', 0, NULL),
(23, 'society_garage_lscustom', 0, NULL),
(24, 'society_unemployed', 0, NULL),
(25, 'society_Duggan crime family', 0, NULL),
(26, 'society_McReary', 0, NULL),
(27, 'society_Cartel De Cayo', 0, NULL),
(28, 'society_unemployed2', 0, NULL),
(29, 'society_boite_pacific', 0, NULL),
(30, 'society_taxi', 0, NULL),
(31, 'society_restau_pearls', 0, NULL),
(32, 'society_garage_driveline', 0, NULL),
(33, 'society_ltd_littleseoul', 0, NULL),
(34, 'society_tabac', 0, NULL),
(35, 'society_weazelnews', 0, NULL),
(36, 'society_ltd_paletobay', 0, NULL),
(37, 'society_saspn', 0, NULL),
(38, 'society_garage_octacyp', 0, NULL),
(39, 'society_ltd_ballas', 0, NULL),
(40, 'society_ltd_arena', 0, NULL),
(41, 'society_restau_burgershot', 0, NULL),
(42, 'society_petitpecheur', 0, NULL),
(43, 'society_police', 0, NULL),
(44, 'society_mecano', 0, NULL),
(45, 'society_garage_paletocustoms', 0, NULL),
(46, 'society_motodealer', 0, NULL),
(47, 'society_garage_eastcustoms', 0, NULL),
(48, 'society_ambulancesandy', 0, NULL),
(49, 'society_Duggan', 0, NULL),
(50, 'society_vangelico', 0, NULL),
(51, 'society_bar_salieris', 0, NULL),
(52, 'society_garage_speedhunters', 0, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `admin_jails`
--

CREATE TABLE `admin_jails` (
  `UniqueID` int(11) NOT NULL,
  `time` longtext DEFAULT NULL,
  `staff` longtext DEFAULT NULL,
  `reason` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `ad_admin`
--

CREATE TABLE `ad_admin` (
  `id` int(11) NOT NULL,
  `identifier` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Structure de la table `ad_banlist`
--

CREATE TABLE `ad_banlist` (
  `id` int(11) NOT NULL,
  `STEAM` longtext NOT NULL,
  `DISCORD` longtext NOT NULL,
  `LICENSE` longtext NOT NULL,
  `LIVE` longtext NOT NULL,
  `XBL` longtext NOT NULL,
  `IP` longtext NOT NULL,
  `TOKENS` longtext NOT NULL,
  `BANID` longtext NOT NULL,
  `REASON` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Structure de la table `ad_unban`
--

CREATE TABLE `ad_unban` (
  `id` int(11) NOT NULL,
  `identifier` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Structure de la table `ad_whitelist`
--

CREATE TABLE `ad_whitelist` (
  `id` int(11) NOT NULL,
  `identifier` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Structure de la table `afk_daily`
--

CREATE TABLE `afk_daily` (
  `id` int(11) NOT NULL,
  `uniqueid` varchar(50) NOT NULL,
  `date` date NOT NULL,
  `minutes` int(11) DEFAULT 0,
  `earnings` bigint(20) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `afk_stats`
--

CREATE TABLE `afk_stats` (
  `id` int(11) NOT NULL,
  `uniqueid` varchar(50) NOT NULL,
  `identifier` varchar(60) NOT NULL,
  `firstname` varchar(50) DEFAULT '',
  `lastname` varchar(50) DEFAULT '',
  `total_minutes` int(11) DEFAULT 0,
  `total_earnings` bigint(20) DEFAULT 0,
  `sessions_count` int(11) DEFAULT 0,
  `last_session` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `aircraft_categorie`
--

CREATE TABLE `aircraft_categorie` (
  `name` text NOT NULL,
  `label` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `aircraft_categorie`
--

INSERT INTO `aircraft_categorie` (`name`, `label`) VALUES
('aircraft', 'Aériens'),
('aircraft', 'Aériens');

-- --------------------------------------------------------

--
-- Structure de la table `animals_perm`
--

CREATE TABLE `animals_perm` (
  `idunique` int(11) NOT NULL,
  `prenom` varchar(255) DEFAULT NULL,
  `model` varchar(255) DEFAULT NULL,
  `owner_identifier` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `appel_jobs`
--

CREATE TABLE `appel_jobs` (
  `id` int(11) NOT NULL,
  `raison` text NOT NULL,
  `pos` varchar(255) NOT NULL,
  `job` varchar(255) NOT NULL,
  `plate` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `appel_jobs`
--

INSERT INTO `appel_jobs` (`id`, `raison`, `pos`, `job`, `plate`) VALUES
(1, 'Vente de drogue', '{\"x\":-219.93475341796876,\"y\":6347.3173828125,\"z\":31.89797973632812}', 'saspn', '[]'),
(2, 'Véhicule en panne', '{\"x\":-1561.9508056640626,\"y\":248.83782958984376,\"z\":59.14666748046875}', 'mecano', '24LCW151'),
(3, 'Véhicule en panne', '{\"x\":564.3199462890625,\"y\":624.0715942382813,\"z\":140.49258422851563}', 'mecano', '21RHN598');

-- --------------------------------------------------------

--
-- Structure de la table `bcso_plainte`
--

CREATE TABLE `bcso_plainte` (
  `id` int(11) NOT NULL,
  `name` longtext DEFAULT NULL,
  `date` text DEFAULT NULL,
  `numberphone` text DEFAULT NULL,
  `reason` longtext DEFAULT NULL,
  `author` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `benches_cache`
--

CREATE TABLE `benches_cache` (
  `id` int(11) NOT NULL,
  `identifier` varchar(50) NOT NULL,
  `benchName` varchar(255) NOT NULL,
  `metadata` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`metadata`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `billing`
--

CREATE TABLE `billing` (
  `id` int(11) NOT NULL,
  `identifier` varchar(255) NOT NULL,
  `sender` varchar(255) NOT NULL,
  `target_type` varchar(50) NOT NULL,
  `target` varchar(255) NOT NULL,
  `label` varchar(255) NOT NULL,
  `amount` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `blackmarket`
--

CREATE TABLE `blackmarket` (
  `id` int(11) NOT NULL,
  `name` varchar(64) NOT NULL,
  `label` varchar(64) NOT NULL,
  `price` int(11) NOT NULL,
  `category` varchar(16) NOT NULL,
  `required_level` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `blackmarket_rank`
--

CREATE TABLE `blackmarket_rank` (
  `id` int(11) NOT NULL,
  `identifier` varchar(64) NOT NULL,
  `rank_name` varchar(32) NOT NULL DEFAULT 'Nouveau',
  `deliveries` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `blanchiment`
--

CREATE TABLE `blanchiment` (
  `id` int(11) NOT NULL,
  `owner` int(11) DEFAULT 0,
  `name` varchar(50) DEFAULT NULL,
  `label` varchar(50) DEFAULT NULL,
  `pos` varchar(255) DEFAULT NULL,
  `percent` longtext DEFAULT '0',
  `time` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `blanchiment`
--

INSERT INTO `blanchiment` (`id`, `owner`, `name`, `label`, `pos`, `percent`, `time`) VALUES
(43, 0, 'blachiment1', 'Blachiment', '{\"x\":347.46478271484377,\"y\":-1255.8421630859376,\"z\":32.45035171508789}', '0', 0),
(44, 0, 'blachiment2', 'Blachiment', '{\"x\":-1704.3978271484376,\"y\":-441.2682189941406,\"z\":41.67023849487305}', '0.09999999999999432', 0);

-- --------------------------------------------------------

--
-- Structure de la table `boat_categories`
--

CREATE TABLE `boat_categories` (
  `name` varchar(50) NOT NULL DEFAULT 'none',
  `label` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `boat_categories`
--

INSERT INTO `boat_categories` (`name`, `label`) VALUES
('boat', 'Bateau');

-- --------------------------------------------------------

--
-- Structure de la table `boost_farm`
--

CREATE TABLE `boost_farm` (
  `UniqueID` int(11) NOT NULL,
  `boost` longtext NOT NULL,
  `time` longtext NOT NULL,
  `multiplication` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `boutique`
--

CREATE TABLE `boutique` (
  `citizenID` varchar(255) NOT NULL,
  `boutique_code` int(11) NOT NULL,
  `points` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `boutique_gains`
--

CREATE TABLE `boutique_gains` (
  `id` int(11) NOT NULL,
  `citizenId` varchar(50) NOT NULL,
  `item` varchar(50) NOT NULL,
  `type` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `boutique_history`
--

CREATE TABLE `boutique_history` (
  `uniqueid` int(11) DEFAULT NULL,
  `data` longtext NOT NULL DEFAULT 'Indéfini',
  `lot` longtext NOT NULL DEFAULT 'Indéfini',
  `reward_type` varchar(20) NOT NULL DEFAULT 'purchase'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `boutique_history`
--

INSERT INTO `boutique_history` (`uniqueid`, `data`, `lot`, `reward_type`) VALUES
(1, 'a acheté l\'arme g17gen5', 'g17gen5', 'purchase'),
(1, 'a acheté l\'arme g17gen5', 'g17gen5', 'purchase'),
(2, 'a acheté un véhicule 16charger avec la plaque AGKZ8872 pour 2000 coins', '16charger', 'purchase'),
(2, 'a acheté un véhicule mule5 avec la plaque RVVK0011 pour 1000 coins', 'mule5', 'purchase'),
(2, 'a acheté un véhicule 2020CLA45s avec la plaque GRLN3354 pour 2000 coins', '2020CLA45s', 'purchase'),
(6, 'a acheté l\'arme combatpdw', 'combatpdw', 'purchase'),
(6, 'a acheté 12500$', '12500', 'purchase'),
(6, 'a acheté 25000$', '25000', 'purchase'),
(6, 'a acheté un véhicule mule5 avec la plaque VKQM0777 pour 1000 coins', 'mule5', 'purchase'),
(6, 'a acheté un véhicule 18rs7 avec la plaque YKOL1198 pour 2000 coins', '18rs7', 'purchase');

-- --------------------------------------------------------

--
-- Structure de la table `boutique_reward`
--

CREATE TABLE `boutique_reward` (
  `UniqueID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `boutique_reward`
--

INSERT INTO `boutique_reward` (`UniqueID`) VALUES
(1),
(7),
(11),
(12);

-- --------------------------------------------------------

--
-- Structure de la table `boutique_security_logs`
--

CREATE TABLE `boutique_security_logs` (
  `id` int(11) NOT NULL,
  `source` int(11) NOT NULL,
  `type` varchar(50) NOT NULL,
  `data` longtext DEFAULT NULL,
  `reason` varchar(255) NOT NULL,
  `timestamp` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `calendar`
--

CREATE TABLE `calendar` (
  `identifier` varchar(60) NOT NULL,
  `days` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `chasse`
--

CREATE TABLE `chasse` (
  `uniqueid` int(11) DEFAULT NULL,
  `levels` int(11) DEFAULT 0,
  `animals` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `chasse`
--

INSERT INTO `chasse` (`uniqueid`, `levels`, `animals`) VALUES
(215, 20, '[\"Lapin\"]'),
(237, 0, '[\"Lapin\"]'),
(343, 0, '[\"Lapin\"]'),
(3, -50, '[\"Lapin\"]'),
(376, 30, '[\"Lapin\"]'),
(566, 380, '[\"Chevreuil\",\"Lapin\",\"Jaguar\",\"Loup\"]'),
(559, 0, '[\"Lapin\"]'),
(257, 80, '[\"Lapin\"]'),
(617, 130, '[\"Chevreuil\",\"Lapin\"]'),
(505, 40, '[\"Lapin\"]'),
(643, 150, '[\"Chevreuil\",\"Lapin\"]'),
(310, 550, '[\"Chevreuil\",\"Lapin\",\"Jaguar\",\"Loup\",\"Cerf\"]'),
(551, -10, '[\"Lapin\"]'),
(808, 560, '[\"Chevreuil\",\"Lapin\",\"Jaguar\",\"Loup\",\"Cerf\"]'),
(207, -60, '[\"Lapin\"]'),
(850, 520, '[\"Chevreuil\",\"Lapin\",\"Jaguar\",\"Loup\",\"Cerf\"]'),
(811, 80, '[\"Chevreuil\",\"Lapin\"]'),
(571, -50, '[\"Lapin\"]'),
(412, 50, '[\"Lapin\"]'),
(512, 520, '[\"Chevreuil\",\"Lapin\",\"Jaguar\",\"Loup\",\"Cerf\"]'),
(276, 170, '[\"Chevreuil\",\"Lapin\"]'),
(553, 900, '[\"Chevreuil\",\"Lapin\",\"Jaguar\",\"Loup\",\"Sanglier\"]'),
(378, 60, '[\"Lapin\"]'),
(935, 30, '[\"Lapin\"]'),
(409, 780, '[\"Chevreuil\",\"Lapin\",\"Jaguar\",\"Loup\",\"Sanglier\"]'),
(928, 710, '[\"Chevreuil\",\"Lapin\",\"Jaguar\",\"Loup\",\"Sanglier\"]'),
(199, 240, '[\"Chevreuil\",\"Lapin\",\"Jaguar\"]'),
(219, 50, '[\"Lapin\"]'),
(170, 30, '[\"Lapin\"]'),
(1104, 0, '[\"Lapin\"]'),
(1101, 20, '[\"Lapin\"]'),
(579, 20, '[\"Lapin\"]'),
(222, 150, '[\"Chevreuil\",\"Lapin\"]'),
(1108, 500, '[\"Chevreuil\",\"Lapin\",\"Jaguar\",\"Loup\",\"Cerf\"]'),
(1047, 610, '[\"Chevreuil\",\"Lapin\",\"Jaguar\",\"Loup\",\"Cerf\"]'),
(484, 380, '[\"Chevreuil\",\"Lapin\",\"Jaguar\",\"Loup\"]'),
(1172, 20, '[\"Lapin\"]'),
(515, 170, '[\"Chevreuil\",\"Lapin\"]'),
(1032, 270, '[\"Chevreuil\",\"Lapin\",\"Jaguar\",\"Loup\"]'),
(1197, -30, '[\"Lapin\"]'),
(1248, 310, '[\"Chevreuil\",\"Lapin\",\"Jaguar\",\"Loup\"]'),
(585, 130, '[\"Chevreuil\",\"Lapin\"]'),
(537, 0, '[\"Lapin\"]'),
(1271, 660, '[\"Chevreuil\",\"Lapin\",\"Jaguar\",\"Loup\",\"Cerf\"]'),
(1275, 0, '[\"Lapin\"]'),
(221, 30, '[\"Lapin\"]'),
(1256, 30, '[\"Lapin\"]'),
(1222, 0, '[\"Lapin\"]'),
(632, 390, '[\"Chevreuil\",\"Lapin\",\"Jaguar\",\"Loup\",\"Cerf\"]'),
(330, 10, '[\"Lapin\"]'),
(583, 0, '[\"Lapin\"]'),
(225, 60, '[\"Lapin\"]'),
(1417, 160, '[\"Chevreuil\",\"Lapin\"]'),
(1459, 590, '[\"Chevreuil\",\"Lapin\",\"Jaguar\",\"Loup\",\"Cerf\"]'),
(173, 20, '[\"Lapin\"]'),
(1326, 540, '[\"Chevreuil\",\"Lapin\",\"Jaguar\",\"Loup\",\"Cerf\"]'),
(1334, 590, '[\"Chevreuil\",\"Lapin\",\"Jaguar\",\"Loup\",\"Cerf\"]'),
(1490, -10, '[\"Lapin\"]'),
(1339, 520, '[\"Chevreuil\",\"Lapin\",\"Jaguar\",\"Loup\",\"Cerf\"]'),
(1236, 10, '[\"Lapin\"]'),
(1440, 120, '[\"Chevreuil\",\"Lapin\"]'),
(4, -50, '[\"Lapin\"]'),
(1498, 630, '[\"Chevreuil\",\"Lapin\",\"Jaguar\",\"Loup\",\"Cerf\"]'),
(1364, 100, '[\"Chevreuil\",\"Lapin\"]'),
(806, 0, '[\"Lapin\"]'),
(722, 360, '[\"Chevreuil\",\"Lapin\",\"Jaguar\",\"Loup\"]'),
(1583, 480, '[\"Chevreuil\",\"Lapin\",\"Jaguar\",\"Loup\",\"Cerf\"]'),
(322, 70, '[\"Lapin\"]'),
(1622, 20, '[\"Lapin\"]'),
(1611, 0, '[\"Lapin\"]'),
(1628, 0, '[\"Lapin\"]'),
(1630, 300, '[\"Chevreuil\",\"Lapin\",\"Jaguar\",\"Loup\"]'),
(201, 0, '[\"Lapin\"]'),
(1687, 30, '[\"Lapin\"]'),
(1761, 20, '[\"Lapin\"]'),
(544, 100, '[\"Chevreuil\",\"Lapin\"]'),
(1839, 140, '[\"Chevreuil\",\"Lapin\"]'),
(166, -50, '[\"Lapin\"]'),
(1, 0, '[\"Lapin\"]'),
(2, -150, '[\"Lapin\"]');

-- --------------------------------------------------------

--
-- Structure de la table `clothes_inventory`
--

CREATE TABLE `clothes_inventory` (
  `UniqueID` int(11) NOT NULL,
  `clothes` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `clothes_inventory`
--

INSERT INTO `clothes_inventory` (`UniqueID`, `clothes`) VALUES
(1, '[{\"number2\":3,\"informations\":false,\"name\":\"Chic White\",\"itemType\":\"shoes\",\"itemName\":\"shoes_1\",\"label\":\"Chic White\",\"image\":\"/src/html/assets/icons/shoes.png\",\"number\":93,\"informationsText\":\"Indéfini\",\"count\":1,\"usable\":true,\"type\":\"item_clothes\"},{\"number2\":8,\"informations\":false,\"name\":\"Chic White\",\"itemType\":\"pants\",\"itemName\":\"pants_1\",\"label\":\"Chic White\",\"image\":\"/src/html/assets/icons/pants.png\",\"number\":92,\"informationsText\":\"Indéfini\",\"count\":1,\"usable\":true,\"type\":\"item_clothes\"}]'),
(4, '[{\"usable\":true,\"label\":\"test\",\"number2\":0,\"informations\":false,\"itemName\":\"bproof_1\",\"number\":0,\"count\":1,\"name\":\"test\",\"informationsText\":\"Indéfini\",\"itemType\":\"bproof\",\"image\":\"/src/html/assets/icons/bproof.png\",\"type\":\"item_clothes\"},{\"usable\":true,\"label\":\"test\",\"number2\":0,\"informations\":false,\"image\":\"/src/html/assets/icons/shoes.png\",\"number\":30,\"count\":1,\"name\":\"test\",\"itemName\":\"shoes_1\",\"informationsText\":\"Indéfini\",\"itemType\":\"shoes\",\"type\":\"item_clothes\"},{\"usable\":true,\"label\":\"SACSKATE\",\"number2\":0,\"informations\":false,\"itemName\":\"bags_1\",\"number\":125,\"count\":1,\"name\":\"SACSKATE\",\"informationsText\":\"Indéfini\",\"itemType\":\"bags\",\"image\":\"/src/html/assets/icons/bags.png\",\"type\":\"item_clothes\"},{\"usable\":true,\"label\":\"lunette\",\"number2\":3,\"informations\":false,\"image\":\"/src/html/assets/icons/glasses.png\",\"number\":33,\"count\":1,\"name\":\"lunette\",\"itemName\":\"glasses_1\",\"informationsText\":\"Indéfini\",\"itemType\":\"glasses\",\"type\":\"item_clothes\"},{\"usable\":true,\"label\":\"test\",\"number2\":0,\"informations\":false,\"image\":\"/src/html/assets/icons/torso.png\",\"number\":693,\"count\":1,\"name\":\"test\",\"informationsText\":\"Indéfini\",\"itemType\":\"torso\",\"itemName\":\"torso_1\",\"type\":\"item_clothes\"},{\"usable\":true,\"label\":\"test\",\"number2\":3,\"informations\":false,\"itemName\":\"pants_1\",\"number\":86,\"count\":1,\"name\":\"test\",\"informationsText\":\"Indéfini\",\"itemType\":\"pants\",\"image\":\"/src/html/assets/icons/pants.png\",\"type\":\"item_clothes\"}]'),
(5, '[]'),
(6, '[{\"usable\":true,\"label\":\"33\\n\",\"number2\":0,\"informations\":false,\"itemName\":\"glasses_1\",\"informationsText\":\"Indéfini\",\"count\":1,\"image\":\"/src/html/assets/icons/glasses.png\",\"itemType\":\"glasses\",\"name\":\"33\\n\",\"number\":21,\"type\":\"item_clothes\"}]'),
(7, '[]'),
(8, '[]'),
(9, '[]'),
(10, '[]'),
(11, '[]'),
(13, '[]'),
(53, '[{\"type\":\"item_clothes\",\"name\":\"Chic Noir\",\"usable\":true,\"image\":\"/src/html/assets/icons/torso.png\",\"label\":\"Chic Noir\",\"number\":654,\"itemType\":\"torso\",\"informations\":false,\"itemName\":\"torso_1\",\"count\":1,\"number2\":3,\"informationsText\":\"Indéfini\"},{\"type\":\"item_clothes\",\"name\":\"Chic Noir\",\"usable\":true,\"image\":\"/src/html/assets/icons/pants.png\",\"informationsText\":\"Indéfini\",\"number\":92,\"itemType\":\"pants\",\"informations\":false,\"itemName\":\"pants_1\",\"count\":1,\"number2\":0,\"label\":\"Chic Noir\"},{\"type\":\"item_clothes\",\"name\":\"Chic Noir\",\"usable\":true,\"image\":\"/src/html/assets/icons/bproof.png\",\"label\":\"Chic Noir\",\"number\":0,\"itemType\":\"bproof\",\"informations\":false,\"itemName\":\"bproof_1\",\"count\":1,\"number2\":0,\"informationsText\":\"Indéfini\"},{\"type\":\"item_clothes\",\"name\":\"Chic Noir\",\"usable\":true,\"image\":\"/src/html/assets/icons/shoes.png\",\"informationsText\":\"Indéfini\",\"number\":10,\"itemType\":\"shoes\",\"informations\":false,\"itemName\":\"shoes_1\",\"count\":1,\"number2\":0,\"label\":\"Chic Noir\"},{\"type\":\"item_clothes\",\"name\":\"Lunette noir\",\"usable\":true,\"image\":\"/src/html/assets/icons/glasses.png\",\"informationsText\":\"Indéfini\",\"number\":16,\"itemType\":\"glasses\",\"informations\":false,\"itemName\":\"glasses_1\",\"count\":1,\"number2\":5,\"label\":\"Lunette noir\"}]'),
(54, '[]'),
(55, '[]'),
(56, '[{\"type\":\"item_clothes\",\"count\":1,\"name\":\"dead\",\"itemName\":\"pants_1\",\"itemType\":\"pants\",\"informationsText\":\"Indéfini\",\"number2\":1,\"label\":\"dead\",\"usable\":true,\"image\":\"/src/html/assets/icons/pants.png\",\"informations\":false,\"number\":248},{\"type\":\"item_clothes\",\"label\":\"dead\",\"name\":\"dead\",\"itemName\":\"torso_1\",\"itemType\":\"torso\",\"informationsText\":\"Indéfini\",\"informations\":false,\"number2\":0,\"usable\":true,\"image\":\"/src/html/assets/icons/torso.png\",\"count\":1,\"number\":155},{\"label\":\"dead\",\"count\":1,\"informationsText\":\"Indéfini\",\"itemName\":\"bproof_1\",\"itemType\":\"bproof\",\"name\":\"dead\",\"informations\":false,\"number2\":2,\"usable\":true,\"image\":\"/src/html/assets/icons/bproof.png\",\"type\":\"item_clothes\",\"number\":176}]'),
(57, '[{\"label\":\"oui\\n\",\"number2\":4,\"number\":30,\"itemName\":\"pants_1\",\"count\":1,\"image\":\"/src/html/assets/icons/pants.png\",\"usable\":true,\"type\":\"item_clothes\",\"itemType\":\"pants\",\"informationsText\":\"Indéfini\",\"informations\":false,\"name\":\"oui\\n\"},{\"label\":\"oui\\n\",\"number2\":6,\"number\":79,\"itemName\":\"torso_1\",\"count\":1,\"image\":\"/src/html/assets/icons/torso.png\",\"itemType\":\"torso\",\"type\":\"item_clothes\",\"informationsText\":\"Indéfini\",\"usable\":true,\"informations\":false,\"name\":\"oui\\n\"},{\"label\":\"flor\",\"number2\":0,\"number\":23,\"itemName\":\"helmet_1\",\"count\":1,\"usable\":true,\"itemType\":\"helmet\",\"type\":\"item_clothes\",\"informationsText\":\"Indéfini\",\"image\":\"/src/html/assets/icons/helmet.png\",\"informations\":false,\"name\":\"flor\"}]'),
(58, '[{\"itemName\":\"bags_1\",\"count\":1,\"informationsText\":\"Indéfini\",\"number2\":0,\"image\":\"/src/html/assets/icons/bags.png\",\"itemType\":\"bags\",\"number\":112,\"type\":\"item_clothes\",\"informations\":false,\"usable\":true}]'),
(59, '[]'),
(61, '[]'),
(62, '[]'),
(63, '[]');

-- --------------------------------------------------------

--
-- Structure de la table `crafting_benches`
--

CREATE TABLE `crafting_benches` (
  `id` int(11) NOT NULL,
  `coords` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`coords`)),
  `propName` varchar(255) NOT NULL,
  `benchName` varchar(255) NOT NULL,
  `heading` float NOT NULL,
  `identifier` varchar(50) NOT NULL,
  `metadata` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`metadata`)),
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `routingBucket` mediumint(9) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `crafting_players`
--

CREATE TABLE `crafting_players` (
  `identifier` varchar(50) NOT NULL,
  `level` int(11) NOT NULL DEFAULT 1,
  `xp` int(11) NOT NULL DEFAULT 0,
  `blueprints` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`blueprints`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `crafting_players`
--

INSERT INTO `crafting_players` (`identifier`, `level`, `xp`, `blueprints`) VALUES
('18', 1, 0, NULL),
('19', 1, 0, NULL),
('20', 1, 0, NULL),
('21', 1, 0, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `crafting_recipes`
--

CREATE TABLE `crafting_recipes` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `result_items` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `perfect_recipe_reward` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `ingredients` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `time` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `crew_liste`
--

CREATE TABLE `crew_liste` (
  `id_crew` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `devise` varchar(255) DEFAULT NULL,
  `color_hex` varchar(7) DEFAULT '#FFFFFF'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `crew_membres`
--

CREATE TABLE `crew_membres` (
  `id` int(11) NOT NULL,
  `identifier` varchar(60) NOT NULL,
  `label` varchar(100) NOT NULL,
  `id_grade` int(11) NOT NULL,
  `label_grade` varchar(100) NOT NULL,
  `rang_grade` int(11) NOT NULL DEFAULT 0,
  `id_crew` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `darkchat_messages`
--

CREATE TABLE `darkchat_messages` (
  `id` int(11) NOT NULL,
  `password` text NOT NULL,
  `owner` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT '',
  `messages` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `detention_records`
--

CREATE TABLE `detention_records` (
  `id` int(11) NOT NULL,
  `target_id` varchar(50) DEFAULT NULL,
  `officer_name` varchar(100) DEFAULT NULL,
  `reason` text DEFAULT NULL,
  `prison_name` varchar(50) DEFAULT NULL,
  `time` int(11) DEFAULT NULL,
  `release_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `dpkeybinds`
--

CREATE TABLE `dpkeybinds` (
  `id` varchar(50) DEFAULT NULL,
  `keybind1` varchar(50) DEFAULT 'num4',
  `emote1` varchar(255) DEFAULT '',
  `keybind2` varchar(50) DEFAULT 'num5',
  `emote2` varchar(255) DEFAULT '',
  `keybind3` varchar(50) DEFAULT 'num6',
  `emote3` varchar(255) DEFAULT '',
  `keybind4` varchar(50) DEFAULT 'num7',
  `emote4` varchar(255) DEFAULT '',
  `keybind5` varchar(50) DEFAULT 'num8',
  `emote5` varchar(255) DEFAULT '',
  `keybind6` varchar(50) DEFAULT 'num9',
  `emote6` varchar(255) DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Structure de la table `drugs_circuits`
--

CREATE TABLE `drugs_circuits` (
  `name` longtext DEFAULT NULL,
  `label` longtext DEFAULT NULL,
  `recolte` longtext DEFAULT NULL,
  `traitement` longtext DEFAULT NULL,
  `animtype` longtext DEFAULT NULL,
  `animdict` longtext DEFAULT NULL,
  `anim` longtext DEFAULT NULL,
  `animtime` int(11) DEFAULT NULL,
  `marker` tinyint(1) DEFAULT 0,
  `props` longtext DEFAULT NULL,
  `name_pooch` longtext DEFAULT NULL,
  `label_pooch` longtext DEFAULT NULL,
  `animtype_t` longtext DEFAULT NULL,
  `animdict_t` longtext DEFAULT NULL,
  `anim_t` longtext DEFAULT NULL,
  `animtime_t` int(11) DEFAULT NULL,
  `marker_t` tinyint(1) DEFAULT 0,
  `props_t` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `drugs_circuits`
--

INSERT INTO `drugs_circuits` (`name`, `label`, `recolte`, `traitement`, `animtype`, `animdict`, `anim`, `animtime`, `marker`, `props`, `name_pooch`, `label_pooch`, `animtype_t`, `animdict_t`, `anim_t`, `animtime_t`, `marker_t`, `props_t`) VALUES
('mdma', 'MDMA', '[{\"x\":2482.186279296875,\"y\":3722.605224609375,\"z\":43.92522430419922}]', '[{\"x\":106.07408905029297,\"y\":6903.52880859375,\"z\":19.48505401611328}]', 'anim', 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@', 'machinic_loop_mechandplayer', 5, 1, 'none', 'mdma_pochon', 'Pochon MDMA', 'anim', 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@', 'machinic_loop_mechandplayer', 5, 1, 'none');

-- --------------------------------------------------------

--
-- Structure de la table `drugs_creator_auctions`
--

CREATE TABLE `drugs_creator_auctions` (
  `id` int(11) NOT NULL,
  `label` varchar(100) NOT NULL,
  `config` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Structure de la table `drugs_fields`
--

CREATE TABLE `drugs_fields` (
  `id` int(11) NOT NULL,
  `label` varchar(50) NOT NULL,
  `coords` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `radius` int(11) NOT NULL,
  `object_model` varchar(50) NOT NULL,
  `max_objects` int(11) NOT NULL,
  `items` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `time` int(11) NOT NULL,
  `blip_name` varchar(50) DEFAULT NULL,
  `blip_sprite` int(11) DEFAULT NULL,
  `blip_color` int(11) DEFAULT NULL,
  `blip_scale` float DEFAULT NULL,
  `required_item` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `drugs_sell`
--

CREATE TABLE `drugs_sell` (
  `id` int(11) NOT NULL,
  `position` varchar(255) NOT NULL,
  `message` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `ediscordboost`
--

CREATE TABLE `ediscordboost` (
  `identifier` varchar(50) DEFAULT '255',
  `time` int(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `fine_types`
--

CREATE TABLE `fine_types` (
  `id` int(11) NOT NULL,
  `label` varchar(255) DEFAULT NULL,
  `amount` int(11) DEFAULT NULL,
  `category` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `fine_types`
--

INSERT INTO `fine_types` (`id`, `label`, `amount`, `category`) VALUES
(1, 'Usage abusif du klaxon', 300, 0),
(2, 'Franchir une ligne continue', 400, 0),
(3, 'Circulation à contresens', 2500, 0),
(4, 'Demi-tour non autorisé', 2500, 0),
(5, 'Circulation hors-route', 1700, 0),
(6, 'Non-respect des distances de sécurité', 300, 0),
(7, 'Arrêt dangereux / interdit', 1500, 0),
(8, 'Stationnement gênant / interdit', 700, 0),
(9, 'Non respect  de la priorité à droite', 700, 0),
(10, 'Non-respect à un véhicule prioritaire', 900, 0),
(11, 'Non-respect d\'un stop', 1050, 0),
(12, 'Non-respect d\'un feu rouge', 1300, 0),
(13, 'Dépassement dangereux', 1000, 0),
(14, 'Véhicule non en état', 1000, 0),
(15, 'Conduite sans permis', 15000, 0),
(16, 'Délit de fuite', 8000, 0),
(17, 'Excès de vitesse < 5 kmh', 900, 0),
(18, 'Excès de vitesse 5-15 kmh', 1200, 0),
(19, 'Excès de vitesse 15-30 kmh', 1800, 0),
(20, 'Excès de vitesse > 30 kmh', 3000, 0),
(21, 'Entrave de la circulation', 1100, 1),
(22, 'Dégradation de la voie publique', 900, 1),
(23, 'Trouble à l\'ordre publique', 900, 1),
(24, 'Entrave opération de police', 1300, 1),
(25, 'Insulte envers / entre civils', 750, 1),
(26, 'Outrage à agent de police', 110, 1),
(27, 'Menace verbale ou intimidation envers civil', 90, 1),
(28, 'Menace verbale ou intimidation envers policier', 150, 1),
(29, 'Manifestation illégale', 250, 1),
(30, 'Tentative de corruption', 1500, 1),
(31, 'Arme blanche sortie en ville', 120, 2),
(32, 'Arme léthale sortie en ville', 300, 2),
(33, 'Port d\'arme non autorisé (défaut de license)', 600, 2),
(34, 'Port d\'arme illégal', 700, 2),
(35, 'Pris en flag lockpick', 300, 2),
(36, 'Vol de voiture', 1800, 2),
(37, 'Vente de drogue', 1500, 2),
(38, 'Fabriquation de drogue', 1500, 2),
(39, 'Possession de drogue', 650, 2),
(40, 'Prise d\'ôtage civil', 1500, 2),
(41, 'Prise d\'ôtage agent de l\'état', 2000, 2),
(42, 'Braquage particulier', 650, 2),
(43, 'Braquage magasin', 650, 2),
(44, 'Braquage de banque', 1500, 2),
(45, 'Tir sur civil', 2000, 3),
(46, 'Tir sur agent de l\'état', 2500, 3),
(47, 'Tentative de meurtre sur civil', 3000, 3),
(48, 'Tentative de meurtre sur agent de l\'état', 5000, 3),
(49, 'Meurtre sur civil', 10000, 3),
(50, 'Meurte sur agent de l\'état', 30000, 3),
(51, 'Meurtre involontaire', 1800, 3),
(52, 'Escroquerie à l\'entreprise', 2000, 2);

-- --------------------------------------------------------

--
-- Structure de la table `fishing`
--

CREATE TABLE `fishing` (
  `UniqueID` int(11) DEFAULT NULL,
  `level` longtext DEFAULT 0,
  `fishList` longtext DEFAULT NULL,
  `permit` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `gangs_new`
--

CREATE TABLE `gangs_new` (
  `id` int(11) NOT NULL,
  `name` longtext DEFAULT NULL,
  `label` longtext DEFAULT NULL,
  `positions` longtext DEFAULT NULL,
  `permissions` longtext DEFAULT NULL,
  `circuit` longtext DEFAULT NULL,
  `chest` longtext DEFAULT NULL,
  `cat` longtext DEFAULT NULL,
  `blips` tinyint(1) DEFAULT NULL,
  `blipscolor` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `gangs_new`
--

INSERT INTO `gangs_new` (`id`, `name`, `label`, `positions`, `permissions`, `circuit`, `chest`, `cat`, `blips`, `blipscolor`) VALUES
(12, 'Cartel de Sinaloa', 'Cartel de Sinaloa', '{\"boss\":{\"x\":-3336.09130859375,\"y\":540.81591796875,\"z\":17.44402503967285},\"chest\":{\"x\":-3337.791748046875,\"y\":543.443115234375,\"z\":17.44402503967285}}', '{\"accounts_add\":{\"Plaza Boss\":true,\"Halcón\":true,\"Jefe Operaciones\":true,\"Sous Chef\":true,\"Cocinero\":true},\"items_remove\":{\"Jefe Operaciones\":true,\"Sous Chef\":true,\"Plaza Boss\":true},\"*\":{\"boss\":true,\"Sous Chef\":false,\"Halcón\":false,\"Jefe Operaciones\":true},\"recruit_remove_player\":{\"Sous Chef\":true,\"Jefe Operaciones\":true},\"accounts_remove\":{\"Sous Chef\":true,\"Jefe Operaciones\":true},\"change_group_player\":{\"Sous Chef\":true,\"Jefe Operaciones\":true},\"manage_members\":{\"Sous Chef\":true,\"Jefe Operaciones\":true},\"weapons_remove\":{\"Jefe Operaciones\":true,\"Sous Chef\":true,\"Plaza Boss\":true},\"items_add\":{\"Plaza Boss\":true,\"Halcón\":true,\"Jefe Operaciones\":true,\"Sous Chef\":true,\"Cocinero\":true},\"weapons_add\":{\"Plaza Boss\":true,\"Halcón\":true,\"Jefe Operaciones\":true,\"Sous Chef\":true,\"Cocinero\":true},\"weapons\":{\"Plaza Boss\":true,\"Sous Chef\":true,\"Jefe Operaciones\":true,\"Cocinero\":true},\"items\":{\"Plaza Boss\":true,\"Sous Chef\":true,\"Jefe Operaciones\":true,\"Cocinero\":true},\"accounts\":{\"Plaza Boss\":false,\"Sous Chef\":true,\"Jefe Operaciones\":true,\"Cocinero\":false},\"create_edit_grades\":{\"Sous Chef\":true,\"Jefe Operaciones\":true}}', '0', '{\"weapons\":[{\"name\":\"WEAPON_SWITCHBLADE\",\"count\":255,\"label\":\"Couteau à cran d\'arrêt\"}],\"accounts\":{\"black_money\":3604727,\"cash\":350000},\"items\":[{\"name\":\"hydrochloric_acid\",\"count\":132,\"label\":\"Acide chlorhydrique\"},{\"name\":\"gasoline\",\"count\":25,\"label\":\"Essence\"},{\"name\":\"coca_blend\",\"count\":27,\"label\":\"Mélange de coca\"},{\"name\":\"kevlar\",\"count\":34,\"label\":\"Kevlar\"},{\"name\":\"pure_meth_pills\",\"count\":37,\"label\":\"Pseudoéphédrine pure\"},{\"name\":\"phosphorerouge\",\"count\":86,\"label\":\"Phosphore rouge\"},{\"name\":\"kq_acetone\",\"count\":10,\"label\":\"Acétone\"},{\"name\":\"kq_ammonia\",\"count\":17,\"label\":\"Ammoniaque\"},{\"name\":\"methpure\",\"count\":1,\"label\":\"Méthamphétamine pure\"},{\"name\":\"kq_ethanol\",\"count\":1,\"label\":\"Éthanol\"},{\"name\":\"kq_meth_pills\",\"count\":22,\"label\":\"Pseudoéphédrine\"},{\"name\":\"kq_lithium\",\"count\":21,\"label\":\"Pack de lithium\"},{\"name\":\"kq_meth_lab_kit\",\"count\":1,\"label\":\"Kit de cuisson\"},{\"name\":\"crochetage_kit\",\"count\":1,\"label\":\"Kit de Crochetage\"},{\"name\":\"pistol_ammo\",\"count\":126,\"label\":\"Munitions pour pistolet\"},{\"name\":\"cokepure\",\"count\":537,\"label\":\"Cocaïne pure\"},{\"name\":\"bmx\",\"count\":8,\"label\":\"BMX\"},{\"name\":\"cement\",\"count\":19,\"label\":\"Ciment\"},{\"name\":\"lapin\",\"count\":1,\"label\":\"Lapin\"},{\"name\":\"coca_leaf\",\"count\":2,\"label\":\"Feuille de coca exotique\"},{\"name\":\"coke_pooch\",\"count\":2,\"label\":\"Pochon de Coke\"}]}', 'Cartel', 0, NULL),
(13, 'Vagos', 'Vagos', '{\"chest\":{\"x\":316.9051208496094,\"y\":-2043.51025390625,\"z\":20.93636894226074},\"boss\":{\"x\":313.8473815917969,\"y\":-2040.437255859375,\"z\":20.93387985229492}}', '{\"recruit_remove_player\":[],\"change_group_player\":[],\"accounts_add\":[],\"accounts_remove\":[],\"*\":{\"boss\":true},\"weapons\":[],\"items\":[],\"weapons_remove\":[],\"items_add\":[],\"create_edit_grades\":[],\"manage_members\":[],\"items_remove\":[],\"accounts\":[],\"weapons_add\":[]}', '0', '{\"accounts\":{\"cash\":0,\"black_money\":243355},\"weapons\":[{\"count\":255,\"label\":\"Couteau\",\"name\":\"WEAPON_KNIFE\"},{\"count\":1,\"label\":\"Couteau\",\"name\":\"WEAPON_KNIFE\"}],\"items\":[{\"count\":1,\"label\":\"Jumelles\",\"name\":\"jumelles\"},{\"count\":1,\"label\":\"Weed\",\"name\":\"weed\"},{\"count\":243,\"label\":\"Feuille de coca exotique\",\"name\":\"coca_leaf\"}]}', NULL, 0, NULL),
(14, 'Cartel De Cayo', 'Cartel de Cayo', '{\"boss\":{\"x\":4979.35595703125,\"y\":-5713.34765625,\"z\":19.88697242736816},\"chest\":{\"x\":4984.9619140625,\"y\":-5707.1181640625,\"z\":19.88697242736816}}', '{\"*\":{\"boss\":true},\"items_remove\":[],\"change_group_player\":[],\"items_add\":[],\"weapons_add\":[],\"accounts\":[],\"manage_members\":[],\"items\":[],\"create_edit_grades\":[],\"weapons\":[],\"accounts_add\":[],\"recruit_remove_player\":[],\"accounts_remove\":[],\"weapons_remove\":[]}', '0', '{\"items\":[{\"name\":\"combatpistol\",\"label\":\"Glock 17\",\"count\":130},{\"name\":\"kevlar\",\"label\":\"Kevlar\",\"count\":362},{\"name\":\"bat\",\"label\":\"Batte de baseball\",\"count\":50},{\"name\":\"battleaxe\",\"label\":\"Hache de combat\",\"count\":50},{\"name\":\"knife\",\"label\":\"Couteau\",\"count\":50},{\"name\":\"switchblade\",\"label\":\"Couteau pliant\",\"count\":50},{\"name\":\"rifle_ammo\",\"label\":\"Munitions pour fusil\",\"count\":3100},{\"name\":\"smg_ammo\",\"label\":\"Munitions pour mitraillette\",\"count\":6129},{\"name\":\"shotgun_ammo\",\"label\":\"Munitions pour fusil à pompe\",\"count\":6833},{\"name\":\"smg\",\"label\":\"Mitraillette MP5\",\"count\":3},{\"name\":\"machinepistol\",\"label\":\"TEC-9\",\"count\":5},{\"name\":\"minismg\",\"label\":\"Mini Uzi\",\"count\":4},{\"name\":\"microsmg\",\"label\":\"Micro Uzi\",\"count\":5},{\"name\":\"assaultrifle\",\"label\":\"Fusil d\'assaut AK-47\",\"count\":2},{\"name\":\"pistol50\",\"label\":\"Desert Eagle\",\"count\":8},{\"name\":\"tablet\",\"label\":\"Tablet\",\"count\":1}],\"accounts\":{\"cash\":4501,\"black_money\":1800159},\"weapons\":[{\"name\":\"WEAPON_HOMINGLAUNCHER\",\"label\":\"Lance tête-chercheuse\",\"count\":255},{\"name\":\"WEAPON_ASSAULTRIFLE\",\"label\":\"Fusil d\'assaut\",\"count\":150},{\"name\":\"WEAPON_ASSAULTRIFLE\",\"label\":\"Fusil d\'assaut\",\"count\":150}]}', 'Cartel', 0, NULL),
(15, 'Madrazo', 'Madrazo', '{\"boss\":{\"x\":1441.87548828125,\"y\":1142.0230712890626,\"z\":114.33203887939453},\"chest\":{\"x\":1441.4482421875,\"y\":1138.111083984375,\"z\":114.32554626464844}}', '{\"items_add\":{\"Lieutenant\":true,\"Soldat 1\":true,\"Soldat 2\":true,\"Soldat 3\":true,\"Bras Droit\":true,\"Sergent \":true},\"weapons_add\":{\"Lieutenant\":true,\"Soldat 1\":true,\"Soldat 2\":true,\"Soldat 3\":true,\"Bras Droit\":true,\"Sergent \":true},\"recruit_remove_player\":{\"Bras Droit\":true,\"Lieutenant\":true},\"manage_members\":{\"Bras Droit\":true},\"accounts_remove\":{\"Bras Droit\":true},\"weapons_remove\":{\"Lieutenant\":true,\"Bras Droit\":true,\"Sergent \":true},\"weapons\":{\"Lieutenant\":true,\"Bras Droit\":true,\"Sergent \":true},\"items\":{\"Lieutenant\":true,\"Soldat 1\":true,\"Soldat 2\":true,\"Soldat 3\":true,\"Bras Droit\":true,\"Sergent \":true},\"change_group_player\":{\"Bras Droit\":true},\"accounts\":{\"Bras Droit\":true},\"create_edit_grades\":{\"Bras Droit\":true},\"*\":{\"Bras Droit\":true,\"boss\":true},\"accounts_add\":{\"Lieutenant\":true,\"Soldat 1\":true,\"Soldat 2\":true,\"Soldat 3\":true,\"Bras Droit\":true,\"Sergent \":true},\"items_remove\":{\"Lieutenant\":true,\"Soldat 1\":false,\"Soldat 2\":true,\"Soldat 3\":true,\"Bras Droit\":true,\"Sergent \":true}}', '0', '{\"weapons\":[{\"name\":\"WEAPON_BAT\",\"label\":\"Batte\",\"count\":255}],\"accounts\":{\"cash\":483001,\"black_money\":494793},\"items\":[{\"name\":\"kq_ammonia\",\"label\":\"Ammoniaque\",\"count\":5},{\"name\":\"hydrochloric_acid\",\"label\":\"Acide chlorhydrique\",\"count\":390},{\"name\":\"poissonchat\",\"label\":\"Poisson Chat\",\"count\":1},{\"name\":\"battleaxe\",\"label\":\"Hache de combat\",\"count\":4},{\"name\":\"pure_meth_pills\",\"label\":\"Pseudoéphédrine pure\",\"count\":2},{\"name\":\"kq_acetone\",\"label\":\"Acétone\",\"count\":11},{\"name\":\"water\",\"label\":\"Eau\",\"count\":20},{\"name\":\"bread\",\"label\":\"Pain\",\"count\":1},{\"name\":\"coca_leaf\",\"label\":\"Feuille de coca exotique\",\"count\":357},{\"name\":\"hack_laptop\",\"label\":\"Ordinateur Portable\",\"count\":2},{\"name\":\"phosphorerouge\",\"label\":\"Phosphore rouge\",\"count\":2141},{\"name\":\"wire\",\"label\":\"Fil de fer\",\"count\":1},{\"name\":\"jumelles\",\"label\":\"Jumelles\",\"count\":1},{\"name\":\"soudeuse\",\"label\":\"Poste à souder\",\"count\":1},{\"name\":\"lockpick\",\"label\":\"Lockpick\",\"count\":2},{\"name\":\"hack_phone\",\"label\":\"Téléphone Jailbreak\",\"count\":1},{\"name\":\"kevlar\",\"label\":\"Kevlar\",\"count\":1},{\"name\":\"coca_blend\",\"label\":\"Mélange de coca\",\"count\":125},{\"name\":\"coca_paste\",\"label\":\"Pâte de coca\",\"count\":25},{\"name\":\"cement\",\"label\":\"Ciment\",\"count\":346},{\"name\":\"gasoline\",\"label\":\"Essence\",\"count\":400},{\"name\":\"combatpistol\",\"label\":\"Glock 17\",\"count\":5},{\"name\":\"tablet\",\"label\":\"Tablet\",\"count\":1},{\"label\":\"Appât d\'Eau Profonde\",\"name\":\"ocean_lures\",\"count\":300}]}', 'Orga', 0, NULL),
(16, 'McReary', 'McReary', '{\"chest\":{\"x\":-1525.311767578125,\"y\":148.8480224609375,\"z\":60.78971481323242},\"boss\":{\"x\":-1529.44873046875,\"y\":151.06224060058595,\"z\":60.79813766479492}}', '{\"items_add\":{\"co-lead\":true,\"lieutenant\":true},\"items_remove\":{\"co-lead\":true,\"lieutenant\":true},\"change_group_player\":{\"co-lead\":true},\"weapons_add\":{\"co-lead\":true,\"lieutenant\":true},\"weapons\":{\"co-lead\":true,\"lieutenant\":true},\"*\":{\"co-lead\":true,\"boss\":true},\"weapons_remove\":{\"co-lead\":true,\"lieutenant\":true},\"create_edit_grades\":{\"co-lead\":true},\"accounts\":{\"co-lead\":true},\"manage_members\":{\"co-lead\":true},\"accounts_remove\":{\"co-lead\":true},\"items\":{\"co-lead\":true,\"lieutenant\":true},\"recruit_remove_player\":{\"co-lead\":true},\"accounts_add\":{\"co-lead\":true,\"lieutenant\":true}}', '0', '{\"accounts\":{\"cash\":116040,\"black_money\":41513},\"weapons\":[{\"name\":\"WEAPON_BAT\",\"label\":\"Batte\",\"count\":255},{\"name\":\"WEAPON_BAT\",\"label\":\"Batte\",\"count\":255}],\"items\":[{\"name\":\"9mm\",\"label\":\"9mm Munition\",\"count\":549},{\"name\":\"kq_lithium\",\"label\":\"Pack de lithium\",\"count\":20},{\"name\":\"kq_ethanol\",\"label\":\"Éthanol\",\"count\":20},{\"name\":\"hack_laptop\",\"label\":\"Ordinateur Portable\",\"count\":1},{\"name\":\"hack_phone\",\"label\":\"Téléphone Jailbreak\",\"count\":1},{\"name\":\"kq_meth_lab_kit\",\"label\":\"Kit de cuisson\",\"count\":1},{\"name\":\"hydrochloric_acid\",\"label\":\"Acide chlorhydrique\",\"count\":12},{\"name\":\"762mm\",\"label\":\"7.62mm Munition\",\"count\":9},{\"name\":\"556mm\",\"label\":\"5.56mm Munition\",\"count\":10},{\"name\":\"68kal\",\"label\":\"Kal.68 Munition\",\"count\":100},{\"name\":\"mg_ammo\",\"label\":\"Munitions pour mitrailleuse\",\"count\":1},{\"name\":\"snspistol\",\"label\":\"Pistolet SNS\",\"count\":1},{\"name\":\"combatpistol\",\"label\":\"Glock 17\",\"count\":3}]}', 'Orga', 0, NULL),
(17, 'Duggan crime family', 'Duggan crime family', '{\"chest\":{\"x\":790.4530029296875,\"y\":3404.861572265625,\"z\":57.8841438293457},\"boss\":{\"x\":750.2612915039063,\"y\":3421.88232421875,\"z\":67.43805694580078}}', '{\"items\":[],\"change_group_player\":[],\"create_edit_grades\":[],\"*\":{\"boss\":true},\"items_add\":[],\"weapons\":[],\"accounts\":[],\"accounts_remove\":[],\"manage_members\":[],\"items_remove\":[],\"accounts_add\":[],\"weapons_remove\":[],\"weapons_add\":[],\"recruit_remove_player\":[]}', '0', '{\"accounts\":{\"black_money\":0,\"cash\":0},\"items\":[],\"weapons\":[]}', 'Orga', 0, NULL),
(18, 'Duggan', 'Duggan', '{\"chest\":{\"x\":790.27294921875,\"y\":3405.045654296875,\"z\":57.88414764404297},\"boss\":{\"x\":750.133056640625,\"y\":3422.416748046875,\"z\":67.43794250488281}}', '{\"items\":{\"Frère Rapprocher \":true,\"Petit Coussin\":false,\"Bras Droit\":true},\"accounts_add\":{\"Coussin\":true,\"Frère\":true,\"Frère Rapprocher \":true,\"Bras Droit\":true},\"create_edit_grades\":{\"Bras Droit\":false},\"*\":{\"boss\":true},\"items_add\":{\"Frère Rapprocher \":true,\"Coussin\":true,\"Frère\":true,\"Petit Coussin\":true,\"Bras Droit\":true},\"weapons\":{\"Frère Rapprocher \":true,\"Bras Droit\":true},\"accounts\":{\"Frère Rapprocher \":false,\"Bras Droit\":true},\"items_remove\":{\"Frère Rapprocher \":true,\"Coussin\":true,\"Frère\":true,\"Petit Coussin\":true,\"Bras Droit\":true},\"accounts_remove\":{\"Frère Rapprocher \":true,\"Frère\":false,\"Bras Droit\":true},\"change_group_player\":[],\"recruit_remove_player\":{\"Bras Droit\":true},\"weapons_remove\":{\"Frère Rapprocher \":true,\"Coussin\":true,\"Frère\":true,\"Petit Coussin\":true,\"Bras Droit\":true},\"weapons_add\":{\"Frère Rapprocher \":true,\"Coussin\":true,\"Frère\":true,\"Petit Coussin\":true,\"Bras Droit\":true},\"manage_members\":[]}', '0', '{\"accounts\":{\"cash\":150000,\"black_money\":0},\"items\":[],\"weapons\":[{\"name\":\"WEAPON_SWITCHBLADE\",\"label\":\"Couteau à cran d\'arrêt\",\"count\":255}]}', 'Orga', 0, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `garages`
--

CREATE TABLE `garages` (
  `id` int(11) NOT NULL,
  `name` varchar(50) DEFAULT 'none',
  `label` varchar(50) NOT NULL DEFAULT 'none',
  `defaultpos` varchar(255) DEFAULT NULL,
  `deletepos` varchar(255) DEFAULT NULL,
  `spawnpos` longtext DEFAULT NULL,
  `headingspawnpos` varchar(255) DEFAULT NULL,
  `activeblip` bit(1) DEFAULT NULL,
  `type` varchar(50) DEFAULT 'car'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Déchargement des données de la table `garages`
--

INSERT INTO `garages` (`id`, `name`, `label`, `defaultpos`, `deletepos`, `spawnpos`, `headingspawnpos`, `activeblip`, `type`) VALUES
(1, 'pc', 'Parking Central', '{\"z\":30.73324203491211,\"x\":215.437744140625,\"y\":-810.1314086914063}', '{\"z\":30.77027511596679,\"x\":221.9745330810547,\"y\":-786.7836303710938}', '[{\"z\":29.45521926879882,\"h\":64.86729431152344,\"x\":232.85386657714845,\"y\":-805.0956420898438},{\"z\":29.46154594421386,\"h\":62.95913696289062,\"x\":233.96218872070313,\"y\":-802.8009033203125},{\"z\":29.48854019165039,\"x\":235.16432189941407,\"h\":74.0940933227539,\"y\":-800.3082885742188}]', '162.05015563964844', b'1', 'car'),
(2, 'hangar_airport', 'Hangar airport 1', '{\"z\":14.04568004608154,\"y\":-2665.697998046875,\"x\":-1276.8614501953126}', '{\"x\":-1310.375,\"y\":-2720.837158203125,\"z\":15.0649127960205}', '[{\"x\":-1316.348388671875,\"z\":12.94494247436523,\"y\":-2731.16259765625,\"h\":147.71737670898438},{\"x\":-1329.6566162109376,\"z\":12.96492721557617,\"y\":-2754.07080078125,\"h\":150.55368041992188}]', '147.15330505371094', b'1', 'aircraft'),
(3, 'dock_marina', 'Dock Marina 1', '{\"z\":1.60516726970672,\"x\":-895.2451782226563,\"y\":-1331.3834228515626}', '{\"z\":1.08127129077911,\"x\":-892.1829833984375,\"y\":-1336.7296142578126}', '[{\"z\":-1.4748937189579,\"h\":291.3253173828125,\"x\":-931.0884399414063,\"y\":-1356.4119873046876},{\"z\":-1.45478234767913,\"x\":-966.6730346679688,\"h\":286.77239990234377,\"y\":-1370.198974609375},{\"z\":-1.58051393508911,\"h\":286.7681884765625,\"x\":-885.8867797851563,\"y\":-1343.6484375}]', '281.8470764160156', b'1', 'boat'),
(201, 'sandy_garage', 'Garage Sandy', '{\"x\":1542.3330078125,\"y\":3680.4755859375,\"z\":34.59654998779297}', '{\"x\":1546.4061279296876,\"y\":3684.100341796875,\"z\":34.45106506347656}', '[{\"h\":337.30059814453127,\"x\":1550.66748046875,\"z\":33.44745971679688,\"y\":3674.59521484375}]', NULL, b'1', 'car'),
(202, 'sandy_boat', 'Sandy Bateaux', '{\"x\":1400.24365234375,\"y\":3790.069580078125,\"z\":31.84799766540527}', '{\"x\":1398.984130859375,\"y\":3795.605712890625,\"z\":31.38217735290527}', '[{\"h\":351.4951171875,\"x\":1382.1025390625,\"z\":30.57751037597656,\"y\":3797.844970703125}]', NULL, b'1', 'boat'),
(203, 'sandy_bcso_heli', 'BCSO Aériens', '{\"x\":-466.67742919921877,\"y\":6005.9189453125,\"z\":31.48917198181152}', '{\"z\":41.58304977416992,\"x\":1729.6837158203126,\"y\":3863.082275390625}', '[{\"z\":40.60304977416992,\"x\":1729.6837158203126,\"h\":221.4136199951172,\"y\":3863.082275390625}]', NULL, b'0', 'aircraft'),
(204, 'paleto_bcso', 'Paleto BCSO', '{\"x\":1789.6358642578126,\"y\":3755.377685546875,\"z\":39.56131744384765}', '{\"x\":-459.3150939941406,\"z\":31.31083488464355,\"y\":5987.0205078125}', '[{\"x\":-465.0893859863281,\"h\":43.72171783447265,\"z\":30.32791664123535,\"y\":5980.115234375}]', NULL, b'0', 'car'),
(205, 'paleto_garage', 'Garaga Paleto', '{\"x\":105.27259826660156,\"y\":6613.736328125,\"z\":32.3973274230957}', '{\"x\":117.05117797851563,\"y\":6599.6572265625,\"z\":32.00846862792969}', '[{\"z\":30.93478729248047,\"x\":119.82846069335938,\"h\":324.8345031738281,\"y\":6609.6591796875}]', NULL, b'0', 'car'),
(206, 'paleto_bcso_heli', 'BCSO Aériens Paleto', '{\"x\":-480.13421630859377,\"y\":5972.32958984375,\"z\":31.30229377746582}', '{\"x\":-475.4081726074219,\"y\":5988.54736328125,\"z\":31.33646965026855}', '[{\"z\":30.35646965026855,\"x\":-475.4081726074219,\"h\":298.8329772949219,\"y\":5988.54736328125}]', NULL, b'0', 'aircraft'),
(207, 'leftbeach_garage', 'Garage Plage Gauche', '{\"x\":-3156.890869140625,\"y\":1093.45654296875,\"z\":20.85467147827148}', '{\"x\":-3153.370849609375,\"y\":1092.623291015625,\"z\":20.70772743225097}', '[{\"z\":19.72720672607422,\"x\":-3151.6875,\"h\":282.340087890625,\"y\":1095.885986328125}]', NULL, b'1', 'car'),
(208, 'ems_garage', 'Garage EMS', '{\"x\":293.8675842285156,\"y\":-599.842041015625,\"z\":43.30205154418945}', '{\"x\":296.14093017578127,\"y\":-606.9788818359375,\"z\":43.32892227172851}', '[{\"z\":42.41240264892578,\"x\":293.5664978027344,\"h\":61.77568435668945,\"y\":-613.1773071289063}]', NULL, b'0', 'car'),
(210, 'police_garage', 'Police', '{\"x\":76.72515106201172,\"y\":-387.6198425292969,\"z\":38.36684799194336}', '{\"x\":73.93659973144531,\"y\":-396.49212646484377,\"z\":38.36689376831055}', '[{\"x\":64.98226928710938,\"y\":-396.0665283203125,\"z\":37.38685562133789,\"h\":247.25498962402345},{\"x\":66.33686828613281,\"y\":-391.7403564453125,\"z\":37.36688995361328,\"h\":242.03652954101563}]', NULL, b'0', 'car'),
(211, 'sandy_bcso', 'sandy_bcso', '{\"x\":1749.390869140625,\"y\":3886.221435546875,\"z\":34.6863784790039}', '{\"x\":1750.97265625,\"y\":3879.0595703125,\"z\":34.64656829833984}', '[{\"x\":1740.118896484375,\"h\":300.141357421875,\"z\":33.67858840942383,\"y\":3875.886962890625}]', NULL, b'0', 'car'),
(212, 'villa-madrazo', 'Villa Madrazo', '{\"x\":-1488.198974609375,\"y\":18.36956405639648,\"z\":54.71760940551758}', '{\"x\":-1490.5205078125,\"y\":24.69636535644531,\"z\":54.7542839050293}', '[{\"y\":24.69621467590332,\"z\":53.7742839050293,\"h\":347.8213195800781,\"x\":-1490.5205078125}]', NULL, b'0', 'car'),
(213, 'coke_island_boat', 'Île', '{\"x\":5497.58447265625,\"y\":2262.285888671875,\"z\":2.98080849647521}', '{\"z\":0.76285117864608,\"y\":2274.01953125,\"x\":5493.47802734375}', '[{\"h\":109.80205535888672,\"z\":-0.21714882135391,\"y\":2274.01953125,\"x\":5493.47802734375}]', NULL, b'0', 'boat'),
(214, 'coke_island_aircraft', 'Île', '{\"x\":5578.291015625,\"y\":2171.10791015625,\"z\":12.95929527282714}', '{\"x\":5588.3486328125,\"y\":2172.797119140625,\"z\":12.50102806091308}', '[{\"x\":5588.3486328125,\"z\":11.52102806091308,\"y\":2172.797119140625,\"h\":304.7853698730469}]', NULL, b'0', 'aircraft'),
(215, 'villa1', 'Villa 1', '{\"x\":-1253.5521240234376,\"y\":809.6049194335938,\"z\":193.37997436523438}', '{\"x\":-1252.2374267578126,\"y\":816.0172729492188,\"z\":193.37997436523438}', '[{\"h\":29.56255912780761,\"x\":-1252.1505126953126,\"y\":815.9951171875,\"z\":192.39997436523439}]', NULL, b'0', 'car'),
(216, 'villa1.2', 'Villa 1 Helico', '{\"x\":-1282.442138671875,\"y\":760.0734252929688,\"z\":190.82989501953126}', '{\"x\":-1288.176025390625,\"y\":756.8605346679688,\"z\":190.8351593017578}', '[{\"h\":204.72933959960938,\"x\":-1288.163330078125,\"y\":756.8800048828125,\"z\":189.85515930175783}]', NULL, b'0', 'aircraft'),
(217, 'taxicar', 'Taxicar', '{\"x\":871.070556640625,\"y\":-160.79696655273438,\"z\":69.42191314697266}', '{\"x\":881.8155517578125,\"y\":-160.27610778808595,\"z\":69.39041900634766}', '[{\"h\":238.720947265625,\"y\":-157.1535186767578,\"z\":68.42475463867187,\"x\":876.2837524414063},{\"h\":238.50216674804688,\"y\":-159.59169006347657,\"z\":68.43151428222656,\"x\":874.674072265625},{\"h\":239.30520629882813,\"y\":-154.6509552001953,\"z\":68.41777374267578,\"x\":877.9386596679688},{\"h\":238.7008056640625,\"y\":-151.87730407714845,\"z\":68.41117431640625,\"x\":879.5030517578125}]', NULL, b'0', 'car'),
(218, 'ammunation', 'Ammunation', '{\"x\":-1319.187255859375,\"y\":-395.5570373535156,\"z\":36.59865570068359}', '{\"x\":-1323.7532958984376,\"y\":-387.6374816894531,\"z\":36.55613327026367}', '[{\"y\":-396.38128662109377,\"h\":33.90383529663086,\"x\":-1329.3468017578126,\"z\":35.47465087890625},{\"y\":-400.1935119628906,\"h\":28.63836097717285,\"x\":-1335.197509765625,\"z\":35.45971252441406}]', NULL, b'1', 'car'),
(219, 'Parking Principal', 'PC2', '{\"x\":-345.9163513183594,\"y\":-875.054931640625,\"z\":31.08417129516601}', '{\"x\":-353.7779235839844,\"y\":-880.5213012695313,\"z\":31.07143402099609}', '[{\"y\":-889.0284423828125,\"x\":-314.5383605957031,\"h\":70.83589172363281,\"z\":30.09977294921875},{\"y\":-891.9327392578125,\"x\":-300.78851318359377,\"h\":70.67552947998047,\"z\":30.10060073852539}]', NULL, b'1', 'car'),
(220, 'parking_2', 'Parking Grange', '{\"x\":-87.45509338378906,\"y\":1877.7344970703126,\"z\":197.32583618164063}', '{\"x\":-79.6023178100586,\"y\":1879.413330078125,\"z\":197.2173309326172}', '[{\"y\":1888.537109375,\"h\":147.2346649169922,\"x\":-63.33160400390625,\"z\":195.21285583496096},{\"y\":1875.3203125,\"h\":90.66307830810547,\"x\":-53.1242561340332,\"z\":195.88265563964846}]', NULL, b'1', 'car'),
(221, 'parking_3', 'Parking Paleto', '{\"x\":112.9619369506836,\"y\":6376.36279296875,\"z\":31.37590026855468}', '{\"x\":109.33660125732422,\"y\":6381.28466796875,\"z\":31.2258243560791}', '[{\"y\":6376.42724609375,\"h\":5.95497798919677,\"x\":101.82656860351563,\"z\":30.2458243560791},{\"y\":6372.33984375,\"h\":5.21031761169433,\"x\":94.47178649902344,\"z\":30.2458243560791}]', NULL, b'1', 'car'),
(222, 'parking_sandy_helico', 'Parking Sandy Helico', '{\"x\":1714.807373046875,\"y\":3275.628173828125,\"z\":41.14509963989258}', '{\"x\":1770.2337646484376,\"y\":3240.2109375,\"z\":42.11545944213867}', '[{\"y\":3240.2109375,\"h\":239.2730712890625,\"x\":1770.2337646484376,\"z\":41.13545944213867},{\"y\":3254.76513671875,\"h\":102.80104064941406,\"x\":1710.818359375,\"z\":40.0770182800293}]', NULL, b'1', 'aircraft'),
(223, 'Rockford', 'rockford', '{\"x\":-754.662841796875,\"y\":-75.79722595214844,\"z\":41.7537841796875}', '{\"x\":-745.7488403320313,\"y\":-71.41999816894531,\"z\":41.75031661987305}', '[{\"y\":-77.83419799804688,\"x\":-742.92333984375,\"h\":20.98543548583984,\"z\":40.76689483642578},{\"y\":-75.96763610839844,\"x\":-739.4658813476563,\"h\":26.57181930541992,\"z\":40.76694061279297},{\"y\":-74.68482208251953,\"x\":-735.9535522460938,\"h\":28.85975074768066,\"z\":40.76673843383789}]', NULL, b'1', 'car'),
(224, 'parking_4', 'Parking Autoroute', '{\"x\":2588.286376953125,\"y\":425.98199462890627,\"z\":108.50659942626953}', '{\"x\":2579.1220703125,\"y\":428.3394470214844,\"z\":108.45570373535156}', '[{\"y\":428.10302734375,\"h\":8.06246757507324,\"x\":2568.37939453125,\"z\":107.4756884765625},{\"y\":409.2273254394531,\"h\":3.56273341178894,\"x\":2569.148681640625,\"z\":107.47652770996094}]', NULL, b'1', 'car'),
(225, 'parking_5', 'Parking Fourrière', '{\"x\":430.509765625,\"y\":-1279.8125,\"z\":30.41626930236816}', '{\"x\":421.2193908691406,\"y\":-1284.4705810546876,\"z\":30.26226997375488}', '[{\"y\":-1289.4398193359376,\"h\":318.0606689453125,\"x\":414.8553161621094,\"z\":29.28924133300781},{\"y\":-1277.3033447265626,\"h\":243.55703735351563,\"x\":407.40087890625,\"z\":29.29394104003906}]', NULL, b'1', 'car'),
(226, 'parking_6', 'Parking Marina', '{\"x\":-831.8294067382813,\"y\":-1330.42431640625,\"z\":5.15208101272583}', '{\"x\":-829.6473999023438,\"y\":-1320.8873291015626,\"z\":5.00034284591674}', '[{\"y\":-1312.8118896484376,\"h\":347.4923095703125,\"x\":-813.9197998046875,\"z\":4.0262346458435},{\"y\":-1296.2125244140626,\"h\":163.68295288085938,\"x\":-811.2744140625,\"z\":4.02038242340087}]', NULL, b'1', 'car'),
(227, 'parking_7', 'Parking Pêche Grape Seed', '{\"x\":1299.0855712890626,\"y\":4322.3662109375,\"z\":38.25406265258789}', '{\"x\":1302.8204345703126,\"y\":4325.82177734375,\"z\":38.41980361938476}', '[{\"y\":4313.921875,\"h\":323.11834716796877,\"x\":1307.389404296875,\"z\":36.72991897583008},{\"y\":4332.46142578125,\"h\":270.0415344238281,\"x\":1294.953125,\"z\":37.54588653564453}]', NULL, b'1', 'car'),
(228, 'parking_9', 'Parking Livraison', '{\"x\":966.0907592773438,\"y\":-1811.4278564453126,\"z\":31.17859649658203}', '{\"x\":968.7085571289063,\"y\":-1818.6629638671876,\"z\":31.09031867980957}', '[{\"y\":-1824.7218017578126,\"h\":0.12698569893836,\"x\":969.5081787109375,\"z\":30.12181617736816},{\"y\":-1817.6868896484376,\"h\":84.32490539550781,\"x\":980.69970703125,\"z\":30.20135643005371}]', NULL, b'1', 'car'),
(229, 'parking_10', 'Parking Aéroport', '{\"x\":-906.822998046875,\"y\":-2039.1212158203126,\"z\":9.40497970581054}', '{\"x\":-898.6197509765625,\"y\":-2048.46533203125,\"z\":9.30317497253418}', '[{\"y\":-2050.173828125,\"h\":220.32992553710938,\"x\":-912.8701171875,\"z\":8.31903507232666}]', NULL, b'1', 'car'),
(230, 'cayo', 'cayo', '{\"x\":4982.20947265625,\"y\":-5693.98681640625,\"z\":19.886962890625}', '{\"x\":4989.20263671875,\"y\":-5684.8193359375,\"z\":20.09181213378906}', '[{\"h\":140.31544494628907,\"z\":19.01393844604492,\"y\":-5687.72509765625,\"x\":4987.4072265625}]', NULL, b'0', 'car'),
(231, 'car_vigneron', 'Garage Vigneron', '{\"x\":-1925.5537109375,\"y\":2048.15478515625,\"z\":140.83206176757813}', '{\"x\":-1920.55908203125,\"y\":2048.664306640625,\"z\":140.73492431640626}', '[{\"h\":248.7144775390625,\"x\":-1920.41796875,\"y\":2048.711181640625,\"z\":139.75493957519533},{\"h\":258.2930603027344,\"x\":-1919.721923828125,\"y\":2052.711181640625,\"z\":139.75504638671877},{\"h\":254.61041259765626,\"x\":-1918.927001953125,\"y\":2056.674560546875,\"z\":139.7551531982422},{\"h\":258.9326477050781,\"x\":-1921.82421875,\"y\":2044.613525390625,\"z\":139.7547412109375}]', NULL, b'0', 'car'),
(232, 'car_lscustoms', 'Garage LSCustom\'s', '{\"x\":-357.8121643066406,\"y\":-107.69117736816406,\"z\":38.70040130615234}', '{\"x\":-370.3961181640625,\"y\":-107.66962432861328,\"z\":38.68401336669922}', '[{\"h\":68.06565856933594,\"x\":-370.3970947265625,\"y\":-107.66983795166016,\"z\":37.70401336669922},{\"h\":72.5738296508789,\"x\":-356.32611083984377,\"y\":-110.31575775146485,\"z\":37.72026016235352},{\"h\":162.15240478515626,\"x\":-359.3999938964844,\"y\":-123.711669921875,\"z\":37.71945907592774}]', NULL, b'0', 'car'),
(234, 'vagos', 'vagos', '{\"x\":327.6126403808594,\"y\":-2034.0263671875,\"z\":20.94764328002929}', '{\"x\":312.6851806640625,\"y\":-2021.0089111328126,\"z\":20.42727088928222}', '[{\"y\":-2027.2498779296876,\"z\":19.73053504943847,\"x\":319.94952392578127,\"h\":51.13272857666015}]', NULL, b'0', 'car'),
(235, 'Garage Madrazo', 'gmadrazo', '{\"x\":1407.881591796875,\"y\":1114.8983154296876,\"z\":114.83773040771485}', '{\"x\":1407.670654296875,\"y\":1118.2861328125,\"z\":114.83773040771485}', '[{\"z\":113.8577456665039,\"y\":1117.9486083984376,\"h\":92.16088104248047,\"x\":1400.701171875}]', NULL, b'0', 'car'),
(236, 'Helico', 'Helico', '{\"x\":1460.2686767578126,\"y\":1111.8538818359376,\"z\":116.22811126708985}', '{\"x\":1462.2664794921876,\"y\":1111.821044921875,\"z\":116.22811126708985}', '[{\"x\":1460.616943359375,\"y\":1111.362060546875,\"z\":115.24811126708984,\"h\":74.22420501708985}]', NULL, b'0', 'aircraft'),
(237, 'sinaloa', 'sinaloa', '{\"x\":-3276.97216796875,\"y\":534.3275146484375,\"z\":12.26541423797607}', '{\"x\":-3272.251220703125,\"y\":533.6539306640625,\"z\":12.26540184020996}', '[{\"x\":-3280.298095703125,\"y\":526.85791015625,\"z\":11.28541423797607,\"h\":125.91364288330078}]', NULL, b'0', 'car'),
(238, 'sinaloaboat', 'sinaloaboat', '{\"x\":-3373.070556640625,\"y\":594.0513305664063,\"z\":3.67391848564147}', '{\"x\":-3383.26611328125,\"y\":594.9461669921875,\"z\":-0.02042291685938}', '[{\"x\":-3390.834716796875,\"y\":610.2230834960938,\"z\":-1.30108843326568,\"h\":40.24918365478515}]', NULL, b'0', 'boat'),
(239, 'pacificbluff', 'pacificbluff', '{\"x\":-3115.574462890625,\"y\":87.78883361816406,\"z\":11.50630092620849}', '{\"x\":-3117.428466796875,\"y\":76.45403289794922,\"z\":13.02966403961181}', '[{\"x\":-3117.428466796875,\"y\":76.45403289794922,\"z\":12.04966403961181,\"h\":175.39419555664063}]', NULL, b'0', 'aircraft'),
(240, 'pacificbluffboat', 'pacificbluffboat', '{\"x\":-3046.2744140625,\"y\":-46.77909851074219,\"z\":3.8787772655487}', '{\"x\":-3041.2158203125,\"y\":-65.85303497314453,\"z\":0.00216955970972}', '[{\"x\":-3041.217041015625,\"y\":-65.85292053222656,\"z\":-0.81874987065792,\"h\":248.0730438232422}]', NULL, b'0', 'boat'),
(241, 'pacificbluffcar', 'pacificbluffcar', '{\"x\":-2952.728271484375,\"y\":49.71783828735351,\"z\":11.60876083374023}', '{\"x\":-2957.00927734375,\"y\":58.37648773193359,\"z\":11.60883235931396}', '[{\"x\":-2957.303955078125,\"y\":58.57454299926758,\"z\":10.62850429534912,\"h\":56.04696273803711}]', NULL, b'0', 'car'),
(242, 'police_1', 'LSPD Intérieur', '{\"x\":-1064.263671875,\"y\":-727.6527099609375,\"z\":19.14602279663086}', '{\"x\":-1058.3419189453126,\"y\":-733.9580078125,\"z\":19.14967918395996}', '[{\"y\":-728.9244384765625,\"z\":18.31752349853515,\"x\":-1051.1016845703126,\"h\":309.52886962890627},{\"y\":-730.5863647460938,\"z\":18.46553184509277,\"x\":-1043.30859375,\"h\":288.4932861328125},{\"y\":-731.26220703125,\"z\":18.60539199829101,\"x\":-1037.07861328125,\"h\":307.403564453125}]', NULL, b'0', 'car'),
(243, 'police_vp', 'LSPD Vespucci', '{\"x\":-1061.931396484375,\"y\":-871.6513671875,\"z\":5.26974534988403}', '{\"x\":-1052.4676513671876,\"y\":-856.9757690429688,\"z\":4.87429428100585}', '[{\"y\":-855.060302734375,\"x\":-1039.3763427734376,\"h\":59.46294021606445,\"z\":3.89501287460327},{\"y\":-858.6564331054688,\"x\":-1042.021484375,\"h\":57.82698822021484,\"z\":3.90738918304443},{\"y\":-862.049560546875,\"x\":-1044.3148193359376,\"h\":65.97406768798828,\"z\":3.93942644119262},{\"y\":-864.597412109375,\"x\":-1048.54052734375,\"h\":53.99195861816406,\"z\":4.02316333770751},{\"y\":-866.7578125,\"x\":-1052.05908203125,\"h\":68.84014129638672,\"z\":4.14201690673828}]', NULL, b'0', 'car');

-- --------------------------------------------------------

--
-- Structure de la table `gfxmdt_appointment`
--

CREATE TABLE `gfxmdt_appointment` (
  `id` varchar(50) NOT NULL,
  `date` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Déchargement des données de la table `gfxmdt_appointment`
--

-- --------------------------------------------------------

--
-- Structure de la table `gfxmdt_avatars`
--

CREATE TABLE `gfxmdt_avatars` (
  `id` int(11) NOT NULL,
  `avatar` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `gfxmdt_banlist`
--

CREATE TABLE `gfxmdt_banlist` (
  `id` int(11) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `addedBy` varchar(50) DEFAULT NULL,
  `date` varchar(50) DEFAULT NULL,
  `avatar` varchar(50) DEFAULT NULL,
  `ranks` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `gfxmdt_department`
--

CREATE TABLE `gfxmdt_department` (
  `id` int(11) NOT NULL,
  `description` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `gfxmdt_fines`
--

CREATE TABLE `gfxmdt_fines` (
  `id` int(11) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `jailTime` varchar(50) DEFAULT NULL,
  `jailType` varchar(50) DEFAULT NULL,
  `money` varchar(50) DEFAULT NULL,
  `lastEdited` varchar(50) DEFAULT NULL,
  `addedBy` varchar(50) DEFAULT NULL,
  `punishment` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Déchargement des données de la table `gfxmdt_fines`
--

INSERT INTO `gfxmdt_fines` (`id`, `name`, `jailTime`, `jailType`, `money`, `lastEdited`, `addedBy`, `punishment`) VALUES
(1, 'Usage abusif du klaxon', '15', 'Minutes', '3000', '{\"time\":1714587600,\"editedBy\":\"Chief Of LSPD\"}', 'Chief Of LSPD', 'Aucun'),
(2, 'Franchir une ligne continue', '20', 'Minutes', '4000', '{\"time\":1714587600,\"editedBy\":\"Chief Of LSPD\"}', 'Chief Of LSPD', 'Aucun'),
(3, 'Circulation à contresens', '30', 'Minutes', '25000', '{\"time\":1714587600,\"editedBy\":\"Chief Of LSPD\"}', 'Chief Of LSPD', 'Aucun'),
(4, 'Demi-tour non autorisé', '25', 'Minutes', '25000', '{\"time\":1714587600,\"editedBy\":\"Chief Of LSPD\"}', 'Chief Of LSPD', 'Aucun'),
(5, 'Circulation hors-route', '20', 'Minutes', '17000', '{\"time\":1714587600,\"editedBy\":\"Chief Of LSPD\"}', 'Chief Of LSPD', 'Aucun'),
(6, 'Non-respect des distances de sécurité', '15', 'Minutes', '3000', '{\"time\":1714587600,\"editedBy\":\"Chief Of LSPD\"}', 'Chief Of LSPD', 'Aucun'),
(7, 'Arrêt dangereux / interdit', '20', 'Minutes', '15000', '{\"time\":1714587600,\"editedBy\":\"Chief Of LSPD\"}', 'Chief Of LSPD', 'Aucun'),
(8, 'Stationnement gênant / interdit', '15', 'Minutes', '7000', '{\"time\":1714587600,\"editedBy\":\"Chief Of LSPD\"}', 'Chief Of LSPD', 'Aucun'),
(9, 'Non respect  de la priorité à droite', '15', 'Minutes', '7000', '{\"time\":1714587600,\"editedBy\":\"Chief Of LSPD\"}', 'Chief Of LSPD', 'Aucun'),
(10, 'Non-respect à un véhicule prioritaire', '20', 'Minutes', '9000', '{\"time\":1714587600,\"editedBy\":\"Chief Of LSPD\"}', 'Chief Of LSPD', 'Aucun'),
(11, 'Non-respect d\'un stop', '20', 'Minutes', '10500', '{\"time\":1714587600,\"editedBy\":\"Chief Of LSPD\"}', 'Chief Of LSPD', 'Aucun'),
(12, 'Non-respect d\'un feu rouge', '25', 'Minutes', '13000', '{\"time\":1714587600,\"editedBy\":\"Chief Of LSPD\"}', 'Chief Of LSPD', 'Aucun'),
(13, 'Dépassement dangereux', '30', 'Minutes', '10000', '{\"time\":1714587600,\"editedBy\":\"Chief Of LSPD\"}', 'Chief Of LSPD', 'Aucun'),
(14, 'Véhicule non en état', '20', 'Minutes', '10000', '{\"time\":1714587600,\"editedBy\":\"Chief Of LSPD\"}', 'Chief Of LSPD', 'Aucun'),
(15, 'Conduite sans permis', '60', 'Minutes', '150000', '{\"time\":1714587600,\"editedBy\":\"Chief Of LSPD\"}', 'Chief Of LSPD', 'Aucun'),
(16, 'Délit de fuite', '60', 'Minutes', '80000', '{\"time\":1714587600,\"editedBy\":\"Chief Of LSPD\"}', 'Chief Of LSPD', 'Aucun'),
(17, 'Excès de vitesse < 5 kmh', '15', 'Minutes', '9000', '{\"time\":1714587600,\"editedBy\":\"Chief Of LSPD\"}', 'Chief Of LSPD', 'Aucun'),
(18, 'Excès de vitesse 5-15 kmh', '20', 'Minutes', '12000', '{\"time\":1714587600,\"editedBy\":\"Chief Of LSPD\"}', 'Chief Of LSPD', 'Aucun'),
(19, 'Excès de vitesse 15-30 kmh', '30', 'Minutes', '18000', '{\"time\":1714587600,\"editedBy\":\"Chief Of LSPD\"}', 'Chief Of LSPD', 'Aucun'),
(20, 'Excès de vitesse > 30 kmh', '45', 'Minutes', '30000', '{\"time\":1714587600,\"editedBy\":\"Chief Of LSPD\"}', 'Chief Of LSPD', 'Aucun'),
(21, 'Entrave de la circulation', '30', 'Minutes', '11000', '{\"time\":1714587600,\"editedBy\":\"Chief Of LSPD\"}', 'Chief Of LSPD', 'Aucun'),
(22, 'Dégradation de la voie publique', '25', 'Minutes', '9000', '{\"time\":1714587600,\"editedBy\":\"Chief Of LSPD\"}', 'Chief Of LSPD', 'Aucun'),
(23, 'Trouble à l\'ordre publique', '20', 'Minutes', '9000', '{\"time\":1714587600,\"editedBy\":\"Chief Of LSPD\"}', 'Chief Of LSPD', 'Aucun'),
(24, 'Entrave opération de police', '30', 'Minutes', '13000', '{\"time\":1714587600,\"editedBy\":\"Chief Of LSPD\"}', 'Chief Of LSPD', 'Aucun'),
(25, 'Insulte envers / entre civils', '15', 'Minutes', '7500', '{\"time\":1714587600,\"editedBy\":\"Chief Of LSPD\"}', 'Chief Of LSPD', 'Aucun'),
(26, 'Outrage à agent de police', '20', 'Minutes', '1100', '{\"time\":1714587600,\"editedBy\":\"Chief Of LSPD\"}', 'Chief Of LSPD', 'Aucun'),
(27, 'Menace verbale ou intimidation envers civil', '15', 'Minutes', '900', '{\"time\":1714587600,\"editedBy\":\"Chief Of LSPD\"}', 'Chief Of LSPD', 'Aucun'),
(28, 'Menace verbale ou intimidation envers policier', '20', 'Minutes', '1500', '{\"time\":1714587600,\"editedBy\":\"Chief Of LSPD\"}', 'Chief Of LSPD', 'Aucun'),
(29, 'Manifestation illégale', '25', 'Minutes', '2500', '{\"time\":1714587600,\"editedBy\":\"Chief Of LSPD\"}', 'Chief Of LSPD', 'Aucun'),
(30, 'Tentative de corruption', '40', 'Minutes', '15000', '{\"time\":1714587600,\"editedBy\":\"Chief Of LSPD\"}', 'Chief Of LSPD', 'Aucun'),
(31, 'Arme blanche sortie en ville', '30', 'Minutes', '1200', '{\"time\":1714587600,\"editedBy\":\"Chief Of LSPD\"}', 'Chief Of LSPD', 'Aucun'),
(32, 'Arme léthale sortie en ville', '45', 'Minutes', '3000', '{\"time\":1714587600,\"editedBy\":\"Chief Of LSPD\"}', 'Chief Of LSPD', 'Aucun'),
(33, 'Port d\'arme non autorisé (défaut de license)', '60', 'Minutes', '6000', '{\"time\":1714587600,\"editedBy\":\"Chief Of LSPD\"}', 'Chief Of LSPD', 'Aucun'),
(34, 'Port d\'arme illégal', '60', 'Minutes', '7000', '{\"time\":1714587600,\"editedBy\":\"Chief Of LSPD\"}', 'Chief Of LSPD', 'Aucun'),
(35, 'Pris en flag lockpick', '30', 'Minutes', '3000', '{\"time\":1714587600,\"editedBy\":\"Chief Of LSPD\"}', 'Chief Of LSPD', 'Aucun'),
(36, 'Vol de voiture', '60', 'Minutes', '18000', '{\"time\":1714587600,\"editedBy\":\"Chief Of LSPD\"}', 'Chief Of LSPD', 'Aucun'),
(37, 'Vente de drogue', '60', 'Minutes', '15000', '{\"time\":1714587600,\"editedBy\":\"Chief Of LSPD\"}', 'Chief Of LSPD', 'Aucun'),
(38, 'Fabriquation de drogue', '60', 'Minutes', '15000', '{\"time\":1714587600,\"editedBy\":\"Chief Of LSPD\"}', 'Chief Of LSPD', 'Aucun'),
(39, 'Possession de drogue', '30', 'Minutes', '6500', '{\"time\":1714587600,\"editedBy\":\"Chief Of LSPD\"}', 'Chief Of LSPD', 'Aucun'),
(40, 'Prise d\'ôtage civil', '90', 'Minutes', '15000', '{\"time\":1714587600,\"editedBy\":\"Chief Of LSPD\"}', 'Chief Of LSPD', 'Aucun'),
(41, 'Prise d\'ôtage agent de l\'état', '120', 'Minutes', '20000', '{\"time\":1714587600,\"editedBy\":\"Chief Of LSPD\"}', 'Chief Of LSPD', 'Aucun'),
(42, 'Braquage particulier', '60', 'Minutes', '6500', '{\"time\":1714587600,\"editedBy\":\"Chief Of LSPD\"}', 'Chief Of LSPD', 'Aucun'),
(43, 'Braquage magasin', '60', 'Minutes', '6500', '{\"time\":1714587600,\"editedBy\":\"Chief Of LSPD\"}', 'Chief Of LSPD', 'Aucun'),
(44, 'Braquage de banque', '120', 'Minutes', '15000', '{\"time\":1714587600,\"editedBy\":\"Chief Of LSPD\"}', 'Chief Of LSPD', 'Aucun'),
(45, 'Tir sur civil', '60', 'Minutes', '20000', '{\"time\":1714587600,\"editedBy\":\"Chief Of LSPD\"}', 'Chief Of LSPD', 'Aucun'),
(46, 'Tir sur agent de l\'état', '90', 'Minutes', '25000', '{\"time\":1714587600,\"editedBy\":\"Chief Of LSPD\"}', 'Chief Of LSPD', 'Aucun'),
(47, 'Tentative de meurtre sur civil', '90', 'Minutes', '30000', '{\"time\":1714587600,\"editedBy\":\"Chief Of LSPD\"}', 'Chief Of LSPD', 'Aucun'),
(48, 'Tentative de meurtre sur agent de l\'état', '120', 'Minutes', '50000', '{\"time\":1714587600,\"editedBy\":\"Chief Of LSPD\"}', 'Chief Of LSPD', 'Aucun'),
(49, 'Meurtre sur civil', '120', 'Minutes', '100000', '{\"time\":1714587600,\"editedBy\":\"Chief Of LSPD\"}', 'Chief Of LSPD', 'Aucun'),
(50, 'Meurte sur agent de l\'état', '120', 'Minutes', '300000', '{\"time\":1714587600,\"editedBy\":\"Chief Of LSPD\"}', 'Chief Of LSPD', 'Aucun'),
(51, 'Meurtre involontaire', '60', 'Minutes', '18000', '{\"time\":1714587600,\"editedBy\":\"Chief Of LSPD\"}', 'Chief Of LSPD', 'Aucun'),
(52, 'Escroquerie à l\'entreprise', '60', 'Minutes', '20000', '{\"time\":1714587600,\"editedBy\":\"Chief Of LSPD\"}', 'Chief Of LSPD', 'Aucun');

-- --------------------------------------------------------

--
-- Structure de la table `gfxmdt_notifications`
--

CREATE TABLE `gfxmdt_notifications` (
  `id` int(11) NOT NULL,
  `title` varchar(50) DEFAULT NULL,
  `text` varchar(50) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `gfxmdt_offenders`
--

CREATE TABLE `gfxmdt_offenders` (
  `id` int(11) NOT NULL,
  `avatar` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `madeBy` varchar(50) DEFAULT NULL,
  `ranks` varchar(50) DEFAULT NULL,
  `reportText` varchar(50) DEFAULT NULL,
  `evidences` varchar(50) DEFAULT NULL,
  `fines` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `gfxmdt_polices`
--

CREATE TABLE `gfxmdt_polices` (
  `id` int(11) NOT NULL,
  `avatar` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `madeBy` varchar(50) DEFAULT NULL,
  `ranks` varchar(50) DEFAULT NULL,
  `reportText` varchar(50) DEFAULT NULL,
  `evidences` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `gfxmdt_records`
--

CREATE TABLE `gfxmdt_records` (
  `id` int(11) NOT NULL,
  `avatar` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `text` varchar(50) DEFAULT NULL,
  `ranks` varchar(50) DEFAULT NULL,
  `date` varchar(50) DEFAULT NULL,
  `addedBy` varchar(50) DEFAULT NULL,
  `reportText` varchar(50) DEFAULT NULL,
  `offenders` varchar(50) DEFAULT NULL,
  `evidences` varchar(50) DEFAULT NULL,
  `polices` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `gfxmdt_wanteds`
--

CREATE TABLE `gfxmdt_wanteds` (
  `id` int(11) NOT NULL,
  `avatar` longtext DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `ranks` varchar(50) DEFAULT NULL,
  `date` varchar(50) DEFAULT NULL,
  `reportText` varchar(50) DEFAULT NULL,
  `addedBy` varchar(50) DEFAULT NULL,
  `evidences` longtext DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `gloveboxitems`
--

CREATE TABLE `gloveboxitems` (
  `id` int(11) NOT NULL,
  `plate` varchar(8) NOT NULL DEFAULT '[]',
  `items` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `gunfight_stats`
--

CREATE TABLE `gunfight_stats` (
  `identifier` varchar(64) NOT NULL,
  `name` varchar(100) NOT NULL,
  `kills` int(11) NOT NULL DEFAULT 0,
  `deaths` int(11) NOT NULL DEFAULT 0,
  `ratio` float NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `harvestable_items`
--

CREATE TABLE `harvestable_items` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `time_to_harvest` int(11) NOT NULL,
  `min_quantity` int(11) NOT NULL,
  `max_quantity` int(11) NOT NULL,
  `icon_type` int(11) NOT NULL,
  `coords` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `scale` longtext NOT NULL,
  `bounce` int(11) NOT NULL DEFAULT 0,
  `follow_camera` int(11) NOT NULL DEFAULT 0,
  `rotate` int(11) NOT NULL DEFAULT 0,
  `color` varchar(100) NOT NULL,
  `opacity` int(11) NOT NULL DEFAULT 0,
  `blip_name` varchar(50) DEFAULT NULL,
  `blip_sprite` int(11) DEFAULT NULL,
  `blip_color` int(11) DEFAULT NULL,
  `blip_scale` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `identity_cards`
--

CREATE TABLE `identity_cards` (
  `UID` longtext NOT NULL,
  `UniqueID` longtext NOT NULL,
  `firstname` longtext NOT NULL,
  `lastname` longtext NOT NULL,
  `dateofbirth` longtext NOT NULL,
  `sex` longtext NOT NULL,
  `height` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `illegal_drugs_circuits`
--

CREATE TABLE `illegal_drugs_circuits` (
  `name` longtext DEFAULT NULL,
  `label` longtext DEFAULT NULL,
  `recolte` longtext DEFAULT NULL,
  `traitement` longtext DEFAULT NULL,
  `animtype` longtext DEFAULT NULL,
  `animdict` longtext DEFAULT NULL,
  `anim` longtext DEFAULT NULL,
  `animtime` int(11) DEFAULT NULL,
  `marker` tinyint(1) DEFAULT 0,
  `props` longtext DEFAULT NULL,
  `name_pooch` longtext DEFAULT NULL,
  `label_pooch` longtext DEFAULT NULL,
  `animtype_t` longtext DEFAULT NULL,
  `animdict_t` longtext DEFAULT NULL,
  `anim_t` longtext DEFAULT NULL,
  `animtime_t` int(11) DEFAULT NULL,
  `marker_t` tinyint(1) DEFAULT 0,
  `props_t` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `illegal_drugs_sell`
--

CREATE TABLE `illegal_drugs_sell` (
  `id` int(11) NOT NULL,
  `position` varchar(255) DEFAULT NULL,
  `message` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `illegal_drugs_sell`
--

INSERT INTO `illegal_drugs_sell` (`id`, `position`, `message`) VALUES
(1, '{\"x\":223.64340209960938,\"y\":361.93609619140627,\"z\":106.01580047607422}', 'Salut, je viens d\'avoir ton contact, rejoins moi !'),
(2, '{\"x\":631.2670288085938,\"y\":126.13030242919922,\"z\":92.8271713256836}', 'J\'ai un paquet de fric pour toi, Rejoins moi !'),
(3, '{\"x\":919.8397827148438,\"y\":-101.06559753417969,\"z\":78.76405334472656}', 'J\'ai envie de m\'évader, rejoins moi !'),
(4, '{\"x\":744.7858276367188,\"y\":-1226.4090576171876,\"z\":24.76889991760254}', 'Mon dealos préféré, tu aurais pas un peu de dobe pour moi ? Rejoins moi !'),
(5, '{\"x\":48.1136589050293,\"y\":-1617.7509765625,\"z\":29.35910987854004}', 'Salut, je viens d\'avoir ton contact, rejoins moi !'),
(6, '{\"x\":-337.1455993652344,\"y\":-1485.842041015625,\"z\":30.58897018432617}', 'J\'ai un paquet de fric pour toi, Rejoins moi !'),
(7, '{\"x\":866.59130859375,\"y\":-1061.0830078125,\"z\":28.92093086242675}', 'J\'ai envie de m\'évader, rejoins moi !'),
(8, '{\"x\":1139.843994140625,\"y\":-793.9586791992188,\"z\":57.59371185302734}', 'Salut, je viens d\'avoir ton contact, rejoins moi !'),
(9, '{\"x\":1116.4549560546876,\"y\":-975.5618286132813,\"z\":46.4276008605957}', 'J\'ai un paquet de fric pour toi, Rejoins moi !'),
(10, '{\"x\":1255.7490234375,\"y\":-728.9434814453125,\"z\":63.08428955078125}', 'Mon dealos préféré, tu aurais pas un peu de dobe pour moi ? Rejoins moi !'),
(11, '{\"x\":1347.6109619140626,\"y\":-579.915283203125,\"z\":74.27182006835938}', 'Tu est où ? J\'ai besoin de ta dobe, rejoins moi !'),
(12, '{\"x\":955.7034912109375,\"y\":-1060.512939453125,\"z\":36.9140510559082}', 'Tu as encore du produit magique ? Rejoins moi, je sais que je peux compter sur toi !'),
(13, '{\"x\":1098.948974609375,\"y\":-257.17230224609377,\"z\":69.23422241210938}', 'Tu as encore un peu de produit pour moi ? Rejoins moi !'),
(14, '{\"x\":-337.54510498046877,\"y\":-937.4935913085938,\"z\":31.08061027526855}', 'Tu as encore du produit magique ? Rejoins moi, je sais que je peux compter sur toi !'),
(15, '{\"x\":-321.01458740234377,\"y\":-708.7540283203125,\"z\":32.90948867797851}', 'J\'ai besoin de ta dobe, rejoins moi à la position !'),
(16, '{\"x\":250.98289489746095,\"y\":-84.9937515258789,\"z\":69.94864654541016}', 'Mon dealos préféré, tu aurais pas un peu de dobe pour moi ? Rejoins moi !'),
(17, '{\"x\":-529.8306274414063,\"y\":-28.73513031005859,\"z\":44.48300170898437}', 'Salut, je viens d\'avoir ton contact, rejoins moi !'),
(18, '{\"x\":-1447.862060546875,\"y\":-366.66900634765627,\"z\":43.54209899902344}', 'J\'ai un paquet de fric pour toi, Rejoins moi !'),
(19, '{\"x\":-1665.5570068359376,\"y\":72.42794036865235,\"z\":63.42919158935547}', 'Tu est où ? J\'ai besoin de ta dobe, rejoins moi !'),
(20, '{\"x\":-1089.6529541015626,\"y\":-303.50421142578127,\"z\":37.64749908447265}', 'Tu as encore un peu de produit pour moi ? Rejoins moi !'),
(21, '{\"x\":67.83145904541016,\"y\":-582.4771728515625,\"z\":31.6286506652832}', 'J\'ai envie de m\'évader, rejoins moi !'),
(22, '{\"x\":508.6759948730469,\"y\":-609.5554809570313,\"z\":24.75115013122558}', 'Mon dealos préféré, tu aurais pas un peu de dobe pour moi ? Rejoins moi !'),
(23, '{\"x\":460.6315002441406,\"y\":-761.1773071289063,\"z\":27.35788917541504}', 'Tu as encore un peu de produit pour moi ? Rejoins moi !'),
(24, '{\"x\":469.0552062988281,\"y\":-585.181396484375,\"z\":28.49962997436523}', 'J\'ai envie de m\'évader, rejoins moi !'),
(25, '{\"x\":188.4803924560547,\"y\":-446.4894104003906,\"z\":41.65034103393555}', 'Tu as encore du produit magique ? Rejoins moi, je sais que je peux compter sur toi !'),
(26, '{\"x\":-113.11299896240235,\"y\":-603.218994140625,\"z\":36.28079986572265}', 'J\'ai besoin de ta dobe, rejoins moi à la position !'),
(27, '{\"x\":171.55740356445313,\"y\":-1235.2259521484376,\"z\":29.31716918945312}', 'Mon dealos préféré, tu aurais pas un peu de dobe pour moi ? Rejoins moi !'),
(28, '{\"x\":168.8957061767578,\"y\":-1074.22900390625,\"z\":29.19271087646484}', 'Salut, je viens d\'avoir ton contact, rejoins moi !'),
(29, '{\"x\":-1026.3599853515626,\"y\":-490.5504150390625,\"z\":36.95706939697265}', 'J\'ai un paquet de fric pour toi, Rejoins moi !'),
(30, '{\"x\":-1187.1409912109376,\"y\":-561.4119262695313,\"z\":27.69302940368652}', 'Tu as encore un peu de produit pour moi ? Rejoins moi !'),
(31, '{\"x\":-1625.845947265625,\"y\":-1013.4970092773438,\"z\":13.14282989501953}', 'J\'ai envie de m\'évader, rejoins moi !'),
(32, '{\"x\":-1478.70703125,\"y\":-1007.2210083007813,\"z\":6.27883720397949}', 'Salut, je viens d\'avoir ton contact, rejoins moi !'),
(33, '{\"x\":-1366.8370361328126,\"y\":-1118.6409912109376,\"z\":4.4401888847351}', 'J\'ai un paquet de fric pour toi, Rejoins moi !'),
(34, '{\"x\":-1307.5059814453126,\"y\":-1310.718017578125,\"z\":4.88076877593994}', 'J\'ai envie de m\'évader, rejoins moi !'),
(35, '{\"x\":-1249.5250244140626,\"y\":-1432.083984375,\"z\":4.32881879806518}', 'J\'ai besoin de ta dobe, rejoins moi à la position !'),
(36, '{\"x\":-1105.416015625,\"y\":-1289.6519775390626,\"z\":5.40987110137939}', 'J\'ai envie de m\'évader, rejoins moi !'),
(37, '{\"x\":-862.0740966796875,\"y\":-1225.4300537109376,\"z\":6.1647138595581}', 'Mon dealos préféré, tu aurais pas un peu de dobe pour moi ? Rejoins moi !'),
(38, '{\"x\":-770.1005859375,\"y\":-1068.8199462890626,\"z\":11.83907032012939}', 'Salut, je viens d\'avoir ton contact, rejoins moi !'),
(39, '{\"x\":-798.7150268554688,\"y\":372.9659118652344,\"z\":87.87606048583985}', 'J\'ai un paquet de fric pour toi, Rejoins moi !'),
(40, '{\"x\":-612.0228881835938,\"y\":333.997802734375,\"z\":85.1166763305664}', 'Tu as encore un peu de produit pour moi ? Rejoins moi !'),
(41, '{\"x\":-7.89298391342163,\"y\":-575.7495727539063,\"z\":37.74507904052734}', 'Tu est où ? J\'ai besoin de ta dobe, rejoins moi !'),
(42, '{\"x\":295.7923889160156,\"y\":-569.9384765625,\"z\":43.26082992553711}', 'Tu as encore du produit magique ? Rejoins moi, je sais que je peux compter sur toi !'),
(43, '{\"x\":382.614501953125,\"y\":-344.03131103515627,\"z\":46.81528091430664}', 'Mon dealos préféré, tu aurais pas un peu de dobe pour moi ? Rejoins moi !'),
(44, '{\"x\":274.8113098144531,\"y\":-326.7182922363281,\"z\":44.91986083984375}', 'Salut, je viens d\'avoir ton contact, rejoins moi !'),
(45, '{\"x\":182.42529296875,\"y\":-183.635498046875,\"z\":54.1486701965332}', 'J\'ai un paquet de fric pour toi, Rejoins moi !'),
(46, '{\"x\":-29.66706085205078,\"y\":-92.48367309570313,\"z\":57.25431060791015}', 'J\'ai envie de m\'évader, rejoins moi !'),
(47, '{\"x\":-359.9700012207031,\"y\":79.45751190185547,\"z\":63.18901824951172}', 'Tu as encore un peu de produit pour moi ? Rejoins moi !'),
(48, '{\"x\":-275.6081848144531,\"y\":201.5198974609375,\"z\":85.69867706298828}', 'Mon dealos préféré, tu aurais pas un peu de dobe pour moi ? Rejoins moi !'),
(49, '{\"x\":-448.37420654296877,\"y\":177.04269409179688,\"z\":75.20374298095703}', 'Salut, je viens d\'avoir ton contact, rejoins moi !'),
(50, '{\"x\":-499.0154113769531,\"y\":58.75120162963867,\"z\":56.49613189697265}', 'J\'ai un paquet de fric pour toi, Rejoins moi !');

-- --------------------------------------------------------

--
-- Structure de la table `illegal_laboratory`
--

CREATE TABLE `illegal_laboratory` (
  `id` int(11) NOT NULL,
  `name` longtext DEFAULT NULL,
  `type` longtext DEFAULT NULL,
  `interior` longtext DEFAULT NULL,
  `owner` longtext DEFAULT NULL,
  `pos` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `items`
--

CREATE TABLE `items` (
  `name` varchar(50) NOT NULL,
  `label` varchar(50) NOT NULL,
  `rare` int(11) NOT NULL DEFAULT 0,
  `can_remove` int(11) NOT NULL DEFAULT 1,
  `weight` float NOT NULL DEFAULT 0.3
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `items`
--

INSERT INTO `items` (`name`, `label`, `rare`, `can_remove`, `weight`) VALUES
('357', 'WEAPON_357', 0, 1, 1),
('5fromages', 'Pizza au 5 fromages', 0, 1, 0.3),
('accesscard', 'Access Card', 0, 1, 0.3),
('advancedrifle', 'Fusil Bullpup avancé', 0, 1, 3.5),
('ak-guard', 'WEAPON_GUARD', 0, 1, 1),
('ak-redl', 'WEAPON_REDL', 0, 1, 1),
('akorus', 'WEAPON_AKORUS', 0, 1, 1),
('aks74u', 'AKS-74U', 0, 1, 3),
('alien', 'WEAPON_ALIEN', 0, 1, 1),
('alive_chicken', 'Poulet vivant', 0, 1, 0.3),
('ananas', 'Ananas', 0, 1, 0.3),
('anchois', 'Anchois', 0, 0, 0),
('anchor', 'Ancre pour bateau', 0, 0, 10),
('ancient', 'WEAPON_ANCIENT', 0, 1, 1),
('appistol', 'FN Five-Seven', 0, 1, 1.5),
('ar15', 'AR-15', 0, 1, 4),
('arsakura', 'WEAPON_ARSAKURA', 0, 1, 1),
('assaultrifle', 'Fusil d\'assaut AK-47', 0, 1, 4),
('assaultrifle_mk2', 'Fusil d\'assaut MK2', 0, 1, 4),
('assaultshotgun', 'Fusil d\'assaut à pompe', 0, 1, 4),
('assaultsmg', 'P90', 0, 1, 3),
('autoshotgun', 'Fusil automatique', 0, 1, 4),
('ball', 'ball', 0, 1, 0.3),
('ball_ammo', 'Munitions pour balles', 0, 1, 0),
('bandage', 'Bandage', 0, 1, 0.3),
('bar', 'Bar', 0, 1, 0.3),
('barbecue', 'pizza au barbecue', 0, 1, 0.3),
('bat', 'Batte de baseball', 0, 1, 2.5),
('battleaxe', 'Hache de combat', 0, 1, 3),
('belini', 'Belini', 0, 1, 0.3),
('bierepleine', 'Bière Pleine', 0, 1, 0.3),
('bierevide', 'Bière Vide', 0, 1, 0.3),
('bijoux', 'Bijoux', 0, 1, 0.3),
('bird_crap_ammo', 'Excréments d\'oiseaux', 0, 1, 0.1),
('blacksniper', 'WEAPON_BLACKSNIPER', 0, 1, 1),
('black_phone', 'Black Phone', 0, 1, 10),
('blastak', 'WEAPON_BLASTAK', 0, 1, 1),
('blastm4', 'WEAPON_BLASTM4', 0, 1, 1),
('blowpipe', 'Chalumeaux', 0, 1, 0.3),
('blowtorch', 'Chalumeau', 0, 1, 0.3),
('blueriot', 'WEAPON_BLUERIOT', 0, 1, 1),
('blue_phone', 'Téléphone', 0, 1, 0.3),
('bmx', 'BMX', 0, 1, 0.5),
('bodycam', 'Bodycam', 0, 1, 0.3),
('bolcacahuetes', 'Bol de cacahuètes', 0, 1, 0.3),
('bolchips', 'Bol de chips', 0, 1, 0.3),
('bolnoixcajou', 'Bol de noix de cajou', 0, 1, 0.3),
('bolpistache', 'Bol de pistaches', 0, 1, 0.3),
('boneper', 'WEAPON_BONEPER', 0, 1, 1),
('bottle', 'Bottle', 0, 1, 0.3),
('boulon', 'Boulon', 0, 1, 0.3),
('boulonneuse', 'Boulonneuse', 0, 1, 0.3),
('bouteilleremplie', 'Bouteille remplie', 0, 1, 0.3),
('boutilletvide', 'Boutillet vide', 0, 1, 0.3),
('bread', 'Pain', 0, 1, 0.3),
('bren', 'Bren Gun', 0, 1, 5),
('brochette', 'Brochette en bois', 0, 1, 0.3),
('bullpuprifle', 'Fusil Bullpup', 0, 1, 3.5),
('bullpuprifle_mk2', 'Fusil Bullpup MK2', 0, 1, 3.5),
('bullpupshotgun', 'Fusil Bullpup', 0, 1, 4),
('burgershot_bacon', 'Bacon', 0, 1, 1),
('burgershot_biere', 'Bière', 0, 1, 1),
('burgershot_burger', 'Burger', 0, 1, 2),
('burgershot_cheddar', 'Cheddar', 0, 1, 1),
('burgershot_chesseburger', 'Cheeseburger', 0, 1, 2),
('burgershot_coca', 'Coca Cola', 0, 1, 1),
('burgershot_cookie', 'Cookie', 0, 1, 1),
('burgershot_frite', 'Frite', 0, 1, 1),
('burgershot_milkshake', 'Milkshake', 0, 1, 1),
('burgershot_oignonrings', 'Onion Rings', 0, 1, 1),
('burgershot_pain', 'Pain Burger', 0, 1, 0.3),
('burgershot_painburger', 'Pain Burger', 0, 1, 1),
('burgershot_poulet', 'Nuggets de poulet', 0, 1, 1),
('burgershot_salade', 'Salade', 0, 1, 1),
('burgershot_sprite', 'Sprite', 0, 1, 1),
('burgershot_tomate', 'Tomate', 0, 1, 1),
('burgershot_viandeburger', 'Viande Burger', 0, 1, 1),
('bzgas', 'Gaz lacrymogène', 0, 1, 1),
('c4_bank', 'Pain de C4', 0, 1, 0.3),
('cabillaud', 'Cabillaud', 0, 0, 0),
('cacahuete', 'Cacahuète', 0, 1, 0.3),
('cagoule', 'Gagoule', 0, 1, 0.1),
('caissepleine', 'Caisse Pleine', 0, 1, 0.3),
('caissevide', 'Caisse Vide', 0, 1, 0.3),
('calzone', 'Pizza calzone', 0, 1, 0.3),
('canette', 'Canette', 0, 1, 0.3),
('canettefondue', 'Canette Fondue', 0, 1, 0.3),
('canettepropre', 'Canette Propre', 0, 1, 0.3),
('canneapeche', 'Canne à Pêche', 0, 0, 0),
('canneapechecarbonne', 'Canne à Pêche en carbonne', 0, 0, 0),
('canneapecheoretcarbonne', 'Canne à Pêche aliage Or et Carbonne', 0, 0, 0),
('cappuccino', 'Cappuccino', 0, 1, 0.3),
('caprisun', 'Caprisun', 0, 1, 0.3),
('carassin', 'Carassin', 0, 0, 0),
('carbinerifle', 'Carabine M4', 0, 1, 3.5),
('carbinerifle_mk2', 'Carabine M4 MK2', 0, 1, 3.5),
('carokit', 'Kit carosserie', 0, 1, 0.3),
('carotool', 'outils carosserie', 0, 1, 0.3),
('carpecommune', 'Carpe commune', 0, 0, 0),
('carpekoi', 'Carpe koï', 0, 0, 0),
('carpemiroir', 'Carpe miroir', 0, 0, 0),
('carrosserie', 'Carrosserie', 0, 1, 0.3),
('cartesecu', 'Carte d\'acces au pannel 11441188', 0, 1, 0.3),
('casino_beer', 'Casino Beer', 0, 1, -1),
('casino_burger', 'Burger', 0, 1, -1),
('casino_chips', 'Casino Chips', 0, 1, -1),
('casino_coffee', 'Casino Coffee', 0, 1, -1),
('casino_coke', 'Casino Kofola', 0, 1, -1),
('casino_donut', 'Casino Donut', 0, 1, -1),
('casino_ego_chaser', 'Casino Ego Chaser', 0, 1, -1),
('casino_luckypotion', 'Casino Lucky Potion', 0, 1, -1),
('casino_psqs', 'Casino Ps & Qs', 0, 1, -1),
('casino_sandwitch', 'Casino Sandwitch', 0, 1, -1),
('casino_sprite', 'Casino Sprite', 0, 1, -1),
('caviar', 'Caviar', 0, 1, 0.3),
('cement', 'Ciment', 0, 1, 0.6),
('ceramicpistol', 'WEAPON_CERAMICPISTOL', 0, 1, 1),
('cerf', 'Cerf', 0, 1, 0.3),
('chaine', 'Chaine de Moto', 0, 1, 0.3),
('chainsaw', 'WEAPON_CHAINSAW', 0, 1, 1),
('chevreuil', 'Chevreuil', 0, 1, 0.3),
('chiffon', 'Chiffon', 0, 1, 0.3),
('chou', 'Chou', 0, 1, 0.3),
('ciseaux', 'Ciseaux', 0, 1, 0.1),
('citron', 'Citron', 0, 1, 0.3),
('classic_phone', 'Classic Phone', 0, 1, 10),
('cles', 'ClÃ©s vÃ©hicules', 0, 1, 0.3),
('clip', 'Chargeur', 0, 1, 0.3),
('coca', 'Coca-Cola', 0, 1, 0.3),
('coca_blend', 'Mélange de coca', 0, 1, 1),
('coca_leaf', 'Feuille de coca exotique', 0, 1, 1),
('coca_paste', 'Pâte de coca', 0, 1, 1),
('cocktailmaison', 'Cocktail maison', 0, 1, 0.3),
('coco', 'Coco', 0, 1, 0.3),
('cokepure', 'Cocaïne pure', 0, 1, 1),
('coke_pooch', 'Pochon de Coke', 0, 1, 1),
('colis', 'Colis', 0, 1, 0.3),
('combatmg', 'Combat MG', 0, 1, 4),
('combatmg_mk2', 'Combat MG MK2', 0, 1, 4),
('combatpdw', 'SIG Sauer MPX', 0, 1, 0.3),
('combatpistol', 'Glock 17', 0, 1, 1.5),
('combatpistolpol', 'Combat Pistol Police', 0, 1, 2),
('combatshotgun', 'WEAPON_COMBATSHOTGUN', 0, 1, 1),
('compactlauncher', 'Lanceur compact M79', 0, 1, 4),
('compactrifle', 'WEAPON_COMPACTRIFLE', 0, 1, 1),
('compo', 'Composants', 0, 1, 0.3),
('contrat', 'Contrat', 0, 1, 0.3),
('contratlocation', 'Contrat de Location', 0, 1, 0.3),
('contratvente', 'Contrat de Vente', 0, 1, 0.3),
('copper', 'Cuivre', 0, 1, 0.3),
('crepe', 'Crepe', 0, 1, 0.3),
('crick', 'Crick', 0, 1, 0.3),
('crochetage_kit', 'Kit de Crochetage', 0, 0, 1),
('crowbar', 'Pied-de-biche', 0, 1, 2.5),
('dagger', 'Dague', 0, 1, 1),
('dashcam', 'Dashcam', 0, 1, 0.3),
('dbshotgun', 'WEAPON_DBSHOTGUN', 0, 1, 1),
('desert-nike', 'WEAPON_DESERTNIKE', 0, 1, 1),
('desertpurple', 'WEAPON_DESERTPURPLE', 0, 1, 1),
('diamant', 'Diamant', 0, 1, 0.3),
('diamond', 'Diamant', 0, 1, 0.3),
('digiscanner', 'digiscanner', 0, 1, 0.3),
('dorade', 'Dorade', 0, 1, 0.3),
('doubleaction', 'Double Action', 0, 1, 2),
('doublebarrel', 'Double Barrel Shotgun', 0, 1, 4),
('douce_lures', 'Appât d\'Eau Douce', 0, 0, 0),
('drill', 'Drill', 0, 1, 1),
('drink_burgershot', 'Boisson Burgershot', 0, 1, 0.1),
('driver_license', 'Permis de conduire', 0, 1, 1),
('drpepper', 'Dr. Pepper', 0, 1, 0.3),
('elixir', 'Élixir', 0, 1, 0.3),
('elixirblanco', 'Élixir blanco', 0, 1, 0.3),
('enceinte', 'Enceinte', 0, 1, 0.3),
('enemy_laser_ammo', 'Munitions pour laser ennemi', 0, 1, 0.1),
('energy', 'Energy Drink', 0, 1, 0.3),
('eperlant', 'Éperlant', 0, 0, 0),
('fakebankingcard', 'Fausse carte bancaire', 0, 1, 0.3),
('fake_id_card', 'Fausse carte d\'identité', 0, 1, 1),
('fake_job_card', 'Fausse carte professionnelle', 0, 1, 1),
('fanta', 'Fanta', 0, 1, 0.3),
('ferraille', 'Ferraille', 0, 1, 0.3),
('feuillechanvre', 'Feuille de chanvre', 0, 1, 0.5),
('feuillecoca', 'Feuille de coca', 0, 1, 0.05),
('fichelocation', 'Fiche de location', 0, 1, 0.3),
('fichenotaire', 'Fiche Notariale', 0, 1, 0.3),
('fireaxe', 'Fire Axe', 0, 1, 2),
('fireextinguisher', 'Extincteur', 0, 1, 3),
('fireextinguisher_ammo', 'Agent extincteur', 0, 1, 0.1),
('firework', 'Feu d\'artifice', 0, 1, 1),
('fish', 'Fish', 0, 1, 0.3),
('fishbait', 'Fish Bait', 0, 1, 0.3),
('fishingrod', 'Canne à pêche', 0, 1, 0.3),
('fixkit', 'Kit réparation', 0, 1, 0.3),
('fixtool', 'outils réparation', 0, 1, 0.3),
('flare', 'Fusée éclairante', 0, 1, 1),
('flaregun', 'Pistolet de détresse', 0, 1, 1),
('flare_ammo', 'Fusées éclairantes', 0, 1, 0.1),
('flashlight', 'Lampe torche', 0, 1, 1),
('fn509', 'FN 509', 0, 1, 2),
('frite', 'Frite', 0, 3, 0.3),
('fromage', 'Portion de Fromage', 0, 1, 0.3),
('g17gen5', 'Glock 17 Gen 5', 0, 1, 2),
('g17neonoir', 'Glock 17 Neon Noir', 0, 1, 2),
('gadgetpistol', 'WEAPON_GADGETPISTOL', 0, 1, 1),
('gadget_nightvision', 'GADGET_NIGHTVISION', 0, 1, 1),
('gadget_parachute', 'GADGET_PARACHUTE', 0, 1, 1),
('galette', 'Galette', 0, 1, 0.3),
('garbagebag', 'garbagebag', 0, 1, 0.3),
('garniture', 'Garniture de tacos', 0, 1, 0.3),
('gasoline', 'Essence', 0, 1, 0.1),
('gateauxchance', 'Gâteaux de la chance', 0, 1, 0.3),
('gazbottle', 'bouteille de gaz', 0, 1, 0.3),
('gazeuse', 'WEAPON_GAZEUSE', 0, 1, 1),
('gigatacos', 'Giga tacos', 0, 1, 0.3),
('gigatacosfroid', 'Giga Tacos Froid', 0, 1, 0.3),
('gitanes', 'Gitanes', 0, 1, 0.3),
('glacealitalienne', 'Glace à l\'italienne', 0, 1, 0.3),
('glitchpopvandal', 'Glitchpop Vandal', 0, 1, 4),
('glock17', 'WEAPON_GLOCK17', 0, 1, 1),
('glockdm', 'WEAPON_GLOCKDM', 0, 1, 1),
('gobeletcoca', 'Gobelelet de coca', 0, 1, 0.3),
('gobeletdecoca', 'Gobelelet de coca', 0, 1, 0.3),
('gobeletdehawai', 'Gobelelet de hawai', 0, 1, 0.3),
('gobeletdeicetea', 'Gobelelet de icetea', 0, 1, 0.3),
('gobeletfanta', 'Gobelelet de fanta', 0, 1, 0.3),
('gobeleticetea', 'Gobelelet de icetea', 0, 1, 0.3),
('gobeletlimonade', 'Gobelet de limonade', 0, 1, 0.3),
('gobeletoasis', 'Gobelelet de Oasis', 0, 1, 0.3),
('gobeletorange', 'Gobelet Orange', 0, 1, 0.3),
('gobeletorangina', 'Gobelelet de Orangina', 0, 1, 0.3),
('gobeletpied', 'Gobelet a Pied', 0, 1, 0.3),
('gobeletsake', 'Gobelet de Sake', 0, 1, 0.3),
('gobeletsheps', 'Gobelet de Sheps', 0, 1, 0.3),
('gobelettropicana', 'Gobelelet de Tropicana', 0, 1, 0.3),
('gobeletvide', 'Gobelet vide', 0, 1, 0.3),
('gobeletvolvic', 'Gobelet de Volvic', 0, 1, 0.3),
('gold', 'Or', 0, 1, 0.3),
('goldbar', 'Gold Bar', 0, 1, 0.3),
('goldm', 'WEAPON_GOLDM', 0, 1, 1),
('goldnecklace', 'Gold Necklace', 0, 1, 0.3),
('goldwatch', 'Gold Watch', 0, 1, 0.3),
('gold_phone', 'Gold Phone', 0, 1, 10),
('golem', 'Golem', 0, 1, 0.3),
('golfclub', 'Club de golf', 0, 1, 2.5),
('grandefrite', 'Grande Frite', 0, 1, 0.3),
('grandefroidfrite', 'Grande Frite Froid', 0, 1, 0.3),
('grand_cru', 'Grand cru', 0, 1, 0.3),
('grapperaisin', 'Grappe de raisin', 0, 1, 0.3),
('grau', 'WEAPON_GRAU', 0, 1, 1),
('greenlight_phone', 'Green Light Phone', 0, 1, 10),
('green_phone', 'Téléphone Vert', 0, 1, 0.3),
('grenade', 'Grenade', 0, 1, 1),
('grenadelauncher', 'Lance-grenades', 0, 1, 4),
('grenadelauncher_ammo', 'Munitions pour lance-grenades', 0, 1, 0.1),
('grenadelauncher_smoke_ammo', 'Grenades fumigènes pour lance-grenades', 0, 1, 0.1),
('gusenberg', 'Balayeuse Gusenberg', 0, 1, 3.5),
('gzgas_ammo', 'Munitions pour gaz lacrymogène', 0, 1, 0.1),
('hackerDevice', 'Hacker Device', 0, 1, 0.3),
('hack_laptop', 'Ordinateur Portable', 1, 1, 1),
('hack_phone', 'Téléphone Jailbreak', 0, 1, 1),
('hammer', 'Marteau', 0, 1, 2),
('hammerwirecutter', 'Hammer And Wire Cutter', 0, 1, 0.3),
('handcuffs', 'Menottes', 0, 1, 1),
('hareng', 'Hareng', 0, 0, 0),
('haschich', 'Haschich', 0, 1, 0.3),
('haschich_pooch', 'Haschich', 0, 1, 0.3),
('hashish', 'Hashish', 0, 1, 0.7),
('hashish_pooch', 'Pochon de Hashish', 0, 1, 1),
('hatchet', 'hatchet', 0, 1, 0.3),
('heavypistol', 'Pistolet lourd', 0, 1, 2),
('heavyrifle', 'WEAPON_HEAVYRIFLE', 0, 1, 1),
('heavyshotgun', 'Saiga-12K', 0, 1, 0.3),
('heavysniper', 'Sniper lourd', 0, 1, 4),
('heavysniper_mk2', 'Sniper lourd MK2', 0, 1, 4),
('heineken', 'Heineken', 0, 1, 0.3),
('hell', 'WEAPON_HELL', 0, 1, 1),
('hellsniper', 'WEAPON_HELLSNIPER', 0, 1, 1),
('hk416', 'HK 416', 0, 1, 3),
('hkump', 'HK UMP', 0, 1, 3),
('hominglauncher', 'Lance-missiles guidé', 0, 1, 4),
('honeybadgercod', 'Honey Badger (COD)', 0, 1, 4),
('hornys_glace', 'Glace', 0, 1, 0.3),
('hydrochloric_acid', 'Acide chlorhydrique', 0, 1, 0.1),
('ice', 'Glaçon', 0, 1, 0.3),
('icetea', 'Ice Tea', 0, 1, 0.3),
('idcard', 'Carte d\'Identité', 0, 0, 0),
('id_card', 'Carte d\'identité', 0, 1, 1),
('id_card_f', 'Malicious Access Card', 3, 1, 0.3),
('ing', 'ingredient a pizza', 0, 1, 0.3),
('iron', 'Fer', 0, 1, 0.3),
('jager', 'Jägermeister', 0, 1, 0.3),
('jagerbomb', 'Jägerbomb', 0, 1, 0.3),
('jagercerbere', 'Jäger Cerbère', 0, 1, 0.3),
('jaguar', 'Jaguar', 0, 1, 0.3),
('jewels', 'Bijoux', 0, 1, 0.3),
('job_card', 'Carte professionnelle', 0, 1, 1),
('jumelles', 'Jumelles', 0, 1, 0.3),
('jusfruit', 'Jus de fruits', 0, 1, 0.3),
('jus_raisin', 'Vin', 0, 1, 0.3),
('karambitknife', 'Karambit Knife', 0, 1, 1),
('katana', 'Katana', 0, 1, 1),
('kevlar', 'Kevlar', 0, 1, 0.3),
('kevlarlow', 'Kevlar en mauvais état', 0, 1, 0.3),
('kevlarmid', 'Kevlar en bon état', 0, 1, 0.3),
('kinetic', 'WEAPON_KINETIC', 0, 1, 1),
('kitcarro', 'Kit Carosserie', 0, 1, 0.3),
('kitmoteur', 'Kit Moteur', 0, 1, 0.3),
('knife', 'Couteau', 0, 1, 1),
('knuckle', 'Knuckledusters', 0, 1, 0.3),
('kq_acetone', 'Acétone', 0, 1, 2),
('kq_ammonia', 'Ammoniaque', 0, 1, 2),
('kq_ethanol', 'Éthanol', 0, 1, 0.1),
('kq_lithium', 'Pack de lithium', 0, 1, 0.3),
('kq_meth_high', 'Méthamphétamine (Haute qualité)', 0, 1, 1),
('kq_meth_lab_kit', 'Kit de cuisson', 0, 1, 5),
('kq_meth_low', 'Méthamphétamine (Qualité basse)', 0, 1, 1),
('kq_meth_mid', 'Méthamphétamine (Qualité moyenne)', 0, 1, 1),
('kq_meth_pills', 'Pseudoéphédrine', 0, 1, 0.4),
('lapin', 'Lapin', 0, 1, 0.3),
('lbd', 'WEAPON_lbd', 0, 1, 1),
('letter', 'Courrier', 0, 1, 0.3),
('lgcougar', 'WEAPON_LGCOUGAR', 0, 1, 1),
('lieu', 'Lieu', 0, 1, 0.3),
('limonade', 'Limonade', 0, 1, 0.3),
('lockpick', 'Lockpick', 0, 1, 0.3),
('loup', 'Loup', 0, 1, 0.3),
('m19', 'WEAPON_M19', 0, 1, 1),
('m4beast', 'WEAPON_M4BEAST', 0, 1, 1),
('m4goldbeast', 'WEAPON_M4GOLDBEAST', 0, 1, 1),
('m6ic', 'M6 IC', 0, 1, 4),
('m9a3', 'M9A3 Pistol', 0, 1, 2),
('m9bayonnetlore', 'M9 Bayonet Lore', 0, 1, 1),
('machete', 'machete', 0, 1, 0.3),
('machinepistol', 'TEC-9', 0, 1, 0.3),
('macro', 'Macro', 0, 1, 0.3),
('maille', 'Maille de Chaine', 0, 1, 0.3),
('malboro', 'Marlboro', 0, 1, 0.3),
('mangoloco', 'Mangoloco', 0, 1, 0.3),
('marksmanpistol', 'Thompson-Center Contender G2', 0, 1, 0.3),
('marksmanrifle', 'Fusil Marksman', 0, 1, 4),
('marksmanrifle_mk2', 'Marksman Rifle MK2', 0, 1, 4),
('martini', 'Martini blanc', 0, 1, 0.3),
('maze', 'WEAPON_MAZE', 0, 1, 1),
('mcxspear', 'MCX Spear', 0, 1, 4),
('mdma', 'MDMA', 0, 1, 0.3),
('medikit', 'Medikit', 0, 1, 0.3),
('melted_steel', 'Acier Fondue', 0, 1, 0.3),
('menthe', 'Feuille de menthe', 0, 1, 0.3),
('mer_lures', 'Appât d\'Eau de Mer', 0, 0, 0),
('meth', 'Meth', 0, 1, 0.3),
('methpure', 'Méthamphétamine pure', 0, 1, 1),
('meth_pooch', 'Pochon de Meth', 0, 1, 0.3),
('metreshooter', 'Mètre de shooter', 0, 1, 0.3),
('mg', 'Mitrailleuse MG', 0, 1, 4),
('mg_ammo', 'Munitions pour mitrailleuse', 0, 1, 0),
('microsmg', 'Micro Uzi', 0, 1, 2),
('midasgun', 'WEAPON_MIDASGUN', 0, 1, 1),
('midgard', 'WEAPON_MIDGARD', 0, 1, 1),
('militarm4', 'WEAPON_MILITARM4', 0, 1, 1),
('militaryrifle', 'WEAPON_MILITARYRIFLE', 0, 1, 1),
('minigun', 'Minigun', 0, 1, 4),
('minigun_ammo', 'Munitions pour Minigun', 0, 1, 0.1),
('minismg', 'Mini Uzi', 0, 1, 2),
('mixapero', 'Mix Apéritif', 0, 1, 0.3),
('mochi', 'Mochi', 0, 1, 0.3),
('mojito', 'Mojito', 0, 1, 0.3),
('molotov', 'Cocktail Molotov', 0, 1, 1.5),
('molotov_ammo', 'Munitions pour cocktails Molotov', 0, 1, 0.1),
('morgane', 'Captaine Morgane', 0, 1, 0.3),
('moteur', 'Moteur', 0, 1, 0.3),
('moyennefrite', 'Moyenne Frite', 0, 1, 0.3),
('moyennefroidfrite', 'Moyenne Frite Froid', 0, 1, 0.3),
('mp5sdfm', 'MP5 SD Full Metal', 0, 1, 3),
('musket', 'Mousquet', 0, 1, 3.5),
('neonbox', 'Neon Box', 0, 1, 1),
('neoncontroller', 'Neon Controller', 0, 1, 1),
('nightstick', 'Matraque', 0, 1, 2),
('nightvision', 'Vision nocturne', 0, 1, 2),
('nioki', 'Nioki Lustukru', 0, 1, 0.3),
('nitrovehicle', 'Nitro', 0, 1, 0.3),
('nouille', 'Portion de nouille', 0, 1, 0.3),
('oblivion', 'WEAPON_OBLIVION', 0, 1, 1),
('oblivionPill', 'Pilule de l\'oubli', 0, 1, 0.3),
('ocean_lures', 'Appât d\'Eau Profonde', 0, 0, 0),
('okonomiyaki', 'Okonomiyaki', 0, 1, 0.3),
('opium', 'Opium', 0, 1, 0.3),
('opium_pooch', 'Pochon d\'Opium', 0, 1, 0.3),
('orange', 'Orange', 0, 1, 0.3),
('orientale', 'Pizza orientale', 0, 1, 0.3),
('pacific_brochettes', 'Brochettes de fruits frais', 0, 1, 0.3),
('pacific_chips', 'Chips de banane plantain', 0, 1, 0.3),
('pacific_coco', 'Eau de coco', 0, 1, 0.3),
('pacific_margarita', 'Margarita ', 0, 1, 0.3),
('pacific_mojito', 'Mojito ', 0, 1, 0.3),
('pacific_pina', 'Piña Colada', 0, 1, 0.3),
('pacific_smoothie', 'Smoothie tropical', 0, 1, 0.3),
('packaged_chicken', 'Poulet en barquette', 0, 1, 0.3),
('papierblanc', 'Papier Blanc', 0, 1, 0.3),
('papiermache', 'Papier maché', 0, 1, 0.3),
('parachute', 'Parachute', 0, 1, 3),
('pastis', 'Pastis', 0, 1, 0.3),
('pate', 'Pate a pizza', 0, 1, 0.3),
('pattecuite', 'Patte à Pizza Cuite', 0, 1, 0.3),
('pc', 'Pc', 0, 1, 0.3),
('pearls_crevette', 'Crevette', 0, 1, 0.3),
('pearls_fish', 'Poisson', 0, 1, 0.3),
('pearls_fishandchips', 'Fish And Chips', 0, 1, 0.3),
('pearls_frite', 'Frite', 0, 1, 0.3),
('pearls_moule', 'Moule', 0, 1, 0.3),
('pearls_moulefrite', 'Moule Frite', 0, 1, 0.3),
('penis', 'WEAPON_PENIS', 0, 1, 1),
('pepsi', 'Pepsi', 0, 1, 0.3),
('petitefrite', 'Petite Frite', 0, 1, 0.3),
('petitefroidfrite', 'Petite Frite Froid', 0, 1, 0.3),
('petrolcan', 'Jerrycan', 0, 1, 4),
('phone', 'Téléphone', 0, 1, 0.3),
('phone_hack', 'Phone Hack', 0, 1, 10),
('phone_module', 'Phone Module', 0, 1, 10),
('phosphorerouge', 'Phosphore rouge', 0, 1, 0.2),
('pibwasser', 'Pibwasser', 0, 1, 0.3),
('pince', 'Pince', 0, 1, 0.3),
('pink_phone', 'Pink Phone', 0, 1, 10),
('pipebomb', 'Bombe artisanale', 0, 1, 2.5),
('pistol', 'Beretta', 0, 1, 1.5),
('pistol50', 'Desert Eagle', 0, 1, 2),
('pistolxm3', 'Pistol XM3', 0, 1, 2),
('pistol_ammo', 'Munitions pour pistolet', 0, 1, 0),
('pistol_mk2', 'Pistolet Sig Sauer P226 MK2', 0, 1, 1.5),
('pizza', 'Pizza', 0, 1, 0.3),
('pizzapate', 'Pate a Pizza', 0, 1, 0.3),
('pizzasavoyarde', ' Savoyarde', 0, 1, 0.3),
('plane_rocket_ammo', 'Munitions pour roquettes aériennes', 0, 1, 0.1),
('player_laser_ammo', 'Munitions pour laser joueur', 0, 1, 0.1),
('pneu', 'Pneu', 0, 1, 0.3),
('pochon_meth', 'Pochon De Meth', 0, 1, 0.3),
('pochon_opium', 'Pochon D\'Opium', 0, 1, 0.3),
('pochon_weed', 'Pochon De Weed', 0, 1, 0.3),
('poisson', 'Portion de poisson', 0, 35, 0.3),
('poissonchat', 'Poisson Chat', 0, 0, 0),
('poolcue', 'Queue de billard', 0, 1, 2),
('poolreceipt', 'Reçu de piscine', 0, 1, 0.3),
('pops_donut', 'Donut', 0, 1, 0.3),
('pops_granité', 'Granité', 0, 1, 0.3),
('pops_hotdog', 'Hot Dog', 0, 1, 0.3),
('pops_sauce', 'Sauce', 0, 1, 0.3),
('pops_saucisse', 'Saucisse', 0, 1, 0.3),
('porc', 'Portion de Porc', 0, 35, 0.3),
('potatos', 'Potatos', 0, 5, 0.3),
('poulet', 'Portion de Poulet', 0, 35, 0.3),
('powerbank', 'Power Bank', 0, 1, 10),
('predator', 'WEAPON_PREDATOR', 0, 1, 1),
('produitchimique', 'Produit Chimique', 0, 1, 0.3),
('proxmine', 'Mine de proximité', 0, 1, 1.5),
('pumpkin-rifle', 'WEAPON_PUMPKIN', 0, 1, 1),
('pumpshotgun', 'Fusil à pompe', 0, 1, 4),
('pumpshotgun_mk2', 'Fusil à pompe MK2', 0, 1, 4),
('pure_meth_pills', 'Pseudoéphédrine pure', 0, 1, 0.4),
('raie', 'Raie', 0, 1, 0.3),
('railgun', 'Canon à rail', 0, 1, 4),
('raisin', 'Raisin', 0, 1, 0.3),
('ramen', ' Ramen', 0, 1, 0.3),
('raspberry', 'Raspberry', 0, 1, 0.3),
('reco_burgershot', 'Pain', 0, 1, 0.3),
('reco_ferrailleur', 'Ferraille Rouillée', 0, 1, 0.3),
('reco_petitpecheur', 'Poisson Frais', 0, 1, 0.3),
('reco_tabac', 'Tabac', 0, 1, 0.3),
('reco_vigneron', 'Raisin', 0, 1, 0.3),
('red_phone', 'Red Phone', 0, 1, 10),
('reine', 'Pizza reine', 0, 1, 0.3),
('remotesniper', 'Sniper télécommandé', 0, 1, 4),
('repairkit', 'Kit de réparation', 0, 1, 0.3),
('requin', 'Requin', 0, 0, 0),
('revolver', 'Revolver lourd', 0, 1, 2.5),
('revolverultra', 'WEAPON_REVOLVERULTRA', 0, 1, 1),
('revolvervamp', 'WEAPON_REVOLVERVAMP', 0, 1, 1),
('revolver_mk2', 'Revolver MK2', 0, 1, 2.5),
('rhum', 'Rhum', 0, 1, 0.3),
('rhumcoca', 'Rhum-coca', 0, 1, 0.3),
('rhumfruit', 'Rhum-jus de fruits', 0, 1, 0.3),
('ricard', 'Ricard', 0, 1, 0.3),
('rifle_ammo', 'Munitions pour fusil', 0, 1, 0),
('riz', 'Portion de riz', 0, 1, 0.3),
('rpg', 'RPG', 0, 1, 4),
('rpg_ammo', 'Munitions pour RPG', 0, 1, 0.1),
('sac_poubelle', 'Sac Poubelle', 0, 1, 0.2),
('salami', 'Salami', 0, 1, 0.3),
('sanglier', 'Sanglier', 0, 1, 0.3),
('sardine', 'sardine', 0, 1, 0.3),
('sauce', 'Portion de sauce', 0, 1, 0.3),
('saucisson', 'Saucisson', 0, 1, 0.3),
('saumon', 'saumon', 0, 1, 0.3),
('saumons', 'Pizza au saumon', 0, 1, 0.3),
('sawnoffshotgun', 'Fusil à canon scié', 0, 1, 3.5),
('scar-17-lshop', 'WEAPON_SCAR17', 0, 1, 1),
('scar17fm', 'SCAR 17 Full Metal', 0, 1, 4),
('scarsc', 'WEAPON_SCARSC', 0, 1, 1),
('secure_card', 'Secure ID Card', 3, 1, 0.3),
('sfrites', 'Sachet de Frite surgele', 0, 1, 0.3),
('shark', 'Shark', 0, 1, 0.3),
('shisha', 'Shisha', 0, 1, 0.3),
('shotgunk', 'WEAPON_SHOTGUNK', 0, 1, 1),
('shotgun_ammo', 'Munitions pour fusil à pompe', 0, 1, 0),
('sig550', 'WEAPON_SIG550', 0, 1, 1),
('silure', 'Silure', 0, 0, 0),
('sim', 'Carte-SIM', 0, 1, 0.3),
('siredward', 'Sir Edward', 0, 1, 0.3),
('slaughtered_chicken', 'Poulet abattu', 0, 1, 0.3),
('sledgehammer', 'Sledgehammer', 0, 1, 4),
('smg', 'Mitraillette MP5', 0, 1, 3),
('smg_ammo', 'Munitions pour mitraillette', 0, 1, 0),
('smg_mk2', 'SMG MK2', 0, 1, 3),
('smokegrenade', 'Grenade fumigène', 0, 1, 1),
('smokegrenade_ammo', 'Munitions pour grenades fumigènes', 0, 1, 0.1),
('snake', 'WEAPON_SNAKE', 0, 1, 1),
('sniperrifle', 'Fusil de sniper', 0, 1, 4),
('sniper_ammo', 'Munitions pour sniper', 0, 1, 0.1),
('sniper_remote_ammo', 'Munitions pour sniper télécommandé', 0, 1, 0.1),
('snowball', 'Boule de neige', 0, 1, 0.5),
('snspistol', 'Pistolet SNS', 0, 1, 1.5),
('snspistol_mk2', 'Pistolet SNS MK2', 0, 1, 1.5),
('soda', 'Soda', 0, 1, 0.3),
('sole', 'sole', 0, 0, 0),
('soudeuse', 'Poste à souder', 0, 1, 0.3),
('sovereign', 'WEAPON_SOVEREIGN', 0, 1, 1),
('space_rocket_ammo', 'Munitions pour fusées spatiales', 0, 1, 0.1),
('specialcarbine', 'Carabine spéciale', 0, 1, 3.5),
('specialcarbine_mk2', 'Carabine spéciale MK2', 0, 1, 3.5),
('specialhammer', 'WEAPON_SPECIALHAMMER', 0, 1, 1),
('spiderak', 'WEAPON_SPIDERAK', 0, 1, 1),
('spotatoss', 'Sachet de Potatos surgele', 0, 1, 0.3),
('spray_remover', 'Eponge', 1, 1, 0.3),
('sprite', 'Sprite', 0, 1, 0.3),
('steellingo', 'Lingot Acier', 0, 1, 0.3),
('stickybomb', 'Bombe collante', 0, 1, 2),
('stickybomb_ammo', 'Munitions pour bombes collantes', 0, 1, 0.1),
('stinger', 'Lance-missiles Stinger', 0, 1, 4),
('stinger_ammo', 'Munitions pour lance-missiles Stinger', 0, 1, 0.1),
('stone', 'Pierre', 0, 1, 0.3),
('stungun', 'Taser', 0, 1, 1),
('stungun_ammo', 'Munitions pour taser', 0, 1, 0.1),
('sundayfraise', 'Sunday Fraise', 0, 1, 0.3),
('sundaynature', 'Sunday Nature', 0, 1, 0.3),
('sushi', 'Sushi', 0, 1, 0.3),
('sw', 'Sandwich', 0, 1, 0.3),
('switchblade', 'Couteau pliant', 0, 1, 1),
('tabacblond', 'Tabac Blond', 0, 1, 0.3),
('tabacblondsec', 'Tabac Blond Séché', 0, 1, 0.3),
('tabacbrun', 'Tabac Brun', 0, 1, 0.3),
('tabacbrunsec', 'Tabac Brun Séché', 0, 1, 0.3),
('tableau', 'Tableau', 0, 1, 0.3),
('tablet', 'Tablet', 0, 1, 0.3),
('tacos2', 'Tacos 2 viandes', 0, 1, 0.3),
('tacos3', 'Tacos 3 viandes', 0, 1, 0.3),
('tacosfroid2', 'Tacos 2 viandes Froid', 0, 1, 0.3),
('tacosfroid3', 'Tacos 3 viandes Froid', 0, 1, 0.3),
('tacosfroidxll', 'Tacos XXL Froid', 0, 1, 0.3),
('tacosl', 'Tacos L', 0, 1, 0.3),
('tacosm', 'Tacos M', 0, 1, 0.3),
('tacosxl', 'Tacos XL', 0, 1, 0.3),
('tacosxll', 'Tacos XXL', 0, 1, 0.3),
('tank_ammo', 'Obus pour tank', 0, 1, 0.1),
('tec9m', 'WEAPON_TEC9M', 0, 1, 1),
('tec9mb', 'WEAPON_TEC9MB', 0, 1, 1),
('tec9mf', 'WEAPON_TEC9MF', 0, 1, 1),
('tel', 'Téléphone', 0, 1, 0.3),
('tele', 'Télé', 0, 1, 0.3),
('teqpaf', 'Teq\'paf', 0, 1, 0.3),
('tequila', 'Tequila', 0, 1, 0.3),
('terre', 'Terre', 0, 1, 0.5),
('thermite', 'Thermite', 0, 1, 1),
('thon', 'thon', 0, 1, 0.3),
('tomate', 'Tomate', 0, 1, 0.3),
('trait_burgershot', 'Colis', 0, 1, 0.3),
('trait_ferrailleur', 'Ferraille Traitée', 0, 1, 0.3),
('trait_petitpecheur', 'Poisson Frit', 0, 1, 0.3),
('trait_tabac', 'Cigarette', 0, 1, 0.3),
('trait_vigneron', 'Vin', 0, 1, 0.3),
('treatedsteel', 'Lingot Acier Traité', 0, 1, 0.3),
('turtle', 'Sea Turtle', 0, 1, 0.3),
('turtlebait', 'Turtle Bait', 0, 1, 0.3),
('unicorn_jusorange', 'Jus d\'orange pressé', 0, 1, 0.3),
('unicorn_miniburger', 'Mini-burgers sliders', 0, 1, 0.3),
('unicorn_pepsi', 'Pepsi ', 0, 1, 0.3),
('unicorn_poulet', 'Ailes de poulet épicées', 0, 1, 0.3),
('unicorn_tequila', 'Tequila Sunrise', 0, 1, 0.3),
('unicorn_vodka', 'Vodka Martini', 0, 1, 0.3),
('unicorn_wisky', 'Whisky sour', 0, 1, 0.3),
('usbhacked', 'Clé USB illégale', 0, 1, 0.3),
('uzi', 'WEAPON_UZILS', 0, 1, 1),
('vase', 'Vase', 0, 1, 0.3),
('vehicle_case', 'Caisse Véhicules', 0, 0, 0.3),
('viande', 'Portion de viande', 0, 1, 0.3),
('victusxmr', 'Victus XMR', 0, 1, 5),
('vinblanc', 'Vin Blanc', 0, 1, 0.3),
('vinrose', 'Rose', 0, 1, 0.3),
('vinrouge', 'Vin Rouge', 0, 1, 0.3),
('vintagepistol', 'Pistolet vintage', 0, 1, 1.5),
('vodka', 'Vodka', 0, 1, 0.3),
('vodkaenergy', 'Vodka-energy', 0, 1, 0.3),
('vodkafruit', 'Vodka-jus de fruits', 0, 1, 0.3),
('vp9', 'VP9', 0, 1, 2),
('vsco', 'WEAPON_VSCO', 0, 1, 1),
('washed_stone', 'Pierre Lavée', 0, 1, 0.3),
('water', 'Eau', 0, 1, 0.3),
('weapons_license', 'Permis de port d\'arme', 0, 1, 1),
('weed', 'Weed', 0, 1, 0.7),
('weed_pooch', 'Pochon de Weed', 0, 1, 1),
('wet_black_phone', 'Wet Black Phone', 0, 1, 10),
('wet_blue_phone', 'Wet Blue Phone', 0, 1, 10),
('wet_classic_phone', 'Wet Classic Phone', 0, 1, 10),
('wet_gold_phone', 'Wet Gold Phone', 0, 1, 10),
('wet_greenlight_phone', 'Wet Green Light Phone', 0, 1, 10),
('wet_green_phone', 'Wet Green Phone', 0, 1, 10),
('wet_phone', 'Wet Phone', 0, 1, 10),
('wet_pink_phone', 'Wet Pink Phone', 0, 1, 10),
('wet_red_phone', 'Wet Red Phone', 0, 1, 10),
('wet_white_phone', 'Wet White Phone', 0, 1, 10),
('whisky', 'Whisky', 0, 1, 0.3),
('whiskycoca', 'Whisky-coca', 0, 1, 0.3),
('white_phone', 'White Phone', 0, 1, 10),
('wire', 'Fil de fer', 0, 1, 0.3),
('wiwang_caviar', 'Caviar', 0, 1, 0.3),
('wiwang_cocktail', 'Cocktail Bora Bora', 0, 1, 0.3),
('wiwang_donperignon', 'Don Perignon', 0, 1, 0.3),
('wiwang_juspassion', 'Jus Passion Mangue', 0, 1, 0.3),
('wiwang_macarons', 'Macarons', 0, 1, 0.3),
('wiwang_ruinart', 'Ruinart', 0, 1, 0.3),
('wiwang_vin', 'Vin', 0, 1, 0.3),
('wrench', 'Clé à molette', 0, 1, 2),
('xanax', 'Xanax', 0, 1, 0.3),
('yakitori', 'Yakitori', 0, 1, 0.3);

-- --------------------------------------------------------

--
-- Structure de la table `jobs`
--

CREATE TABLE `jobs` (
  `name` varchar(50) NOT NULL,
  `label` varchar(50) DEFAULT NULL,
  `whitelisted` tinyint(1) NOT NULL DEFAULT 0,
  `type` int(1) NOT NULL DEFAULT 1,
  `handyservice` varchar(2) NOT NULL DEFAULT '0',
  `hasapp` int(2) NOT NULL DEFAULT 0,
  `onlyboss` int(2) NOT NULL DEFAULT 0,
  `enable_billing` int(1) DEFAULT 0,
  `can_rob` int(1) DEFAULT 0,
  `can_handcuff` int(1) DEFAULT 0,
  `can_lockpick_cars` int(1) DEFAULT 0,
  `can_wash_vehicles` int(1) DEFAULT 0,
  `can_repair_vehicles` int(1) DEFAULT 0,
  `can_impound_vehicles` int(1) DEFAULT 0,
  `can_check_identity` int(1) DEFAULT 0,
  `can_check_vehicle_owner` int(1) DEFAULT 0,
  `can_check_driving_license` int(1) DEFAULT 0,
  `can_check_weapon_license` int(1) DEFAULT 0,
  `can_heal` int(1) DEFAULT 0,
  `can_revive` int(1) DEFAULT 0,
  `actions_menu_enabled` int(1) DEFAULT 1,
  `placeable_objects` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `jobs`
--

INSERT INTO `jobs` (`name`, `label`, `whitelisted`, `type`, `handyservice`, `hasapp`, `onlyboss`, `enable_billing`, `can_rob`, `can_handcuff`, `can_lockpick_cars`, `can_wash_vehicles`, `can_repair_vehicles`, `can_impound_vehicles`, `can_check_identity`, `can_check_vehicle_owner`, `can_check_driving_license`, `can_check_weapon_license`, `can_heal`, `can_revive`, `actions_menu_enabled`, `placeable_objects`) VALUES
('airdealer', 'Concessionnaire Aérien', 0, 1, '0', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, NULL),
('ambulance', 'EMS', 0, 1, '0', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, NULL),
('ambulancesandy', 'Ambulance Sandy', 0, 1, '0', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, NULL),
('bar_beachclub', 'Beach Club', 0, 1, '0', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, NULL),
('bar_mojitoinn', 'Mojito Inn', 0, 1, '0', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, NULL),
('bar_salieris', 'Salieris', 1, 1, '0', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, NULL),
('bar_tequila', 'Tequila', 0, 1, '0', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, NULL),
('boatdealer', 'Concessionnaire Bateau', 0, 1, '0', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, NULL),
('boite_pacific', 'Pacific Bluffs', 0, 1, '0', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, NULL),
('boite_unicorn', 'Unicorn', 0, 1, '0', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, NULL),
('boite_wiwang', 'Wiwang', 0, 1, '0', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, NULL),
('cardealer', 'Concessionnaire', 1, 1, '0', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, NULL),
('Cartel De Cayo', 'Cartel de Cayo', 0, 0, '0', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, NULL),
('Cartel de Sinaloa', 'Cartel de Sinaloa', 0, 0, '0', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, NULL),
('Duggan', 'Duggan', 0, 0, '0', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, NULL),
('Duggan crime family', 'Duggan crime family', 0, 0, '0', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, NULL),
('garage_driveline', 'Driveline Garage', 0, 1, '0', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, NULL),
('garage_eastcustoms', 'East Customs', 0, 1, '0', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, NULL),
('garage_lscustom', 'LsCustoms', 0, 1, '0', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, NULL),
('garage_octacyp', 'Octa Cyp Garage', 0, 1, '0', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, NULL),
('garage_paletocustoms', 'Paleto Customs', 0, 1, '0', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, NULL),
('garage_speedhunters', 'Speed Hunters', 0, 1, '0', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, NULL),
('gouvernement', 'Gouvernement', 1, 1, '0', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, NULL),
('hornys', 'Horny\'s', 0, 1, '0', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, NULL),
('le_ferailleur', 'Le Férailleur', 0, 1, '0', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, NULL),
('ltd_arena', 'LTD Arena', 0, 1, '0', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, NULL),
('ltd_ballas', 'LTD Grove Street', 0, 1, '0', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, NULL),
('ltd_f4l', 'LTD Forum Drive', 0, 1, '0', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, NULL),
('ltd_littleseoul', 'LTD Little Seoul', 0, 1, '0', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, NULL),
('ltd_paletobay', 'LTD Paleto Bay', 0, 1, '0', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, NULL),
('Madrazo', 'Madrazo', 0, 0, '0', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, NULL),
('McReary', 'McReary', 0, 0, '0', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, NULL),
('mecano', 'Benny\'s', 0, 1, '0', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, NULL),
('motodealer', 'Concessionnaire Moto', 1, 1, '0', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, NULL),
('off_ambulance', 'EMS - Off duty', 0, 1, '0', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, NULL),
('off_police', 'LSPD - Off duty', 0, 1, '0', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, NULL),
('petitpecheur', 'Petit Pêcheur', 0, 1, '0', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, NULL),
('police', 'LSPD', 1, 1, '0', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, NULL),
('realestateagent', 'Agent Immobilier', 0, 1, '0', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, NULL),
('restau_burgershot', 'Burgershot', 0, 1, '0', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, NULL),
('restau_pearls', 'Pearls', 0, 1, '0', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, NULL),
('restau_pops', 'Pop\'s Diner', 0, 1, '0', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, NULL),
('saspn', 'BCSO', 0, 1, '0', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, NULL),
('tabac', 'Tabac', 0, 1, '0', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, NULL),
('taxi', 'Taxi', 0, 1, '0', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, NULL),
('unemployed', 'Chomeur', 0, 1, '0', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, NULL),
('unemployed2', 'Chomeur', 0, 0, '0', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, NULL),
('Vagos', 'Vagos', 0, 0, '0', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, NULL),
('vangelico', 'Vangelico', 0, 1, '0', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, NULL),
('vigne', 'Vigneron', 0, 1, '0', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, NULL),
('weazelnews', 'Weazle News', 0, 1, '0', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `jobs_armories`
--

CREATE TABLE `jobs_armories` (
  `id` int(11) NOT NULL,
  `weapon` varchar(50) NOT NULL,
  `components` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `ammo` int(10) UNSIGNED NOT NULL,
  `tint` int(11) NOT NULL,
  `marker_id` int(11) NOT NULL,
  `identifier` varchar(80) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `jobs_data`
--

CREATE TABLE `jobs_data` (
  `id` int(11) NOT NULL,
  `job_name` varchar(50) NOT NULL,
  `type` varchar(50) NOT NULL,
  `coords` varchar(300) NOT NULL DEFAULT '',
  `grades_type` varchar(20) DEFAULT NULL,
  `specific_grades` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `min_grade` smallint(6) DEFAULT NULL,
  `data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `blip_id` int(11) DEFAULT NULL,
  `blip_color` int(11) DEFAULT 0,
  `blip_scale` float DEFAULT 1,
  `label` varchar(50) DEFAULT NULL,
  `marker_type` int(11) DEFAULT 1,
  `marker_scale_x` float DEFAULT 1.5,
  `marker_scale_y` float DEFAULT 1.5,
  `marker_scale_z` float DEFAULT 0.5,
  `marker_color_red` int(3) DEFAULT 150,
  `marker_color_green` int(3) DEFAULT 150,
  `marker_color_blue` int(3) DEFAULT 0,
  `marker_color_alpha` int(3) DEFAULT 50,
  `ped` varchar(50) DEFAULT NULL,
  `ped_heading` float DEFAULT NULL,
  `object` varchar(50) DEFAULT NULL,
  `object_heading` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `jobs_shops`
--

CREATE TABLE `jobs_shops` (
  `id` int(11) NOT NULL,
  `marker_id` int(11) NOT NULL,
  `item_name` varchar(50) NOT NULL,
  `item_type` varchar(50) NOT NULL,
  `item_quantity` int(11) NOT NULL,
  `price` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `jobs_wardrobes`
--

CREATE TABLE `jobs_wardrobes` (
  `id` int(11) NOT NULL,
  `identifier` varchar(100) NOT NULL,
  `label` varchar(50) NOT NULL,
  `outfit` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `job_garages`
--

CREATE TABLE `job_garages` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `label` varchar(100) NOT NULL,
  `access_type` enum('public','job','gang') NOT NULL DEFAULT 'public',
  `access_name` varchar(100) DEFAULT NULL,
  `garage_type` enum('car','boat','aircraft') NOT NULL DEFAULT 'car',
  `access_point` longtext NOT NULL,
  `delete_point` longtext NOT NULL,
  `spawn_points` longtext NOT NULL,
  `vehicles` longtext DEFAULT NULL,
  `permissions` longtext DEFAULT NULL,
  `blip` longtext DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `job_grades`
--

CREATE TABLE `job_grades` (
  `id` int(11) NOT NULL,
  `job_name` varchar(50) DEFAULT NULL,
  `grade` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `label` varchar(50) NOT NULL,
  `salary` int(11) DEFAULT NULL,
  `skin_male` longtext DEFAULT NULL,
  `skin_female` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `job_grades`
--

INSERT INTO `job_grades` (`id`, `job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
(1, 'unemployed', 0, 'unemployed', '', 100, '{}', '{}'),
(2, 'unemployed2', 0, 'rsa', '', 50, '{}', '{}'),
(11, 'police', 0, 'recrue', 'Recrue', 1500, '{}', '{}'),
(12, 'police', 1, 'cadet', 'Cadet', 1700, '{}', '{}'),
(13, 'police', 2, 'officier1', 'Officer I', 2000, '{}', '{}'),
(14, 'police', 3, 'officier2', 'Officer II', 2300, '{}', '{}'),
(15, 'police', 4, 'officier3', 'Officer III', 2600, '{}', '{}'),
(16, 'police', 5, 'detective1', 'Detective I', 2900, '{}', '{}'),
(17, 'police', 6, 'detective2', 'Detective II', 3200, '{}', '{}'),
(18, 'police', 7, 'sergent1', 'Sergent I', 3500, '{}', '{}'),
(19, 'police', 8, 'sergent2', 'Sergent II', 3800, '{}', '{}'),
(20, 'police', 9, 'lieutenant', 'Lieutenant', 4100, '{}', '{}'),
(21, 'police', 10, 'capitaine', 'Capitaine', 4400, '{}', '{}'),
(22, 'police', 11, 'commandant', 'Commandant', 4700, '{}', '{}'),
(23, 'police', 12, 'dchief', 'Deputy Chief', 5000, '{}', '{}'),
(24, 'police', 13, 'achief', 'Assistant Chief', 5300, '{}', '{}'),
(25, 'police', 14, 'boss', 'Chief of Police', 6000, '{}', '{}'),
(30, 'gouvernement', 13, 'boss', 'Gouverneur', 0, 'null', 'null'),
(31, 'gouvernement', 12, 'Vice Gouverneur', 'Vice Gouverneur', 0, '[]', '[]'),
(32, 'gouvernement', 11, 'Premier Ministre', 'Premier Ministre', 0, '[]', '[]'),
(33, 'gouvernement', 10, 'Secretaire Défense', 'SD', 0, '[]', '[]'),
(34, 'gouvernement', 9, 'Ministre de la Justice', 'MJ', 0, '[]', '[]'),
(35, 'gouvernement', 8, 'Ministre de l\'Economie', 'ME', 0, '[]', '[]'),
(36, 'gouvernement', 7, 'Secrétaire d\'Etat', 'SE', 0, '[]', '[]'),
(37, 'gouvernement', 6, 'Secretaire au Logement', 'SL', 0, '[]', '[]'),
(38, 'gouvernement', 5, 'juge', 'Juge', 0, '[]', '[]'),
(39, 'gouvernement', 4, 'procureur', 'Procureur', 0, '[]', '[]'),
(40, 'gouvernement', 2, 'garde', 'Garde du Corp', 1000, '[]', '[]'),
(41, 'gouvernement', 1, 'chefsecu', 'Chef de securité', 0, '[]', '[]'),
(703, 'cardealer', 7, 'boss', 'patron', 1, '{}', '{}'),
(704, 'motodealer', 7, 'Stagiaire', '🎓 Stagiaire', 0, '{}', '{}'),
(706, 'motodealer', 8, 'Employé+', '✨ Employé expérimenté', 0, '{}', '{}'),
(707, 'motodealer', 1, 'boss', '👑 Directeur', 300, '{}', '{}'),
(765, 'vigne', 4, 'boss', 'Patron', 1000, '{}', '{}'),
(1781, 'realestateagent', 2, 'vendeur', 'Employé', 5500, '{}', '{}'),
(1782, 'realestateagent', 3, 'manager', 'Manager', 6500, '{}', '{}'),
(1783, 'realestateagent', 4, 'Co-gérant', 'Gestion', 7500, '{}', '{}'),
(1784, 'realestateagent', 5, 'boss', 'Patron', 9000, '{}', '{}'),
(1850, 'boatdealer', 1, 'Stagiaire', 'EMPLOYER', 0, '{}', '{}'),
(1851, 'boatdealer', 6, 'boss', 'PDG', 1, '{}', '{}'),
(1852, 'boatdealer', 5, 'co-patron', 'Co-Patron', 0, '[]', '[]'),
(1870, 'airdealer', 4, 'boss', 'PDG', 5000, NULL, NULL),
(1871, 'airdealer', 3, 'Co Patron', 'Co-Patron', 500, '[]', '[]'),
(1872, 'airdealer', 1, 'Salarié', 'Salarié', 500, '[]', '[]'),
(1946, 'saspn', 0, 'cadet', 'Trainee', 800, '{}', '{}'),
(1947, 'saspn', 1, 'officier1', 'Deputy Sheriff I', 900, '{}', '{}'),
(1948, 'saspn', 2, 'officier2', 'Deputy Sheriff II', 1000, '{}', '{}'),
(1949, 'saspn', 3, 'officier3', 'Deputy Sheriff III', 1000, '{}', '{}'),
(1950, 'saspn', 4, 'officierprincipal ', 'Senior Deputy Sheriff', 1000, '{}', '{}'),
(1951, 'saspn', 5, 'sergent1', 'Sergent', 1000, NULL, NULL),
(1952, 'saspn', 6, 'sergent2', 'Sergent Chef', 1500, NULL, NULL),
(1953, 'saspn', 7, 'lieutenant', 'Lieutenant', 2000, NULL, NULL),
(1954, 'saspn', 8, 'capitaine', 'Captain', 3000, NULL, NULL),
(1955, 'saspn', 11, 'boss', 'Sheriff', 5000, NULL, NULL),
(2032, 'le_ferailleur', 3, 'boss', 'Chef', 0, '{}', '{}'),
(2033, 'le_ferailleur', 2, 'Co -patron', 'CP', 0, '[]', '[]'),
(2034, 'le_ferailleur', 1, 'Ramasseur', 'RM', 0, '[]', '[]'),
(2062, 'taxi', 15, 'boss', '💼 I patron', 10, NULL, NULL),
(2063, 'taxi', 12, 'co-boss', '💼 I co-patron', 1, '[]', '[]'),
(2093, 'garage_lscustom', 6, 'boss', 'Boss', 1000, NULL, NULL),
(2138, 'garage_lscustom', 3, 'mecano', 'Mécano', 250, '[]', '[]'),
(2139, 'garage_lscustom', 4, 'chefequipe', 'Chef Equipe', 1, '[]', '[]'),
(2140, 'garage_lscustom', 5, 'copatron', 'Co-Patron', 500, '[]', '[]'),
(2887, 'weazelnews', 2, 'employed', 'Employé', 0, NULL, NULL),
(2888, 'weazelnews', 1, 'employed', 'Employé', 0, NULL, NULL),
(2889, 'weazelnews', 4, 'boss', 'Patron', 0, NULL, NULL),
(2890, 'weazelnews', 3, 'sous-boss', 'Manager', 0, NULL, NULL),
(2894, 'petitpecheur', 4, 'boss', 'Patron', 0, NULL, NULL),
(2895, 'petitpecheur', 1, 'employed', 'Employé', 0, NULL, NULL),
(2896, 'petitpecheur', 2, 'employed', 'Manager', 0, NULL, NULL),
(2897, 'petitpecheur', 3, 'sous-boss', 'Co-Patron', 0, NULL, NULL),
(2901, 'taxi', 3, 'chauffeur', '⭐ I chauffeur', 300, '[]', '[]'),
(2903, 'taxi', 5, 'manager', 'manager', 0, '[]', '[]'),
(2904, 'taxi', 1, 'stagiare', 'stagiare', 0, '[]', '[]'),
(2961, 'vigne', 3, 'sous-boss', 'Co-Patron', 1000, NULL, NULL),
(2968, 'saspn', 10, 'Under Sheriff', 'Under Sheriff', 4500, '[]', '[]'),
(2978, 'tabac', 3, 'sous-boss', 'Responsable d\'équipe', NULL, NULL, NULL),
(2979, 'tabac', 2, 'employed', 'Employé(e)', 0, NULL, NULL),
(2980, 'tabac', 2, 'employed', 'Employé(e)', 0, NULL, NULL),
(2981, 'tabac', 4, 'boss', 'PDG', 1, NULL, NULL),
(2988, 'motodealer', 2, 'Responsable', '📊 Responsable', 0, '[]', '[]'),
(3018, 'gouvernement', 3, 'Avocat', 'Avocat', 0, '[]', '[]'),
(3021, 'ltd_littleseoul', 4, 'boss', 'Patron', 1, NULL, NULL),
(3022, 'ltd_littleseoul', 3, 'sous-boss', 'Co-Patron', 1, NULL, NULL),
(3024, 'ltd_paletobay', 1, 'employed', 'Employer', 0, NULL, NULL),
(3025, 'ltd_paletobay', 2, 'employed', 'Employer', 0, NULL, NULL),
(3026, 'ltd_paletobay', 3, 'sous-boss', 'Co-Patron', 0, NULL, NULL),
(3027, 'ltd_paletobay', 4, 'boss', 'Patron', 0, NULL, NULL),
(3028, 'ltd_f4l', 2, 'employer', 'vendeur', 0, NULL, NULL),
(3029, 'ltd_f4l', 2, 'employer', 'vendeur', 0, NULL, NULL),
(3030, 'ltd_f4l', 3, 'sous-boss', 'Responsable', 500, NULL, NULL),
(3031, 'ltd_f4l', 4, 'boss', 'Patron', 0, NULL, NULL),
(3032, 'ltd_ballas', 1, 'employed', 'Stagiaire', 0, NULL, NULL),
(3033, 'ltd_ballas', 2, 'employed', 'Employer', 0, NULL, NULL),
(3034, 'ltd_ballas', 3, 'sous-boss', 'Co-Patron', 0, NULL, NULL),
(3035, 'ltd_ballas', 4, 'boss', 'Patron', 0, NULL, NULL),
(3044, 'ambulancesandy', 4, 'boss', 'Patron', 0, NULL, NULL),
(3045, 'ambulancesandy', 3, 'sous-boss', 'Médecin', 0, NULL, NULL),
(3046, 'ambulancesandy', 1, 'employed', 'Stagiaire', 0, NULL, NULL),
(3047, 'ambulancesandy', 2, 'employed', 'Infirmier', 0, NULL, NULL),
(3067, 'ltd_littleseoul', 2, 'Expérimenté', 'Expérimenter', 650, '[]', '[]'),
(3071, 'realestateagent', 6, 'co-patron', 'Co-patron', 8500, '[]', '[]'),
(3074, 'boatdealer', 2, 'Expérimenté', 'Novice', 0, '[]', '[]'),
(3075, 'vigne', 2, 'Sous chef', 'Sous chef', 400, '[]', '[]'),
(3076, 'vigne', 1, 'Employer', 'Empoyer', 250, '[]', '[]'),
(3085, 'ambulance', 1, 'boss', 'Directeur', 5000, NULL, NULL),
(3093, 'restau_burgershot', 1, 'employed', 'Employé', 0, NULL, NULL),
(3094, 'restau_burgershot', 2, 'employed', 'Employé', 0, NULL, NULL),
(3095, 'restau_burgershot', 3, 'sous-boss', 'Co-Patron', 0, NULL, NULL),
(3096, 'restau_burgershot', 4, 'boss', 'Patronµ', 0, NULL, NULL),
(3097, 'mecano', 3, 'Stagiaire', 'Mécano', 1, NULL, NULL),
(3098, 'mecano', 3, 'Stagiaire', 'Mécano', 1, NULL, NULL),
(3099, 'mecano', 5, 'Co patron', 'Co-Patron', 0, NULL, NULL),
(3100, 'mecano', 6, 'boss', 'Boss', 0, NULL, NULL),
(3101, 'boite_unicorn', 1, 'employed', 'Employé', 0, NULL, NULL),
(3102, 'boite_unicorn', 2, 'employed', 'Employé', 0, NULL, NULL),
(3103, 'boite_unicorn', 3, 'sous-boss', 'Co-Patron', 0, NULL, NULL),
(3104, 'boite_unicorn', 4, 'boss', 'Patron', 0, NULL, NULL),
(3105, 'gouvernement', 14, 'president', 'president', 500, '[]', '[]'),
(3106, 'ambulance', 7, 'Infirmier', 'Infirmier', 100, '[]', '[]'),
(3107, 'vangelico', 3, 'sous-boss', 'Sous Boss', 0, NULL, NULL),
(3108, 'vangelico', 2, 'employed', 'Confirmer', 0, NULL, NULL),
(3109, 'vangelico', 4, 'boss', 'Boss', 0, NULL, NULL),
(3110, 'vangelico', 1, 'employed', 'Employé', 0, NULL, NULL),
(3111, 'restau_pops', 4, 'boss', 'Patron', 0, NULL, NULL),
(3112, 'restau_pops', 3, 'sous-boss', 'Co-Patron', 0, NULL, NULL),
(3113, 'restau_pops', 2, 'employed', 'Employé', 0, NULL, NULL),
(3114, 'restau_pops', 1, 'employed', 'Stagiaire', 0, NULL, NULL),
(3115, 'hornys', 2, 'employed', 'Stagiaire', 0, NULL, NULL),
(3116, 'hornys', 1, 'employed', 'Stagiaire', 0, NULL, NULL),
(3117, 'hornys', 4, 'boss', 'Patron', 0, NULL, NULL),
(3118, 'hornys', 3, 'sous-boss', 'Co-Patron', 0, NULL, NULL),
(3119, 'restau_pearls', 4, 'boss', 'Patron', 2500, NULL, NULL),
(3120, 'restau_pearls', 3, 'sous-boss', 'Co-Patron', 1000, NULL, NULL),
(3121, 'restau_pearls', 2, 'employed', 'Employé', 550, NULL, NULL),
(3122, 'restau_pearls', 2, 'employed', 'Employé', 550, NULL, NULL),
(3123, 'boite_wiwang', 4, 'boss', 'Patron', 0, NULL, NULL),
(3124, 'boite_wiwang', 3, 'sous-boss', 'Co-Patron', 0, NULL, NULL),
(3125, 'boite_wiwang', 2, 'employed', 'Employé', 0, NULL, NULL),
(3126, 'boite_wiwang', 1, 'employed', 'Stagiaire', 0, NULL, NULL),
(3128, 'boite_pacific', 3, 'dj', 'dj', 0, NULL, NULL),
(3129, 'boite_pacific', 2, 'Sécurité', 'Employé', 0, NULL, NULL),
(3130, 'boite_pacific', 2, 'Sécurité', 'Employé', 0, NULL, NULL),
(3136, 'mecano', 4, 'Mécano Expérimenté', 'Mécano Expérimenté', 200, '[]', '[]'),
(3138, 'mecano', 2, 'Recrue', 'Recrue', 100, '[]', '[]'),
(3143, 'Cartel de Sinaloa', 1, 'boss', 'Chef', NULL, NULL, NULL),
(3146, 'cardealer', 1, 'Vendeur', 'Vendeur', 1000, '[]', '[]'),
(3147, 'cardealer', 5, 'Directeur Ressource Humaine', 'DRH', 3500, '[]', '[]'),
(3148, 'cardealer', 6, 'Ressource Humaine', 'Rh', 3500, '[]', '[]'),
(3149, 'Vagos', 1, 'boss', 'Jefe', NULL, NULL, NULL),
(3150, 'Vagos', 2, 'Capo', 'Capo', NULL, NULL, NULL),
(3151, 'Vagos', 3, 'Affiliado', 'Affiliado', NULL, NULL, NULL),
(3152, 'Vagos', 4, 'Tirador', 'Tirador', NULL, NULL, NULL),
(3153, 'Vagos', 5, 'Labron ', 'Labron ', NULL, NULL, NULL),
(3154, 'Vagos', 6, 'Esperanza ', 'Esperanza ', NULL, NULL, NULL),
(3155, 'Vagos', 7, 'Iniciado', 'Iniciado', NULL, NULL, NULL),
(3157, 'cardealer', 8, 'Directeur des ventes', 'DV', 1, '[]', '[]'),
(3158, 'Cartel De Cayo', 1, 'boss', 'Chef', NULL, NULL, NULL),
(3159, 'Madrazo', 1, 'boss', 'Jefe', NULL, NULL, NULL),
(3170, 'McReary', 1, 'boss', 'Chef', NULL, NULL, NULL),
(3171, 'McReary', 2, 'co-lead', 'co-lead', NULL, NULL, NULL),
(3172, 'McReary', 3, 'lieutenant', 'lieutenant', NULL, NULL, NULL),
(3173, 'McReary', 4, 'gros-bras', 'gros-bras', NULL, NULL, NULL),
(3174, 'McReary', 5, 'mafieux', 'mafieux', NULL, NULL, NULL),
(3175, 'McReary', 6, 'soldat', 'soldat', NULL, NULL, NULL),
(3176, 'McReary', 7, 'gosse de rue', 'gosse de rue', NULL, NULL, NULL),
(3177, 'saspn', 9, 'Commander', 'Area Commander', 4000, '[]', '[]'),
(3179, 'Cartel de Sinaloa', 2, 'Halcón', 'Halcón', NULL, NULL, NULL),
(3180, 'Cartel de Sinaloa', 3, 'Cocinero', 'Cocinero', NULL, NULL, NULL),
(3181, 'Cartel de Sinaloa', 4, 'Plaza Boss', 'Plaza Boss', NULL, NULL, NULL),
(3182, 'Cartel de Sinaloa', 5, 'Jefe Operaciones', 'Jefe OP', NULL, NULL, NULL),
(3183, 'Cartel de Sinaloa', 6, 'Sous Chef', 'SubJefe', NULL, NULL, NULL),
(3185, 'Duggan', 1, 'boss', 'Chef', NULL, NULL, NULL),
(3186, 'Duggan', 2, 'Petit Coussin', 'Petit Coussin', NULL, NULL, NULL),
(3187, 'Duggan', 3, 'Coussin', 'Coussin ', NULL, NULL, NULL),
(3189, 'Duggan', 4, 'Frère', 'Frère', NULL, NULL, NULL),
(3190, 'Duggan', 5, 'Frère Rapprocher ', 'Frère R', NULL, NULL, NULL),
(3191, 'Duggan', 6, 'Bras Droit', 'Bras D.', NULL, NULL, NULL),
(3194, 'ambulance', 4, 'rh', 'RH', 300, '[]', '[]'),
(3195, 'ambulance', 3, 'drh', 'DRH', 300, '[]', '[]'),
(3198, 'ambulance', 6, 'médecin', 'Médecin', 400, '[]', '[]'),
(3199, 'ambulance', 5, 'médecin chef', 'Médecin chef', 500, '[]', '[]'),
(3200, 'ambulance', 2, 'co patron', 'Co patron', 2000, '[]', '[]'),
(3202, 'Madrazo', 2, 'Bras Droit', 'General', NULL, NULL, NULL),
(3203, 'Madrazo', 3, 'Lieutenant', 'Lieutenant', NULL, NULL, NULL),
(3204, 'Madrazo', 4, 'Sergent ', 'Sergent', NULL, NULL, NULL),
(3206, 'Madrazo', 5, 'Soldat 1', 'Soldat 1', NULL, NULL, NULL),
(3207, 'Madrazo', 6, 'Soldat 2', 'Soldat 2', NULL, NULL, NULL),
(3208, 'Madrazo', 7, 'Soldat 3', 'Soldat 3', NULL, NULL, NULL),
(3209, 'ltd_littleseoul', 1, 'Employé', 'Employé', 350, '[]', '[]'),
(3211, 'Cartel De Cayo', 3, 'soldat', 'Soldat Cayo', NULL, NULL, NULL),
(3212, 'cardealer', 2, 'Vendeur confirmé', 'Vendeur confirmé', 1500, '[]', '[]'),
(3217, 'bar_tequila', 1, 'employed', 'Stagiaire', 0, NULL, NULL),
(3218, 'bar_tequila', 4, 'boss', 'Patron', 0, NULL, NULL),
(3219, 'bar_tequila', 3, 'sous-boss', 'Co-Patron', 0, NULL, NULL),
(3220, 'bar_tequila', 2, 'employed', 'Employé', 0, NULL, NULL),
(3221, 'bar_beachclub', 1, 'employed', 'Stagiaire', 0, NULL, NULL),
(3222, 'bar_beachclub', 2, 'employed', 'Employé', 0, NULL, NULL),
(3223, 'bar_beachclub', 3, 'sous-boss', 'Co-Patron', 0, NULL, NULL),
(3224, 'bar_beachclub', 4, 'boss', 'Patron', 0, NULL, NULL),
(3225, 'bar_mojitoinn', 1, 'employed', 'Stagiaire', 0, NULL, NULL),
(3226, 'bar_mojitoinn', 4, 'boss', 'Patron', 0, NULL, NULL),
(3227, 'bar_mojitoinn', 3, 'sous-boss', 'Co-Patron', 0, NULL, NULL),
(3228, 'bar_mojitoinn', 2, 'employed', 'Employé', 0, NULL, NULL),
(3229, 'ltd_arena', 1, 'employed', 'Stagiaire', 0, NULL, NULL),
(3230, 'ltd_arena', 2, 'employed', 'Employé', 0, NULL, NULL),
(3231, 'ltd_arena', 3, 'sous-boss', 'Co-Patron', 0, NULL, NULL),
(3232, 'ltd_arena', 4, 'boss', 'Patron', 0, NULL, NULL),
(3233, 'garage_octacyp', 1, 'employed', 'Stagiaire', 0, NULL, NULL),
(3234, 'garage_octacyp', 2, 'employed', 'Employé', 0, NULL, NULL),
(3235, 'garage_octacyp', 4, 'boss', 'Patron', 0, NULL, NULL),
(3236, 'garage_octacyp', 3, 'sous-boss', 'Co-Patron', 0, NULL, NULL),
(3237, 'garage_driveline', 1, 'employed', 'Stagiaire', 0, NULL, NULL),
(3238, 'garage_driveline', 4, 'boss', 'Patron', 0, NULL, NULL),
(3239, 'garage_driveline', 3, 'sous-boss', 'Co-Patron', 0, NULL, NULL),
(3240, 'garage_driveline', 2, 'employed', 'Employé', 0, NULL, NULL),
(3241, 'garage_eastcustoms', 1, 'employed', 'Stagiaire', 0, NULL, NULL),
(3242, 'garage_eastcustoms', 4, 'boss', 'Patron', 0, NULL, NULL),
(3243, 'garage_eastcustoms', 3, 'sous-boss', 'Co-Patron', 0, NULL, NULL),
(3244, 'garage_eastcustoms', 2, 'employed', 'Employé', 0, NULL, NULL),
(3245, 'garage_paletocustoms', 1, 'employed', 'Stagiaire', 0, NULL, NULL),
(3246, 'garage_paletocustoms', 4, 'boss', 'Patron', 0, NULL, NULL),
(3247, 'garage_paletocustoms', 3, 'sous-boss', 'Co-Patron', 0, NULL, NULL),
(3248, 'garage_paletocustoms', 2, 'employed', 'Employé', 0, NULL, NULL),
(3249, 'garage_speedhunters', 1, 'employed', 'Stagiaire', 0, NULL, NULL),
(3250, 'garage_speedhunters', 2, 'employed', 'Employé', 0, NULL, NULL),
(3251, 'garage_speedhunters', 3, 'sous-boss', 'Co-Patron', 0, NULL, NULL),
(3252, 'garage_speedhunters', 4, 'boss', 'Patron', 0, NULL, NULL),
(3253, 'off_ambulance', 1, 'off_boss', 'Directeur', 0, '{}', '{}'),
(3254, 'off_ambulance', 2, 'off_co patron', 'Co patron', 0, '{}', '{}'),
(3255, 'off_ambulance', 3, 'off_drh', 'DRH', 0, '{}', '{}'),
(3256, 'off_ambulance', 4, 'off_rh', 'RH', 0, '{}', '{}'),
(3257, 'off_ambulance', 5, 'off_médecin chef', 'Médecin chef', 0, '{}', '{}'),
(3258, 'off_ambulance', 6, 'off_médecin', 'Médecin', 0, '{}', '{}'),
(3259, 'off_ambulance', 7, 'off_Infirmier', 'Infirmier', 0, '{}', '{}'),
(3260, 'off_police', 1, 'off_cadet', 'Cadet', 0, '{}', '{}'),
(3261, 'off_police', 2, 'off_officier1', 'Officer I', 0, '{}', '{}'),
(3262, 'off_police', 3, 'off_officier2', 'Officer II', 0, '{}', '{}'),
(3263, 'off_police', 4, 'off_officier3', 'Officer III', 0, '{}', '{}'),
(3264, 'off_police', 5, 'off_detective1', 'Detective I', 0, '{}', '{}'),
(3265, 'off_police', 6, 'off_detective2', 'Detective II', 0, '{}', '{}'),
(3266, 'off_police', 7, 'off_sergent1', 'Sergent I', 0, '{}', '{}'),
(3267, 'off_police', 8, 'off_sergent2', 'Sergent II', 0, '{}', '{}'),
(3268, 'off_police', 9, 'off_lieutenant', 'Lieutenant', 0, '{}', '{}'),
(3269, 'off_police', 10, 'off_capitaine', 'Capitaine', 0, '{}', '{}'),
(3270, 'off_police', 11, 'off_commandant', 'Commandant', 0, '{}', '{}'),
(3271, 'off_police', 12, 'off_dchief', 'Deputy Chief', 0, '{}', '{}'),
(3272, 'off_police', 13, 'off_achief', 'Assistant Chief', 0, '{}', '{}'),
(3273, 'off_police', 14, 'off_chief', 'Chief of Police', 0, '{}', '{}'),
(3274, 'off_police', 0, 'off_recrue', 'Recrue', 0, '{}', '{}');

-- --------------------------------------------------------

--
-- Structure de la table `laboratories`
--

CREATE TABLE `laboratories` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `coords` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `allowed_recipes` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `allowed_jobs` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `icon_type` int(11) NOT NULL,
  `scale` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `bounce` int(11) NOT NULL DEFAULT 0,
  `follow_camera` int(11) NOT NULL DEFAULT 0,
  `rotate` int(11) NOT NULL DEFAULT 0,
  `color` varchar(50) NOT NULL DEFAULT '0',
  `opacity` int(11) NOT NULL DEFAULT 0,
  `blip_name` varchar(50) DEFAULT NULL,
  `blip_sprite` int(11) DEFAULT NULL,
  `blip_color` int(11) DEFAULT NULL,
  `blip_scale` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `licenses`
--

CREATE TABLE `licenses` (
  `type` varchar(60) NOT NULL,
  `label` varchar(60) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `licenses`
--

INSERT INTO `licenses` (`type`, `label`) VALUES
('boat', 'Boat License'),
('dmv', 'Code de la route'),
('drive', 'Permis de conduire'),
('drive_bike', 'Permis moto'),
('drive_truck', 'Permis camion'),
('weapon', 'Permis de port d\'arme');

-- --------------------------------------------------------

--
-- Structure de la table `livraisons`
--

CREATE TABLE `livraisons` (
  `uniqueid` int(11) NOT NULL,
  `levels` int(11) DEFAULT 0,
  `gains` int(11) NOT NULL DEFAULT 100,
  `livraisons` int(11) DEFAULT 0,
  `vehicle` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `livraisons`
--

INSERT INTO `livraisons` (`uniqueid`, `levels`, `gains`, `livraisons`, `vehicle`) VALUES
(75, 50, 100, 5, '[\"boxville\"]'),
(142, 10, 100, 1, '[\"boxville\"]'),
(156, 50, 100, 5, '[\"boxville\"]'),
(166, 440, 400, 44, '[\"packer\"]'),
(210, 420, 400, 242, '[\"packer\"]'),
(252, 0, 500, 50, '[\"packer\"]'),
(219, 40, 100, 4, '[\"boxville\"]'),
(265, 30, 100, 3, '[\"boxville\"]'),
(234, 300, 300, 80, '[\"mule\"]'),
(274, 0, 100, 0, '[\"boxville\"]'),
(207, 0, 100, 0, '[\"boxville\"]'),
(291, 220, 200, 222, '[\"mule\"]'),
(310, 210, 200, 321, '[\"mule\"]'),
(232, 0, 100, 0, '[\"boxville\"]'),
(226, 0, 100, 0, '[\"boxville\"]'),
(171, 40, 100, 4, '[\"boxville\"]'),
(237, 40, 100, 4, '[\"boxville\"]'),
(257, 0, 100, 0, '[\"boxville\"]'),
(408, 100, 100, 10, '[\"boxville\"]'),
(201, 50, 500, 155, '[\"boxville\"]'),
(373, 40, 100, 4, '[\"boxville\"]'),
(438, 200, 200, 20, '[\"mule\"]'),
(276, 10, 100, 1, '[\"boxville\"]'),
(376, 60, 100, 6, '[\"boxville\"]'),
(466, 10, 100, 1, '[\"boxville\"]'),
(325, 90, 100, 9, '[\"boxville\"]'),
(279, 70, 100, 7, '[\"boxville\"]'),
(499, 80, 100, 8, '[\"boxville\"]'),
(236, 10, 100, 1, '[\"boxville\"]'),
(523, 10, 100, 1, '[\"boxville\"]'),
(505, 180, 100, 18, '[\"boxville\"]'),
(480, 0, 100, 0, '[\"boxville\"]'),
(412, 30, 100, 3, '[\"boxville\"]'),
(597, 10, 100, 1, '[\"boxville\"]'),
(606, 0, 100, 0, '[\"boxville\"]'),
(596, 110, 100, 11, '[\"boxville\"]'),
(643, 190, 100, 19, '[\"boxville\"]'),
(664, 70, 100, 7, '[\"boxville\"]'),
(642, 490, 400, 49, '[\"packer\"]'),
(695, 240, 200, 124, '[\"mule\"]'),
(681, 20, 100, 2, '[\"boxville\"]'),
(696, 110, 100, 11, '[\"boxville\"]'),
(692, 90, 100, 9, '[\"boxville\"]'),
(748, 40, 100, 4, '[\"boxville\"]'),
(571, 10, 100, 1, '[\"boxville\"]'),
(810, 30, 100, 3, '[\"boxville\"]'),
(806, 100, 100, 160, '[\"boxville\"]'),
(805, 70, 100, 7, '[\"boxville\"]'),
(808, 30, 100, 3, '[\"boxville\"]'),
(551, 110, 100, 11, '[\"boxville\"]'),
(559, 40, 100, 4, '[\"boxville\"]'),
(173, 0, 100, 0, '[\"boxville\"]'),
(856, 90, 100, 9, '[\"boxville\"]'),
(624, 40, 100, 4, '[\"boxville\"]'),
(566, 50, 100, 5, '[\"boxville\"]'),
(786, 20, 500, 52, '[\"boxville\"]'),
(378, 50, 100, 5, '[\"boxville\"]'),
(686, 50, 100, 5, '[\"boxville\"]'),
(661, 20, 100, 2, '[\"boxville\"]'),
(330, 180, 100, 18, '[\"boxville\"]'),
(222, 120, 100, 62, '[\"boxville\"]'),
(922, 10, 100, 1, '[\"boxville\"]'),
(579, 320, 300, 82, '[\"mule\"]'),
(1075, 120, 100, 12, '[\"boxville\"]'),
(1096, 10, 100, 1, '[\"boxville\"]'),
(1108, 330, 300, 33, '[\"mule\"]'),
(214, 0, 100, 0, '[\"boxville\"]'),
(1150, 70, 100, 7, '[\"boxville\"]'),
(1166, 20, 100, 2, '[\"boxville\"]'),
(1102, 100, 100, 10, '[\"boxville\"]'),
(1103, 0, 500, 50, '[\"packer\"]'),
(1106, 30, 100, 3, '[\"boxville\"]'),
(1236, 230, 200, 73, '[\"mule\"]'),
(1197, 10, 100, 1, '[\"boxville\"]'),
(1305, 30, 100, 3, '[\"boxville\"]'),
(1263, 120, 100, 62, '[\"boxville\"]'),
(1147, 20, 100, 2, '[\"boxville\"]'),
(1256, 340, 300, 34, '[\"mule\"]'),
(583, 120, 100, 112, '[\"boxville\"]'),
(1327, 70, 100, 7, '[\"boxville\"]'),
(1334, 110, 100, 11, '[\"boxville\"]'),
(1326, 200, 200, 20, '[\"mule\"]'),
(1339, 380, 300, 38, '[\"mule\"]'),
(1377, 110, 100, 11, '[\"boxville\"]'),
(1394, 40, 100, 4, '[\"boxville\"]'),
(1275, 230, 200, 23, '[\"mule\"]'),
(1421, 80, 500, 158, '[\"boxville\"]'),
(1420, 420, 400, 92, '[\"packer\"]'),
(1438, 0, 100, 0, '[\"boxville\"]'),
(1222, 60, 100, 6, '[\"boxville\"]'),
(205, 10, 500, 251, '[\"boxville\"]'),
(1364, 320, 300, 132, '[\"mule\"]'),
(843, 70, 100, 7, '[\"boxville\"]'),
(603, 70, 500, 107, '[\"boxville\"]'),
(1487, 90, 100, 9, '[\"boxville\"]'),
(585, 60, 100, 6, '[\"boxville\"]'),
(824, 80, 100, 8, '[\"boxville\"]'),
(1515, 60, 100, 6, '[\"boxville\"]'),
(1562, 50, 100, 5, '[\"boxville\"]'),
(1542, 200, 200, 20, '[\"mule\"]'),
(321, 110, 100, 11, '[\"boxville\"]'),
(1529, 60, 100, 6, '[\"boxville\"]'),
(1582, 40, 100, 4, '[\"boxville\"]'),
(1526, 50, 100, 5, '[\"boxville\"]'),
(557, 210, 200, 121, '[\"mule\"]'),
(1516, 0, 100, 0, '[\"boxville\"]'),
(722, 140, 100, 64, '[\"boxville\"]'),
(221, 20, 100, 2, '[\"boxville\"]'),
(369, 10, 100, 1, '[\"boxville\"]'),
(1618, 80, 100, 8, '[\"boxville\"]'),
(471, 180, 100, 18, '[\"boxville\"]'),
(1689, 0, 100, 0, '[\"boxville\"]'),
(1704, 20, 100, 2, '[\"boxville\"]'),
(1744, 0, 100, 0, '[\"boxville\"]'),
(1498, 40, 100, 4, '[\"boxville\"]'),
(1894, 0, 100, 0, '[\"boxville\"]'),
(1888, 0, 100, 0, '[\"boxville\"]'),
(1955, 20, 100, 2, '[\"boxville\"]'),
(1459, 0, 100, 0, '[\"boxville\"]');

-- --------------------------------------------------------

--
-- Structure de la table `luxucex_accounts`
--

CREATE TABLE `luxucex_accounts` (
  `id` int(10) UNSIGNED NOT NULL,
  `char_id` varchar(255) NOT NULL,
  `balance` bigint(20) NOT NULL DEFAULT 0,
  `crypto` longtext NOT NULL,
  `address` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `luxucex_market_transactions`
--

CREATE TABLE `luxucex_market_transactions` (
  `id` int(10) UNSIGNED NOT NULL,
  `identifier` varchar(100) NOT NULL,
  `type` enum('buy','sell') NOT NULL,
  `coin` varchar(50) NOT NULL,
  `amount` decimal(20,8) UNSIGNED NOT NULL,
  `price` decimal(20,8) UNSIGNED NOT NULL,
  `created_at` datetime NOT NULL DEFAULT curtime()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `luxucex_positions`
--

CREATE TABLE `luxucex_positions` (
  `code` char(36) NOT NULL,
  `pair` varchar(100) NOT NULL,
  `type` varchar(100) NOT NULL,
  `contract_quantity` varchar(100) NOT NULL,
  `entry` float NOT NULL,
  `leverage` int(11) NOT NULL,
  `allocated_margin` float NOT NULL,
  `date` datetime NOT NULL DEFAULT current_timestamp(),
  `liquidation` float DEFAULT NULL,
  `owner` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `luxucex_tradinghistory`
--

CREATE TABLE `luxucex_tradinghistory` (
  `key` int(11) NOT NULL,
  `pair` varchar(100) NOT NULL,
  `entry` varchar(100) DEFAULT NULL,
  `margin` varchar(100) NOT NULL,
  `leverage` varchar(100) NOT NULL,
  `size` varchar(100) NOT NULL,
  `type` varchar(100) NOT NULL,
  `close` varchar(100) DEFAULT NULL,
  `date` datetime NOT NULL DEFAULT current_timestamp(),
  `action` varchar(100) NOT NULL,
  `pnl` varchar(100) DEFAULT NULL,
  `owner` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `luxucex_transfers`
--

CREATE TABLE `luxucex_transfers` (
  `id` int(10) UNSIGNED NOT NULL,
  `sender` varchar(255) NOT NULL,
  `receiver` varchar(255) NOT NULL,
  `coin` varchar(255) NOT NULL,
  `amount` decimal(20,8) UNSIGNED NOT NULL,
  `created_at` datetime NOT NULL DEFAULT curtime()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `maintenant`
--

CREATE TABLE `maintenant` (
  `active` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `maintenant`
--

INSERT INTO `maintenant` (`active`) VALUES
(0);

-- --------------------------------------------------------

--
-- Structure de la table `mechanics`
--

CREATE TABLE `mechanics` (
  `plate` text DEFAULT NULL,
  `data` longtext DEFAULT '[]'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `moto_categories`
--

CREATE TABLE `moto_categories` (
  `name` varchar(60) NOT NULL,
  `label` varchar(60) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `moto_categories`
--

INSERT INTO `moto_categories` (`name`, `label`) VALUES
('motorcycles', 'Moto');

-- --------------------------------------------------------

--
-- Structure de la table `nv_banking_data`
--

CREATE TABLE `nv_banking_data` (
  `id` int(11) NOT NULL,
  `uuid` varchar(64) NOT NULL,
  `info` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`info`)),
  `active_credits` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`active_credits`)),
  `transactions` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`transactions`)),
  `crypto_holdings` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`crypto_holdings`)),
  `requests` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`requests`)),
  `notifications` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`notifications`)),
  `account_used` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`account_used`)),
  `savings_balance` int(11) NOT NULL DEFAULT 0,
  `credit_score` int(11) NOT NULL DEFAULT 1000,
  `iban` varchar(20) NOT NULL,
  `password` varchar(255) NOT NULL,
  `savings_accounts_data` longtext NOT NULL DEFAULT '[]'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `nv_cloth`
--

CREATE TABLE `nv_cloth` (
  `id` int(11) NOT NULL,
  `identifier` varchar(50) NOT NULL,
  `clothes` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `open_car`
--

CREATE TABLE `open_car` (
  `id` int(11) NOT NULL,
  `identifier` varchar(255) DEFAULT NULL,
  `label` varchar(255) DEFAULT NULL,
  `value` varchar(50) DEFAULT NULL,
  `got` varchar(50) DEFAULT NULL,
  `NB` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Structure de la table `owned_vehicles`
--

CREATE TABLE `owned_vehicles` (
  `owner` varchar(50) NOT NULL,
  `nom` varchar(255) DEFAULT NULL,
  `doubles` longtext NOT NULL DEFAULT '{"cles":[]}',
  `plate` varchar(255) NOT NULL,
  `vehicle` longtext NOT NULL,
  `status` int(12) DEFAULT NULL,
  `inventory` longtext DEFAULT NULL,
  `numero` int(12) DEFAULT NULL,
  `garage` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `position` varchar(255) DEFAULT NULL,
  `degat` longtext DEFAULT NULL,
  `boutique` tinyint(1) NOT NULL DEFAULT 0,
  `garageid` int(11) NOT NULL DEFAULT 1,
  `state` tinyint(1) NOT NULL DEFAULT 1,
  `label` longtext NOT NULL DEFAULT 'A MODIFIER',
  `type` varchar(50) DEFAULT 'car',
  `job` text DEFAULT '\'unemployed\'',
  `propertiesID` int(11) DEFAULT 0,
  `fuel` longtext DEFAULT '100',
  `carseller` int(11) DEFAULT 0,
  `neons` int(1) NOT NULL DEFAULT 0,
  `key_id` int(11) DEFAULT 0,
  `glovebox` longtext DEFAULT NULL,
  `trunk` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `owned_vehicles`
--

INSERT INTO `owned_vehicles` (`owner`, `nom`, `doubles`, `plate`, `vehicle`, `status`, `inventory`, `numero`, `garage`, `name`, `position`, `degat`, `boutique`, `garageid`, `state`, `label`, `type`, `job`, `propertiesID`, `fuel`, `carseller`, `neons`, `key_id`, `glovebox`, `trunk`) VALUES
('21', NULL, '{\"cles\":[]}', 'TEMP4725', '{\"model\":970598228,\"plate\":\"TEMP4725\"}', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, 1, 'A MODIFIER', 'car', '\'unemployed\'', 0, '100', 0, 0, 0, NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `ox_doorlock`
--

CREATE TABLE `ox_doorlock` (
  `id` int(11) UNSIGNED NOT NULL,
  `name` varchar(50) NOT NULL,
  `data` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `ox_inventory`
--

CREATE TABLE `ox_inventory` (
  `owner` varchar(60) DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `data` longtext DEFAULT NULL,
  `lastupdated` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `pausemenu_battlepass_dailymissions`
--

CREATE TABLE `pausemenu_battlepass_dailymissions` (
  `missions` longtext DEFAULT NULL,
  `updatedAt` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Déchargement des données de la table `pausemenu_battlepass_dailymissions`
--

INSERT INTO `pausemenu_battlepass_dailymissions` (`missions`, `updatedAt`) VALUES
('[]', 1734517005);

-- --------------------------------------------------------

--
-- Structure de la table `pausemenu_battlepass_data`
--

CREATE TABLE `pausemenu_battlepass_data` (
  `id` int(11) NOT NULL,
  `identifier` longtext NOT NULL,
  `level` int(11) NOT NULL DEFAULT 1,
  `xp` int(11) NOT NULL DEFAULT 0,
  `purchased` int(11) NOT NULL DEFAULT 0,
  `claimedLevels` longtext NOT NULL DEFAULT '{}',
  `missions` longtext DEFAULT '{}'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Structure de la table `pausemenu_battlepass_day_counter`
--

CREATE TABLE `pausemenu_battlepass_day_counter` (
  `counter` int(11) DEFAULT 30
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Déchargement des données de la table `pausemenu_battlepass_day_counter`
--

INSERT INTO `pausemenu_battlepass_day_counter` (`counter`) VALUES
(5);

-- --------------------------------------------------------

--
-- Structure de la table `pausemenu_battlepass_transactions`
--

CREATE TABLE `pausemenu_battlepass_transactions` (
  `tbx_id` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `pausemenu_commands`
--

CREATE TABLE `pausemenu_commands` (
  `command` longtext DEFAULT NULL,
  `desc` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Déchargement des données de la table `pausemenu_commands`
--

INSERT INTO `pausemenu_commands` (`command`, `desc`) VALUES
('report', 'Vous permet de contacter l\'équipe staff si besoin'),
('tv', 'Pour gérer les Télévisions (Fonctionne aussi en véhicule)'),
('streamermode', 'Désactive la music des véhicules et des Télévisions');

-- --------------------------------------------------------

--
-- Structure de la table `pausemenu_daily_awards`
--

CREATE TABLE `pausemenu_daily_awards` (
  `identifier` longtext DEFAULT NULL,
  `claimedDays` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Structure de la table `pausemenu_daily_awards_day_counter`
--

CREATE TABLE `pausemenu_daily_awards_day_counter` (
  `counter` int(11) DEFAULT NULL,
  `updatedAt` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Déchargement des données de la table `pausemenu_daily_awards_day_counter`
--

INSERT INTO `pausemenu_daily_awards_day_counter` (`counter`, `updatedAt`) VALUES
(27, 1734258639);

-- --------------------------------------------------------

--
-- Structure de la table `pausemenu_guidebook`
--

CREATE TABLE `pausemenu_guidebook` (
  `id` int(11) NOT NULL,
  `name` longtext DEFAULT NULL,
  `html` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `pausemenu_keybinds`
--

CREATE TABLE `pausemenu_keybinds` (
  `key` longtext NOT NULL,
  `desc` longtext DEFAULT NULL,
  `combinationkey` longtext DEFAULT NULL,
  `combinationdesc` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Déchargement des données de la table `pausemenu_keybinds`
--

INSERT INTO `pausemenu_keybinds` (`key`, `desc`, `combinationkey`, `combinationdesc`) VALUES
('TAB', 'Ouvre l\'inventaire', 'false', ''),
('W', 'Arrêter une animation', 'false', ''),
('T', 'Ouvre le chat', 'false', ''),
('U', 'Verrouille le véhicule', 'false', ''),
('G', 'Sortir/Ranger le téléphone', 'false', ''),
('J', 'S\'endormir/Trébuchet', 'false', ''),
('L', 'Ouvrir le coffre d\'un véhicule', 'false', ''),
('LEFTSHIFT', 'Courir', 'false', ''),
('X', 'Lever les mains', 'false', ''),
('P', 'ouvrir la map', 'false', ''),
('F11', 'Modifie la portée de la voix', 'false', ''),
('F2', 'Ouvre le menu animation', 'false', ''),
('F5', 'Inventaire/Portefeuille/Préférences', 'false', ''),
('F6', 'Menu Entreprise', 'false', ''),
('F7', 'Menu Illégal', 'false', ''),
('1', 'Raccourci d\'inventaire / Changer de place en véhicule', 'false', ''),
('2', 'Raccourci d\'inventaire / Changer de place en véhicule', 'false', ''),
('3', 'Raccourci d\'inventaire / Changer de place en véhicule', 'false', ''),
('4', 'Raccourci d\'inventaire / Changer de place en véhicule', 'false', ''),
('5', 'Raccourci d\'inventaire / Changer de place en véhicule', 'false', '');

-- --------------------------------------------------------

--
-- Structure de la table `pausemenu_peds`
--

CREATE TABLE `pausemenu_peds` (
  `identifier` longtext DEFAULT NULL,
  `ped` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `perso_preferences`
--

CREATE TABLE `perso_preferences` (
  `UniqueID` int(11) DEFAULT NULL,
  `data` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `perso_preferences`
--

INSERT INTO `perso_preferences` (`UniqueID`, `data`) VALUES
(1, '{\"objects_infos\":{\"name\":\"objects_infos\",\"active\":false}}'),
(2, '[]'),
(3, '[]'),
(4, '[]'),
(5, '[]'),
(6, '[]'),
(7, '[]'),
(8, '[]'),
(9, '[]'),
(10, '[]'),
(11, '[]'),
(12, '[]'),
(13, '[]'),
(14, '[]'),
(15, '[]'),
(16, '[]'),
(17, '[]'),
(18, '[]'),
(19, '[]'),
(20, '[]'),
(21, '[]');

-- --------------------------------------------------------

--
-- Structure de la table `playerstattoos`
--

CREATE TABLE `playerstattoos` (
  `identifier` varchar(50) NOT NULL,
  `tattoos` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- --------------------------------------------------------

--
-- Structure de la table `players_gofast`
--

CREATE TABLE `players_gofast` (
  `id` int(11) NOT NULL,
  `license_identifier` varchar(50) NOT NULL,
  `gofast_cooldown` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `players_props`
--

CREATE TABLE `players_props` (
  `UniqueID` int(11) NOT NULL DEFAULT 0,
  `data` longtext DEFAULT NULL,
  `name` longtext DEFAULT NULL,
  `id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `players_props`
--

INSERT INTO `players_props` (`UniqueID`, `data`, `name`, `id`) VALUES
(1, '{\"label\":\"Canapé d\'angle 2\",\"count\":1,\"owner\":1,\"name\":\"v_res_mp_sofa\"}', 'v_res_mp_sofa', 10),
(1, '{\"owner\":1,\"count\":1,\"name\":\"prop_fib_3b_bench\",\"label\":\"Chaise 3 places\"}', 'prop_fib_3b_bench', 11);

-- --------------------------------------------------------

--
-- Structure de la table `players_territories`
--

CREATE TABLE `players_territories` (
  `id` int(11) NOT NULL,
  `control` varchar(50) DEFAULT 'none',
  `namecontrol` varchar(50) DEFAULT 'none',
  `influence` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `player_clothes`
--

CREATE TABLE `player_clothes` (
  `UniqueID` int(11) NOT NULL,
  `clothes` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `player_clothes`
--

INSERT INTO `player_clothes` (`UniqueID`, `clothes`) VALUES
(1, '[{\"label\":\"Chic Noir\",\"data\":[{\"number\":0,\"name\":\"arms\"},{\"number\":0,\"name\":\"bproof_1\"},{\"number\":0,\"name\":\"bproof_2\"},{\"number\":15,\"name\":\"tshirt_1\"},{\"number\":0,\"name\":\"shoes_2\"},{\"number\":0,\"name\":\"decals_1\"},{\"number\":0,\"name\":\"pants_2\"},{\"number\":0,\"name\":\"tshirt_2\"},{\"number\":10,\"name\":\"shoes_1\"},{\"number\":3,\"name\":\"torso_2\"},{\"number\":654,\"name\":\"torso_1\"},{\"number\":92,\"name\":\"pants_1\"}]},{\"label\":\"Summer Black\",\"data\":[{\"number\":5,\"name\":\"arms\"},{\"number\":0,\"name\":\"bproof_1\"},{\"number\":0,\"name\":\"bproof_2\"},{\"number\":5,\"name\":\"tshirt_1\"},{\"number\":0,\"name\":\"shoes_2\"},{\"number\":0,\"name\":\"decals_1\"},{\"number\":0,\"name\":\"pants_2\"},{\"number\":0,\"name\":\"tshirt_2\"},{\"number\":56,\"name\":\"shoes_1\"},{\"number\":6,\"name\":\"torso_2\"},{\"number\":724,\"name\":\"torso_1\"},{\"number\":41,\"name\":\"pants_1\"}]},{\"label\":\"Chic White\",\"data\":[{\"number\":8,\"name\":\"arms\"},{\"number\":0,\"name\":\"bproof_1\"},{\"number\":0,\"name\":\"bproof_2\"},{\"number\":15,\"name\":\"tshirt_1\"},{\"number\":3,\"name\":\"shoes_2\"},{\"number\":0,\"name\":\"decals_1\"},{\"number\":8,\"name\":\"pants_2\"},{\"number\":0,\"name\":\"tshirt_2\"},{\"number\":93,\"name\":\"shoes_1\"},{\"number\":0,\"name\":\"torso_2\"},{\"number\":693,\"name\":\"torso_1\"},{\"number\":92,\"name\":\"pants_1\"}]}]'),
(2, '[{\"label\":\"Test\",\"data\":[{\"number\":0,\"name\":\"pants_2\"},{\"number\":0,\"name\":\"tshirt_1\"},{\"number\":0,\"name\":\"torso_2\"},{\"number\":0,\"name\":\"shoes_2\"},{\"number\":226,\"name\":\"torso_1\"},{\"number\":0,\"name\":\"bproof_2\"},{\"number\":0,\"name\":\"bproof_1\"},{\"number\":0,\"name\":\"pants_1\"},{\"number\":0,\"name\":\"decals_1\"},{\"number\":0,\"name\":\"shoes_1\"},{\"number\":0,\"name\":\"arms\"},{\"number\":0,\"name\":\"tshirt_2\"}]},{\"label\":\"test\",\"data\":[{\"number\":0,\"name\":\"pants_2\"},{\"number\":153,\"name\":\"tshirt_1\"},{\"number\":0,\"name\":\"torso_2\"},{\"number\":0,\"name\":\"shoes_2\"},{\"number\":226,\"name\":\"torso_1\"},{\"number\":0,\"name\":\"bproof_2\"},{\"number\":0,\"name\":\"bproof_1\"},{\"number\":0,\"name\":\"pants_1\"},{\"number\":0,\"name\":\"decals_1\"},{\"number\":0,\"name\":\"shoes_1\"},{\"number\":0,\"name\":\"arms\"},{\"number\":0,\"name\":\"tshirt_2\"}]}]'),
(4, '[{\"label\":\"test\",\"data\":[{\"number\":3,\"name\":\"pants_2\"},{\"number\":30,\"name\":\"shoes_1\"},{\"number\":8,\"name\":\"arms\"},{\"number\":0,\"name\":\"tshirt_2\"},{\"number\":0,\"name\":\"decals_1\"},{\"number\":15,\"name\":\"tshirt_1\"},{\"number\":0,\"name\":\"bproof_2\"},{\"number\":0,\"name\":\"bproof_1\"},{\"number\":86,\"name\":\"pants_1\"},{\"number\":0,\"name\":\"torso_2\"},{\"number\":693,\"name\":\"torso_1\"},{\"number\":0,\"name\":\"shoes_2\"}]}]'),
(5, '[{\"label\":\"SASP\",\"data\":[{\"name\":\"torso_2\",\"number\":0},{\"name\":\"torso_1\",\"number\":733},{\"name\":\"pants_1\",\"number\":43},{\"name\":\"bproof_2\",\"number\":0},{\"name\":\"pants_2\",\"number\":1},{\"name\":\"shoes_2\",\"number\":2},{\"name\":\"tshirt_1\",\"number\":23},{\"name\":\"tshirt_2\",\"number\":0},{\"name\":\"bproof_1\",\"number\":0},{\"name\":\"decals_1\",\"number\":0},{\"name\":\"arms\",\"number\":1},{\"name\":\"shoes_1\",\"number\":7}]}]'),
(6, '[{\"label\":\"33\",\"data\":[{\"name\":\"pants_2\",\"number\":2},{\"name\":\"decals_1\",\"number\":0},{\"name\":\"shoes_2\",\"number\":1},{\"name\":\"torso_2\",\"number\":0},{\"name\":\"shoes_1\",\"number\":30},{\"name\":\"tshirt_2\",\"number\":0},{\"name\":\"tshirt_1\",\"number\":15},{\"name\":\"pants_1\",\"number\":212},{\"name\":\"bproof_2\",\"number\":0},{\"name\":\"torso_1\",\"number\":390},{\"name\":\"arms\",\"number\":0},{\"name\":\"bproof_1\",\"number\":0}]},{\"data\":[{\"name\":\"tshirt_2\",\"number\":0},{\"name\":\"pants_1\",\"number\":212},{\"name\":\"tshirt_1\",\"number\":15},{\"name\":\"torso_1\",\"number\":654},{\"name\":\"decals_1\",\"number\":0},{\"name\":\"arms\",\"number\":0},{\"name\":\"bproof_1\",\"number\":0},{\"name\":\"pants_2\",\"number\":2},{\"name\":\"shoes_2\",\"number\":1},{\"name\":\"torso_2\",\"number\":4},{\"name\":\"bproof_2\",\"number\":0},{\"name\":\"shoes_1\",\"number\":30}],\"label\":\"44\\n\"},{\"data\":[{\"name\":\"tshirt_2\",\"number\":0},{\"name\":\"pants_1\",\"number\":212},{\"name\":\"tshirt_1\",\"number\":15},{\"name\":\"torso_1\",\"number\":679},{\"name\":\"decals_1\",\"number\":0},{\"name\":\"arms\",\"number\":0},{\"name\":\"bproof_1\",\"number\":0},{\"name\":\"pants_2\",\"number\":2},{\"name\":\"shoes_2\",\"number\":1},{\"name\":\"torso_2\",\"number\":0},{\"name\":\"bproof_2\",\"number\":0},{\"name\":\"shoes_1\",\"number\":30}],\"label\":\"44\"}]'),
(20, '[{\"label\":\"1\",\"data\":[{\"number\":0,\"name\":\"decals_1\"},{\"number\":2,\"name\":\"torso_2\"},{\"number\":711,\"name\":\"torso_1\"},{\"number\":212,\"name\":\"pants_1\"},{\"number\":0,\"name\":\"bproof_2\"},{\"number\":2,\"name\":\"pants_2\"},{\"number\":15,\"name\":\"tshirt_1\"},{\"number\":30,\"name\":\"shoes_1\"},{\"number\":1,\"name\":\"shoes_2\"},{\"number\":0,\"name\":\"bproof_1\"},{\"number\":0,\"name\":\"arms\"},{\"number\":0,\"name\":\"tshirt_2\"}]}]'),
(53, '[{\"label\":\"Chic Noir\",\"data\":[{\"number\":10,\"name\":\"shoes_1\"},{\"number\":92,\"name\":\"pants_1\"},{\"number\":0,\"name\":\"bproof_2\"},{\"number\":0,\"name\":\"pants_2\"},{\"number\":0,\"name\":\"shoes_2\"},{\"number\":0,\"name\":\"decals_1\"},{\"number\":654,\"name\":\"torso_1\"},{\"number\":0,\"name\":\"arms\"},{\"number\":0,\"name\":\"bproof_1\"},{\"number\":3,\"name\":\"torso_2\"},{\"number\":15,\"name\":\"tshirt_1\"},{\"number\":0,\"name\":\"tshirt_2\"}]}]'),
(55, '[{\"label\":\"tenue sortie\",\"data\":[{\"name\":\"tshirt_1\",\"number\":15},{\"name\":\"pants_1\",\"number\":70},{\"name\":\"torso_2\",\"number\":5},{\"name\":\"tshirt_2\",\"number\":0},{\"name\":\"shoes_2\",\"number\":0},{\"name\":\"decals_1\",\"number\":0},{\"name\":\"arms\",\"number\":12},{\"name\":\"shoes_1\",\"number\":32},{\"name\":\"torso_1\",\"number\":719},{\"name\":\"pants_2\",\"number\":0},{\"name\":\"bproof_2\",\"number\":0},{\"name\":\"bproof_1\",\"number\":0}]},{\"label\":\"agent gouv\",\"data\":[{\"name\":\"tshirt_1\",\"number\":365},{\"name\":\"pants_1\",\"number\":335},{\"name\":\"shoes_1\",\"number\":126},{\"name\":\"torso_1\",\"number\":819},{\"name\":\"bproof_1\",\"number\":153},{\"name\":\"bproof_2\",\"number\":7},{\"name\":\"arms\",\"number\":1},{\"name\":\"decals_1\",\"number\":0},{\"name\":\"pants_2\",\"number\":2},{\"name\":\"shoes_2\",\"number\":0},{\"name\":\"torso_2\",\"number\":0},{\"name\":\"tshirt_2\",\"number\":0}]},{\"label\":\"tenue ceremonie \",\"data\":[{\"name\":\"tshirt_1\",\"number\":15},{\"name\":\"pants_1\",\"number\":99},{\"name\":\"shoes_1\",\"number\":10},{\"name\":\"torso_1\",\"number\":734},{\"name\":\"bproof_1\",\"number\":0},{\"name\":\"bproof_2\",\"number\":0},{\"name\":\"arms\",\"number\":84},{\"name\":\"decals_1\",\"number\":0},{\"name\":\"pants_2\",\"number\":0},{\"name\":\"shoes_2\",\"number\":0},{\"name\":\"torso_2\",\"number\":0},{\"name\":\"tshirt_2\",\"number\":0}]}]'),
(56, '[{\"label\":\"de\",\"data\":[{\"name\":\"torso_1\",\"number\":155},{\"name\":\"pants_2\",\"number\":1},{\"name\":\"decals_1\",\"number\":0},{\"name\":\"bproof_2\",\"number\":0},{\"name\":\"arms\",\"number\":3},{\"name\":\"pants_1\",\"number\":248},{\"name\":\"tshirt_1\",\"number\":9},{\"name\":\"torso_2\",\"number\":0},{\"name\":\"shoes_2\",\"number\":0},{\"name\":\"shoes_1\",\"number\":88},{\"name\":\"bproof_1\",\"number\":0},{\"name\":\"tshirt_2\",\"number\":0}]},{\"label\":\"mil\",\"data\":[{\"name\":\"arms\",\"number\":4},{\"name\":\"pants_1\",\"number\":195},{\"name\":\"bproof_2\",\"number\":0},{\"name\":\"shoes_1\",\"number\":18},{\"name\":\"torso_1\",\"number\":38},{\"name\":\"decals_1\",\"number\":0},{\"name\":\"shoes_2\",\"number\":1},{\"name\":\"bproof_1\",\"number\":0},{\"name\":\"torso_2\",\"number\":0},{\"name\":\"tshirt_1\",\"number\":1},{\"name\":\"pants_2\",\"number\":0},{\"name\":\"tshirt_2\",\"number\":0}]}]'),
(57, '[{\"label\":\"po\",\"data\":[{\"number\":1,\"name\":\"shoes_2\"},{\"number\":391,\"name\":\"tshirt_1\"},{\"number\":4,\"name\":\"tshirt_2\"},{\"number\":220,\"name\":\"shoes_1\"},{\"number\":319,\"name\":\"pants_1\"},{\"number\":0,\"name\":\"bproof_2\"},{\"number\":248,\"name\":\"torso_1\"},{\"number\":64,\"name\":\"arms\"},{\"number\":0,\"name\":\"bproof_1\"},{\"number\":7,\"name\":\"torso_2\"},{\"number\":0,\"name\":\"decals_1\"},{\"number\":0,\"name\":\"pants_2\"}]},{\"label\":\"lili\",\"data\":[{\"number\":49,\"name\":\"tshirt_1\"},{\"number\":0,\"name\":\"bproof_2\"},{\"number\":0,\"name\":\"bproof_1\"},{\"number\":0,\"name\":\"decals_1\"},{\"number\":12,\"name\":\"pants_2\"},{\"number\":226,\"name\":\"shoes_1\"},{\"number\":325,\"name\":\"pants_1\"},{\"number\":3,\"name\":\"torso_2\"},{\"number\":4,\"name\":\"shoes_2\"},{\"number\":112,\"name\":\"torso_1\"},{\"number\":64,\"name\":\"arms\"},{\"number\":0,\"name\":\"tshirt_2\"}]},{\"label\":\"bon lii\\n\",\"data\":[{\"number\":49,\"name\":\"tshirt_1\"},{\"number\":0,\"name\":\"bproof_2\"},{\"number\":0,\"name\":\"bproof_1\"},{\"number\":0,\"name\":\"decals_1\"},{\"number\":12,\"name\":\"pants_2\"},{\"number\":226,\"name\":\"shoes_1\"},{\"number\":325,\"name\":\"pants_1\"},{\"number\":3,\"name\":\"torso_2\"},{\"number\":8,\"name\":\"shoes_2\"},{\"number\":112,\"name\":\"torso_1\"},{\"number\":64,\"name\":\"arms\"},{\"number\":0,\"name\":\"tshirt_2\"}]},{\"label\":\"v\",\"data\":[{\"number\":17,\"name\":\"arms\"},{\"number\":49,\"name\":\"tshirt_1\"},{\"number\":24,\"name\":\"shoes_2\"},{\"number\":0,\"name\":\"bproof_1\"},{\"number\":3,\"name\":\"torso_2\"},{\"number\":0,\"name\":\"tshirt_2\"},{\"number\":145,\"name\":\"shoes_1\"},{\"number\":191,\"name\":\"pants_1\"},{\"number\":0,\"name\":\"decals_1\"},{\"number\":0,\"name\":\"bproof_2\"},{\"number\":292,\"name\":\"torso_1\"},{\"number\":3,\"name\":\"pants_2\"}]},{\"label\":\"bon ballas\\n\",\"data\":[{\"number\":301,\"name\":\"arms\"},{\"number\":402,\"name\":\"tshirt_1\"},{\"number\":1,\"name\":\"shoes_2\"},{\"number\":0,\"name\":\"bproof_1\"},{\"number\":5,\"name\":\"torso_2\"},{\"number\":0,\"name\":\"tshirt_2\"},{\"number\":85,\"name\":\"shoes_1\"},{\"number\":326,\"name\":\"pants_1\"},{\"number\":0,\"name\":\"decals_1\"},{\"number\":0,\"name\":\"bproof_2\"},{\"number\":685,\"name\":\"torso_1\"},{\"number\":2,\"name\":\"pants_2\"}]},{\"label\":\"on est la\\n\",\"data\":[{\"number\":302,\"name\":\"arms\"},{\"number\":49,\"name\":\"tshirt_1\"},{\"number\":0,\"name\":\"shoes_2\"},{\"number\":0,\"name\":\"bproof_1\"},{\"number\":0,\"name\":\"torso_2\"},{\"number\":0,\"name\":\"tshirt_2\"},{\"number\":222,\"name\":\"shoes_1\"},{\"number\":322,\"name\":\"pants_1\"},{\"number\":0,\"name\":\"decals_1\"},{\"number\":0,\"name\":\"bproof_2\"},{\"number\":700,\"name\":\"torso_1\"},{\"number\":2,\"name\":\"pants_2\"}]},{\"data\":[{\"number\":17,\"name\":\"arms\"},{\"number\":49,\"name\":\"tshirt_1\"},{\"number\":24,\"name\":\"shoes_2\"},{\"number\":0,\"name\":\"bproof_1\"},{\"number\":3,\"name\":\"torso_2\"},{\"number\":0,\"name\":\"tshirt_2\"},{\"number\":145,\"name\":\"shoes_1\"},{\"number\":191,\"name\":\"pants_1\"},{\"number\":0,\"name\":\"decals_1\"},{\"number\":0,\"name\":\"bproof_2\"},{\"number\":292,\"name\":\"torso_1\"},{\"number\":3,\"name\":\"pants_2\"}]},{\"data\":[{\"number\":4,\"name\":\"pants_2\"},{\"number\":64,\"name\":\"arms\"},{\"number\":1,\"name\":\"shoes_2\"},{\"number\":84,\"name\":\"shoes_1\"},{\"number\":100,\"name\":\"torso_1\"},{\"number\":0,\"name\":\"bproof_2\"},{\"number\":30,\"name\":\"pants_1\"},{\"number\":0,\"name\":\"torso_2\"},{\"number\":0,\"name\":\"tshirt_2\"},{\"number\":49,\"name\":\"tshirt_1\"},{\"number\":0,\"name\":\"bproof_1\"},{\"number\":0,\"name\":\"decals_1\"}],\"label\":\"robe step\\n\\n\"}]'),
(63, '[{\"data\":[{\"number\":0,\"name\":\"bproof_2\"},{\"number\":0,\"name\":\"arms\"},{\"number\":95,\"name\":\"torso_1\"},{\"number\":0,\"name\":\"bproof_1\"},{\"number\":220,\"name\":\"shoes_1\"},{\"number\":0,\"name\":\"decals_1\"},{\"number\":0,\"name\":\"tshirt_2\"},{\"number\":15,\"name\":\"tshirt_1\"},{\"number\":1,\"name\":\"pants_2\"},{\"number\":7,\"name\":\"torso_2\"},{\"number\":4,\"name\":\"shoes_2\"},{\"number\":315,\"name\":\"pants_1\"}],\"label\":\"AS\"}]');

-- --------------------------------------------------------

--
-- Structure de la table `player_entreprise`
--

CREATE TABLE `player_entreprise` (
  `type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `label` varchar(255) DEFAULT NULL,
  `PosVestiaire` varchar(255) DEFAULT NULL,
  `PosCustom` varchar(255) DEFAULT NULL,
  `PosCustom2` varchar(255) DEFAULT NULL,
  `PosCustom3` varchar(255) DEFAULT NULL,
  `PosBoss` varchar(255) DEFAULT NULL,
  `namerecolteitem` varchar(255) DEFAULT NULL,
  `PosRecolte` varchar(255) DEFAULT NULL,
  `nametraitementitem` varchar(255) DEFAULT NULL,
  `PosTraitement` varchar(255) DEFAULT NULL,
  `PosVente` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `player_entreprise`
--

INSERT INTO `player_entreprise` (`type`, `name`, `label`, `PosVestiaire`, `PosCustom`, `PosCustom2`, `PosCustom3`, `PosBoss`, `namerecolteitem`, `PosRecolte`, `nametraitementitem`, `PosTraitement`, `PosVente`) VALUES
('Farm', 'le_ferailleur', 'Le Férailleur', NULL, NULL, NULL, NULL, 'null', 'reco_ferrailleur', '{\"x\":-471.3713073730469,\"y\":-1692.560546875,\"z\":18.90809059143066}', 'trait_ferrailleur', '{\"x\":1060.7255859375,\"y\":-1998.80908203125,\"z\":31.01581382751465}', '{\"x\":1269.7349853515626,\"y\":-3222.6962890625,\"z\":5.90104293823242}'),
('Farm', 'petitpecheur', 'PetitPecheur', NULL, NULL, NULL, NULL, 'null', 'reco_petitpecheur', '{\"x\":-161.963134765625,\"y\":-3560.025146484375,\"z\":1.38876366615295}', 'trait_petitpecheur', '{\"x\":907.828369140625,\"y\":-1723.7042236328126,\"z\":32.15963363647461}', '{\"x\":-1038.5352783203126,\"y\":-1396.851806640625,\"z\":5.55319213867187}'),
('Farm', 'tabac', 'Tabac', NULL, NULL, NULL, NULL, 'null', 'reco_tabac', '{\"x\":2868.0263671875,\"y\":4610.85205078125,\"z\":48.1182861328125}', 'trait_tabac', '{\"x\":932.3169555664063,\"y\":-1803.5010986328126,\"z\":30.69332313537597}', '{\"x\":1276.494140625,\"y\":-3217.777099609375,\"z\":5.90104436874389}'),
('Farm', 'vangelico', 'Vangelico', NULL, NULL, NULL, NULL, 'null', 'diamant', '{\"x\":1006.6739501953125,\"y\":-1219.7052001953126,\"z\":25.13553237915039}', 'bijoux', '{\"x\":-403.7701721191406,\"y\":-2274.496826171875,\"z\":7.60825490951538}', '{\"x\":-624.5750732421875,\"y\":-231.01414489746095,\"z\":38.0570068359375}'),
('Farm', 'vigne', 'Vigneron', NULL, NULL, NULL, NULL, 'null', 'reco_vigneron', '{\"x\":-1811.5535888671876,\"y\":2210.196044921875,\"z\":91.2333984375}', 'trait_vigneron', '{\"x\":-1137.95751953125,\"y\":2686.93798828125,\"z\":18.61795806884765}', '{\"x\":-25.15570068359375,\"y\":-86.69558715820313,\"z\":57.25407409667969}');

-- --------------------------------------------------------

--
-- Structure de la table `player_fishing`
--

CREATE TABLE `player_fishing` (
  `UniqueID` int(11) DEFAULT NULL,
  `level` longtext DEFAULT 0,
  `fishList` longtext DEFAULT NULL,
  `permit` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `player_fishing`
--

INSERT INTO `player_fishing` (`UniqueID`, `level`, `fishList`, `permit`) VALUES
(1, '0', '[]', '0'),
(11, '0', '[]', '0'),
(61, '0', '[]', '0'),
(2, '57.25', '[]', '0'),
(237, '0', '[]', '0'),
(215, '0', '[]', '0'),
(376, '0', '[]', '0'),
(218, '0', '[]', '0'),
(500, '0', '[]', '0'),
(566, '0', '[]', '0'),
(505, '0', '[]', '0'),
(551, '0', '[]', '0'),
(808, '0', '[]', '0'),
(559, '0', '[]', '0'),
(579, '0', '[]', '0'),
(170, '0', '[]', '{\"fishing_ocean\":true,\"fishing_douce\":true,\"fishing_mer\":true}'),
(219, '0', '[]', '0'),
(1275, '0', '[]', '0'),
(537, '0', '[]', '0'),
(204, '0', '[]', '0'),
(571, '0', '[]', '0'),
(1222, '0', '[]', '0'),
(1256, '0', '[]', '0'),
(1339, '0', '[]', '0'),
(1236, '0', '[]', '0'),
(276, '0', '[]', '0'),
(1334, '0', '[]', '0'),
(1364, '0', '[]', '0'),
(173, '0', '[]', '0'),
(1583, '0', '[]', '0'),
(1611, '0', '[]', '0'),
(236, '0', '[]', '{\"fishing_ocean\":true}'),
(1459, '0', '[]', '0'),
(1047, '0', '[]', '0'),
(1715, '0', '[]', '0'),
(1761, '0', '[]', '{\"fishing_mer\":true}'),
(544, '0', '[]', '0'),
(343, '0', '[]', '{\"fishing_douce\":true}'),
(1838, '0', '[]', '0'),
(201, '0', '[]', '0'),
(183, '0', '[]', '0'),
(2029, '0', '[]', '0'),
(286, '0', '[]', '0'),
(1744, '0', '[]', '0');

-- --------------------------------------------------------

--
-- Structure de la table `player_gallery`
--

CREATE TABLE `player_gallery` (
  `id` int(11) NOT NULL,
  `identifier` text NOT NULL,
  `resim` text NOT NULL,
  `data` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `player_idcard`
--

CREATE TABLE `player_idcard` (
  `UID` longtext NOT NULL,
  `UniqueID` longtext NOT NULL,
  `firstname` longtext NOT NULL,
  `lastname` longtext NOT NULL,
  `dateofbirth` longtext NOT NULL,
  `sex` longtext NOT NULL,
  `height` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- --------------------------------------------------------

--
-- Structure de la table `player_inventory_clothes`
--

CREATE TABLE `player_inventory_clothes` (
  `UniqueID` int(11) NOT NULL,
  `clothes` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `player_inventory_clothes`
--

INSERT INTO `player_inventory_clothes` (`UniqueID`, `clothes`) VALUES
(1, '[{\"label\":\"test\",\"name\":\"decals_1\",\"number\":0},{\"label\":\"test\",\"name\":\"arms\",\"number\":0},{\"name\":\"tshirt_1\",\"label\":\"test\",\"number2\":0,\"number\":15},{\"label\":\"test\",\"name\":\"decals_1\",\"number\":0},{\"label\":\"test\",\"name\":\"arms\",\"number\":0},{\"name\":\"tshirt_1\",\"label\":\"test\",\"number2\":0,\"number\":15},{\"name\":\"tshirt_1\",\"label\":\"test\",\"number2\":0,\"number\":15},{\"label\":\"test\",\"name\":\"arms\",\"number\":0},{\"label\":\"test\",\"name\":\"decals_1\",\"number\":0},{\"name\":\"tshirt_1\",\"label\":\"aaaa\",\"number2\":0,\"number\":15},{\"label\":\"aaaa\",\"name\":\"decals_1\",\"number\":0},{\"label\":\"aaaa\",\"name\":\"arms\",\"number\":0},{\"name\":\"tshirt_1\",\"label\":\"aaaa\",\"number2\":0,\"number\":15},{\"label\":\"aaaa\",\"name\":\"decals_1\",\"number\":0},{\"label\":\"aaaa\",\"name\":\"arms\",\"number\":0},{\"name\":\"tshirt_1\",\"label\":\"Civil\",\"number2\":0,\"number\":15},{\"label\":\"Civil\",\"name\":\"arms\",\"number\":0},{\"label\":\"Civil\",\"name\":\"decals_1\",\"number\":0},{\"name\":\"tshirt_1\",\"label\":\"Civil\",\"number2\":0,\"number\":15},{\"label\":\"Civil\",\"name\":\"arms\",\"number\":11},{\"label\":\"Civil\",\"name\":\"decals_1\",\"number\":0},{\"label\":\"Civil\\n\",\"name\":\"decals_1\",\"number\":0},{\"label\":\"Civil\\n\",\"name\":\"arms\",\"number\":1},{\"name\":\"tshirt_1\",\"label\":\"Civil\\n\",\"number2\":0,\"number\":15},{\"name\":\"glasses_1\",\"label\":\"Lunette\",\"number2\":0,\"number\":16},{\"label\":\"Chic Noir\",\"name\":\"arms\",\"number\":0},{\"name\":\"bproof_1\",\"label\":\"Chic Noir\",\"number2\":0,\"number\":0},{\"name\":\"tshirt_1\",\"label\":\"Chic Noir\",\"number2\":0,\"number\":15},{\"label\":\"Chic Noir\",\"name\":\"decals_1\",\"number\":0},{\"name\":\"shoes_1\",\"label\":\"Chic Noir\",\"number2\":0,\"number\":10},{\"name\":\"torso_1\",\"label\":\"Chic Noir\",\"number2\":3,\"number\":654},{\"name\":\"pants_1\",\"label\":\"Chic Noir\",\"number2\":0,\"number\":92},{\"label\":\"Chic White\",\"name\":\"arms\",\"number\":8},{\"name\":\"bproof_1\",\"label\":\"Chic White\",\"number2\":0,\"number\":0},{\"name\":\"tshirt_1\",\"label\":\"Chic White\",\"number2\":0,\"number\":15},{\"label\":\"Chic White\",\"name\":\"decals_1\",\"number\":0},{\"name\":\"shoes_1\",\"label\":\"Chic White\",\"number2\":3,\"number\":93},{\"name\":\"torso_1\",\"label\":\"Chic White\",\"number2\":0,\"number\":693},{\"name\":\"pants_1\",\"label\":\"Chic White\",\"number2\":8,\"number\":92},{\"name\":\"bags_1\",\"label\":\"Test\",\"number2\":0,\"number\":125},{\"label\":\"Test\",\"name\":\"bags_1\",\"number2\":0,\"number\":119},{\"label\":\"1\",\"name\":\"bags_1\",\"number2\":0,\"number\":119},{\"label\":\"Test\",\"name\":\"bags_1\",\"number2\":0,\"number\":107}]'),
(2, '[{\"label\":\"test\",\"name\":\"glasses_1\",\"number\":56,\"number2\":0}]'),
(4, '[{\"number\":8,\"label\":\"test\",\"name\":\"arms\"},{\"number\":0,\"label\":\"test\",\"name\":\"decals_1\"},{\"number2\":0,\"number\":15,\"name\":\"tshirt_1\",\"label\":\"test\"},{\"number\":8,\"label\":\"test\",\"name\":\"arms\"},{\"number\":0,\"label\":\"test\",\"name\":\"decals_1\"},{\"number2\":0,\"number\":15,\"name\":\"tshirt_1\",\"label\":\"test\"},{\"number2\":0,\"number\":125,\"name\":\"bags_1\",\"label\":\"SACSKATE\"},{\"number\":8,\"label\":\"test\",\"name\":\"arms\"},{\"number\":0,\"label\":\"test\",\"name\":\"decals_1\"},{\"number2\":0,\"number\":15,\"label\":\"test\",\"name\":\"tshirt_1\"},{\"number2\":3,\"number\":33,\"label\":\"lunette\",\"name\":\"glasses_1\"},{\"number2\":0,\"number\":30,\"label\":\"test\",\"name\":\"shoes_1\"},{\"number\":8,\"label\":\"test\",\"name\":\"arms\"},{\"number\":0,\"label\":\"test\",\"name\":\"decals_1\"},{\"number2\":0,\"number\":15,\"label\":\"test\",\"name\":\"tshirt_1\"},{\"number2\":0,\"number\":0,\"label\":\"test\",\"name\":\"bproof_1\"},{\"number2\":3,\"number\":86,\"label\":\"test\",\"name\":\"pants_1\"},{\"number2\":0,\"number\":693,\"label\":\"test\",\"name\":\"torso_1\"}]'),
(5, '[{\"label\":\"z\",\"number\":2,\"name\":\"helmet_1\",\"number2\":0},{\"label\":\"aaa\",\"number\":11,\"name\":\"helmet_1\",\"number2\":0},{\"label\":\"1\",\"name\":\"glasses_1\",\"number\":1,\"number2\":0},{\"label\":\"1\",\"name\":\"mask_1\",\"number\":1,\"number2\":0}]'),
(6, '[{\"number2\":0,\"name\":\"bags_1\",\"number\":125,\"label\":\"3\"},{\"number2\":0,\"name\":\"glasses_1\",\"number\":20,\"label\":\"4\"},{\"number2\":0,\"name\":\"glasses_1\",\"number\":21,\"label\":\"33\\n\"}]'),
(20, '[{\"label\":\"1\",\"number\":96,\"number2\":0,\"name\":\"bags_1\"},{\"label\":\"2\\n\",\"name\":\"bags_1\",\"number2\":0,\"number\":125},{\"label\":\"3\\n\",\"number\":134,\"number2\":0,\"name\":\"bags_1\"},{\"label\":\"2\",\"name\":\"glasses_1\",\"number2\":12,\"number\":50},{\"label\":\"1\",\"number2\":12,\"number\":50,\"name\":\"glasses_1\"}]'),
(53, '[{\"number\":10,\"name\":\"shoes_1\",\"label\":\"Chic Noir\",\"number2\":0},{\"number\":92,\"name\":\"pants_1\",\"label\":\"Chic Noir\",\"number2\":0},{\"number\":0,\"name\":\"decals_1\",\"label\":\"Chic Noir\"},{\"number\":654,\"name\":\"torso_1\",\"label\":\"Chic Noir\",\"number2\":3},{\"number\":0,\"name\":\"arms\",\"label\":\"Chic Noir\"},{\"number\":0,\"name\":\"bproof_1\",\"label\":\"Chic Noir\",\"number2\":0},{\"number\":15,\"name\":\"tshirt_1\",\"label\":\"Chic Noir\",\"number2\":0},{\"number\":16,\"name\":\"glasses_1\",\"label\":\"Lunette noir\",\"number2\":5}]'),
(55, '[{\"label\":\"tenue sortie\",\"number2\":0,\"number\":15,\"name\":\"tshirt_1\"},{\"label\":\"tenue sortie\",\"number\":0,\"name\":\"decals_1\"},{\"label\":\"tenue sortie\",\"number\":12,\"name\":\"arms\"},{\"label\":\"tenue sortie\",\"number2\":0,\"number\":15,\"name\":\"tshirt_1\"},{\"label\":\"tenue sortie\",\"number\":0,\"name\":\"decals_1\"},{\"label\":\"tenue sortie\",\"number\":12,\"name\":\"arms\"},{\"label\":\"tenue sortie\",\"number2\":0,\"number\":15,\"name\":\"tshirt_1\"},{\"label\":\"tenue sortie\",\"number\":0,\"name\":\"decals_1\"},{\"label\":\"tenue sortie\",\"number\":12,\"name\":\"arms\"},{\"label\":\"tenue sortie\",\"number2\":0,\"number\":15,\"name\":\"tshirt_1\"},{\"label\":\"tenue sortie\",\"number\":0,\"name\":\"decals_1\"},{\"label\":\"tenue sortie\",\"number\":12,\"name\":\"arms\"},{\"label\":\"tenue sortie\",\"number2\":0,\"number\":15,\"name\":\"tshirt_1\"},{\"label\":\"tenue sortie\",\"number\":0,\"name\":\"decals_1\"},{\"label\":\"tenue sortie\",\"number\":12,\"name\":\"arms\"},{\"label\":\"lunette\",\"number2\":8,\"number\":62,\"name\":\"glasses_1\"},{\"number2\":0,\"number\":125,\"name\":\"bags_1\"},{\"label\":\"montre\\n\",\"number2\":0,\"number\":20,\"name\":\"watches_1\"}]'),
(56, '[{\"number2\":0,\"number\":155,\"label\":\"dead\",\"name\":\"torso_1\"},{\"number\":0,\"label\":\"dead\",\"name\":\"decals_1\"},{\"number\":3,\"label\":\"dead\",\"name\":\"arms\"},{\"number2\":1,\"number\":248,\"label\":\"dead\",\"name\":\"pants_1\"},{\"number2\":0,\"number\":360,\"label\":\"dead\",\"name\":\"tshirt_1\"},{\"number2\":0,\"number\":88,\"label\":\"dead\",\"name\":\"shoes_1\"},{\"number2\":2,\"number\":176,\"label\":\"dead\",\"name\":\"bproof_1\"},{\"number2\":0,\"number\":112,\"label\":\"sac\",\"name\":\"bags_1\"}]'),
(57, '[{\"number2\":0,\"number\":389,\"name\":\"tshirt_1\",\"label\":\"oui\\n\"},{\"number\":64,\"name\":\"arms\",\"label\":\"oui\\n\"},{\"number\":0,\"name\":\"decals_1\",\"label\":\"oui\\n\"},{\"number2\":0,\"number\":389,\"name\":\"tshirt_1\",\"label\":\"oui\\n\"},{\"number\":64,\"name\":\"arms\",\"label\":\"oui\\n\"},{\"number\":0,\"name\":\"decals_1\",\"label\":\"oui\\n\"},{\"number2\":0,\"number\":389,\"name\":\"tshirt_1\",\"label\":\"oui\\n\"},{\"number\":64,\"name\":\"arms\",\"label\":\"oui\\n\"},{\"number\":0,\"name\":\"decals_1\",\"label\":\"oui\\n\"},{\"number2\":0,\"number\":389,\"name\":\"tshirt_1\",\"label\":\"oui\\n\"},{\"number\":64,\"name\":\"arms\",\"label\":\"oui\\n\"},{\"number\":0,\"name\":\"decals_1\",\"label\":\"oui\\n\"},{\"number2\":0,\"number\":389,\"name\":\"tshirt_1\",\"label\":\"oui\\n\"},{\"number\":64,\"name\":\"arms\",\"label\":\"oui\\n\"},{\"number\":0,\"name\":\"decals_1\",\"label\":\"oui\\n\"},{\"number2\":0,\"number\":389,\"name\":\"tshirt_1\",\"label\":\"oui\\n\"},{\"number\":64,\"name\":\"arms\",\"label\":\"oui\\n\"},{\"number\":0,\"name\":\"decals_1\",\"label\":\"oui\\n\"},{\"number\":232,\"name\":\"mask_1\",\"number2\":0},{\"number\":219,\"name\":\"mask_1\",\"number2\":2},{\"number2\":14,\"number\":219,\"name\":\"mask_1\",\"label\":\"oui bon\\n\"},{\"number2\":2,\"number\":40,\"name\":\"glasses_1\",\"label\":\"gg\\n\"},{\"number2\":4,\"number\":30,\"name\":\"pants_1\",\"label\":\"oui\\n\"},{\"number2\":0,\"number\":389,\"name\":\"tshirt_1\",\"label\":\"oui\\n\"},{\"number\":64,\"name\":\"arms\",\"label\":\"oui\\n\"},{\"number2\":6,\"number\":79,\"name\":\"torso_1\",\"label\":\"oui\\n\"},{\"number\":0,\"name\":\"decals_1\",\"label\":\"oui\\n\"},{\"number2\":4,\"number\":58,\"name\":\"shoes_1\",\"label\":\"oui\\n\"},{\"number2\":4,\"number\":391,\"name\":\"tshirt_1\",\"label\":\"po\"},{\"number2\":1,\"number\":220,\"name\":\"shoes_1\",\"label\":\"po\"},{\"number2\":0,\"number\":319,\"name\":\"pants_1\",\"label\":\"po\"},{\"number2\":7,\"number\":248,\"name\":\"torso_1\",\"label\":\"po\"},{\"number\":64,\"name\":\"arms\",\"label\":\"po\"},{\"number\":0,\"name\":\"decals_1\",\"label\":\"po\"},{\"number2\":0,\"number\":38,\"name\":\"glasses_1\",\"label\":\"BON\\n\"},{\"label\":\"oui\",\"number\":107,\"name\":\"helmet_1\",\"number2\":3},{\"number2\":0,\"number\":23,\"name\":\"helmet_1\",\"label\":\"flor\"}]'),
(58, '[{\"name\":\"bags_1\",\"number2\":5,\"number\":114,\"label\":\"sac\\n\"}]');

-- --------------------------------------------------------

--
-- Structure de la table `player_isdead`
--

CREATE TABLE `player_isdead` (
  `UniqueID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `player_isdead`
--

INSERT INTO `player_isdead` (`UniqueID`) VALUES
(15),
(15);

-- --------------------------------------------------------

--
-- Structure de la table `player_jails`
--

CREATE TABLE `player_jails` (
  `UniqueID` int(11) NOT NULL,
  `time` longtext DEFAULT NULL,
  `staff` longtext DEFAULT NULL,
  `reason` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


--
-- Structure de la table `player_leboncoin`
--

CREATE TABLE `player_leboncoin` (
  `identifier` longtext DEFAULT NULL,
  `label` longtext DEFAULT NULL,
  `name` longtext DEFAULT NULL,
  `count` longtext DEFAULT NULL,
  `type` longtext DEFAULT NULL,
  `price` longtext DEFAULT NULL,
  `id` longtext DEFAULT NULL,
  `plate` longtext DEFAULT NULL,
  `vehicle` longtext DEFAULT NULL,
  `UniqueID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `player_leboncoin`
--

INSERT INTO `player_leboncoin` (`identifier`, `label`, `name`, `count`, `type`, `price`, `id`, `plate`, `vehicle`, `UniqueID`) VALUES
(NULL, 'Eau', 'water', '2', 'obj', '300', '464437', NULL, NULL, 330),
(NULL, NULL, 'Baller sport blanc jante noir', NULL, 'car', '50000', '1579917', 'CVCP9930', '{\"wheelSize\":1.0,\"modBrakes\":-1,\"model\":634118882,\"modShifterLeavers\":-1,\"color2\":0,\"color1\":111,\"modRearBumper\":-1,\"modSmokeEnabled\":false,\"modBackWheels\":-1,\"bulletProofTyres\":true,\"windowTint\":-1,\"modExhaust\":-1,\"wheels\":3,\"modSpoilers\":-1,\"modSideSkirt\":-1,\"modRoofLivery\":-1,\"modEngineBlock\":-1,\"dashboardColor\":156,\"modOrnaments\":-1,\"modStruts\":-1,\"bodyHealth\":964,\"modSuspension\":-1,\"modFrame\":-1,\"modHood\":-1,\"plateIndex\":0,\"fuelLevel\":51,\"wheelWidth\":1.0,\"modPlateHolder\":-1,\"engineHealth\":910,\"modCustomTiresF\":false,\"wheelColor\":7,\"extras\":{\"10\":1,\"12\":0},\"tyreSmokeColor\":[255,255,255],\"modCustomTiresR\":false,\"modFender\":-1,\"modAerials\":-1,\"modSpeakers\":-1,\"modLivery\":-1,\"modFrontWheels\":-1,\"modHydraulics\":false,\"modDashboard\":-1,\"modEngine\":-1,\"modVanityPlate\":-1,\"modFrontBumper\":-1,\"paintType1\":7,\"modLightbar\":-1,\"modTank\":-1,\"neonEnabled\":[false,false,false,false],\"modTrimB\":-1,\"modArchCover\":-1,\"modTurbo\":false,\"modTrimA\":-1,\"modDial\":-1,\"neonColor\":[255,0,255],\"modRoof\":-1,\"interiorColor\":8,\"modSteeringWheel\":-1,\"paintType2\":7,\"modSubwoofer\":-1,\"modHorns\":-1,\"modNitrous\":-1,\"modRightFender\":-1,\"tankHealth\":996,\"modDoorR\":-1,\"xenonColor\":255,\"tyres\":[],\"doors\":[],\"modGrille\":-1,\"modWindows\":-1,\"modArmor\":-1,\"plate\":\"CVCP9930\",\"windows\":[],\"modAirFilter\":-1,\"oilLevel\":8,\"dirtLevel\":15,\"modHydrolic\":-1,\"driftTyres\":false,\"modDoorSpeaker\":-1,\"modTrunk\":-1,\"modXenon\":false,\"modAPlate\":-1,\"modTransmission\":-1,\"modSeats\":-1,\"pearlescentColor\":2}', 808),
(NULL, 'Pain', 'bread', '1', 'obj', '100000', '650902', NULL, NULL, 166);

-- --------------------------------------------------------

--
-- Structure de la table `player_livraisons`
--

CREATE TABLE `player_livraisons` (
  `uniqueid` int(11) NOT NULL,
  `levels` int(11) DEFAULT 0,
  `gains` int(11) NOT NULL DEFAULT 100,
  `livraisons` int(11) DEFAULT 0,
  `vehicle` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `player_livraisons`
--

INSERT INTO `player_livraisons` (`uniqueid`, `levels`, `gains`, `livraisons`, `vehicle`) VALUES
(1, 0, 100, 0, '[\"boxville\"]'),
(6, 0, 100, 0, '[\"boxville\"]');

-- --------------------------------------------------------

--
-- Structure de la table `player_ltdsales`
--

CREATE TABLE `player_ltdsales` (
  `uid` int(11) NOT NULL,
  `job` longtext NOT NULL,
  `u` longtext DEFAULT NULL,
  `d` longtext DEFAULT NULL,
  `night` longtext NOT NULL,
  `day` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `player_ltdsales`
--

INSERT INTO `player_ltdsales` (`uid`, `job`, `u`, `d`, `night`, `day`) VALUES
(4, 'ltd_f4l', NULL, NULL, '{\"sales\":1,\"amount\":1000}', '{\"amount\":500,\"sales\":1}'),
(8, 'ltd_ballas', NULL, NULL, '{\"sales\":1,\"amount\":150}', '{\"sales\":0,\"amount\":0}'),
(173, 'ltd_littleseoul', NULL, NULL, '{\"sales\":1,\"amount\":500}', '{\"sales\":1,\"amount\":5600}'),
(194, 'ltd_littleseoul', NULL, NULL, '{\"amount\":6100,\"sales\":3}', '{\"amount\":0,\"sales\":0}'),
(199, 'ltd_littleseoul', NULL, NULL, '{\"amount\":1200,\"sales\":1}', '{\"amount\":0,\"sales\":0}'),
(201, 'ltd_littleseoul', NULL, NULL, '{\"sales\":2,\"amount\":9050}', '{\"sales\":1,\"amount\":7200}'),
(214, 'ltd_ballas', NULL, NULL, '{\"amount\":800,\"sales\":2}', '{\"sales\":5,\"amount\":17130}'),
(221, 'ltd_littleseoul', NULL, NULL, '{\"sales\":1,\"amount\":1000}', '{\"sales\":1,\"amount\":500}'),
(276, 'ltd_ballas', NULL, NULL, '{\"sales\":0,\"amount\":0}', '{\"sales\":5,\"amount\":17280}'),
(286, 'ltd_littleseoul', NULL, NULL, '{\"sales\":3,\"amount\":24050}', '{\"amount\":750,\"sales\":1}'),
(515, 'ltd_ballas', NULL, NULL, '{\"sales\":0,\"amount\":0}', '{\"sales\":1,\"amount\":750}'),
(624, 'ltd_ballas', NULL, NULL, '{\"sales\":0,\"amount\":0}', '{\"sales\":1,\"amount\":1000}'),
(816, 'ltd_littleseoul', NULL, NULL, '{\"amount\":0,\"sales\":0}', '{\"amount\":3000,\"sales\":1}'),
(1275, 'ltd_f4l', NULL, NULL, '{\"sales\":2,\"amount\":250}', '{\"amount\":4330,\"sales\":3}'),
(1459, 'ltd_f4l', NULL, NULL, '{\"sales\":2,\"amount\":550}', '{\"amount\":84330,\"sales\":4}'),
(1515, 'ltd_f4l', NULL, NULL, '{\"amount\":0,\"sales\":0}', '{\"amount\":50,\"sales\":1}'),
(1624, 'ltd_f4l', NULL, NULL, '{\"sales\":0,\"amount\":0}', '{\"sales\":1,\"amount\":2000}'),
(1682, 'ltd_f4l', NULL, NULL, '{\"sales\":1,\"amount\":1640}', '{\"sales\":0,\"amount\":0}'),
(1715, 'ltd_f4l', NULL, NULL, '{\"amount\":5000,\"sales\":1}', '{\"sales\":4,\"amount\":64330}'),
(1744, 'ltd_littleseoul', NULL, NULL, '{\"sales\":1,\"amount\":50}', '{\"sales\":0,\"amount\":0}'),
(1779, 'ltd_f4l', NULL, NULL, '{\"sales\":0,\"amount\":0}', '{\"sales\":1,\"amount\":50}'),
(1852, 'ltd_littleseoul', NULL, NULL, '{\"amount\":0,\"sales\":0}', '{\"amount\":600,\"sales\":1}'),
(1889, 'ltd_f4l', NULL, NULL, '{\"amount\":500,\"sales\":1}', '{\"amount\":0,\"sales\":0}'),
(1894, 'ltd_f4l', NULL, NULL, '{\"amount\":0,\"sales\":0}', '{\"amount\":200,\"sales\":1}'),
(2045, 'ltd_f4l', NULL, NULL, '{\"amount\":200,\"sales\":1}', '{\"amount\":0,\"sales\":0}');

-- --------------------------------------------------------

--
-- Structure de la table `playlists`
--

CREATE TABLE `playlists` (
  `id` int(11) NOT NULL,
  `label` varchar(60) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `playlist_songs`
--

CREATE TABLE `playlist_songs` (
  `id` int(11) NOT NULL,
  `playlist` int(11) DEFAULT NULL,
  `link` varchar(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `playlist_songs`
--

INSERT INTO `playlist_songs` (`id`, `playlist`, `link`) VALUES
(26, 0, 'https://www.youtube.com/watch?v=EYAjqqWuBxg'),
(28, 0, 'https://www.youtube.com/watch?v=yXeJ8ZRActM'),
(32, 50, 'https://www.youtube.com/watch?v=CYgDUBH2Zro'),
(34, 54, 'https://www.youtube.com/watch?v=vGp4TwRNtFY&list=RDMM&start_radio=1');

-- --------------------------------------------------------

--
-- Structure de la table `police_plainte`
--

CREATE TABLE `police_plainte` (
  `id` int(11) NOT NULL,
  `name` longtext DEFAULT NULL,
  `date` text DEFAULT NULL,
  `numberphone` text DEFAULT NULL,
  `reason` longtext DEFAULT NULL,
  `author` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `police_plainte`
--

INSERT INTO `police_plainte` (`id`, `name`, `date`, `numberphone`, `reason`, `author`) VALUES
(1, 'd', '12222', 'd', 'j\'essais !', 'Valentin Agl');

-- --------------------------------------------------------

--
-- Structure de la table `properties`
--

CREATE TABLE `properties` (
  `propertiesID` int(11) NOT NULL,
  `name` longtext DEFAULT NULL,
  `label` longtext DEFAULT NULL,
  `propertiesOWNER` longtext DEFAULT NULL,
  `ownerName` longtext DEFAULT NULL,
  `enter` varchar(255) DEFAULT NULL,
  `exit` varchar(255) DEFAULT NULL,
  `garage` tinyint(1) UNSIGNED ZEROFILL DEFAULT 0,
  `garagePos` varchar(255) DEFAULT NULL,
  `garageSpawn` varchar(255) DEFAULT NULL,
  `garageRotation` varchar(255) DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `garageType` longtext DEFAULT NULL,
  `players` longtext DEFAULT '{}',
  `type` longtext DEFAULT NULL,
  `trunk` longtext DEFAULT NULL,
  `trunkPos` varchar(255) DEFAULT NULL,
  `logementType` longtext DEFAULT NULL,
  `time` int(11) UNSIGNED ZEROFILL DEFAULT NULL,
  `street` longtext DEFAULT NULL,
  `entrepot` tinyint(4) DEFAULT NULL,
  `pound` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `properties`
--

INSERT INTO `properties` (`propertiesID`, `name`, `label`, `propertiesOWNER`, `ownerName`, `enter`, `exit`, `garage`, `garagePos`, `garageSpawn`, `garageRotation`, `price`, `garageType`, `players`, `type`, `trunk`, `trunkPos`, `logementType`, `time`, `street`, `entrepot`, `pound`) VALUES
(6, 'Test10', 'test10', '1', 'NEOJIM', '{\"x\":-149.31414794921876,\"y\":-888.809814453125,\"z\":29.31801033020019}', '{\"x\":151.7301025390625,\"y\":-1007.4360961914063,\"z\":-99.0000991821289}', 0, '[]', '[]', '0', 80000, 'none', '{\"1\":false}', 'achat', '{\"weapons\":[],\"items\":[],\"code\":{\"active\":false,\"blocked\":false},\"accounts\":{\"black_money\":0,\"cash\":0}}', '{\"x\":152.10208129882813,\"y\":-1000.234619140625,\"z\":-98.99959564208985}', 'Motel', NULL, 'Pillbox Hill', 0, 0);

-- --------------------------------------------------------

--
-- Structure de la table `properties_access`
--

CREATE TABLE `properties_access` (
  `id_access` int(11) NOT NULL,
  `identifier` varchar(50) DEFAULT NULL,
  `label` varchar(50) DEFAULT NULL,
  `id_property` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `properties_list`
--

CREATE TABLE `properties_list` (
  `id_property` int(11) NOT NULL,
  `property_name` varchar(50) NOT NULL,
  `property_pos` varchar(100) DEFAULT NULL,
  `property_chest` varchar(50) DEFAULT NULL,
  `property_type` varchar(50) DEFAULT NULL,
  `property_price` int(11) DEFAULT NULL,
  `property_status` varchar(50) DEFAULT 'free',
  `property_owner` varchar(50) DEFAULT NULL,
  `garage_pos` varchar(100) DEFAULT NULL,
  `garage_max` int(11) DEFAULT NULL,
  `jobs` varchar(50) DEFAULT NULL,
  `orga` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `properties_news`
--

CREATE TABLE `properties_news` (
  `id` int(11) NOT NULL,
  `name` longtext DEFAULT NULL,
  `label` longtext DEFAULT NULL,
  `owner` int(11) DEFAULT NULL,
  `ownerName` longtext DEFAULT NULL,
  `positions` longtext DEFAULT NULL,
  `garage` longtext DEFAULT NULL,
  `entrepot` longtext DEFAULT NULL,
  `location` longtext DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `players` longtext DEFAULT '[]',
  `informations` longtext DEFAULT NULL,
  `colocations` longtext DEFAULT NULL,
  `chest` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `properties_vehicles`
--

CREATE TABLE `properties_vehicles` (
  `propertyID` int(11) DEFAULT NULL,
  `plate` varchar(50) DEFAULT NULL,
  `data_vehicle` longtext NOT NULL,
  `stored` int(11) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `property_created`
--

CREATE TABLE `property_created` (
  `propertyID` int(11) NOT NULL,
  `owner` varchar(255) DEFAULT NULL,
  `label` varchar(255) DEFAULT NULL,
  `price` varchar(255) DEFAULT NULL,
  `pNumber` varchar(255) DEFAULT NULL,
  `pEnterPos` varchar(255) DEFAULT NULL,
  `gEnterPos` varchar(255) DEFAULT NULL,
  `gPlaces` varchar(255) DEFAULT NULL,
  `stockCapacity` varchar(255) DEFAULT NULL,
  `dateRented` varchar(255) DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL,
  `pInventory` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '{}',
  `pVehicules` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '{}',
  `pKeys` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '{}'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `radiocar_music`
--

CREATE TABLE `radiocar_music` (
  `id` int(11) NOT NULL,
  `label` varchar(64) NOT NULL,
  `url` varchar(256) NOT NULL,
  `plate` varchar(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Déchargement des données de la table `radiocar_music`
--

INSERT INTO `radiocar_music` (`id`, `label`, `url`, `plate`) VALUES
(1, 'FF', 'https://www.youtube.com/watch?v=SKT-D99sZ5w', 'ONAO3071'),
(2, 'Gazo - WAYANS', 'https://www.youtube.com/watch?v=42K-xivGn4Q', 'QUBU7581'),
(3, 'Gazo - NANANI NANANA', 'https://www.youtube.com/watch?v=8Bkgi6yB6P8', 'QUBU7581'),
(4, 'GAZO - CELINE 3x', 'https://www.youtube.com/watch?v=wWblPXLnv6k', 'QUBU7581'),
(5, 'Freeze Corleone 667 - Freeze Raël', 'https://www.youtube.com/watch?v=oJ5PfRQB93o', 'QUBU7581'),
(6, 'GAZO x Tiakola - Kassav', 'https://www.youtube.com/watch?v=zNEU9VExoWE', 'QUBU7581'),
(7, 'Werenoi - Pétunias (Clip Officiel)', 'https://www.youtube.com/watch?v=n2THLWjJ3Wo', 'QUBU7581'),
(8, 'Gazo - WAYANS', 'https://www.youtube.com/watch?v=42K-xivGn4Q', 'ZQNY8807'),
(9, 'Gazo - NANANI NANANA', 'https://www.youtube.com/watch?v=8Bkgi6yB6P8', 'ZQNY8807'),
(10, 'GAZO - CELINE 3x', 'https://www.youtube.com/watch?v=wWblPXLnv6k', 'ZQNY8807'),
(11, 'Freeze Corleone 667 - Freeze Raël', 'https://www.youtube.com/watch?v=oJ5PfRQB93o', 'ZQNY8807'),
(12, 'GAZO x Tiakola - Kassav', 'https://www.youtube.com/watch?v=zNEU9VExoWE', 'ZQNY8807'),
(13, 'Werenoi - Pétunias (Clip Officiel)', 'https://www.youtube.com/watch?v=n2THLWjJ3Wo', 'ZQNY8807'),
(14, 'UZI  - 50G feat @jksnofficiel (Clip officiel)', 'https://www.youtube.com/watch?v=yEcxzdugtps', 'YHAN2265'),
(15, 'SDM - MERCI (Clip Officiel)', 'https://www.youtube.com/watch?v=DF3UfgKdFjA', 'YHAN2265'),
(16, 'Tiakola - Manon B feat. Ryflo, Oskoow & MC Cebezinho (Clip offic', 'https://www.youtube.com/watch?v=v0duI6_MxR0', 'YHAN2265'),
(17, 'CENTRAL CEE X JRK 19 - BOLIDE NOIR (MUSIC VIDEO)', 'https://www.youtube.com/watch?v=i8Iy7F1rQic', 'YHAN2265'),
(18, 'SDM - CARTIER SANTOS (Visualizer Officiel)', 'https://www.youtube.com/watch?v=3nGdVePdlT4', 'YHAN2265'),
(19, 'Tiakola - T.I.A | A COLORS SHOW', 'https://www.youtube.com/watch?v=vaeio3idHzU', 'YHAN2265'),
(20, 'Leto - J\'crois qu\'ils ont pas compris (Clip officiel)', 'https://www.youtube.com/watch?v=QXgJrYO9Sto', 'YHAN2265'),
(21, 'Gambi - Tentation feat. Hamza', 'https://www.youtube.com/watch?v=wbtFMQCskIs', 'YHAN2265'),
(22, 'Werenoi - Pétunias (Clip Officiel)', 'https://www.youtube.com/watch?v=n2THLWjJ3Wo', 'YHAN2265'),
(23, 'K2S - Dougie (Paroles)', 'https://www.youtube.com/watch?v=Ib9RgAVMngA', 'YHAN2265'),
(24, 'SDM - POUR ELLE (Visualizer Officiel)', 'https://www.youtube.com/watch?v=eYG5Qg6RCyE', 'YHAN2265'),
(25, 'YORSSY - CRF [Official Video]', 'https://www.youtube.com/watch?v=aemW1vYld-Q', 'YHAN2265'),
(26, 'GENEZIO - EL GEMANO (feat. LA MANO 1.9)', 'https://www.youtube.com/watch?v=UUupGl80JeU', 'YHAN2265'),
(27, 'Booba - Dolce Camara ft. SDM (Clip Vidéo)', 'https://www.youtube.com/watch?v=1y7o32utVts', 'YHAN2265'),
(28, 'DADI - BAH OUAIS (Clip Officiel)', 'https://www.youtube.com/watch?v=p48ac4UNa7w', 'YHAN2265'),
(29, 'Werenoi Ft. SDM - Dans un verre (Clip Officiel)', 'https://www.youtube.com/watch?v=FjR2kJTbslQ', 'YHAN2265'),
(30, 'Kerchak - Saison 2 (Clip Officiel)', 'https://www.youtube.com/watch?v=V-FFXqIiOLI', 'YHAN2265'),
(31, 'Koba LaD - Un peu d\'amour', 'https://www.youtube.com/watch?v=84034w0UhxI', 'YHAN2265'),
(32, 'UZI - Gars du Zoo (Clip officiel)', 'https://www.youtube.com/watch?v=w2MwXVuzVXI', 'YHAN2265'),
(33, 'JKSN- Christian Dior', 'https://www.youtube.com/watch?v=87yeX-oyhHs', 'YHAN2265'),
(34, 'Rsko - BOOM BOOM (Feat. IDS)', 'https://www.youtube.com/watch?v=A7vDevMb3Sc', 'YHAN2265'),
(35, 'DA Uzi - Michael Jordan (Clip officiel)', 'https://www.youtube.com/watch?v=PHYSEaCH0hM', 'YHAN2265'),
(36, 'TIAKOLA - X', 'https://www.youtube.com/watch?v=IiNRgiWgDAk', 'YHAN2265'),
(37, 'VEN1 - HAKAYET', 'https://www.youtube.com/watch?v=wszBopxvprg', 'YHAN2265'),
(38, 'UZI -  Panama feat @SDM92  (Lyrics Video)', 'https://www.youtube.com/watch?v=pqmyjq_M2bA', 'YHAN2265'),
(39, 'Djadja & Dinaz - Miss France [Lyrics Video]', 'https://www.youtube.com/watch?v=BxFYk5RpT9g', 'YHAN2265'),
(40, 'BOOBA - DOLCE CAMARA (SNIGHT B REMIX)', 'https://www.youtube.com/watch?v=u-n7l0WorGY', 'YHAN2265'),
(41, 'Werenoi (ft. Hamza) - Maudit (Visualizer)', 'https://www.youtube.com/watch?v=GFqbhQULYik', 'YHAN2265'),
(42, 'Bouss - Parler tout bas (Clip Officiel)', 'https://www.youtube.com/watch?v=CWcEv17US4A', 'YHAN2265'),
(43, 'Djadja & Dinaz - LA MÊME HISTOIRE [Clip Officiel]', 'https://www.youtube.com/watch?v=xdTnSAdO_lY', 'YHAN2265'),
(44, 'GAZO x @TiakolaOfficiel - 300K', 'https://www.youtube.com/watch?v=5T6ccvAn5n4', 'YHAN2265'),
(45, 'PLK Feat. Gazo - Ça mène à rien (clip officiel)', 'https://www.youtube.com/watch?v=9bbl18W63Mg', 'YHAN2265'),
(46, 'PLK feat. JUL - Faut pas (clip officiel)', 'https://www.youtube.com/watch?v=y0J3vX9zuYo', 'YHAN2265'),
(47, 'GAZO x @TiakolaOfficiel - CARTIER', 'https://www.youtube.com/watch?v=QzZflH4liuU', 'YHAN2265'),
(48, 'Werenoi (ft. Damso) - Pyramide (Clip Officiel)', 'https://www.youtube.com/watch?v=EXYj9wecau4', 'YHAN2265'),
(49, 'weed', 'https://www.youtube.com/watch?v=Sy-it14Duk4', 'TFTV2985'),
(50, 'MICRO MAFIA MAES ', 'https://www.youtube.com/watch?v=xK-rxiKd2D4', '69RBC015'),
(51, 'mix musique ', 'https://www.youtube.com/watch?v=X4oh8q_U2Eg', '88MZI283'),
(52, 'GITANE', 'https://youtu.be/lj-KSQ9J1Bs?si=koB0fUgosJXN2VIe', 'DHCE4687'),
(53, 'Capata', 'https://youtu.be/wCzUYYAl39c?si=BhnFN_5X2KEeLoxm', '43MYQ847'),
(54, 'un jour je l\'aurai', 'https://youtu.be/bdxaG9KMnc4?si=kX12ypnbO-Xryu0q', '43MYQ847'),
(55, 'je veux que toi', 'https://youtu.be/w3VOe5uP2EE?si=xv0fpWHq_q9-cV87', '43MYQ847'),
(56, 'Vent', 'https://youtu.be/wszBopxvprg?si=iZWkaCqeXrCBjB7f', 'TAYF0419'),
(57, 'sd night', 'https://youtu.be/6vNq-TcCRjo?si=jbxodcT18KfwCl86', 'TAYF0419'),
(58, 'Rocky', 'https://www.youtube.com/watch?v=fginctlIgFQ', 'JRPD1171'),
(59, 'Damso Alpha', 'https://www.youtube.com/watch?v=wMCJladUYGQ', 'JRPD1171'),
(60, 'INK ENCRE', 'https://youtu.be/onzULMt9VOE', 'LJGP6738'),
(61, 'Ink Encre CARTEL', 'https://youtu.be/a4zhfiryo_o?list=PLf1HbsxUn6ytQz8PEeh0J-MLh3DdOHyBD', 'LJGP6738'),
(62, 'encre noir', 'https://youtu.be/x0T3f1fcO84?list=RDQM2h62NGs-xGo', 'LJGP6738'),
(63, 'EL diablo ', 'https://www.youtube.com/watch?v=25M6ygkUGcU', 'LJGP6738'),
(64, 'Intro Lucifer', 'https://www.youtube.com/watch?v=HKtsdZs9LJo&ab_channel=CageTheElephantVEVO', 'SXZJ2790'),
(65, 'Carry on my wayward son - KANSAS', 'https://www.youtube.com/watch?v=P5ZJui3aPoQ&ab_channel=kansasVEVO', 'SXZJ2790'),
(66, 'ACDC - Thunderstruck', 'https://youtu.be/v2AC41dglnM?si=4yj5y-VgZt1xfpey', 'SXZJ2790'),
(67, 'ACDC - Back in black', 'https://youtu.be/pAgnJDJN4VA?si=0OTzrgEAOH3b7Hvh', 'SXZJ2790'),
(68, 'Mouloud Kefta - Hayette', 'https://www.youtube.com/watch?v=h9BAyYPUdN8', 'SXZJ2790'),
(69, 'GDK - LA PREGUNTA', 'https://www.youtube.com/watch?v=wZC7rhRqxlc', 'SXZJ2790'),
(70, '[LS CONFIDENTIAL] PILLS - MA DAME FEAT. LUNA', 'https://www.youtube.com/watch?v=aTmVlfqmh-s', 'SXZJ2790'),
(71, 'BALLAS GANG - Monotone', 'https://www.youtube.com/watch?v=Ai1_CjnDJ3E', 'SXZJ2790'),
(72, 'BLK - VIE D\'ARTISTE', 'https://www.youtube.com/watch?v=J9HqnORyZdk', 'SXZJ2790'),
(73, 'PRIME - SOMME', 'https://www.youtube.com/watch?v=ITCDJ_XQDs0', 'SXZJ2790'),
(74, 'ELÉA - INSTABILITÉ', 'https://www.youtube.com/watch?v=DF7FIuJ4c_A', 'SXZJ2790'),
(75, 'BLK - INTRO', 'https://www.youtube.com/watch?v=NTm11sGiieI', 'SXZJ2790'),
(76, '[LSCONFIDENTIAL] BAX x Brams - F4L', 'https://www.youtube.com/watch?v=SOtM2BVcIiE', 'SXZJ2790'),
(77, 'AZUL RECORD - LA FIN ! [LS Confidential]', 'https://www.youtube.com/watch?v=hv2qWiBsM0A', 'SXZJ2790'),
(78, '[LS CONFIDENTIAL] PILLS - W33D FEAT. L\'AMEHANTABLE', 'https://www.youtube.com/watch?v=pAP0tbtPm1A', 'SXZJ2790'),
(79, '[LS CONFIDENTIAL] James Snow - LSHD', 'https://www.youtube.com/watch?v=1MHmMYKl0fk', 'SXZJ2790'),
(80, 'GDK - GUERILLA', 'https://www.youtube.com/watch?v=mEA6pLnnOls', 'SXZJ2790'),
(81, 'GDK - OUARZAZATE', 'https://www.youtube.com/watch?v=8Sl1NjVVDSM', 'SXZJ2790'),
(82, 'GDK - SUR ECOUTE', 'https://www.youtube.com/watch?v=4Va_yc-1eCU', 'SXZJ2790'),
(83, 'GDK - RAPHANUS #1', 'https://www.youtube.com/watch?v=H3o1ASXITI8', 'SXZJ2790'),
(84, '[LSCONFIDENTIAL] BAX - SANS SUITE', 'https://www.youtube.com/watch?v=k7xGdA4UWy0', 'SXZJ2790'),
(85, 'FLEECA - LES COEURS BRISES FEAT.MARV & MISSS', 'https://www.youtube.com/watch?v=sMgT-8zrcYw', 'SXZJ2790'),
(86, 'RICO - PRIMO FEAT. ALMA', 'https://www.youtube.com/watch?v=JwBVVn9I3ao', 'SXZJ2790'),
(87, 'FLEECA  - BALLAS BALLAS (Prod. by Gravy Beats)', 'https://www.youtube.com/watch?v=mDKDhdBlhHw', 'SXZJ2790'),
(88, '[LS CONFIDENTIAL] PILLS - FAMILIES GVNG FEAT. PRIME', 'https://www.youtube.com/watch?v=OCormTREEtE', 'SXZJ2790'),
(89, 'L\'amitié - L feat B.O.B [LS.CONFIDENTIAL]', 'https://www.youtube.com/watch?v=89w3PQDBhng', 'SXZJ2790'),
(90, 'PRIME - MASSA', 'https://www.youtube.com/watch?v=s41VfmQIRmM', 'SXZJ2790'),
(91, 'BLK - BIG DREAMS', 'https://www.youtube.com/watch?v=eL0qVTir27s', 'SXZJ2790'),
(92, 'MALEK - LE SANG COULE', 'https://www.youtube.com/watch?v=20PHWEhUbK8', 'SXZJ2790'),
(93, 'GDK - AH BON', 'https://www.youtube.com/watch?v=MdZAi6MS_Ig', 'SXZJ2790'),
(94, 'Mathieu Khanez', 'https://www.youtube.com/watch?v=F9ynDgj1iUc&list=RDMM&start_radio=1&ab_channel=SBKalash', 'SXZJ2790'),
(95, 'Chassé-croisé', 'https://www.youtube.com/watch?v=QMZ0HfOjCqY', 'TNTT8081'),
(96, 'Ziak - Fixette (Prod. Focus Beatz)', 'https://www.youtube.com/watch?v=xk1c02v3U_U', 'TNTT8081'),
(97, 'BEN plg feat. Georgio - Colorier des HLM (prod. Lucci\')', 'https://www.youtube.com/watch?v=3uWK_UtzIqc', 'TNTT8081'),
(98, 'Grabba', 'https://www.youtube.com/watch?v=pos7SwbEXoI', 'TNTT8081'),
(99, 'Ziak - Akimbo (Prod. Focus Beatz X Hellboy)', 'https://www.youtube.com/watch?v=cojoYPRcIJA', 'TNTT8081'),
(100, 'Zamdane - Chanel', 'https://www.youtube.com/watch?v=vfDPuyib5hs', 'TNTT8081'),
(101, 'Désolé', 'https://www.youtube.com/watch?v=tLWKFeP52BI', 'TNTT8081'),
(102, 'Op Ganté', 'https://www.youtube.com/watch?v=YAc4knLIP98', 'TNTT8081'),
(103, 'KAROL G - Si Antes Te Hubiera Conocido | Coke Studio', 'https://www.youtube.com/watch?v=_ogD5wloeHw', 'TNTT8081'),
(104, 'NANANI NANANA', 'https://www.youtube.com/watch?v=sxDWEwG4hYk', 'TNTT8081'),
(105, 'Ziak - Vautours Feat @KobaLaDOfficiel  (Prod. Lowonstage)', 'https://www.youtube.com/watch?v=DbzM4xjC3zc', 'TNTT8081'),
(106, 'Effet mer', 'https://www.youtube.com/watch?v=oFnKrCG2Oq8', 'TNTT8081'),
(107, 'Même pas un grincement', 'https://www.youtube.com/watch?v=JHWjG0xLX20', 'TNTT8081'),
(108, 't\'appelles ça vivre ?', 'https://www.youtube.com/watch?v=aQ7WYcEJ7DY', 'TNTT8081'),
(109, 'Ziak - Galerie (Prod. Devil)', 'https://www.youtube.com/watch?v=4vPb_VNSWrc', 'TNTT8081'),
(110, 'Kerchak - FAKE (Clip Officiel)', 'https://www.youtube.com/watch?v=lnMFUFCbLkM', 'TNTT8081'),
(111, 'La plage', 'https://www.youtube.com/watch?v=n6cKpNFLmvY', 'TNTT8081'),
(112, 'Raspoutine', 'https://www.youtube.com/watch?v=kIm4yixG3-g', 'TNTT8081'),
(113, 'CAM', 'https://www.youtube.com/watch?v=oxyYtOfOwWo', 'TNTT8081'),
(114, 'KAROL G, Feid, DFZM ft. Ovy On The Drums, J Balvin, Maluma, Ryan', 'https://www.youtube.com/watch?v=3PDFqUiqZA8', 'TNTT8081'),
(115, 'Lumière blanche (Ad Finem)', 'https://www.youtube.com/watch?v=y_e6RKM6NBk', 'TNTT8081'),
(116, 'BEENDO Z - PAS BÊTE', 'https://www.youtube.com/watch?v=DWzekLgB0Oo', 'TNTT8081'),
(117, 'Werenoi - Pétunias (Clip Officiel)', 'https://www.youtube.com/watch?v=n2THLWjJ3Wo', 'TNTT8081'),
(118, 'VEN1 - MENACE FANTOME', 'https://www.youtube.com/watch?v=T2qp30KXVik', 'TNTT8081'),
(119, 'Ormaz - OZ feat. Zeu', 'https://www.youtube.com/watch?v=t3h2TTKQMYE', 'TNTT8081'),
(120, 'Booba - Freestyle CKO', 'https://www.youtube.com/watch?v=Z9KmCBd7tWw', 'TNTT8081'),
(121, 'Passement de jambes', 'https://www.youtube.com/watch?v=6QHU6hPskQM', 'TNTT8081'),
(122, 'BLESSD ❌ ANUEL AA | MIRAME REMIX (VIDEO OFICIAL)', 'https://www.youtube.com/watch?v=uHWFuICiEns', 'TNTT8081'),
(123, 'SDM - BOLIDE ALLEMAND 1/2 (Clip Officiel)', 'https://www.youtube.com/watch?v=WcX37NouKxw', 'TNTT8081'),
(124, 'A$AP', 'https://www.youtube.com/watch?v=DD7VvVUILps', 'TNTT8081'),
(125, 'Dolce Camara', 'https://www.youtube.com/watch?v=AgFG6_TGdTY', 'TNTT8081'),
(126, 'SCH - Stigmates', 'https://www.youtube.com/watch?v=ji2lbYIB1gI', 'TNTT8081'),
(127, 'EXTRAMILES (feat. Jolagreen23)', 'https://www.youtube.com/watch?v=1LBvpxCd4TY', 'TNTT8081'),
(128, 'CARTIER SANTOS', 'https://www.youtube.com/watch?v=l5ylz9fhcbM', 'TNTT8081'),
(129, 'Chassé-croisé', 'https://www.youtube.com/watch?v=QMZ0HfOjCqY', 'IXWX4711'),
(130, 'Grabba', 'https://www.youtube.com/watch?v=pos7SwbEXoI', 'IXWX4711'),
(131, 'BEN plg feat. Georgio - Colorier des HLM (prod. Lucci\')', 'https://www.youtube.com/watch?v=3uWK_UtzIqc', 'IXWX4711'),
(132, 'Kerchak - FAKE (Clip Officiel)', 'https://www.youtube.com/watch?v=lnMFUFCbLkM', 'IXWX4711'),
(133, 'Ziak - Fixette (Prod. Focus Beatz)', 'https://www.youtube.com/watch?v=xk1c02v3U_U', 'IXWX4711'),
(134, 'Zamdane - Chanel', 'https://www.youtube.com/watch?v=vfDPuyib5hs', 'IXWX4711'),
(135, 'Désolé', 'https://www.youtube.com/watch?v=tLWKFeP52BI', 'IXWX4711'),
(136, 'Op Ganté', 'https://www.youtube.com/watch?v=YAc4knLIP98', 'IXWX4711'),
(137, 'KAROL G - Si Antes Te Hubiera Conocido | Coke Studio', 'https://www.youtube.com/watch?v=_ogD5wloeHw', 'IXWX4711'),
(138, 'Ziak - Akimbo (Prod. Focus Beatz X Hellboy)', 'https://www.youtube.com/watch?v=cojoYPRcIJA', 'IXWX4711'),
(139, 'Ziak - Vautours Feat @KobaLaDOfficiel  (Prod. Lowonstage)', 'https://www.youtube.com/watch?v=DbzM4xjC3zc', 'IXWX4711'),
(140, 'Effet mer', 'https://www.youtube.com/watch?v=oFnKrCG2Oq8', 'IXWX4711'),
(141, 'NANANI NANANA', 'https://www.youtube.com/watch?v=sxDWEwG4hYk', 'IXWX4711'),
(142, 't\'appelles ça vivre ?', 'https://www.youtube.com/watch?v=aQ7WYcEJ7DY', 'IXWX4711'),
(143, 'Même pas un grincement', 'https://www.youtube.com/watch?v=JHWjG0xLX20', 'IXWX4711'),
(144, 'Ormaz - OZ feat. Zeu', 'https://www.youtube.com/watch?v=t3h2TTKQMYE', 'IXWX4711'),
(145, 'La plage', 'https://www.youtube.com/watch?v=n6cKpNFLmvY', 'IXWX4711'),
(146, 'Ziak - Galerie (Prod. Devil)', 'https://www.youtube.com/watch?v=4vPb_VNSWrc', 'IXWX4711'),
(147, 'CAM', 'https://www.youtube.com/watch?v=oxyYtOfOwWo', 'IXWX4711'),
(148, 'KAROL G, Feid, DFZM ft. Ovy On The Drums, J Balvin, Maluma, Ryan', 'https://www.youtube.com/watch?v=3PDFqUiqZA8', 'IXWX4711'),
(149, 'Raspoutine', 'https://www.youtube.com/watch?v=kIm4yixG3-g', 'IXWX4711'),
(150, 'Lumière blanche (Ad Finem)', 'https://www.youtube.com/watch?v=y_e6RKM6NBk', 'IXWX4711'),
(151, 'Werenoi - Pétunias (Clip Officiel)', 'https://www.youtube.com/watch?v=n2THLWjJ3Wo', 'IXWX4711'),
(152, 'SCH - Stigmates', 'https://www.youtube.com/watch?v=ji2lbYIB1gI', 'IXWX4711'),
(153, 'Soprano - Faux paradis feat. PLK [Visualizer Officiel]', 'https://www.youtube.com/watch?v=oSYxc2hyprU', 'IXWX4711'),
(154, 'Booba - Freestyle CKO', 'https://www.youtube.com/watch?v=Z9KmCBd7tWw', 'IXWX4711'),
(155, 'Passement de jambes', 'https://www.youtube.com/watch?v=6QHU6hPskQM', 'IXWX4711'),
(156, 'BLESSD ❌ ANUEL AA | MIRAME REMIX (VIDEO OFICIAL)', 'https://www.youtube.com/watch?v=uHWFuICiEns', 'IXWX4711'),
(157, 'BEENDO Z - PAS BÊTE', 'https://www.youtube.com/watch?v=DWzekLgB0Oo', 'IXWX4711'),
(158, 'A$AP', 'https://www.youtube.com/watch?v=DD7VvVUILps', 'IXWX4711'),
(159, 'Dolce Camara', 'https://www.youtube.com/watch?v=AgFG6_TGdTY', 'IXWX4711'),
(160, 'VEN1 - MENACE FANTOME', 'https://www.youtube.com/watch?v=T2qp30KXVik', 'IXWX4711'),
(161, 'Missiles', 'https://www.youtube.com/watch?v=mCypLLHkx_Q', 'IXWX4711'),
(162, 'SDM - BOLIDE ALLEMAND 1/2 (Clip Officiel)', 'https://www.youtube.com/watch?v=WcX37NouKxw', 'IXWX4711'),
(163, 'Chassé-croisé', 'https://www.youtube.com/watch?v=QMZ0HfOjCqY', 'IXWX4711'),
(164, 'Ziak - Fixette (Prod. Focus Beatz)', 'https://www.youtube.com/watch?v=xk1c02v3U_U', 'IXWX4711'),
(165, 'BEN plg feat. Georgio - Colorier des HLM (prod. Lucci\')', 'https://www.youtube.com/watch?v=3uWK_UtzIqc', 'IXWX4711'),
(166, 'Grabba', 'https://www.youtube.com/watch?v=pos7SwbEXoI', 'IXWX4711'),
(167, 'NANANI NANANA', 'https://www.youtube.com/watch?v=sxDWEwG4hYk', 'IXWX4711'),
(168, 'Zamdane - Chanel', 'https://www.youtube.com/watch?v=vfDPuyib5hs', 'IXWX4711'),
(169, 'Désolé', 'https://www.youtube.com/watch?v=tLWKFeP52BI', 'IXWX4711'),
(170, 'Op Ganté', 'https://www.youtube.com/watch?v=YAc4knLIP98', 'IXWX4711'),
(171, 'KAROL G - Si Antes Te Hubiera Conocido | Coke Studio', 'https://www.youtube.com/watch?v=_ogD5wloeHw', 'IXWX4711'),
(172, 'Ziak - Akimbo (Prod. Focus Beatz X Hellboy)', 'https://www.youtube.com/watch?v=cojoYPRcIJA', 'IXWX4711'),
(173, 'Ziak - Vautours Feat @KobaLaDOfficiel  (Prod. Lowonstage)', 'https://www.youtube.com/watch?v=DbzM4xjC3zc', 'IXWX4711'),
(174, 'Effet mer', 'https://www.youtube.com/watch?v=oFnKrCG2Oq8', 'IXWX4711'),
(175, 'Ziak - Galerie (Prod. Devil)', 'https://www.youtube.com/watch?v=4vPb_VNSWrc', 'IXWX4711'),
(176, 't\'appelles ça vivre ?', 'https://www.youtube.com/watch?v=aQ7WYcEJ7DY', 'IXWX4711'),
(177, 'Même pas un grincement', 'https://www.youtube.com/watch?v=JHWjG0xLX20', 'IXWX4711'),
(178, 'Kerchak - FAKE (Clip Officiel)', 'https://www.youtube.com/watch?v=lnMFUFCbLkM', 'IXWX4711'),
(179, 'La plage', 'https://www.youtube.com/watch?v=n6cKpNFLmvY', 'IXWX4711'),
(180, 'Ziak - Raspoutine (Prod. Jango)', 'https://www.youtube.com/watch?v=7OXULEBUpOg', 'IXWX4711'),
(181, 'CAM', 'https://www.youtube.com/watch?v=oxyYtOfOwWo', 'IXWX4711'),
(182, 'KAROL G, Feid, DFZM ft. Ovy On The Drums, J Balvin, Maluma, Ryan', 'https://www.youtube.com/watch?v=3PDFqUiqZA8', 'IXWX4711'),
(183, 'Lumière blanche (Ad Finem)', 'https://www.youtube.com/watch?v=y_e6RKM6NBk', 'IXWX4711'),
(184, 'Werenoi - Pétunias (Clip Officiel)', 'https://www.youtube.com/watch?v=n2THLWjJ3Wo', 'IXWX4711'),
(185, 'SCH - Stigmates', 'https://www.youtube.com/watch?v=ji2lbYIB1gI', 'IXWX4711'),
(186, 'Ormaz - OZ feat. Zeu', 'https://www.youtube.com/watch?v=t3h2TTKQMYE', 'IXWX4711'),
(187, 'BEENDO Z - PAS BÊTE', 'https://www.youtube.com/watch?v=DWzekLgB0Oo', 'IXWX4711'),
(188, 'Booba - Freestyle CKO', 'https://www.youtube.com/watch?v=Z9KmCBd7tWw', 'IXWX4711'),
(189, 'Passement de jambes', 'https://www.youtube.com/watch?v=6QHU6hPskQM', 'IXWX4711'),
(190, 'BLESSD ❌ ANUEL AA | MIRAME REMIX (VIDEO OFICIAL)', 'https://www.youtube.com/watch?v=uHWFuICiEns', 'IXWX4711'),
(191, 'SDM - BOLIDE ALLEMAND 1/2 (Clip Officiel)', 'https://www.youtube.com/watch?v=WcX37NouKxw', 'IXWX4711'),
(192, 'A$AP', 'https://www.youtube.com/watch?v=DD7VvVUILps', 'IXWX4711'),
(193, 'Chassé-croisé', 'https://www.youtube.com/watch?v=QMZ0HfOjCqY', 'HLWK5704'),
(194, 'Grabba', 'https://www.youtube.com/watch?v=pos7SwbEXoI', 'HLWK5704'),
(195, 'BEN plg feat. Georgio - Colorier des HLM (prod. Lucci\')', 'https://www.youtube.com/watch?v=3uWK_UtzIqc', 'HLWK5704'),
(196, 'Kerchak - FAKE (Clip Officiel)', 'https://www.youtube.com/watch?v=lnMFUFCbLkM', 'HLWK5704'),
(197, 'Ziak - Fixette (Prod. Focus Beatz)', 'https://www.youtube.com/watch?v=xk1c02v3U_U', 'HLWK5704'),
(198, 'Zamdane - Chanel', 'https://www.youtube.com/watch?v=vfDPuyib5hs', 'HLWK5704'),
(199, 'Désolé', 'https://www.youtube.com/watch?v=tLWKFeP52BI', 'HLWK5704'),
(200, 'Op Ganté', 'https://www.youtube.com/watch?v=YAc4knLIP98', 'HLWK5704'),
(201, 'KAROL G - Si Antes Te Hubiera Conocido | Coke Studio', 'https://www.youtube.com/watch?v=_ogD5wloeHw', 'HLWK5704'),
(202, 'NANANI NANANA', 'https://www.youtube.com/watch?v=sxDWEwG4hYk', 'HLWK5704'),
(203, 'Ziak - Vautours Feat @KobaLaDOfficiel  (Prod. Lowonstage)', 'https://www.youtube.com/watch?v=DbzM4xjC3zc', 'HLWK5704'),
(204, 'Effet mer', 'https://www.youtube.com/watch?v=oFnKrCG2Oq8', 'HLWK5704'),
(205, 'Ziak - Akimbo (Prod. Focus Beatz X Hellboy)', 'https://www.youtube.com/watch?v=cojoYPRcIJA', 'HLWK5704'),
(206, 't\'appelles ça vivre ?', 'https://www.youtube.com/watch?v=aQ7WYcEJ7DY', 'HLWK5704'),
(207, 'Ziak - Galerie (Prod. Devil)', 'https://www.youtube.com/watch?v=4vPb_VNSWrc', 'HLWK5704'),
(208, 'Ormaz - OZ feat. Zeu', 'https://www.youtube.com/watch?v=t3h2TTKQMYE', 'HLWK5704'),
(209, 'La plage', 'https://www.youtube.com/watch?v=n6cKpNFLmvY', 'HLWK5704'),
(210, 'Même pas un grincement', 'https://www.youtube.com/watch?v=JHWjG0xLX20', 'HLWK5704'),
(211, 'CAM', 'https://www.youtube.com/watch?v=oxyYtOfOwWo', 'HLWK5704'),
(212, 'KAROL G, Feid, DFZM ft. Ovy On The Drums, J Balvin, Maluma, Ryan', 'https://www.youtube.com/watch?v=3PDFqUiqZA8', 'HLWK5704'),
(213, 'Raspoutine', 'https://www.youtube.com/watch?v=kIm4yixG3-g', 'HLWK5704'),
(214, 'Lumière blanche (Ad Finem)', 'https://www.youtube.com/watch?v=y_e6RKM6NBk', 'HLWK5704'),
(215, 'Werenoi - Pétunias (Clip Officiel)', 'https://www.youtube.com/watch?v=n2THLWjJ3Wo', 'HLWK5704'),
(216, 'SCH - Stigmates', 'https://www.youtube.com/watch?v=ji2lbYIB1gI', 'HLWK5704'),
(217, 'Soprano - Faux paradis feat. PLK [Visualizer Officiel]', 'https://www.youtube.com/watch?v=oSYxc2hyprU', 'HLWK5704'),
(218, 'Booba - Freestyle CKO', 'https://www.youtube.com/watch?v=Z9KmCBd7tWw', 'HLWK5704'),
(219, 'Passement de jambes', 'https://www.youtube.com/watch?v=6QHU6hPskQM', 'HLWK5704'),
(220, 'BLESSD ❌ ANUEL AA | MIRAME REMIX (VIDEO OFICIAL)', 'https://www.youtube.com/watch?v=uHWFuICiEns', 'HLWK5704'),
(221, 'BEENDO Z - PAS BÊTE', 'https://www.youtube.com/watch?v=DWzekLgB0Oo', 'HLWK5704'),
(222, 'Missiles', 'https://www.youtube.com/watch?v=mCypLLHkx_Q', 'HLWK5704'),
(223, 'SDM - BOLIDE ALLEMAND 1/2 (Clip Officiel)', 'https://www.youtube.com/watch?v=WcX37NouKxw', 'HLWK5704'),
(224, 'VEN1 - MENACE FANTOME', 'https://www.youtube.com/watch?v=T2qp30KXVik', 'HLWK5704'),
(225, 'A$AP', 'https://www.youtube.com/watch?v=DD7VvVUILps', 'HLWK5704'),
(226, 'Dolce Camara', 'https://www.youtube.com/watch?v=AgFG6_TGdTY', 'HLWK5704'),
(227, 'Chassé-croisé', 'https://www.youtube.com/watch?v=QMZ0HfOjCqY', 'HLWK5704'),
(228, 'Grabba', 'https://www.youtube.com/watch?v=pos7SwbEXoI', 'HLWK5704'),
(229, 'BEN plg feat. Georgio - Colorier des HLM (prod. Lucci\')', 'https://www.youtube.com/watch?v=3uWK_UtzIqc', 'HLWK5704'),
(230, 'Kerchak - FAKE (Clip Officiel)', 'https://www.youtube.com/watch?v=lnMFUFCbLkM', 'HLWK5704'),
(231, 'Ziak - Fixette (Prod. Focus Beatz)', 'https://www.youtube.com/watch?v=xk1c02v3U_U', 'HLWK5704'),
(232, 'Zamdane - Chanel', 'https://www.youtube.com/watch?v=vfDPuyib5hs', 'HLWK5704'),
(233, 'Désolé', 'https://www.youtube.com/watch?v=tLWKFeP52BI', 'HLWK5704'),
(234, 'Op Ganté', 'https://www.youtube.com/watch?v=YAc4knLIP98', 'HLWK5704'),
(235, 'KAROL G - Si Antes Te Hubiera Conocido | Coke Studio', 'https://www.youtube.com/watch?v=_ogD5wloeHw', 'HLWK5704'),
(236, 'Ziak - Akimbo (Prod. Focus Beatz X Hellboy)', 'https://www.youtube.com/watch?v=cojoYPRcIJA', 'HLWK5704'),
(237, 'Ziak - Vautours Feat @KobaLaDOfficiel  (Prod. Lowonstage)', 'https://www.youtube.com/watch?v=DbzM4xjC3zc', 'HLWK5704'),
(238, 'Effet mer', 'https://www.youtube.com/watch?v=oFnKrCG2Oq8', 'HLWK5704'),
(239, 'NANANI NANANA', 'https://www.youtube.com/watch?v=sxDWEwG4hYk', 'HLWK5704'),
(240, 't\'appelles ça vivre ?', 'https://www.youtube.com/watch?v=aQ7WYcEJ7DY', 'HLWK5704'),
(241, 'Même pas un grincement', 'https://www.youtube.com/watch?v=JHWjG0xLX20', 'HLWK5704'),
(242, 'Ormaz - OZ feat. Zeu', 'https://www.youtube.com/watch?v=t3h2TTKQMYE', 'HLWK5704'),
(243, 'La plage', 'https://www.youtube.com/watch?v=n6cKpNFLmvY', 'HLWK5704'),
(244, 'Ziak - Galerie (Prod. Devil)', 'https://www.youtube.com/watch?v=4vPb_VNSWrc', 'HLWK5704'),
(245, 'CAM', 'https://www.youtube.com/watch?v=oxyYtOfOwWo', 'HLWK5704'),
(246, 'KAROL G, Feid, DFZM ft. Ovy On The Drums, J Balvin, Maluma, Ryan', 'https://www.youtube.com/watch?v=3PDFqUiqZA8', 'HLWK5704'),
(247, 'Ziak - Raspoutine (Prod. Jango)', 'https://www.youtube.com/watch?v=7OXULEBUpOg', 'HLWK5704'),
(248, 'Lumière blanche (Ad Finem)', 'https://www.youtube.com/watch?v=y_e6RKM6NBk', 'HLWK5704'),
(249, 'Werenoi - Pétunias (Clip Officiel)', 'https://www.youtube.com/watch?v=n2THLWjJ3Wo', 'HLWK5704'),
(250, 'SCH - Stigmates', 'https://www.youtube.com/watch?v=ji2lbYIB1gI', 'HLWK5704'),
(251, 'Soprano - Faux paradis feat. PLK [Visualizer Officiel]', 'https://www.youtube.com/watch?v=oSYxc2hyprU', 'HLWK5704'),
(252, 'Booba - Freestyle CKO', 'https://www.youtube.com/watch?v=Z9KmCBd7tWw', 'HLWK5704'),
(253, 'Passement de jambes', 'https://www.youtube.com/watch?v=6QHU6hPskQM', 'HLWK5704'),
(254, 'BLESSD ❌ ANUEL AA | MIRAME REMIX (VIDEO OFICIAL)', 'https://www.youtube.com/watch?v=uHWFuICiEns', 'HLWK5704'),
(255, 'BEENDO Z - PAS BÊTE', 'https://www.youtube.com/watch?v=DWzekLgB0Oo', 'HLWK5704'),
(256, 'Missiles', 'https://www.youtube.com/watch?v=mCypLLHkx_Q', 'HLWK5704'),
(257, 'c63', 'https://www.youtube.com/watch?v=0zl6YXiI8hQ', 'IGVZ7172'),
(258, 'Jrk', 'https://youtu.be/9f6Kcrc0dUA?si=1kWZNCyyKZcBNU1L', 'TAYF0419'),
(259, '410 BEQUIILLE', 'https://www.youtube.com/watch?v=ROAjVi8Ngt4&pp=ygUDNDEw', 'KEHT4493'),
(260, 'ALICE', 'https://www.youtube.com/watch?v=jeEWpavIjIk&pp=ygUDNDEw', 'KEHT4493'),
(261, 'CARTEL', 'https://youtu.be/xJ_ri4QcLnc', 'CXOH7020'),
(262, 'PÄRLIN', 'https://youtu.be/ZJofTVkzDKo', 'CXOH7020'),
(263, 'ou aller - gims', 'https://www.youtube.com/watch?v=zr0Yy6xsyus&pp=ygUHbXVzaXF1ZQ%3D%3D', 'ZBMN1685'),
(264, 'narcos', 'https://www.youtube.com/watch?v=q06Hea1DdQc&pp=ygUGbmFyY29z', 'ZBMN1685'),
(265, 'narcos 1', 'https://www.youtube.com/watch?v=q06Hea1DdQc&pp=ygUGbmFyY29z', 'GHTR7222'),
(266, 'el diablo', 'https://www.youtube.com/watch?v=doku-BRZpD0&pp=ygUGbmFyY29z', 'GHTR7222'),
(267, 'cours enfoire', 'https://youtu.be/J7BE6v4rxUE?si=1ttOQUF-yzL8xAMh', 'UHSZ6605'),
(268, 'un jour je l\'aurai- Jul', 'https://youtu.be/bdxaG9KMnc4?si=BszEhOfUAUvPsdim', 'CCAI5606'),
(269, 'Je veux que toi-Jul', 'https://youtu.be/w3VOe5uP2EE?si=-PIx7y8eA0LsSWOK', 'CCAI5606'),
(270, 'Y\'a plus de reconnaissance-Jul', 'https://youtu.be/lfPwil3SBC8?si=9oi_XNHegGbPaDV6', 'CCAI5606'),
(271, 'Je m\'habille pas en Versace', 'https://youtu.be/bJ_O7mmHmog?si=6q9eb0WAfG5cF2-0', 'CCAI5606'),
(272, 'Y\'a plus de reconnaissance', 'https://www.youtube.com/watch?v=lfPwil3SBC8', 'CCAI5606'),
(273, 'Je m\'habille pas en Versace', 'https://www.youtube.com/watch?v=bJ_O7mmHmog', 'CCAI5606'),
(274, 'JuL - Un jour, je l\'aurai // Clip Officiel // 2024', 'https://www.youtube.com/watch?v=bdxaG9KMnc4', 'CCAI5606'),
(275, 'Arrête tes manières', 'https://www.youtube.com/watch?v=wgAgjgkRMnc', 'CCAI5606'),
(276, 'Je veux que toi', 'https://www.youtube.com/watch?v=D6nTz9R968g', 'CCAI5606'),
(277, 'C\'est ça les collègues ?', 'https://www.youtube.com/watch?v=3ik7c3oB1bA', 'CCAI5606'),
(278, 'Maille (feat. Bad Gyal)', 'https://www.youtube.com/watch?v=uN5FTkc2EVg', 'CCAI5606'),
(279, 'Capata (feat. FRANCÈ ZITO)', 'https://www.youtube.com/watch?v=oeDZG-AYo9M', 'CCAI5606'),
(280, 'Montblanc', 'https://www.youtube.com/watch?v=uL1A8_rdOSQ', 'CCAI5606'),
(281, 'Plus de pitié', 'https://www.youtube.com/watch?v=wwx6oig5lIQ', 'CCAI5606'),
(282, 'Coeur en or', 'https://www.youtube.com/watch?v=n_T3pnai05Q', 'CCAI5606'),
(283, 'Un heureux, un déçu', 'https://www.youtube.com/watch?v=6mIuosK9pFI', 'CCAI5606'),
(284, 'Ma douce', 'https://www.youtube.com/watch?v=4_02L3LgzRQ', 'CCAI5606'),
(285, 'Boucle dorée', 'https://www.youtube.com/watch?v=EYkC_Tr_V9E', 'CCAI5606'),
(286, 'La vie me blesse', 'https://www.youtube.com/watch?v=tUdp9mUBe3I', 'CCAI5606'),
(287, 'Wesh alors le deum', 'https://www.youtube.com/watch?v=BxNG55yrg5U', 'CCAI5606'),
(288, 'C\'est pas la peine', 'https://www.youtube.com/watch?v=CsvLYIZ-iuk', 'CCAI5606'),
(289, 'Je suis fait pour...', 'https://www.youtube.com/watch?v=o1-y9-ZLmCQ', 'CCAI5606'),
(290, 'Fugati', 'https://www.youtube.com/watch?v=3KhQDitRHXM', 'CCAI5606'),
(291, 'Un point c\'est tout', 'https://www.youtube.com/watch?v=7JS5oqVhXyo', 'CCAI5606'),
(292, 'Toujours la même', 'https://www.youtube.com/watch?v=HBE73yFpNK0', 'CCAI5606'),
(293, 'Rare comme un diamant', 'https://www.youtube.com/watch?v=NoWDiMIt2o4', 'CCAI5606'),
(294, 'LOPSA STORY', 'https://music.youtube.com/watch?v=8_XYiWraciY&si=i2nTwygHbGaZH1Qw', 'MOID7943'),
(295, 'Narcos Episode 7 End Song (Sigue Feliz)', 'https://www.youtube.com/watch?v=dH05wYoQj9k', 'OZAN1309'),
(296, 'Porro Bonito - Orquesta Ritmo De Sabanas', 'https://www.youtube.com/watch?v=Qjnm7LVPSA4', 'OZAN1309'),
(297, 'Narcos - Abertura da série (Tuyo, por Rodrigo Amarante)', 'https://www.youtube.com/watch?v=TnrDJnCTSno', 'OZAN1309'),
(298, 'Narcos - La Pelea Con el Diablo - Netflix [HD]', 'https://www.youtube.com/watch?v=doku-BRZpD0', 'OZAN1309'),
(299, 'Narcos Episode 7 End Song (Sigue Feliz)', 'https://www.youtube.com/watch?v=dH05wYoQj9k', 'OZAN1309'),
(300, 'Pedro Bromfman - Baby Girl - Narcos 2º Season', 'https://www.youtube.com/watch?v=cNMJhSmOeCk', 'OZAN1309'),
(301, 'Usma Y Su Conjunto el hijo de tono Narcos season 2 Episode 5 End', 'https://www.youtube.com/watch?v=oGsKVu2-LQc', 'OZAN1309'),
(302, 'Usma Y Su Conjunto   El Hijo de Toño (Narcos 2x05)', 'https://www.youtube.com/watch?v=q06Hea1DdQc', 'OZAN1309'),
(303, 'Flores de Colombia - Lalito y Conjunto Colombia', 'https://www.youtube.com/watch?v=Uv9lrqmexms', 'OZAN1309'),
(304, '\"Melancolía\" - Julio Jaramillo (Pasillo)', 'https://www.youtube.com/watch?v=KE4PTttgeZQ', 'OZAN1309'),
(305, 'Usma Y Su Conjunto el hijo de tono Narcos season 2 Episode 5 End', 'https://www.youtube.com/watch?v=oGsKVu2-LQc', 'OZAN1309'),
(306, 'Todo En La Vida, Elia Y Elizabeth - Audio', 'https://www.youtube.com/watch?v=ssGg46rz-jw', 'OZAN1309'),
(307, 'narcos season 2 episode 6 end song (Noche de Ronda)', 'https://www.youtube.com/watch?v=NFQiSJVfxVw', 'OZAN1309'),
(308, 'Rodrigo Amarante - Narcos Tuyo (Nalesia Remix)', 'https://www.youtube.com/watch?v=LvHouH28Dvk', 'OZAN1309'),
(309, 'Narcos Prologue -OST longer version', 'https://www.youtube.com/watch?v=jktBN5TuaJA', 'OZAN1309'),
(310, 'Fruko Y Sus Tesos -Yo Soy El Punto Cubano', 'https://www.youtube.com/watch?v=U8UHGTWbbI0', 'OZAN1309'),
(311, 'Usma Y Su Conjunto el hijo de tono Narcos season 2 Episode 5 End', 'https://www.youtube.com/watch?v=bmnR6Fiz2kA', 'OZAN1309'),
(312, 'narcos season 2 episode 6 end song (Noche de Ronda)', 'https://www.youtube.com/watch?v=LHX3Tq_zDZQ', 'OZAN1309'),
(313, 'Todo En La Vida, Elia Y Elizabeth - Audio', 'https://www.youtube.com/watch?v=oGsKVu2-LQc', 'OZAN1309'),
(314, 'TABACO Y RON', 'https://www.youtube.com/watch?v=NFQiSJVfxVw', 'OZAN1309'),
(315, 'LIMONCITO CON RON, rodolfo aicardi', 'https://www.youtube.com/watch?v=ssGg46rz-jw', 'OZAN1309'),
(316, 'Narcos season 2 episode 9 ending song', 'https://www.youtube.com/watch?v=raRqgKqIM3M', 'OZAN1309'),
(317, 'letoooo', 'https://youtu.be/HpuRsDQPfsU?si=FRXwlkfoDoc6ygo7', 'OIAR9680'),
(318, 'Werenoi', 'https://youtu.be/BWr5MoXPMUc?si=oPk0hDwTe91B0ohF', 'FLUI4353'),
(319, 'fefe lambo', 'https://youtu.be/4VDe58GSk6s?si=UhTW_r2cYf_TYeio', 'YHCS4063'),
(320, 'donna', 'https://youtu.be/Pc0L6JqWpUo?si=-d6HVU-ll394k-NM', 'YHCS4063'),
(321, 'ciel', 'https://youtu.be/KG6ft_YDp5k?si=CHQNGinV7NXdbdzJ', 'XUVZ2114'),
(322, 'M', 'https://youtu.be/KG6ft_YDp5k?si=CHQNGinV7NXdbdzJ', 'UVZV3812'),
(323, 'bandoleros', 'https://youtu.be/Cd06IxUBIM0', 'FDAD5736'),
(324, 'oye', 'https://www.youtube.com/watch?v=M3u7Ku42jeM&pp=ygUDb3ll', 'FDAD5736'),
(325, 'skiboy', 'https://www.youtube.com/watch?v=ySmWMPAyCJg&pp=ygUVbWVuYWNlIHNhbnRhbmEgc2tpYm95', 'FDAD5736'),
(326, 'pink', 'https://www.youtube.com/watch?v=lw_XFnk5kwU&pp=ygUTcGFpbiBwaW5rcGFudGhlcmVzcw%3D%3D', 'FDAD5736'),
(327, 'hay lupita', 'https://www.youtube.com/watch?v=z6LsIMZ546w&pp=ygUKaGF5IGx1cGl0YQ%3D%3D', 'FDAD5736'),
(328, 'ghypsy woman', 'https://www.youtube.com/watch?v=_KztNIg4cvE&pp=ygULZ3lwc3kgd29tYW4%3D', 'FDAD5736'),
(329, 'Zoum m', 'https://youtu.be/KG6ft_YDp5k?si=CHQNGinV7NXdbdzJ', 'FWDU1872'),
(330, 'ZOUIIM', 'https://youtu.be/KG6ft_YDp5k?si=CHQNGinV7NXdbdzJ', 'IVVP7251'),
(331, 'brazil', 'https://www.youtube.com/watch?v=sIkIzcYpouA&pp=ygUib2ggZ2Fyb3RhIGV1IHF1ZXJvIHZvY2Ugc28gcHJhIG1pbQ%3D%3D', 'FDAD5736'),
(332, 'brazil', 'https://www.youtube.com/watch?v=sIkIzcYpouA&pp=ygUib2ggZ2Fyb3RhIGV1IHF1ZXJvIHZvY2Ugc28gcHJhIG1pbQ%3D%3D', 'OZAN1309'),
(336, 'BMF', 'https://youtu.be/Nj6Qv73RCoQ', 'EYNR4965'),
(337, 'M16', 'https://youtu.be/jwVES2OExvc', 'EYNR4965'),
(338, 'Okartier', 'https://youtu.be/SBngx_tVpxg', 'EYNR4965'),
(339, 'Ma signature | CJ', 'https://youtu.be/q_QL45PLYQM', 'AVVZ3146'),
(340, 'Qu\'es qui ce passe chez les Ballas |Crazy', 'https://youtu.be/rxeeFUuBEVk', 'AVVZ3146'),
(341, 'Fonoti | SCHYZOCRAZY', 'https://youtu.be/bnKqcxjPXM4', 'AVVZ3146'),
(342, 'Sodomite RAP | Cum$hot', 'https://youtu.be/WqYVYmeUv3k', 'AVVZ3146'),
(343, 'ours Enfoiré | Jimmy 2X/Willy', 'https://youtu.be/J7BE6v4rxUE', 'AVVZ3146'),
(344, 'Jimmy 2x | cours enfoiré ', 'https://youtu.be/J7BE6v4rxUE', 'DFMI1611'),
(345, 'Sodomite RAP | Cum$hot ', 'https://youtu.be/WqYVYmeUv3k?si=PvgQGEpqU6Sq_t4D', 'DFMI1611'),
(346, 'Fonoti | SCHYZOCRAZY', 'https://youtu.be/bnKqcxjPXM4?si=EBdG-vkN7KxQ69hw', 'DFMI1611'),
(347, 'Keski\'s passe chez les Ballas', 'https://youtu.be/rxeeFUuBEVk?si=eD5AD38wCp_Oemro', 'DFMI1611'),
(348, 'Ma Signature | CJ', 'https://youtu.be/q_QL45PLYQM?si=P6i-U9jNkwGkxmGB', 'DFMI1611'),
(349, '92i veyron', 'https://www.youtube.com/watch?v=hwtLqJyhS3Q&pp=ygUKOTJpIHZleXJvbg%3D%3D', 'FDAD5736'),
(350, 'miu linda', 'https://youtu.be/cordADXcng0', 'FDAD5736'),
(351, 'BMF', 'https://youtu.be/Nj6Qv73RCoQ?si=3Jbqplyyk6_kMBrS', 'YAGR3565'),
(352, 'vanessa', 'https://youtu.be/uJgcQtNwsqI?si=GIXCk8HlivhAGa7q', 'YAGR3565'),
(353, 'paye', 'https://youtu.be/CpxJ_qfUf24?si=bd0rwjdyvvmtF8tq', 'YAGR3565'),
(354, 'vanessa', 'https://youtu.be/uJgcQtNwsqI?si=yyowIu-0KBFHt3M6', 'TYOE3606'),
(355, 'BMF', 'https://youtu.be/Nj6Qv73RCoQ', 'HGCS7504'),
(356, 'PIGNOUF', 'https://youtu.be/mb79mnyZfUU', 'SMJV8424'),
(357, 'B', 'https://youtu.be/jwVES2OExvc', 'SMJV8424'),
(358, 'BMF', 'https://youtu.be/Nj6Qv73RCoQ', 'SMJV8424'),
(359, 'beixao', 'https://www.youtube.com/watch?v=Yzy83rngXlw&pp=ygUUZXUgbmFvIGRhbmNvIGNvbnRpZ28%3D', 'FDAD5736'),
(360, 'badoxa', 'https://www.youtube.com/watch?v=ixv6Wrow5SM&pp=ygUIY29udHJvbGE%3D', 'FDAD5736'),
(361, 'NIRO', 'https://youtu.be/aHuFAgAibak?si=7E3eouh7ymGIiLbn', 'YAGR3565'),
(362, 'DD', 'https://youtu.be/hAIzMLGTGPQ', '63BGS977'),
(363, 'million', 'https://youtu.be/ccsuo2_dn5Q?si=7UWaM9kpVG2Xb__M', 'PYBK8589'),
(364, 'dans ma tete', 'https://youtu.be/rEDdcU9ucoI?si=hh8vcyXnXWsFrkJE', 'YAGR3565'),
(365, 'miu linda', 'https://www.youtube.com/watch?v=isE7GyOS9fc&pp=ygUJbWl1IGxpbmRh', 'FRAJ8540'),
(366, 'AMNESIE', 'https://www.youtube.com/watch?v=fVoK3P3Xla0', 'FKHY8137'),
(367, 'congolese', 'https://www.youtube.com/watch?v=d2tnwgcBfoA&pp=ygUSa29uZ29sZXNlIHNvdXMgYmJs', 'FRAJ8540'),
(368, 'd', 'https://www.youtube.com/watch?v=d2tnwgcBfoA&pp=ygUSa29uZ29sZXNlIHNvdXMgYmJs', '21TJM424'),
(369, 'race', 'https://youtu.be/n3sSpuppWP0', '21TJM424'),
(370, 'LIMS', 'https://youtu.be/jGpCvSMcRyY?si=oYXM10G8JMru5TgS', 'YAGR3565'),
(371, 'kiki', 'https://youtu.be/UUupGl80JeU?si=HM-OPAhwkkCXX9S3', 'YHCS4063'),
(373, 'reseau1', 'https://www.youtube.com/watch?v=tul6zYBp9tA', 'IMVU0892'),
(374, 'un poco', 'https://www.youtube.com/watch?v=eqYxVsEaypk', 'IMVU0892'),
(375, 'partenaire particulie', 'https://www.youtube.com/watch?v=ccSPZZ2AKXY', 'IMVU0892'),
(376, 'damzp', 'https://www.youtube.com/watch?v=wMCJladUYGQ&pp=ygULYWxwaGEgZGFtc28%3D', 'FRAJ8540'),
(377, 'popopo', 'https://www.youtube.com/watch?v=H_rZMgS5nE4', 'IMVU0892'),
(378, 'dddd', 'https://www.youtube.com/watch?v=hwtLqJyhS3Q&pp=ygUKOTJpIHZleXJvbg%3D%3D', 'FRAJ8540'),
(379, 'chui dans lbock', 'https://youtu.be/H_rZMgS5nE4', 'FRAJ8540'),
(380, 'watchh', 'https://youtu.be/8rSgH-ulBtA?list=PLtgliYlgbh0zYR8Aj3DwE8nFjOvOAEnRh', 'FRAJ8540'),
(381, 'd', 'https://youtu.be/WJADXTw7QU0?list=PLtgliYlgbh0zYR8Aj3DwE8nFjOvOAEnRh', 'FRAJ8540'),
(382, 'doogie', 'https://www.youtube.com/watch?v=63CCPPLeyXA', 'IMVU0892'),
(383, 'kaaris', 'https://youtu.be/xX4Pxiwti4E', 'FRAJ8540'),
(384, 'kaaaaarus', 'https://youtu.be/xX4Pxiwti4E', 'FRAJ8540'),
(385, 'benz', 'https://www.youtube.com/watch?v=Y4uOM7s38XA&pp=ygUMZGFucyBtYSBiZW56', 'FRAJ8540'),
(386, 'bougie', 'https://youtu.be/EgfNeQm_z6k?si=Lg_dlSgV0Mn1ZOv5', 'YQZY0670'),
(387, 'SHATTA', 'https://www.youtube.com/watch?v=3QdZQyRBsGk&list=PLOVMhvW69ghkIYRoEc69LdrE4hOfB9fTY', 'JHDN7031'),
(388, 'Vespa', 'https://www.youtube.com/watch?v=3QdZQyRBsGk', 'JHDN7031'),
(389, 'Santorini (Toutouni)', 'https://www.youtube.com/watch?v=dhg3qcyDj90', 'JHDN7031'),
(390, 'Bandit', 'https://www.youtube.com/watch?v=0_XDCX8NBNU', 'JHDN7031'),
(391, 'Incognito (feat. Dj Weezz & Ottomatik)', 'https://www.youtube.com/watch?v=w5HipX6hKRw', 'JHDN7031'),
(392, 'Je l\'ai vu (feat. Arendi) (Bouyon Kings Mixtape)', 'https://www.youtube.com/watch?v=T4v-xcT4fOw', 'JHDN7031'),
(393, 'Pilule', 'https://www.youtube.com/watch?v=XGnrjvr-MSU', 'JHDN7031'),
(394, 'Ay koké manman\'w', 'https://www.youtube.com/watch?v=Ir113PxiQvA', 'JHDN7031'),
(395, 'Joncté', 'https://www.youtube.com/watch?v=7oLBVw26OMc', 'JHDN7031'),
(396, '1t1 & Theomaa - Wa wa Waaaw (Audio Officiel)', 'https://www.youtube.com/watch?v=sqLHkuTmvJw', 'JHDN7031'),
(397, 'Natoxie Ft TKD - Woaw (Bouyon 2022)', 'https://www.youtube.com/watch?v=pKFYRj_9hLM', 'JHDN7031'),
(398, 'Applaudissement', 'https://www.youtube.com/watch?v=gnuDKuF5CgI', 'JHDN7031'),
(399, 'Gyal Accroupi', 'https://www.youtube.com/watch?v=XKLcdrYC0ts', 'JHDN7031'),
(400, 'NATOXIE - SHATTA BOUYON', 'https://www.youtube.com/watch?v=983_4Exfo2U', 'JHDN7031'),
(401, 'Doglife! Vcvc', 'https://www.youtube.com/watch?v=EiejcbRdtB8', 'JHDN7031'),
(402, 'Natoxie Ft Crown Up (French, Sarah & Coco) - Chupa Chups (Carnat', 'https://www.youtube.com/watch?v=ON33a3NP9Zw', 'JHDN7031'),
(403, 'Dife Kako', 'https://www.youtube.com/watch?v=YXyuGgLl_Mg', 'JHDN7031'),
(404, 'Gwo Kal-Libre', 'https://www.youtube.com/watch?v=UxbMe-Lo3xo', 'JHDN7031'),
(405, 'TCHIRIRI X PLAT | DJ FAB ft  KROSIF |', 'https://www.youtube.com/watch?v=mbFGoMb66kA', 'JHDN7031'),
(406, 'Pineco', 'https://www.youtube.com/watch?v=VByupWmatQs', 'JHDN7031'),
(407, '#ÇaPique', 'https://www.youtube.com/watch?v=nEPWqXt2QQU', 'JHDN7031'),
(408, 'Baissé Blessé', 'https://www.youtube.com/watch?v=60GDSAFFRmE', 'JHDN7031'),
(409, 'Wap Din Ding Dong', 'https://www.youtube.com/watch?v=B-3ZiQk4_A8', 'JHDN7031'),
(410, 'Walpa 2', 'https://www.youtube.com/watch?v=LfP8PHApwm8', 'JHDN7031'),
(411, 'Wouaw Wouaw', 'https://www.youtube.com/watch?v=qFYAHgFgQAY', 'JHDN7031'),
(412, 'Shatta Toute la Night', 'https://www.youtube.com/watch?v=Gskd5DGbZts', 'JHDN7031'),
(413, 'Guatauba', 'https://www.youtube.com/watch?v=zs7bnoXT42g', 'JHDN7031'),
(414, 'Plat', 'https://www.youtube.com/watch?v=cttFDn66EFc', 'JHDN7031'),
(415, 'Coco', 'https://www.youtube.com/watch?v=iO4Gw-B4r1A', 'JHDN7031'),
(416, 'KJF 4', 'https://www.youtube.com/watch?v=0xKNFdt2BTs', 'JHDN7031'),
(417, 'Se Voce Nao Quer Passa a Vez', 'https://www.youtube.com/watch?v=GKQVUd-N5Ys', 'JHDN7031'),
(418, '50/50', 'https://www.youtube.com/watch?v=Woq_cf5RL-8', 'JHDN7031'),
(419, 'Whine & Kotch', 'https://www.youtube.com/watch?v=JyvSlD4p04w', 'JHDN7031'),
(420, 'Ella Quiere Hmm', 'https://www.youtube.com/watch?v=7HOrN86Ym-I', 'JHDN7031'),
(421, 'Sumba pa Moverlo', 'https://www.youtube.com/watch?v=U4rEKi3BCYg', 'JHDN7031'),
(422, 'Desesperados', 'https://www.youtube.com/watch?v=j-UZMyi6YHA', 'JHDN7031'),
(423, 'Vespa', 'https://www.youtube.com/watch?v=3QdZQyRBsGk', 'TUSZ8106'),
(424, 'Santorini (Toutouni)', 'https://www.youtube.com/watch?v=dhg3qcyDj90', 'TUSZ8106'),
(425, 'Bandit', 'https://www.youtube.com/watch?v=0_XDCX8NBNU', 'TUSZ8106'),
(426, 'Incognito (feat. Dj Weezz & Ottomatik)', 'https://www.youtube.com/watch?v=w5HipX6hKRw', 'TUSZ8106'),
(427, 'Je l\'ai vu (feat. Arendi) (Bouyon Kings Mixtape)', 'https://www.youtube.com/watch?v=T4v-xcT4fOw', 'TUSZ8106'),
(428, 'Pilule', 'https://www.youtube.com/watch?v=XGnrjvr-MSU', 'TUSZ8106'),
(429, 'Ay koké manman\'w', 'https://www.youtube.com/watch?v=Ir113PxiQvA', 'TUSZ8106'),
(430, 'Joncté', 'https://www.youtube.com/watch?v=7oLBVw26OMc', 'TUSZ8106'),
(431, '1t1 & Theomaa - Wa wa Waaaw (Audio Officiel)', 'https://www.youtube.com/watch?v=sqLHkuTmvJw', 'TUSZ8106'),
(432, 'Natoxie Ft TKD - Woaw (Bouyon 2022)', 'https://www.youtube.com/watch?v=pKFYRj_9hLM', 'TUSZ8106'),
(433, 'Applaudissement', 'https://www.youtube.com/watch?v=gnuDKuF5CgI', 'TUSZ8106'),
(434, 'Gyal Accroupi', 'https://www.youtube.com/watch?v=XKLcdrYC0ts', 'TUSZ8106'),
(435, 'NATOXIE - SHATTA BOUYON', 'https://www.youtube.com/watch?v=983_4Exfo2U', 'TUSZ8106'),
(436, 'Doglife! Vcvc', 'https://www.youtube.com/watch?v=EiejcbRdtB8', 'TUSZ8106'),
(437, 'Natoxie Ft Crown Up (French, Sarah & Coco) - Chupa Chups (Carnat', 'https://www.youtube.com/watch?v=ON33a3NP9Zw', 'TUSZ8106'),
(438, 'Dife Kako', 'https://www.youtube.com/watch?v=YXyuGgLl_Mg', 'TUSZ8106'),
(439, 'Gwo Kal-Libre', 'https://www.youtube.com/watch?v=UxbMe-Lo3xo', 'TUSZ8106'),
(440, 'TCHIRIRI X PLAT | DJ FAB ft  KROSIF |', 'https://www.youtube.com/watch?v=mbFGoMb66kA', 'TUSZ8106'),
(441, 'Pineco', 'https://www.youtube.com/watch?v=VByupWmatQs', 'TUSZ8106'),
(442, '#ÇaPique', 'https://www.youtube.com/watch?v=nEPWqXt2QQU', 'TUSZ8106'),
(443, 'Baissé Blessé', 'https://www.youtube.com/watch?v=60GDSAFFRmE', 'TUSZ8106'),
(444, 'Wap Din Ding Dong', 'https://www.youtube.com/watch?v=B-3ZiQk4_A8', 'TUSZ8106'),
(445, 'Walpa 2', 'https://www.youtube.com/watch?v=LfP8PHApwm8', 'TUSZ8106'),
(446, 'Wouaw Wouaw', 'https://www.youtube.com/watch?v=qFYAHgFgQAY', 'TUSZ8106'),
(447, 'Shatta Toute la Night', 'https://www.youtube.com/watch?v=Gskd5DGbZts', 'TUSZ8106'),
(448, 'Guatauba', 'https://www.youtube.com/watch?v=zs7bnoXT42g', 'TUSZ8106'),
(449, 'Plat', 'https://www.youtube.com/watch?v=cttFDn66EFc', 'TUSZ8106'),
(450, 'Coco', 'https://www.youtube.com/watch?v=iO4Gw-B4r1A', 'TUSZ8106'),
(451, 'KJF 4', 'https://www.youtube.com/watch?v=0xKNFdt2BTs', 'TUSZ8106'),
(452, 'Se Voce Nao Quer Passa a Vez', 'https://www.youtube.com/watch?v=GKQVUd-N5Ys', 'TUSZ8106'),
(453, '50/50', 'https://www.youtube.com/watch?v=Woq_cf5RL-8', 'TUSZ8106'),
(454, 'Whine & Kotch', 'https://www.youtube.com/watch?v=JyvSlD4p04w', 'TUSZ8106'),
(455, 'Ella Quiere Hmm', 'https://www.youtube.com/watch?v=7HOrN86Ym-I', 'TUSZ8106'),
(456, 'Sumba pa Moverlo', 'https://www.youtube.com/watch?v=U4rEKi3BCYg', 'TUSZ8106'),
(457, 'Desesperados', 'https://www.youtube.com/watch?v=j-UZMyi6YHA', 'TUSZ8106'),
(458, 'cagoule', 'https://www.youtube.com/watch?v=PI9yKr39vGI', 'IMVU0892'),
(459, 'comme les gens d\'ici', 'https://www.youtube.com/watch?v=7echk8kqtJw', 'IMVU0892'),
(460, 'sous la lune', 'https://www.youtube.com/watch?v=Pwn74QiCeEU', 'IMVU0892'),
(461, 'Amis Ennemis', 'https://www.youtube.com/watch?v=hE66jLHc3fI', 'JGHB8709'),
(462, 'Hayce Lemsi - Jean Reno', 'https://www.youtube.com/watch?v=6Vp9364IeCc', 'JGHB8709'),
(463, '45 AMG', 'https://www.youtube.com/watch?v=hR-AHt4-uNU', 'JGHB8709'),
(464, 'Big Lemsi', 'https://www.youtube.com/watch?v=95ts0lUSJXw', 'JGHB8709'),
(465, 'Hasta la vista', 'https://www.youtube.com/watch?v=WCnMiCGTQXQ', 'JGHB8709'),
(466, 'Barry Allen', 'https://www.youtube.com/watch?v=T2JYlMEe_eU', 'JGHB8709'),
(467, 'BLC', 'https://www.youtube.com/watch?v=UYnMPfasYY0', 'JGHB8709'),
(468, 'Ice on Hayce', 'https://www.youtube.com/watch?v=2MxhWMaRqRI', 'JGHB8709'),
(469, 'Thug Life', 'https://www.youtube.com/watch?v=mb3qr6Sjnks', 'JGHB8709'),
(470, 'Hayce Lemsi - Gennaro', 'https://www.youtube.com/watch?v=KTgrwNi3BdM', 'JGHB8709'),
(471, 'Flexin', 'https://www.youtube.com/watch?v=gS59iU1qGBs', 'JGHB8709'),
(472, 'Gris Montaigne', 'https://www.youtube.com/watch?v=EAIupoOq6-s', 'JGHB8709'),
(473, 'L\'indomptable', 'https://www.youtube.com/watch?v=2GjpKdFKvxE', 'JGHB8709'),
(474, 'Dernier verre', 'https://www.youtube.com/watch?v=CMTog7sxSQA', 'JGHB8709'),
(475, 'Hayce Lemsi - 10 ans déja', 'https://www.youtube.com/watch?v=7U0WUvXu0vs', 'JGHB8709'),
(476, 'Hayce Lemsi - Écorché Vif -', 'https://www.youtube.com/watch?v=57aN2ZQNKhA', 'JGHB8709');

-- --------------------------------------------------------

--
-- Structure de la table `radiocar_owned`
--

CREATE TABLE `radiocar_owned` (
  `id` int(11) NOT NULL,
  `spz` varchar(32) NOT NULL,
  `style` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `radiocar_playlist`
--

CREATE TABLE `radiocar_playlist` (
  `id` int(11) NOT NULL,
  `playlist` text NOT NULL,
  `plate` varchar(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `rcore_tattoos`
--

CREATE TABLE `rcore_tattoos` (
  `identifier` varchar(100) NOT NULL,
  `tattoos` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `rcore_tattoos_business`
--

CREATE TABLE `rcore_tattoos_business` (
  `name` varchar(60) NOT NULL,
  `margin` int(11) DEFAULT 20,
  `money` int(11) DEFAULT NULL,
  `owner` varchar(60) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `reset_logs`
--

CREATE TABLE `reset_logs` (
  `id` int(11) NOT NULL,
  `last_reset` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `reset_logs`
--

INSERT INTO `reset_logs` (`id`, `last_reset`) VALUES
(1, '2026-02-18 15:54:29');

-- --------------------------------------------------------

--
-- Structure de la table `selling_weapons`
--

CREATE TABLE `selling_weapons` (
  `name` longtext DEFAULT NULL,
  `label` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `selling_weapons`
--

INSERT INTO `selling_weapons` (`name`, `label`) VALUES
('Cartel De Cayo', 'Cartel de Cayo'),
('Cartel de Sinaloa', 'Cartel de Sinaloa');

-- --------------------------------------------------------

--
-- Structure de la table `slots_inventory`
--

CREATE TABLE `slots_inventory` (
  `UniqueID` int(11) NOT NULL,
  `slots` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `slots_inventory`
--

INSERT INTO `slots_inventory` (`UniqueID`, `slots`) VALUES
(1, '[{\"label\":\"\",\"item\":{\"label\":\"\",\"name\":-1569615261},\"slot\":1,\"name\":-1569615261},{\"label\":\"\",\"item\":{\"label\":\"\",\"name\":-1569615261},\"slot\":2,\"name\":-1569615261},{\"label\":\"\",\"item\":{\"label\":\"\",\"name\":-1569615261},\"slot\":3,\"name\":-1569615261}]'),
(2, '[{\"slot\":1,\"label\":\"Aucun\",\"name\":-1569615261,\"item\":{\"label\":\"Aucun\",\"name\":-1569615261}},{\"slot\":2,\"label\":\"Aucun\",\"name\":-1569615261,\"item\":{\"label\":\"Aucun\",\"name\":-1569615261}},{\"slot\":3,\"label\":\"Aucun\",\"name\":-1569615261,\"item\":{\"label\":\"Aucun\",\"name\":-1569615261}},{\"slot\":4,\"label\":\"Aucun\",\"name\":-1569615261,\"item\":{\"label\":\"Aucun\",\"name\":-1569615261}},{\"slot\":5,\"label\":\"Aucun\",\"name\":-1569615261,\"item\":{\"label\":\"Aucun\",\"name\":-1569615261}}]'),
(4, '[{\"item\":{\"name\":-1569615261,\"label\":\"\"},\"slot\":2,\"name\":-1569615261,\"label\":\"\"},{\"slot\":1,\"label\":\"Lance-rocket (255)\",\"item\":{\"usable\":true,\"count\":255,\"informationsText\":\"Indéfini\",\"label\":\"Lance-rocket (255)\",\"name\":\"WEAPON_RPG\",\"informations\":false,\"image\":\"/src/html/assets/icons/toolbox.png\",\"type\":\"item_weapon\"},\"image\":\"/src/html/assets/icons/toolbox.png\",\"name\":\"WEAPON_RPG\"}]'),
(5, '[{\"slot\":1,\"label\":\"\",\"name\":-1569615261,\"item\":{\"name\":-1569615261,\"label\":\"\"}},{\"slot\":2,\"label\":\"\",\"name\":-1569615261,\"item\":{\"name\":-1569615261,\"label\":\"\"}}]'),
(6, '[{\"name\":-1569615261,\"slot\":3,\"item\":{\"name\":-1569615261,\"label\":\"\"},\"label\":\"\"},{\"slot\":1,\"label\":\"SCAR-17 (255)\",\"name\":\"WEAPON_SCAR17FM\",\"image\":\"/src/html/assets/icons/WEAPON_SCAR17FM.png\",\"item\":{\"usable\":true,\"count\":255,\"informationsText\":\"Indéfini\",\"label\":\"SCAR-17 (255)\",\"name\":\"WEAPON_SCAR17FM\",\"informations\":false,\"image\":\"/src/html/assets/icons/WEAPON_SCAR17FM.png\",\"type\":\"item_weapon\"}},{\"slot\":2,\"label\":\"Lance-rocket (255)\",\"name\":\"WEAPON_RPG\",\"image\":\"/src/html/assets/icons/toolbox.png\",\"item\":{\"usable\":true,\"count\":255,\"informationsText\":\"Indéfini\",\"label\":\"Lance-rocket (255)\",\"name\":\"WEAPON_RPG\",\"informations\":false,\"image\":\"/src/html/assets/icons/toolbox.png\",\"type\":\"item_weapon\"}}]'),
(7, '[{\"name\":-1569615261,\"label\":\"Aucun\",\"item\":{\"name\":-1569615261,\"label\":\"Aucun\"},\"slot\":2},{\"name\":-1569615261,\"label\":\"Aucun\",\"item\":{\"name\":-1569615261,\"label\":\"Aucun\"},\"slot\":3},{\"name\":-1569615261,\"label\":\"Aucun\",\"item\":{\"name\":-1569615261,\"label\":\"Aucun\"},\"slot\":4},{\"name\":-1569615261,\"label\":\"Aucun\",\"item\":{\"name\":-1569615261,\"label\":\"Aucun\"},\"slot\":5},{\"name\":\"WEAPON_REVOLVER\",\"image\":\"/src/html/assets/icons/WEAPON_REVOLVER.png\",\"label\":\"Revolver (137)\",\"item\":{\"name\":\"WEAPON_REVOLVER\",\"label\":\"Revolver (137)\",\"informations\":false,\"image\":\"/src/html/assets/icons/WEAPON_REVOLVER.png\",\"usable\":true,\"count\":137,\"type\":\"item_weapon\",\"informationsText\":\"Indéfini\"},\"slot\":1}]'),
(8, '[{\"slot\":1,\"image\":\"/src/html/assets/icons/WEAPON_PISTOL.png\",\"label\":\"Pistolet (100)\",\"item\":{\"name\":\"WEAPON_PISTOL\",\"informations\":false,\"label\":\"Pistolet (100)\",\"type\":\"item_weapon\",\"image\":\"/src/html/assets/icons/WEAPON_PISTOL.png\",\"count\":100,\"usable\":true,\"informationsText\":\"Indéfini\"},\"name\":\"WEAPON_PISTOL\"}]'),
(9, '[]'),
(10, '[{\"slot\":1,\"label\":\"Aucun\",\"item\":{\"name\":-1569615261,\"label\":\"Aucun\"},\"name\":-1569615261},{\"slot\":2,\"label\":\"Aucun\",\"item\":{\"name\":-1569615261,\"label\":\"Aucun\"},\"name\":-1569615261},{\"slot\":3,\"label\":\"Aucun\",\"item\":{\"name\":-1569615261,\"label\":\"Aucun\"},\"name\":-1569615261},{\"slot\":4,\"label\":\"Aucun\",\"item\":{\"name\":-1569615261,\"label\":\"Aucun\"},\"name\":-1569615261},{\"slot\":5,\"label\":\"Aucun\",\"item\":{\"name\":-1569615261,\"label\":\"Aucun\"},\"name\":-1569615261}]'),
(11, '[{\"slot\":1,\"label\":\"Aucun\",\"item\":{\"name\":-1569615261,\"label\":\"Aucun\"},\"name\":-1569615261},{\"slot\":2,\"label\":\"Aucun\",\"item\":{\"name\":-1569615261,\"label\":\"Aucun\"},\"name\":-1569615261},{\"slot\":3,\"label\":\"Aucun\",\"item\":{\"name\":-1569615261,\"label\":\"Aucun\"},\"name\":-1569615261},{\"slot\":4,\"label\":\"Aucun\",\"item\":{\"name\":-1569615261,\"label\":\"Aucun\"},\"name\":-1569615261},{\"slot\":5,\"label\":\"Aucun\",\"item\":{\"name\":-1569615261,\"label\":\"Aucun\"},\"name\":-1569615261}]'),
(13, '[{\"name\":-1569615261,\"label\":\"Aucun\",\"item\":{\"name\":-1569615261,\"label\":\"Aucun\"},\"slot\":1},{\"name\":-1569615261,\"label\":\"Aucun\",\"item\":{\"name\":-1569615261,\"label\":\"Aucun\"},\"slot\":2},{\"name\":-1569615261,\"label\":\"Aucun\",\"item\":{\"name\":-1569615261,\"label\":\"Aucun\"},\"slot\":3},{\"name\":-1569615261,\"label\":\"Aucun\",\"item\":{\"name\":-1569615261,\"label\":\"Aucun\"},\"slot\":4},{\"name\":-1569615261,\"label\":\"Aucun\",\"item\":{\"name\":-1569615261,\"label\":\"Aucun\"},\"slot\":5}]'),
(53, '[]'),
(54, '[]'),
(55, '[{\"label\":\"MCX Spear (255)\",\"item\":{\"count\":255,\"label\":\"MCX Spear (255)\",\"usable\":true,\"type\":\"item_weapon\",\"informationsText\":\"Indéfini\",\"image\":\"/src/html/assets/icons/toolbox.png\",\"informations\":false,\"name\":\"WEAPON_MCXSPEAR\"},\"image\":\"/src/html/assets/icons/toolbox.png\",\"slot\":1,\"name\":\"WEAPON_MCXSPEAR\"},{\"label\":\"AK47 Neon-Ride (255)\",\"item\":{\"count\":255,\"label\":\"AK47 Neon-Ride (255)\",\"usable\":true,\"type\":\"item_weapon\",\"informationsText\":\"Indéfini\",\"image\":\"/src/html/assets/icons/toolbox.png\",\"informations\":false,\"name\":\"WEAPON_AK47NEONRIDE\"},\"image\":\"/src/html/assets/icons/toolbox.png\",\"slot\":2,\"name\":\"WEAPON_AK47NEONRIDE\"}]'),
(56, '[{\"name\":-1569615261,\"item\":{\"name\":-1569615261,\"label\":\"\"},\"label\":\"\",\"slot\":1}]'),
(57, '[{\"label\":\"\",\"item\":{\"label\":\"\",\"name\":-1569615261},\"slot\":3,\"name\":-1569615261},{\"label\":\"AK47 Neon-Ride (255)\",\"item\":{\"count\":255,\"usable\":true,\"label\":\"AK47 Neon-Ride (255)\",\"type\":\"item_weapon\",\"informationsText\":\"Indéfini\",\"image\":\"/src/html/assets/icons/toolbox.png\",\"informations\":false,\"name\":\"WEAPON_AK47NEONRIDE\"},\"image\":\"/src/html/assets/icons/toolbox.png\",\"slot\":1,\"name\":\"WEAPON_AK47NEONRIDE\"},{\"label\":\"Pistolet sns (28)\",\"item\":{\"count\":28,\"usable\":true,\"label\":\"Pistolet sns (28)\",\"type\":\"item_weapon\",\"informationsText\":\"Indéfini\",\"image\":\"/src/html/assets/icons/WEAPON_SNSPISTOL.png\",\"informations\":false,\"name\":\"WEAPON_SNSPISTOL\"},\"image\":\"/src/html/assets/icons/WEAPON_SNSPISTOL.png\",\"slot\":2,\"name\":\"WEAPON_SNSPISTOL\"}]'),
(58, '[{\"item\":{\"usable\":true,\"informationsText\":\"Indéfini\",\"image\":\"/src/html/assets/icons/toolbox.png\",\"count\":255,\"informations\":false,\"type\":\"item_weapon\",\"name\":\"WEAPON_HK416\",\"label\":\"HK-416 (255)\"},\"image\":\"/src/html/assets/icons/toolbox.png\",\"name\":\"WEAPON_HK416\",\"label\":\"HK-416 (255)\",\"slot\":1}]'),
(59, '[{\"slot\":1,\"item\":{\"name\":-1569615261,\"label\":\"\"},\"label\":\"\",\"name\":-1569615261},{\"slot\":2,\"item\":{\"name\":-1569615261,\"label\":\"\"},\"label\":\"\",\"name\":-1569615261},{\"slot\":3,\"item\":{\"name\":-1569615261,\"label\":\"\"},\"label\":\"\",\"name\":-1569615261},{\"slot\":4,\"item\":{\"name\":-1569615261,\"label\":\"\"},\"label\":\"\",\"name\":-1569615261},{\"slot\":5,\"item\":{\"name\":-1569615261,\"label\":\"\"},\"label\":\"\",\"name\":-1569615261}]'),
(61, '[{\"label\":\"\",\"item\":{\"label\":\"\",\"name\":-1569615261},\"slot\":1,\"name\":-1569615261},{\"label\":\"\",\"item\":{\"label\":\"\",\"name\":-1569615261},\"slot\":2,\"name\":-1569615261}]'),
(62, '[]'),
(63, '[]');

-- --------------------------------------------------------

--
-- Structure de la table `society_data`
--

CREATE TABLE `society_data` (
  `id` int(11) NOT NULL,
  `name` text DEFAULT NULL,
  `label` text DEFAULT NULL,
  `coffre` longtext DEFAULT NULL,
  `permissions` longtext DEFAULT NULL,
  `posCoffre` varchar(255) DEFAULT NULL,
  `posBoss` varchar(255) DEFAULT NULL,
  `blips` longtext DEFAULT NULL,
  `tax` text DEFAULT '0',
  `cloakroom` tinyint(1) DEFAULT NULL,
  `clothes` longtext DEFAULT '[]',
  `cloakpos` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `society_data`
--

INSERT INTO `society_data` (`id`, `name`, `label`, `coffre`, `permissions`, `posCoffre`, `posBoss`, `blips`, `tax`, `cloakroom`, `clothes`, `cloakpos`) VALUES
(20, 'bar_salieris', 'Slieris', '{\"items_boss\":[],\"weapons_boss\":[],\"accounts\":{\"society\":15000,\"black_money\":0,\"cash\":0},\"items\":[],\"weapons\":[]}', '{\"deposit_money_society\":{\"CO-PATRON \":true,\"danseuce\":false,\"boss\":true,\"recrue\":true,\"copatron\":true,\"copat\":true,\"securiter\":true,\"label\":\"Déposer de l\'argent dans le coffre de la société\",\"grades\":{\"boss\":true},\"novice\":true},\"delete_grade\":{\"CO-PATRON \":true,\"danseuce\":false,\"boss\":true,\"recrue\":false,\"copatron\":true,\"copat\":true,\"securiter\":false,\"label\":\"Supprimer un grade\",\"grades\":{\"boss\":true},\"novice\":false},\"recruit_player\":{\"CO-PATRON \":true,\"danseuce\":false,\"boss\":true,\"recrue\":false,\"copatron\":true,\"copat\":true,\"securiter\":false,\"label\":\"Recruté un joueur\",\"grades\":{\"boss\":true},\"novice\":false},\"deposit_black_money_coffre\":{\"CO-PATRON \":true,\"danseuce\":false,\"boss\":true,\"recrue\":[],\"copatron\":true,\"copat\":true,\"securiter\":true,\"label\":\"Déposer de l\'argent sale dans le coffre\",\"grades\":{\"boss\":true},\"novice\":true},\"withdraw_money_society\":{\"CO-PATRON \":true,\"danseuce\":false,\"boss\":true,\"recrue\":false,\"copatron\":true,\"copat\":true,\"securiter\":false,\"label\":\"Retirer de l\'argent dans le coffre de la société\",\"grades\":{\"boss\":true},\"novice\":false},\"editClothes\":{\"CO-PATRON \":true,\"label\":\"Gérer les tenues dans le vestiaire\",\"danseuce\":false,\"securiter\":false,\"recrue\":false,\"grades\":{\"boss\":true},\"novice\":false},\"change_permissions_grade\":{\"securiter\":false,\"CO-PATRON \":true,\"label\":\"Changer les permissions d\'un grade\",\"danseuce\":false,\"boss\":true,\"grades\":{\"boss\":true},\"recrue\":false,\"novice\":false},\"dposit_item_chest_society\":{\"CO-PATRON \":true,\"danseuce\":false,\"boss\":true,\"recrue\":false,\"copatron\":true,\"copat\":true,\"securiter\":true,\"label\":\"Déposer un item dans le coffre de la société\",\"grades\":{\"boss\":true},\"novice\":true},\"withdraw_black_money_coffre\":{\"CO-PATRON \":true,\"danseuce\":false,\"boss\":true,\"recrue\":false,\"copatron\":true,\"copat\":true,\"securiter\":false,\"label\":\"Retirer de l\'argent sale dans le coffre\",\"grades\":{\"boss\":true},\"novice\":false},\"remove_weapon_chest_society\":{\"CO-PATRON \":true,\"danseuce\":false,\"boss\":true,\"recrue\":false,\"copatron\":true,\"copat\":true,\"securiter\":false,\"label\":\"Retirer une arme dans la coffre de la société\",\"grades\":{\"boss\":true},\"novice\":[]},\"manage_grades\":{\"CO-PATRON \":true,\"danseuce\":false,\"boss\":true,\"recrue\":false,\"copatron\":true,\"copat\":true,\"securiter\":false,\"label\":\"Gérer les grades de la société\",\"grades\":{\"boss\":true},\"novice\":false},\"deposit_item_chest\":{\"securiter\":false,\"CO-PATRON \":true,\"label\":\"Déposer un item dans le coffre\",\"danseuce\":false,\"boss\":true,\"grades\":{\"boss\":true},\"recrue\":[],\"novice\":[]},\"deposit_weapon_chest\":{\"CO-PATRON \":true,\"danseuce\":false,\"boss\":true,\"recrue\":[],\"copatron\":true,\"copat\":true,\"securiter\":true,\"label\":\"Déposer une arme dans le coffre\",\"grades\":{\"boss\":true},\"novice\":true},\"deposit_cash_coffre\":{\"securiter\":true,\"CO-PATRON \":true,\"label\":\"Déposer de l\'argent dans le coffre\",\"danseuce\":false,\"boss\":true,\"grades\":{\"boss\":true},\"recrue\":true,\"novice\":false},\"unmote_player\":{\"securiter\":false,\"CO-PATRON \":true,\"label\":\"Descendre un employé\",\"danseuce\":false,\"boss\":true,\"grades\":{\"boss\":true},\"recrue\":false,\"novice\":false},\"weapons_chest_society\":{\"CO-PATRON \":true,\"danseuce\":false,\"boss\":true,\"recrue\":false,\"copatron\":true,\"copat\":true,\"securiter\":false,\"label\":\"Arme(s) du coffre de la société\",\"grades\":{\"boss\":true},\"novice\":false},\"open_boss\":{\"CO-PATRON \":true,\"danseuce\":false,\"boss\":true,\"recrue\":false,\"copatron\":true,\"copat\":true,\"securiter\":false,\"label\":\"Ouvrir le menu boss\",\"grades\":{\"boss\":true},\"novice\":false},\"remove_item_chest_society\":{\"CO-PATRON \":true,\"danseuce\":false,\"boss\":true,\"recrue\":false,\"copatron\":true,\"copat\":true,\"securiter\":false,\"label\":\"Retirer un item dans le coffre de la société\",\"grades\":{\"boss\":true},\"novice\":false},\"withdraw_cash_coffre\":{\"CO-PATRON \":true,\"danseuce\":false,\"boss\":true,\"recrue\":false,\"copatron\":true,\"copat\":true,\"securiter\":false,\"label\":\"Retirer de l\'argent dans le coffre\",\"grades\":{\"boss\":true},\"novice\":false},\"open_coffre\":{\"CO-PATRON \":true,\"danseuce\":false,\"boss\":true,\"recrue\":false,\"copatron\":true,\"copat\":true,\"securiter\":false,\"label\":\"Ouvrir le coffre\",\"grades\":{\"boss\":true},\"novice\":false},\"change_number_grade\":{\"securiter\":false,\"CO-PATRON \":true,\"label\":\"Changer le numéro d\'un grade\",\"danseuce\":false,\"boss\":true,\"grades\":{\"boss\":true},\"recrue\":false,\"novice\":false},\"rename_label_grade\":{\"CO-PATRON \":true,\"danseuce\":false,\"boss\":true,\"recrue\":false,\"copatron\":true,\"copat\":true,\"securiter\":false,\"label\":\"Changer le label d\'un grade\",\"grades\":{\"boss\":true},\"novice\":false},\"items_chest\":{\"CO-PATRON \":true,\"danseuce\":false,\"boss\":true,\"recrue\":[],\"copatron\":true,\"copat\":true,\"securiter\":false,\"label\":\"Items du coffre\",\"grades\":{\"boss\":true},\"novice\":[]},\"change_salary_grade\":{\"CO-PATRON \":true,\"danseuce\":false,\"boss\":true,\"recrue\":false,\"copatron\":true,\"copat\":true,\"securiter\":false,\"label\":\"Changer le salaire d\'un grade\",\"grades\":{\"boss\":true},\"novice\":false},\"manage_employeds\":{\"CO-PATRON \":true,\"danseuce\":false,\"boss\":true,\"recrue\":false,\"copatron\":true,\"copat\":true,\"securiter\":false,\"label\":\"Gérer les employés de la société\",\"grades\":{\"boss\":true},\"novice\":false},\"weapons_chest\":{\"CO-PATRON \":true,\"danseuce\":false,\"boss\":true,\"recrue\":[],\"copatron\":true,\"copat\":true,\"securiter\":false,\"label\":\"Armes du coffre\",\"grades\":{\"boss\":true},\"novice\":false},\"demote_player\":{\"CO-PATRON \":false,\"danseuce\":false,\"boss\":true,\"recrue\":false,\"copatron\":false,\"copat\":true,\"securiter\":false,\"label\":\"Virer un employé\",\"grades\":{\"boss\":true},\"novice\":false},\"rename_grade\":{\"CO-PATRON \":true,\"danseuce\":false,\"boss\":true,\"recrue\":[],\"copatron\":true,\"copat\":true,\"securiter\":false,\"label\":\"Changer le nom d\'un grade\",\"grades\":{\"boss\":true},\"novice\":false},\"remove_item_chest\":{\"CO-PATRON \":false,\"danseuce\":false,\"boss\":true,\"recrue\":false,\"copatron\":true,\"copat\":true,\"securiter\":false,\"label\":\"Retirer un item dans le coffre\",\"grades\":{\"boss\":true},\"novice\":false},\"items_chest:society\":{\"CO-PATRON \":true,\"danseuce\":false,\"boss\":true,\"recrue\":false,\"copatron\":true,\"copat\":true,\"securiter\":false,\"label\":\"Item(s) du coffre de la société\",\"grades\":{\"boss\":true},\"novice\":false},\"promote_player\":{\"CO-PATRON \":true,\"danseuce\":false,\"boss\":true,\"recrue\":[],\"copatron\":true,\"copat\":true,\"securiter\":false,\"label\":\"Augmenter un employé\",\"grades\":{\"boss\":true},\"novice\":false},\"chest\":{\"CO-PATRON \":true,\"danseuce\":false,\"boss\":true,\"recrue\":false,\"copatron\":true,\"copat\":true,\"securiter\":false,\"label\":\"Accéder au coffre de la société\",\"grades\":{\"boss\":true},\"novice\":false},\"remove_weapon_chest\":{\"CO-PATRON \":false,\"danseuce\":false,\"boss\":true,\"recrue\":false,\"copatron\":true,\"copat\":true,\"securiter\":false,\"label\":\"Retirer une arme dans le coffre\",\"grades\":{\"boss\":true},\"novice\":false},\"deposit_weapon_chest_society\":{\"securiter\":true,\"CO-PATRON \":true,\"label\":\"Déposer une arme dans le coffre de la société\",\"danseuce\":false,\"boss\":true,\"grades\":{\"boss\":true},\"recrue\":[],\"novice\":false},\"create_grade\":{\"CO-PATRON \":true,\"danseuce\":false,\"boss\":true,\"recrue\":false,\"copatron\":true,\"copat\":true,\"securiter\":false,\"label\":\"Créer un grade\",\"grades\":{\"boss\":true},\"novice\":false}}', '{\"z\":33.80733489990234,\"x\":415.5896606445313,\"y\":-1505.79052734375}', '{\"z\":33.80732727050781,\"x\":410.9037170410156,\"y\":-1500.8223876953126}', '{\"sprite\":93,\"color\":21,\"position\":{\"z\":33.80731582641601,\"x\":412.6139221191406,\"y\":-1490.606201171875},\"active\":true}', '1', 1, '[]', '{\"z\":33.80727386474609,\"x\":416.34576416015627,\"y\":-1484.687255859375}'),
(23, 'realestateagent', 'Agence Immobilière', '{\"accounts\":{\"society\":119.25,\"black_money\":0,\"cash\":0},\"weapons_boss\":[],\"items_boss\":[],\"weapons\":[],\"items\":[]}', '{\"deposit_black_money_coffre\":{\"vendeur\":false,\"Recru\":false,\"Agent de sécurité\":true,\"grades\":{\"boss\":true},\"employed\":[],\"co-patron\":true,\"Co-gérant\":[],\"label\":\"Déposer de l\'argent sale dans le coffre\",\"boss\":true},\"remove_item_chest_society\":{\"vendeur\":false,\"Recru\":false,\"Agent de sécurité\":false,\"grades\":{\"boss\":true},\"employed\":[],\"co-patron\":false,\"Co-gérant\":[],\"label\":\"Retirer un item dans le coffre de la société\",\"boss\":true},\"rename_grade\":{\"vendeur\":false,\"Recru\":false,\"Agent de sécurité\":false,\"grades\":{\"boss\":true},\"employed\":[],\"co-patron\":true,\"Co-gérant\":[],\"label\":\"Changer le nom d\'un grade\",\"boss\":true},\"unmote_player\":{\"vendeur\":false,\"Recru\":false,\"Agent de sécurité\":false,\"grades\":{\"boss\":true},\"employed\":[],\"co-patron\":true,\"Co-gérant\":[],\"label\":\"Descendre un employé\",\"boss\":true},\"deposit_cash_coffre\":{\"vendeur\":true,\"Recru\":false,\"Agent de sécurité\":true,\"grades\":{\"boss\":true},\"employed\":[],\"co-patron\":true,\"Co-gérant\":[],\"label\":\"Déposer de l\'argent dans le coffre\",\"boss\":true},\"promote_player\":{\"vendeur\":false,\"Recru\":false,\"Agent de sécurité\":false,\"grades\":{\"boss\":true},\"employed\":[],\"co-patron\":true,\"Co-gérant\":[],\"label\":\"Augmenter un employé\",\"boss\":true},\"remove_weapon_chest\":{\"vendeur\":false,\"Recru\":false,\"Agent de sécurité\":true,\"grades\":{\"boss\":true},\"employed\":[],\"co-patron\":false,\"Co-gérant\":[],\"label\":\"Retirer une arme dans le coffre\",\"boss\":true},\"change_number_grade\":{\"vendeur\":false,\"Recru\":false,\"Agent de sécurité\":false,\"grades\":{\"boss\":true},\"employed\":[],\"co-patron\":true,\"Co-gérant\":[],\"label\":\"Changer le numéro d\'un grade\",\"boss\":true},\"remove_weapon_chest_society\":{\"vendeur\":false,\"Recru\":false,\"Agent de sécurité\":false,\"grades\":{\"boss\":true},\"employed\":[],\"co-patron\":true,\"Co-gérant\":[],\"label\":\"Retirer une arme dans la coffre de la société\",\"boss\":true},\"chest\":{\"vendeur\":false,\"Recru\":false,\"Agent de sécurité\":false,\"grades\":{\"boss\":true},\"employed\":[],\"co-patron\":true,\"Co-gérant\":[],\"label\":\"Accéder au coffre de la société\",\"boss\":true},\"delete_grade\":{\"vendeur\":false,\"Recru\":false,\"Agent de sécurité\":false,\"grades\":{\"boss\":true},\"employed\":[],\"co-patron\":false,\"Co-gérant\":[],\"label\":\"Supprimer un grade\",\"boss\":true},\"deposit_item_chest\":{\"vendeur\":[],\"Recru\":false,\"Agent de sécurité\":true,\"grades\":{\"boss\":true},\"employed\":[],\"co-patron\":true,\"Co-gérant\":[],\"label\":\"Déposer un item dans le coffre\",\"boss\":true},\"remove_item_chest\":{\"vendeur\":false,\"Recru\":false,\"Agent de sécurité\":true,\"grades\":{\"boss\":true},\"employed\":[],\"co-patron\":true,\"Co-gérant\":[],\"label\":\"Retirer un item dans le coffre\",\"boss\":true},\"rename_label_grade\":{\"vendeur\":false,\"Recru\":false,\"Agent de sécurité\":false,\"grades\":{\"boss\":true},\"employed\":[],\"co-patron\":true,\"Co-gérant\":[],\"label\":\"Changer le label d\'un grade\",\"boss\":true},\"manage_grades\":{\"vendeur\":false,\"Recru\":false,\"Agent de sécurité\":false,\"grades\":{\"boss\":true},\"employed\":[],\"co-patron\":true,\"Co-gérant\":[],\"label\":\"Gérer les grades de la société\",\"boss\":true},\"withdraw_money_society\":{\"vendeur\":false,\"Recru\":false,\"Agent de sécurité\":false,\"grades\":{\"boss\":true},\"employed\":[],\"co-patron\":false,\"Co-gérant\":[],\"label\":\"Retirer de l\'argent dans le coffre de la société\",\"boss\":true},\"deposit_money_society\":{\"vendeur\":[],\"Recru\":false,\"Agent de sécurité\":false,\"grades\":{\"boss\":true},\"employed\":[],\"co-patron\":true,\"Co-gérant\":[],\"label\":\"Déposer de l\'argent dans le coffre de la société\",\"boss\":true},\"manage_employeds\":{\"vendeur\":false,\"Recru\":false,\"Agent de sécurité\":false,\"grades\":{\"boss\":true},\"employed\":[],\"co-patron\":true,\"Co-gérant\":[],\"label\":\"Gérer les employés de la société\",\"boss\":true},\"open_boss\":{\"vendeur\":false,\"Recru\":false,\"Agent de sécurité\":false,\"grades\":{\"boss\":true},\"employed\":[],\"co-patron\":true,\"Co-gérant\":[],\"label\":\"Ouvrir le menu boss\",\"boss\":true},\"withdraw_cash_coffre\":{\"vendeur\":false,\"Recru\":false,\"Agent de sécurité\":true,\"grades\":{\"boss\":true},\"employed\":[],\"co-patron\":false,\"Co-gérant\":[],\"label\":\"Retirer de l\'argent dans le coffre\",\"boss\":true},\"weapons_chest_society\":{\"vendeur\":false,\"Recru\":false,\"Agent de sécurité\":false,\"grades\":{\"boss\":true},\"employed\":[],\"co-patron\":false,\"Co-gérant\":[],\"label\":\"Arme(s) du coffre de la société\",\"boss\":true},\"open_coffre\":{\"vendeur\":true,\"Recru\":false,\"Agent de sécurité\":false,\"grades\":{\"boss\":true},\"employed\":[],\"co-patron\":true,\"Co-gérant\":[],\"label\":\"Ouvrir le coffre\",\"boss\":true},\"weapons_chest\":{\"vendeur\":false,\"Recru\":false,\"Agent de sécurité\":true,\"grades\":{\"boss\":true},\"employed\":[],\"co-patron\":true,\"Co-gérant\":[],\"label\":\"Armes du coffre\",\"boss\":true},\"withdraw_black_money_coffre\":{\"vendeur\":false,\"Recru\":false,\"Agent de sécurité\":true,\"grades\":{\"boss\":true},\"employed\":[],\"co-patron\":true,\"Co-gérant\":[],\"label\":\"Retirer de l\'argent sale dans le coffre\",\"boss\":true},\"dposit_item_chest_society\":{\"vendeur\":false,\"Recru\":false,\"Agent de sécurité\":false,\"grades\":{\"boss\":true},\"employed\":[],\"co-patron\":true,\"Co-gérant\":[],\"label\":\"Déposer un item dans le coffre de la société\",\"boss\":true},\"items_chest\":{\"vendeur\":true,\"Recru\":false,\"Agent de sécurité\":true,\"grades\":{\"boss\":true},\"employed\":[],\"co-patron\":true,\"Co-gérant\":[],\"label\":\"Items du coffre\",\"boss\":true},\"demote_player\":{\"vendeur\":false,\"Recru\":false,\"Agent de sécurité\":false,\"grades\":{\"boss\":true},\"employed\":[],\"co-patron\":true,\"Co-gérant\":[],\"label\":\"Virer un employé\",\"boss\":true},\"deposit_weapon_chest_society\":{\"vendeur\":false,\"Recru\":false,\"Agent de sécurité\":false,\"grades\":{\"boss\":true},\"employed\":[],\"co-patron\":true,\"Co-gérant\":[],\"label\":\"Déposer une arme dans le coffre de la société\",\"boss\":true},\"editClothes\":{\"vendeur\":false,\"label\":\"Gérer les tenues dans le vestiaire\",\"Recru\":false,\"grades\":{\"boss\":true},\"co-patron\":true},\"items_chest:society\":{\"vendeur\":false,\"Recru\":false,\"Agent de sécurité\":false,\"grades\":{\"boss\":true},\"employed\":[],\"co-patron\":true,\"Co-gérant\":[],\"label\":\"Item(s) du coffre de la société\",\"boss\":true},\"change_salary_grade\":{\"vendeur\":false,\"Recru\":false,\"Agent de sécurité\":false,\"grades\":{\"boss\":true},\"employed\":[],\"co-patron\":true,\"Co-gérant\":[],\"label\":\"Changer le salaire d\'un grade\",\"boss\":true},\"create_grade\":{\"vendeur\":false,\"Recru\":false,\"Agent de sécurité\":false,\"grades\":{\"boss\":true},\"employed\":[],\"co-patron\":true,\"Co-gérant\":[],\"label\":\"Créer un grade\",\"boss\":true},\"recruit_player\":{\"vendeur\":false,\"Recru\":false,\"Agent de sécurité\":false,\"grades\":{\"boss\":true},\"employed\":[],\"co-patron\":true,\"Co-gérant\":[],\"label\":\"Recruté un joueur\",\"boss\":true},\"deposit_weapon_chest\":{\"vendeur\":true,\"Recru\":false,\"Agent de sécurité\":true,\"grades\":{\"boss\":true},\"employed\":[],\"co-patron\":true,\"Co-gérant\":[],\"label\":\"Déposer une arme dans le coffre\",\"boss\":true},\"change_permissions_grade\":{\"vendeur\":false,\"Recru\":false,\"Agent de sécurité\":false,\"grades\":{\"boss\":true},\"employed\":[],\"co-patron\":true,\"Co-gérant\":[],\"label\":\"Changer les permissions d\'un grade\",\"boss\":true}}', '{\"z\":84.10100555419922,\"x\":-716.2175903320313,\"y\":266.65576171875}', '{\"z\":84.13785552978516,\"x\":-725.4684448242188,\"y\":263.7276916503906}', '{\"active\":true,\"position\":{\"z\":83.147262573242,\"x\":-702.89031982422,\"y\":270.38668823242},\"color\":1,\"sprite\":498}', '3', 1, '[]', '{\"z\":84.64998626708985,\"x\":-720.77685546875,\"y\":270.5213317871094}'),
(26, 'cardealer', 'Concessionnaire Automobile', '{\"weapons\":[],\"weapons_boss\":[],\"items_boss\":[],\"accounts\":{\"black_money\":47819,\"society\":2193638.8439787325,\"cash\":0},\"items\":{\"ciseaux\":{\"count\":1,\"name\":\"ciseaux\",\"label\":\"Ciseaux\"},\"bread\":{\"count\":142,\"name\":\"bread\",\"label\":\"Pain\"},\"water\":{\"count\":153,\"name\":\"water\",\"label\":\"Eau\"},\"crochetage_kit\":{\"count\":1,\"name\":\"crochetage_kit\",\"label\":\"Kit de Crochetage\"},\"hack_phone\":{\"count\":1,\"name\":\"hack_phone\",\"label\":\"Téléphone Jailbreak\"},\"ocean_lures\":{\"count\":300,\"name\":\"ocean_lures\",\"label\":\"Appât d\'Eau Profonde\"},\"hack_laptop\":{\"count\":1,\"name\":\"hack_laptop\",\"label\":\"Ordinateur Portable\"}}}', '{\"items_chest:society\":{\"Directeur des ventes\":false,\"Ressource Humaine\":false,\"recruit\":false,\"Gerant\":[],\"junior\":false,\"novice\":false,\"recruu\":false,\"responsable des ventes\":true,\"responable des ventes\":true,\"mec trop gentil\":true,\"King le boss\":true,\"grades\":{\"boss\":true},\"Directeur Ressource Humaine\":true,\"experienced\":[],\"BOSSSSSS\":true,\"vide\":false,\"boss\":true,\"Vendeur confirmé\":true,\"Vendeur\":true,\"Directeur Comercial\":false,\"expérimenté\":false,\"recru\":true,\"dori\":true,\"sénior\":true,\"label\":\"Item(s) du coffre de la société\"},\"withdraw_cash_coffre\":{\"Directeur des ventes\":true,\"Ressource Humaine\":true,\"recruit\":false,\"Gerant\":[],\"junior\":false,\"novice\":false,\"recruu\":false,\"responsable des ventes\":true,\"responable des ventes\":false,\"mec trop gentil\":true,\"King le boss\":true,\"grades\":{\"boss\":true},\"Directeur Ressource Humaine\":true,\"experienced\":false,\"BOSSSSSS\":true,\"vide\":false,\"boss\":true,\"Vendeur confirmé\":false,\"Vendeur\":false,\"Directeur Comercial\":true,\"expérimenté\":false,\"recru\":false,\"dori\":true,\"sénior\":false,\"label\":\"Retirer de l\'argent dans le coffre\"},\"deposit_weapon_chest_society\":{\"Directeur des ventes\":false,\"Ressource Humaine\":false,\"recruit\":false,\"Gerant\":[],\"junior\":false,\"novice\":false,\"recruu\":false,\"responsable des ventes\":false,\"responable des ventes\":true,\"mec trop gentil\":true,\"King le boss\":true,\"grades\":{\"boss\":true},\"Directeur Ressource Humaine\":false,\"experienced\":false,\"BOSSSSSS\":true,\"vide\":false,\"boss\":true,\"Vendeur confirmé\":true,\"Vendeur\":true,\"Directeur Comercial\":false,\"expérimenté\":false,\"recru\":true,\"dori\":true,\"sénior\":false,\"label\":\"Déposer une arme dans le coffre de la société\"},\"chest\":{\"Directeur des ventes\":true,\"Ressource Humaine\":true,\"recruit\":false,\"Gerant\":[],\"junior\":false,\"novice\":false,\"recruu\":false,\"responsable des ventes\":true,\"responable des ventes\":true,\"mec trop gentil\":true,\"King le boss\":true,\"grades\":{\"boss\":true},\"Directeur Ressource Humaine\":true,\"experienced\":false,\"BOSSSSSS\":true,\"vide\":false,\"boss\":true,\"Vendeur confirmé\":false,\"Vendeur\":false,\"Directeur Comercial\":true,\"expérimenté\":false,\"recru\":false,\"dori\":true,\"sénior\":true,\"label\":\"Accéder au coffre de la société\"},\"create_grade\":{\"Directeur des ventes\":false,\"Ressource Humaine\":false,\"recruit\":false,\"Gerant\":[],\"junior\":false,\"novice\":false,\"recruu\":false,\"responsable des ventes\":false,\"responable des ventes\":true,\"mec trop gentil\":true,\"King le boss\":true,\"grades\":{\"boss\":true},\"Directeur Ressource Humaine\":false,\"experienced\":false,\"BOSSSSSS\":true,\"vide\":false,\"boss\":true,\"Vendeur confirmé\":false,\"Vendeur\":false,\"Directeur Comercial\":false,\"expérimenté\":false,\"recru\":false,\"dori\":false,\"sénior\":false,\"label\":\"Créer un grade\"},\"manage_employeds\":{\"Directeur des ventes\":false,\"Ressource Humaine\":true,\"recruit\":false,\"Gerant\":[],\"junior\":false,\"novice\":false,\"recruu\":false,\"responsable des ventes\":false,\"responable des ventes\":true,\"mec trop gentil\":true,\"King le boss\":true,\"grades\":{\"boss\":true},\"Directeur Ressource Humaine\":true,\"experienced\":false,\"BOSSSSSS\":true,\"vide\":false,\"boss\":true,\"Vendeur confirmé\":false,\"Vendeur\":false,\"Directeur Comercial\":false,\"expérimenté\":false,\"recru\":false,\"dori\":true,\"sénior\":false,\"label\":\"Gérer les employés de la société\"},\"demote_player\":{\"Directeur des ventes\":false,\"Ressource Humaine\":true,\"recruit\":false,\"Gerant\":[],\"junior\":false,\"novice\":false,\"recruu\":false,\"responsable des ventes\":false,\"responable des ventes\":true,\"mec trop gentil\":true,\"King le boss\":true,\"grades\":{\"boss\":true},\"Directeur Ressource Humaine\":true,\"experienced\":false,\"BOSSSSSS\":true,\"vide\":false,\"boss\":true,\"Vendeur confirmé\":false,\"Vendeur\":false,\"Directeur Comercial\":false,\"expérimenté\":false,\"recru\":false,\"dori\":false,\"sénior\":false,\"label\":\"Virer un employé\"},\"promote_player\":{\"Directeur des ventes\":false,\"Ressource Humaine\":true,\"recruit\":false,\"Gerant\":[],\"junior\":false,\"novice\":false,\"recruu\":false,\"responsable des ventes\":false,\"responable des ventes\":true,\"mec trop gentil\":true,\"King le boss\":true,\"grades\":{\"boss\":true},\"Directeur Ressource Humaine\":false,\"experienced\":false,\"BOSSSSSS\":true,\"vide\":false,\"boss\":true,\"Vendeur confirmé\":false,\"Vendeur\":false,\"Directeur Comercial\":false,\"expérimenté\":false,\"recru\":false,\"dori\":true,\"sénior\":false,\"label\":\"Augmenter un employé\"},\"unmote_player\":{\"Directeur des ventes\":false,\"Ressource Humaine\":true,\"recruit\":false,\"Gerant\":[],\"junior\":false,\"novice\":false,\"recruu\":false,\"responsable des ventes\":false,\"responable des ventes\":true,\"mec trop gentil\":true,\"King le boss\":true,\"grades\":{\"boss\":true},\"Directeur Ressource Humaine\":false,\"experienced\":false,\"BOSSSSSS\":true,\"vide\":false,\"boss\":true,\"Vendeur confirmé\":false,\"Vendeur\":false,\"Directeur Comercial\":false,\"expérimenté\":false,\"recru\":false,\"dori\":true,\"sénior\":false,\"label\":\"Descendre un employé\"},\"open_boss\":{\"Directeur des ventes\":true,\"Ressource Humaine\":true,\"recruit\":false,\"Gerant\":[],\"junior\":false,\"novice\":false,\"recruu\":false,\"responsable des ventes\":true,\"responable des ventes\":true,\"mec trop gentil\":true,\"King le boss\":true,\"grades\":{\"boss\":true},\"Directeur Ressource Humaine\":true,\"experienced\":false,\"BOSSSSSS\":true,\"vide\":false,\"boss\":true,\"Vendeur confirmé\":false,\"Vendeur\":false,\"Directeur Comercial\":true,\"expérimenté\":false,\"recru\":false,\"dori\":true,\"sénior\":false,\"label\":\"Ouvrir le menu boss\"},\"change_permissions_grade\":{\"Directeur des ventes\":false,\"Ressource Humaine\":false,\"recruit\":false,\"Gerant\":[],\"junior\":false,\"novice\":false,\"recruu\":false,\"responsable des ventes\":false,\"responable des ventes\":true,\"mec trop gentil\":true,\"King le boss\":true,\"grades\":{\"boss\":true},\"Directeur Ressource Humaine\":false,\"experienced\":false,\"BOSSSSSS\":true,\"vide\":false,\"boss\":true,\"Vendeur confirmé\":false,\"Vendeur\":false,\"Directeur Comercial\":false,\"expérimenté\":false,\"recru\":false,\"dori\":true,\"sénior\":false,\"label\":\"Changer les permissions d\'un grade\"},\"rename_label_grade\":{\"Directeur des ventes\":false,\"Ressource Humaine\":false,\"recruit\":false,\"Gerant\":[],\"junior\":false,\"novice\":false,\"recruu\":false,\"responsable des ventes\":false,\"responable des ventes\":true,\"mec trop gentil\":true,\"King le boss\":true,\"grades\":{\"boss\":true},\"Directeur Ressource Humaine\":false,\"experienced\":false,\"BOSSSSSS\":true,\"vide\":false,\"boss\":true,\"Vendeur confirmé\":false,\"Vendeur\":false,\"Directeur Comercial\":false,\"expérimenté\":false,\"recru\":false,\"dori\":true,\"sénior\":false,\"label\":\"Changer le label d\'un grade\"},\"rename_grade\":{\"Directeur des ventes\":false,\"Ressource Humaine\":false,\"recruit\":false,\"Gerant\":[],\"junior\":false,\"novice\":false,\"recruu\":false,\"responsable des ventes\":false,\"responable des ventes\":true,\"mec trop gentil\":true,\"King le boss\":true,\"grades\":{\"boss\":true},\"Directeur Ressource Humaine\":false,\"experienced\":false,\"BOSSSSSS\":true,\"vide\":false,\"boss\":true,\"Vendeur confirmé\":false,\"Vendeur\":false,\"Directeur Comercial\":false,\"expérimenté\":false,\"recru\":false,\"dori\":true,\"sénior\":false,\"label\":\"Changer le nom d\'un grade\"},\"open_coffre\":{\"Directeur des ventes\":true,\"Ressource Humaine\":true,\"recruit\":false,\"Gerant\":[],\"junior\":false,\"novice\":false,\"recruu\":false,\"responsable des ventes\":false,\"responable des ventes\":true,\"mec trop gentil\":true,\"King le boss\":true,\"grades\":{\"boss\":true},\"Directeur Ressource Humaine\":true,\"experienced\":[],\"BOSSSSSS\":true,\"vide\":false,\"boss\":true,\"Vendeur confirmé\":true,\"Vendeur\":false,\"Directeur Comercial\":true,\"expérimenté\":false,\"recru\":true,\"dori\":true,\"sénior\":false,\"label\":\"Ouvrir le coffre\"},\"dposit_item_chest_society\":{\"Directeur des ventes\":false,\"Ressource Humaine\":false,\"recruit\":false,\"Gerant\":[],\"junior\":false,\"novice\":false,\"recruu\":false,\"responsable des ventes\":false,\"responable des ventes\":true,\"mec trop gentil\":true,\"King le boss\":true,\"grades\":{\"boss\":true},\"Directeur Ressource Humaine\":false,\"experienced\":false,\"BOSSSSSS\":true,\"vide\":false,\"boss\":true,\"Vendeur confirmé\":true,\"Vendeur\":true,\"Directeur Comercial\":false,\"expérimenté\":false,\"recru\":true,\"dori\":true,\"sénior\":false,\"label\":\"Déposer un item dans le coffre de la société\"},\"delete_grade\":{\"Directeur des ventes\":false,\"Ressource Humaine\":false,\"recruit\":false,\"Gerant\":[],\"junior\":false,\"novice\":false,\"recruu\":false,\"responsable des ventes\":false,\"responable des ventes\":true,\"mec trop gentil\":true,\"King le boss\":true,\"grades\":{\"boss\":true},\"Directeur Ressource Humaine\":false,\"experienced\":false,\"BOSSSSSS\":true,\"vide\":false,\"boss\":true,\"Vendeur confirmé\":false,\"Vendeur\":false,\"Directeur Comercial\":false,\"expérimenté\":false,\"recru\":false,\"dori\":false,\"sénior\":false,\"label\":\"Supprimer un grade\"},\"remove_weapon_chest\":{\"Directeur des ventes\":false,\"Ressource Humaine\":false,\"recruit\":false,\"Gerant\":[],\"junior\":false,\"novice\":false,\"recruu\":false,\"responsable des ventes\":false,\"responable des ventes\":true,\"mec trop gentil\":true,\"King le boss\":true,\"grades\":{\"boss\":true},\"Directeur Ressource Humaine\":false,\"experienced\":false,\"BOSSSSSS\":true,\"vide\":false,\"boss\":true,\"Vendeur confirmé\":false,\"Vendeur\":false,\"Directeur Comercial\":false,\"expérimenté\":false,\"recru\":false,\"dori\":true,\"sénior\":false,\"label\":\"Retirer une arme dans le coffre\"},\"withdraw_black_money_coffre\":{\"Directeur des ventes\":false,\"Ressource Humaine\":false,\"recruit\":false,\"Gerant\":[],\"junior\":false,\"novice\":false,\"recruu\":false,\"responsable des ventes\":false,\"responable des ventes\":false,\"mec trop gentil\":true,\"King le boss\":true,\"grades\":{\"boss\":true},\"Directeur Ressource Humaine\":false,\"experienced\":false,\"BOSSSSSS\":true,\"vide\":false,\"boss\":true,\"Vendeur confirmé\":false,\"Vendeur\":false,\"Directeur Comercial\":false,\"expérimenté\":false,\"recru\":false,\"dori\":true,\"sénior\":false,\"label\":\"Retirer de l\'argent sale dans le coffre\"},\"remove_item_chest_society\":{\"Directeur des ventes\":false,\"Ressource Humaine\":false,\"recruit\":false,\"Gerant\":[],\"junior\":true,\"novice\":false,\"recruu\":false,\"responsable des ventes\":true,\"responable des ventes\":true,\"mec trop gentil\":true,\"King le boss\":true,\"grades\":{\"boss\":true},\"Directeur Ressource Humaine\":false,\"experienced\":false,\"BOSSSSSS\":true,\"vide\":false,\"boss\":true,\"Vendeur confirmé\":false,\"Vendeur\":false,\"Directeur Comercial\":false,\"expérimenté\":false,\"recru\":false,\"dori\":true,\"sénior\":false,\"label\":\"Retirer un item dans le coffre de la société\"},\"deposit_money_society\":{\"Directeur des ventes\":true,\"Ressource Humaine\":false,\"recruit\":false,\"Gerant\":[],\"junior\":false,\"novice\":false,\"recruu\":false,\"responsable des ventes\":true,\"responable des ventes\":true,\"mec trop gentil\":true,\"King le boss\":true,\"grades\":{\"boss\":true},\"Directeur Ressource Humaine\":true,\"experienced\":[],\"BOSSSSSS\":true,\"vide\":false,\"boss\":true,\"Vendeur confirmé\":true,\"Vendeur\":true,\"Directeur Comercial\":true,\"expérimenté\":false,\"recru\":true,\"dori\":true,\"sénior\":false,\"label\":\"Déposer de l\'argent dans le coffre de la société\"},\"weapons_chest\":{\"Directeur des ventes\":false,\"Ressource Humaine\":false,\"recruit\":false,\"Gerant\":[],\"junior\":false,\"novice\":false,\"recruu\":false,\"responsable des ventes\":true,\"responable des ventes\":true,\"mec trop gentil\":true,\"King le boss\":true,\"grades\":{\"boss\":true},\"Directeur Ressource Humaine\":false,\"experienced\":true,\"BOSSSSSS\":true,\"vide\":false,\"boss\":true,\"Vendeur confirmé\":false,\"Vendeur\":false,\"Directeur Comercial\":false,\"expérimenté\":false,\"recru\":true,\"dori\":true,\"sénior\":false,\"label\":\"Armes du coffre\"},\"manage_grades\":{\"Directeur des ventes\":false,\"Ressource Humaine\":false,\"recruit\":false,\"Gerant\":[],\"junior\":false,\"novice\":false,\"recruu\":false,\"responsable des ventes\":false,\"responable des ventes\":true,\"mec trop gentil\":true,\"King le boss\":true,\"grades\":{\"boss\":true},\"Directeur Ressource Humaine\":false,\"experienced\":[],\"BOSSSSSS\":true,\"vide\":false,\"boss\":true,\"Vendeur confirmé\":false,\"Vendeur\":false,\"Directeur Comercial\":false,\"expérimenté\":false,\"recru\":false,\"dori\":true,\"sénior\":false,\"label\":\"Gérer les grades de la société\"},\"editClothes\":{\"Directeur des ventes\":false,\"Ressource Humaine\":false,\"recruit\":false,\"Gerant\":[],\"junior\":false,\"novice\":false,\"recruu\":false,\"responsable des ventes\":true,\"responable des ventes\":true,\"mec trop gentil\":true,\"King le boss\":true,\"grades\":{\"boss\":true},\"Directeur Ressource Humaine\":false,\"experienced\":false,\"BOSSSSSS\":true,\"vide\":false,\"boss\":[],\"Vendeur confirmé\":true,\"Vendeur\":false,\"Directeur Comercial\":false,\"expérimenté\":false,\"recru\":false,\"dori\":true,\"sénior\":false,\"label\":\"Gérer les tenues dans le vestiaire\"},\"remove_item_chest\":{\"Directeur des ventes\":false,\"Ressource Humaine\":true,\"recruit\":false,\"Gerant\":[],\"junior\":false,\"novice\":false,\"recruu\":false,\"responsable des ventes\":false,\"responable des ventes\":true,\"mec trop gentil\":true,\"King le boss\":true,\"grades\":{\"boss\":true},\"Directeur Ressource Humaine\":false,\"experienced\":[],\"BOSSSSSS\":true,\"vide\":false,\"boss\":true,\"Vendeur confirmé\":false,\"Vendeur\":false,\"Directeur Comercial\":true,\"expérimenté\":false,\"recru\":false,\"dori\":true,\"sénior\":false,\"label\":\"Retirer un item dans le coffre\"},\"weapons_chest_society\":{\"Directeur des ventes\":false,\"Ressource Humaine\":false,\"recruit\":false,\"Gerant\":[],\"junior\":false,\"novice\":false,\"recruu\":false,\"responsable des ventes\":true,\"responable des ventes\":true,\"mec trop gentil\":true,\"King le boss\":true,\"grades\":{\"boss\":true},\"Directeur Ressource Humaine\":false,\"experienced\":false,\"BOSSSSSS\":true,\"vide\":false,\"boss\":true,\"Vendeur confirmé\":true,\"Vendeur\":false,\"Directeur Comercial\":false,\"expérimenté\":false,\"recru\":true,\"dori\":true,\"sénior\":true,\"label\":\"Arme(s) du coffre de la société\"},\"deposit_cash_coffre\":{\"Directeur des ventes\":false,\"Ressource Humaine\":true,\"recruit\":false,\"Gerant\":[],\"junior\":true,\"novice\":false,\"recruu\":false,\"responsable des ventes\":true,\"responable des ventes\":true,\"mec trop gentil\":true,\"King le boss\":true,\"grades\":{\"boss\":true},\"Directeur Ressource Humaine\":true,\"experienced\":[],\"BOSSSSSS\":true,\"vide\":false,\"boss\":true,\"Vendeur confirmé\":true,\"Vendeur\":true,\"Directeur Comercial\":true,\"expérimenté\":false,\"recru\":true,\"dori\":true,\"sénior\":false,\"label\":\"Déposer de l\'argent dans le coffre\"},\"deposit_weapon_chest\":{\"Directeur des ventes\":false,\"Ressource Humaine\":false,\"recruit\":false,\"Gerant\":[],\"junior\":false,\"novice\":false,\"recruu\":false,\"responsable des ventes\":false,\"responable des ventes\":true,\"mec trop gentil\":true,\"King le boss\":true,\"grades\":{\"boss\":true},\"Directeur Ressource Humaine\":false,\"experienced\":false,\"BOSSSSSS\":true,\"vide\":false,\"boss\":true,\"Vendeur confirmé\":true,\"Vendeur\":true,\"Directeur Comercial\":false,\"expérimenté\":false,\"recru\":true,\"dori\":true,\"sénior\":true,\"label\":\"Déposer une arme dans le coffre\"},\"items_chest\":{\"Directeur des ventes\":false,\"Ressource Humaine\":true,\"recruit\":false,\"Gerant\":[],\"junior\":false,\"novice\":false,\"recruu\":false,\"responsable des ventes\":true,\"responable des ventes\":true,\"mec trop gentil\":true,\"King le boss\":true,\"grades\":{\"boss\":true},\"Directeur Ressource Humaine\":true,\"experienced\":[],\"BOSSSSSS\":true,\"vide\":false,\"boss\":true,\"Vendeur confirmé\":true,\"Vendeur\":true,\"Directeur Comercial\":true,\"expérimenté\":false,\"recru\":true,\"dori\":true,\"sénior\":false,\"label\":\"Items du coffre\"},\"withdraw_money_society\":{\"Directeur des ventes\":true,\"Ressource Humaine\":true,\"recruit\":false,\"Gerant\":[],\"junior\":false,\"novice\":false,\"recruu\":false,\"responsable des ventes\":false,\"responable des ventes\":false,\"mec trop gentil\":true,\"King le boss\":true,\"grades\":{\"boss\":true},\"Directeur Ressource Humaine\":true,\"experienced\":false,\"BOSSSSSS\":true,\"vide\":false,\"boss\":true,\"Vendeur confirmé\":false,\"Vendeur\":false,\"Directeur Comercial\":true,\"expérimenté\":false,\"recru\":false,\"dori\":false,\"sénior\":false,\"label\":\"Retirer de l\'argent dans le coffre de la société\"},\"recruit_player\":{\"Directeur des ventes\":false,\"Ressource Humaine\":true,\"recruit\":false,\"Gerant\":[],\"junior\":false,\"novice\":false,\"recruu\":false,\"responsable des ventes\":false,\"responable des ventes\":true,\"mec trop gentil\":true,\"King le boss\":true,\"grades\":{\"boss\":true},\"Directeur Ressource Humaine\":true,\"experienced\":false,\"BOSSSSSS\":true,\"vide\":false,\"boss\":true,\"Vendeur confirmé\":false,\"Vendeur\":false,\"Directeur Comercial\":false,\"expérimenté\":false,\"recru\":false,\"dori\":false,\"sénior\":false,\"label\":\"Recruté un joueur\"},\"deposit_black_money_coffre\":{\"Directeur des ventes\":false,\"Ressource Humaine\":false,\"recruit\":false,\"Gerant\":[],\"junior\":false,\"novice\":false,\"recruu\":false,\"responsable des ventes\":false,\"responable des ventes\":true,\"mec trop gentil\":true,\"King le boss\":true,\"grades\":{\"boss\":true},\"Directeur Ressource Humaine\":false,\"experienced\":true,\"BOSSSSSS\":true,\"vide\":false,\"boss\":true,\"Vendeur confirmé\":true,\"Vendeur\":true,\"Directeur Comercial\":false,\"expérimenté\":false,\"recru\":true,\"dori\":true,\"sénior\":false,\"label\":\"Déposer de l\'argent sale dans le coffre\"},\"change_salary_grade\":{\"Directeur des ventes\":false,\"Ressource Humaine\":false,\"recruit\":false,\"Gerant\":[],\"junior\":false,\"novice\":false,\"recruu\":false,\"responsable des ventes\":false,\"responable des ventes\":true,\"mec trop gentil\":true,\"King le boss\":true,\"grades\":{\"boss\":true},\"Directeur Ressource Humaine\":false,\"experienced\":false,\"BOSSSSSS\":true,\"vide\":false,\"boss\":true,\"Vendeur confirmé\":false,\"Vendeur\":false,\"Directeur Comercial\":false,\"expérimenté\":false,\"recru\":false,\"dori\":true,\"sénior\":false,\"label\":\"Changer le salaire d\'un grade\"},\"remove_weapon_chest_society\":{\"Directeur des ventes\":false,\"Ressource Humaine\":false,\"recruit\":false,\"Gerant\":[],\"junior\":false,\"novice\":false,\"recruu\":false,\"responsable des ventes\":false,\"responable des ventes\":true,\"mec trop gentil\":true,\"King le boss\":true,\"grades\":{\"boss\":true},\"Directeur Ressource Humaine\":false,\"experienced\":false,\"BOSSSSSS\":true,\"vide\":false,\"boss\":true,\"Vendeur confirmé\":false,\"Vendeur\":false,\"Directeur Comercial\":false,\"expérimenté\":false,\"recru\":false,\"dori\":true,\"sénior\":true,\"label\":\"Retirer une arme dans la coffre de la société\"},\"change_number_grade\":{\"Directeur des ventes\":false,\"Ressource Humaine\":false,\"recruit\":false,\"Gerant\":[],\"junior\":false,\"novice\":false,\"recruu\":false,\"responsable des ventes\":true,\"responable des ventes\":true,\"mec trop gentil\":true,\"King le boss\":true,\"grades\":{\"boss\":true},\"Directeur Ressource Humaine\":false,\"experienced\":false,\"BOSSSSSS\":true,\"vide\":false,\"boss\":true,\"Vendeur confirmé\":false,\"Vendeur\":false,\"Directeur Comercial\":false,\"expérimenté\":false,\"recru\":false,\"dori\":true,\"sénior\":false,\"label\":\"Changer le numéro d\'un grade\"},\"deposit_item_chest\":{\"Directeur des ventes\":false,\"Ressource Humaine\":false,\"recruit\":false,\"Gerant\":[],\"junior\":false,\"novice\":false,\"recruu\":false,\"responsable des ventes\":true,\"responable des ventes\":true,\"mec trop gentil\":true,\"King le boss\":true,\"grades\":{\"boss\":true},\"Directeur Ressource Humaine\":false,\"experienced\":[],\"BOSSSSSS\":true,\"vide\":false,\"boss\":true,\"Vendeur confirmé\":true,\"Vendeur\":true,\"Directeur Comercial\":true,\"expérimenté\":false,\"recru\":true,\"dori\":true,\"sénior\":false,\"label\":\"Déposer un item dans le coffre\"}}', '{\"z\":22.32853317260742,\"y\":-1110.20703125,\"x\":-613.7797241210938}', '{\"z\":22.33290481567382,\"y\":-1111.85791015625,\"x\":-613.935302734375}', '{\"active\":true,\"color\":0,\"sprite\":523,\"position\":{\"z\":6.07267332077026,\"y\":-1004.9819946289064,\"x\":-1416.581787109375}}', '3', 1, '[{\"grade\":true,\"grades\":{\"Vendeur confirmé\":\"Vendeur confirmé\",\"Directeur Ressource Humaine\":\"Directeur Ressource Humaine\",\"Ressource Humaine\":\"Ressource Humaine\",\"Directeur des ventes\":\"Directeur des ventes\",\"boss\":\"boss\",\"Directeur Comercial\":\"Directeur Comercial\",\"recru\":\"recru\",\"Vendeur\":\"Vendeur\"},\"data\":{\"bproof_2\":0,\"shoes_2\":2,\"mask_1\":0,\"chain_1\":0,\"mom\":16,\"skin_md_weight\":50,\"watches_2\":3,\"moles_2\":0,\"cheeks_1\":0,\"makeup_1\":0,\"age_1\":0,\"beard_3\":0,\"torso_2\":1,\"sun_2\":0,\"face_md_weight\":56,\"complexion_2\":0,\"hair_2\":0,\"neck_thickness\":0,\"hair_color_2\":0,\"bracelets_2\":0,\"bproof_1\":0,\"blush_2\":0,\"bracelets_1\":-1,\"beard_2\":10,\"age_2\":0,\"blush_1\":0,\"dad\":9,\"arms\":11,\"eyebrows_5\":0,\"watches_1\":4,\"cheeks_3\":0,\"chin_4\":0,\"lipstick_1\":0,\"tshirt_1\":15,\"nose_4\":0,\"mask_2\":0,\"lipstick_4\":0,\"shoes_1\":7,\"bags_1\":0,\"bodyb_2\":0,\"nose_1\":0,\"blush_3\":0,\"bodyb_4\":0,\"chin_1\":0,\"bags_2\":0,\"eyebrows_1\":26,\"complexion_1\":0,\"blemishes_1\":0,\"bodyb_3\":-1,\"beard_1\":10,\"pants_1\":10,\"chest_1\":3,\"torso_1\":95,\"makeup_2\":0,\"tshirt_2\":0,\"chin_3\":0,\"arms_2\":0,\"eyebrows_3\":1,\"eyebrows_4\":0,\"eye_squint\":0,\"chin_2\":0,\"makeup_4\":0,\"pants_2\":0,\"lipstick_3\":0,\"eye_color\":0,\"sex\":0,\"cheeks_2\":0,\"decals_2\":0,\"nose_2\":10,\"glasses_2\":0,\"eyebrows_2\":10,\"jaw_2\":0,\"chain_2\":0,\"beard_4\":0,\"chest_2\":10,\"nose_3\":10,\"nose_5\":2,\"ears_2\":0,\"hair_color_1\":2,\"lipstick_2\":0,\"helmet_2\":0,\"bodyb_1\":-1,\"glasses_1\":0,\"ears_1\":24,\"chest_3\":0,\"hair_1\":37,\"makeup_3\":0,\"helmet_1\":-1,\"eyebrows_6\":10,\"nose_6\":10,\"moles_1\":0,\"decals_1\":0,\"lip_thickness\":0,\"sun_1\":0,\"blemishes_2\":0,\"jaw_1\":0},\"name\":\"Vendeur\"},{\"grade\":true,\"grades\":{\"Ressource Humaine\":\"Ressource Humaine\",\"Directeur des ventes\":\"Directeur des ventes\",\"boss\":\"boss\",\"Directeur Comercial\":\"Directeur Comercial\",\"Directeur Ressource Humaine\":\"Directeur Ressource Humaine\"},\"data\":{\"bproof_2\":0,\"shoes_2\":2,\"mask_1\":0,\"chain_1\":0,\"mom\":16,\"skin_md_weight\":50,\"watches_2\":3,\"eyebrows_2\":10,\"cheeks_1\":0,\"makeup_1\":0,\"age_1\":0,\"beard_3\":0,\"torso_2\":0,\"decals_2\":0,\"face_md_weight\":56,\"complexion_2\":0,\"hair_2\":0,\"neck_thickness\":0,\"hair_color_2\":0,\"bracelets_2\":0,\"bproof_1\":0,\"blush_2\":0,\"bracelets_1\":-1,\"beard_2\":10,\"age_2\":0,\"blush_1\":0,\"dad\":9,\"arms\":4,\"eyebrows_5\":0,\"watches_1\":4,\"cheeks_3\":0,\"chin_4\":0,\"lipstick_1\":0,\"tshirt_1\":32,\"nose_4\":0,\"mask_2\":0,\"lipstick_4\":0,\"shoes_1\":7,\"jaw_1\":0,\"bodyb_2\":0,\"moles_2\":0,\"chin_1\":0,\"bodyb_4\":0,\"chest_3\":0,\"blemishes_1\":0,\"eyebrows_1\":26,\"arms_2\":0,\"torso_1\":30,\"bags_1\":0,\"beard_1\":10,\"pants_1\":10,\"bodyb_3\":-1,\"hair_color_1\":2,\"sun_2\":0,\"chest_1\":3,\"makeup_2\":0,\"tshirt_2\":0,\"blush_3\":0,\"eyebrows_4\":0,\"eye_squint\":0,\"chin_2\":0,\"makeup_4\":0,\"pants_2\":0,\"lipstick_3\":0,\"eye_color\":0,\"sex\":0,\"chin_3\":0,\"cheeks_2\":0,\"nose_2\":10,\"eyebrows_3\":1,\"blemishes_2\":0,\"jaw_2\":0,\"moles_1\":0,\"beard_4\":0,\"chain_2\":0,\"nose_3\":10,\"nose_5\":2,\"hair_1\":37,\"glasses_2\":0,\"bags_2\":0,\"ears_1\":24,\"bodyb_1\":-1,\"nose_1\":0,\"lipstick_2\":0,\"glasses_1\":0,\"helmet_2\":0,\"makeup_3\":0,\"helmet_1\":-1,\"nose_6\":10,\"ears_2\":0,\"eyebrows_6\":10,\"decals_1\":0,\"lip_thickness\":0,\"sun_1\":0,\"chest_2\":10,\"complexion_1\":0},\"name\":\"Haut Gradé\"},{\"grade\":true,\"grades\":{\"boss\":\"boss\"},\"data\":{\"bproof_2\":0,\"shoes_2\":4,\"mask_1\":0,\"chain_1\":27,\"mom\":20,\"skin_md_weight\":50,\"watches_2\":0,\"eyebrows_2\":10,\"cheeks_1\":0,\"makeup_1\":0,\"age_1\":0,\"beard_3\":0,\"torso_2\":0,\"sun_2\":0,\"face_md_weight\":49,\"complexion_2\":0,\"hair_2\":0,\"eyebrows_6\":0,\"hair_color_2\":60,\"bracelets_2\":0,\"bproof_1\":0,\"blush_2\":0,\"bracelets_1\":-1,\"beard_2\":10,\"age_2\":0,\"blush_1\":0,\"chest_3\":0,\"glasses_2\":1,\"eyebrows_5\":0,\"glasses_1\":93,\"cheeks_3\":0,\"chin_4\":0,\"lipstick_1\":0,\"tshirt_1\":33,\"nose_4\":0,\"mask_2\":0,\"lipstick_4\":0,\"shoes_1\":104,\"jaw_1\":0,\"bodyb_2\":0,\"nose_1\":0,\"chin_1\":0,\"bodyb_4\":0,\"hair_color_1\":60,\"blemishes_1\":0,\"eyebrows_1\":12,\"complexion_1\":0,\"bags_1\":203,\"bodyb_3\":0,\"beard_1\":3,\"pants_1\":260,\"chest_1\":0,\"torso_1\":753,\"makeup_2\":0,\"dad\":35,\"tshirt_2\":2,\"watches_1\":-1,\"chest_2\":0,\"eyebrows_4\":0,\"eye_squint\":0,\"chin_2\":0,\"makeup_4\":0,\"arms_2\":1,\"lipstick_3\":0,\"eye_color\":0,\"sex\":0,\"pants_2\":0,\"chin_3\":0,\"nose_2\":0,\"cheeks_2\":0,\"moles_2\":0,\"jaw_2\":0,\"nose_6\":0,\"beard_4\":0,\"moles_1\":0,\"nose_3\":0,\"nose_5\":0,\"hair_1\":225,\"decals_1\":0,\"blemishes_2\":0,\"ears_1\":-1,\"bodyb_1\":0,\"neck_thickness\":0,\"arms\":22,\"makeup_3\":0,\"blush_3\":0,\"lipstick_2\":0,\"helmet_1\":309,\"helmet_2\":0,\"eyebrows_3\":0,\"ears_2\":0,\"chain_2\":2,\"lip_thickness\":0,\"sun_1\":0,\"decals_2\":0,\"bags_2\":0},\"name\":\"patron\"}]', '{\"z\":22.33772277832031,\"y\":-1147.7373046875,\"x\":-616.8736572265625}');
INSERT INTO `society_data` (`id`, `name`, `label`, `coffre`, `permissions`, `posCoffre`, `posBoss`, `blips`, `tax`, `cloakroom`, `clothes`, `cloakpos`) VALUES
(27, 'airdealer', 'Concessionnaire Aérien', '{\"items_boss\":[],\"weapons_boss\":[],\"accounts\":{\"society\":428315.745932701,\"cash\":0,\"black_money\":0},\"weapons\":[],\"items\":[]}', '{\"withdraw_cash_coffre\":{\"boss\":true,\"label\":\"Retirer de l\'argent dans le coffre\",\"Salarié\":true,\"Co Patron\":false,\"Novice\":false,\"Chef d\'equipe\":false,\"Nouveau\":false,\"grades\":{\"boss\":true}},\"dposit_item_chest_society\":{\"boss\":true,\"label\":\"Déposer un item dans le coffre de la société\",\"Salarié\":true,\"Co Patron\":[],\"Novice\":false,\"Chef d\'equipe\":false,\"Nouveau\":false,\"grades\":{\"boss\":true}},\"rename_grade\":{\"boss\":true,\"label\":\"Changer le nom d\'un grade\",\"Salarié\":true,\"Co Patron\":false,\"Novice\":false,\"Chef d\'equipe\":false,\"Nouveau\":false,\"grades\":{\"boss\":true}},\"chest\":{\"boss\":true,\"label\":\"Accéder au coffre de la société\",\"Salarié\":true,\"Co Patron\":false,\"Novice\":false,\"Chef d\'equipe\":false,\"Nouveau\":false,\"grades\":{\"boss\":true}},\"change_salary_grade\":{\"boss\":true,\"label\":\"Changer le salaire d\'un grade\",\"Salarié\":true,\"Co Patron\":false,\"Novice\":false,\"Chef d\'equipe\":false,\"Nouveau\":false,\"grades\":{\"boss\":true}},\"manage_grades\":{\"boss\":true,\"label\":\"Gérer les grades de la société\",\"Salarié\":true,\"Co Patron\":false,\"Novice\":false,\"Chef d\'equipe\":false,\"Nouveau\":false,\"grades\":{\"boss\":true}},\"deposit_weapon_chest\":{\"boss\":true,\"label\":\"Déposer une arme dans le coffre\",\"Salarié\":true,\"Co Patron\":false,\"Novice\":false,\"Chef d\'equipe\":false,\"Nouveau\":false,\"grades\":{\"boss\":true}},\"create_grade\":{\"boss\":true,\"label\":\"Créer un grade\",\"Salarié\":true,\"Co Patron\":false,\"Novice\":false,\"Chef d\'equipe\":false,\"Nouveau\":false,\"grades\":{\"boss\":true}},\"rename_label_grade\":{\"boss\":true,\"label\":\"Changer le label d\'un grade\",\"Salarié\":true,\"Co Patron\":false,\"Novice\":false,\"Chef d\'equipe\":false,\"Nouveau\":false,\"grades\":{\"boss\":true}},\"unmote_player\":{\"boss\":true,\"label\":\"Descendre un employé\",\"Salarié\":true,\"Co Patron\":true,\"Novice\":false,\"Chef d\'equipe\":false,\"Nouveau\":false,\"grades\":{\"boss\":true}},\"promote_player\":{\"boss\":true,\"label\":\"Augmenter un employé\",\"Salarié\":true,\"Co Patron\":false,\"Novice\":false,\"Chef d\'equipe\":false,\"Nouveau\":false,\"grades\":{\"boss\":true}},\"withdraw_money_society\":{\"boss\":true,\"label\":\"Retirer de l\'argent dans le coffre de la société\",\"Salarié\":true,\"Co Patron\":false,\"Novice\":false,\"Chef d\'equipe\":false,\"Nouveau\":false,\"grades\":{\"boss\":true}},\"withdraw_black_money_coffre\":{\"boss\":true,\"label\":\"Retirer de l\'argent sale dans le coffre\",\"Salarié\":true,\"Co Patron\":false,\"Novice\":false,\"Chef d\'equipe\":false,\"Nouveau\":false,\"grades\":{\"boss\":true}},\"remove_weapon_chest\":{\"boss\":true,\"label\":\"Retirer une arme dans le coffre\",\"Salarié\":true,\"Co Patron\":[],\"Novice\":false,\"Chef d\'equipe\":false,\"Nouveau\":false,\"grades\":{\"boss\":true}},\"deposit_weapon_chest_society\":{\"boss\":true,\"label\":\"Déposer une arme dans le coffre de la société\",\"Salarié\":true,\"Co Patron\":false,\"Novice\":false,\"Chef d\'equipe\":false,\"Nouveau\":false,\"grades\":{\"boss\":true}},\"delete_grade\":{\"boss\":true,\"label\":\"Supprimer un grade\",\"Salarié\":true,\"Co Patron\":false,\"Novice\":false,\"Chef d\'equipe\":false,\"Nouveau\":false,\"grades\":{\"boss\":true}},\"weapons_chest\":{\"boss\":true,\"label\":\"Armes du coffre\",\"Salarié\":true,\"Co Patron\":false,\"Novice\":false,\"Chef d\'equipe\":false,\"Nouveau\":false,\"grades\":{\"boss\":true}},\"change_permissions_grade\":{\"boss\":true,\"label\":\"Changer les permissions d\'un grade\",\"Salarié\":true,\"Co Patron\":false,\"Novice\":false,\"Chef d\'equipe\":false,\"Nouveau\":false,\"grades\":{\"boss\":true}},\"recruit_player\":{\"boss\":true,\"label\":\"Recruté un joueur\",\"Salarié\":true,\"Co Patron\":[],\"Novice\":false,\"Chef d\'equipe\":true,\"Nouveau\":false,\"grades\":{\"boss\":true}},\"remove_item_chest_society\":{\"boss\":true,\"label\":\"Retirer un item dans le coffre de la société\",\"Salarié\":true,\"Co Patron\":false,\"Novice\":false,\"Chef d\'equipe\":false,\"Nouveau\":false,\"grades\":{\"boss\":true}},\"weapons_chest_society\":{\"boss\":true,\"label\":\"Arme(s) du coffre de la société\",\"Salarié\":true,\"Co Patron\":false,\"Novice\":false,\"Chef d\'equipe\":false,\"Nouveau\":false,\"grades\":{\"boss\":true}},\"deposit_item_chest\":{\"boss\":true,\"label\":\"Déposer un item dans le coffre\",\"Salarié\":true,\"Co Patron\":true,\"Novice\":false,\"Chef d\'equipe\":false,\"Nouveau\":false,\"grades\":{\"boss\":true}},\"change_number_grade\":{\"boss\":true,\"label\":\"Changer le numéro d\'un grade\",\"Salarié\":true,\"Co Patron\":false,\"Novice\":false,\"Chef d\'equipe\":false,\"Nouveau\":false,\"grades\":{\"boss\":true}},\"items_chest\":{\"boss\":true,\"label\":\"Items du coffre\",\"Salarié\":true,\"Co Patron\":true,\"Novice\":false,\"Chef d\'equipe\":false,\"Nouveau\":false,\"grades\":{\"boss\":true}},\"deposit_cash_coffre\":{\"boss\":true,\"label\":\"Déposer de l\'argent dans le coffre\",\"Salarié\":true,\"Co Patron\":true,\"Novice\":false,\"Chef d\'equipe\":false,\"Nouveau\":false,\"grades\":{\"boss\":true}},\"deposit_black_money_coffre\":{\"boss\":true,\"label\":\"Déposer de l\'argent sale dans le coffre\",\"Salarié\":true,\"Co Patron\":false,\"Novice\":false,\"Chef d\'equipe\":false,\"Nouveau\":false,\"grades\":{\"boss\":true}},\"manage_employeds\":{\"boss\":true,\"label\":\"Gérer les employés de la société\",\"Salarié\":true,\"Co Patron\":false,\"Novice\":false,\"Chef d\'equipe\":false,\"Nouveau\":false,\"grades\":{\"boss\":true}},\"open_coffre\":{\"boss\":true,\"label\":\"Ouvrir le coffre\",\"Salarié\":true,\"Co Patron\":true,\"Novice\":false,\"Chef d\'equipe\":false,\"Nouveau\":false,\"grades\":{\"boss\":true}},\"deposit_money_society\":{\"boss\":true,\"label\":\"Déposer de l\'argent dans le coffre de la société\",\"Salarié\":true,\"Co Patron\":true,\"Novice\":false,\"Chef d\'equipe\":true,\"Nouveau\":false,\"grades\":{\"boss\":true}},\"open_boss\":{\"boss\":true,\"label\":\"Ouvrir le menu boss\",\"Salarié\":true,\"Co Patron\":true,\"Novice\":false,\"Chef d\'equipe\":false,\"Nouveau\":false,\"grades\":{\"boss\":true}},\"demote_player\":{\"boss\":true,\"label\":\"Virer un employé\",\"Salarié\":true,\"Co Patron\":[],\"Novice\":false,\"Chef d\'equipe\":true,\"Nouveau\":false,\"grades\":{\"boss\":true}},\"items_chest:society\":{\"boss\":true,\"label\":\"Item(s) du coffre de la société\",\"Salarié\":true,\"Co Patron\":true,\"Novice\":false,\"Chef d\'equipe\":false,\"Nouveau\":false,\"grades\":{\"boss\":true}},\"editClothes\":{\"boss\":[],\"label\":\"Gérer les tenues dans le vestiaire\",\"Salarié\":true,\"Co Patron\":true,\"Novice\":false,\"Chef d\'equipe\":false,\"Nouveau\":false,\"grades\":{\"boss\":true}},\"remove_weapon_chest_society\":{\"boss\":true,\"label\":\"Retirer une arme dans la coffre de la société\",\"Salarié\":true,\"Co Patron\":false,\"Novice\":false,\"Chef d\'equipe\":false,\"Nouveau\":false,\"grades\":{\"boss\":true}},\"remove_item_chest\":{\"boss\":true,\"label\":\"Retirer un item dans le coffre\",\"Salarié\":true,\"Co Patron\":false,\"Novice\":false,\"Chef d\'equipe\":false,\"Nouveau\":false,\"grades\":{\"boss\":true}}}', '{\"y\":-2979.162109375,\"x\":-900.5676879882813,\"z\":19.84539794921875}', '{\"y\":-2954.657470703125,\"x\":-941.421142578125,\"z\":19.84539794921875}', '{\"sprite\":423,\"color\":0,\"active\":true,\"position\":{\"y\":-2954.657470703125,\"x\":-941.421142578125,\"z\":19.84539794921875}}', '3', 1, '[{\"name\":\"Patron-Blanc\",\"grades\":{\"boss\":\"boss\"},\"data\":{\"nose_2\":0,\"chin_3\":0,\"nose_1\":0,\"blemishes_2\":0,\"torso_2\":4,\"eyebrows_1\":0,\"bproof_2\":0,\"mom\":0,\"lipstick_4\":0,\"cheeks_3\":0,\"lipstick_2\":10.0,\"blush_2\":10.0,\"moles_2\":10.0,\"chest_3\":0,\"bodyb_4\":0,\"pants_2\":5,\"jaw_2\":-1,\"pants_1\":24,\"chain_2\":0,\"chest_1\":0,\"lipstick_1\":-1,\"tshirt_1\":25,\"eyebrows_3\":0,\"mask_1\":0,\"eye_squint\":0,\"glasses_1\":-1,\"age_1\":0,\"age_2\":10.0,\"nose_5\":0,\"blemishes_1\":0,\"eyebrows_5\":0,\"decals_2\":0,\"chin_4\":0,\"hair_color_2\":0,\"blush_3\":0,\"makeup_4\":3.0,\"chin_1\":-1,\"nose_4\":0,\"bracelets_2\":0,\"makeup_2\":10.0,\"bags_2\":0,\"arms_2\":0,\"bodyb_2\":0,\"skin_md_weight\":0.0,\"complexion_1\":0,\"bags_1\":0,\"sun_2\":0,\"beard_1\":0,\"torso_1\":24,\"sun_1\":0,\"bodyb_1\":-1,\"hair_color_1\":0,\"bproof_1\":0,\"hair_2\":0,\"watches_2\":-1,\"neck_thickness\":-1,\"nose_3\":0,\"eyebrows_6\":0,\"sex\":0,\"moles_1\":-1,\"nose_6\":0,\"hair_1\":51,\"ears_1\":-1,\"beard_4\":0,\"complexion_2\":0,\"blush_1\":-1,\"chin_2\":0,\"face_md_weight\":0.0,\"decals_1\":0,\"lip_thickness\":0.0,\"beard_3\":0,\"helmet_1\":-1,\"eyebrows_4\":0,\"jaw_1\":-1,\"helmet_2\":-1,\"dad\":0,\"makeup_1\":-1,\"shoes_1\":20,\"arms\":39,\"ears_2\":-1,\"cheeks_2\":0,\"shoes_2\":3,\"makeup_3\":0,\"beard_2\":0,\"eye_color\":0,\"lipstick_3\":0,\"glasses_2\":-1,\"chain_1\":-1,\"mask_2\":0,\"tshirt_2\":0,\"cheeks_1\":0,\"chest_2\":0,\"watches_1\":-1,\"bodyb_3\":-1,\"bracelets_1\":-1,\"eyebrows_2\":10},\"grade\":true},{\"name\":\"salarié\",\"grades\":[],\"data\":{\"bodyb_3\":-1,\"chin_3\":0,\"nose_1\":0,\"blemishes_2\":0,\"torso_2\":3,\"eyebrows_1\":30,\"bproof_2\":0,\"mom\":23,\"lipstick_4\":0,\"cheeks_3\":0,\"chest_2\":0,\"nose_6\":0,\"moles_2\":0,\"beard_2\":0,\"cheeks_1\":0,\"pants_2\":0,\"jaw_2\":0,\"pants_1\":22,\"beard_4\":0,\"arms_2\":0,\"lipstick_1\":0,\"tshirt_1\":25,\"eyebrows_3\":0,\"blemishes_1\":0,\"makeup_3\":0,\"sex\":0,\"glasses_1\":0,\"watches_2\":0,\"age_2\":0,\"nose_5\":0,\"blush_1\":0,\"chest_1\":0,\"chest_3\":0,\"chin_4\":0,\"hair_color_2\":0,\"moles_1\":0,\"makeup_4\":0,\"chin_1\":0,\"bodyb_2\":0,\"bracelets_2\":0,\"makeup_2\":0,\"nose_4\":0,\"bags_1\":0,\"mask_1\":0,\"skin_md_weight\":50,\"complexion_1\":0,\"hair_2\":0,\"ears_2\":-1,\"watches_1\":-1,\"torso_1\":4,\"sun_1\":0,\"helmet_2\":-1,\"eye_squint\":0,\"bproof_1\":0,\"beard_1\":0,\"cheeks_2\":0,\"lipstick_2\":0,\"nose_3\":0,\"eyebrows_6\":0,\"face_color\":45,\"helmet_1\":-1,\"glasses_2\":0,\"hair_1\":273,\"age_1\":0,\"bodyb_1\":-1,\"complexion_2\":0,\"face_md_weight\":100,\"chin_2\":0,\"lip_thickness\":0,\"decals_1\":0,\"sun_2\":0,\"beard_3\":0,\"arms\":39,\"hair_color_1\":0,\"jaw_1\":0,\"eyebrows_2\":10,\"dad\":32,\"makeup_1\":0,\"shoes_1\":20,\"decals_2\":0,\"eye_color\":0,\"eyebrows_5\":0,\"shoes_2\":0,\"ears_1\":-1,\"bags_2\":0,\"bodyb_4\":0,\"lipstick_3\":0,\"nose_2\":0,\"chain_1\":-1,\"mask_2\":0,\"tshirt_2\":0,\"blush_3\":0,\"blush_2\":0,\"bracelets_1\":-1,\"eyebrows_4\":0,\"neck_thickness\":0,\"chain_2\":0},\"grade\":false}]', '{\"y\":-2965.811767578125,\"x\":-923.8231811523438,\"z\":19.84539794921875}'),
(28, 'boatdealer', 'Concessionaire Bateau', '{\"items_boss\":[],\"weapons_boss\":[],\"accounts\":{\"society\":1567486.7188753924,\"cash\":0,\"black_money\":0},\"weapons\":[],\"items\":[]}', '{\"withdraw_cash_coffre\":{\"boss\":true,\"CO-FONDA\":false,\"label\":\"Retirer de l\'argent dans le coffre\",\"EMPLOYER\":false,\"novice\":[],\"CONSEILLER\":false,\"co-patron\":[],\"grades\":{\"boss\":true}},\"dposit_item_chest_society\":{\"boss\":true,\"CO-FONDA\":true,\"label\":\"Déposer un item dans le coffre de la société\",\"EMPLOYER\":false,\"novice\":[],\"CONSEILLER\":false,\"co-patron\":[],\"grades\":{\"boss\":true}},\"rename_grade\":{\"boss\":true,\"CO-FONDA\":false,\"label\":\"Changer le nom d\'un grade\",\"EMPLOYER\":false,\"novice\":[],\"CONSEILLER\":false,\"co-patron\":[],\"grades\":{\"boss\":true}},\"chest\":{\"boss\":true,\"CO-FONDA\":true,\"label\":\"Accéder au coffre de la société\",\"EMPLOYER\":false,\"novice\":[],\"CONSEILLER\":false,\"co-patron\":false,\"grades\":{\"boss\":true}},\"change_salary_grade\":{\"boss\":true,\"CO-FONDA\":false,\"label\":\"Changer le salaire d\'un grade\",\"EMPLOYER\":false,\"novice\":[],\"CONSEILLER\":false,\"co-patron\":[],\"grades\":{\"boss\":true}},\"manage_grades\":{\"stagiaire\":false,\"CO-FONDA\":false,\"novice\":[],\"CONSEILLER\":false,\"boss\":true,\"EMPLOYER\":false,\"co-patron\":[],\"label\":\"Gérer les grades de la société\",\"grades\":{\"boss\":true}},\"deposit_weapon_chest\":{\"boss\":true,\"CO-FONDA\":true,\"label\":\"Déposer une arme dans le coffre\",\"EMPLOYER\":false,\"novice\":[],\"CONSEILLER\":false,\"co-patron\":false,\"grades\":{\"boss\":true}},\"create_grade\":{\"stagiaire\":false,\"CO-FONDA\":false,\"novice\":[],\"CONSEILLER\":false,\"boss\":true,\"EMPLOYER\":false,\"co-patron\":false,\"label\":\"Créer un grade\",\"grades\":{\"boss\":true}},\"rename_label_grade\":{\"boss\":true,\"CO-FONDA\":false,\"label\":\"Changer le label d\'un grade\",\"EMPLOYER\":false,\"novice\":[],\"CONSEILLER\":false,\"co-patron\":false,\"grades\":{\"boss\":true}},\"unmote_player\":{\"stagiaire\":false,\"CO-FONDA\":false,\"novice\":[],\"CONSEILLER\":false,\"boss\":true,\"EMPLOYER\":false,\"co-patron\":true,\"label\":\"Descendre un employé\",\"grades\":{\"boss\":true}},\"promote_player\":{\"boss\":true,\"CO-FONDA\":false,\"label\":\"Augmenter un employé\",\"EMPLOYER\":false,\"novice\":[],\"CONSEILLER\":false,\"co-patron\":[],\"grades\":{\"boss\":true}},\"withdraw_money_society\":{\"boss\":true,\"CO-FONDA\":false,\"label\":\"Retirer de l\'argent dans le coffre de la société\",\"EMPLOYER\":false,\"novice\":false,\"CONSEILLER\":false,\"co-patron\":false,\"grades\":{\"boss\":true}},\"withdraw_black_money_coffre\":{\"boss\":true,\"CO-FONDA\":false,\"label\":\"Retirer de l\'argent sale dans le coffre\",\"EMPLOYER\":false,\"novice\":[],\"CONSEILLER\":false,\"co-patron\":false,\"grades\":{\"boss\":true}},\"remove_weapon_chest\":{\"boss\":true,\"CO-FONDA\":false,\"label\":\"Retirer une arme dans le coffre\",\"EMPLOYER\":false,\"novice\":[],\"CONSEILLER\":false,\"co-patron\":[],\"grades\":{\"boss\":true}},\"deposit_weapon_chest_society\":{\"stagiaire\":false,\"CO-FONDA\":false,\"novice\":[],\"CONSEILLER\":false,\"boss\":true,\"EMPLOYER\":false,\"co-patron\":[],\"label\":\"Déposer une arme dans le coffre de la société\",\"grades\":{\"boss\":true}},\"delete_grade\":{\"stagiaire\":false,\"CO-FONDA\":false,\"novice\":[],\"CONSEILLER\":false,\"boss\":true,\"EMPLOYER\":false,\"co-patron\":false,\"label\":\"Supprimer un grade\",\"grades\":{\"boss\":true}},\"weapons_chest\":{\"boss\":true,\"CO-FONDA\":true,\"label\":\"Armes du coffre\",\"EMPLOYER\":false,\"novice\":[],\"CONSEILLER\":false,\"co-patron\":[],\"grades\":{\"boss\":true}},\"change_permissions_grade\":{\"boss\":true,\"CO-FONDA\":false,\"label\":\"Changer les permissions d\'un grade\",\"EMPLOYER\":false,\"novice\":[],\"CONSEILLER\":false,\"co-patron\":[],\"grades\":{\"boss\":true}},\"recruit_player\":{\"boss\":true,\"CO-FONDA\":true,\"label\":\"Recruté un joueur\",\"EMPLOYER\":false,\"novice\":[],\"CONSEILLER\":false,\"co-patron\":[],\"grades\":{\"boss\":true}},\"remove_item_chest_society\":{\"boss\":true,\"CO-FONDA\":true,\"label\":\"Retirer un item dans le coffre de la société\",\"EMPLOYER\":false,\"novice\":false,\"CONSEILLER\":false,\"co-patron\":[],\"grades\":{\"boss\":true}},\"weapons_chest_society\":{\"boss\":true,\"CO-FONDA\":false,\"label\":\"Arme(s) du coffre de la société\",\"EMPLOYER\":false,\"novice\":[],\"CONSEILLER\":false,\"co-patron\":[],\"grades\":{\"boss\":true}},\"deposit_cash_coffre\":{\"boss\":true,\"CO-FONDA\":false,\"label\":\"Déposer de l\'argent dans le coffre\",\"EMPLOYER\":false,\"novice\":[],\"CONSEILLER\":true,\"co-patron\":[],\"grades\":{\"boss\":true}},\"change_number_grade\":{\"boss\":true,\"CO-FONDA\":false,\"label\":\"Changer le numéro d\'un grade\",\"EMPLOYER\":false,\"novice\":[],\"CONSEILLER\":false,\"co-patron\":[],\"grades\":{\"boss\":true}},\"demote_player\":{\"boss\":true,\"CO-FONDA\":true,\"label\":\"Virer un employé\",\"EMPLOYER\":false,\"novice\":[],\"CONSEILLER\":false,\"co-patron\":[],\"grades\":{\"boss\":true}},\"items_chest\":{\"boss\":true,\"CO-FONDA\":true,\"label\":\"Items du coffre\",\"EMPLOYER\":false,\"novice\":[],\"CONSEILLER\":false,\"co-patron\":[],\"grades\":{\"boss\":true}},\"deposit_black_money_coffre\":{\"boss\":true,\"CO-FONDA\":true,\"label\":\"Déposer de l\'argent sale dans le coffre\",\"EMPLOYER\":false,\"novice\":[],\"CONSEILLER\":true,\"co-patron\":[],\"grades\":{\"boss\":true}},\"manage_employeds\":{\"boss\":true,\"CO-FONDA\":false,\"label\":\"Gérer les employés de la société\",\"EMPLOYER\":false,\"novice\":[],\"CONSEILLER\":false,\"co-patron\":[],\"grades\":{\"boss\":true}},\"open_coffre\":{\"stagiaire\":false,\"CO-FONDA\":true,\"novice\":[],\"CONSEILLER\":false,\"boss\":true,\"EMPLOYER\":false,\"co-patron\":[],\"label\":\"Ouvrir le coffre\",\"grades\":{\"boss\":true}},\"deposit_money_society\":{\"boss\":true,\"CO-FONDA\":false,\"label\":\"Déposer de l\'argent dans le coffre de la société\",\"EMPLOYER\":false,\"novice\":[],\"CONSEILLER\":true,\"co-patron\":false,\"grades\":{\"boss\":true}},\"open_boss\":{\"boss\":true,\"CO-FONDA\":false,\"label\":\"Ouvrir le menu boss\",\"EMPLOYER\":false,\"novice\":[],\"CONSEILLER\":false,\"co-patron\":[],\"grades\":{\"boss\":true}},\"items_chest:society\":{\"boss\":true,\"CO-FONDA\":false,\"label\":\"Item(s) du coffre de la société\",\"EMPLOYER\":false,\"novice\":[],\"CONSEILLER\":false,\"co-patron\":[],\"grades\":{\"boss\":true}},\"editClothes\":{\"co-patron\":[]},\"deposit_item_chest\":{\"stagiaire\":false,\"CO-FONDA\":false,\"novice\":[],\"CONSEILLER\":true,\"boss\":true,\"EMPLOYER\":false,\"co-patron\":[],\"label\":\"Déposer un item dans le coffre\",\"grades\":{\"boss\":true}},\"remove_weapon_chest_society\":{\"boss\":true,\"CO-FONDA\":false,\"label\":\"Retirer une arme dans la coffre de la société\",\"EMPLOYER\":false,\"novice\":[],\"CONSEILLER\":false,\"co-patron\":false,\"grades\":{\"boss\":true}},\"remove_item_chest\":{\"stagiaire\":false,\"CO-FONDA\":true,\"novice\":[],\"CONSEILLER\":true,\"boss\":true,\"EMPLOYER\":false,\"co-patron\":false,\"label\":\"Retirer un item dans le coffre\",\"grades\":{\"boss\":true}}}', '{\"y\":-1368.5792236328126,\"x\":-810.6853637695313,\"z\":5.17834520339965}', '{\"y\":-1345.907958984375,\"x\":-788.5839233398438,\"z\":5.1783447265625}', '{\"sprite\":410,\"color\":0,\"active\":true,\"position\":{\"y\":-1345.907958984375,\"x\":-788.5839233398438,\"z\":5.1783447265625}}', '3', 1, '[]', '{\"y\":-1344.47021484375,\"x\":-791.1055908203125,\"z\":9.03531646728515}'),
(29, 'motodealer', 'Concessionnaire Moto', '{\"items_boss\":[],\"weapons_boss\":[],\"accounts\":{\"society\":82661.4121198938,\"cash\":0,\"black_money\":0},\"weapons\":[],\"items\":[]}', '{\"withdraw_cash_coffre\":{\"confirmer\":false,\"Employer \":false,\"Manager\":false,\"Apprentie\":false,\"employer Confirmer\":false,\"Stagiaire \":false,\"Responsable\":false,\"label\":\"Retirer de l\'argent dans le coffre\",\"employer confirmer\":false,\"Employer expert\":false,\"boss\":true,\"Expérimenter\":false,\"Employer\":false,\"✨ Employé expérimenté\":false,\"Stagiare\":false,\"Employer Expert\":false,\"Manager \":false,\"Stagiaire\":false,\"grades\":{\"boss\":true}},\"dposit_item_chest_society\":{\"confirmer\":false,\"Employer \":false,\"Manager\":false,\"Apprentie\":[],\"employer Confirmer\":false,\"Stagiaire \":false,\"Responsable\":false,\"label\":\"Déposer un item dans le coffre de la société\",\"employer confirmer\":false,\"Employer expert\":false,\"boss\":true,\"Expérimenter\":[],\"Employer\":false,\"✨ Employé expérimenté\":false,\"Stagiare\":false,\"Employer Expert\":false,\"Manager \":false,\"Stagiaire\":false,\"grades\":{\"boss\":true}},\"rename_grade\":{\"confirmer\":false,\"Employer \":false,\"Manager\":false,\"Apprentie\":false,\"employer Confirmer\":false,\"Stagiaire \":false,\"Responsable\":false,\"label\":\"Changer le nom d\'un grade\",\"employer confirmer\":false,\"Employer expert\":false,\"boss\":true,\"Expérimenter\":false,\"Employer\":false,\"✨ Employé expérimenté\":false,\"Stagiare\":false,\"Employer Expert\":false,\"Manager \":false,\"Stagiaire\":false,\"grades\":{\"boss\":true}},\"chest\":{\"confirmer\":false,\"Employer \":false,\"Manager\":false,\"Apprentie\":false,\"employer Confirmer\":false,\"Stagiaire \":false,\"Responsable\":false,\"label\":\"Accéder au coffre de la société\",\"employer confirmer\":false,\"Employer expert\":false,\"boss\":true,\"Expérimenter\":[],\"Employer\":false,\"✨ Employé expérimenté\":false,\"Stagiare\":false,\"Employer Expert\":false,\"Manager \":false,\"Stagiaire\":false,\"grades\":{\"boss\":true}},\"change_salary_grade\":{\"confirmer\":false,\"Employer \":false,\"Manager\":false,\"Apprentie\":false,\"employer Confirmer\":false,\"Stagiaire \":false,\"Responsable\":false,\"label\":\"Changer le salaire d\'un grade\",\"employer confirmer\":false,\"Employer expert\":false,\"boss\":true,\"Expérimenter\":false,\"Employer\":false,\"✨ Employé expérimenté\":false,\"Stagiare\":false,\"Employer Expert\":false,\"Manager \":false,\"Stagiaire\":false,\"grades\":{\"boss\":true}},\"manage_grades\":{\"confirmer\":false,\"Employer \":false,\"Manager\":false,\"Apprentie\":false,\"employer Confirmer\":false,\"Stagiaire \":false,\"Responsable\":false,\"label\":\"Gérer les grades de la société\",\"employer confirmer\":false,\"Employer expert\":false,\"boss\":true,\"Expérimenter\":false,\"Employer\":false,\"✨ Employé expérimenté\":false,\"Stagiare\":false,\"Employer Expert\":false,\"Manager \":false,\"Stagiaire\":false,\"grades\":{\"boss\":true}},\"deposit_weapon_chest\":{\"confirmer\":false,\"Employer \":false,\"Manager\":false,\"Apprentie\":[],\"employer Confirmer\":false,\"Stagiaire \":false,\"Responsable\":false,\"label\":\"Déposer une arme dans le coffre\",\"employer confirmer\":false,\"Employer expert\":false,\"boss\":true,\"Expérimenter\":[],\"Employer\":false,\"✨ Employé expérimenté\":false,\"Stagiare\":false,\"Employer Expert\":false,\"Manager \":false,\"Stagiaire\":false,\"grades\":{\"boss\":true}},\"create_grade\":{\"confirmer\":false,\"Employer \":false,\"Manager\":false,\"Apprentie\":false,\"employer Confirmer\":false,\"Stagiaire \":false,\"Responsable\":false,\"label\":\"Créer un grade\",\"employer confirmer\":false,\"Employer expert\":false,\"boss\":true,\"Expérimenter\":false,\"Employer\":false,\"✨ Employé expérimenté\":false,\"Stagiare\":false,\"Employer Expert\":false,\"Manager \":false,\"Stagiaire\":false,\"grades\":{\"boss\":true}},\"rename_label_grade\":{\"confirmer\":false,\"Employer \":false,\"Manager\":false,\"Apprentie\":false,\"employer Confirmer\":false,\"Stagiaire \":false,\"Responsable\":false,\"label\":\"Changer le label d\'un grade\",\"employer confirmer\":false,\"Employer expert\":false,\"boss\":true,\"Expérimenter\":false,\"Employer\":false,\"✨ Employé expérimenté\":false,\"Stagiare\":false,\"Employer Expert\":false,\"Manager \":false,\"Stagiaire\":false,\"grades\":{\"boss\":true}},\"unmote_player\":{\"confirmer\":false,\"Employer \":false,\"Manager\":false,\"Apprentie\":false,\"employer Confirmer\":false,\"Stagiaire \":false,\"Responsable\":true,\"label\":\"Descendre un employé\",\"employer confirmer\":false,\"Employer expert\":false,\"boss\":true,\"Expérimenter\":false,\"Employer\":false,\"✨ Employé expérimenté\":false,\"Stagiare\":false,\"Employer Expert\":false,\"Manager \":false,\"Stagiaire\":false,\"grades\":{\"boss\":true}},\"promote_player\":{\"confirmer\":false,\"Employer \":false,\"Manager\":false,\"Apprentie\":false,\"employer Confirmer\":false,\"Stagiaire \":false,\"Responsable\":true,\"label\":\"Augmenter un employé\",\"employer confirmer\":false,\"Employer expert\":false,\"boss\":true,\"Expérimenter\":false,\"Employer\":false,\"✨ Employé expérimenté\":false,\"Stagiare\":false,\"Employer Expert\":false,\"Manager \":false,\"Stagiaire\":false,\"grades\":{\"boss\":true}},\"withdraw_money_society\":{\"confirmer\":false,\"Employer \":false,\"Manager\":false,\"Apprentie\":false,\"employer Confirmer\":false,\"Stagiaire \":false,\"Responsable\":false,\"label\":\"Retirer de l\'argent dans le coffre de la société\",\"employer confirmer\":false,\"Employer expert\":false,\"boss\":true,\"Expérimenter\":[],\"Employer\":false,\"✨ Employé expérimenté\":false,\"Stagiare\":false,\"Employer Expert\":false,\"Manager \":false,\"Stagiaire\":false,\"grades\":{\"boss\":true}},\"withdraw_black_money_coffre\":{\"confirmer\":false,\"Employer \":false,\"Manager\":false,\"Apprentie\":false,\"employer Confirmer\":false,\"Stagiaire \":false,\"Responsable\":false,\"label\":\"Retirer de l\'argent sale dans le coffre\",\"employer confirmer\":false,\"Employer expert\":false,\"boss\":true,\"Expérimenter\":false,\"Employer\":false,\"✨ Employé expérimenté\":false,\"Stagiare\":false,\"Employer Expert\":false,\"Manager \":false,\"Stagiaire\":false,\"grades\":{\"boss\":true}},\"remove_weapon_chest\":{\"confirmer\":false,\"Employer \":false,\"Manager\":false,\"Apprentie\":false,\"employer Confirmer\":false,\"Stagiaire \":false,\"Responsable\":false,\"label\":\"Retirer une arme dans le coffre\",\"employer confirmer\":false,\"Employer expert\":false,\"boss\":true,\"Expérimenter\":false,\"Employer\":false,\"✨ Employé expérimenté\":false,\"Stagiare\":false,\"Employer Expert\":false,\"Manager \":false,\"Stagiaire\":false,\"grades\":{\"boss\":true}},\"deposit_weapon_chest_society\":{\"confirmer\":false,\"Employer \":false,\"Manager\":false,\"Apprentie\":[],\"employer Confirmer\":false,\"Stagiaire \":false,\"Responsable\":false,\"label\":\"Déposer une arme dans le coffre de la société\",\"employer confirmer\":false,\"Employer expert\":false,\"boss\":true,\"Expérimenter\":[],\"Employer\":false,\"✨ Employé expérimenté\":false,\"Stagiare\":false,\"Employer Expert\":false,\"Manager \":false,\"Stagiaire\":false,\"grades\":{\"boss\":true}},\"delete_grade\":{\"confirmer\":false,\"Employer \":false,\"Manager\":false,\"Apprentie\":false,\"employer Confirmer\":false,\"Stagiaire \":false,\"Responsable\":false,\"label\":\"Supprimer un grade\",\"employer confirmer\":false,\"Employer expert\":false,\"boss\":true,\"Expérimenter\":false,\"Employer\":false,\"✨ Employé expérimenté\":false,\"Stagiare\":false,\"Employer Expert\":false,\"Manager \":false,\"Stagiaire\":false,\"grades\":{\"boss\":true}},\"weapons_chest\":{\"confirmer\":false,\"Employer \":false,\"Manager\":false,\"Apprentie\":[],\"employer Confirmer\":false,\"Stagiaire \":false,\"Responsable\":false,\"label\":\"Armes du coffre\",\"employer confirmer\":false,\"Employer expert\":false,\"boss\":true,\"Expérimenter\":[],\"Employer\":false,\"✨ Employé expérimenté\":false,\"Stagiare\":false,\"Employer Expert\":false,\"Manager \":false,\"Stagiaire\":false,\"grades\":{\"boss\":true}},\"change_permissions_grade\":{\"confirmer\":false,\"Employer \":false,\"Manager\":false,\"Apprentie\":false,\"employer Confirmer\":false,\"Stagiaire \":false,\"Responsable\":false,\"label\":\"Changer les permissions d\'un grade\",\"employer confirmer\":false,\"Employer expert\":false,\"boss\":true,\"Expérimenter\":[],\"Employer\":false,\"✨ Employé expérimenté\":false,\"Stagiare\":false,\"Employer Expert\":false,\"Manager \":false,\"Stagiaire\":false,\"grades\":{\"boss\":true}},\"recruit_player\":{\"confirmer\":false,\"Employer \":false,\"Manager\":false,\"Apprentie\":false,\"employer Confirmer\":false,\"Stagiaire \":false,\"Responsable\":true,\"label\":\"Recruté un joueur\",\"employer confirmer\":false,\"Employer expert\":false,\"boss\":true,\"Expérimenter\":[],\"Employer\":false,\"✨ Employé expérimenté\":false,\"Stagiare\":false,\"Employer Expert\":false,\"Manager \":true,\"Stagiaire\":false,\"grades\":{\"boss\":true}},\"remove_item_chest_society\":{\"confirmer\":false,\"Employer \":false,\"Manager\":false,\"Apprentie\":false,\"employer Confirmer\":false,\"Stagiaire \":false,\"Responsable\":false,\"label\":\"Retirer un item dans le coffre de la société\",\"employer confirmer\":false,\"Employer expert\":false,\"boss\":true,\"Expérimenter\":false,\"Employer\":false,\"✨ Employé expérimenté\":false,\"Stagiare\":false,\"Employer Expert\":false,\"Manager \":false,\"Stagiaire\":false,\"grades\":{\"boss\":true}},\"weapons_chest_society\":{\"confirmer\":false,\"Employer \":false,\"Manager\":false,\"Apprentie\":false,\"employer Confirmer\":false,\"Stagiaire \":false,\"Responsable\":false,\"label\":\"Arme(s) du coffre de la société\",\"employer confirmer\":false,\"Employer expert\":false,\"boss\":true,\"Expérimenter\":false,\"Employer\":false,\"✨ Employé expérimenté\":false,\"Stagiare\":false,\"Employer Expert\":false,\"Manager \":false,\"Stagiaire\":false,\"grades\":{\"boss\":true}},\"demote_player\":{\"confirmer\":false,\"Employer \":false,\"Manager\":false,\"Apprentie\":false,\"employer Confirmer\":false,\"Stagiaire \":false,\"Responsable\":true,\"label\":\"Virer un employé\",\"employer confirmer\":false,\"Employer expert\":false,\"boss\":true,\"Expérimenter\":false,\"Employer\":false,\"✨ Employé expérimenté\":false,\"Stagiare\":false,\"Employer Expert\":false,\"Manager \":false,\"Stagiaire\":false,\"grades\":{\"boss\":true}},\"change_number_grade\":{\"Employer Expert\":false,\"Employer \":false,\"Manager\":false,\"Apprentie\":false,\"employer Confirmer\":false,\"✨ Employé expérimenté\":false,\"Responsable\":false,\"label\":\"Changer le numéro d\'un grade\",\"employer confirmer\":false,\"Employer expert\":false,\"boss\":true,\"Employer\":false,\"Expérimenter\":false,\"Stagiare\":false,\"Stagiaire\":false,\"Manager \":false,\"Stagiaire \":false,\"grades\":{\"boss\":true}},\"deposit_black_money_coffre\":{\"confirmer\":false,\"Employer \":false,\"Manager\":false,\"Apprentie\":[],\"employer Confirmer\":false,\"Stagiaire \":false,\"Responsable\":false,\"label\":\"Déposer de l\'argent sale dans le coffre\",\"employer confirmer\":false,\"Employer expert\":false,\"boss\":true,\"Expérimenter\":[],\"Employer\":false,\"✨ Employé expérimenté\":false,\"Stagiare\":false,\"Employer Expert\":false,\"Manager \":false,\"Stagiaire\":false,\"grades\":{\"boss\":true}},\"items_chest\":{\"confirmer\":false,\"Employer \":false,\"Manager\":false,\"Apprentie\":false,\"employer Confirmer\":false,\"Stagiaire \":false,\"Responsable\":false,\"label\":\"Items du coffre\",\"employer confirmer\":false,\"Employer expert\":false,\"boss\":true,\"Expérimenter\":false,\"Employer\":false,\"✨ Employé expérimenté\":false,\"Stagiare\":false,\"Employer Expert\":false,\"Manager \":false,\"Stagiaire\":false,\"grades\":{\"boss\":true}},\"deposit_cash_coffre\":{\"confirmer\":false,\"Employer \":false,\"Manager\":false,\"Apprentie\":[],\"employer Confirmer\":false,\"Stagiaire \":false,\"Responsable\":false,\"label\":\"Déposer de l\'argent dans le coffre\",\"employer confirmer\":false,\"Employer expert\":false,\"boss\":true,\"Expérimenter\":[],\"Employer\":false,\"✨ Employé expérimenté\":false,\"Stagiare\":false,\"Employer Expert\":false,\"Manager \":false,\"Stagiaire\":false,\"grades\":{\"boss\":true}},\"manage_employeds\":{\"Employer Expert\":false,\"Employer \":false,\"Manager\":false,\"Apprentie\":false,\"employer Confirmer\":false,\"✨ Employé expérimenté\":false,\"Responsable\":true,\"label\":\"Gérer les employés de la société\",\"employer confirmer\":false,\"Employer expert\":false,\"boss\":true,\"Employer\":false,\"Expérimenter\":false,\"Stagiare\":false,\"Stagiaire\":false,\"Manager \":false,\"Stagiaire \":false,\"grades\":{\"boss\":true}},\"open_coffre\":{\"confirmer\":false,\"Employer \":false,\"Manager\":false,\"Apprentie\":[],\"employer Confirmer\":false,\"Stagiaire \":false,\"Responsable\":false,\"label\":\"Ouvrir le coffre\",\"employer confirmer\":false,\"Employer expert\":false,\"boss\":true,\"Expérimenter\":false,\"Employer\":false,\"✨ Employé expérimenté\":false,\"Stagiare\":false,\"Employer Expert\":false,\"Manager \":false,\"Stagiaire\":false,\"grades\":{\"boss\":true}},\"deposit_money_society\":{\"confirmer\":false,\"Employer \":false,\"Manager\":false,\"Apprentie\":[],\"employer Confirmer\":false,\"Stagiaire \":false,\"Responsable\":false,\"label\":\"Déposer de l\'argent dans le coffre de la société\",\"employer confirmer\":false,\"Employer expert\":false,\"boss\":true,\"Expérimenter\":[],\"Employer\":false,\"✨ Employé expérimenté\":false,\"Stagiare\":false,\"Employer Expert\":false,\"Manager \":false,\"Stagiaire\":false,\"grades\":{\"boss\":true}},\"open_boss\":{\"Employer Expert\":false,\"Employer \":false,\"Manager\":false,\"Apprentie\":false,\"employer Confirmer\":false,\"✨ Employé expérimenté\":false,\"Responsable\":false,\"label\":\"Ouvrir le menu boss\",\"employer confirmer\":false,\"Employer expert\":false,\"boss\":true,\"Employer\":false,\"Expérimenter\":false,\"Stagiare\":false,\"Stagiaire\":false,\"Manager \":false,\"Stagiaire \":false,\"grades\":{\"boss\":true}},\"items_chest:society\":{\"confirmer\":false,\"Employer \":false,\"Manager\":false,\"Apprentie\":false,\"employer Confirmer\":false,\"Stagiaire \":false,\"Responsable\":false,\"label\":\"Item(s) du coffre de la société\",\"employer confirmer\":false,\"Employer expert\":false,\"boss\":true,\"Expérimenter\":false,\"Employer\":false,\"✨ Employé expérimenté\":false,\"Stagiare\":false,\"Employer Expert\":false,\"Manager \":false,\"Stagiaire\":false,\"grades\":{\"boss\":true}},\"editClothes\":{\"Employer Expert\":false,\"Employer \":false,\"Manager\":false,\"Apprentie\":true,\"employer Confirmer\":false,\"✨ Employé expérimenté\":false,\"Responsable\":true,\"label\":\"Gérer les tenues dans le vestiaire\",\"employer confirmer\":false,\"Employer expert\":false,\"boss\":[],\"Employer\":false,\"Expérimenter\":true,\"Stagiare\":false,\"Stagiaire\":false,\"Manager \":false,\"Stagiaire \":false,\"grades\":{\"boss\":true}},\"deposit_item_chest\":{\"confirmer\":false,\"Employer \":false,\"Manager\":false,\"Apprentie\":[],\"employer Confirmer\":false,\"Stagiaire \":false,\"Responsable\":false,\"label\":\"Déposer un item dans le coffre\",\"employer confirmer\":false,\"Employer expert\":false,\"boss\":true,\"Expérimenter\":[],\"Employer\":false,\"✨ Employé expérimenté\":false,\"Stagiare\":false,\"Employer Expert\":false,\"Manager \":false,\"Stagiaire\":false,\"grades\":{\"boss\":true}},\"remove_weapon_chest_society\":{\"confirmer\":false,\"Employer \":false,\"Manager\":false,\"Apprentie\":false,\"employer Confirmer\":false,\"Stagiaire \":false,\"Responsable\":false,\"label\":\"Retirer une arme dans la coffre de la société\",\"employer confirmer\":false,\"Employer expert\":false,\"boss\":true,\"Expérimenter\":false,\"Employer\":false,\"✨ Employé expérimenté\":false,\"Stagiare\":false,\"Employer Expert\":false,\"Manager \":false,\"Stagiaire\":false,\"grades\":{\"boss\":true}},\"remove_item_chest\":{\"confirmer\":false,\"Employer \":false,\"Manager\":false,\"Apprentie\":false,\"employer Confirmer\":false,\"Stagiaire \":false,\"Responsable\":false,\"label\":\"Retirer un item dans le coffre\",\"employer confirmer\":false,\"Employer expert\":false,\"boss\":true,\"Expérimenter\":[],\"Employer\":false,\"✨ Employé expérimenté\":false,\"Stagiare\":false,\"Employer Expert\":false,\"Manager \":false,\"Stagiaire\":false,\"grades\":{\"boss\":true}}}', '{\"y\":-204.45040893554688,\"x\":-870.6925659179688,\"z\":37.83721542358398}', '{\"y\":-203.1305389404297,\"x\":-868.6610107421875,\"z\":37.83723831176758}', '{\"sprite\":348,\"color\":0,\"active\":true,\"position\":{\"y\":-194.85923767089845,\"x\":-867.6478881835938,\"z\":37.83718872070312}}', '3', 1, '[{\"grades\":{\"boss\":\"boss\",\"Responsable\":\"Responsable\"},\"data\":{\"eyebrows_5\":0,\"watches_2\":0,\"skin_md_weight\":50,\"nose_3\":0,\"glasses_1\":0,\"age_1\":0,\"chest_1\":0,\"decals_1\":0,\"eyebrows_1\":0,\"cheeks_1\":0,\"mask_2\":0,\"neck_thickness\":0,\"moles_2\":0,\"bproof_2\":0,\"lip_thickness\":0,\"hair_color_2\":0,\"bracelets_2\":0,\"mom\":21,\"bproof_1\":0,\"hair_2\":0,\"eyebrows_3\":0,\"chain_1\":0,\"nose_1\":0,\"cheeks_2\":0,\"face_md_weight\":50,\"nose_4\":0,\"makeup_1\":0,\"shoes_1\":10,\"glasses_2\":0,\"nose_6\":0,\"torso_2\":0,\"complexion_2\":0,\"jaw_2\":0,\"chest_3\":0,\"chin_1\":0,\"hair_color_1\":0,\"lipstick_4\":0,\"lipstick_2\":0,\"sex\":0,\"eye_color\":0,\"eyebrows_6\":0,\"beard_3\":0,\"watches_1\":-1,\"bags_1\":0,\"helmet_2\":0,\"lipstick_1\":0,\"decals_2\":0,\"ears_2\":-1,\"chain_2\":0,\"chin_2\":0,\"complexion_1\":0,\"nose_5\":0,\"makeup_4\":0,\"tshirt_2\":0,\"arms\":1,\"jaw_1\":0,\"bodyb_2\":0,\"mask_1\":0,\"tshirt_1\":150,\"torso_1\":31,\"nose_2\":0,\"blush_2\":0,\"helmet_1\":-1,\"beard_4\":0,\"eyebrows_4\":0,\"sun_1\":0,\"moles_1\":0,\"sun_2\":0,\"hair_1\":0,\"ears_1\":-1,\"shoes_2\":0,\"lipstick_3\":0,\"arms_2\":0,\"chin_4\":0,\"eye_squint\":0,\"dad\":0,\"makeup_3\":0,\"beard_1\":0,\"makeup_2\":0,\"bodyb_1\":-1,\"eyebrows_2\":0,\"blemishes_2\":0,\"chin_3\":0,\"chest_2\":0,\"pants_2\":0,\"beard_2\":0,\"blush_1\":0,\"blush_3\":0,\"bags_2\":0,\"bodyb_3\":-1,\"bracelets_1\":-1,\"pants_1\":24,\"bodyb_4\":0,\"age_2\":0,\"blemishes_1\":0,\"cheeks_3\":0},\"name\":\"Directeur | Responsable\",\"grade\":true},{\"grades\":{\"Stagiaire\":\"Stagiaire\",\"Employé+\":\"Employé+\"},\"data\":{\"eyebrows_5\":0,\"watches_2\":0,\"skin_md_weight\":50,\"nose_3\":0,\"glasses_1\":0,\"age_1\":0,\"chest_1\":0,\"decals_1\":0,\"eyebrows_1\":0,\"cheeks_1\":0,\"mask_2\":0,\"neck_thickness\":0,\"moles_2\":0,\"bproof_2\":0,\"lip_thickness\":0,\"hair_color_2\":0,\"bracelets_2\":0,\"mom\":21,\"bproof_1\":0,\"hair_2\":0,\"eyebrows_3\":0,\"chain_1\":0,\"nose_1\":0,\"cheeks_2\":0,\"face_md_weight\":50,\"nose_4\":0,\"makeup_1\":0,\"shoes_1\":10,\"glasses_2\":0,\"nose_6\":0,\"torso_2\":0,\"complexion_2\":0,\"jaw_2\":0,\"chest_3\":0,\"chin_1\":0,\"hair_color_1\":0,\"lipstick_4\":0,\"lipstick_2\":0,\"sex\":0,\"eye_color\":0,\"eyebrows_6\":0,\"beard_3\":0,\"watches_1\":-1,\"bags_1\":0,\"helmet_2\":0,\"lipstick_1\":0,\"decals_2\":0,\"ears_2\":-1,\"chain_2\":0,\"chin_2\":0,\"complexion_1\":0,\"nose_5\":0,\"makeup_4\":0,\"tshirt_2\":0,\"arms\":1,\"jaw_1\":0,\"bodyb_2\":0,\"mask_1\":0,\"tshirt_1\":21,\"torso_1\":31,\"nose_2\":0,\"blush_2\":0,\"helmet_1\":-1,\"beard_4\":0,\"eyebrows_4\":0,\"sun_1\":0,\"moles_1\":0,\"sun_2\":0,\"hair_1\":0,\"ears_1\":-1,\"shoes_2\":0,\"lipstick_3\":0,\"arms_2\":0,\"chin_4\":0,\"eye_squint\":0,\"dad\":0,\"makeup_3\":0,\"beard_1\":0,\"makeup_2\":0,\"bodyb_1\":-1,\"eyebrows_2\":0,\"blemishes_2\":0,\"chin_3\":0,\"chest_2\":0,\"pants_2\":0,\"beard_2\":0,\"blush_1\":0,\"blush_3\":0,\"bags_2\":0,\"bodyb_3\":-1,\"bracelets_1\":-1,\"pants_1\":24,\"bodyb_4\":0,\"age_2\":0,\"blemishes_1\":0,\"cheeks_3\":0},\"name\":\"Employé | Stagiaire\",\"grade\":true}]', '{\"y\":-197.7801513671875,\"x\":-875.474609375,\"z\":37.83722305297851}');
INSERT INTO `society_data` (`id`, `name`, `label`, `coffre`, `permissions`, `posCoffre`, `posBoss`, `blips`, `tax`, `cloakroom`, `clothes`, `cloakpos`) VALUES
(30, 'saspnn', 'BCSO', '{\"items_boss\":[],\"weapons\":[],\"items\":[],\"accounts\":{\"society\":1000,\"cash\":0,\"black_money\":0},\"weapons_boss\":[]}', '{\"manage_employeds\":{\"officier3\":false,\"officier2\":false,\"Under Sheriff\":true,\"lieutenant\":false,\"cadet\":false,\"sergent1\":false,\"sergent2\":false,\"officierprincipal \":false,\"label\":\"Gérer les employés de la société\",\"grades\":{\"boss\":true},\"capitaine\":true,\"boss\":true,\"officier1\":false},\"open_boss\":{\"officier3\":false,\"officier2\":false,\"Under Sheriff\":true,\"lieutenant\":[],\"cadet\":false,\"sergent1\":[],\"sergent2\":false,\"officierprincipal \":[],\"label\":\"Ouvrir le menu boss\",\"grades\":{\"boss\":true},\"capitaine\":true,\"boss\":true,\"officier1\":false},\"remove_weapon_chest\":{\"officier3\":false,\"officier2\":false,\"Under Sheriff\":true,\"lieutenant\":false,\"cadet\":false,\"sergent1\":false,\"sergent2\":false,\"officierprincipal \":false,\"label\":\"Retirer une arme dans le coffre\",\"grades\":{\"boss\":true},\"capitaine\":true,\"boss\":true,\"officier1\":false},\"change_permissions_grade\":{\"officier3\":false,\"officier2\":false,\"Under Sheriff\":true,\"lieutenant\":[],\"cadet\":false,\"sergent1\":false,\"sergent2\":false,\"officierprincipal \":false,\"label\":\"Changer les permissions d\'un grade\",\"grades\":{\"boss\":true},\"capitaine\":true,\"boss\":true,\"officier1\":false},\"rename_label_grade\":{\"officier3\":false,\"officier2\":false,\"Under Sheriff\":true,\"lieutenant\":false,\"cadet\":false,\"sergent1\":false,\"sergent2\":false,\"officierprincipal \":false,\"label\":\"Changer le label d\'un grade\",\"grades\":{\"boss\":true},\"capitaine\":true,\"boss\":true,\"officier1\":false},\"delete_grade\":{\"officier3\":false,\"officier2\":false,\"Under Sheriff\":true,\"lieutenant\":false,\"cadet\":false,\"sergent1\":false,\"sergent2\":false,\"officierprincipal \":false,\"label\":\"Supprimer un grade\",\"grades\":{\"boss\":true},\"capitaine\":true,\"boss\":true,\"officier1\":false},\"remove_item_chest\":{\"officier3\":false,\"officier2\":false,\"Under Sheriff\":true,\"lieutenant\":false,\"cadet\":false,\"sergent1\":false,\"sergent2\":false,\"officierprincipal \":false,\"label\":\"Retirer un item dans le coffre\",\"grades\":{\"boss\":true},\"capitaine\":true,\"boss\":true,\"officier1\":false},\"chest\":{\"officier3\":false,\"officier2\":false,\"Under Sheriff\":true,\"lieutenant\":false,\"cadet\":false,\"sergent1\":false,\"sergent2\":false,\"officierprincipal \":[],\"label\":\"Accéder au coffre de la société\",\"grades\":{\"boss\":true},\"capitaine\":true,\"boss\":true,\"officier1\":[]},\"withdraw_cash_coffre\":{\"officier3\":false,\"officier2\":false,\"Under Sheriff\":true,\"lieutenant\":false,\"cadet\":false,\"sergent1\":false,\"sergent2\":false,\"officierprincipal \":false,\"label\":\"Retirer de l\'argent dans le coffre\",\"grades\":{\"boss\":true},\"capitaine\":true,\"boss\":true,\"officier1\":false},\"promote_player\":{\"officier3\":false,\"officier2\":false,\"Under Sheriff\":true,\"lieutenant\":false,\"cadet\":false,\"sergent1\":false,\"sergent2\":false,\"officierprincipal \":[],\"label\":\"Augmenter un employé\",\"grades\":{\"boss\":true},\"capitaine\":true,\"boss\":true,\"officier1\":false},\"dposit_item_chest_society\":{\"officier3\":[],\"officier2\":false,\"Under Sheriff\":true,\"lieutenant\":[],\"cadet\":false,\"sergent1\":[],\"sergent2\":[],\"officierprincipal \":[],\"label\":\"Déposer un item dans le coffre de la société\",\"grades\":{\"boss\":true},\"capitaine\":true,\"boss\":true,\"officier1\":[]},\"open_coffre\":{\"officier3\":false,\"officier2\":false,\"Under Sheriff\":true,\"lieutenant\":[],\"cadet\":false,\"sergent1\":[],\"sergent2\":[],\"officierprincipal \":[],\"label\":\"Ouvrir le coffre\",\"grades\":{\"boss\":true},\"capitaine\":[],\"boss\":true,\"officier1\":[]},\"deposit_black_money_coffre\":{\"officier3\":false,\"officier2\":[],\"Under Sheriff\":true,\"lieutenant\":[],\"cadet\":false,\"sergent1\":[],\"sergent2\":[],\"officierprincipal \":[],\"label\":\"Déposer de l\'argent sale dans le coffre\",\"grades\":{\"boss\":true},\"capitaine\":true,\"boss\":true,\"officier1\":[]},\"remove_weapon_chest_society\":{\"officier3\":false,\"officier2\":false,\"Under Sheriff\":true,\"lieutenant\":false,\"cadet\":false,\"sergent1\":false,\"sergent2\":false,\"officierprincipal \":false,\"label\":\"Retirer une arme dans la coffre de la société\",\"grades\":{\"boss\":true},\"capitaine\":true,\"boss\":true,\"officier1\":false},\"weapons_chest_society\":{\"officier3\":[],\"officier2\":[],\"Under Sheriff\":true,\"lieutenant\":[],\"cadet\":false,\"sergent1\":true,\"sergent2\":true,\"officierprincipal \":[],\"label\":\"Arme(s) du coffre de la société\",\"grades\":{\"boss\":true},\"capitaine\":[],\"boss\":true,\"officier1\":[]},\"deposit_item_chest\":{\"officier3\":false,\"officier2\":true,\"Under Sheriff\":true,\"lieutenant\":true,\"cadet\":false,\"sergent1\":true,\"sergent2\":[],\"officierprincipal \":[],\"label\":\"Déposer un item dans le coffre\",\"grades\":{\"boss\":true},\"capitaine\":true,\"boss\":true,\"officier1\":[]},\"withdraw_black_money_coffre\":{\"officier3\":false,\"officier2\":false,\"Under Sheriff\":true,\"lieutenant\":false,\"cadet\":[],\"sergent1\":false,\"sergent2\":false,\"officierprincipal \":false,\"label\":\"Retirer de l\'argent sale dans le coffre\",\"grades\":{\"boss\":true},\"capitaine\":true,\"boss\":true,\"officier1\":false},\"deposit_weapon_chest\":{\"officier3\":[],\"officier2\":[],\"Under Sheriff\":true,\"lieutenant\":[],\"cadet\":[],\"sergent1\":[],\"sergent2\":[],\"officierprincipal \":true,\"label\":\"Déposer une arme dans le coffre\",\"grades\":{\"boss\":true},\"capitaine\":[],\"boss\":true,\"officier1\":[]},\"recruit_player\":{\"officier3\":false,\"officier2\":false,\"Under Sheriff\":true,\"lieutenant\":false,\"cadet\":false,\"sergent1\":false,\"sergent2\":false,\"officierprincipal \":false,\"label\":\"Recruté un joueur\",\"grades\":{\"boss\":true},\"capitaine\":true,\"boss\":true,\"officier1\":false},\"change_salary_grade\":{\"officier3\":false,\"officier2\":false,\"Under Sheriff\":true,\"lieutenant\":false,\"cadet\":false,\"sergent1\":false,\"sergent2\":false,\"officierprincipal \":false,\"label\":\"Changer le salaire d\'un grade\",\"grades\":{\"boss\":true},\"capitaine\":true,\"boss\":true,\"officier1\":false},\"editClothes\":{\"grades\":{\"boss\":true},\"label\":\"Gérer les tenues dans le vestiaire\",\"capitaine\":[],\"cadet\":false,\"Under Sheriff\":true},\"unmote_player\":{\"officier3\":false,\"officier2\":false,\"Under Sheriff\":true,\"lieutenant\":false,\"cadet\":false,\"sergent1\":false,\"sergent2\":false,\"officierprincipal \":false,\"label\":\"Descendre un employé\",\"grades\":{\"boss\":true},\"capitaine\":true,\"boss\":true,\"officier1\":false},\"manage_grades\":{\"officier3\":false,\"officier2\":false,\"Under Sheriff\":true,\"lieutenant\":false,\"cadet\":false,\"sergent1\":false,\"sergent2\":[],\"officierprincipal \":false,\"label\":\"Gérer les grades de la société\",\"grades\":{\"boss\":true},\"capitaine\":true,\"boss\":true,\"officier1\":false},\"deposit_weapon_chest_society\":{\"officier3\":[],\"officier2\":[],\"Under Sheriff\":true,\"lieutenant\":[],\"cadet\":false,\"sergent1\":[],\"sergent2\":[],\"officierprincipal \":[],\"label\":\"Déposer une arme dans le coffre de la société\",\"grades\":{\"boss\":true},\"capitaine\":[],\"boss\":true,\"officier1\":[]},\"create_grade\":{\"officier3\":false,\"officier2\":false,\"Under Sheriff\":true,\"lieutenant\":false,\"cadet\":false,\"sergent1\":false,\"sergent2\":false,\"officierprincipal \":false,\"label\":\"Créer un grade\",\"grades\":{\"boss\":true},\"capitaine\":true,\"boss\":true,\"officier1\":false},\"items_chest:society\":{\"officier3\":[],\"officier2\":[],\"Under Sheriff\":true,\"lieutenant\":[],\"cadet\":false,\"sergent1\":[],\"sergent2\":[],\"officierprincipal \":[],\"label\":\"Item(s) du coffre de la société\",\"grades\":{\"boss\":true},\"capitaine\":true,\"boss\":true,\"officier1\":[]},\"deposit_money_society\":{\"officier3\":[],\"officier2\":[],\"Under Sheriff\":true,\"lieutenant\":[],\"cadet\":false,\"sergent1\":[],\"sergent2\":[],\"officierprincipal \":[],\"label\":\"Déposer de l\'argent dans le coffre de la société\",\"grades\":{\"boss\":true},\"capitaine\":[],\"boss\":true,\"officier1\":[]},\"change_number_grade\":{\"officier3\":false,\"officier2\":false,\"Under Sheriff\":true,\"lieutenant\":false,\"cadet\":false,\"sergent1\":false,\"sergent2\":false,\"officierprincipal \":false,\"label\":\"Changer le numéro d\'un grade\",\"grades\":{\"boss\":true},\"capitaine\":true,\"boss\":true,\"officier1\":false},\"deposit_cash_coffre\":{\"officier3\":[],\"officier2\":true,\"Under Sheriff\":true,\"lieutenant\":false,\"cadet\":false,\"sergent1\":false,\"sergent2\":false,\"officierprincipal \":[],\"label\":\"Déposer de l\'argent dans le coffre\",\"grades\":{\"boss\":true},\"capitaine\":[],\"boss\":true,\"officier1\":[]},\"items_chest\":{\"officier3\":[],\"officier2\":[],\"Under Sheriff\":true,\"lieutenant\":[],\"cadet\":[],\"sergent1\":[],\"sergent2\":[],\"officierprincipal \":true,\"label\":\"Items du coffre\",\"grades\":{\"boss\":true},\"capitaine\":true,\"boss\":true,\"officier1\":[]},\"remove_item_chest_society\":{\"officier3\":false,\"officier2\":false,\"Under Sheriff\":true,\"lieutenant\":false,\"cadet\":false,\"sergent1\":false,\"sergent2\":false,\"officierprincipal \":false,\"label\":\"Retirer un item dans le coffre de la société\",\"grades\":{\"boss\":true},\"capitaine\":true,\"boss\":true,\"officier1\":false},\"withdraw_money_society\":{\"officier3\":false,\"officier2\":false,\"Under Sheriff\":true,\"lieutenant\":false,\"cadet\":false,\"sergent1\":false,\"sergent2\":false,\"officierprincipal \":false,\"label\":\"Retirer de l\'argent dans le coffre de la société\",\"grades\":{\"boss\":true},\"capitaine\":true,\"boss\":true,\"officier1\":false},\"weapons_chest\":{\"officier3\":[],\"officier2\":true,\"Under Sheriff\":true,\"lieutenant\":[],\"cadet\":false,\"sergent1\":[],\"sergent2\":[],\"officierprincipal \":[],\"label\":\"Armes du coffre\",\"grades\":{\"boss\":true},\"capitaine\":[],\"boss\":true,\"officier1\":[]},\"rename_grade\":{\"officier3\":false,\"officier2\":false,\"Under Sheriff\":true,\"lieutenant\":false,\"cadet\":false,\"sergent1\":false,\"sergent2\":false,\"officierprincipal \":false,\"label\":\"Changer le nom d\'un grade\",\"grades\":{\"boss\":true},\"capitaine\":true,\"boss\":true,\"officier1\":false},\"demote_player\":{\"officier3\":false,\"officier2\":false,\"Under Sheriff\":true,\"lieutenant\":false,\"cadet\":false,\"sergent1\":false,\"sergent2\":false,\"officierprincipal \":false,\"label\":\"Virer un employé\",\"grades\":{\"boss\":true},\"capitaine\":true,\"boss\":true,\"officier1\":false}}', '{\"x\":-437.8479614257813,\"y\":6011.97412109375,\"z\":27.58152770996093}', '{\"x\":-432.8706970214844,\"y\":6006.29931640625,\"z\":36.99566268920898}', '{\"color\":6,\"position\":{\"x\":-432.8706970214844,\"y\":6006.29931640625,\"z\":36.99566268920898},\"sprite\":60,\"active\":true}', '0', 1, '[{\"name\":\"unefined\",\"grades\":[],\"grade\":false,\"data\":{\"bracelets_2\":0,\"neck_thickness\":0,\"blemishes_1\":0,\"mask_1\":223,\"hair_color_1\":60,\"nose_1\":0,\"mask_2\":0,\"complexion_2\":0,\"tshirt_2\":2,\"hair_2\":0,\"chest_3\":0,\"nose_2\":0,\"beard_1\":16,\"bproof_1\":0,\"glasses_1\":56,\"lipstick_1\":0,\"lip_thickness\":0,\"watches_1\":21,\"lipstick_3\":0,\"dad\":37,\"chin_2\":0,\"bodyb_3\":-1,\"shoes_2\":0,\"mom\":21,\"eyebrows_6\":0,\"eyebrows_5\":0,\"complexion_1\":0,\"chin_4\":0,\"beard_2\":10,\"bags_1\":125,\"blemishes_2\":0,\"eyebrows_2\":0,\"face_md_weight\":50,\"face_color\":0,\"decals_1\":0,\"torso_2\":0,\"chin_1\":0,\"nose_3\":0,\"decals_2\":0,\"arms\":1,\"pants_2\":2,\"beard_3\":0,\"sun_2\":0,\"eyebrows_1\":0,\"tshirt_1\":81,\"sex\":0,\"bproof_2\":0,\"chain_2\":2,\"eyebrows_4\":0,\"cheeks_2\":0,\"hair_color_2\":0,\"ears_2\":0,\"chain_1\":278,\"eye_squint\":0,\"makeup_2\":0,\"sun_1\":0,\"helmet_2\":3,\"torso_1\":783,\"bags_2\":0,\"moles_1\":0,\"helmet_1\":113,\"pants_1\":327,\"skin_md_weight\":50,\"makeup_4\":0,\"hair_1\":73,\"nose_4\":0,\"watches_2\":0,\"moles_2\":0,\"eyebrows_3\":0,\"age_2\":0,\"chest_1\":0,\"jaw_1\":0,\"chest_2\":0,\"blush_3\":0,\"nose_6\":0,\"ears_1\":-1,\"bodyb_1\":-1,\"shoes_1\":54,\"lipstick_4\":0,\"blush_2\":0,\"bracelets_1\":3,\"bodyb_2\":0,\"glasses_2\":0,\"beard_4\":0,\"blush_1\":0,\"nose_5\":0,\"eye_color\":0,\"makeup_3\":0,\"makeup_1\":0,\"chin_3\":0,\"age_1\":0,\"bodyb_4\":0,\"arms_2\":0,\"cheeks_3\":0,\"cheeks_1\":0,\"jaw_2\":0,\"lipstick_2\":0}}]', '{\"x\":-439.0482177734375,\"y\":6011.17041015625,\"z\":36.99565887451172}'),
(32, 'police', 'LSPD', '{\"items_boss\":{\"pistol_ammo\":{\"label\":\"Munitions pour pistolet\",\"count\":490,\"name\":\"pistol_ammo\"},\"smg_ammo\":{\"label\":\"Munitions pour mitraillette\",\"count\":450,\"name\":\"smg_ammo\"},\"rifle_ammo\":{\"label\":\"Munitions pour fusil\",\"count\":450,\"name\":\"rifle_ammo\"},\"ball_ammo\":{\"label\":\"Munitions pour balles\",\"count\":450,\"name\":\"ball_ammo\"},\"shotgun_ammo\":{\"label\":\"Munitions pour fusil à pompe\",\"count\":500,\"name\":\"shotgun_ammo\"},\"burgershot_coca\":{\"label\":\"Coca Cola\",\"count\":59,\"name\":\"burgershot_coca\"},\"mg_ammo\":{\"label\":\"Munitions pour mitrailleuse\",\"count\":500,\"name\":\"mg_ammo\"},\"burgershot_burger\":{\"label\":\"Burger\",\"count\":54,\"name\":\"burgershot_burger\"}},\"items\":{\"kq_meth_low\":{\"label\":\"Méthamphétamine (Qualité basse)\",\"count\":12,\"name\":\"kq_meth_low\"},\"cokepure\":{\"label\":\"Cocaïne pure\",\"count\":18,\"name\":\"cokepure\"},\"coca_blend\":{\"label\":\"Mélange de coca\",\"count\":1,\"name\":\"coca_blend\"},\"crochetage_kit\":{\"label\":\"Kit de Crochetage\",\"count\":1,\"name\":\"crochetage_kit\"}},\"weapons\":{\"WEAPON_COMBATPISTOLPOL3\":{\"label\":\"Pistolet de combat\",\"number\":3,\"ammo\":255,\"name\":\"WEAPON_COMBATPISTOLPOL\"},\"WEAPON_PISTOL5\":{\"label\":\"Pistolet\",\"number\":5,\"ammo\":255,\"name\":\"WEAPON_PISTOL\"},\"WEAPON_COMBATPISTOL8\":{\"label\":\"Pistolet de combat\",\"number\":8,\"ammo\":255,\"name\":\"WEAPON_COMBATPISTOL\"},\"WEAPON_FLASHLIGHT10\":{\"label\":\"Lampe torche\",\"number\":10,\"ammo\":255,\"name\":\"WEAPON_FLASHLIGHT\"},\"WEAPON_COMBATPISTOL7\":{\"label\":\"Pistolet de combat\",\"number\":7,\"ammo\":255,\"name\":\"WEAPON_COMBATPISTOL\"},\"WEAPON_PISTOL6\":{\"label\":\"Pistolet\",\"number\":6,\"ammo\":255,\"name\":\"WEAPON_PISTOL\"},\"WEAPON_NIGHTSTICK8\":{\"label\":\"Matraque\",\"number\":8,\"ammo\":255,\"name\":\"WEAPON_NIGHTSTICK\"}},\"accounts\":{\"cash\":0,\"black_money\":53444,\"society\":12201125},\"weapons_boss\":[]}', '{\"deposit_item_chest\":{\"grades\":{\"boss\":true},\"swat\":true,\"officierprincipal \":[],\"Chief \":true,\"boss\":true,\"crm\":true,\"officier3\":true,\"label\":\"Déposer un item dans le coffre\",\"officier2\":true,\"lieutenant\":[],\"cadet\":true,\"officier1\":true,\"sergent2\":[],\"sergent1\":[],\"capitaine\":[]},\"withdraw_money_society\":{\"grades\":{\"boss\":true},\"swat\":true,\"officierprincipal \":false,\"Chief \":true,\"boss\":true,\"crm\":false,\"officier3\":false,\"label\":\"Retirer de l\'argent dans le coffre de la société\",\"officier2\":false,\"lieutenant\":false,\"cadet\":true,\"officier1\":false,\"sergent2\":false,\"sergent1\":false,\"capitaine\":[]},\"promote_player\":{\"grades\":{\"boss\":true},\"swat\":true,\"officierprincipal \":false,\"Chief \":true,\"boss\":true,\"crm\":false,\"officier3\":true,\"label\":\"Augmenter un employé\",\"officier2\":false,\"lieutenant\":[],\"cadet\":true,\"officier1\":false,\"sergent2\":true,\"sergent1\":false,\"capitaine\":[]},\"change_permissions_grade\":{\"grades\":{\"boss\":true},\"swat\":true,\"officierprincipal \":false,\"Chief \":true,\"boss\":true,\"crm\":false,\"officier3\":false,\"label\":\"Changer les permissions d\'un grade\",\"officier2\":false,\"lieutenant\":false,\"cadet\":true,\"officier1\":false,\"sergent2\":false,\"sergent1\":false,\"capitaine\":false},\"remove_item_chest_society\":{\"grades\":{\"boss\":true},\"swat\":true,\"officierprincipal \":false,\"Chief \":true,\"boss\":true,\"crm\":false,\"officier3\":false,\"label\":\"Retirer un item dans le coffre de la société\",\"officier2\":false,\"lieutenant\":false,\"cadet\":true,\"officier1\":false,\"sergent2\":false,\"sergent1\":false,\"capitaine\":[]},\"chest\":{\"grades\":{\"boss\":true},\"swat\":true,\"officierprincipal \":false,\"Chief \":true,\"boss\":true,\"crm\":false,\"officier3\":false,\"label\":\"Accéder au coffre de la société\",\"officier2\":false,\"lieutenant\":false,\"cadet\":true,\"officier1\":false,\"sergent2\":true,\"sergent1\":[],\"capitaine\":[]},\"rename_label_grade\":{\"grades\":{\"boss\":true},\"swat\":true,\"officierprincipal \":false,\"Chief \":true,\"boss\":true,\"crm\":false,\"officier3\":false,\"label\":\"Changer le label d\'un grade\",\"officier2\":false,\"lieutenant\":false,\"cadet\":true,\"officier1\":false,\"sergent2\":false,\"sergent1\":false,\"capitaine\":false},\"demote_player\":{\"grades\":{\"boss\":true},\"swat\":true,\"officierprincipal \":false,\"Chief \":true,\"boss\":true,\"crm\":false,\"officier3\":false,\"label\":\"Virer un employé\",\"officier2\":false,\"lieutenant\":false,\"cadet\":true,\"officier1\":false,\"sergent2\":true,\"sergent1\":false,\"capitaine\":[]},\"unmote_player\":{\"grades\":{\"boss\":true},\"swat\":true,\"officierprincipal \":false,\"Chief \":true,\"boss\":true,\"crm\":false,\"officier3\":false,\"label\":\"Descendre un employé\",\"officier2\":false,\"lieutenant\":false,\"cadet\":true,\"officier1\":false,\"sergent2\":true,\"sergent1\":false,\"capitaine\":[]},\"deposit_money_society\":{\"grades\":{\"boss\":true},\"swat\":true,\"officierprincipal \":false,\"Chief \":true,\"boss\":true,\"crm\":false,\"officier3\":false,\"label\":\"Déposer de l\'argent dans le coffre de la société\",\"officier2\":false,\"lieutenant\":[],\"cadet\":true,\"officier1\":false,\"sergent2\":true,\"sergent1\":true,\"capitaine\":[]},\"rename_grade\":{\"grades\":{\"boss\":true},\"swat\":true,\"officierprincipal \":false,\"Chief \":true,\"boss\":true,\"crm\":false,\"officier3\":false,\"label\":\"Changer le nom d\'un grade\",\"officier2\":false,\"lieutenant\":false,\"cadet\":true,\"officier1\":false,\"sergent2\":true,\"sergent1\":false,\"capitaine\":false},\"editClothes\":{\"grades\":{\"boss\":true},\"swat\":true,\"officierprincipal \":false,\"Chief \":true,\"boss\":true,\"crm\":false,\"officier3\":false,\"label\":\"Gérer les tenues dans le vestiaire\",\"officier2\":false,\"lieutenant\":false,\"cadet\":true,\"officier1\":false,\"sergent2\":false,\"sergent1\":false,\"capitaine\":[]},\"manage_grades\":{\"grades\":{\"boss\":true},\"swat\":true,\"officierprincipal \":false,\"Chief \":true,\"boss\":true,\"crm\":false,\"officier3\":false,\"label\":\"Gérer les grades de la société\",\"officier2\":false,\"lieutenant\":false,\"cadet\":true,\"officier1\":false,\"sergent2\":true,\"sergent1\":false,\"capitaine\":false},\"remove_weapon_chest_society\":{\"grades\":{\"boss\":true},\"swat\":true,\"officierprincipal \":false,\"Chief \":true,\"boss\":true,\"crm\":false,\"officier3\":false,\"label\":\"Retirer une arme dans la coffre de la société\",\"officier2\":false,\"lieutenant\":false,\"cadet\":true,\"officier1\":false,\"sergent2\":false,\"sergent1\":false,\"capitaine\":[]},\"change_salary_grade\":{\"grades\":{\"boss\":true},\"swat\":true,\"officierprincipal \":false,\"Chief \":true,\"boss\":true,\"crm\":false,\"officier3\":false,\"label\":\"Changer le salaire d\'un grade\",\"officier2\":false,\"lieutenant\":false,\"cadet\":true,\"officier1\":false,\"sergent2\":false,\"sergent1\":false,\"capitaine\":[]},\"weapons_chest_society\":{\"grades\":{\"boss\":true},\"swat\":true,\"officierprincipal \":false,\"Chief \":true,\"boss\":true,\"crm\":false,\"officier3\":[],\"label\":\"Arme(s) du coffre de la société\",\"officier2\":false,\"lieutenant\":false,\"cadet\":true,\"officier1\":false,\"sergent2\":false,\"sergent1\":false,\"capitaine\":[]},\"withdraw_black_money_coffre\":{\"grades\":{\"boss\":true},\"swat\":true,\"officierprincipal \":[],\"Chief \":true,\"boss\":true,\"crm\":false,\"officier3\":true,\"label\":\"Retirer de l\'argent sale dans le coffre\",\"officier2\":false,\"lieutenant\":[],\"cadet\":true,\"officier1\":false,\"sergent2\":[],\"sergent1\":[],\"capitaine\":[]},\"manage_employeds\":{\"grades\":{\"boss\":true},\"swat\":true,\"officierprincipal \":false,\"Chief \":true,\"boss\":true,\"crm\":false,\"officier3\":false,\"label\":\"Gérer les employés de la société\",\"officier2\":false,\"lieutenant\":false,\"cadet\":true,\"officier1\":false,\"sergent2\":true,\"sergent1\":false,\"capitaine\":[]},\"items_chest\":{\"grades\":{\"boss\":true},\"swat\":true,\"officierprincipal \":[],\"Chief \":true,\"boss\":true,\"crm\":false,\"officier3\":true,\"label\":\"Items du coffre\",\"officier2\":true,\"lieutenant\":[],\"cadet\":true,\"officier1\":true,\"sergent2\":[],\"sergent1\":[],\"capitaine\":[]},\"create_grade\":{\"grades\":{\"boss\":true},\"swat\":true,\"officierprincipal \":false,\"Chief \":true,\"boss\":true,\"crm\":false,\"officier3\":false,\"label\":\"Créer un grade\",\"officier2\":false,\"lieutenant\":false,\"cadet\":true,\"officier1\":false,\"sergent2\":false,\"sergent1\":false,\"capitaine\":true},\"open_coffre\":{\"grades\":{\"boss\":true},\"swat\":true,\"officierprincipal \":[],\"Chief \":true,\"boss\":true,\"crm\":true,\"officier3\":true,\"label\":\"Ouvrir le coffre\",\"officier2\":true,\"lieutenant\":[],\"cadet\":true,\"officier1\":true,\"sergent2\":[],\"sergent1\":[],\"capitaine\":[]},\"deposit_weapon_chest_society\":{\"grades\":{\"boss\":true},\"swat\":true,\"officierprincipal \":false,\"Chief \":true,\"boss\":true,\"crm\":false,\"officier3\":false,\"label\":\"Déposer une arme dans le coffre de la société\",\"officier2\":false,\"lieutenant\":false,\"cadet\":true,\"officier1\":false,\"sergent2\":false,\"sergent1\":false,\"capitaine\":[]},\"deposit_cash_coffre\":{\"grades\":{\"boss\":true},\"swat\":true,\"officierprincipal \":[],\"Chief \":true,\"boss\":true,\"crm\":true,\"officier3\":[],\"label\":\"Déposer de l\'argent dans le coffre\",\"officier2\":true,\"lieutenant\":[],\"cadet\":true,\"officier1\":[],\"sergent2\":[],\"sergent1\":[],\"capitaine\":[]},\"deposit_weapon_chest\":{\"grades\":{\"boss\":true},\"swat\":true,\"officierprincipal \":[],\"Chief \":true,\"boss\":true,\"crm\":true,\"officier3\":true,\"label\":\"Déposer une arme dans le coffre\",\"officier2\":true,\"lieutenant\":false,\"cadet\":[],\"officier1\":true,\"sergent2\":[],\"sergent1\":[],\"capitaine\":[]},\"remove_weapon_chest\":{\"grades\":{\"boss\":true},\"swat\":true,\"officierprincipal \":[],\"Chief \":true,\"boss\":true,\"crm\":true,\"officier3\":true,\"label\":\"Retirer une arme dans le coffre\",\"officier2\":true,\"lieutenant\":false,\"cadet\":true,\"officier1\":false,\"sergent2\":[],\"sergent1\":[],\"capitaine\":[]},\"deposit_black_money_coffre\":{\"grades\":{\"boss\":true},\"swat\":true,\"officierprincipal \":[],\"Chief \":true,\"boss\":true,\"crm\":true,\"officier3\":true,\"label\":\"Déposer de l\'argent sale dans le coffre\",\"officier2\":true,\"lieutenant\":[],\"cadet\":true,\"officier1\":true,\"sergent2\":[],\"sergent1\":[],\"capitaine\":[]},\"weapons_chest\":{\"grades\":{\"boss\":true},\"swat\":true,\"officierprincipal \":true,\"Chief \":true,\"boss\":true,\"crm\":false,\"officier3\":true,\"label\":\"Armes du coffre\",\"officier2\":true,\"lieutenant\":false,\"cadet\":[],\"officier1\":false,\"sergent2\":[],\"sergent1\":[],\"capitaine\":[]},\"dposit_item_chest_society\":{\"grades\":{\"boss\":true},\"swat\":true,\"officierprincipal \":false,\"Chief \":true,\"boss\":true,\"crm\":false,\"officier3\":false,\"label\":\"Déposer un item dans le coffre de la société\",\"officier2\":false,\"lieutenant\":false,\"cadet\":true,\"officier1\":false,\"sergent2\":false,\"sergent1\":false,\"capitaine\":[]},\"recruit_player\":{\"grades\":{\"boss\":true},\"swat\":true,\"officierprincipal \":true,\"Chief \":true,\"boss\":true,\"crm\":false,\"officier3\":false,\"label\":\"Recruté un joueur\",\"officier2\":false,\"lieutenant\":false,\"cadet\":true,\"officier1\":false,\"sergent2\":[],\"sergent1\":[],\"capitaine\":[]},\"delete_grade\":{\"grades\":{\"boss\":true},\"swat\":true,\"officierprincipal \":false,\"Chief \":true,\"boss\":true,\"crm\":false,\"officier3\":false,\"label\":\"Supprimer un grade\",\"officier2\":false,\"lieutenant\":false,\"cadet\":true,\"officier1\":false,\"sergent2\":false,\"sergent1\":false,\"capitaine\":true},\"change_number_grade\":{\"grades\":{\"boss\":true},\"swat\":true,\"officierprincipal \":false,\"Chief \":true,\"boss\":true,\"crm\":false,\"officier3\":false,\"label\":\"Changer le numéro d\'un grade\",\"officier2\":false,\"lieutenant\":false,\"cadet\":true,\"officier1\":false,\"sergent2\":false,\"sergent1\":false,\"capitaine\":false},\"withdraw_cash_coffre\":{\"grades\":{\"boss\":true},\"swat\":true,\"officierprincipal \":[],\"Chief \":true,\"boss\":true,\"crm\":false,\"officier3\":false,\"label\":\"Retirer de l\'argent dans le coffre\",\"officier2\":false,\"lieutenant\":false,\"cadet\":true,\"officier1\":false,\"sergent2\":[],\"sergent1\":true,\"capitaine\":[]},\"items_chest:society\":{\"grades\":{\"boss\":true},\"swat\":true,\"officierprincipal \":false,\"Chief \":true,\"boss\":true,\"crm\":false,\"officier3\":false,\"label\":\"Item(s) du coffre de la société\",\"officier2\":false,\"lieutenant\":false,\"cadet\":true,\"officier1\":false,\"sergent2\":false,\"sergent1\":false,\"capitaine\":[]},\"open_boss\":{\"grades\":{\"boss\":true},\"swat\":true,\"officierprincipal \":false,\"Chief \":true,\"boss\":true,\"crm\":false,\"officier3\":false,\"label\":\"Ouvrir le menu boss\",\"officier2\":false,\"lieutenant\":false,\"cadet\":true,\"officier1\":false,\"sergent2\":true,\"sergent1\":false,\"capitaine\":[]},\"remove_item_chest\":{\"grades\":{\"boss\":true},\"swat\":true,\"officierprincipal \":[],\"Chief \":true,\"boss\":true,\"crm\":true,\"officier3\":true,\"label\":\"Retirer un item dans le coffre\",\"officier2\":false,\"lieutenant\":false,\"cadet\":true,\"officier1\":false,\"sergent2\":[],\"sergent1\":[],\"capitaine\":[]}}', '{\"y\":-834.9634399414063,\"x\":-1090.831298828125,\"z\":23.12088394165039}', '{\"y\":-806.2178344726563,\"x\":-1072.383544921875,\"z\":23.15277099609375}', '{\"active\":true,\"sprite\":60,\"color\":67,\"position\":{\"y\":-825.0560302734375,\"x\":-1111.691650390625,\"z\":19.31609344482422}}', '10000', 1, '[{\"grades\":[],\"name\":\"LSPD FEMME\",\"data\":{\"helmet_1\":-1,\"hair_1\":510,\"nose_2\":0,\"decals_1\":0,\"pants_1\":346,\"makeup_1\":0,\"bodyb_3\":-1,\"lipstick_3\":0,\"tshirt_2\":0,\"nose_5\":0,\"eyebrows_2\":9,\"glasses_1\":79,\"hair_color_2\":0,\"eye_color\":19,\"eyebrows_5\":0,\"bproof_2\":0,\"lip_thickness\":0,\"face_md_weight\":50,\"cheeks_3\":0,\"cheeks_2\":0,\"blemishes_1\":0,\"pants_2\":0,\"jaw_1\":0,\"arms\":9,\"blush_1\":0,\"torso_1\":626,\"chest_2\":0,\"bodyb_1\":-1,\"blush_3\":0,\"cheeks_1\":0,\"mom\":41,\"glasses_2\":0,\"mask_2\":0,\"mask_1\":0,\"eyebrows_3\":3,\"beard_3\":0,\"helmet_2\":0,\"complexion_2\":0,\"age_1\":0,\"watches_2\":0,\"bags_1\":0,\"makeup_2\":0,\"tshirt_1\":6,\"chin_4\":0,\"bracelets_1\":0,\"chain_1\":0,\"bodyb_4\":0,\"bags_2\":0,\"blemishes_2\":0,\"lipstick_4\":0,\"makeup_4\":0,\"eyebrows_6\":0,\"eyebrows_4\":0,\"decals_2\":0,\"complexion_1\":0,\"chest_3\":0,\"jaw_2\":0,\"eyebrows_1\":1,\"shoes_1\":202,\"sex\":1,\"moles_2\":0,\"nose_1\":0,\"chain_2\":0,\"chin_2\":0,\"neck_thickness\":0,\"hair_2\":0,\"lipstick_1\":0,\"nose_4\":0,\"makeup_3\":0,\"bproof_1\":184,\"chest_1\":0,\"chin_3\":0,\"eye_squint\":0,\"sun_1\":0,\"beard_2\":0,\"age_2\":0,\"chin_1\":0,\"nose_6\":0,\"moles_1\":0,\"watches_1\":-1,\"nose_3\":0,\"sun_2\":0,\"bracelets_2\":0,\"ears_1\":-1,\"blush_2\":0,\"lipstick_2\":0,\"shoes_2\":0,\"ears_2\":0,\"bodyb_2\":0,\"arms_2\":0,\"dad\":26,\"beard_4\":0,\"skin_md_weight\":50,\"hair_color_1\":0,\"beard_1\":0,\"torso_2\":0},\"grade\":false},{\"grades\":[],\"name\":\"SASP\",\"data\":{\"torso_2\":2,\"hair_1\":0,\"nose_2\":0,\"hair_color_1\":0,\"pants_1\":49,\"makeup_1\":0,\"bodyb_3\":-1,\"lipstick_3\":0,\"eyebrows_1\":0,\"nose_5\":0,\"eyebrows_2\":0,\"glasses_1\":58,\"hair_color_2\":0,\"eye_color\":0,\"eyebrows_5\":0,\"bproof_2\":0,\"lip_thickness\":0,\"face_md_weight\":0,\"cheeks_3\":0,\"chain_2\":0,\"blemishes_1\":0,\"pants_2\":0,\"jaw_1\":0,\"arms\":12,\"blush_1\":0,\"torso_1\":193,\"chest_2\":0,\"bodyb_1\":-1,\"blush_3\":0,\"cheeks_1\":0,\"mom\":24,\"glasses_2\":0,\"mask_2\":0,\"mask_1\":274,\"nose_6\":0,\"beard_3\":0,\"helmet_2\":0,\"complexion_2\":0,\"chest_1\":0,\"watches_2\":0,\"bags_1\":33,\"makeup_2\":0,\"tshirt_1\":292,\"chin_4\":0,\"bracelets_1\":-1,\"chain_1\":233,\"complexion_1\":0,\"bags_2\":0,\"blemishes_2\":0,\"lipstick_4\":0,\"makeup_4\":0,\"lipstick_2\":0,\"nose_4\":0,\"decals_2\":5,\"sex\":0,\"age_2\":0,\"beard_4\":0,\"lipstick_1\":0,\"shoes_1\":61,\"jaw_2\":0,\"moles_2\":0,\"nose_1\":0,\"bproof_1\":62,\"cheeks_2\":0,\"nose_3\":0,\"hair_2\":0,\"chest_3\":0,\"ears_2\":0,\"makeup_3\":0,\"arms_2\":0,\"age_1\":0,\"shoes_2\":0,\"eye_squint\":0,\"sun_1\":0,\"beard_2\":0,\"neck_thickness\":0,\"decals_1\":0,\"chin_3\":0,\"eyebrows_3\":0,\"watches_1\":-1,\"eyebrows_4\":0,\"sun_2\":0,\"bracelets_2\":0,\"ears_1\":-1,\"blush_2\":0,\"eyebrows_6\":0,\"chin_2\":0,\"tshirt_2\":0,\"bodyb_2\":0,\"helmet_1\":-1,\"dad\":3,\"chin_1\":0,\"skin_md_weight\":0,\"moles_1\":0,\"beard_1\":0,\"bodyb_4\":0},\"grade\":false}]', '{\"y\":-814.5414428710938,\"x\":-1086.743408203125,\"z\":23.15271377563476}');
INSERT INTO `society_data` (`id`, `name`, `label`, `coffre`, `permissions`, `posCoffre`, `posBoss`, `blips`, `tax`, `cloakroom`, `clothes`, `cloakpos`) VALUES
(33, 'gouvernement', 'Gouvernement', '{\"weapons_boss\":[],\"accounts\":{\"society\":7062.594295664399,\"black_money\":0,\"cash\":0},\"weapons\":[],\"items\":[],\"items_boss\":[]}', '{\"promote_player\":{\"test\":false,\"procureur\":false,\"label\":\"Augmenter un employé\",\"Avocat\":false,\"garde\":false,\"juge\":false,\"boss\":true,\"president\":true,\"Secrétaire d\'Etat\":false,\"Ministre de la Justice\":false,\"Premier Ministre\":false,\"Secretaire Défense\":false,\"chefsecu\":false,\"Secretaire au Logement\":false,\"Ministre de l\'Economie\":false,\"Chef S\'écurité\":true,\"Vice Gouverneur\":true,\"grades\":{\"boss\":true}},\"chest\":{\"test\":false,\"procureur\":false,\"label\":\"Accéder au coffre de la société\",\"Avocat\":false,\"garde\":false,\"juge\":false,\"boss\":true,\"president\":true,\"Secrétaire d\'Etat\":false,\"Ministre de la Justice\":false,\"Premier Ministre\":true,\"Secretaire Défense\":false,\"chefsecu\":false,\"Secretaire au Logement\":false,\"Ministre de l\'Economie\":false,\"Chef S\'écurité\":true,\"Vice Gouverneur\":true,\"grades\":{\"boss\":true}},\"open_coffre\":{\"test\":false,\"procureur\":false,\"label\":\"Ouvrir le coffre\",\"Avocat\":false,\"garde\":true,\"juge\":false,\"boss\":true,\"president\":true,\"Secrétaire d\'Etat\":false,\"Ministre de la Justice\":false,\"Premier Ministre\":true,\"Secretaire Défense\":false,\"chefsecu\":false,\"Secretaire au Logement\":false,\"Ministre de l\'Economie\":false,\"Chef S\'écurité\":true,\"Vice Gouverneur\":true,\"grades\":{\"boss\":true}},\"change_number_grade\":{\"test\":false,\"procureur\":false,\"label\":\"Changer le numéro d\'un grade\",\"Avocat\":false,\"garde\":false,\"juge\":false,\"boss\":true,\"president\":true,\"Secrétaire d\'Etat\":false,\"Ministre de la Justice\":false,\"Premier Ministre\":false,\"Secretaire Défense\":false,\"chefsecu\":false,\"Secretaire au Logement\":false,\"Ministre de l\'Economie\":false,\"Chef S\'écurité\":true,\"Vice Gouverneur\":true,\"grades\":{\"boss\":true}},\"rename_grade\":{\"test\":false,\"procureur\":false,\"label\":\"Changer le nom d\'un grade\",\"Avocat\":false,\"garde\":false,\"juge\":false,\"boss\":true,\"president\":true,\"Secrétaire d\'Etat\":false,\"Ministre de la Justice\":false,\"Premier Ministre\":false,\"Secretaire Défense\":false,\"chefsecu\":false,\"Secretaire au Logement\":false,\"Ministre de l\'Economie\":false,\"Chef S\'écurité\":true,\"Vice Gouverneur\":true,\"grades\":{\"boss\":true}},\"change_salary_grade\":{\"test\":false,\"procureur\":false,\"label\":\"Changer le salaire d\'un grade\",\"Avocat\":false,\"garde\":false,\"juge\":false,\"boss\":true,\"president\":true,\"Secrétaire d\'Etat\":false,\"Ministre de la Justice\":false,\"Premier Ministre\":false,\"Secretaire Défense\":false,\"chefsecu\":false,\"Secretaire au Logement\":false,\"Ministre de l\'Economie\":false,\"Chef S\'écurité\":true,\"Vice Gouverneur\":true,\"grades\":{\"boss\":true}},\"delete_grade\":{\"test\":false,\"procureur\":false,\"label\":\"Supprimer un grade\",\"Avocat\":false,\"garde\":false,\"juge\":false,\"boss\":true,\"president\":true,\"Secrétaire d\'Etat\":false,\"Ministre de la Justice\":false,\"Premier Ministre\":false,\"Secretaire Défense\":false,\"chefsecu\":false,\"Secretaire au Logement\":false,\"Ministre de l\'Economie\":false,\"Chef S\'écurité\":true,\"Vice Gouverneur\":true,\"grades\":{\"boss\":true}},\"rename_label_grade\":{\"test\":false,\"procureur\":false,\"label\":\"Changer le label d\'un grade\",\"Avocat\":false,\"garde\":false,\"juge\":false,\"boss\":true,\"president\":true,\"Secrétaire d\'Etat\":false,\"Ministre de la Justice\":false,\"Premier Ministre\":false,\"Secretaire Défense\":false,\"chefsecu\":false,\"Secretaire au Logement\":false,\"Ministre de l\'Economie\":false,\"Chef S\'écurité\":true,\"Vice Gouverneur\":true,\"grades\":{\"boss\":true}},\"unmote_player\":{\"test\":false,\"procureur\":false,\"label\":\"Descendre un employé\",\"Avocat\":false,\"garde\":false,\"juge\":false,\"boss\":true,\"president\":true,\"Secrétaire d\'Etat\":false,\"Ministre de la Justice\":false,\"Premier Ministre\":false,\"Secretaire Défense\":false,\"chefsecu\":false,\"Secretaire au Logement\":false,\"Ministre de l\'Economie\":false,\"Chef S\'écurité\":true,\"Vice Gouverneur\":true,\"grades\":{\"boss\":true}},\"demote_player\":{\"test\":false,\"procureur\":false,\"label\":\"Virer un employé\",\"Avocat\":false,\"garde\":false,\"juge\":false,\"boss\":true,\"president\":true,\"Secrétaire d\'Etat\":false,\"Ministre de la Justice\":false,\"Premier Ministre\":false,\"Secretaire Défense\":false,\"chefsecu\":false,\"Secretaire au Logement\":false,\"Ministre de l\'Economie\":false,\"Chef S\'écurité\":true,\"Vice Gouverneur\":true,\"grades\":{\"boss\":true}},\"change_permissions_grade\":{\"test\":false,\"procureur\":false,\"label\":\"Changer les permissions d\'un grade\",\"Avocat\":false,\"garde\":false,\"juge\":false,\"boss\":true,\"president\":true,\"Secrétaire d\'Etat\":false,\"Ministre de la Justice\":false,\"Premier Ministre\":false,\"Secretaire Défense\":false,\"chefsecu\":false,\"Secretaire au Logement\":false,\"Ministre de l\'Economie\":false,\"Chef S\'écurité\":true,\"Vice Gouverneur\":true,\"grades\":{\"boss\":true}},\"create_grade\":{\"test\":false,\"procureur\":false,\"label\":\"Créer un grade\",\"Avocat\":false,\"garde\":false,\"juge\":false,\"boss\":true,\"president\":true,\"Secrétaire d\'Etat\":false,\"Ministre de la Justice\":false,\"Premier Ministre\":false,\"Secretaire Défense\":false,\"chefsecu\":false,\"Secretaire au Logement\":false,\"Ministre de l\'Economie\":false,\"Chef S\'écurité\":true,\"Vice Gouverneur\":true,\"grades\":{\"boss\":true}},\"remove_item_chest_society\":{\"test\":false,\"procureur\":false,\"label\":\"Retirer un item dans le coffre de la société\",\"Avocat\":false,\"garde\":false,\"juge\":false,\"boss\":true,\"president\":true,\"Secrétaire d\'Etat\":false,\"Ministre de la Justice\":false,\"Premier Ministre\":true,\"Secretaire Défense\":false,\"chefsecu\":false,\"Secretaire au Logement\":false,\"Ministre de l\'Economie\":false,\"Chef S\'écurité\":true,\"Vice Gouverneur\":true,\"grades\":{\"boss\":true}},\"weapons_chest\":{\"test\":false,\"procureur\":false,\"label\":\"Armes du coffre\",\"Avocat\":false,\"garde\":true,\"juge\":false,\"boss\":true,\"president\":true,\"Secrétaire d\'Etat\":false,\"Ministre de la Justice\":false,\"Premier Ministre\":true,\"Secretaire Défense\":false,\"chefsecu\":true,\"Secretaire au Logement\":false,\"Ministre de l\'Economie\":false,\"Chef S\'écurité\":true,\"Vice Gouverneur\":true,\"grades\":{\"boss\":true}},\"withdraw_money_society\":{\"test\":false,\"procureur\":false,\"label\":\"Retirer de l\'argent dans le coffre de la société\",\"Avocat\":false,\"garde\":false,\"juge\":false,\"boss\":true,\"president\":true,\"Secrétaire d\'Etat\":false,\"Ministre de la Justice\":false,\"Premier Ministre\":true,\"Secretaire Défense\":false,\"chefsecu\":false,\"Secretaire au Logement\":false,\"Ministre de l\'Economie\":false,\"Chef S\'écurité\":true,\"Vice Gouverneur\":true,\"grades\":{\"boss\":true}},\"open_boss\":{\"test\":false,\"procureur\":false,\"label\":\"Ouvrir le menu boss\",\"Avocat\":false,\"garde\":false,\"juge\":false,\"boss\":true,\"president\":true,\"Secrétaire d\'Etat\":false,\"Ministre de la Justice\":false,\"Premier Ministre\":false,\"Secretaire Défense\":false,\"chefsecu\":false,\"Secretaire au Logement\":false,\"Ministre de l\'Economie\":false,\"Chef S\'écurité\":true,\"Vice Gouverneur\":true,\"grades\":{\"boss\":true}},\"deposit_money_society\":{\"test\":false,\"procureur\":false,\"label\":\"Déposer de l\'argent dans le coffre de la société\",\"Avocat\":false,\"garde\":false,\"juge\":false,\"boss\":true,\"president\":true,\"Secrétaire d\'Etat\":false,\"Ministre de la Justice\":false,\"Premier Ministre\":true,\"Secretaire Défense\":false,\"chefsecu\":false,\"Secretaire au Logement\":false,\"Ministre de l\'Economie\":false,\"Chef S\'écurité\":true,\"Vice Gouverneur\":true,\"grades\":{\"boss\":true}},\"remove_weapon_chest_society\":{\"test\":false,\"procureur\":false,\"label\":\"Retirer une arme dans la coffre de la société\",\"Avocat\":false,\"garde\":false,\"juge\":false,\"boss\":true,\"president\":true,\"Secrétaire d\'Etat\":false,\"Ministre de la Justice\":false,\"Premier Ministre\":true,\"Secretaire Défense\":false,\"chefsecu\":false,\"Secretaire au Logement\":false,\"Ministre de l\'Economie\":false,\"Chef S\'écurité\":true,\"Vice Gouverneur\":true,\"grades\":{\"boss\":true}},\"deposit_black_money_coffre\":{\"test\":false,\"procureur\":false,\"label\":\"Déposer de l\'argent sale dans le coffre\",\"Avocat\":false,\"garde\":true,\"juge\":false,\"boss\":true,\"president\":true,\"Secrétaire d\'Etat\":false,\"Ministre de la Justice\":false,\"Premier Ministre\":true,\"Secretaire Défense\":false,\"chefsecu\":true,\"Secretaire au Logement\":false,\"Ministre de l\'Economie\":false,\"Chef S\'écurité\":true,\"Vice Gouverneur\":true,\"grades\":{\"boss\":true}},\"recruit_player\":{\"test\":false,\"procureur\":false,\"label\":\"Recruté un joueur\",\"Avocat\":false,\"garde\":false,\"juge\":false,\"boss\":true,\"president\":true,\"Secrétaire d\'Etat\":false,\"Ministre de la Justice\":false,\"Premier Ministre\":true,\"Secretaire Défense\":false,\"chefsecu\":false,\"Secretaire au Logement\":false,\"Ministre de l\'Economie\":false,\"Chef S\'écurité\":true,\"Vice Gouverneur\":true,\"grades\":{\"boss\":true}},\"deposit_weapon_chest_society\":{\"test\":false,\"procureur\":false,\"label\":\"Déposer une arme dans le coffre de la société\",\"Avocat\":false,\"garde\":false,\"juge\":false,\"boss\":true,\"president\":true,\"Secrétaire d\'Etat\":false,\"Ministre de la Justice\":false,\"Premier Ministre\":true,\"Secretaire Défense\":false,\"chefsecu\":true,\"Secretaire au Logement\":false,\"Ministre de l\'Economie\":false,\"Chef S\'écurité\":true,\"Vice Gouverneur\":true,\"grades\":{\"boss\":true}},\"deposit_weapon_chest\":{\"test\":false,\"procureur\":false,\"label\":\"Déposer une arme dans le coffre\",\"Avocat\":false,\"garde\":false,\"juge\":false,\"boss\":true,\"president\":true,\"Secrétaire d\'Etat\":false,\"Ministre de la Justice\":false,\"Premier Ministre\":true,\"Secretaire Défense\":false,\"chefsecu\":true,\"Secretaire au Logement\":false,\"Ministre de l\'Economie\":false,\"Chef S\'écurité\":true,\"Vice Gouverneur\":true,\"grades\":{\"boss\":true}},\"weapons_chest_society\":{\"test\":false,\"procureur\":false,\"label\":\"Arme(s) du coffre de la société\",\"Avocat\":false,\"garde\":false,\"juge\":false,\"boss\":true,\"president\":true,\"Secrétaire d\'Etat\":false,\"Ministre de la Justice\":false,\"Premier Ministre\":true,\"Secretaire Défense\":false,\"chefsecu\":false,\"Secretaire au Logement\":false,\"Ministre de l\'Economie\":false,\"Chef S\'écurité\":true,\"Vice Gouverneur\":true,\"grades\":{\"boss\":true}},\"remove_weapon_chest\":{\"test\":false,\"procureur\":false,\"label\":\"Retirer une arme dans le coffre\",\"Avocat\":false,\"garde\":false,\"juge\":false,\"boss\":true,\"president\":true,\"Secrétaire d\'Etat\":false,\"Ministre de la Justice\":false,\"Premier Ministre\":true,\"Secretaire Défense\":false,\"chefsecu\":true,\"Secretaire au Logement\":false,\"Ministre de l\'Economie\":false,\"Chef S\'écurité\":true,\"Vice Gouverneur\":true,\"grades\":{\"boss\":true}},\"manage_grades\":{\"test\":false,\"procureur\":false,\"label\":\"Gérer les grades de la société\",\"Avocat\":false,\"garde\":false,\"juge\":false,\"boss\":true,\"president\":true,\"Secrétaire d\'Etat\":false,\"Ministre de la Justice\":false,\"Premier Ministre\":false,\"Secretaire Défense\":false,\"chefsecu\":false,\"Secretaire au Logement\":false,\"Ministre de l\'Economie\":false,\"Chef S\'écurité\":true,\"Vice Gouverneur\":true,\"grades\":{\"boss\":true}},\"items_chest:society\":{\"test\":false,\"procureur\":false,\"label\":\"Item(s) du coffre de la société\",\"Avocat\":false,\"garde\":false,\"juge\":false,\"boss\":true,\"president\":true,\"Secrétaire d\'Etat\":false,\"Ministre de la Justice\":false,\"Premier Ministre\":true,\"Secretaire Défense\":false,\"chefsecu\":false,\"Secretaire au Logement\":false,\"Ministre de l\'Economie\":false,\"Chef S\'écurité\":true,\"Vice Gouverneur\":true,\"grades\":{\"boss\":true}},\"deposit_item_chest\":{\"test\":false,\"procureur\":false,\"label\":\"Déposer un item dans le coffre\",\"Avocat\":false,\"garde\":true,\"juge\":false,\"boss\":true,\"president\":true,\"Secrétaire d\'Etat\":false,\"Ministre de la Justice\":false,\"Premier Ministre\":true,\"Secretaire Défense\":false,\"chefsecu\":true,\"Secretaire au Logement\":false,\"Ministre de l\'Economie\":false,\"Chef S\'écurité\":true,\"Vice Gouverneur\":true,\"grades\":{\"boss\":true}},\"dposit_item_chest_society\":{\"test\":false,\"procureur\":false,\"label\":\"Déposer un item dans le coffre de la société\",\"Avocat\":false,\"garde\":false,\"juge\":false,\"boss\":true,\"president\":true,\"Secrétaire d\'Etat\":false,\"Ministre de la Justice\":false,\"Premier Ministre\":true,\"Secretaire Défense\":false,\"chefsecu\":false,\"Secretaire au Logement\":false,\"Ministre de l\'Economie\":false,\"Chef S\'écurité\":true,\"Vice Gouverneur\":true,\"grades\":{\"boss\":true}},\"editClothes\":{\"test\":false,\"procureur\":true,\"label\":\"Gérer les tenues dans le vestiaire\",\"Avocat\":false,\"garde\":false,\"juge\":true,\"boss\":true,\"president\":true,\"Secrétaire d\'Etat\":[],\"Ministre de la Justice\":[],\"Premier Ministre\":true,\"Secretaire Défense\":[],\"chefsecu\":false,\"Secretaire au Logement\":true,\"Ministre de l\'Economie\":[],\"Chef S\'écurité\":true,\"Vice Gouverneur\":true,\"grades\":{\"boss\":true}},\"manage_employeds\":{\"test\":false,\"procureur\":false,\"label\":\"Gérer les employés de la société\",\"Avocat\":false,\"garde\":false,\"juge\":false,\"boss\":true,\"president\":true,\"Secrétaire d\'Etat\":false,\"Ministre de la Justice\":false,\"Premier Ministre\":false,\"Secretaire Défense\":false,\"chefsecu\":false,\"Secretaire au Logement\":false,\"Ministre de l\'Economie\":false,\"Chef S\'écurité\":true,\"Vice Gouverneur\":true,\"grades\":{\"boss\":true}},\"withdraw_cash_coffre\":{\"test\":false,\"procureur\":false,\"label\":\"Retirer de l\'argent dans le coffre\",\"Avocat\":false,\"garde\":true,\"juge\":false,\"boss\":true,\"president\":true,\"Secrétaire d\'Etat\":false,\"Ministre de la Justice\":false,\"Premier Ministre\":true,\"Secretaire Défense\":false,\"chefsecu\":false,\"Secretaire au Logement\":false,\"Ministre de l\'Economie\":false,\"Chef S\'écurité\":true,\"Vice Gouverneur\":true,\"grades\":{\"boss\":true}},\"remove_item_chest\":{\"test\":false,\"procureur\":false,\"label\":\"Retirer un item dans le coffre\",\"Avocat\":false,\"garde\":false,\"juge\":false,\"boss\":true,\"president\":true,\"Secrétaire d\'Etat\":false,\"Ministre de la Justice\":false,\"Premier Ministre\":true,\"Secretaire Défense\":false,\"chefsecu\":true,\"Secretaire au Logement\":false,\"Ministre de l\'Economie\":false,\"Chef S\'écurité\":true,\"Vice Gouverneur\":true,\"grades\":{\"boss\":true}},\"withdraw_black_money_coffre\":{\"test\":false,\"procureur\":false,\"label\":\"Retirer de l\'argent sale dans le coffre\",\"Avocat\":false,\"garde\":false,\"juge\":false,\"boss\":true,\"president\":true,\"Secrétaire d\'Etat\":false,\"Ministre de la Justice\":false,\"Premier Ministre\":true,\"Secretaire Défense\":false,\"chefsecu\":false,\"Secretaire au Logement\":false,\"Ministre de l\'Economie\":false,\"Chef S\'écurité\":true,\"Vice Gouverneur\":true,\"grades\":{\"boss\":true}},\"deposit_cash_coffre\":{\"test\":false,\"procureur\":false,\"label\":\"Déposer de l\'argent dans le coffre\",\"Avocat\":false,\"garde\":true,\"juge\":false,\"boss\":true,\"president\":true,\"Secrétaire d\'Etat\":false,\"Ministre de la Justice\":false,\"Premier Ministre\":true,\"Secretaire Défense\":false,\"chefsecu\":true,\"Secretaire au Logement\":false,\"Ministre de l\'Economie\":false,\"Chef S\'écurité\":true,\"Vice Gouverneur\":true,\"grades\":{\"boss\":true}},\"items_chest\":{\"test\":false,\"procureur\":false,\"label\":\"Items du coffre\",\"Avocat\":false,\"garde\":true,\"juge\":false,\"boss\":true,\"president\":true,\"Secrétaire d\'Etat\":false,\"Ministre de la Justice\":false,\"Premier Ministre\":true,\"Secretaire Défense\":false,\"chefsecu\":true,\"Secretaire au Logement\":false,\"Ministre de l\'Economie\":false,\"Chef S\'écurité\":true,\"Vice Gouverneur\":true,\"grades\":{\"boss\":true}}}', '{\"x\":-565.3583984375,\"y\":-193.72940063476569,\"z\":38.21800994873047}', '{\"x\":-568.2265014648438,\"y\":-193.75869750976569,\"z\":38.21842193603515}', '{\"sprite\":419,\"position\":{\"x\":-545.161743,\"y\":-204.668915,\"z\":38.214741},\"active\":true,\"color\":0}', '0', 1, '[{\"name\":\"Premier Ministre\",\"grades\":{\"Premier Ministre\":\"Premier Ministre\"},\"grade\":true,\"data\":{\"complexion_2\":1,\"lipstick_4\":0,\"mask_2\":0,\"chin_3\":0,\"ears_2\":-1,\"blemishes_1\":1,\"blush_2\":3,\"bodyb_2\":0,\"neck_thickness\":10,\"torso_2\":1,\"hair_2\":0,\"decals_2\":0,\"cheeks_3\":5,\"cheeks_1\":10,\"moles_2\":7.0,\"glasses_1\":35,\"complexion_1\":5,\"bracelets_1\":1,\"lipstick_1\":-1,\"jaw_2\":-1,\"nose_2\":5,\"eyebrows_5\":6,\"beard_3\":0,\"hair_color_2\":0,\"bodyb_3\":-1,\"eyebrows_3\":41,\"tshirt_2\":0,\"watches_2\":-1,\"chin_1\":0,\"torso_1\":40,\"chest_3\":0,\"cheeks_2\":0,\"arms_2\":0,\"pants_2\":11,\"bodyb_1\":-1,\"moles_1\":6,\"makeup_1\":0,\"chin_2\":0,\"ears_1\":-1,\"bags_2\":0,\"pants_1\":105,\"chain_2\":0,\"bags_1\":0,\"nose_6\":0,\"hair_color_1\":55,\"bracelets_2\":0,\"dad\":15,\"makeup_2\":0,\"helmet_2\":0,\"mask_1\":254,\"mom\":44,\"chin_4\":0,\"lip_thickness\":5,\"helmet_1\":8,\"sun_1\":1,\"glasses_2\":0,\"eye_squint\":5,\"eye_color\":0,\"makeup_3\":0,\"nose_3\":0,\"nose_5\":0,\"beard_1\":3,\"eyebrows_4\":0,\"beard_4\":0,\"hair_1\":111,\"bproof_1\":0,\"beard_2\":3,\"eyebrows_1\":2,\"age_1\":0,\"face_md_weight\":10,\"decals_1\":191,\"jaw_1\":10,\"sun_2\":1,\"nose_1\":5,\"tshirt_1\":158,\"shoes_2\":7,\"blush_3\":0,\"bodyb_4\":5,\"nose_4\":6,\"arms\":6,\"blush_1\":-1,\"shoes_1\":20,\"chain_1\":25,\"eyebrows_2\":4,\"lipstick_2\":10.0,\"bproof_2\":0,\"blemishes_2\":1,\"chest_2\":0,\"age_2\":10.0,\"makeup_4\":10,\"eyebrows_6\":0,\"skin_md_weight\":3,\"watches_1\":11,\"chest_1\":0,\"lipstick_3\":37,\"sex\":0}},{\"name\":\"Securité\",\"grades\":[],\"grade\":false,\"data\":{\"complexion_2\":1,\"lipstick_4\":0,\"chin_4\":0,\"chin_3\":0,\"ears_2\":-1,\"mom\":44,\"blush_2\":3,\"bodyb_2\":0,\"neck_thickness\":10,\"torso_2\":0,\"hair_2\":0,\"decals_2\":0,\"cheeks_3\":5,\"cheeks_1\":10,\"moles_2\":7.0,\"glasses_1\":47,\"complexion_1\":5,\"bracelets_1\":1,\"lipstick_1\":-1,\"jaw_2\":-1,\"nose_2\":5,\"eyebrows_5\":6,\"beard_3\":0,\"mask_2\":0,\"bodyb_3\":-1,\"hair_color_1\":55,\"lipstick_2\":10.0,\"watches_2\":-1,\"chin_1\":0,\"hair_1\":104,\"chest_3\":0,\"makeup_4\":10,\"arms_2\":0,\"pants_2\":0,\"bodyb_1\":-1,\"moles_1\":6,\"makeup_1\":0,\"chin_2\":0,\"ears_1\":-1,\"bags_2\":0,\"cheeks_2\":0,\"helmet_2\":-1,\"bags_1\":138,\"nose_6\":0,\"dad\":15,\"bracelets_2\":0,\"mask_1\":254,\"makeup_2\":0,\"blemishes_1\":1,\"torso_1\":835,\"eyebrows_2\":4,\"helmet_1\":0,\"lip_thickness\":5,\"hair_color_2\":0,\"eyebrows_3\":41,\"glasses_2\":0,\"eye_squint\":5,\"nose_5\":0,\"makeup_3\":0,\"nose_3\":0,\"eyebrows_4\":0,\"beard_1\":3,\"bodyb_4\":5,\"beard_4\":0,\"decals_1\":0,\"bproof_1\":66,\"beard_2\":3,\"eyebrows_1\":2,\"age_1\":0,\"eye_color\":0,\"shoes_2\":0,\"jaw_1\":10,\"sun_2\":1,\"nose_1\":5,\"tshirt_1\":266,\"pants_1\":304,\"blush_3\":0,\"eyebrows_6\":0,\"nose_4\":6,\"arms\":96,\"blush_1\":-1,\"shoes_1\":259,\"chain_1\":368,\"tshirt_2\":0,\"sun_1\":1,\"bproof_2\":0,\"blemishes_2\":1,\"chest_2\":0,\"age_2\":10.0,\"skin_md_weight\":3,\"face_md_weight\":10,\"chain_2\":0,\"watches_1\":11,\"chest_1\":0,\"lipstick_3\":37,\"sex\":0}},{\"name\":\"Chef de Sécurité\",\"grades\":{\"chefsecu\":\"chefsecu\"},\"grade\":true,\"data\":{\"complexion_2\":1,\"lipstick_4\":0,\"chin_4\":0,\"chin_3\":0,\"ears_2\":-1,\"mom\":44,\"blush_2\":3,\"bodyb_2\":0,\"neck_thickness\":10,\"torso_2\":3,\"hair_2\":0,\"decals_2\":0,\"cheeks_3\":5,\"cheeks_1\":10,\"moles_2\":7.0,\"glasses_1\":47,\"complexion_1\":5,\"bracelets_1\":1,\"lipstick_1\":-1,\"jaw_2\":-1,\"nose_2\":5,\"eyebrows_5\":6,\"beard_3\":0,\"mask_2\":0,\"bodyb_3\":-1,\"hair_color_1\":55,\"lipstick_2\":10.0,\"watches_2\":-1,\"chin_1\":0,\"hair_1\":104,\"chest_3\":0,\"makeup_4\":10,\"arms_2\":0,\"pants_2\":0,\"bodyb_1\":-1,\"moles_1\":6,\"makeup_1\":0,\"chin_2\":0,\"ears_1\":-1,\"bags_2\":0,\"cheeks_2\":0,\"helmet_2\":-1,\"bags_1\":138,\"nose_6\":0,\"dad\":15,\"bracelets_2\":0,\"mask_1\":254,\"makeup_2\":0,\"blemishes_1\":1,\"torso_1\":835,\"eyebrows_2\":4,\"helmet_1\":0,\"lip_thickness\":5,\"hair_color_2\":0,\"eyebrows_3\":41,\"glasses_2\":0,\"eye_squint\":5,\"nose_5\":0,\"makeup_3\":0,\"nose_3\":0,\"eyebrows_4\":0,\"beard_1\":3,\"bodyb_4\":5,\"beard_4\":0,\"decals_1\":0,\"bproof_1\":66,\"beard_2\":3,\"eyebrows_1\":2,\"age_1\":0,\"eye_color\":0,\"shoes_2\":0,\"jaw_1\":10,\"sun_2\":1,\"nose_1\":5,\"tshirt_1\":266,\"pants_1\":304,\"blush_3\":0,\"eyebrows_6\":0,\"nose_4\":6,\"arms\":96,\"blush_1\":-1,\"shoes_1\":259,\"chain_1\":368,\"tshirt_2\":0,\"sun_1\":1,\"bproof_2\":1,\"blemishes_2\":1,\"chest_2\":0,\"age_2\":10.0,\"skin_md_weight\":3,\"face_md_weight\":10,\"chain_2\":0,\"watches_1\":11,\"chest_1\":0,\"lipstick_3\":37,\"sex\":0}},{\"name\":\"Juge\",\"grades\":{\"Premier Ministre\":\"Premier Ministre\",\"juge\":\"juge\",\"procureur\":\"procureur\"},\"grade\":true,\"data\":{\"complexion_2\":1,\"lipstick_4\":0,\"mask_2\":0,\"chin_3\":0,\"ears_2\":0,\"blemishes_1\":1,\"blush_2\":3,\"bodyb_2\":0,\"neck_thickness\":10,\"torso_2\":0,\"hair_2\":0,\"decals_2\":0,\"cheeks_3\":5,\"cheeks_1\":10,\"moles_2\":7.0,\"glasses_1\":34,\"complexion_1\":5,\"bracelets_1\":1,\"lipstick_1\":-1,\"jaw_2\":-1,\"nose_2\":5,\"eyebrows_5\":6,\"beard_3\":0,\"glasses_2\":0,\"bodyb_3\":-1,\"mask_1\":254,\"tshirt_2\":0,\"watches_2\":-1,\"chin_1\":0,\"cheeks_2\":0,\"chest_3\":0,\"pants_1\":118,\"arms_2\":0,\"pants_2\":0,\"bodyb_1\":-1,\"moles_1\":6,\"makeup_1\":0,\"chin_2\":0,\"ears_1\":223,\"bags_2\":0,\"helmet_2\":0,\"torso_1\":817,\"bags_1\":0,\"nose_6\":0,\"dad\":15,\"bracelets_2\":0,\"hair_1\":104,\"makeup_2\":0,\"nose_5\":0,\"chin_4\":0,\"eyebrows_3\":41,\"helmet_1\":8,\"lip_thickness\":5,\"sun_1\":1,\"hair_color_2\":0,\"face_md_weight\":10,\"eye_squint\":5,\"chain_2\":0,\"makeup_3\":0,\"nose_3\":0,\"eyebrows_4\":0,\"beard_1\":3,\"mom\":44,\"beard_4\":0,\"eyebrows_6\":0,\"bproof_1\":0,\"beard_2\":3,\"eyebrows_1\":2,\"age_1\":0,\"decals_1\":0,\"eye_color\":0,\"jaw_1\":10,\"sun_2\":1,\"nose_1\":5,\"tshirt_1\":311,\"shoes_2\":3,\"blush_3\":0,\"bodyb_4\":5,\"nose_4\":6,\"arms\":4,\"blush_1\":-1,\"shoes_1\":20,\"chain_1\":26,\"makeup_4\":10,\"lipstick_2\":10.0,\"bproof_2\":0,\"blemishes_2\":1,\"chest_2\":0,\"age_2\":10.0,\"hair_color_1\":55,\"skin_md_weight\":3,\"eyebrows_2\":4,\"watches_1\":11,\"chest_1\":0,\"lipstick_3\":37,\"sex\":0}},{\"name\":\"Secrétaire de Défense\",\"grades\":{\"Secretaire Défense\":\"Secretaire Défense\",\"boss\":\"boss\",\"Vice Gouverneur\":\"Vice Gouverneur\"},\"grade\":true,\"data\":{\"complexion_2\":1,\"lipstick_4\":0,\"mask_2\":0,\"chin_3\":0,\"ears_2\":0,\"mom\":44,\"blush_2\":3,\"bodyb_2\":0,\"neck_thickness\":10,\"torso_2\":0,\"hair_2\":0,\"decals_2\":0,\"cheeks_3\":5,\"cheeks_1\":10,\"moles_2\":7.0,\"glasses_1\":47,\"complexion_1\":5,\"bracelets_1\":1,\"lipstick_1\":-1,\"jaw_2\":-1,\"nose_2\":5,\"eyebrows_5\":6,\"beard_3\":0,\"pants_1\":315,\"bodyb_3\":-1,\"shoes_2\":1,\"lipstick_2\":10.0,\"watches_2\":-1,\"chin_1\":0,\"torso_1\":838,\"chest_3\":0,\"hair_color_1\":55,\"arms_2\":0,\"pants_2\":0,\"bodyb_1\":-1,\"moles_1\":6,\"makeup_1\":0,\"chin_2\":0,\"ears_1\":223,\"bags_2\":0,\"helmet_2\":-1,\"mask_1\":254,\"bags_1\":138,\"nose_6\":0,\"dad\":15,\"bracelets_2\":0,\"tshirt_2\":0,\"makeup_2\":0,\"eyebrows_4\":0,\"eyebrows_3\":41,\"makeup_4\":10,\"helmet_1\":8,\"lip_thickness\":5,\"chin_4\":0,\"hair_color_2\":0,\"glasses_2\":0,\"eye_squint\":5,\"sun_1\":1,\"makeup_3\":0,\"nose_3\":0,\"blemishes_1\":1,\"beard_1\":3,\"hair_1\":104,\"beard_4\":0,\"bodyb_4\":5,\"bproof_1\":73,\"beard_2\":3,\"eyebrows_1\":2,\"age_1\":0,\"decals_1\":165,\"eye_color\":0,\"jaw_1\":10,\"sun_2\":1,\"nose_1\":5,\"tshirt_1\":292,\"nose_5\":0,\"blush_3\":0,\"eyebrows_6\":0,\"nose_4\":6,\"arms\":180,\"blush_1\":-1,\"shoes_1\":61,\"chain_1\":368,\"eyebrows_2\":4,\"cheeks_2\":0,\"bproof_2\":0,\"blemishes_2\":1,\"chest_2\":0,\"age_2\":10.0,\"skin_md_weight\":3,\"face_md_weight\":10,\"chain_2\":0,\"watches_1\":11,\"chest_1\":0,\"lipstick_3\":37,\"sex\":0}},{\"name\":\"Gouverneur 1\",\"grades\":{\"boss\":\"boss\",\"Vice Gouverneur\":\"Vice Gouverneur\"},\"grade\":true,\"data\":{\"complexion_2\":0,\"lipstick_4\":0,\"chin_4\":0,\"chin_3\":0,\"ears_2\":0,\"blemishes_1\":0,\"blush_2\":0,\"bodyb_2\":0,\"neck_thickness\":0,\"torso_2\":0,\"hair_2\":0,\"decals_2\":0,\"cheeks_3\":0,\"cheeks_1\":0,\"moles_2\":0,\"glasses_1\":5,\"complexion_1\":0,\"bracelets_1\":-1,\"lipstick_1\":0,\"jaw_2\":0,\"nose_2\":0,\"eyebrows_5\":0,\"beard_3\":29,\"hair_1\":91,\"bodyb_3\":-1,\"mask_2\":0,\"watches_2\":0,\"dad\":24,\"chin_1\":0,\"cheeks_2\":0,\"chest_3\":0,\"makeup_4\":0,\"arms_2\":0,\"pants_2\":0,\"bodyb_1\":-1,\"moles_1\":0,\"makeup_1\":0,\"chin_2\":0,\"ears_1\":0,\"bags_2\":0,\"sun_1\":0,\"torso_1\":4,\"bags_1\":0,\"nose_6\":0,\"eyebrows_6\":0,\"bracelets_2\":0,\"mask_1\":0,\"makeup_2\":0,\"glasses_2\":0,\"mom\":2,\"helmet_1\":-1,\"hair_color_2\":29,\"lip_thickness\":0,\"hair_color_1\":29,\"eyebrows_2\":10,\"skin_md_weight\":50,\"eye_squint\":0,\"eyebrows_4\":0,\"makeup_3\":0,\"nose_3\":0,\"face_md_weight\":50,\"beard_1\":10,\"bodyb_4\":0,\"beard_4\":0,\"decals_1\":0,\"bproof_1\":0,\"beard_2\":10,\"eyebrows_1\":0,\"age_1\":0,\"eye_color\":0,\"helmet_2\":0,\"jaw_1\":0,\"sun_2\":0,\"nose_1\":0,\"tshirt_1\":146,\"pants_1\":24,\"blush_3\":0,\"tshirt_2\":0,\"nose_4\":0,\"arms\":4,\"blush_1\":0,\"shoes_1\":104,\"chain_1\":333,\"eyebrows_3\":0,\"lipstick_2\":0,\"bproof_2\":0,\"blemishes_2\":0,\"chest_2\":0,\"age_2\":0,\"shoes_2\":0,\"chain_2\":0,\"nose_5\":0,\"watches_1\":-1,\"chest_1\":0,\"lipstick_3\":0,\"sex\":0}},{\"name\":\"gouverneur 2\",\"grades\":{\"boss\":\"boss\",\"Vice Gouverneur\":\"Vice Gouverneur\"},\"grade\":true,\"data\":{\"complexion_2\":0,\"lipstick_4\":0,\"chin_4\":0,\"chin_3\":0,\"ears_2\":-1,\"blemishes_1\":0,\"blush_2\":0,\"bodyb_2\":0,\"neck_thickness\":0,\"torso_2\":4,\"hair_2\":0,\"decals_2\":0,\"cheeks_3\":0,\"cheeks_1\":0,\"moles_2\":0,\"glasses_1\":5,\"complexion_1\":0,\"bracelets_1\":-1,\"lipstick_1\":0,\"jaw_2\":0,\"nose_2\":0,\"eyebrows_5\":0,\"beard_3\":29,\"hair_1\":91,\"bodyb_3\":-1,\"mask_2\":0,\"watches_2\":0,\"dad\":24,\"chin_1\":0,\"cheeks_2\":0,\"chest_3\":0,\"makeup_4\":0,\"arms_2\":0,\"pants_2\":5,\"bodyb_1\":-1,\"moles_1\":0,\"makeup_1\":0,\"chin_2\":0,\"ears_1\":-1,\"bags_2\":0,\"sun_1\":0,\"torso_1\":120,\"bags_1\":0,\"nose_6\":0,\"eyebrows_6\":0,\"bracelets_2\":0,\"mask_1\":0,\"makeup_2\":0,\"glasses_2\":0,\"mom\":2,\"helmet_1\":8,\"hair_color_2\":29,\"lip_thickness\":0,\"hair_color_1\":29,\"eyebrows_2\":10,\"skin_md_weight\":50,\"eye_squint\":0,\"eyebrows_4\":0,\"makeup_3\":0,\"nose_3\":0,\"face_md_weight\":50,\"beard_1\":10,\"bodyb_4\":0,\"beard_4\":0,\"decals_1\":0,\"bproof_1\":0,\"beard_2\":10,\"eyebrows_1\":0,\"age_1\":0,\"eye_color\":0,\"helmet_2\":0,\"jaw_1\":0,\"sun_2\":0,\"nose_1\":0,\"tshirt_1\":157,\"pants_1\":24,\"blush_3\":0,\"tshirt_2\":0,\"nose_4\":0,\"arms\":1,\"blush_1\":0,\"shoes_1\":104,\"chain_1\":29,\"eyebrows_3\":0,\"lipstick_2\":0,\"bproof_2\":0,\"blemishes_2\":0,\"chest_2\":0,\"age_2\":0,\"shoes_2\":3,\"chain_2\":0,\"nose_5\":0,\"watches_1\":-1,\"chest_1\":0,\"lipstick_3\":0,\"sex\":0}},{\"name\":\"gouverneur 3\",\"grades\":{\"boss\":\"boss\",\"Vice Gouverneur\":\"Vice Gouverneur\"},\"grade\":true,\"data\":{\"complexion_2\":0,\"lipstick_4\":0,\"chin_4\":0,\"chin_3\":0,\"ears_2\":-1,\"blemishes_1\":0,\"blush_2\":0,\"bodyb_2\":0,\"neck_thickness\":0,\"torso_2\":4,\"hair_2\":0,\"decals_2\":0,\"cheeks_3\":0,\"cheeks_1\":0,\"moles_2\":0,\"glasses_1\":5,\"complexion_1\":0,\"bracelets_1\":-1,\"lipstick_1\":0,\"jaw_2\":0,\"nose_2\":0,\"eyebrows_5\":0,\"beard_3\":29,\"hair_1\":91,\"bodyb_3\":-1,\"mask_2\":0,\"watches_2\":0,\"dad\":24,\"chin_1\":0,\"cheeks_2\":0,\"chest_3\":0,\"makeup_4\":0,\"arms_2\":0,\"pants_2\":5,\"bodyb_1\":-1,\"moles_1\":0,\"makeup_1\":0,\"chin_2\":0,\"ears_1\":-1,\"bags_2\":0,\"sun_1\":0,\"torso_1\":120,\"bags_1\":0,\"nose_6\":0,\"eyebrows_6\":0,\"bracelets_2\":0,\"mask_1\":0,\"makeup_2\":0,\"glasses_2\":0,\"mom\":2,\"helmet_1\":8,\"hair_color_2\":29,\"lip_thickness\":0,\"hair_color_1\":29,\"eyebrows_2\":10,\"skin_md_weight\":50,\"eye_squint\":0,\"eyebrows_4\":0,\"makeup_3\":0,\"nose_3\":0,\"face_md_weight\":50,\"beard_1\":10,\"bodyb_4\":0,\"beard_4\":0,\"decals_1\":0,\"bproof_1\":0,\"beard_2\":10,\"eyebrows_1\":0,\"age_1\":0,\"eye_color\":0,\"helmet_2\":0,\"jaw_1\":0,\"sun_2\":0,\"nose_1\":0,\"tshirt_1\":157,\"pants_1\":24,\"blush_3\":0,\"tshirt_2\":0,\"nose_4\":0,\"arms\":1,\"blush_1\":0,\"shoes_1\":104,\"chain_1\":29,\"eyebrows_3\":0,\"lipstick_2\":0,\"bproof_2\":0,\"blemishes_2\":0,\"chest_2\":0,\"age_2\":0,\"shoes_2\":3,\"chain_2\":0,\"nose_5\":0,\"watches_1\":-1,\"chest_1\":0,\"lipstick_3\":0,\"sex\":0}},{\"name\":\"Avocat\",\"grades\":{\"Avocat\":\"Avocat\"},\"grade\":true,\"data\":{\"complexion_2\":0,\"lipstick_4\":0,\"mask_2\":0,\"chin_3\":0,\"ears_2\":0,\"mom\":2,\"blush_2\":0,\"bodyb_2\":0,\"neck_thickness\":0,\"torso_2\":0,\"hair_2\":0,\"decals_2\":0,\"cheeks_3\":0,\"cheeks_1\":0,\"eyebrows_3\":0,\"glasses_1\":5,\"complexion_1\":0,\"bracelets_1\":-1,\"lipstick_1\":0,\"jaw_2\":0,\"nose_2\":0,\"eyebrows_5\":0,\"beard_3\":29,\"eyebrows_2\":10,\"bodyb_3\":-1,\"hair_1\":91,\"torso_1\":295,\"watches_2\":0,\"chin_1\":0,\"cheeks_2\":0,\"chest_3\":0,\"makeup_4\":0,\"arms_2\":0,\"pants_2\":0,\"bodyb_1\":-1,\"moles_1\":0,\"makeup_1\":0,\"chin_2\":0,\"ears_1\":0,\"bags_2\":0,\"glasses_2\":0,\"pants_1\":28,\"bags_1\":0,\"nose_6\":0,\"dad\":24,\"bracelets_2\":0,\"sun_1\":0,\"makeup_2\":0,\"mask_1\":0,\"shoes_2\":3,\"bodyb_4\":0,\"helmet_1\":-1,\"lip_thickness\":0,\"tshirt_2\":0,\"face_md_weight\":50,\"skin_md_weight\":50,\"eye_squint\":0,\"hair_color_2\":29,\"makeup_3\":0,\"nose_3\":0,\"eyebrows_4\":0,\"beard_1\":10,\"blemishes_1\":0,\"beard_4\":0,\"helmet_2\":0,\"bproof_1\":0,\"beard_2\":10,\"eyebrows_1\":0,\"age_1\":0,\"eye_color\":0,\"nose_5\":0,\"jaw_1\":0,\"sun_2\":0,\"nose_1\":0,\"tshirt_1\":35,\"decals_1\":0,\"blush_3\":0,\"eyebrows_6\":0,\"nose_4\":0,\"arms\":12,\"blush_1\":0,\"shoes_1\":104,\"chain_1\":343,\"chin_4\":0,\"lipstick_2\":0,\"bproof_2\":0,\"blemishes_2\":0,\"chest_2\":0,\"age_2\":0,\"moles_2\":0,\"hair_color_1\":29,\"chain_2\":0,\"watches_1\":-1,\"chest_1\":0,\"lipstick_3\":0,\"sex\":0}},{\"grades\":{\"chefsecu\":\"chefsecu\",\"garde\":\"garde\"},\"name\":\"sécurité\",\"grade\":true,\"data\":{\"complexion_2\":0,\"lipstick_4\":0,\"mask_2\":0,\"chin_3\":0,\"hair_1\":0,\"mom\":2,\"blush_2\":0,\"bodyb_2\":0,\"neck_thickness\":0,\"torso_2\":0,\"hair_2\":0,\"decals_2\":0,\"cheeks_3\":0,\"cheeks_1\":0,\"eyebrows_3\":0,\"glasses_1\":5,\"complexion_1\":0,\"bracelets_1\":-1,\"lipstick_1\":0,\"eyebrows_4\":0,\"nose_2\":0,\"eyebrows_5\":0,\"beard_3\":29,\"bproof_1\":0,\"skin_md_weight\":50,\"chain_2\":0,\"eyebrows_6\":0,\"bodyb_4\":0,\"chin_1\":0,\"bodyb_1\":-1,\"eye_color\":0,\"face_md_weight\":50,\"lipstick_2\":0,\"pants_2\":0,\"torso_1\":295,\"moles_1\":0,\"makeup_1\":0,\"chin_2\":0,\"ears_1\":0,\"bags_2\":0,\"sun_1\":0,\"eyebrows_2\":10,\"bags_1\":0,\"nose_6\":0,\"nose_5\":0,\"bracelets_2\":0,\"tshirt_1\":35,\"makeup_2\":0,\"jaw_2\":0,\"mask_1\":0,\"hair_color_2\":29,\"watches_1\":-1,\"lip_thickness\":0,\"moles_2\":0,\"helmet_1\":-1,\"glasses_2\":0,\"eye_squint\":0,\"chin_4\":0,\"makeup_3\":0,\"nose_3\":0,\"arms_2\":0,\"beard_1\":10,\"shoes_2\":3,\"beard_4\":0,\"watches_2\":0,\"makeup_4\":0,\"beard_2\":10,\"eyebrows_1\":0,\"age_1\":0,\"dad\":24,\"chest_3\":0,\"jaw_1\":0,\"sun_2\":0,\"nose_1\":0,\"pants_1\":28,\"decals_1\":0,\"blush_3\":0,\"tshirt_2\":0,\"nose_4\":0,\"arms\":12,\"blush_1\":0,\"shoes_1\":104,\"chain_1\":343,\"hair_color_1\":29,\"cheeks_2\":0,\"bproof_2\":0,\"blemishes_2\":0,\"chest_2\":0,\"age_2\":0,\"blemishes_1\":0,\"ears_2\":0,\"bodyb_3\":-1,\"helmet_2\":0,\"chest_1\":0,\"lipstick_3\":0,\"sex\":0}}]', '{\"x\":-568.9598388671875,\"y\":-199.23117065429688,\"z\":38.21366500854492}'),
(35, 'le_ferailleur', 'Roger Salvage et Scrap', '{\"accounts\":{\"society\":15250,\"cash\":0,\"black_money\":0},\"items\":[],\"items_boss\":[],\"weapons\":[],\"weapons_boss\":[]}', '{\"create_grade\":{\"Ramasseur\":false,\"Co -patron\":true,\"boss\":true,\"grades\":{\"boss\":true},\"label\":\"Créer un grade\"},\"items_chest:society\":{\"Ramasseur\":false,\"Co -patron\":true,\"boss\":true,\"grades\":{\"boss\":true},\"label\":\"Item(s) du coffre de la société\"},\"chest\":{\"Ramasseur\":false,\"Co -patron\":true,\"boss\":true,\"grades\":{\"boss\":true},\"label\":\"Accéder au coffre de la société\"},\"promote_player\":{\"Ramasseur\":false,\"Co -patron\":true,\"boss\":true,\"grades\":{\"boss\":true},\"label\":\"Augmenter un employé\"},\"withdraw_money_society\":{\"Ramasseur\":false,\"Co -patron\":true,\"boss\":true,\"grades\":{\"boss\":true},\"label\":\"Retirer de l\'argent dans le coffre de la société\"},\"remove_item_chest\":{\"Ramasseur\":false,\"Co -patron\":true,\"boss\":true,\"grades\":{\"boss\":true},\"label\":\"Retirer un item dans le coffre\"},\"change_permissions_grade\":{\"Ramasseur\":false,\"Co -patron\":true,\"boss\":true,\"grades\":{\"boss\":true},\"label\":\"Changer les permissions d\'un grade\"},\"remove_weapon_chest_society\":{\"Ramasseur\":false,\"Co -patron\":true,\"boss\":true,\"grades\":{\"boss\":true},\"label\":\"Retirer une arme dans la coffre de la société\"},\"withdraw_black_money_coffre\":{\"Ramasseur\":false,\"Co -patron\":true,\"boss\":true,\"grades\":{\"boss\":true},\"label\":\"Retirer de l\'argent sale dans le coffre\"},\"open_boss\":{\"Ramasseur\":false,\"Co -patron\":true,\"boss\":true,\"grades\":{\"boss\":true},\"label\":\"Ouvrir le menu boss\"},\"demote_player\":{\"Ramasseur\":false,\"Co -patron\":false,\"boss\":true,\"grades\":{\"boss\":true},\"label\":\"Virer un employé\"},\"deposit_money_society\":{\"Ramasseur\":false,\"Co -patron\":true,\"boss\":true,\"grades\":{\"boss\":true},\"label\":\"Déposer de l\'argent dans le coffre de la société\"},\"editClothes\":{\"Ramasseur\":false,\"Co -patron\":true,\"boss\":true,\"grades\":{\"boss\":true},\"label\":\"Gérer les tenues dans le vestiaire\"},\"delete_grade\":{\"Ramasseur\":false,\"Co -patron\":true,\"boss\":true,\"grades\":{\"boss\":true},\"label\":\"Supprimer un grade\"},\"deposit_weapon_chest_society\":{\"Ramasseur\":false,\"Co -patron\":true,\"boss\":true,\"grades\":{\"boss\":true},\"label\":\"Déposer une arme dans le coffre de la société\"},\"rename_label_grade\":{\"Ramasseur\":false,\"Co -patron\":true,\"boss\":true,\"grades\":{\"boss\":true},\"label\":\"Changer le label d\'un grade\"},\"remove_item_chest_society\":{\"Ramasseur\":false,\"Co -patron\":true,\"boss\":true,\"grades\":{\"boss\":true},\"label\":\"Retirer un item dans le coffre de la société\"},\"manage_employeds\":{\"Ramasseur\":false,\"Co -patron\":true,\"boss\":true,\"grades\":{\"boss\":true},\"label\":\"Gérer les employés de la société\"},\"dposit_item_chest_society\":{\"Ramasseur\":false,\"Co -patron\":true,\"boss\":true,\"grades\":{\"boss\":true},\"label\":\"Déposer un item dans le coffre de la société\"},\"deposit_weapon_chest\":{\"Ramasseur\":false,\"Co -patron\":true,\"boss\":true,\"grades\":{\"boss\":true},\"label\":\"Déposer une arme dans le coffre\"},\"remove_weapon_chest\":{\"Ramasseur\":false,\"Co -patron\":true,\"boss\":true,\"grades\":{\"boss\":true},\"label\":\"Retirer une arme dans le coffre\"},\"withdraw_cash_coffre\":{\"Ramasseur\":false,\"Co -patron\":true,\"boss\":true,\"grades\":{\"boss\":true},\"label\":\"Retirer de l\'argent dans le coffre\"},\"change_number_grade\":{\"Ramasseur\":false,\"Co -patron\":true,\"boss\":true,\"grades\":{\"boss\":true},\"label\":\"Changer le numéro d\'un grade\"},\"recruit_player\":{\"Ramasseur\":false,\"Co -patron\":true,\"boss\":true,\"grades\":{\"boss\":true},\"label\":\"Recruté un joueur\"},\"deposit_item_chest\":{\"Ramasseur\":true,\"Co -patron\":true,\"boss\":true,\"grades\":{\"boss\":true},\"label\":\"Déposer un item dans le coffre\"},\"manage_grades\":{\"Ramasseur\":false,\"Co -patron\":true,\"boss\":true,\"grades\":{\"boss\":true},\"label\":\"Gérer les grades de la société\"},\"deposit_cash_coffre\":{\"Ramasseur\":false,\"Co -patron\":true,\"boss\":true,\"grades\":{\"boss\":true},\"label\":\"Déposer de l\'argent dans le coffre\"},\"items_chest\":{\"Ramasseur\":true,\"Co -patron\":true,\"boss\":true,\"grades\":{\"boss\":true},\"label\":\"Items du coffre\"},\"rename_grade\":{\"Ramasseur\":false,\"Co -patron\":true,\"boss\":true,\"grades\":{\"boss\":true},\"label\":\"Changer le nom d\'un grade\"},\"unmote_player\":{\"Ramasseur\":false,\"Co -patron\":true,\"boss\":true,\"grades\":{\"boss\":true},\"label\":\"Descendre un employé\"},\"weapons_chest_society\":{\"Ramasseur\":false,\"Co -patron\":true,\"boss\":true,\"grades\":{\"boss\":true},\"label\":\"Arme(s) du coffre de la société\"},\"change_salary_grade\":{\"Ramasseur\":false,\"Co -patron\":true,\"boss\":true,\"grades\":{\"boss\":true},\"label\":\"Changer le salaire d\'un grade\"},\"open_coffre\":{\"Ramasseur\":true,\"Co -patron\":true,\"boss\":true,\"grades\":{\"boss\":true},\"label\":\"Ouvrir le coffre\"},\"weapons_chest\":{\"Ramasseur\":false,\"Co -patron\":true,\"boss\":true,\"grades\":{\"boss\":true},\"label\":\"Armes du coffre\"},\"deposit_black_money_coffre\":{\"Ramasseur\":false,\"Co -patron\":true,\"boss\":true,\"grades\":{\"boss\":true},\"label\":\"Déposer de l\'argent sale dans le coffre\"}}', '{\"y\":-1617.8726806640626,\"x\":-621.104248046875,\"z\":33.01055145263672}', '{\"y\":-1623.073974609375,\"x\":-617.3504028320313,\"z\":33.01055145263672}', '{\"sprite\":67,\"position\":{\"y\":-1629.8315429688,\"x\":-617.04089355469,\"z\":33.010578155518},\"active\":true,\"color\":0}', '1', 1, '[{\"data\":{\"cheeks_1\":0,\"eyebrows_4\":0,\"tshirt_1\":-1,\"lipstick_1\":0,\"hair_color_2\":15,\"skin_md_weight\":50,\"arms\":30,\"pants_1\":321,\"bproof_2\":0,\"nose_5\":0,\"lipstick_2\":0,\"ears_1\":-1,\"hair_2\":0,\"complexion_1\":0,\"bags_2\":0,\"makeup_2\":0,\"makeup_4\":0,\"sun_2\":0,\"eyebrows_2\":10,\"complexion_2\":0,\"dad\":0,\"makeup_3\":0,\"blush_3\":0,\"bodyb_4\":0,\"cheeks_3\":0,\"lipstick_3\":0,\"eye_color\":0,\"blush_2\":0,\"bodyb_3\":-1,\"nose_4\":0,\"chains_2\":0,\"beard_3\":29,\"eyebrows_6\":0,\"mask_1\":0,\"beard_2\":9,\"age_1\":0,\"eyebrows_1\":22,\"moles_1\":0,\"torso_2\":2,\"beard_4\":0,\"hair_color_1\":29,\"chin_3\":0,\"decals_2\":0,\"glasses_1\":50,\"shoes_2\":9,\"neck_thickness\":0,\"glasses_2\":0,\"chest_2\":0,\"lip_thickness\":0,\"hair_1\":11,\"bproof_1\":0,\"torso_1\":0,\"bracelets_2\":0,\"chain_2\":1,\"pants_2\":0,\"helmet_1\":175,\"eyebrows_5\":0,\"nose_6\":0,\"watches_2\":0,\"arms_2\":0,\"blemishes_1\":0,\"mom\":38,\"shoes_1\":196,\"chest_1\":0,\"blemishes_2\":0,\"decals_1\":0,\"chains_1\":0,\"blush_1\":0,\"eye_squint\":0,\"arms_1\":30,\"nose_3\":0,\"chain_1\":248,\"bags_1\":82,\"bracelets_1\":-1,\"watches_1\":30,\"jaw_1\":0,\"sex\":0,\"makeup_1\":0,\"mask_2\":0,\"chin_4\":0,\"nose_1\":0,\"ears_2\":0,\"age_2\":0,\"chest_3\":0,\"jaw_2\":0,\"sun_1\":0,\"eyebrows_3\":29,\"beard_1\":10,\"helmet_2\":0,\"chin_2\":0,\"face_md_weight\":50,\"tshirt_2\":-1,\"cheeks_2\":0,\"lipstick_4\":0,\"moles_2\":0,\"nose_2\":0,\"bodyb_1\":-1,\"bodyb_2\":0,\"chin_1\":0},\"grades\":{\"Co -patron\":\"Co -patron\"},\"grade\":true,\"name\":\"co-Patron\"},{\"data\":{\"cheeks_1\":0,\"eyebrows_4\":0,\"tshirt_1\":15,\"lipstick_1\":0,\"hair_color_2\":15,\"skin_md_weight\":50,\"arms\":1,\"pants_1\":317,\"bproof_2\":0,\"nose_5\":0,\"lipstick_2\":0,\"ears_1\":-1,\"hair_2\":0,\"complexion_1\":0,\"bags_2\":2,\"makeup_2\":0,\"makeup_4\":0,\"sun_2\":0,\"eyebrows_2\":10,\"complexion_2\":0,\"dad\":0,\"makeup_3\":0,\"blush_3\":0,\"bodyb_4\":0,\"cheeks_3\":0,\"lipstick_3\":0,\"eye_color\":0,\"blush_2\":0,\"bodyb_3\":-1,\"nose_4\":0,\"chains_2\":0,\"beard_3\":29,\"eyebrows_6\":0,\"mask_1\":0,\"beard_2\":9,\"age_1\":0,\"eyebrows_1\":22,\"moles_1\":0,\"torso_2\":1,\"beard_4\":0,\"hair_color_1\":29,\"chin_3\":0,\"decals_2\":0,\"glasses_1\":0,\"shoes_2\":0,\"neck_thickness\":0,\"glasses_2\":0,\"chest_2\":0,\"lip_thickness\":0,\"hair_1\":11,\"bproof_1\":0,\"torso_1\":792,\"bracelets_2\":0,\"chain_2\":0,\"pants_2\":0,\"helmet_1\":238,\"eyebrows_5\":0,\"nose_6\":0,\"watches_2\":0,\"arms_2\":0,\"blemishes_1\":0,\"mom\":38,\"shoes_1\":259,\"chest_1\":0,\"blemishes_2\":0,\"decals_1\":190,\"chains_1\":0,\"blush_1\":0,\"eye_squint\":0,\"arms_1\":205,\"nose_3\":0,\"chain_1\":0,\"bags_1\":82,\"bracelets_1\":-1,\"watches_1\":-1,\"jaw_1\":0,\"sex\":0,\"makeup_1\":0,\"mask_2\":0,\"chin_4\":0,\"nose_1\":0,\"ears_2\":0,\"age_2\":0,\"chest_3\":0,\"jaw_2\":0,\"sun_1\":0,\"eyebrows_3\":29,\"beard_1\":10,\"helmet_2\":0,\"chin_2\":0,\"face_md_weight\":50,\"tshirt_2\":0,\"cheeks_2\":0,\"lipstick_4\":0,\"moles_2\":0,\"nose_2\":0,\"bodyb_1\":-1,\"bodyb_2\":0,\"chin_1\":0},\"grades\":[],\"grade\":false,\"name\":\"unefined\"},{\"data\":{\"cheeks_1\":0,\"eyebrows_4\":0,\"tshirt_1\":15,\"lipstick_1\":0,\"hair_color_2\":15,\"skin_md_weight\":50,\"arms\":1,\"pants_1\":317,\"bproof_2\":0,\"nose_5\":0,\"lipstick_2\":0,\"ears_1\":-1,\"hair_2\":0,\"complexion_1\":0,\"bags_2\":2,\"makeup_2\":0,\"makeup_4\":0,\"sun_2\":0,\"eyebrows_2\":10,\"complexion_2\":0,\"dad\":0,\"makeup_3\":0,\"blush_3\":0,\"bodyb_4\":0,\"cheeks_3\":0,\"lipstick_3\":0,\"eye_color\":0,\"blush_2\":0,\"bodyb_3\":-1,\"nose_4\":0,\"chains_2\":0,\"beard_3\":29,\"eyebrows_6\":0,\"mask_1\":0,\"beard_2\":9,\"age_1\":0,\"eyebrows_1\":22,\"moles_1\":0,\"torso_2\":1,\"beard_4\":0,\"hair_color_1\":29,\"chin_3\":0,\"decals_2\":0,\"glasses_1\":0,\"shoes_2\":0,\"neck_thickness\":0,\"glasses_2\":0,\"chest_2\":0,\"lip_thickness\":0,\"hair_1\":11,\"bproof_1\":0,\"torso_1\":792,\"bracelets_2\":0,\"chain_2\":0,\"pants_2\":0,\"helmet_1\":238,\"eyebrows_5\":0,\"nose_6\":0,\"watches_2\":0,\"arms_2\":0,\"blemishes_1\":0,\"mom\":38,\"shoes_1\":259,\"chest_1\":0,\"blemishes_2\":0,\"decals_1\":190,\"chains_1\":0,\"blush_1\":0,\"eye_squint\":0,\"arms_1\":205,\"nose_3\":0,\"chain_1\":0,\"bags_1\":82,\"bracelets_1\":-1,\"watches_1\":-1,\"jaw_1\":0,\"sex\":0,\"makeup_1\":0,\"mask_2\":0,\"chin_4\":0,\"nose_1\":0,\"ears_2\":0,\"age_2\":0,\"chest_3\":0,\"jaw_2\":0,\"sun_1\":0,\"eyebrows_3\":29,\"beard_1\":10,\"helmet_2\":0,\"chin_2\":0,\"face_md_weight\":50,\"tshirt_2\":0,\"cheeks_2\":0,\"lipstick_4\":0,\"moles_2\":0,\"nose_2\":0,\"bodyb_1\":-1,\"bodyb_2\":0,\"chin_1\":0},\"grades\":[],\"grade\":true,\"name\":\"unefined\"}]', '{\"y\":-1618.1151123046876,\"x\":-619.4880981445313,\"z\":33.01055145263672}'),
(37, 'garage_lscustom', 'LsCustoms', '{\"items\":{\"water\":{\"label\":\"Eau\",\"count\":215,\"name\":\"water\"},\"bread\":{\"label\":\"Pain\",\"count\":205,\"name\":\"bread\"}},\"weapons_boss\":[],\"items_boss\":[],\"weapons\":[],\"accounts\":{\"cash\":0,\"society\":3191270.123635239,\"black_money\":0}}', '{\"recruit_player\":{\"mecano\":false,\"boss\":true,\"chefequipe\":[],\"copatron\":true},\"remove_weapon_chest_society\":{\"mecano\":false,\"boss\":true,\"chefequipe\":false,\"copatron\":[]},\"withdraw_black_money_coffre\":{\"mecano\":false,\"boss\":true,\"chefequipe\":false,\"copatron\":true},\"demote_player\":{\"mecano\":false,\"boss\":true,\"chefequipe\":false,\"copatron\":true},\"deposit_money_society\":{\"mecano\":false,\"boss\":true,\"chefequipe\":false,\"copatron\":[]},\"promote_player\":{\"mecano\":false,\"boss\":true,\"chefequipe\":true,\"copatron\":[]},\"deposit_weapon_chest_society\":{\"mecano\":false,\"boss\":true,\"chefequipe\":false,\"copatron\":false},\"unmote_player\":{\"mecano\":false,\"boss\":true,\"chefequipe\":true,\"copatron\":true},\"weapons_chest\":{\"mecano\":false,\"boss\":true,\"chefequipe\":false,\"copatron\":true},\"manage_employeds\":{\"mecano\":false,\"boss\":true,\"chefequipe\":false,\"copatron\":[]},\"open_boss\":{\"mecano\":false,\"boss\":true,\"chefequipe\":false,\"copatron\":true},\"open_coffre\":{\"mecano\":false,\"boss\":true,\"chefequipe\":false,\"copatron\":true},\"manage_grades\":{\"mecano\":false,\"boss\":true,\"chefequipe\":false,\"copatron\":[]},\"rename_label_grade\":{\"mecano\":false,\"boss\":true,\"chefequipe\":false,\"copatron\":[]},\"chest\":{\"mecano\":false,\"boss\":true,\"chefequipe\":false,\"copatron\":true},\"items_chest\":{\"mecano\":false,\"boss\":true,\"chefequipe\":false,\"copatron\":true},\"remove_item_chest_society\":{\"mecano\":false,\"boss\":true,\"chefequipe\":false,\"copatron\":[]},\"editClothes\":{\"mecano\":false,\"boss\":true,\"chefequipe\":false,\"copatron\":[]},\"deposit_cash_coffre\":{\"mecano\":false,\"boss\":true,\"chefequipe\":false,\"copatron\":false},\"remove_weapon_chest\":{\"mecano\":false,\"boss\":true,\"chefequipe\":false,\"copatron\":[]},\"change_number_grade\":{\"mecano\":false,\"boss\":true,\"chefequipe\":false,\"copatron\":false},\"rename_grade\":{\"mecano\":false,\"boss\":true,\"chefequipe\":false,\"copatron\":false},\"create_grade\":{\"mecano\":false,\"boss\":true,\"chefequipe\":false,\"copatron\":false},\"delete_grade\":{\"mecano\":false,\"boss\":true,\"chefequipe\":false,\"copatron\":false},\"withdraw_cash_coffre\":{\"mecano\":false,\"boss\":true,\"chefequipe\":false,\"copatron\":false},\"change_permissions_grade\":{\"mecano\":false,\"boss\":true,\"chefequipe\":false,\"copatron\":false},\"weapons_chest_society\":{\"mecano\":false,\"boss\":true,\"chefequipe\":false,\"copatron\":false},\"items_chest:society\":{\"mecano\":false,\"boss\":true,\"chefequipe\":false,\"copatron\":[]},\"withdraw_money_society\":{\"mecano\":false,\"boss\":true,\"chefequipe\":false,\"copatron\":false},\"deposit_weapon_chest\":{\"mecano\":false,\"boss\":true,\"chefequipe\":false,\"copatron\":false},\"deposit_item_chest\":{\"mecano\":false,\"boss\":true,\"chefequipe\":false,\"copatron\":[]},\"deposit_black_money_coffre\":{\"mecano\":false,\"boss\":true,\"chefequipe\":false,\"copatron\":false},\"remove_item_chest\":{\"mecano\":false,\"boss\":true,\"chefequipe\":false,\"copatron\":[]},\"change_salary_grade\":{\"mecano\":false,\"boss\":true,\"chefequipe\":false,\"copatron\":false},\"dposit_item_chest_society\":{\"mecano\":true,\"boss\":true,\"chefequipe\":false,\"copatron\":[]}}', '{\"z\":42.0371208190918,\"y\":-124.81334686279296,\"x\":-344.1487731933594}', '{\"z\":42.03677368164062,\"y\":-131.3484039306641,\"x\":-348.3934631347656}', '{\"position\":{\"z\":39.00970840454101,\"y\":-147.0532379150391,\"x\":-330.6905822753906},\"sprite\":446,\"active\":true,\"color\":47}', '3', 1, '[{\"grades\":[],\"data\":{\"hair_1\":175,\"moles_2\":10.0,\"glasses_2\":2,\"complexion_2\":0,\"eyebrows_5\":0,\"beard_2\":20,\"nose_3\":0,\"jaw_1\":-1,\"chin_1\":-1,\"moles_1\":-1,\"skin_md_weight\":0.0,\"ears_1\":-1,\"eye_color\":8,\"bodyb_3\":-1,\"cheeks_3\":0,\"cheeks_1\":0,\"chest_2\":0,\"torso_2\":11,\"eyebrows_6\":0,\"tshirt_2\":0,\"lipstick_4\":0,\"bodyb_4\":0,\"chain_1\":-1,\"arms_2\":0,\"ears_2\":-1,\"mom\":0,\"shoes_1\":25,\"decals_2\":0,\"torso_1\":505,\"jaw_2\":-1,\"age_1\":0,\"bags_1\":44,\"tshirt_1\":15,\"sun_1\":0,\"pants_2\":2,\"chest_1\":0,\"nose_2\":0,\"complexion_1\":0,\"lipstick_1\":-1,\"hair_2\":0,\"shoes_2\":0,\"dad\":14,\"bproof_2\":0,\"face_md_weight\":0.0,\"age_2\":10.0,\"bodyb_1\":-1,\"helmet_2\":0,\"eye_squint\":0,\"mask_1\":0,\"helmet_1\":8,\"neck_thickness\":-1,\"makeup_1\":-1,\"makeup_4\":3.0,\"eyebrows_2\":10,\"pants_1\":98,\"nose_1\":0,\"hair_color_2\":0,\"bracelets_1\":0,\"nose_4\":0,\"mask_2\":0,\"decals_1\":0,\"nose_5\":0,\"chain_2\":0,\"blemishes_2\":0,\"lipstick_3\":0,\"glasses_1\":0,\"watches_1\":-1,\"eyebrows_3\":0,\"blush_2\":10.0,\"cheeks_2\":0,\"bags_2\":0,\"blush_1\":-1,\"eyebrows_1\":33,\"blemishes_1\":0,\"bracelets_2\":0,\"beard_3\":61,\"sex\":0,\"chest_3\":0,\"lip_thickness\":0.0,\"bproof_1\":0,\"sun_2\":0,\"nose_6\":0,\"beard_1\":16,\"lipstick_2\":10.0,\"hair_color_1\":61,\"bodyb_2\":0,\"chin_2\":0,\"blush_3\":0,\"beard_4\":0,\"chin_3\":0,\"watches_2\":-1,\"eyebrows_4\":0,\"chin_4\":0,\"arms\":0,\"makeup_3\":0,\"makeup_2\":10.0},\"grade\":false,\"name\":\"tenue de service\"}]', '{\"z\":44.58747863769531,\"y\":-161.72747802734376,\"x\":-341.477294921875}');
INSERT INTO `society_data` (`id`, `name`, `label`, `coffre`, `permissions`, `posCoffre`, `posBoss`, `blips`, `tax`, `cloakroom`, `clothes`, `cloakpos`) VALUES
(40, 'percio', 'Bar Perico', '{\"items_boss\":[],\"weapons_boss\":[],\"accounts\":{\"society\":15000,\"black_money\":0,\"cash\":0},\"items\":[],\"weapons\":[]}', '{\"demote_player\":{\"boss\":true},\"manage_employeds\":{\"boss\":true},\"items_chest:society\":{\"boss\":true},\"deposit_item_chest\":{\"boss\":true},\"deposit_black_money_coffre\":{\"boss\":true},\"open_boss\":{\"boss\":true},\"chest\":{\"boss\":true},\"recruit_player\":{\"boss\":true},\"withdraw_money_society\":{\"boss\":true},\"remove_weapon_chest\":{\"boss\":true},\"items_chest\":{\"boss\":true},\"rename_grade\":{\"boss\":true},\"deposit_money_society\":{\"boss\":true},\"deposit_cash_coffre\":{\"boss\":true},\"weapons_chest\":{\"boss\":true},\"promote_player\":{\"boss\":true},\"remove_item_chest_society\":{\"boss\":true},\"change_number_grade\":{\"boss\":true},\"deposit_weapon_chest_society\":{\"boss\":true},\"delete_grade\":{\"boss\":true},\"editClothes\":{\"boss\":true},\"dposit_item_chest_society\":{\"boss\":true},\"create_grade\":{\"boss\":true},\"remove_weapon_chest_society\":{\"boss\":true},\"manage_grades\":{\"boss\":true},\"unmote_player\":{\"boss\":true},\"withdraw_black_money_coffre\":{\"boss\":true},\"rename_label_grade\":{\"boss\":true},\"deposit_weapon_chest\":{\"boss\":true},\"withdraw_cash_coffre\":{\"boss\":true},\"change_salary_grade\":{\"boss\":true},\"open_coffre\":{\"boss\":true},\"weapons_chest_society\":{\"boss\":true},\"change_permissions_grade\":{\"boss\":true},\"remove_item_chest\":{\"boss\":true}}', '{\"y\":-4942.396484375,\"z\":3.38087058067321,\"x\":4903.65283203125}', '{\"y\":-4955.5009765625,\"z\":4.93026733398437,\"x\":4892.0478515625}', '{\"position\":{\"y\":-4918.95361328125,\"z\":3.36774158477783,\"x\":4896.77685546875},\"active\":false}', '1', 0, '[]', '\"none\"'),
(41, 'taxi', 'Taxi', '{\"items_boss\":[],\"accounts\":{\"society\":49803.7188,\"cash\":0,\"black_money\":0},\"weapons\":[],\"items\":{\"water\":{\"count\":90,\"label\":\"Eau\",\"name\":\"water\"},\"bread\":{\"count\":90,\"label\":\"Pain\",\"name\":\"bread\"}},\"weapons_boss\":[]}', '{\"open_boss\":{\"label\":\"Ouvrir le menu boss\",\"boss\":true,\"chauffeur\":false,\"chauffeur v.i.p\":false,\"grades\":{\"boss\":true},\"expérimenté\":false,\"stagiare\":false,\"manager\":false},\"recruit_player\":{\"label\":\"Recruté un joueur\",\"boss\":true,\"chauffeur\":false,\"chauffeur v.i.p\":false,\"grades\":{\"boss\":true},\"expérimenté\":false,\"stagiare\":false,\"manager\":false},\"unmote_player\":{\"label\":\"Descendre un employé\",\"boss\":true,\"chauffeur\":false,\"chauffeur v.i.p\":false,\"grades\":{\"boss\":true},\"expérimenté\":false,\"stagiare\":false,\"manager\":false},\"demote_player\":{\"label\":\"Virer un employé\",\"boss\":true,\"chauffeur\":false,\"chauffeur v.i.p\":false,\"grades\":{\"boss\":true},\"expérimenté\":false,\"stagiare\":false,\"manager\":false},\"withdraw_cash_coffre\":{\"label\":\"Retirer de l\'argent dans le coffre\",\"boss\":true,\"chauffeur\":false,\"chauffeur v.i.p\":false,\"grades\":{\"boss\":true},\"expérimenté\":false,\"stagiare\":false,\"manager\":false},\"rename_grade\":{\"label\":\"Changer le nom d\'un grade\",\"boss\":true,\"chauffeur\":false,\"chauffeur v.i.p\":false,\"grades\":{\"boss\":true},\"expérimenté\":false,\"stagiare\":false,\"manager\":false},\"manage_employeds\":{\"label\":\"Gérer les employés de la société\",\"boss\":true,\"chauffeur\":false,\"chauffeur v.i.p\":false,\"grades\":{\"boss\":true},\"expérimenté\":false,\"stagiare\":false,\"manager\":false},\"withdraw_black_money_coffre\":{\"label\":\"Retirer de l\'argent sale dans le coffre\",\"boss\":true,\"chauffeur\":false,\"chauffeur v.i.p\":false,\"grades\":{\"boss\":true},\"expérimenté\":false,\"stagiare\":false,\"manager\":false},\"change_permissions_grade\":{\"label\":\"Changer les permissions d\'un grade\",\"boss\":true,\"chauffeur\":false,\"chauffeur v.i.p\":false,\"grades\":{\"boss\":true},\"expérimenté\":false,\"stagiare\":false,\"manager\":false},\"dposit_item_chest_society\":{\"label\":\"Déposer un item dans le coffre de la société\",\"boss\":true,\"chauffeur\":false,\"chauffeur v.i.p\":false,\"grades\":{\"boss\":true},\"expérimenté\":false,\"stagiare\":false,\"manager\":false},\"promote_player\":{\"label\":\"Augmenter un employé\",\"boss\":true,\"chauffeur\":false,\"chauffeur v.i.p\":false,\"grades\":{\"boss\":true},\"expérimenté\":false,\"stagiare\":false,\"manager\":false},\"items_chest:society\":{\"label\":\"Item(s) du coffre de la société\",\"boss\":true,\"chauffeur\":false,\"chauffeur v.i.p\":false,\"grades\":{\"boss\":true},\"expérimenté\":false,\"stagiare\":false,\"manager\":false},\"withdraw_money_society\":{\"label\":\"Retirer de l\'argent dans le coffre de la société\",\"boss\":true,\"chauffeur\":false,\"chauffeur v.i.p\":false,\"grades\":{\"boss\":true},\"expérimenté\":false,\"stagiare\":false,\"manager\":false},\"open_coffre\":{\"label\":\"Ouvrir le coffre\",\"boss\":true,\"chauffeur\":false,\"chauffeur v.i.p\":false,\"grades\":{\"boss\":true},\"expérimenté\":false,\"stagiare\":false,\"manager\":false},\"weapons_chest\":{\"label\":\"Armes du coffre\",\"boss\":true,\"chauffeur\":false,\"chauffeur v.i.p\":false,\"grades\":{\"boss\":true},\"expérimenté\":false,\"stagiare\":false,\"manager\":false},\"deposit_money_society\":{\"label\":\"Déposer de l\'argent dans le coffre de la société\",\"boss\":true,\"chauffeur\":false,\"chauffeur v.i.p\":false,\"grades\":{\"boss\":true},\"expérimenté\":false,\"stagiare\":false,\"manager\":false},\"editClothes\":{\"label\":\"Gérer les tenues dans le vestiaire\",\"boss\":true,\"chauffeur\":false,\"chauffeur v.i.p\":false,\"grades\":{\"boss\":true},\"expérimenté\":false,\"stagiare\":false,\"manager\":false},\"remove_item_chest\":{\"label\":\"Retirer un item dans le coffre\",\"boss\":true,\"chauffeur\":false,\"chauffeur v.i.p\":false,\"grades\":{\"boss\":true},\"expérimenté\":false,\"stagiare\":false,\"manager\":false},\"deposit_weapon_chest\":{\"label\":\"Déposer une arme dans le coffre\",\"boss\":true,\"chauffeur\":false,\"chauffeur v.i.p\":false,\"grades\":{\"boss\":true},\"expérimenté\":false,\"stagiare\":false,\"manager\":false},\"change_salary_grade\":{\"label\":\"Changer le salaire d\'un grade\",\"boss\":true,\"chauffeur\":false,\"chauffeur v.i.p\":false,\"grades\":{\"boss\":true},\"expérimenté\":false,\"stagiare\":false,\"manager\":false},\"chest\":{\"label\":\"Accéder au coffre de la société\",\"boss\":true,\"chauffeur\":false,\"chauffeur v.i.p\":false,\"grades\":{\"boss\":true},\"expérimenté\":false,\"stagiare\":false,\"manager\":false},\"deposit_item_chest\":{\"label\":\"Déposer un item dans le coffre\",\"boss\":true,\"chauffeur\":false,\"chauffeur v.i.p\":false,\"grades\":{\"boss\":true},\"expérimenté\":false,\"stagiare\":false,\"manager\":false},\"delete_grade\":{\"label\":\"Supprimer un grade\",\"boss\":true,\"chauffeur\":false,\"chauffeur v.i.p\":false,\"grades\":{\"boss\":true},\"expérimenté\":false,\"stagiare\":false,\"manager\":false},\"change_number_grade\":{\"label\":\"Changer le numéro d\'un grade\",\"boss\":true,\"chauffeur\":false,\"chauffeur v.i.p\":false,\"grades\":{\"boss\":true},\"expérimenté\":false,\"stagiare\":false,\"manager\":false},\"rename_label_grade\":{\"label\":\"Changer le label d\'un grade\",\"boss\":true,\"chauffeur\":false,\"chauffeur v.i.p\":false,\"grades\":{\"boss\":true},\"expérimenté\":false,\"stagiare\":false,\"manager\":false},\"remove_item_chest_society\":{\"label\":\"Retirer un item dans le coffre de la société\",\"boss\":true,\"chauffeur\":false,\"chauffeur v.i.p\":false,\"grades\":{\"boss\":true},\"expérimenté\":false,\"stagiare\":false,\"manager\":false},\"manage_grades\":{\"label\":\"Gérer les grades de la société\",\"boss\":true,\"chauffeur\":false,\"chauffeur v.i.p\":false,\"grades\":{\"boss\":true},\"expérimenté\":false,\"stagiare\":false,\"manager\":false},\"deposit_black_money_coffre\":{\"label\":\"Déposer de l\'argent sale dans le coffre\",\"boss\":true,\"chauffeur\":false,\"chauffeur v.i.p\":false,\"grades\":{\"boss\":true},\"expérimenté\":false,\"stagiare\":false,\"manager\":false},\"create_grade\":{\"label\":\"Créer un grade\",\"boss\":true,\"chauffeur\":false,\"chauffeur v.i.p\":false,\"grades\":{\"boss\":true},\"expérimenté\":false,\"stagiare\":false,\"manager\":false},\"items_chest\":{\"label\":\"Items du coffre\",\"boss\":true,\"chauffeur\":false,\"chauffeur v.i.p\":false,\"grades\":{\"boss\":true},\"expérimenté\":false,\"stagiare\":false,\"manager\":false},\"deposit_weapon_chest_society\":{\"label\":\"Déposer une arme dans le coffre de la société\",\"boss\":true,\"chauffeur\":false,\"chauffeur v.i.p\":false,\"grades\":{\"boss\":true},\"expérimenté\":false,\"stagiare\":false,\"manager\":false},\"weapons_chest_society\":{\"label\":\"Arme(s) du coffre de la société\",\"boss\":true,\"chauffeur\":false,\"chauffeur v.i.p\":false,\"grades\":{\"boss\":true},\"expérimenté\":false,\"stagiare\":false,\"manager\":false},\"deposit_cash_coffre\":{\"label\":\"Déposer de l\'argent dans le coffre\",\"boss\":true,\"chauffeur\":false,\"chauffeur v.i.p\":false,\"grades\":{\"boss\":true},\"expérimenté\":false,\"stagiare\":false,\"manager\":false},\"remove_weapon_chest\":{\"label\":\"Retirer une arme dans le coffre\",\"boss\":true,\"chauffeur\":false,\"chauffeur v.i.p\":false,\"grades\":{\"boss\":true},\"expérimenté\":false,\"stagiare\":false,\"manager\":false},\"remove_weapon_chest_society\":{\"label\":\"Retirer une arme dans la coffre de la société\",\"boss\":true,\"chauffeur\":false,\"chauffeur v.i.p\":false,\"grades\":{\"boss\":true},\"expérimenté\":false,\"stagiare\":false,\"manager\":false}}', '{\"z\":74.2222671508789,\"y\":-166.5725860595703,\"x\":900.9324340820313}', '{\"z\":74.22233581542969,\"y\":-165.82579040527345,\"x\":898.317626953125}', '{\"color\":5,\"active\":true,\"position\":{\"z\":78.16291809082031,\"y\":-162.7771148681641,\"x\":904.8250122070313},\"sprite\":56}', '3', 1, '[{\"grades\":{\"apprenti\":\"apprenti\",\"manager\":\"manager\",\"stagiare\":\"stagiare\",\"debutant\":\"debutant\",\"pratiquant\":\"pratiquant\",\"chauffeur\":\"chauffeur\",\"co-boss\":\"co-boss\",\"boss\":\"boss\"},\"name\":\"tenu taxi\",\"data\":{\"bproof_2\":0,\"bags_1\":0,\"skin_md_weight\":0.0,\"jaw_1\":0,\"lipstick_1\":-1,\"blush_3\":0,\"decals_2\":6,\"torso_2\":7,\"blemishes_1\":0,\"helmet_2\":0,\"decals_1\":0,\"chest_1\":0,\"pants_1\":37,\"arms_2\":0,\"shoes_2\":1,\"lipstick_2\":10.0,\"face_md_weight\":0.0,\"pants_2\":2,\"beard_1\":3,\"eyebrows_2\":10,\"dad\":29,\"ears_1\":-1,\"blush_1\":-1,\"moles_1\":-1,\"chin_1\":-1,\"sex\":0,\"hair_2\":0,\"beard_4\":0,\"eye_squint\":0,\"bproof_1\":95,\"sun_2\":0,\"eyebrows_3\":41,\"chain_2\":0,\"torso_1\":505,\"moles_2\":10.0,\"blush_2\":10.0,\"chin_4\":0,\"chain_1\":0,\"nose_6\":0,\"eye_color\":12,\"age_1\":0,\"bodyb_4\":0,\"neck_thickness\":-1,\"bodyb_1\":-1,\"age_2\":10.0,\"watches_1\":-1,\"beard_2\":20,\"helmet_1\":8,\"watches_2\":-1,\"glasses_2\":0,\"bracelets_1\":-1,\"mom\":0,\"eyebrows_1\":30,\"chest_3\":0,\"arms\":0,\"eyebrows_4\":0,\"nose_5\":0,\"sun_1\":0,\"jaw_2\":0,\"makeup_4\":3.0,\"makeup_1\":-1,\"cheeks_1\":1,\"blemishes_2\":0,\"cheeks_3\":0,\"mask_1\":0,\"tshirt_2\":0,\"nose_1\":0,\"hair_color_1\":0,\"makeup_2\":10.0,\"complexion_1\":0,\"eyebrows_6\":0,\"tshirt_1\":15,\"cheeks_2\":0,\"lipstick_4\":0,\"ears_2\":-1,\"bodyb_3\":-1,\"nose_2\":0,\"bodyb_2\":0,\"nose_3\":0,\"complexion_2\":0,\"lipstick_3\":0,\"shoes_1\":31,\"chin_3\":0,\"glasses_1\":0,\"hair_1\":221,\"chest_2\":0,\"makeup_3\":0,\"hair_color_2\":61,\"bags_2\":0,\"beard_3\":0,\"bracelets_2\":0,\"mask_2\":0,\"eyebrows_5\":0,\"chin_2\":0,\"nose_4\":2,\"lip_thickness\":0.0},\"grade\":true},{\"grades\":{\"boss\":\"boss\",\"co-boss\":\"co-boss\"},\"name\":\"tenu patron \",\"data\":{\"bproof_2\":0,\"bags_1\":0,\"skin_md_weight\":50,\"jaw_1\":3,\"lipstick_1\":0,\"blush_3\":0,\"decals_2\":0,\"torso_2\":0,\"lip_thickness\":0,\"helmet_2\":0,\"decals_1\":0,\"chest_1\":0,\"pants_1\":24,\"arms_2\":0,\"shoes_2\":0,\"lipstick_2\":0,\"hair_color_1\":0,\"pants_2\":5,\"beard_1\":19,\"eyebrows_2\":0,\"dad\":9,\"ears_1\":-1,\"blush_1\":0,\"helmet_1\":7,\"chin_1\":3,\"sex\":0,\"hair_2\":0,\"beard_4\":0,\"eye_squint\":0,\"bproof_1\":0,\"sun_2\":0,\"eyebrows_3\":0,\"chain_2\":0,\"torso_1\":321,\"mom\":4,\"blush_2\":0,\"chin_4\":6,\"chain_1\":362,\"nose_6\":0,\"eye_color\":0,\"age_1\":0,\"bodyb_4\":0,\"neck_thickness\":0,\"bodyb_1\":-1,\"age_2\":0,\"watches_1\":-1,\"beard_2\":10,\"ears_2\":0,\"eyebrows_1\":0,\"watches_2\":0,\"glasses_2\":0,\"bracelets_1\":-1,\"arms\":22,\"lipstick_4\":0,\"chest_3\":0,\"nose_5\":1,\"blemishes_1\":0,\"face_color\":2,\"makeup_1\":0,\"jaw_2\":3,\"makeup_4\":0,\"blemishes_2\":0,\"cheeks_1\":4,\"mask_1\":0,\"shoes_1\":10,\"cheeks_3\":4,\"tshirt_2\":0,\"nose_1\":2,\"lipstick_3\":0,\"makeup_2\":0,\"complexion_1\":0,\"eyebrows_6\":0,\"tshirt_1\":15,\"cheeks_2\":0,\"eyebrows_4\":0,\"bodyb_3\":-1,\"moles_1\":0,\"nose_2\":2,\"bodyb_2\":0,\"nose_3\":5,\"complexion_2\":0,\"sun_1\":1,\"eyebrows_5\":0,\"hair_1\":8,\"glasses_1\":5,\"hair_color_2\":0,\"chest_2\":0,\"makeup_3\":0,\"bags_2\":0,\"moles_2\":0,\"beard_3\":0,\"bracelets_2\":0,\"mask_2\":0,\"chin_3\":3,\"chin_2\":3,\"nose_4\":5,\"face_md_weight\":100},\"grade\":true}]', '{\"z\":75.31824493408203,\"y\":-149.68199157714845,\"x\":900.0584716796875}'),
(46, 'weazelnews', 'Weazle News', '{\"items_boss\":[],\"accounts\":{\"society\":15000,\"black_money\":0,\"cash\":0},\"items\":[],\"weapons_boss\":[],\"weapons\":[]}', '{\"unmote_player\":{\"boss\":true},\"editClothes\":{\"boss\":true},\"remove_weapon_chest\":{\"boss\":true},\"rename_label_grade\":{\"boss\":true},\"create_grade\":{\"boss\":true},\"weapons_chest_society\":{\"boss\":true},\"withdraw_money_society\":{\"boss\":true},\"demote_player\":{\"boss\":true},\"open_coffre\":{\"boss\":true},\"dposit_item_chest_society\":{\"boss\":true},\"deposit_weapon_chest_society\":{\"boss\":true},\"change_number_grade\":{\"boss\":true},\"recruit_player\":{\"boss\":true},\"manage_employeds\":{\"boss\":true},\"deposit_black_money_coffre\":{\"boss\":true},\"items_chest:society\":{\"boss\":true},\"remove_item_chest\":{\"boss\":true},\"deposit_money_society\":{\"boss\":true},\"deposit_weapon_chest\":{\"boss\":true},\"promote_player\":{\"boss\":true},\"remove_item_chest_society\":{\"boss\":true},\"withdraw_black_money_coffre\":{\"boss\":true},\"remove_weapon_chest_society\":{\"boss\":true},\"change_salary_grade\":{\"boss\":true},\"deposit_cash_coffre\":{\"boss\":true},\"manage_grades\":{\"boss\":true},\"items_chest\":{\"boss\":true},\"withdraw_cash_coffre\":{\"boss\":true},\"weapons_chest\":{\"boss\":true},\"delete_grade\":{\"boss\":true},\"change_permissions_grade\":{\"boss\":true},\"deposit_item_chest\":{\"boss\":true},\"rename_grade\":{\"boss\":true},\"chest\":{\"boss\":true},\"open_boss\":{\"boss\":true}}', '{\"x\":-574.282227,\"z\":23.86964,\"y\":-923.107971}', '{\"x\":-583.081238,\"z\":28.157051,\"y\":-928.580811}', '{\"sprite\":184,\"active\":true,\"position\":{\"x\":-583.081238,\"z\":28.157051,\"y\":-928.580811},\"color\":9}', '1', 1, '[]', '{\"x\":-588.1155395507813,\"z\":23.86913871765136,\"y\":-927.4957885742188}'),
(47, 'petitpecheur', 'Petit Pêcheur', '{\"items_boss\":[],\"weapons_boss\":[],\"accounts\":{\"society\":15000,\"black_money\":0,\"cash\":0},\"items\":[],\"weapons\":[]}', '{\"change_number_grade\":{\"boss\":true},\"manage_grades\":{\"boss\":true},\"remove_item_chest\":{\"boss\":true},\"items_chest:society\":{\"boss\":true},\"open_boss\":{\"boss\":true},\"deposit_money_society\":{\"boss\":true},\"deposit_weapon_chest\":{\"boss\":true},\"rename_grade\":{\"boss\":true},\"withdraw_cash_coffre\":{\"boss\":true},\"unmote_player\":{\"boss\":true},\"items_chest\":{\"boss\":true},\"create_grade\":{\"boss\":true},\"withdraw_money_society\":{\"boss\":true},\"chest\":{\"boss\":true},\"delete_grade\":{\"boss\":true},\"remove_weapon_chest\":{\"boss\":true},\"withdraw_black_money_coffre\":{\"boss\":true},\"deposit_item_chest\":{\"boss\":true},\"weapons_chest_society\":{\"boss\":true},\"deposit_cash_coffre\":{\"boss\":true},\"change_permissions_grade\":{\"boss\":true},\"manage_employeds\":{\"boss\":true},\"deposit_weapon_chest_society\":{\"boss\":true},\"dposit_item_chest_society\":{\"boss\":true},\"remove_item_chest_society\":{\"boss\":true},\"recruit_player\":{\"boss\":true},\"open_coffre\":{\"boss\":true},\"change_salary_grade\":{\"boss\":true},\"demote_player\":{\"boss\":true},\"editClothes\":{\"boss\":true},\"deposit_black_money_coffre\":{\"boss\":true},\"remove_weapon_chest_society\":{\"boss\":true},\"rename_label_grade\":{\"boss\":true},\"promote_player\":{\"boss\":true},\"weapons_chest\":{\"boss\":true}}', '{\"z\":5.00024080276489,\"y\":-2778.757568359375,\"x\":-316.8606872558594}', '{\"z\":5.00024032592773,\"y\":-2783.19775390625,\"x\":-315.61761474609377}', '{\"sprite\":455,\"active\":true,\"position\":{\"z\":5.00023221969604,\"y\":-2778.19970703125,\"x\":-313.3329162597656},\"color\":3}', '1', 1, '[]', '{\"z\":5.00023794174194,\"y\":-2784.130126953125,\"x\":-312.71258544921877}'),
(49, 'vigne', 'Vigneron', '{\"items_boss\":{},\"items\":{\"crochetage_kit\":{\"name\":\"crochetage_kit\",\"count\":2,\"label\":\"Kit de Crochetage\"},\"hack_phone\":{\"name\":\"hack_phone\",\"count\":1,\"label\":\"Téléphone Jailbreak\"}},\"accounts\":{\"cash\":0,\"society\":156900.0,\"black_money\":0},\"weapons\":[],\"weapons_boss\":[]}', '{\"remove_weapon_chest_society\":{\"Employer\":false,\"boss\":true,\"label\":\"Retirer une arme dans la coffre de la société\",\"grades\":{\"boss\":true},\"employed\":false},\"remove_item_chest_society\":{\"Employer\":false,\"boss\":true,\"label\":\"Retirer un item dans le coffre de la société\",\"grades\":{\"boss\":true},\"employed\":false},\"unmote_player\":{\"Employer\":false,\"boss\":true,\"label\":\"Descendre un employé\",\"grades\":{\"boss\":true},\"employed\":false},\"delete_grade\":{\"Employer\":false,\"boss\":true,\"label\":\"Supprimer un grade\",\"grades\":{\"boss\":true},\"employed\":false},\"withdraw_black_money_coffre\":{\"Employer\":false,\"boss\":true,\"label\":\"Retirer de l\'argent sale dans le coffre\",\"grades\":{\"boss\":true},\"employed\":false},\"chest\":{\"Employer\":false,\"boss\":true,\"label\":\"Accéder au coffre de la société\",\"grades\":{\"boss\":true},\"employed\":false},\"weapons_chest\":{\"Employer\":true,\"boss\":true,\"label\":\"Armes du coffre\",\"grades\":{\"boss\":true},\"employed\":false},\"rename_label_grade\":{\"Employer\":false,\"boss\":true,\"label\":\"Changer le label d\'un grade\",\"grades\":{\"boss\":true},\"employed\":false},\"change_number_grade\":{\"Employer\":false,\"boss\":true,\"label\":\"Changer le numéro d\'un grade\",\"grades\":{\"boss\":true},\"employed\":false},\"deposit_weapon_chest_society\":{\"Employer\":false,\"boss\":true,\"label\":\"Déposer une arme dans le coffre de la société\",\"grades\":{\"boss\":true},\"employed\":false},\"dposit_item_chest_society\":{\"Employer\":false,\"boss\":true,\"label\":\"Déposer un item dans le coffre de la société\",\"grades\":{\"boss\":true},\"employed\":false},\"withdraw_cash_coffre\":{\"Employer\":false,\"boss\":true,\"label\":\"Retirer de l\'argent dans le coffre\",\"grades\":{\"boss\":true},\"employed\":false},\"deposit_money_society\":{\"Employer\":false,\"boss\":true,\"label\":\"Déposer de l\'argent dans le coffre de la société\",\"grades\":{\"boss\":true},\"employed\":[]},\"create_grade\":{\"Employer\":false,\"boss\":true,\"label\":\"Créer un grade\",\"grades\":{\"boss\":true},\"employed\":false},\"items_chest:society\":{\"Employer\":false,\"boss\":true,\"label\":\"Item(s) du coffre de la société\",\"grades\":{\"boss\":true},\"employed\":false},\"promote_player\":{\"Employer\":false,\"boss\":true,\"label\":\"Augmenter un employé\",\"grades\":{\"boss\":true},\"employed\":false},\"deposit_cash_coffre\":{\"Employer\":true,\"boss\":true,\"label\":\"Déposer de l\'argent dans le coffre\",\"grades\":{\"boss\":true},\"employed\":false},\"change_permissions_grade\":{\"Employer\":false,\"boss\":true,\"label\":\"Changer les permissions d\'un grade\",\"grades\":{\"boss\":true},\"employed\":false},\"open_boss\":{\"Employer\":false,\"boss\":true,\"label\":\"Ouvrir le menu boss\",\"grades\":{\"boss\":true},\"employed\":false},\"deposit_item_chest\":{\"Employer\":true,\"boss\":true,\"label\":\"Déposer un item dans le coffre\",\"grades\":{\"boss\":true},\"employed\":[]},\"weapons_chest_society\":{\"Employer\":false,\"boss\":true,\"label\":\"Arme(s) du coffre de la société\",\"grades\":{\"boss\":true},\"employed\":false},\"open_coffre\":{\"Employer\":true,\"boss\":true,\"label\":\"Ouvrir le coffre\",\"grades\":{\"boss\":true},\"employed\":true},\"remove_item_chest\":{\"Employer\":true,\"boss\":true,\"label\":\"Retirer un item dans le coffre\",\"grades\":{\"boss\":true},\"employed\":false},\"deposit_weapon_chest\":{\"Employer\":true,\"boss\":true,\"label\":\"Déposer une arme dans le coffre\",\"grades\":{\"boss\":true},\"employed\":[]},\"manage_employeds\":{\"Employer\":false,\"boss\":true,\"label\":\"Gérer les employés de la société\",\"grades\":{\"boss\":true},\"employed\":false},\"recruit_player\":{\"Employer\":false,\"boss\":true,\"label\":\"Recruté un joueur\",\"grades\":{\"boss\":true},\"employed\":false},\"editClothes\":{\"Employer\":false,\"boss\":true,\"label\":\"Gérer les tenues dans le vestiaire\",\"grades\":{\"boss\":true},\"employed\":false},\"deposit_black_money_coffre\":{\"Employer\":true,\"boss\":true,\"label\":\"Déposer de l\'argent sale dans le coffre\",\"grades\":{\"boss\":true},\"employed\":false},\"rename_grade\":{\"Employer\":false,\"boss\":true,\"label\":\"Changer le nom d\'un grade\",\"grades\":{\"boss\":true},\"employed\":false},\"manage_grades\":{\"Employer\":false,\"boss\":true,\"label\":\"Gérer les grades de la société\",\"grades\":{\"boss\":true},\"employed\":false},\"withdraw_money_society\":{\"Employer\":false,\"boss\":true,\"label\":\"Retirer de l\'argent dans le coffre de la société\",\"grades\":{\"boss\":true},\"employed\":false},\"items_chest\":{\"Employer\":true,\"boss\":true,\"label\":\"Items du coffre\",\"grades\":{\"boss\":true},\"employed\":false},\"remove_weapon_chest\":{\"Employer\":false,\"boss\":true,\"label\":\"Retirer une arme dans le coffre\",\"grades\":{\"boss\":true},\"employed\":false},\"change_salary_grade\":{\"Employer\":false,\"boss\":true,\"label\":\"Changer le salaire d\'un grade\",\"grades\":{\"boss\":true},\"employed\":false},\"demote_player\":{\"Employer\":false,\"boss\":true,\"label\":\"Virer un employé\",\"grades\":{\"boss\":true},\"employed\":false}}', '{\"z\":140.9839324951172,\"y\":2061.106201171875,\"x\":-1881.4403076171876}', '{\"z\":145.5737457275391,\"y\":2060.869873046875,\"x\":-1876.074951171875}', '{\"sprite\":85,\"position\":{\"z\":141.46322631835938,\"y\":2058.33056640625,\"x\":-1884.1417236328128},\"color\":8,\"active\":true}', '0', 1, '[{\"name\":\"co patron\",\"grade\":true,\"grades\":{\"sous-boss\":\"sous-boss\",\"boss\":\"boss\"},\"data\":{\"complexion_2\":0,\"nose_3\":0,\"chin_4\":0,\"pants_2\":0,\"cheeks_1\":0,\"decals_2\":0,\"face_md_weight\":50,\"watches_1\":2,\"nose_5\":0,\"skin_md_weight\":50,\"eyebrows_5\":0,\"torso_2\":0,\"chest_3\":0,\"tshirt_2\":0,\"glasses_1\":56,\"makeup_4\":0,\"eyebrows_3\":0,\"chin_2\":0,\"sun_1\":0,\"pants_1\":23,\"helmet_2\":0,\"nose_4\":2,\"hair_1\":124,\"chain_2\":0,\"bproof_1\":0,\"ears_1\":3,\"chest_2\":0,\"age_2\":0,\"lipstick_2\":0,\"watches_2\":0,\"chin_3\":0,\"bags_2\":0,\"blemishes_1\":0,\"hair_color_1\":0,\"glasses_2\":0,\"blush_1\":0,\"beard_2\":10,\"bodyb_4\":0,\"age_1\":0,\"moles_2\":0,\"chin_1\":0,\"bodyb_3\":-1,\"decals_1\":0,\"eye_squint\":0,\"chain_1\":0,\"jaw_1\":0,\"helmet_1\":190,\"bproof_2\":0,\"cheeks_2\":0,\"lipstick_3\":0,\"chest_1\":0,\"moles_1\":0,\"neck_thickness\":0,\"sun_2\":0,\"blush_3\":0,\"eyebrows_6\":0,\"tshirt_1\":130,\"shoes_1\":137,\"makeup_2\":0,\"arms_2\":0,\"blush_2\":0,\"eye_color\":0,\"beard_1\":3,\"bodyb_1\":-1,\"complexion_1\":0,\"lip_thickness\":0,\"blemishes_2\":0,\"mask_2\":26,\"makeup_3\":0,\"cheeks_3\":0,\"nose_1\":0,\"hair_2\":0,\"arms\":178,\"nose_2\":0,\"bodyb_2\":0,\"eyebrows_2\":10,\"hair_color_2\":1,\"mom\":25,\"nose_6\":0,\"shoes_2\":0,\"lipstick_4\":0,\"eyebrows_1\":33,\"dad\":24,\"torso_1\":349,\"beard_3\":0,\"lipstick_1\":0,\"bracelets_2\":0,\"beard_4\":0,\"bags_1\":0,\"sex\":0,\"bracelets_1\":-1,\"mask_1\":111,\"makeup_1\":0,\"eyebrows_4\":0,\"ears_2\":0,\"jaw_2\":0}},{\"name\":\"patron\",\"grade\":true,\"grades\":{\"boss\":\"boss\"},\"data\":{\"complexion_2\":0,\"dad\":23,\"chin_4\":0,\"pants_2\":0,\"cheeks_1\":0,\"decals_2\":0,\"face_md_weight\":50,\"watches_1\":0,\"nose_5\":0,\"skin_md_weight\":50,\"eyebrows_5\":0,\"torso_2\":0,\"chest_3\":0,\"tshirt_2\":0,\"glasses_1\":51,\"makeup_4\":0,\"eyebrows_3\":0,\"chin_2\":0,\"sun_1\":0,\"pants_1\":10,\"helmet_2\":0,\"nose_4\":0,\"hair_1\":93,\"chain_2\":0,\"bproof_1\":0,\"ears_1\":-1,\"chest_2\":0,\"age_2\":0,\"lipstick_2\":0,\"watches_2\":0,\"chin_3\":0,\"bags_2\":0,\"arms_2\":0,\"hair_color_1\":0,\"glasses_2\":0,\"blush_1\":0,\"beard_2\":10,\"bodyb_4\":0,\"age_1\":0,\"moles_2\":0,\"chin_1\":0,\"eye_squint\":0,\"decals_1\":0,\"blemishes_2\":0,\"nose_3\":0,\"jaw_1\":0,\"helmet_1\":190,\"bproof_2\":0,\"cheeks_2\":0,\"lipstick_3\":0,\"chest_1\":0,\"moles_1\":0,\"sun_2\":0,\"blush_3\":0,\"eyebrows_4\":0,\"neck_thickness\":0,\"tshirt_1\":4,\"shoes_1\":10,\"makeup_2\":0,\"sex\":0,\"blush_2\":0,\"beard_1\":3,\"bodyb_1\":-1,\"blemishes_1\":0,\"complexion_1\":0,\"lip_thickness\":0,\"bodyb_3\":-1,\"mask_2\":0,\"mask_1\":0,\"cheeks_3\":0,\"nose_1\":0,\"hair_2\":0,\"eyebrows_6\":0,\"nose_2\":0,\"bodyb_2\":0,\"eye_color\":0,\"eyebrows_2\":10,\"mom\":0,\"nose_6\":0,\"shoes_2\":0,\"hair_color_2\":0,\"eyebrows_1\":30,\"lipstick_4\":0,\"torso_1\":142,\"beard_3\":0,\"lipstick_1\":0,\"bracelets_2\":0,\"makeup_3\":0,\"bags_1\":131,\"beard_4\":0,\"bracelets_1\":-1,\"chain_1\":20,\"makeup_1\":0,\"arms\":0,\"ears_2\":0,\"jaw_2\":0}},{\"name\":\"Emploie\",\"grade\":true,\"grades\":{\"Employer\":\"Employer\"},\"data\":{\"complexion_2\":0,\"dad\":23,\"chin_4\":0,\"pants_2\":1,\"cheeks_1\":0,\"decals_2\":0,\"face_md_weight\":50,\"watches_1\":15,\"nose_5\":0,\"skin_md_weight\":50,\"eyebrows_5\":0,\"torso_2\":0,\"chest_3\":0,\"tshirt_2\":0,\"glasses_1\":6,\"makeup_4\":0,\"eyebrows_3\":0,\"chin_2\":0,\"sun_1\":0,\"pants_1\":129,\"helmet_2\":2,\"nose_4\":0,\"hair_1\":93,\"chain_2\":0,\"bproof_1\":0,\"ears_1\":-1,\"chest_2\":0,\"age_2\":0,\"lipstick_2\":0,\"watches_2\":0,\"chin_3\":0,\"bags_2\":0,\"arms_2\":0,\"hair_color_1\":0,\"glasses_2\":0,\"blush_1\":0,\"beard_2\":10,\"bodyb_4\":0,\"age_1\":0,\"moles_2\":0,\"chin_1\":0,\"eyebrows_2\":10,\"decals_1\":0,\"blemishes_2\":0,\"chain_1\":151,\"jaw_1\":0,\"helmet_1\":13,\"bproof_2\":0,\"cheeks_2\":0,\"lipstick_3\":0,\"chest_1\":0,\"moles_1\":0,\"sun_2\":0,\"blush_3\":0,\"arms\":11,\"eyebrows_4\":0,\"tshirt_1\":15,\"shoes_1\":12,\"makeup_2\":0,\"blush_2\":0,\"beard_1\":3,\"eye_squint\":0,\"bodyb_1\":-1,\"blemishes_1\":0,\"complexion_1\":0,\"lip_thickness\":0,\"neck_thickness\":0,\"mask_2\":0,\"bodyb_3\":-1,\"mask_1\":0,\"nose_1\":0,\"hair_2\":0,\"cheeks_3\":0,\"nose_2\":0,\"bodyb_2\":0,\"nose_3\":0,\"eye_color\":0,\"mom\":0,\"nose_6\":0,\"shoes_2\":6,\"hair_color_2\":0,\"eyebrows_1\":30,\"lipstick_4\":0,\"torso_1\":42,\"beard_3\":0,\"lipstick_1\":0,\"bracelets_2\":0,\"makeup_3\":0,\"bags_1\":9,\"beard_4\":0,\"bracelets_1\":-1,\"sex\":0,\"makeup_1\":0,\"eyebrows_6\":0,\"ears_2\":0,\"jaw_2\":0}},{\"name\":\"Vigneron\",\"data\":{\"complexion_2\":0,\"nose_3\":0,\"blush_3\":0,\"lipstick_4\":0,\"cheeks_1\":0,\"decals_2\":0,\"face_md_weight\":50,\"watches_1\":-1,\"nose_5\":0,\"hair_color_2\":0,\"eyebrows_5\":0,\"torso_2\":3,\"chest_3\":0,\"tshirt_2\":0,\"glasses_1\":5,\"makeup_4\":0,\"eyebrows_3\":0,\"chin_2\":0,\"sun_1\":0,\"pants_1\":47,\"eye_color\":0,\"nose_4\":0,\"hair_1\":12,\"chain_2\":0,\"bproof_1\":0,\"ears_1\":-1,\"chest_2\":0,\"age_2\":0,\"sun_2\":0,\"lipstick_1\":0,\"chin_3\":0,\"bags_2\":0,\"arms_2\":0,\"hair_color_1\":3,\"glasses_2\":1,\"blush_1\":0,\"beard_2\":10,\"bodyb_4\":0,\"eye_squint\":0,\"moles_2\":0,\"makeup_3\":0,\"eyebrows_2\":0,\"decals_1\":0,\"sex\":0,\"chin_4\":0,\"jaw_1\":0,\"helmet_1\":-1,\"cheeks_3\":0,\"cheeks_2\":0,\"lipstick_3\":0,\"chest_1\":0,\"moles_1\":0,\"blemishes_1\":0,\"chin_1\":0,\"watches_2\":0,\"lipstick_2\":0,\"tshirt_1\":15,\"shoes_1\":71,\"makeup_2\":0,\"bproof_2\":0,\"chain_1\":-1,\"mask_1\":0,\"age_1\":0,\"dad\":7,\"eyebrows_6\":0,\"blush_2\":0,\"bodyb_1\":-1,\"mask_2\":0,\"skin_md_weight\":50,\"neck_thickness\":0,\"nose_1\":0,\"hair_2\":0,\"lip_thickness\":0,\"nose_2\":0,\"bodyb_2\":0,\"beard_4\":0,\"bodyb_3\":-1,\"mom\":0,\"nose_6\":0,\"shoes_2\":3,\"beard_1\":10,\"eyebrows_1\":0,\"helmet_2\":0,\"torso_1\":241,\"beard_3\":0,\"blemishes_2\":0,\"bracelets_2\":0,\"complexion_1\":0,\"bags_1\":-1,\"eyebrows_4\":0,\"bracelets_1\":-1,\"pants_2\":0,\"makeup_1\":0,\"arms\":2,\"ears_2\":0,\"jaw_2\":0},\"grades\":[],\"grade\":false}]', '{\"z\":141.06919860839845,\"y\":2053.555908203125,\"x\":-1874.4549560546876}'),
(50, 'tabac', 'Tabac', '{\"accounts\":{\"cash\":0,\"society\":15550,\"black_money\":0},\"items_boss\":[],\"weapons\":[],\"weapons_boss\":[],\"items\":[]}', '{\"deposit_weapon_chest_society\":{\"sous-boss\":false,\"boss\":true,\"employed\":false},\"withdraw_cash_coffre\":{\"sous-boss\":false,\"boss\":true,\"employed\":false},\"change_salary_grade\":{\"sous-boss\":false,\"boss\":true,\"employed\":false},\"weapons_chest_society\":{\"sous-boss\":false,\"boss\":true,\"employed\":false},\"manage_employeds\":{\"sous-boss\":false,\"boss\":true,\"employed\":false},\"rename_label_grade\":{\"sous-boss\":false,\"boss\":true,\"employed\":false},\"promote_player\":{\"sous-boss\":false,\"boss\":true,\"employed\":false},\"open_boss\":{\"sous-boss\":false,\"boss\":true,\"employed\":false},\"deposit_black_money_coffre\":{\"sous-boss\":false,\"boss\":true,\"employed\":false},\"change_permissions_grade\":{\"sous-boss\":false,\"boss\":true,\"employed\":false},\"deposit_cash_coffre\":{\"sous-boss\":false,\"boss\":true,\"employed\":false},\"remove_weapon_chest\":{\"sous-boss\":false,\"boss\":true,\"employed\":false},\"manage_grades\":{\"sous-boss\":false,\"boss\":true,\"employed\":false},\"rename_grade\":{\"sous-boss\":false,\"boss\":true,\"employed\":false},\"delete_grade\":{\"sous-boss\":false,\"boss\":true,\"employed\":false},\"change_number_grade\":{\"sous-boss\":false,\"boss\":true,\"employed\":false},\"weapons_chest\":{\"sous-boss\":false,\"boss\":true,\"employed\":false},\"create_grade\":{\"sous-boss\":false,\"boss\":true,\"employed\":false},\"remove_item_chest\":{\"sous-boss\":false,\"boss\":true,\"employed\":false},\"deposit_money_society\":{\"sous-boss\":false,\"boss\":true,\"employed\":false},\"dposit_item_chest_society\":{\"sous-boss\":false,\"boss\":true,\"employed\":false},\"open_coffre\":{\"sous-boss\":false,\"boss\":true,\"employed\":false},\"withdraw_black_money_coffre\":{\"sous-boss\":false,\"boss\":true,\"employed\":false},\"remove_weapon_chest_society\":{\"sous-boss\":false,\"boss\":true,\"employed\":false},\"editClothes\":{\"sous-boss\":false,\"boss\":true,\"employed\":false},\"withdraw_money_society\":{\"sous-boss\":false,\"boss\":true,\"employed\":false},\"remove_item_chest_society\":{\"sous-boss\":false,\"boss\":true,\"employed\":false},\"items_chest\":{\"sous-boss\":false,\"boss\":true,\"employed\":false},\"deposit_item_chest\":{\"sous-boss\":false,\"boss\":true,\"employed\":false},\"items_chest:society\":{\"sous-boss\":false,\"boss\":true,\"employed\":false},\"chest\":{\"sous-boss\":false,\"boss\":true,\"employed\":false},\"deposit_weapon_chest\":{\"sous-boss\":false,\"boss\":true,\"employed\":false},\"demote_player\":{\"sous-boss\":false,\"boss\":true,\"employed\":false},\"recruit_player\":{\"sous-boss\":false,\"boss\":true,\"employed\":false},\"unmote_player\":{\"sous-boss\":false,\"boss\":true,\"employed\":false}}', '{\"z\":50.30839920043945,\"y\":4397.13134765625,\"x\":2889.119384765625}', '{\"z\":50.3368911743164,\"y\":4391.7001953125,\"x\":2890.314208984375}', '{\"position\":{\"z\":50.3368911743164,\"y\":4391.7001953125,\"x\":2890.314208984375},\"active\":true,\"sprite\":208,\"color\":64}', '1', 1, '[{\"grades\":{\"employed\":\"employed\"},\"grade\":true,\"data\":{\"chain_2\":0,\"hair_color_2\":0,\"face_md_weight\":49,\"mom\":2,\"mask_2\":0,\"bproof_2\":0,\"nose_5\":0,\"lipstick_2\":0,\"tshirt_1\":59,\"chin_4\":0,\"hair_1\":133,\"shoes_1\":12,\"arms\":0,\"blush_1\":0,\"chin_2\":0,\"bodyb_4\":0,\"decals_1\":0,\"helmet_2\":0,\"eye_color\":0,\"sex\":0,\"bracelets_2\":0,\"ears_1\":-1,\"eyebrows_4\":0,\"eye_squint\":0,\"eyebrows_6\":0,\"bags_1\":0,\"eyebrows_2\":0,\"blemishes_2\":0,\"bracelets_1\":-1,\"chest_1\":0,\"eyebrows_1\":0,\"helmet_1\":-1,\"age_1\":0,\"jaw_2\":0,\"complexion_2\":0,\"bodyb_1\":-1,\"cheeks_2\":0,\"mask_1\":0,\"eyebrows_5\":0,\"sun_1\":0,\"eyebrows_3\":0,\"skin_md_weight\":49,\"nose_6\":0,\"torso_1\":751,\"cheeks_3\":0,\"bproof_1\":0,\"makeup_1\":0,\"lip_thickness\":0,\"nose_2\":0,\"dad\":9,\"lipstick_4\":0,\"moles_2\":0,\"nose_1\":0,\"beard_1\":10,\"hair_color_1\":55,\"makeup_3\":0,\"beard_2\":10,\"chin_1\":0,\"cheeks_1\":0,\"pants_1\":4,\"chain_1\":0,\"arms_2\":0,\"moles_1\":0,\"complexion_1\":0,\"glasses_2\":0,\"blemishes_1\":0,\"neck_thickness\":0,\"nose_4\":0,\"tshirt_2\":0,\"makeup_4\":0,\"bodyb_3\":-1,\"bags_2\":0,\"makeup_2\":0,\"blush_3\":0,\"hair_2\":0,\"glasses_1\":0,\"pants_2\":4,\"blush_2\":0,\"jaw_1\":0,\"lipstick_3\":0,\"chin_3\":0,\"chest_2\":0,\"watches_1\":0,\"age_2\":0,\"shoes_2\":6,\"nose_3\":0,\"sun_2\":0,\"torso_2\":5,\"lipstick_1\":0,\"ears_2\":0,\"beard_3\":0,\"beard_4\":0,\"watches_2\":0,\"decals_2\":0,\"chest_3\":0,\"bodyb_2\":0},\"name\":\"Stagiaire\"},{\"grades\":{\"employed\":\"employed\"},\"grade\":true,\"data\":{\"chain_2\":0,\"hair_color_2\":0,\"face_md_weight\":49,\"mom\":2,\"mask_2\":0,\"bproof_2\":0,\"nose_5\":0,\"lipstick_2\":0,\"tshirt_1\":15,\"chin_4\":0,\"hair_1\":133,\"shoes_1\":12,\"arms\":0,\"blush_1\":0,\"chin_2\":0,\"bodyb_4\":0,\"decals_1\":0,\"helmet_2\":0,\"eye_color\":0,\"sex\":0,\"bracelets_2\":0,\"ears_1\":-1,\"eyebrows_4\":0,\"eye_squint\":0,\"eyebrows_6\":0,\"bags_1\":0,\"eyebrows_2\":0,\"blemishes_2\":0,\"bracelets_1\":-1,\"chest_1\":0,\"eyebrows_1\":0,\"helmet_1\":-1,\"age_1\":0,\"jaw_2\":0,\"complexion_2\":0,\"bodyb_1\":-1,\"cheeks_2\":0,\"mask_1\":0,\"eyebrows_5\":0,\"sun_1\":0,\"eyebrows_3\":0,\"skin_md_weight\":49,\"nose_6\":0,\"torso_1\":751,\"cheeks_3\":0,\"bproof_1\":0,\"makeup_1\":0,\"lip_thickness\":0,\"nose_2\":0,\"dad\":9,\"lipstick_4\":0,\"moles_2\":0,\"nose_1\":0,\"beard_1\":10,\"hair_color_1\":55,\"makeup_3\":0,\"beard_2\":10,\"chin_1\":0,\"cheeks_1\":0,\"pants_1\":4,\"chain_1\":0,\"arms_2\":0,\"moles_1\":0,\"complexion_1\":0,\"glasses_2\":0,\"blemishes_1\":0,\"neck_thickness\":0,\"nose_4\":0,\"tshirt_2\":0,\"makeup_4\":0,\"bodyb_3\":-1,\"bags_2\":0,\"makeup_2\":0,\"blush_3\":0,\"hair_2\":0,\"glasses_1\":0,\"pants_2\":4,\"blush_2\":0,\"jaw_1\":0,\"lipstick_3\":0,\"chin_3\":0,\"chest_2\":0,\"watches_1\":0,\"age_2\":0,\"shoes_2\":6,\"nose_3\":0,\"sun_2\":0,\"torso_2\":5,\"lipstick_1\":0,\"ears_2\":0,\"beard_3\":0,\"beard_4\":0,\"watches_2\":0,\"decals_2\":0,\"chest_3\":0,\"bodyb_2\":0},\"name\":\"Employé(e)\"},{\"grades\":{\"sous-boss\":\"sous-boss\"},\"grade\":true,\"data\":{\"chain_2\":0,\"hair_color_2\":0,\"face_md_weight\":49,\"mom\":2,\"mask_2\":0,\"bproof_2\":0,\"nose_5\":0,\"lipstick_2\":0,\"tshirt_1\":15,\"chin_4\":0,\"hair_1\":133,\"shoes_1\":10,\"arms\":11,\"blush_1\":0,\"chin_2\":0,\"bodyb_4\":0,\"decals_1\":0,\"helmet_2\":0,\"eye_color\":0,\"sex\":0,\"bracelets_2\":0,\"ears_1\":-1,\"eyebrows_4\":0,\"eye_squint\":0,\"eyebrows_6\":0,\"bags_1\":0,\"eyebrows_2\":0,\"blemishes_2\":0,\"bracelets_1\":-1,\"chest_1\":0,\"eyebrows_1\":0,\"helmet_1\":-1,\"age_1\":0,\"jaw_2\":0,\"complexion_2\":0,\"bodyb_1\":-1,\"cheeks_2\":0,\"mask_1\":0,\"eyebrows_5\":0,\"sun_1\":0,\"eyebrows_3\":0,\"skin_md_weight\":49,\"nose_6\":0,\"torso_1\":26,\"cheeks_3\":0,\"bproof_1\":0,\"makeup_1\":0,\"lip_thickness\":0,\"nose_2\":0,\"dad\":9,\"lipstick_4\":0,\"moles_2\":0,\"nose_1\":0,\"beard_1\":10,\"hair_color_1\":55,\"makeup_3\":0,\"beard_2\":10,\"chin_1\":0,\"cheeks_1\":0,\"pants_1\":10,\"chain_1\":0,\"arms_2\":0,\"moles_1\":0,\"complexion_1\":0,\"glasses_2\":0,\"blemishes_1\":0,\"neck_thickness\":0,\"nose_4\":0,\"tshirt_2\":0,\"makeup_4\":0,\"bodyb_3\":-1,\"bags_2\":0,\"makeup_2\":0,\"blush_3\":0,\"hair_2\":0,\"glasses_1\":0,\"pants_2\":0,\"blush_2\":0,\"jaw_1\":0,\"lipstick_3\":0,\"chin_3\":0,\"chest_2\":0,\"watches_1\":0,\"age_2\":0,\"shoes_2\":0,\"nose_3\":0,\"sun_2\":0,\"torso_2\":1,\"lipstick_1\":0,\"ears_2\":0,\"beard_3\":0,\"beard_4\":0,\"watches_2\":0,\"decals_2\":0,\"chest_3\":0,\"bodyb_2\":0},\"name\":\"Responsable\"},{\"grades\":{\"boss\":\"boss\"},\"grade\":true,\"data\":{\"chain_2\":0,\"hair_color_2\":0,\"face_md_weight\":49,\"mom\":2,\"mask_2\":0,\"bproof_2\":0,\"nose_5\":0,\"lipstick_2\":0,\"tshirt_1\":15,\"chin_4\":0,\"hair_1\":133,\"shoes_1\":3,\"arms\":11,\"blush_1\":0,\"chin_2\":0,\"bodyb_4\":0,\"decals_1\":0,\"helmet_2\":0,\"eye_color\":0,\"sex\":0,\"bracelets_2\":0,\"ears_1\":-1,\"eyebrows_4\":0,\"eye_squint\":0,\"eyebrows_6\":0,\"bags_1\":0,\"eyebrows_2\":0,\"blemishes_2\":0,\"bracelets_1\":-1,\"chest_1\":0,\"eyebrows_1\":0,\"helmet_1\":-1,\"age_1\":0,\"jaw_2\":0,\"complexion_2\":0,\"bodyb_1\":-1,\"cheeks_2\":0,\"mask_1\":0,\"eyebrows_5\":0,\"sun_1\":0,\"eyebrows_3\":0,\"skin_md_weight\":49,\"nose_6\":0,\"torso_1\":838,\"cheeks_3\":0,\"bproof_1\":0,\"makeup_1\":0,\"lip_thickness\":0,\"nose_2\":0,\"dad\":9,\"lipstick_4\":0,\"moles_2\":0,\"nose_1\":0,\"beard_1\":10,\"hair_color_1\":55,\"makeup_3\":0,\"beard_2\":10,\"chin_1\":0,\"cheeks_1\":0,\"pants_1\":24,\"chain_1\":0,\"arms_2\":0,\"moles_1\":0,\"complexion_1\":0,\"glasses_2\":0,\"blemishes_1\":0,\"neck_thickness\":0,\"nose_4\":0,\"tshirt_2\":0,\"makeup_4\":0,\"bodyb_3\":-1,\"bags_2\":0,\"makeup_2\":0,\"blush_3\":0,\"hair_2\":0,\"glasses_1\":0,\"pants_2\":5,\"blush_2\":0,\"jaw_1\":0,\"lipstick_3\":0,\"chin_3\":0,\"chest_2\":0,\"watches_1\":0,\"age_2\":0,\"shoes_2\":1,\"nose_3\":0,\"sun_2\":0,\"torso_2\":3,\"lipstick_1\":0,\"ears_2\":0,\"beard_3\":0,\"beard_4\":0,\"watches_2\":0,\"decals_2\":0,\"chest_3\":0,\"bodyb_2\":0},\"name\":\"Patron\"}]', '{\"z\":50.29619216918945,\"y\":4400.97314453125,\"x\":2887.09326171875}');
INSERT INTO `society_data` (`id`, `name`, `label`, `coffre`, `permissions`, `posCoffre`, `posBoss`, `blips`, `tax`, `cloakroom`, `clothes`, `cloakpos`) VALUES
(53, 'ltd_littleseoul', 'LTD Little Seoul', '{\"items\":{\"ocean_lures\":{\"label\":\"Appât d\'Eau Profonde\",\"name\":\"ocean_lures\",\"count\":60},\"douce_lures\":{\"label\":\"Appât d\'Eau Douce\",\"name\":\"douce_lures\",\"count\":660},\"canneapeche\":{\"label\":\"Canne à Pêche\",\"name\":\"canneapeche\",\"count\":1}},\"weapons_boss\":[],\"accounts\":{\"society\":88353.85628988136,\"cash\":0,\"black_money\":0},\"weapons\":[],\"items_boss\":{\"water\":{\"label\":\"Eau\",\"name\":\"water\",\"count\":20},\"kq_acetone\":{\"label\":\"Acétone\",\"name\":\"kq_acetone\",\"count\":20},\"kq_ethanol\":{\"label\":\"Éthanol\",\"name\":\"kq_ethanol\",\"count\":20},\"bread\":{\"label\":\"Pain\",\"name\":\"bread\",\"count\":18}}}', '{\"withdraw_cash_coffre\":{\"Expérimenter\":false,\"label\":\"Retirer de l\'argent dans le coffre\",\"employed\":[],\"Expérimenté\":false,\"grades\":{\"boss\":true},\"sous-boss\":[],\"Employé\":false,\"boss\":true},\"dposit_item_chest_society\":{\"Expérimenter\":true,\"label\":\"Déposer un item dans le coffre de la société\",\"employed\":[],\"Expérimenté\":false,\"grades\":{\"boss\":true},\"sous-boss\":[],\"Employé\":false,\"boss\":true},\"rename_grade\":{\"Expérimenter\":false,\"label\":\"Changer le nom d\'un grade\",\"employed\":[],\"Expérimenté\":false,\"grades\":{\"boss\":true},\"sous-boss\":[],\"Employé\":false,\"boss\":true},\"chest\":{\"Expérimenter\":true,\"label\":\"Accéder au coffre de la société\",\"employed\":[],\"Expérimenté\":false,\"grades\":{\"boss\":true},\"sous-boss\":[],\"Employé\":false,\"boss\":true},\"change_salary_grade\":{\"Expérimenter\":false,\"label\":\"Changer le salaire d\'un grade\",\"employed\":[],\"Expérimenté\":false,\"grades\":{\"boss\":true},\"sous-boss\":[],\"Employé\":false,\"boss\":true},\"manage_grades\":{\"Expérimenter\":false,\"label\":\"Gérer les grades de la société\",\"employed\":false,\"Expérimenté\":false,\"grades\":{\"boss\":true},\"sous-boss\":[],\"Employé\":false,\"boss\":true},\"deposit_weapon_chest\":{\"Expérimenter\":true,\"label\":\"Déposer une arme dans le coffre\",\"employed\":[],\"Expérimenté\":false,\"grades\":{\"boss\":true},\"sous-boss\":[],\"Employé\":false,\"boss\":true},\"create_grade\":{\"Expérimenter\":false,\"label\":\"Créer un grade\",\"employed\":[],\"Expérimenté\":false,\"grades\":{\"boss\":true},\"sous-boss\":[],\"Employé\":false,\"boss\":true},\"rename_label_grade\":{\"Expérimenter\":false,\"label\":\"Changer le label d\'un grade\",\"employed\":[],\"Expérimenté\":false,\"grades\":{\"boss\":true},\"sous-boss\":[],\"Employé\":false,\"boss\":true},\"demote_player\":{\"Expérimenter\":false,\"label\":\"Virer un employé\",\"employed\":[],\"Expérimenté\":false,\"grades\":{\"boss\":true},\"sous-boss\":[],\"Employé\":false,\"boss\":true},\"promote_player\":{\"Expérimenter\":true,\"label\":\"Augmenter un employé\",\"employed\":[],\"Expérimenté\":false,\"grades\":{\"boss\":true},\"sous-boss\":[],\"Employé\":false,\"boss\":true},\"withdraw_money_society\":{\"Expérimenter\":false,\"label\":\"Retirer de l\'argent dans le coffre de la société\",\"employed\":[],\"Expérimenté\":false,\"grades\":{\"boss\":true},\"sous-boss\":[],\"Employé\":false,\"boss\":true},\"withdraw_black_money_coffre\":{\"Expérimenter\":false,\"label\":\"Retirer de l\'argent sale dans le coffre\",\"employed\":[],\"Expérimenté\":false,\"grades\":{\"boss\":true},\"sous-boss\":[],\"Employé\":false,\"boss\":true},\"remove_weapon_chest\":{\"Expérimenter\":false,\"label\":\"Retirer une arme dans le coffre\",\"employed\":[],\"Expérimenté\":false,\"grades\":{\"boss\":true},\"sous-boss\":[],\"Employé\":false,\"boss\":true},\"deposit_weapon_chest_society\":{\"Expérimenter\":true,\"label\":\"Déposer une arme dans le coffre de la société\",\"employed\":[],\"Expérimenté\":false,\"grades\":{\"boss\":true},\"sous-boss\":[],\"Employé\":false,\"boss\":true},\"delete_grade\":{\"Expérimenter\":false,\"label\":\"Supprimer un grade\",\"employed\":[],\"Expérimenté\":false,\"grades\":{\"boss\":true},\"sous-boss\":[],\"Employé\":false,\"boss\":true},\"weapons_chest\":{\"Expérimenter\":false,\"label\":\"Armes du coffre\",\"employed\":[],\"Expérimenté\":false,\"grades\":{\"boss\":true},\"sous-boss\":[],\"Employé\":false,\"boss\":true},\"change_permissions_grade\":{\"Expérimenter\":false,\"label\":\"Changer les permissions d\'un grade\",\"employed\":[],\"Expérimenté\":false,\"grades\":{\"boss\":true},\"sous-boss\":[],\"Employé\":false,\"boss\":true},\"items_chest:society\":{\"Expérimenter\":false,\"label\":\"Item(s) du coffre de la société\",\"employed\":[],\"Expérimenté\":false,\"grades\":{\"boss\":true},\"sous-boss\":[],\"Employé\":false,\"boss\":true},\"remove_item_chest_society\":{\"Expérimenter\":false,\"label\":\"Retirer un item dans le coffre de la société\",\"employed\":[],\"Expérimenté\":false,\"grades\":{\"boss\":true},\"sous-boss\":[],\"Employé\":false,\"boss\":true},\"weapons_chest_society\":{\"Expérimenter\":false,\"label\":\"Arme(s) du coffre de la société\",\"employed\":[],\"Expérimenté\":false,\"grades\":{\"boss\":true},\"sous-boss\":[],\"Employé\":false,\"boss\":true},\"editClothes\":{\"Expérimenter\":false,\"label\":\"Gérer les tenues dans le vestiaire\",\"employed\":[],\"Expérimenté\":false,\"grades\":{\"boss\":true},\"sous-boss\":[],\"Employé\":false,\"boss\":true},\"change_number_grade\":{\"Expérimenter\":false,\"label\":\"Changer le numéro d\'un grade\",\"employed\":[],\"Expérimenté\":false,\"grades\":{\"boss\":true},\"sous-boss\":[],\"Employé\":false,\"boss\":true},\"deposit_cash_coffre\":{\"Expérimenter\":false,\"label\":\"Déposer de l\'argent dans le coffre\",\"employed\":[],\"Expérimenté\":false,\"grades\":{\"boss\":true},\"sous-boss\":[],\"Employé\":false,\"boss\":true},\"deposit_black_money_coffre\":{\"Expérimenter\":false,\"label\":\"Déposer de l\'argent sale dans le coffre\",\"employed\":[],\"Expérimenté\":false,\"grades\":{\"boss\":true},\"sous-boss\":[],\"Employé\":false,\"boss\":true},\"unmote_player\":{\"Expérimenter\":false,\"label\":\"Descendre un employé\",\"employed\":[],\"Expérimenté\":false,\"grades\":{\"boss\":true},\"sous-boss\":[],\"Employé\":false,\"boss\":true},\"manage_employeds\":{\"Expérimenter\":false,\"label\":\"Gérer les employés de la société\",\"employed\":[],\"Expérimenté\":false,\"grades\":{\"boss\":true},\"sous-boss\":[],\"Employé\":false,\"boss\":true},\"open_coffre\":{\"Expérimenter\":true,\"label\":\"Ouvrir le coffre\",\"employed\":[],\"Expérimenté\":false,\"grades\":{\"boss\":true},\"sous-boss\":[],\"Employé\":false,\"boss\":true},\"deposit_money_society\":{\"Expérimenter\":true,\"label\":\"Déposer de l\'argent dans le coffre de la société\",\"employed\":[],\"Expérimenté\":false,\"grades\":{\"boss\":true},\"sous-boss\":[],\"Employé\":false,\"boss\":true},\"open_boss\":{\"Expérimenter\":false,\"label\":\"Ouvrir le menu boss\",\"employed\":[],\"Expérimenté\":false,\"grades\":{\"boss\":true},\"sous-boss\":[],\"Employé\":false,\"boss\":true},\"deposit_item_chest\":{\"Expérimenter\":true,\"label\":\"Déposer un item dans le coffre\",\"employed\":[],\"Expérimenté\":false,\"grades\":{\"boss\":true},\"sous-boss\":[],\"Employé\":false,\"boss\":true},\"items_chest\":{\"Expérimenter\":false,\"label\":\"Items du coffre\",\"employed\":[],\"Expérimenté\":false,\"grades\":{\"boss\":true},\"sous-boss\":[],\"Employé\":false,\"boss\":true},\"recruit_player\":{\"Expérimenter\":false,\"label\":\"Recruté un joueur\",\"employed\":[],\"Expérimenté\":false,\"grades\":{\"boss\":true},\"sous-boss\":[],\"Employé\":false,\"boss\":true},\"remove_weapon_chest_society\":{\"Expérimenter\":false,\"label\":\"Retirer une arme dans la coffre de la société\",\"employed\":[],\"Expérimenté\":false,\"grades\":{\"boss\":true},\"sous-boss\":[],\"Employé\":false,\"boss\":true},\"remove_item_chest\":{\"Expérimenter\":false,\"label\":\"Retirer un item dans le coffre\",\"employed\":[],\"Expérimenté\":false,\"grades\":{\"boss\":true},\"sous-boss\":[],\"Employé\":false,\"boss\":true}}', '{\"y\":-904.4976196289064,\"x\":-705.4893188476563,\"z\":19.21559906005859}', '{\"y\":-904.7119750976564,\"x\":-709.4483032226563,\"z\":19.21559906005859}', '{\"sprite\":52,\"color\":69,\"active\":true,\"position\":{\"y\":-914.44750976562,\"x\":-709.75347900391,\"z\":19.214469909668}}', '3', 1, '[{\"grade\":true,\"data\":{\"tshirt_1\":31,\"moles_1\":0,\"lipstick_1\":0,\"complexion_2\":0,\"beard_2\":10,\"lip_thickness\":0,\"dad\":15,\"chest_2\":0,\"eye_color\":0,\"skin_md_weight\":50,\"bodyb_3\":-1,\"shoes_1\":10,\"torso_1\":29,\"eyebrows_4\":0,\"bodyb_1\":0,\"chain_2\":0,\"mask_2\":0,\"decals_2\":0,\"jaw_2\":0,\"watches_2\":0,\"blush_2\":0,\"pants_2\":0,\"eye_squint\":0,\"arms\":1,\"sun_1\":0,\"bags_1\":0,\"nose_2\":1,\"glasses_1\":68,\"torso_2\":0,\"eyebrows_2\":0,\"eyebrows_6\":0,\"helmet_2\":0,\"bproof_1\":0,\"beard_4\":0,\"cheeks_3\":0,\"decals_1\":0,\"chain_1\":0,\"blush_3\":0,\"nose_4\":1,\"hair_color_1\":0,\"sex\":0,\"chin_2\":0,\"bproof_2\":0,\"glasses_2\":0,\"watches_1\":-1,\"sun_2\":0,\"hair_2\":0,\"arms_2\":0,\"mom\":2,\"chin_3\":0,\"bracelets_2\":0,\"nose_3\":0,\"lipstick_3\":0,\"age_2\":0,\"chin_1\":0,\"face_color\":0,\"ears_1\":0,\"blemishes_2\":0,\"eyebrows_1\":0,\"neck_thickness\":0,\"beard_3\":0,\"bags_2\":0,\"age_1\":0,\"nose_1\":0,\"face_md_weight\":0,\"blemishes_1\":0,\"lipstick_4\":0,\"helmet_1\":-1,\"hair_1\":81,\"eyebrows_3\":0,\"chest_1\":0,\"complexion_1\":0,\"cheeks_2\":0,\"blush_1\":0,\"shoes_2\":0,\"makeup_4\":0,\"cheeks_1\":0,\"bodyb_4\":0,\"hair_color_2\":0,\"beard_1\":3,\"makeup_3\":0,\"mask_1\":0,\"bodyb_2\":0,\"jaw_1\":0,\"tshirt_2\":0,\"moles_2\":0,\"nose_6\":0,\"chin_4\":0,\"chest_3\":0,\"lipstick_2\":0,\"ears_2\":0,\"pants_1\":13,\"nose_5\":0,\"makeup_1\":0,\"eyebrows_5\":0,\"makeup_2\":0,\"bracelets_1\":-1},\"name\":\"Tenue Patron\",\"grades\":{\"boss\":\"boss\"}},{\"grade\":true,\"data\":{\"tshirt_1\":15,\"moles_1\":0,\"lipstick_1\":0,\"complexion_2\":0,\"beard_2\":10,\"lip_thickness\":0,\"dad\":15,\"chest_2\":0,\"eye_color\":0,\"skin_md_weight\":50,\"bodyb_3\":-1,\"shoes_1\":201,\"torso_1\":825,\"eyebrows_4\":0,\"bodyb_1\":0,\"chain_2\":0,\"mask_2\":0,\"decals_2\":0,\"jaw_2\":0,\"watches_2\":0,\"blush_2\":0,\"pants_2\":0,\"eye_squint\":0,\"arms\":0,\"sun_1\":0,\"bags_1\":0,\"nose_2\":1,\"glasses_1\":68,\"torso_2\":1,\"eyebrows_2\":0,\"eyebrows_6\":0,\"helmet_2\":0,\"bproof_1\":0,\"beard_4\":0,\"cheeks_3\":0,\"decals_1\":0,\"chain_1\":0,\"blush_3\":0,\"nose_4\":1,\"hair_color_1\":0,\"sex\":0,\"chin_2\":0,\"bproof_2\":0,\"glasses_2\":0,\"watches_1\":-1,\"sun_2\":0,\"hair_2\":0,\"arms_2\":0,\"mom\":2,\"chin_3\":0,\"bracelets_2\":0,\"nose_3\":0,\"lipstick_3\":0,\"age_2\":0,\"chin_1\":0,\"face_color\":0,\"ears_1\":0,\"blemishes_2\":0,\"eyebrows_1\":0,\"neck_thickness\":0,\"beard_3\":0,\"bags_2\":0,\"age_1\":0,\"nose_1\":0,\"face_md_weight\":0,\"blemishes_1\":0,\"lipstick_4\":0,\"helmet_1\":-1,\"hair_1\":81,\"eyebrows_3\":0,\"chest_1\":0,\"complexion_1\":0,\"cheeks_2\":0,\"blush_1\":0,\"shoes_2\":0,\"makeup_4\":0,\"cheeks_1\":0,\"bodyb_4\":0,\"hair_color_2\":0,\"beard_1\":3,\"makeup_3\":0,\"mask_1\":0,\"bodyb_2\":0,\"jaw_1\":0,\"tshirt_2\":0,\"moles_2\":0,\"nose_6\":0,\"chin_4\":0,\"chest_3\":0,\"lipstick_2\":0,\"ears_2\":0,\"pants_1\":13,\"nose_5\":0,\"makeup_1\":0,\"eyebrows_5\":0,\"makeup_2\":0,\"bracelets_1\":-1},\"name\":\"Tenue Co Patron\",\"grades\":{\"sous-boss\":\"sous-boss\"}},{\"grade\":true,\"data\":{\"tshirt_1\":299,\"moles_1\":5,\"lipstick_1\":0,\"complexion_2\":0,\"beard_2\":10,\"lip_thickness\":0,\"beard_1\":11,\"chest_2\":0,\"eye_color\":0,\"skin_md_weight\":50,\"bodyb_3\":-1,\"shoes_1\":12,\"torso_1\":704,\"eyebrows_4\":0,\"bodyb_1\":-1,\"hair_1\":75,\"mask_2\":0,\"ears_2\":0,\"jaw_2\":0,\"watches_2\":0,\"blush_2\":0,\"pants_2\":0,\"hair_2\":0,\"helmet_1\":-1,\"sun_1\":0,\"nose_6\":0,\"nose_2\":0,\"glasses_1\":96,\"torso_2\":0,\"eyebrows_2\":10,\"eyebrows_6\":0,\"helmet_2\":0,\"chest_1\":0,\"chin_1\":0,\"cheeks_3\":0,\"decals_1\":0,\"chain_1\":397,\"blush_3\":0,\"nose_4\":0,\"hair_color_1\":0,\"sex\":0,\"chin_2\":0,\"decals_2\":0,\"glasses_2\":0,\"beard_4\":0,\"neck_thickness\":0,\"lipstick_2\":0,\"bracelets_1\":-1,\"jaw_1\":0,\"chin_3\":0,\"blemishes_1\":0,\"nose_3\":0,\"lipstick_3\":0,\"age_2\":0,\"hair_color_2\":0,\"eyebrows_5\":0,\"ears_1\":-1,\"blemishes_2\":0,\"eyebrows_1\":33,\"moles_2\":10,\"beard_3\":0,\"bags_2\":0,\"age_1\":0,\"nose_1\":0,\"face_md_weight\":0,\"lipstick_4\":0,\"sun_2\":0,\"complexion_1\":0,\"bracelets_2\":0,\"eyebrows_3\":0,\"watches_1\":0,\"bodyb_4\":0,\"cheeks_2\":7,\"blush_1\":0,\"shoes_2\":3,\"makeup_4\":0,\"cheeks_1\":10,\"bproof_1\":0,\"mom\":30,\"eye_squint\":0,\"makeup_3\":0,\"mask_1\":0,\"bodyb_2\":0,\"chain_2\":0,\"tshirt_2\":0,\"bags_1\":0,\"arms\":11,\"chin_4\":0,\"chest_3\":0,\"bproof_2\":0,\"pants_1\":102,\"arms_2\":0,\"nose_5\":0,\"makeup_1\":0,\"face_color\":0,\"makeup_2\":0,\"dad\":24},\"name\":\"Tenu  1\",\"grades\":{\"employed\":\"employed\"}},{\"grade\":true,\"data\":{\"tshirt_1\":2,\"moles_1\":0,\"lipstick_1\":0,\"complexion_2\":0,\"beard_2\":8,\"lip_thickness\":0,\"eyebrows_2\":9,\"chest_2\":0,\"eye_color\":0,\"chin_2\":0,\"bodyb_3\":-1,\"shoes_1\":99,\"torso_1\":602,\"eyebrows_4\":0,\"bodyb_1\":-1,\"chain_2\":0,\"mask_2\":0,\"decals_2\":0,\"chain_1\":203,\"watches_2\":28,\"blush_2\":0,\"pants_2\":0,\"hair_2\":0,\"arms\":35,\"sun_1\":0,\"nose_6\":0,\"bodyb_4\":0,\"glasses_1\":18,\"torso_2\":2,\"eyebrows_6\":0,\"helmet_2\":0,\"bproof_1\":129,\"nose_4\":0,\"complexion_1\":0,\"decals_1\":0,\"bracelets_2\":28,\"blush_3\":0,\"lipstick_4\":0,\"hair_color_1\":0,\"sex\":0,\"jaw_2\":0,\"helmet_1\":290,\"glasses_2\":2,\"watches_1\":-1,\"moles_2\":0,\"chest_1\":0,\"arms_2\":0,\"blemishes_1\":0,\"chin_3\":0,\"hair_1\":39,\"nose_3\":0,\"lipstick_3\":0,\"age_2\":0,\"jaw_1\":0,\"eyebrows_5\":0,\"ears_1\":0,\"blemishes_2\":0,\"eyebrows_1\":30,\"neck_thickness\":0,\"beard_3\":0,\"chin_1\":0,\"age_1\":0,\"nose_1\":0,\"face_md_weight\":50,\"eye_squint\":0,\"sun_2\":0,\"tshirt_2\":30,\"mom\":0,\"eyebrows_3\":0,\"beard_1\":10,\"bracelets_1\":-1,\"cheeks_2\":0,\"blush_1\":0,\"shoes_2\":1,\"makeup_4\":0,\"cheeks_1\":0,\"nose_2\":0,\"beard_4\":0,\"cheeks_3\":0,\"makeup_3\":0,\"mask_1\":0,\"bodyb_2\":0,\"bags_1\":0,\"ears_2\":0,\"hair_color_2\":0,\"bproof_2\":30,\"chin_4\":0,\"chest_3\":0,\"lipstick_2\":0,\"dad\":0,\"bags_2\":0,\"nose_5\":0,\"makeup_1\":0,\"skin_md_weight\":50,\"makeup_2\":0,\"pants_1\":221},\"name\":\"CO PATRON\",\"grades\":{\"sous-boss\":\"sous-boss\"}}]', '{\"y\":-915.3992309570313,\"x\":-705.880859375,\"z\":19.21560859680175}'),
(54, 'ltd_paletobay', 'LTD Paleto Bay', '{\"accounts\":{\"society\":15000,\"cash\":0,\"black_money\":0},\"weapons\":[],\"weapons_boss\":[],\"items\":[],\"items_boss\":[]}', '{\"chest\":{\"boss\":true},\"weapons_chest\":{\"boss\":true},\"create_grade\":{\"boss\":true},\"deposit_item_chest\":{\"boss\":true},\"deposit_weapon_chest\":{\"boss\":true},\"unmote_player\":{\"boss\":true},\"withdraw_money_society\":{\"boss\":true},\"items_chest\":{\"boss\":true},\"promote_player\":{\"boss\":true},\"remove_item_chest\":{\"boss\":true},\"remove_item_chest_society\":{\"boss\":true},\"open_boss\":{\"boss\":true},\"deposit_black_money_coffre\":{\"boss\":true},\"remove_weapon_chest\":{\"boss\":true},\"rename_label_grade\":{\"boss\":true},\"deposit_cash_coffre\":{\"boss\":true},\"delete_grade\":{\"boss\":true},\"deposit_weapon_chest_society\":{\"boss\":true},\"rename_grade\":{\"boss\":true},\"open_coffre\":{\"boss\":true},\"editClothes\":{\"boss\":true},\"withdraw_cash_coffre\":{\"boss\":true},\"withdraw_black_money_coffre\":{\"boss\":true},\"remove_weapon_chest_society\":{\"boss\":true},\"demote_player\":{\"boss\":true},\"change_salary_grade\":{\"boss\":true},\"change_number_grade\":{\"boss\":true},\"manage_employeds\":{\"boss\":true},\"deposit_money_society\":{\"boss\":true},\"weapons_chest_society\":{\"boss\":true},\"change_permissions_grade\":{\"boss\":true},\"items_chest:society\":{\"boss\":true},\"manage_grades\":{\"boss\":true},\"recruit_player\":{\"boss\":true},\"dposit_item_chest_society\":{\"boss\":true}}', '{\"x\":164.86036682128907,\"y\":6649.79931640625,\"z\":31.69863128662109}', '{\"x\":157.68443298339845,\"y\":6643.82568359375,\"z\":31.69863510131836}', '{\"sprite\":52,\"color\":69,\"position\":{\"y\":6637.4296875,\"z\":31.7012882232666,\"x\":162.81805419921876},\"active\":true}', '0', 1, '[]', '{\"x\":157.95318603515626,\"y\":6653.68505859375,\"z\":31.69862747192382}'),
(55, 'ltd_f4l', 'LTD Forum Drive', '{\"items\":{\"wiwang_juspassion\":{\"name\":\"wiwang_juspassion\",\"label\":\"Jus Passion Mangue\",\"count\":10},\"hydrochloric_acid\":{\"name\":\"hydrochloric_acid\",\"label\":\"Acide chlorhydrique\",\"count\":13},\"coca_blend\":{\"name\":\"coca_blend\",\"label\":\"Mélange de coca\",\"count\":15},\"wiwang_cocktail\":{\"name\":\"wiwang_cocktail\",\"label\":\"Cocktail Bora Bora\",\"count\":10},\"wiwang_donperignon\":{\"name\":\"wiwang_donperignon\",\"label\":\"Don Perignon\",\"count\":10},\"rifle_ammo\":{\"name\":\"rifle_ammo\",\"label\":\"Munitions pour fusil\",\"count\":127},\"kq_meth_lab_kit\":{\"name\":\"kq_meth_lab_kit\",\"label\":\"Kit de cuisson\",\"count\":1},\"wiwang_macarons\":{\"name\":\"wiwang_macarons\",\"label\":\"Macarons\",\"count\":10},\"feuillecoca\":{\"name\":\"feuillecoca\",\"label\":\"Feuille de coca\",\"count\":13},\"wiwang_vin\":{\"name\":\"wiwang_vin\",\"label\":\"Vin\",\"count\":9},\"wiwang_ruinart\":{\"name\":\"wiwang_ruinart\",\"label\":\"Ruinart\",\"count\":11}},\"weapons_boss\":[],\"items_boss\":[],\"weapons\":[],\"accounts\":{\"society\":1583407.0,\"cash\":0,\"black_money\":274370}}', '{\"items_chest\":{\"employer\":true,\"sous-boss\":[],\"boss\":true},\"editClothes\":{\"employer\":false,\"sous-boss\":[],\"boss\":true},\"rename_grade\":{\"employer\":false,\"sous-boss\":[],\"boss\":true},\"chest\":{\"employer\":false,\"sous-boss\":[],\"boss\":true},\"change_salary_grade\":{\"employer\":false,\"sous-boss\":[],\"boss\":true},\"manage_grades\":{\"employer\":false,\"sous-boss\":[],\"boss\":true},\"deposit_weapon_chest\":{\"employer\":false,\"sous-boss\":[],\"boss\":true},\"create_grade\":{\"employer\":false,\"sous-boss\":[],\"boss\":true},\"deposit_item_chest\":{\"employer\":false,\"sous-boss\":[],\"boss\":true},\"demote_player\":{\"employer\":false,\"sous-boss\":[],\"boss\":true},\"promote_player\":{\"employer\":false,\"sous-boss\":[],\"boss\":true},\"withdraw_money_society\":{\"employer\":false,\"sous-boss\":[],\"boss\":true},\"withdraw_black_money_coffre\":{\"employer\":false,\"sous-boss\":[],\"boss\":true},\"remove_weapon_chest\":{\"employer\":false,\"sous-boss\":[],\"boss\":true},\"deposit_weapon_chest_society\":{\"employer\":false,\"sous-boss\":[],\"boss\":true},\"delete_grade\":{\"employer\":false,\"sous-boss\":false,\"boss\":true},\"weapons_chest\":{\"employer\":false,\"sous-boss\":[],\"boss\":true},\"change_permissions_grade\":{\"employer\":false,\"sous-boss\":false,\"boss\":true},\"recruit_player\":{\"employer\":false,\"sous-boss\":[],\"boss\":true},\"remove_item_chest_society\":{\"employer\":false,\"sous-boss\":[],\"boss\":true},\"weapons_chest_society\":{\"employer\":false,\"sous-boss\":[],\"boss\":true},\"unmote_player\":{\"employer\":false,\"sous-boss\":[],\"boss\":true},\"change_number_grade\":{\"employer\":false,\"sous-boss\":[],\"boss\":true},\"dposit_item_chest_society\":{\"employer\":false,\"sous-boss\":[],\"boss\":true},\"withdraw_cash_coffre\":{\"employer\":false,\"sous-boss\":[],\"boss\":true},\"items_chest:society\":{\"employer\":false,\"sous-boss\":[],\"boss\":true},\"manage_employeds\":{\"employer\":false,\"sous-boss\":[],\"boss\":true},\"open_coffre\":{\"employer\":false,\"sous-boss\":[],\"boss\":true},\"deposit_money_society\":{\"employer\":false,\"sous-boss\":[],\"boss\":true},\"open_boss\":{\"employer\":false,\"sous-boss\":true,\"boss\":true},\"deposit_black_money_coffre\":{\"employer\":false,\"sous-boss\":[],\"boss\":true},\"deposit_cash_coffre\":{\"employer\":false,\"sous-boss\":[],\"boss\":true},\"rename_label_grade\":{\"employer\":false,\"sous-boss\":[],\"boss\":true},\"remove_weapon_chest_society\":{\"employer\":false,\"sous-boss\":[],\"boss\":true},\"remove_item_chest\":{\"employer\":false,\"sous-boss\":[],\"boss\":true}}', '{\"y\":-1339.27978515625,\"x\":31.03375053405761,\"z\":29.49405479431152}', '{\"y\":-1339.3367919921876,\"x\":24.74807167053222,\"z\":29.49405288696289}', '{\"sprite\":52,\"color\":69,\"active\":true,\"position\":{\"y\":-1345.2635498047,\"x\":27.35817527771,\"z\":29.496807098389}}', '0', 1, '[{\"grades\":[],\"grade\":false,\"name\":\"Vendeur\",\"data\":{\"nose_3\":0,\"sun_1\":0,\"makeup_1\":0,\"nose_6\":0,\"decals_2\":0,\"ears_1\":8,\"chain_1\":11,\"watches_1\":8,\"moles_2\":0,\"complexion_1\":0,\"lipstick_2\":0,\"decals_1\":0,\"dad\":21,\"bracelets_1\":-1,\"eye_squint\":0,\"complexion_2\":0,\"mask_2\":0,\"eyebrows_4\":0,\"lipstick_1\":0,\"bproof_1\":0,\"bags_2\":0,\"blemishes_2\":0,\"glasses_1\":59,\"chain_2\":6,\"beard_1\":0,\"glasses_2\":0,\"eye_color\":11,\"hair_color_2\":0,\"pants_2\":3,\"blush_3\":0,\"chest_3\":0,\"torso_1\":25,\"eyebrows_3\":0,\"nose_1\":0,\"bags_1\":0,\"eyebrows_1\":0,\"chin_2\":0,\"lipstick_3\":0,\"lipstick_4\":0,\"moles_1\":0,\"bodyb_3\":-1,\"torso_2\":0,\"face_md_weight\":50,\"ears_2\":0,\"makeup_3\":36,\"cheeks_1\":0,\"bodyb_2\":0,\"helmet_1\":12,\"nose_4\":0,\"arms_2\":0,\"nose_2\":0,\"jaw_2\":0,\"cheeks_3\":0,\"makeup_2\":0,\"chin_4\":0,\"tshirt_1\":6,\"mom\":9,\"helmet_2\":1,\"blush_2\":0,\"bodyb_1\":-1,\"chin_3\":0,\"pants_1\":10,\"bproof_2\":0,\"sex\":0,\"hair_color_1\":14,\"eyebrows_5\":0,\"beard_3\":0,\"skin_md_weight\":50,\"nose_5\":0,\"watches_2\":0,\"beard_2\":0,\"shoes_1\":10,\"jaw_1\":0,\"blush_1\":0,\"eyebrows_2\":7,\"chest_2\":0,\"neck_thickness\":0,\"makeup_4\":0,\"eyebrows_6\":0,\"cheeks_2\":0,\"sun_2\":0,\"tshirt_2\":0,\"beard_4\":0,\"shoes_2\":9,\"arms\":74,\"hair_1\":57,\"lip_thickness\":0,\"bracelets_2\":0,\"hair_2\":0,\"blemishes_1\":0,\"age_2\":0,\"mask_1\":0,\"chest_1\":0,\"age_1\":0,\"chin_1\":0,\"bodyb_4\":0}},{\"grades\":[],\"grade\":false,\"name\":\"VendeurM\",\"data\":{\"nose_3\":0,\"sun_1\":0,\"makeup_1\":0,\"nose_6\":0,\"decals_2\":0,\"ears_1\":8,\"chain_1\":11,\"watches_1\":8,\"moles_2\":0,\"complexion_1\":0,\"lipstick_2\":0,\"decals_1\":0,\"dad\":21,\"bracelets_1\":-1,\"eye_squint\":0,\"complexion_2\":0,\"mask_2\":0,\"eyebrows_4\":0,\"lipstick_1\":0,\"bproof_1\":0,\"bags_2\":0,\"blemishes_2\":0,\"glasses_1\":59,\"chain_2\":6,\"beard_1\":0,\"glasses_2\":0,\"eye_color\":11,\"hair_color_2\":0,\"pants_2\":3,\"blush_3\":0,\"chest_3\":0,\"torso_1\":25,\"eyebrows_3\":0,\"nose_1\":0,\"bags_1\":0,\"eyebrows_1\":0,\"chin_2\":0,\"lipstick_3\":0,\"lipstick_4\":0,\"moles_1\":0,\"bodyb_3\":-1,\"torso_2\":0,\"face_md_weight\":50,\"ears_2\":0,\"makeup_3\":36,\"cheeks_1\":0,\"bodyb_2\":0,\"helmet_1\":12,\"nose_4\":0,\"arms_2\":0,\"nose_2\":0,\"jaw_2\":0,\"cheeks_3\":0,\"makeup_2\":0,\"chin_4\":0,\"tshirt_1\":6,\"mom\":9,\"helmet_2\":1,\"blush_2\":0,\"bodyb_1\":-1,\"chin_3\":0,\"pants_1\":10,\"bproof_2\":0,\"sex\":0,\"hair_color_1\":14,\"eyebrows_5\":0,\"beard_3\":0,\"skin_md_weight\":50,\"nose_5\":0,\"watches_2\":0,\"beard_2\":0,\"shoes_1\":10,\"jaw_1\":0,\"blush_1\":0,\"eyebrows_2\":7,\"chest_2\":0,\"neck_thickness\":0,\"makeup_4\":0,\"eyebrows_6\":0,\"cheeks_2\":0,\"sun_2\":0,\"tshirt_2\":0,\"beard_4\":0,\"shoes_2\":9,\"arms\":74,\"hair_1\":57,\"lip_thickness\":0,\"bracelets_2\":0,\"hair_2\":0,\"blemishes_1\":0,\"age_2\":0,\"mask_1\":0,\"chest_1\":0,\"age_1\":0,\"chin_1\":0,\"bodyb_4\":0}}]', '{\"y\":-1348.7269287109376,\"x\":24.53115844726562,\"z\":29.49773597717285}'),
(56, 'ltd_ballas', 'LTD Grove Street', '{\"items\":{},\"items_boss\":[],\"weapons_boss\":[],\"weapons\":[],\"accounts\":{\"black_money\":0,\"society\":0,\"cash\":0}}', '{\"promote_player\":{\"boss\":true},\"deposit_weapon_chest\":{\"boss\":true},\"dposit_item_chest_society\":{\"boss\":true},\"items_chest:society\":{\"boss\":true},\"change_permissions_grade\":{\"boss\":true},\"remove_weapon_chest_society\":{\"boss\":true},\"open_boss\":{\"boss\":true},\"rename_grade\":{\"boss\":true},\"withdraw_money_society\":{\"boss\":true},\"manage_grades\":{\"boss\":true},\"editClothes\":{\"boss\":true},\"remove_item_chest_society\":{\"boss\":true},\"items_chest\":{\"boss\":true},\"recruit_player\":{\"boss\":true},\"deposit_weapon_chest_society\":{\"boss\":true},\"deposit_cash_coffre\":{\"boss\":true},\"weapons_chest\":{\"boss\":true},\"change_salary_grade\":{\"boss\":true},\"demote_player\":{\"boss\":true},\"remove_item_chest\":{\"boss\":true},\"unmote_player\":{\"boss\":true},\"deposit_black_money_coffre\":{\"boss\":true},\"change_number_grade\":{\"boss\":true},\"withdraw_black_money_coffre\":{\"boss\":true},\"deposit_money_society\":{\"boss\":true},\"weapons_chest_society\":{\"boss\":true},\"chest\":{\"boss\":true},\"rename_label_grade\":{\"boss\":true},\"deposit_item_chest\":{\"boss\":true},\"withdraw_cash_coffre\":{\"boss\":true},\"create_grade\":{\"boss\":true},\"delete_grade\":{\"boss\":true},\"manage_employeds\":{\"boss\":true},\"open_coffre\":{\"boss\":true},\"remove_weapon_chest\":{\"boss\":true}}', '{\"x\":-40.55442428588867,\"y\":-1751.7152099609376,\"z\":29.42101097106933}', '{\"x\":-43.83893585205078,\"y\":-1749.273193359375,\"z\":29.42101669311523}', '{\"position\":{\"x\":-49.525199890137,\"y\":-1756.1180419922,\"z\":29.420993804932},\"active\":true,\"sprite\":52,\"color\":69}', '1', 1, '[{\"data\":{\"bodyb_2\":10,\"chin_4\":0,\"cheeks_3\":0,\"dad\":9,\"nose_5\":0,\"chest_2\":0,\"makeup_1\":0,\"eyebrows_5\":0,\"makeup_2\":0,\"face_md_weight\":50,\"mom\":21,\"blush_3\":0,\"sun_2\":0,\"cheeks_1\":0,\"decals_1\":0,\"shoes_1\":290,\"ears_1\":-1,\"arms\":4,\"complexion_1\":0,\"watches_1\":67,\"pants_2\":10,\"lipstick_2\":0,\"jaw_2\":0,\"bags_1\":0,\"blemishes_1\":0,\"pants_1\":321,\"ears_2\":0,\"age_2\":0,\"nose_3\":0,\"blemishes_2\":0,\"skin_md_weight\":50,\"bproof_2\":0,\"chin_3\":0,\"bags_2\":0,\"torso_1\":831,\"makeup_3\":0,\"shoes_2\":0,\"chin_1\":0,\"lipstick_3\":0,\"lipstick_1\":0,\"bracelets_1\":-1,\"nose_1\":0,\"beard_3\":0,\"blush_2\":0,\"tshirt_2\":0,\"nose_6\":0,\"tshirt_1\":299,\"complexion_2\":0,\"sex\":0,\"eyebrows_6\":0,\"eyebrows_4\":0,\"arms_2\":0,\"chain_2\":0,\"eyebrows_1\":30,\"helmet_2\":0,\"eyebrows_3\":0,\"bproof_1\":0,\"glasses_2\":0,\"makeup_4\":0,\"hair_color_1\":0,\"beard_1\":3,\"neck_thickness\":0,\"moles_2\":0,\"beard_2\":10,\"mask_1\":0,\"bracelets_2\":0,\"bodyb_3\":-1,\"hair_1\":120,\"decals_2\":0,\"age_1\":0,\"moles_1\":0,\"blush_1\":0,\"nose_4\":0,\"chin_2\":0,\"bodyb_4\":0,\"eye_squint\":0,\"mask_2\":0,\"torso_2\":9,\"hair_2\":0,\"eye_color\":0,\"chest_1\":0,\"glasses_1\":0,\"sun_1\":0,\"cheeks_2\":0,\"bodyb_1\":-1,\"watches_2\":0,\"nose_2\":0,\"hair_color_2\":0,\"chest_3\":0,\"lipstick_4\":0,\"chain_1\":-1,\"helmet_1\":-1,\"lip_thickness\":0,\"jaw_1\":10,\"beard_4\":0,\"eyebrows_2\":10},\"name\":\"LTD\",\"grade\":false,\"grades\":[]},{\"data\":{\"bodyb_2\":10,\"chin_4\":0,\"cheeks_3\":0,\"dad\":9,\"nose_5\":0,\"chest_2\":0,\"makeup_1\":0,\"eyebrows_5\":0,\"makeup_2\":0,\"face_md_weight\":50,\"mom\":21,\"blush_3\":0,\"sun_2\":0,\"cheeks_1\":0,\"decals_1\":0,\"shoes_1\":290,\"ears_1\":-1,\"arms\":4,\"complexion_1\":0,\"watches_1\":67,\"pants_2\":10,\"lipstick_2\":0,\"jaw_2\":0,\"bags_1\":0,\"blemishes_1\":0,\"pants_1\":321,\"ears_2\":0,\"age_2\":0,\"nose_3\":0,\"blemishes_2\":0,\"skin_md_weight\":50,\"bproof_2\":0,\"chin_3\":0,\"bags_2\":0,\"torso_1\":831,\"makeup_3\":0,\"shoes_2\":0,\"chin_1\":0,\"lipstick_3\":0,\"lipstick_1\":0,\"bracelets_1\":-1,\"nose_1\":0,\"beard_3\":0,\"blush_2\":0,\"tshirt_2\":0,\"nose_6\":0,\"tshirt_1\":299,\"complexion_2\":0,\"sex\":0,\"eyebrows_6\":0,\"eyebrows_4\":0,\"arms_2\":0,\"chain_2\":0,\"eyebrows_1\":30,\"helmet_2\":0,\"eyebrows_3\":0,\"bproof_1\":0,\"glasses_2\":0,\"makeup_4\":0,\"hair_color_1\":0,\"beard_1\":3,\"neck_thickness\":0,\"moles_2\":0,\"beard_2\":10,\"mask_1\":0,\"bracelets_2\":0,\"bodyb_3\":-1,\"hair_1\":120,\"decals_2\":0,\"age_1\":0,\"moles_1\":0,\"blush_1\":0,\"nose_4\":0,\"chin_2\":0,\"bodyb_4\":0,\"eye_squint\":0,\"mask_2\":0,\"torso_2\":9,\"hair_2\":0,\"eye_color\":0,\"chest_1\":0,\"glasses_1\":0,\"sun_1\":0,\"cheeks_2\":0,\"bodyb_1\":-1,\"watches_2\":0,\"nose_2\":0,\"hair_color_2\":0,\"chest_3\":0,\"lipstick_4\":0,\"chain_1\":-1,\"helmet_1\":99,\"lip_thickness\":0,\"jaw_1\":10,\"beard_4\":0,\"eyebrows_2\":10},\"name\":\"LTD NOEL\",\"grade\":false,\"grades\":[]}]', '{\"x\":-47.82780075073242,\"y\":-1759.3521728515626,\"z\":29.42099571228027}'),
(57, 'ambulancesandy', 'Ambulance Sandy', '{\"weapons_boss\":[],\"items\":[],\"accounts\":{\"black_money\":0,\"society\":15000,\"cash\":0},\"weapons\":[],\"items_boss\":[]}', '{\"deposit_item_chest\":{\"boss\":true},\"deposit_black_money_coffre\":{\"boss\":true},\"items_chest\":{\"boss\":true},\"change_number_grade\":{\"boss\":true},\"remove_item_chest\":{\"boss\":true},\"promote_player\":{\"boss\":true},\"change_permissions_grade\":{\"boss\":true},\"deposit_weapon_chest_society\":{\"boss\":true},\"recruit_player\":{\"boss\":true},\"open_coffre\":{\"boss\":true},\"deposit_weapon_chest\":{\"boss\":true},\"withdraw_black_money_coffre\":{\"boss\":true},\"change_salary_grade\":{\"boss\":true},\"items_chest:society\":{\"boss\":true},\"remove_weapon_chest_society\":{\"boss\":true},\"manage_employeds\":{\"boss\":true},\"remove_weapon_chest\":{\"boss\":true},\"rename_grade\":{\"boss\":true},\"editClothes\":{\"boss\":true},\"rename_label_grade\":{\"boss\":true},\"withdraw_cash_coffre\":{\"boss\":true},\"manage_grades\":{\"boss\":true},\"deposit_money_society\":{\"boss\":true},\"open_boss\":{\"boss\":true},\"dposit_item_chest_society\":{\"boss\":true},\"weapons_chest_society\":{\"boss\":true},\"deposit_cash_coffre\":{\"boss\":true},\"chest\":{\"boss\":true},\"weapons_chest\":{\"boss\":true},\"demote_player\":{\"boss\":true},\"withdraw_money_society\":{\"boss\":true},\"delete_grade\":{\"boss\":true},\"remove_item_chest_society\":{\"boss\":true},\"unmote_player\":{\"boss\":true},\"create_grade\":{\"boss\":true}}', '{\"x\":1768.4810791015626,\"y\":3643.358154296875,\"z\":34.85253524780273}', '{\"x\":1784.179931640625,\"y\":3658.7099609375,\"z\":34.8525276184082}', '{\"active\":true,\"color\":2,\"position\":{\"x\":1985.743652,\"y\":3762.457764,\"z\":32.603275},\"sprite\":61}', '1', 1, '[]', '{\"x\":1784.9034423828126,\"y\":3652.426513671875,\"z\":34.85258102416992}');
INSERT INTO `society_data` (`id`, `name`, `label`, `coffre`, `permissions`, `posCoffre`, `posBoss`, `blips`, `tax`, `cloakroom`, `clothes`, `cloakpos`) VALUES
(58, 'saspn', 'BCSO Sandy', '{\"weapons_boss\":{\"WEAPON_FLASHLIGHT51\":{\"ammo\":255,\"label\":\"Lampe torche\",\"number\":51,\"name\":\"WEAPON_FLASHLIGHT\"},\"WEAPON_NIGHTSTICK40\":{\"ammo\":255,\"label\":\"Matraque\",\"number\":40,\"name\":\"WEAPON_NIGHTSTICK\"},\"WEAPON_FLASHLIGHT47\":{\"ammo\":255,\"label\":\"Lampe torche\",\"number\":47,\"name\":\"WEAPON_FLASHLIGHT\"},\"WEAPON_FLASHLIGHT43\":{\"ammo\":255,\"label\":\"Lampe torche\",\"number\":43,\"name\":\"WEAPON_FLASHLIGHT\"},\"WEAPON_FLASHLIGHT44\":{\"ammo\":255,\"label\":\"Lampe torche\",\"number\":44,\"name\":\"WEAPON_FLASHLIGHT\"},\"WEAPON_FLASHLIGHT27\":{\"ammo\":255,\"label\":\"Lampe torche\",\"number\":27,\"name\":\"WEAPON_FLASHLIGHT\"},\"WEAPON_FLASHLIGHT50\":{\"ammo\":255,\"label\":\"Lampe torche\",\"number\":50,\"name\":\"WEAPON_FLASHLIGHT\"}},\"accounts\":{\"cash\":0,\"black_money\":3633,\"society\":1930155.0},\"weapons\":[],\"items_boss\":{\"nightstick\":{\"count\":1,\"name\":\"nightstick\",\"label\":\"Matraque\"},\"bullpupshotgun\":{\"count\":1,\"name\":\"bullpupshotgun\",\"label\":\"Fusil Bullpup\"},\"shotgun_ammo\":{\"count\":196,\"name\":\"shotgun_ammo\",\"label\":\"Munitions pour fusil à pompe\"},\"pistol_ammo\":{\"count\":16,\"name\":\"pistol_ammo\",\"label\":\"Munitions pour pistolet\"},\"9mm\":{\"count\":160,\"name\":\"9mm\",\"label\":\"9mm Munition\"},\"combatpistolpol\":{\"count\":1,\"name\":\"combatpistolpol\",\"label\":\"Combat Pistol Police\"},\"lapin\":{\"count\":13,\"name\":\"lapin\",\"label\":\"Lapin\"},\"762mm\":{\"count\":468,\"name\":\"762mm\",\"label\":\"7.62mm Munition\"},\"burgershot_burger\":{\"count\":10,\"name\":\"burgershot_burger\",\"label\":\"Burger\"},\"burgershot_coca\":{\"count\":14,\"name\":\"burgershot_coca\",\"label\":\"Coca Cola\"},\"smg_ammo\":{\"count\":15,\"name\":\"smg_ammo\",\"label\":\"Munitions pour mitraillette\"},\"rifle_ammo\":{\"count\":2112,\"name\":\"rifle_ammo\",\"label\":\"Munitions pour fusil\"},\"flashlight\":{\"count\":1,\"name\":\"flashlight\",\"label\":\"Lampe torche\"},\"mg_ammo\":{\"count\":200,\"name\":\"mg_ammo\",\"label\":\"Munitions pour mitrailleuse\"},\"556mm\":{\"count\":180,\"name\":\"556mm\",\"label\":\"5.56mm Munition\"},\"hack_laptop\":{\"count\":1,\"name\":\"hack_laptop\",\"label\":\"Ordinateur Portable\"},\"12gauge\":{\"count\":153,\"name\":\"12gauge\",\"label\":\"12mm Munition\"},\"sniper_ammo\":{\"count\":388,\"name\":\"sniper_ammo\",\"label\":\"Munitions pour sniper\"},\"cerf\":{\"count\":3,\"name\":\"cerf\",\"label\":\"Cerf\"},\"smg\":{\"count\":1,\"name\":\"smg\",\"label\":\"Mitraillette MP5\"},\"hack_phone\":{\"count\":1,\"name\":\"hack_phone\",\"label\":\"Téléphone Jailbreak\"},\"assaultsmg\":{\"count\":2,\"name\":\"assaultsmg\",\"label\":\"P90\"},\"kevlar\":{\"count\":5,\"name\":\"kevlar\",\"label\":\"Kevlar\"}},\"items\":{\"coca_blend\":{\"count\":1,\"name\":\"coca_blend\",\"label\":\"Mélange de coca\"},\"heavypistol\":{\"count\":1,\"name\":\"heavypistol\",\"label\":\"Pistolet lourd\"},\"combatpistol\":{\"count\":1,\"name\":\"combatpistol\",\"label\":\"Glock 17\"},\"kq_ammonia\":{\"count\":4,\"name\":\"kq_ammonia\",\"label\":\"Ammoniaque\"}}}', '{\"manage_employeds\":{\"grades\":{\"boss\":true},\"lieutenant\":[],\"boss\":true,\"Commander\":true,\"Under Sheriff\":[],\"label\":\"Gérer les employés de la société\"},\"rename_grade\":{\"grades\":{\"boss\":true},\"lieutenant\":[],\"boss\":true,\"Commander\":true,\"Under Sheriff\":[],\"label\":\"Changer le nom d\'un grade\"},\"deposit_weapon_chest\":{\"grades\":{\"boss\":true},\"lieutenant\":[],\"boss\":true,\"Commander\":true,\"Under Sheriff\":[],\"label\":\"Déposer une arme dans le coffre\"},\"items_chest:society\":{\"grades\":{\"boss\":true},\"lieutenant\":[],\"boss\":true,\"Commander\":true,\"Under Sheriff\":[],\"label\":\"Item(s) du coffre de la société\"},\"remove_weapon_chest\":{\"grades\":{\"boss\":true},\"lieutenant\":[],\"boss\":true,\"Commander\":true,\"Under Sheriff\":[],\"label\":\"Retirer une arme dans le coffre\"},\"change_salary_grade\":{\"grades\":{\"boss\":true},\"lieutenant\":[],\"boss\":true,\"Commander\":true,\"Under Sheriff\":[],\"label\":\"Changer le salaire d\'un grade\"},\"deposit_cash_coffre\":{\"grades\":{\"boss\":true},\"lieutenant\":[],\"boss\":true,\"Commander\":true,\"Under Sheriff\":[],\"label\":\"Déposer de l\'argent dans le coffre\"},\"create_grade\":{\"grades\":{\"boss\":true},\"lieutenant\":[],\"boss\":true,\"Commander\":true,\"Under Sheriff\":[],\"label\":\"Créer un grade\"},\"open_boss\":{\"grades\":{\"boss\":true},\"lieutenant\":[],\"boss\":true,\"Commander\":true,\"Under Sheriff\":[],\"label\":\"Ouvrir le menu boss\"},\"deposit_weapon_chest_society\":{\"grades\":{\"boss\":true},\"lieutenant\":[],\"boss\":true,\"Commander\":true,\"Under Sheriff\":[],\"label\":\"Déposer une arme dans le coffre de la société\"},\"change_permissions_grade\":{\"grades\":{\"boss\":true},\"lieutenant\":[],\"boss\":true,\"Commander\":true,\"Under Sheriff\":[],\"label\":\"Changer les permissions d\'un grade\"},\"deposit_black_money_coffre\":{\"grades\":{\"boss\":true},\"lieutenant\":[],\"boss\":true,\"Commander\":true,\"Under Sheriff\":[],\"label\":\"Déposer de l\'argent sale dans le coffre\"},\"manage_grades\":{\"grades\":{\"boss\":true},\"lieutenant\":[],\"boss\":true,\"Commander\":true,\"Under Sheriff\":[],\"label\":\"Gérer les grades de la société\"},\"withdraw_black_money_coffre\":{\"grades\":{\"boss\":true},\"lieutenant\":[],\"boss\":true,\"Commander\":true,\"Under Sheriff\":[],\"label\":\"Retirer de l\'argent sale dans le coffre\"},\"remove_item_chest_society\":{\"grades\":{\"boss\":true},\"lieutenant\":[],\"boss\":true,\"Commander\":true,\"Under Sheriff\":[],\"label\":\"Retirer un item dans le coffre de la société\"},\"withdraw_cash_coffre\":{\"grades\":{\"boss\":true},\"lieutenant\":[],\"boss\":true,\"Commander\":true,\"Under Sheriff\":[],\"label\":\"Retirer de l\'argent dans le coffre\"},\"chest\":{\"grades\":{\"boss\":true},\"lieutenant\":[],\"boss\":true,\"Commander\":true,\"Under Sheriff\":[],\"label\":\"Accéder au coffre de la société\"},\"change_number_grade\":{\"grades\":{\"boss\":true},\"lieutenant\":[],\"boss\":true,\"Commander\":true,\"Under Sheriff\":[],\"label\":\"Changer le numéro d\'un grade\"},\"weapons_chest\":{\"grades\":{\"boss\":true},\"lieutenant\":[],\"boss\":true,\"Commander\":true,\"Under Sheriff\":[],\"label\":\"Armes du coffre\"},\"items_chest\":{\"grades\":{\"boss\":true},\"lieutenant\":[],\"boss\":true,\"Commander\":true,\"Under Sheriff\":[],\"label\":\"Items du coffre\"},\"promote_player\":{\"grades\":{\"boss\":true},\"lieutenant\":[],\"boss\":true,\"Commander\":true,\"Under Sheriff\":true,\"label\":\"Augmenter un employé\"},\"dposit_item_chest_society\":{\"grades\":{\"boss\":true},\"lieutenant\":[],\"boss\":true,\"Commander\":true,\"Under Sheriff\":[],\"label\":\"Déposer un item dans le coffre de la société\"},\"rename_label_grade\":{\"grades\":{\"boss\":true},\"lieutenant\":[],\"boss\":true,\"Commander\":true,\"Under Sheriff\":[],\"label\":\"Changer le label d\'un grade\"},\"unmote_player\":{\"grades\":{\"boss\":true},\"lieutenant\":[],\"boss\":true,\"Commander\":true,\"Under Sheriff\":true,\"label\":\"Descendre un employé\"},\"deposit_item_chest\":{\"grades\":{\"boss\":true},\"lieutenant\":[],\"boss\":true,\"Commander\":true,\"Under Sheriff\":[],\"label\":\"Déposer un item dans le coffre\"},\"recruit_player\":{\"grades\":{\"boss\":true},\"lieutenant\":[],\"boss\":true,\"Commander\":true,\"Under Sheriff\":[],\"label\":\"Recruté un joueur\"},\"withdraw_money_society\":{\"grades\":{\"boss\":true},\"lieutenant\":[],\"boss\":true,\"Commander\":true,\"Under Sheriff\":[],\"label\":\"Retirer de l\'argent dans le coffre de la société\"},\"demote_player\":{\"grades\":{\"boss\":true},\"lieutenant\":[],\"boss\":true,\"Commander\":true,\"Under Sheriff\":[],\"label\":\"Virer un employé\"},\"remove_weapon_chest_society\":{\"grades\":{\"boss\":true},\"lieutenant\":[],\"boss\":true,\"Commander\":true,\"Under Sheriff\":[],\"label\":\"Retirer une arme dans la coffre de la société\"},\"open_coffre\":{\"grades\":{\"boss\":true},\"lieutenant\":[],\"boss\":true,\"Commander\":true,\"Under Sheriff\":[],\"label\":\"Ouvrir le coffre\"},\"deposit_money_society\":{\"grades\":{\"boss\":true},\"lieutenant\":[],\"boss\":true,\"Commander\":true,\"Under Sheriff\":[],\"label\":\"Déposer de l\'argent dans le coffre de la société\"},\"editClothes\":{\"grades\":{\"boss\":true},\"lieutenant\":[],\"boss\":true,\"Commander\":true,\"Under Sheriff\":[],\"label\":\"Gérer les tenues dans le vestiaire\"},\"weapons_chest_society\":{\"grades\":{\"boss\":true},\"lieutenant\":[],\"boss\":true,\"Commander\":true,\"Under Sheriff\":[],\"label\":\"Arme(s) du coffre de la société\"},\"remove_item_chest\":{\"grades\":{\"boss\":true},\"lieutenant\":[],\"boss\":true,\"Commander\":true,\"Under Sheriff\":[],\"label\":\"Retirer un item dans le coffre\"},\"delete_grade\":{\"grades\":{\"boss\":true},\"lieutenant\":[],\"boss\":true,\"Commander\":true,\"Under Sheriff\":[],\"label\":\"Supprimer un grade\"}}', '{\"x\":1703.9688720703126,\"y\":3874.3505859375,\"z\":31.45193099975586}', '{\"x\":1736.8114013671876,\"y\":3897.229248046875,\"z\":39.78068161010742}', '{\"color\":47,\"position\":{\"x\":1709.5550537109376,\"z\":35.01941680908203,\"y\":3868.821533203125},\"sprite\":60,\"active\":true}', '0', 1, '[{\"grade\":true,\"name\":\"Trainee\",\"grades\":{\"cadet\":\"cadet\"},\"data\":{\"eyebrows_1\":0,\"glasses_1\":0,\"lipstick_1\":0,\"blush_1\":0,\"bodyb_4\":0,\"glasses_2\":0,\"beard_4\":0,\"makeup_2\":0,\"ears_1\":-1,\"face_color\":0,\"dad\":37,\"hair_color_2\":29,\"eyebrows_6\":0,\"eye_squint\":0,\"nose_5\":0,\"tshirt_2\":0,\"age_1\":0,\"sun_1\":0,\"mask_2\":0,\"makeup_4\":0,\"helmet_1\":306,\"blemishes_2\":0,\"chest_2\":0,\"jaw_2\":0,\"torso_1\":902,\"bodyb_2\":0,\"age_2\":0,\"eye_color\":0,\"skin_md_weight\":50,\"chin_2\":0,\"chin_1\":0,\"mom\":33,\"lip_thickness\":0,\"jaw_1\":0,\"arms_2\":0,\"bproof_2\":0,\"neck_thickness\":0,\"bodyb_1\":-1,\"blush_2\":0,\"blemishes_1\":0,\"moles_2\":0,\"cheeks_2\":0,\"watches_1\":-1,\"cheeks_3\":0,\"decals_2\":0,\"nose_6\":0,\"arms\":22,\"mask_1\":0,\"chest_1\":0,\"lipstick_2\":0,\"makeup_3\":0,\"complexion_2\":0,\"shoes_1\":25,\"blush_3\":0,\"beard_3\":0,\"torso_2\":0,\"nose_3\":0,\"hair_2\":0,\"chin_4\":0,\"tshirt_1\":284,\"makeup_1\":0,\"hair_1\":79,\"cheeks_1\":0,\"bracelets_2\":0,\"watches_2\":0,\"face_md_weight\":0,\"bracelets_1\":-1,\"pants_2\":6,\"chain_1\":194,\"complexion_1\":0,\"eyebrows_4\":0,\"chain_2\":0,\"nose_4\":0,\"sex\":0,\"lipstick_3\":0,\"bproof_1\":10,\"nose_2\":0,\"eyebrows_2\":10,\"chest_3\":0,\"bodyb_3\":-1,\"nose_1\":0,\"bags_1\":191,\"eyebrows_3\":0,\"ears_2\":0,\"chin_3\":0,\"eyebrows_5\":0,\"moles_1\":0,\"lipstick_4\":0,\"sun_2\":0,\"helmet_2\":1,\"bags_2\":0,\"shoes_2\":0,\"beard_2\":0,\"beard_1\":0,\"hair_color_1\":0,\"pants_1\":341,\"decals_1\":0}},{\"grade\":true,\"name\":\"V.I.R\",\"grades\":{\"officier2\":\"officier2\",\"boss\":\"boss\",\"sergent2\":\"sergent2\",\"officier3\":\"officier3\",\"capitaine\":\"capitaine\",\"lieutenant\":\"lieutenant\",\"Commander\":\"Commander\",\"sergent1\":\"sergent1\",\"officier1\":\"officier1\",\"Under Sheriff\":\"Under Sheriff\",\"officierprincipal \":\"officierprincipal \",\"cadet\":\"cadet\"},\"data\":{\"eyebrows_1\":33,\"glasses_1\":4,\"lipstick_1\":0,\"blush_1\":0,\"bodyb_4\":0,\"glasses_2\":0,\"beard_4\":0,\"makeup_2\":0,\"ears_1\":-1,\"face_color\":0,\"dad\":21,\"hair_color_2\":0,\"eyebrows_6\":0,\"eye_squint\":0,\"nose_5\":0,\"tshirt_2\":0,\"age_1\":0,\"sun_1\":0,\"mask_2\":0,\"makeup_3\":0,\"helmet_1\":13,\"blemishes_2\":0,\"chest_2\":0,\"jaw_2\":0,\"torso_1\":897,\"bodyb_2\":0,\"age_2\":0,\"eye_color\":0,\"skin_md_weight\":50,\"chin_2\":0,\"chin_1\":0,\"mom\":0,\"lip_thickness\":3,\"jaw_1\":7,\"arms_2\":0,\"bproof_2\":0,\"neck_thickness\":0,\"bodyb_1\":0,\"blush_2\":0,\"bags_2\":0,\"moles_2\":0,\"hair_color_1\":0,\"watches_1\":3,\"cheeks_3\":0,\"decals_2\":0,\"eyebrows_5\":0,\"arms\":33,\"mask_1\":0,\"chest_1\":0,\"lipstick_2\":0,\"nose_1\":1,\"complexion_2\":0,\"shoes_1\":24,\"blush_3\":0,\"nose_6\":0,\"torso_2\":6,\"nose_3\":0,\"cheeks_2\":0,\"chin_4\":0,\"tshirt_1\":288,\"makeup_1\":0,\"hair_1\":45,\"cheeks_1\":0,\"bracelets_2\":0,\"watches_2\":0,\"face_md_weight\":0,\"bracelets_1\":-1,\"pants_2\":0,\"makeup_4\":0,\"complexion_1\":0,\"eyebrows_4\":0,\"chain_2\":0,\"nose_4\":0,\"sex\":0,\"lipstick_3\":0,\"beard_3\":0,\"nose_2\":0,\"bags_1\":0,\"chest_3\":0,\"bodyb_3\":-1,\"chin_3\":0,\"hair_2\":0,\"eyebrows_3\":0,\"ears_2\":0,\"bproof_1\":80,\"moles_1\":0,\"lipstick_4\":0,\"beard_1\":11,\"sun_2\":0,\"helmet_2\":0,\"blemishes_1\":0,\"shoes_2\":0,\"beard_2\":10,\"chain_1\":219,\"eyebrows_2\":10,\"pants_1\":31,\"decals_1\":0}},{\"grade\":true,\"name\":\"Supervisor\",\"grades\":{\"capitaine\":\"capitaine\",\"Under Sheriff\":\"Under Sheriff\",\"Commander\":\"Commander\",\"boss\":\"boss\",\"sergent2\":\"sergent2\",\"lieutenant\":\"lieutenant\",\"sergent1\":\"sergent1\"},\"data\":{\"eyebrows_1\":33,\"glasses_1\":4,\"lipstick_1\":0,\"blush_1\":0,\"bodyb_4\":0,\"glasses_2\":0,\"beard_4\":0,\"makeup_2\":0,\"ears_1\":-1,\"face_color\":0,\"dad\":21,\"hair_color_2\":0,\"eyebrows_6\":0,\"eye_squint\":0,\"nose_5\":0,\"tshirt_2\":0,\"age_1\":0,\"sun_1\":0,\"mask_2\":0,\"makeup_3\":0,\"helmet_1\":286,\"blemishes_2\":0,\"chest_2\":0,\"jaw_2\":0,\"torso_1\":902,\"bodyb_2\":0,\"age_2\":0,\"eye_color\":0,\"skin_md_weight\":50,\"chin_2\":0,\"chin_1\":0,\"mom\":0,\"lip_thickness\":3,\"jaw_1\":7,\"arms_2\":0,\"bproof_2\":0,\"neck_thickness\":0,\"bodyb_1\":0,\"blush_2\":0,\"bags_2\":0,\"moles_2\":0,\"hair_color_1\":0,\"watches_1\":3,\"cheeks_3\":0,\"decals_2\":0,\"eyebrows_5\":0,\"arms\":27,\"mask_1\":0,\"chest_1\":0,\"lipstick_2\":0,\"nose_1\":1,\"complexion_2\":0,\"shoes_1\":25,\"blush_3\":0,\"nose_6\":0,\"torso_2\":0,\"nose_3\":0,\"cheeks_2\":0,\"chin_4\":0,\"tshirt_1\":288,\"makeup_1\":0,\"hair_1\":45,\"cheeks_1\":0,\"bracelets_2\":0,\"watches_2\":0,\"face_md_weight\":0,\"bracelets_1\":-1,\"pants_2\":0,\"makeup_4\":0,\"complexion_1\":0,\"eyebrows_4\":0,\"chain_2\":0,\"nose_4\":0,\"sex\":0,\"lipstick_3\":0,\"beard_3\":0,\"nose_2\":0,\"bags_1\":0,\"chest_3\":0,\"bodyb_3\":-1,\"chin_3\":0,\"hair_2\":0,\"eyebrows_3\":0,\"ears_2\":0,\"bproof_1\":115,\"moles_1\":0,\"lipstick_4\":0,\"beard_1\":11,\"sun_2\":0,\"helmet_2\":0,\"blemishes_1\":0,\"shoes_2\":0,\"beard_2\":10,\"chain_1\":194,\"eyebrows_2\":10,\"pants_1\":49,\"decals_1\":0}},{\"grade\":true,\"name\":\"Corp de Commandemant\",\"grades\":{\"capitaine\":\"capitaine\",\"Under Sheriff\":\"Under Sheriff\",\"Commander\":\"Commander\",\"boss\":\"boss\",\"lieutenant\":\"lieutenant\"},\"data\":{\"eyebrows_1\":33,\"glasses_1\":4,\"lipstick_1\":0,\"blush_1\":0,\"bodyb_4\":0,\"glasses_2\":0,\"beard_4\":0,\"makeup_2\":0,\"ears_1\":-1,\"face_color\":0,\"dad\":21,\"hair_color_2\":0,\"eyebrows_6\":0,\"eye_squint\":0,\"nose_5\":0,\"tshirt_2\":0,\"age_1\":0,\"sun_1\":0,\"mask_2\":0,\"makeup_3\":0,\"helmet_1\":13,\"blemishes_2\":0,\"chest_2\":0,\"jaw_2\":0,\"torso_1\":902,\"bodyb_2\":0,\"age_2\":0,\"eye_color\":0,\"skin_md_weight\":50,\"chin_2\":0,\"chin_1\":0,\"mom\":0,\"lip_thickness\":3,\"jaw_1\":7,\"arms_2\":0,\"bproof_2\":0,\"neck_thickness\":0,\"bodyb_1\":0,\"blush_2\":0,\"bags_2\":0,\"moles_2\":0,\"hair_color_1\":0,\"watches_1\":3,\"cheeks_3\":0,\"decals_2\":0,\"eyebrows_5\":0,\"arms\":27,\"mask_1\":0,\"chest_1\":0,\"lipstick_2\":0,\"nose_1\":1,\"complexion_2\":0,\"shoes_1\":25,\"blush_3\":0,\"nose_6\":0,\"torso_2\":0,\"nose_3\":0,\"cheeks_2\":0,\"chin_4\":0,\"tshirt_1\":288,\"makeup_1\":0,\"hair_1\":45,\"cheeks_1\":0,\"bracelets_2\":0,\"watches_2\":0,\"face_md_weight\":0,\"bracelets_1\":-1,\"pants_2\":0,\"makeup_4\":0,\"complexion_1\":0,\"eyebrows_4\":0,\"chain_2\":0,\"nose_4\":0,\"sex\":0,\"lipstick_3\":0,\"beard_3\":0,\"nose_2\":0,\"bags_1\":0,\"chest_3\":0,\"bodyb_3\":-1,\"chin_3\":0,\"hair_2\":0,\"eyebrows_3\":0,\"ears_2\":0,\"bproof_1\":115,\"moles_1\":0,\"lipstick_4\":0,\"beard_1\":11,\"sun_2\":0,\"helmet_2\":0,\"blemishes_1\":0,\"shoes_2\":0,\"beard_2\":10,\"chain_1\":194,\"eyebrows_2\":10,\"pants_1\":49,\"decals_1\":0}},{\"grade\":true,\"name\":\"Etat Major\",\"grades\":{\"boss\":\"boss\",\"Under Sheriff\":\"Under Sheriff\",\"Commander\":\"Commander\"},\"data\":{\"eyebrows_1\":33,\"glasses_1\":4,\"lipstick_1\":0,\"blush_1\":0,\"bodyb_4\":0,\"glasses_2\":0,\"beard_4\":0,\"makeup_2\":0,\"ears_1\":-1,\"face_color\":0,\"dad\":21,\"hair_color_2\":0,\"eyebrows_6\":0,\"eye_squint\":0,\"nose_5\":0,\"tshirt_2\":0,\"age_1\":0,\"sun_1\":0,\"mask_2\":0,\"makeup_3\":0,\"helmet_1\":13,\"blemishes_2\":0,\"chest_2\":0,\"jaw_2\":0,\"torso_1\":902,\"bodyb_2\":0,\"age_2\":0,\"eye_color\":0,\"skin_md_weight\":50,\"chin_2\":0,\"chin_1\":0,\"mom\":0,\"lip_thickness\":3,\"jaw_1\":7,\"arms_2\":0,\"bproof_2\":0,\"neck_thickness\":0,\"bodyb_1\":0,\"blush_2\":0,\"bags_2\":0,\"moles_2\":0,\"hair_color_1\":0,\"watches_1\":3,\"cheeks_3\":0,\"decals_2\":0,\"eyebrows_5\":0,\"arms\":82,\"mask_1\":0,\"chest_1\":0,\"lipstick_2\":0,\"nose_1\":1,\"complexion_2\":0,\"shoes_1\":25,\"blush_3\":0,\"nose_6\":0,\"torso_2\":0,\"nose_3\":0,\"cheeks_2\":0,\"chin_4\":0,\"tshirt_1\":288,\"makeup_1\":0,\"hair_1\":45,\"cheeks_1\":0,\"bracelets_2\":0,\"watches_2\":0,\"face_md_weight\":0,\"bracelets_1\":-1,\"pants_2\":0,\"makeup_4\":0,\"complexion_1\":0,\"eyebrows_4\":0,\"chain_2\":0,\"nose_4\":0,\"sex\":0,\"lipstick_3\":0,\"beard_3\":0,\"nose_2\":0,\"bags_1\":0,\"chest_3\":0,\"bodyb_3\":-1,\"chin_3\":0,\"hair_2\":0,\"eyebrows_3\":0,\"ears_2\":0,\"bproof_1\":0,\"moles_1\":0,\"lipstick_4\":0,\"beard_1\":11,\"sun_2\":0,\"helmet_2\":0,\"blemishes_1\":0,\"shoes_2\":0,\"beard_2\":10,\"chain_1\":194,\"eyebrows_2\":10,\"pants_1\":25,\"decals_1\":0}},{\"grade\":true,\"name\":\"Ceremonie\",\"grades\":{\"officier2\":\"officier2\",\"boss\":\"boss\",\"sergent2\":\"sergent2\",\"officier3\":\"officier3\",\"capitaine\":\"capitaine\",\"lieutenant\":\"lieutenant\",\"Commander\":\"Commander\",\"sergent1\":\"sergent1\",\"officier1\":\"officier1\",\"Under Sheriff\":\"Under Sheriff\",\"officierprincipal \":\"officierprincipal \",\"cadet\":\"cadet\"},\"data\":{\"eyebrows_1\":33,\"glasses_1\":4,\"lipstick_1\":0,\"blush_1\":0,\"bodyb_4\":0,\"glasses_2\":0,\"beard_4\":0,\"makeup_2\":0,\"ears_1\":-1,\"face_color\":0,\"dad\":21,\"hair_color_2\":0,\"eyebrows_6\":0,\"eye_squint\":0,\"nose_5\":0,\"tshirt_2\":0,\"age_1\":0,\"sun_1\":0,\"mask_2\":0,\"makeup_3\":0,\"helmet_1\":13,\"blemishes_2\":0,\"chest_2\":0,\"jaw_2\":0,\"torso_1\":902,\"bodyb_2\":0,\"age_2\":0,\"eye_color\":0,\"skin_md_weight\":50,\"chin_2\":0,\"chin_1\":0,\"mom\":0,\"lip_thickness\":3,\"jaw_1\":7,\"arms_2\":0,\"bproof_2\":0,\"neck_thickness\":0,\"bodyb_1\":0,\"blush_2\":0,\"bags_2\":0,\"moles_2\":0,\"hair_color_1\":0,\"watches_1\":3,\"cheeks_3\":0,\"decals_2\":0,\"eyebrows_5\":0,\"arms\":82,\"mask_1\":0,\"chest_1\":0,\"lipstick_2\":0,\"nose_1\":1,\"complexion_2\":0,\"shoes_1\":25,\"blush_3\":0,\"nose_6\":0,\"torso_2\":0,\"nose_3\":0,\"cheeks_2\":0,\"chin_4\":0,\"tshirt_1\":288,\"makeup_1\":0,\"hair_1\":45,\"cheeks_1\":0,\"bracelets_2\":0,\"watches_2\":0,\"face_md_weight\":0,\"bracelets_1\":-1,\"pants_2\":0,\"makeup_4\":0,\"complexion_1\":0,\"eyebrows_4\":0,\"chain_2\":0,\"nose_4\":0,\"sex\":0,\"lipstick_3\":0,\"beard_3\":0,\"nose_2\":0,\"bags_1\":0,\"chest_3\":0,\"bodyb_3\":-1,\"chin_3\":0,\"hair_2\":0,\"eyebrows_3\":0,\"ears_2\":0,\"bproof_1\":0,\"moles_1\":0,\"lipstick_4\":0,\"beard_1\":11,\"sun_2\":0,\"helmet_2\":0,\"blemishes_1\":0,\"shoes_2\":0,\"beard_2\":10,\"chain_1\":194,\"eyebrows_2\":10,\"pants_1\":25,\"decals_1\":0}},{\"grade\":true,\"name\":\"Corp des Officiers\",\"grades\":{\"officier2\":\"officier2\",\"boss\":\"boss\",\"sergent2\":\"sergent2\",\"officier3\":\"officier3\",\"capitaine\":\"capitaine\",\"lieutenant\":\"lieutenant\",\"officier1\":\"officier1\",\"Under Sheriff\":\"Under Sheriff\",\"officierprincipal \":\"officierprincipal \",\"sergent1\":\"sergent1\"},\"data\":{\"eyebrows_1\":33,\"glasses_1\":4,\"lipstick_1\":0,\"blush_1\":0,\"bodyb_4\":0,\"glasses_2\":0,\"beard_4\":0,\"makeup_2\":0,\"ears_1\":-1,\"face_color\":0,\"dad\":21,\"hair_color_2\":0,\"eyebrows_6\":0,\"eye_squint\":0,\"nose_5\":0,\"tshirt_2\":0,\"age_1\":0,\"sun_1\":0,\"mask_2\":0,\"makeup_3\":0,\"helmet_1\":286,\"blemishes_2\":0,\"chest_2\":0,\"jaw_2\":0,\"torso_1\":902,\"bodyb_2\":0,\"age_2\":0,\"eye_color\":0,\"skin_md_weight\":50,\"chin_2\":0,\"chin_1\":0,\"mom\":0,\"lip_thickness\":3,\"jaw_1\":7,\"arms_2\":0,\"bproof_2\":0,\"neck_thickness\":0,\"bodyb_1\":0,\"blush_2\":0,\"bags_2\":0,\"moles_2\":0,\"hair_color_1\":0,\"watches_1\":3,\"cheeks_3\":0,\"decals_2\":0,\"eyebrows_5\":0,\"arms\":27,\"mask_1\":0,\"chest_1\":0,\"lipstick_2\":0,\"nose_1\":1,\"complexion_2\":0,\"shoes_1\":25,\"blush_3\":0,\"nose_6\":0,\"torso_2\":0,\"nose_3\":0,\"cheeks_2\":0,\"chin_4\":0,\"tshirt_1\":288,\"makeup_1\":0,\"hair_1\":45,\"cheeks_1\":0,\"bracelets_2\":0,\"watches_2\":0,\"face_md_weight\":0,\"bracelets_1\":-1,\"pants_2\":0,\"makeup_4\":0,\"complexion_1\":0,\"eyebrows_4\":0,\"chain_2\":0,\"nose_4\":0,\"sex\":0,\"lipstick_3\":0,\"beard_3\":0,\"nose_2\":0,\"bags_1\":0,\"chest_3\":0,\"bodyb_3\":-1,\"chin_3\":0,\"hair_2\":0,\"eyebrows_3\":0,\"ears_2\":0,\"bproof_1\":115,\"moles_1\":0,\"lipstick_4\":0,\"beard_1\":11,\"sun_2\":0,\"helmet_2\":0,\"blemishes_1\":0,\"shoes_2\":0,\"beard_2\":10,\"chain_1\":194,\"eyebrows_2\":10,\"pants_1\":49,\"decals_1\":0}},{\"grade\":true,\"name\":\"Trainee\",\"grades\":[],\"data\":{\"eyebrows_1\":0,\"glasses_1\":5,\"lipstick_1\":0,\"blush_1\":0,\"bodyb_4\":0,\"glasses_2\":1,\"beard_4\":0,\"makeup_2\":0,\"ears_1\":-1,\"dad\":0,\"hair_color_2\":29,\"eyebrows_6\":0,\"eye_squint\":0,\"nose_5\":0,\"tshirt_2\":0,\"age_1\":0,\"sun_1\":0,\"mask_2\":0,\"makeup_4\":0,\"helmet_1\":306,\"nose_1\":0,\"chest_2\":0,\"jaw_2\":0,\"torso_1\":193,\"bodyb_2\":0,\"age_2\":0,\"eye_color\":0,\"skin_md_weight\":50,\"chin_2\":0,\"pants_1\":341,\"mom\":7,\"lip_thickness\":0,\"jaw_1\":0,\"arms_2\":0,\"bproof_2\":0,\"neck_thickness\":0,\"bodyb_1\":-1,\"blush_2\":0,\"bags_2\":0,\"moles_2\":0,\"hair_color_1\":0,\"watches_1\":-1,\"cheeks_3\":0,\"decals_2\":0,\"makeup_3\":0,\"arms\":22,\"mask_1\":0,\"chest_1\":0,\"lipstick_2\":0,\"complexion_1\":0,\"complexion_2\":0,\"shoes_1\":25,\"blush_3\":0,\"chin_4\":0,\"torso_2\":1,\"nose_3\":0,\"tshirt_1\":284,\"bracelets_2\":0,\"bproof_1\":10,\"makeup_1\":0,\"hair_1\":79,\"cheeks_1\":0,\"face_md_weight\":50,\"watches_2\":0,\"bags_1\":191,\"bracelets_1\":-1,\"pants_2\":6,\"hair_2\":0,\"chin_1\":0,\"eyebrows_4\":0,\"chain_2\":2,\"nose_4\":0,\"sex\":0,\"lipstick_3\":0,\"beard_3\":0,\"nose_2\":0,\"eyebrows_2\":0,\"chest_3\":0,\"bodyb_3\":-1,\"chin_3\":0,\"eyebrows_5\":0,\"eyebrows_3\":0,\"ears_2\":0,\"moles_1\":0,\"blemishes_2\":0,\"beard_1\":0,\"lipstick_4\":0,\"sun_2\":0,\"blemishes_1\":0,\"helmet_2\":1,\"shoes_2\":0,\"beard_2\":0,\"chain_1\":10,\"cheeks_2\":0,\"nose_6\":0,\"decals_1\":0}},{\"grade\":true,\"name\":\"ERT Intervention\",\"data\":{\"shoes_1\":25,\"glasses_1\":5,\"lipstick_1\":0,\"blush_1\":0,\"bodyb_4\":0,\"glasses_2\":1,\"beard_4\":0,\"makeup_2\":0,\"ears_1\":-1,\"dad\":0,\"hair_color_2\":26,\"eyebrows_6\":0,\"eye_squint\":0,\"nose_5\":0,\"tshirt_2\":0,\"age_1\":0,\"sun_1\":0,\"mask_2\":13,\"makeup_3\":0,\"helmet_1\":231,\"blemishes_2\":0,\"chest_2\":0,\"jaw_2\":0,\"torso_1\":579,\"bodyb_2\":0,\"age_2\":0,\"eye_color\":0,\"skin_md_weight\":50,\"chin_2\":0,\"chin_1\":0,\"mom\":20,\"lip_thickness\":0,\"jaw_1\":0,\"arms_2\":0,\"beard_1\":0,\"neck_thickness\":0,\"bodyb_1\":-1,\"eyebrows_5\":0,\"blemishes_1\":0,\"moles_2\":0,\"cheeks_2\":0,\"watches_1\":-1,\"cheeks_3\":0,\"decals_2\":0,\"nose_1\":0,\"eyebrows_2\":0,\"watches_2\":0,\"chest_1\":0,\"lipstick_2\":0,\"arms\":179,\"complexion_2\":0,\"chain_1\":194,\"blush_3\":0,\"bags_1\":191,\"nose_6\":0,\"nose_3\":0,\"hair_2\":0,\"lipstick_4\":0,\"pants_1\":261,\"makeup_1\":0,\"hair_1\":79,\"cheeks_1\":0,\"decals_1\":0,\"mask_1\":169,\"makeup_4\":0,\"bracelets_1\":-1,\"pants_2\":1,\"bags_2\":0,\"eyebrows_4\":0,\"chin_4\":0,\"chin_3\":0,\"nose_4\":0,\"sex\":0,\"lipstick_3\":0,\"eyebrows_1\":0,\"nose_2\":0,\"chain_2\":0,\"chest_3\":0,\"bodyb_3\":-1,\"helmet_2\":1,\"torso_2\":2,\"eyebrows_3\":0,\"ears_2\":0,\"complexion_1\":0,\"hair_color_1\":0,\"bproof_2\":0,\"bproof_1\":116,\"sun_2\":0,\"bracelets_2\":0,\"blush_2\":0,\"shoes_2\":0,\"beard_2\":0,\"face_md_weight\":50,\"beard_3\":0,\"moles_1\":0,\"tshirt_1\":247},\"grades\":{\"officier3\":\"officier3\"}},{\"grade\":false,\"name\":\"ERTV2\",\"data\":{\"shoes_1\":25,\"glasses_1\":5,\"lipstick_1\":0,\"blush_1\":0,\"bodyb_4\":0,\"glasses_2\":1,\"beard_4\":0,\"makeup_2\":0,\"ears_1\":-1,\"dad\":0,\"hair_color_2\":26,\"eyebrows_6\":0,\"eye_squint\":0,\"nose_5\":0,\"tshirt_2\":0,\"age_1\":0,\"sun_1\":0,\"mask_2\":13,\"makeup_3\":0,\"helmet_1\":231,\"blemishes_2\":0,\"chest_2\":0,\"jaw_2\":0,\"torso_1\":579,\"bodyb_2\":0,\"age_2\":0,\"eye_color\":0,\"skin_md_weight\":50,\"chin_2\":0,\"chin_1\":0,\"mom\":20,\"lip_thickness\":0,\"jaw_1\":0,\"arms_2\":0,\"beard_1\":0,\"neck_thickness\":0,\"bodyb_1\":-1,\"eyebrows_5\":0,\"blemishes_1\":0,\"moles_2\":0,\"cheeks_2\":0,\"watches_1\":-1,\"cheeks_3\":0,\"decals_2\":0,\"nose_1\":0,\"eyebrows_2\":0,\"watches_2\":0,\"chest_1\":0,\"lipstick_2\":0,\"arms\":179,\"complexion_2\":0,\"chain_1\":194,\"blush_3\":0,\"bags_1\":191,\"nose_6\":0,\"nose_3\":0,\"hair_2\":0,\"lipstick_4\":0,\"pants_1\":261,\"makeup_1\":0,\"hair_1\":79,\"cheeks_1\":0,\"decals_1\":0,\"mask_1\":169,\"makeup_4\":0,\"bracelets_1\":-1,\"pants_2\":1,\"bags_2\":0,\"eyebrows_4\":0,\"chin_4\":0,\"chin_3\":0,\"nose_4\":0,\"sex\":0,\"lipstick_3\":0,\"eyebrows_1\":0,\"nose_2\":0,\"chain_2\":0,\"chest_3\":0,\"bodyb_3\":-1,\"helmet_2\":1,\"torso_2\":2,\"eyebrows_3\":0,\"ears_2\":0,\"complexion_1\":0,\"hair_color_1\":0,\"bproof_2\":0,\"bproof_1\":116,\"sun_2\":0,\"bracelets_2\":0,\"blush_2\":0,\"shoes_2\":0,\"beard_2\":0,\"face_md_weight\":50,\"beard_3\":0,\"moles_1\":0,\"tshirt_1\":247},\"grades\":[]}]', '{\"x\":1731.1424560546876,\"y\":3893.091796875,\"z\":31.45198440551757}'),
(60, 'ambulance', 'EMS', '{\"weapons_boss\":[],\"weapons\":[],\"items_boss\":{\"bread\":{\"label\":\"Pain\",\"count\":196,\"name\":\"bread\"},\"water\":{\"label\":\"Eau\",\"count\":207,\"name\":\"water\"}},\"items\":{\"pearls_moulefrite\":{\"label\":\"Moule Frite\",\"count\":40,\"name\":\"pearls_moulefrite\"},\"burgershot_cookie\":{\"label\":\"Cookie\",\"count\":38,\"name\":\"burgershot_cookie\"},\"bread\":{\"label\":\"Pain\",\"count\":9,\"name\":\"bread\"},\"lapin\":{\"label\":\"Lapin\",\"count\":2,\"name\":\"lapin\"},\"water\":{\"label\":\"Eau\",\"count\":9,\"name\":\"water\"}},\"accounts\":{\"society\":7340500,\"cash\":0,\"black_money\":0}}', '{\"open_boss\":{\"Stagiaire EMS\":false,\"president\":true,\"boss\":true,\"label\":\"Ouvrir le menu boss\",\"Aide Soignant\":false,\"rh\":false,\"grades\":{\"boss\":true},\"Médecin Chef\":false,\"medecin chef\":false,\"Infirmier\":false,\"directeur\":[]},\"deposit_weapon_chest_society\":{\"Stagiaire EMS\":false,\"president\":true,\"boss\":true,\"label\":\"Déposer une arme dans le coffre de la société\",\"Aide Soignant\":false,\"rh\":false,\"grades\":{\"boss\":true},\"Médecin Chef\":false,\"medecin chef\":false,\"Infirmier\":false,\"directeur\":[]},\"delete_grade\":{\"Stagiaire EMS\":false,\"president\":true,\"boss\":true,\"label\":\"Supprimer un grade\",\"Aide Soignant\":false,\"rh\":false,\"grades\":{\"boss\":true},\"Médecin Chef\":false,\"medecin chef\":false,\"Infirmier\":false,\"directeur\":[]},\"items_chest:society\":{\"Stagiaire EMS\":false,\"president\":true,\"boss\":true,\"label\":\"Item(s) du coffre de la société\",\"Aide Soignant\":false,\"rh\":false,\"grades\":{\"boss\":true},\"Médecin Chef\":false,\"medecin chef\":false,\"Infirmier\":false,\"directeur\":[]},\"create_grade\":{\"Stagiaire EMS\":false,\"president\":true,\"boss\":true,\"label\":\"Créer un grade\",\"Aide Soignant\":false,\"rh\":false,\"grades\":{\"boss\":true},\"Médecin Chef\":false,\"medecin chef\":false,\"Infirmier\":false,\"directeur\":[]},\"recruit_player\":{\"Stagiaire EMS\":false,\"president\":true,\"boss\":true,\"label\":\"Recruté un joueur\",\"Aide Soignant\":false,\"rh\":true,\"grades\":{\"boss\":true},\"Médecin Chef\":true,\"medecin chef\":false,\"Infirmier\":false,\"directeur\":[]},\"promote_player\":{\"Stagiaire EMS\":false,\"president\":true,\"boss\":true,\"label\":\"Augmenter un employé\",\"Aide Soignant\":false,\"rh\":false,\"grades\":{\"boss\":true},\"Médecin Chef\":true,\"medecin chef\":false,\"Infirmier\":false,\"directeur\":[]},\"remove_weapon_chest_society\":{\"Stagiaire EMS\":false,\"president\":true,\"boss\":true,\"label\":\"Retirer une arme dans la coffre de la société\",\"Aide Soignant\":false,\"rh\":false,\"grades\":{\"boss\":true},\"Médecin Chef\":false,\"medecin chef\":false,\"Infirmier\":false,\"directeur\":[]},\"remove_weapon_chest\":{\"Stagiaire EMS\":false,\"president\":true,\"boss\":true,\"label\":\"Retirer une arme dans le coffre\",\"Aide Soignant\":false,\"rh\":false,\"grades\":{\"boss\":true},\"Médecin Chef\":false,\"medecin chef\":false,\"Infirmier\":false,\"directeur\":[]},\"dposit_item_chest_society\":{\"Stagiaire EMS\":false,\"president\":true,\"boss\":true,\"label\":\"Déposer un item dans le coffre de la société\",\"Aide Soignant\":false,\"rh\":false,\"grades\":{\"boss\":true},\"Médecin Chef\":false,\"medecin chef\":false,\"Infirmier\":false,\"directeur\":[]},\"withdraw_money_society\":{\"Stagiaire EMS\":false,\"president\":true,\"boss\":true,\"label\":\"Retirer de l\'argent dans le coffre de la société\",\"Aide Soignant\":false,\"rh\":false,\"grades\":{\"boss\":true},\"Médecin Chef\":false,\"medecin chef\":false,\"Infirmier\":false,\"directeur\":[]},\"unmote_player\":{\"Stagiaire EMS\":false,\"president\":true,\"boss\":true,\"label\":\"Descendre un employé\",\"Aide Soignant\":false,\"rh\":false,\"grades\":{\"boss\":true},\"Médecin Chef\":true,\"medecin chef\":false,\"Infirmier\":false,\"directeur\":[]},\"editClothes\":{\"Stagiaire EMS\":false,\"president\":true,\"boss\":true,\"label\":\"Gérer les tenues dans le vestiaire\",\"Aide Soignant\":false,\"rh\":false,\"grades\":{\"boss\":true},\"Médecin Chef\":false,\"medecin chef\":false,\"Infirmier\":false,\"directeur\":[]},\"items_chest\":{\"Stagiaire EMS\":false,\"president\":true,\"boss\":true,\"label\":\"Items du coffre\",\"Aide Soignant\":false,\"rh\":true,\"grades\":{\"boss\":true},\"Médecin Chef\":false,\"medecin chef\":false,\"Infirmier\":false,\"directeur\":[]},\"change_permissions_grade\":{\"Stagiaire EMS\":false,\"president\":true,\"boss\":true,\"label\":\"Changer les permissions d\'un grade\",\"Aide Soignant\":false,\"rh\":false,\"grades\":{\"boss\":true},\"Médecin Chef\":false,\"medecin chef\":false,\"Infirmier\":false,\"directeur\":[]},\"deposit_cash_coffre\":{\"Stagiaire EMS\":false,\"president\":true,\"boss\":true,\"label\":\"Déposer de l\'argent dans le coffre\",\"Aide Soignant\":false,\"rh\":false,\"grades\":{\"boss\":true},\"Médecin Chef\":false,\"medecin chef\":false,\"Infirmier\":false,\"directeur\":[]},\"remove_item_chest\":{\"Stagiaire EMS\":false,\"president\":true,\"boss\":true,\"label\":\"Retirer un item dans le coffre\",\"Aide Soignant\":false,\"rh\":true,\"grades\":{\"boss\":true},\"Médecin Chef\":false,\"medecin chef\":false,\"Infirmier\":false,\"directeur\":[]},\"manage_grades\":{\"Stagiaire EMS\":false,\"president\":true,\"boss\":true,\"label\":\"Gérer les grades de la société\",\"Aide Soignant\":false,\"rh\":false,\"grades\":{\"boss\":true},\"Médecin Chef\":false,\"medecin chef\":false,\"Infirmier\":false,\"directeur\":[]},\"demote_player\":{\"Stagiaire EMS\":false,\"president\":true,\"boss\":true,\"label\":\"Virer un employé\",\"Aide Soignant\":false,\"rh\":false,\"grades\":{\"boss\":true},\"Médecin Chef\":true,\"medecin chef\":false,\"Infirmier\":false,\"directeur\":[]},\"weapons_chest_society\":{\"Stagiaire EMS\":false,\"president\":true,\"boss\":true,\"label\":\"Arme(s) du coffre de la société\",\"Aide Soignant\":false,\"rh\":false,\"grades\":{\"boss\":true},\"Médecin Chef\":false,\"medecin chef\":false,\"Infirmier\":false,\"directeur\":[]},\"change_number_grade\":{\"Stagiaire EMS\":false,\"president\":true,\"boss\":true,\"label\":\"Changer le numéro d\'un grade\",\"Aide Soignant\":false,\"rh\":false,\"grades\":{\"boss\":true},\"Médecin Chef\":false,\"medecin chef\":false,\"Infirmier\":false,\"directeur\":[]},\"withdraw_cash_coffre\":{\"Stagiaire EMS\":false,\"president\":true,\"boss\":true,\"label\":\"Retirer de l\'argent dans le coffre\",\"Aide Soignant\":false,\"rh\":false,\"grades\":{\"boss\":true},\"Médecin Chef\":false,\"medecin chef\":false,\"Infirmier\":false,\"directeur\":[]},\"deposit_money_society\":{\"Stagiaire EMS\":false,\"president\":true,\"boss\":true,\"label\":\"Déposer de l\'argent dans le coffre de la société\",\"Aide Soignant\":false,\"rh\":false,\"grades\":{\"boss\":true},\"Médecin Chef\":false,\"medecin chef\":false,\"Infirmier\":false,\"directeur\":[]},\"open_coffre\":{\"Stagiaire EMS\":false,\"president\":true,\"boss\":true,\"label\":\"Ouvrir le coffre\",\"Aide Soignant\":false,\"rh\":true,\"grades\":{\"boss\":true},\"Médecin Chef\":false,\"medecin chef\":false,\"Infirmier\":false,\"directeur\":[]},\"withdraw_black_money_coffre\":{\"Stagiaire EMS\":false,\"president\":true,\"boss\":true,\"label\":\"Retirer de l\'argent sale dans le coffre\",\"Aide Soignant\":false,\"rh\":false,\"grades\":{\"boss\":true},\"Médecin Chef\":false,\"medecin chef\":false,\"Infirmier\":false,\"directeur\":[]},\"rename_label_grade\":{\"Stagiaire EMS\":false,\"president\":true,\"boss\":true,\"label\":\"Changer le label d\'un grade\",\"Aide Soignant\":false,\"rh\":false,\"grades\":{\"boss\":true},\"Médecin Chef\":false,\"medecin chef\":false,\"Infirmier\":false,\"directeur\":[]},\"deposit_black_money_coffre\":{\"Stagiaire EMS\":false,\"president\":true,\"boss\":true,\"label\":\"Déposer de l\'argent sale dans le coffre\",\"Aide Soignant\":false,\"rh\":false,\"grades\":{\"boss\":true},\"Médecin Chef\":false,\"medecin chef\":false,\"Infirmier\":false,\"directeur\":[]},\"chest\":{\"Stagiaire EMS\":false,\"president\":true,\"boss\":true,\"label\":\"Accéder au coffre de la société\",\"Aide Soignant\":false,\"rh\":false,\"grades\":{\"boss\":true},\"Médecin Chef\":false,\"medecin chef\":true,\"Infirmier\":false,\"directeur\":[]},\"change_salary_grade\":{\"Stagiaire EMS\":false,\"president\":true,\"boss\":true,\"label\":\"Changer le salaire d\'un grade\",\"Aide Soignant\":false,\"rh\":false,\"grades\":{\"boss\":true},\"Médecin Chef\":false,\"medecin chef\":false,\"Infirmier\":false,\"directeur\":[]},\"rename_grade\":{\"Stagiaire EMS\":false,\"president\":true,\"boss\":true,\"label\":\"Changer le nom d\'un grade\",\"Aide Soignant\":false,\"rh\":false,\"grades\":{\"boss\":true},\"Médecin Chef\":false,\"medecin chef\":false,\"Infirmier\":false,\"directeur\":[]},\"manage_employeds\":{\"Stagiaire EMS\":false,\"president\":true,\"boss\":true,\"label\":\"Gérer les employés de la société\",\"Aide Soignant\":false,\"rh\":false,\"grades\":{\"boss\":true},\"Médecin Chef\":true,\"medecin chef\":false,\"Infirmier\":false,\"directeur\":[]},\"remove_item_chest_society\":{\"Stagiaire EMS\":false,\"president\":true,\"boss\":true,\"label\":\"Retirer un item dans le coffre de la société\",\"Aide Soignant\":false,\"rh\":false,\"grades\":{\"boss\":true},\"Médecin Chef\":false,\"medecin chef\":false,\"Infirmier\":false,\"directeur\":[]},\"deposit_item_chest\":{\"Stagiaire EMS\":false,\"president\":true,\"boss\":true,\"label\":\"Déposer un item dans le coffre\",\"Aide Soignant\":false,\"rh\":true,\"grades\":{\"boss\":true},\"Médecin Chef\":false,\"medecin chef\":false,\"Infirmier\":false,\"directeur\":[]},\"deposit_weapon_chest\":{\"Stagiaire EMS\":false,\"president\":true,\"boss\":true,\"label\":\"Déposer une arme dans le coffre\",\"Aide Soignant\":false,\"rh\":false,\"grades\":{\"boss\":true},\"Médecin Chef\":false,\"medecin chef\":false,\"Infirmier\":false,\"directeur\":[]},\"weapons_chest\":{\"Stagiaire EMS\":false,\"president\":true,\"boss\":true,\"label\":\"Armes du coffre\",\"Aide Soignant\":false,\"rh\":false,\"grades\":{\"boss\":true},\"Médecin Chef\":false,\"medecin chef\":false,\"Infirmier\":false,\"directeur\":[]}}', '{\"z\":33.6893081665039,\"x\":-481.3997192382813,\"y\":-1005.3652954101564}', '{\"z\":33.68928527832031,\"x\":-485.8601379394531,\"y\":-1002.9920043945313}', '{\"color\":3,\"sprite\":61,\"active\":true,\"position\":{\"z\":24.28947448730468,\"x\":-493.1570434570313,\"y\":-983.519287109375}}', '10000', 1, '[{\"name\":\"EMS HOMME\",\"data\":{\"complexion_2\":0,\"nose_3\":0,\"blush_3\":0,\"pants_2\":0,\"cheeks_1\":2,\"decals_2\":0,\"face_md_weight\":49,\"watches_1\":3,\"nose_5\":0,\"skin_md_weight\":49,\"eyebrows_5\":0,\"eyebrows_4\":0,\"chest_3\":0,\"tshirt_2\":0,\"glasses_1\":5,\"makeup_4\":0,\"eyebrows_3\":0,\"chin_2\":2,\"sun_1\":0,\"pants_1\":7,\"helmet_2\":0,\"nose_4\":3,\"hair_1\":79,\"chain_2\":0,\"bproof_1\":0,\"ears_1\":-1,\"beard_4\":0,\"age_2\":0,\"eyebrows_2\":10,\"blemishes_2\":0,\"chin_3\":3,\"bags_2\":0,\"bodyb_1\":-1,\"hair_color_1\":0,\"lip_thickness\":9,\"blush_1\":0,\"beard_2\":10,\"bodyb_4\":0,\"eye_color\":0,\"moles_2\":0,\"makeup_3\":0,\"chain_1\":0,\"decals_1\":0,\"eyebrows_6\":0,\"lipstick_3\":0,\"jaw_1\":3,\"helmet_1\":-1,\"bproof_2\":2,\"cheeks_2\":3,\"sex\":0,\"chest_1\":0,\"moles_1\":0,\"chest_2\":0,\"beard_1\":3,\"watches_2\":0,\"lipstick_2\":0,\"tshirt_1\":0,\"eye_squint\":0,\"makeup_2\":0,\"sun_2\":0,\"lipstick_4\":0,\"mask_1\":0,\"arms_2\":0,\"shoes_1\":7,\"complexion_1\":0,\"torso_2\":0,\"arms\":1,\"mask_2\":0,\"bracelets_1\":-1,\"glasses_2\":1,\"nose_1\":1,\"hair_2\":0,\"cheeks_3\":0,\"nose_2\":7,\"bodyb_2\":0,\"lipstick_1\":0,\"dad\":10,\"mom\":0,\"nose_6\":0,\"shoes_2\":0,\"chin_4\":1,\"eyebrows_1\":1,\"chin_1\":4,\"torso_1\":897,\"beard_3\":0,\"blush_2\":0,\"bracelets_2\":0,\"neck_thickness\":2,\"bags_1\":0,\"age_1\":0,\"bodyb_3\":-1,\"blemishes_1\":0,\"makeup_1\":0,\"hair_color_2\":0,\"ears_2\":0,\"jaw_2\":2},\"grades\":[],\"grade\":false},{\"name\":\"ems femme interne\",\"grades\":[],\"data\":{\"complexion_2\":0,\"nose_3\":9,\"neck_thickness\":0,\"lipstick_4\":0,\"cheeks_1\":2,\"decals_2\":0,\"face_md_weight\":78,\"watches_1\":-1,\"nose_5\":4,\"skin_md_weight\":50,\"eyebrows_5\":0,\"torso_2\":0,\"chest_3\":0,\"tshirt_2\":0,\"glasses_1\":66,\"makeup_4\":0,\"face_color\":0,\"chin_2\":0,\"sun_1\":0,\"pants_1\":322,\"helmet_2\":0,\"nose_4\":8,\"hair_1\":219,\"chain_2\":0,\"bproof_1\":0,\"ears_1\":25,\"chest_2\":0,\"age_2\":0,\"lipstick_2\":0,\"watches_2\":0,\"chin_3\":0,\"bags_2\":0,\"bodyb_1\":-1,\"hair_color_1\":5,\"lip_thickness\":2,\"blush_1\":0,\"beard_2\":0,\"bodyb_4\":0,\"hair_color_2\":29,\"shoes_1\":222,\"moles_2\":6,\"makeup_3\":0,\"arms_2\":0,\"decals_1\":0,\"glasses_2\":0,\"lipstick_1\":0,\"jaw_1\":0,\"helmet_1\":-1,\"bproof_2\":0,\"cheeks_2\":0,\"sex\":1,\"chest_1\":0,\"moles_1\":0,\"chin_1\":0,\"age_1\":0,\"eyebrows_4\":0,\"eyebrows_3\":0,\"tshirt_1\":2,\"eye_squint\":0,\"makeup_2\":0,\"eye_color\":15,\"blemishes_2\":0,\"sun_2\":0,\"blemishes_1\":0,\"beard_1\":0,\"complexion_1\":0,\"chin_4\":0,\"pants_2\":0,\"mask_2\":0,\"mask_1\":0,\"dad\":30,\"nose_1\":0,\"hair_2\":0,\"lipstick_3\":0,\"nose_2\":5,\"bodyb_2\":0,\"bracelets_1\":-1,\"chain_1\":321,\"mom\":30,\"nose_6\":0,\"shoes_2\":0,\"eyebrows_2\":0,\"eyebrows_1\":0,\"beard_4\":0,\"torso_1\":950,\"beard_3\":0,\"blush_3\":0,\"bracelets_2\":0,\"blush_2\":0,\"bags_1\":0,\"cheeks_3\":2,\"bodyb_3\":-1,\"eyebrows_6\":0,\"makeup_1\":0,\"arms\":14,\"ears_2\":0,\"jaw_2\":0},\"grade\":false},{\"name\":\"Ems femme externe\",\"grades\":[],\"data\":{\"complexion_2\":0,\"nose_3\":9,\"neck_thickness\":0,\"lipstick_4\":0,\"cheeks_1\":2,\"decals_2\":0,\"face_md_weight\":78,\"watches_1\":-1,\"nose_5\":4,\"skin_md_weight\":50,\"eyebrows_5\":0,\"torso_2\":0,\"chest_3\":0,\"tshirt_2\":0,\"glasses_1\":66,\"makeup_4\":0,\"face_color\":0,\"chin_2\":0,\"sun_1\":0,\"pants_1\":341,\"helmet_2\":0,\"nose_4\":8,\"hair_1\":219,\"chain_2\":0,\"bproof_1\":0,\"ears_1\":25,\"chest_2\":0,\"age_2\":0,\"lipstick_2\":0,\"watches_2\":0,\"chin_3\":0,\"bags_2\":0,\"bodyb_1\":-1,\"hair_color_1\":5,\"lip_thickness\":2,\"blush_1\":0,\"beard_2\":0,\"bodyb_4\":0,\"hair_color_2\":29,\"shoes_1\":149,\"moles_2\":6,\"makeup_3\":0,\"arms_2\":0,\"decals_1\":0,\"glasses_2\":0,\"lipstick_1\":0,\"jaw_1\":0,\"helmet_1\":-1,\"bproof_2\":0,\"cheeks_2\":0,\"sex\":1,\"chest_1\":0,\"moles_1\":0,\"chin_1\":0,\"age_1\":0,\"eyebrows_4\":0,\"eyebrows_3\":0,\"tshirt_1\":69,\"eye_squint\":0,\"makeup_2\":0,\"eye_color\":15,\"blemishes_2\":0,\"sun_2\":0,\"blemishes_1\":0,\"beard_1\":0,\"complexion_1\":0,\"chin_4\":0,\"pants_2\":5,\"mask_2\":0,\"mask_1\":0,\"dad\":30,\"nose_1\":0,\"hair_2\":0,\"lipstick_3\":0,\"nose_2\":5,\"bodyb_2\":0,\"bracelets_1\":-1,\"chain_1\":321,\"mom\":30,\"nose_6\":0,\"shoes_2\":2,\"eyebrows_2\":0,\"eyebrows_1\":0,\"beard_4\":0,\"torso_1\":1087,\"beard_3\":0,\"blush_3\":0,\"bracelets_2\":0,\"blush_2\":0,\"bags_1\":0,\"cheeks_3\":2,\"bodyb_3\":-1,\"eyebrows_6\":0,\"makeup_1\":0,\"arms\":1,\"ears_2\":0,\"jaw_2\":0},\"grade\":false}]', '{\"z\":33.67815399169922,\"x\":-481.5459289550781,\"y\":-1011.929931640625}'),
(61, 'restau_burgershot', 'Burger Shot', '{\"accounts\":{\"black_money\":0,\"cash\":0,\"society\":15000},\"weapons\":[],\"weapons_boss\":[],\"items\":[],\"items_boss\":[]}', '{\"chest\":{\"boss\":true},\"weapons_chest\":{\"boss\":true},\"create_grade\":{\"boss\":true},\"deposit_item_chest\":{\"boss\":true},\"deposit_weapon_chest\":{\"boss\":true},\"unmote_player\":{\"boss\":true},\"withdraw_money_society\":{\"boss\":true},\"items_chest\":{\"boss\":true},\"promote_player\":{\"boss\":true},\"remove_item_chest\":{\"boss\":true},\"remove_item_chest_society\":{\"boss\":true},\"open_boss\":{\"boss\":true},\"deposit_black_money_coffre\":{\"boss\":true},\"remove_weapon_chest\":{\"boss\":true},\"rename_label_grade\":{\"boss\":true},\"deposit_cash_coffre\":{\"boss\":true},\"delete_grade\":{\"boss\":true},\"deposit_weapon_chest_society\":{\"boss\":true},\"rename_grade\":{\"boss\":true},\"open_coffre\":{\"boss\":true},\"editClothes\":{\"boss\":true},\"withdraw_cash_coffre\":{\"boss\":true},\"withdraw_black_money_coffre\":{\"boss\":true},\"remove_weapon_chest_society\":{\"boss\":true},\"recruit_player\":{\"boss\":true},\"items_chest:society\":{\"boss\":true},\"weapons_chest_society\":{\"boss\":true},\"manage_employeds\":{\"boss\":true},\"change_number_grade\":{\"boss\":true},\"deposit_money_society\":{\"boss\":true},\"change_permissions_grade\":{\"boss\":true},\"dposit_item_chest_society\":{\"boss\":true},\"manage_grades\":{\"boss\":true},\"demote_player\":{\"boss\":true},\"change_salary_grade\":{\"boss\":true}}', '{\"x\":-1196.744873046875,\"y\":-901.7516479492188,\"z\":13.8861608505249}', '{\"x\":-1199.842041015625,\"y\":-902.7513427734375,\"z\":13.88615703582763}', '{\"sprite\":106,\"color\":1,\"position\":{\"y\":-889.5091552734375,\"z\":13.79837894439697,\"x\":-1191.08642578125},\"active\":true}', '0', 1, '[]', '{\"x\":-1203.8621826171876,\"y\":-894.0457763671875,\"z\":13.88615131378173}'),
(63, 'boite_unicorn', 'Unicorn', '{\"weapons_boss\":[],\"items_boss\":[],\"accounts\":{\"cash\":0,\"society\":15000,\"black_money\":0},\"items\":[],\"weapons\":[]}', '{\"change_number_grade\":{\"boss\":true},\"change_permissions_grade\":{\"boss\":true},\"deposit_cash_coffre\":{\"boss\":true},\"deposit_money_society\":{\"boss\":true},\"remove_weapon_chest\":{\"boss\":true},\"rename_grade\":{\"boss\":true},\"recruit_player\":{\"boss\":true},\"deposit_weapon_chest\":{\"boss\":true},\"delete_grade\":{\"boss\":true},\"withdraw_black_money_coffre\":{\"boss\":true},\"remove_weapon_chest_society\":{\"boss\":true},\"unmote_player\":{\"boss\":true},\"rename_label_grade\":{\"boss\":true},\"withdraw_money_society\":{\"boss\":true},\"items_chest\":{\"boss\":true},\"manage_employeds\":{\"boss\":true},\"change_salary_grade\":{\"boss\":true},\"open_coffre\":{\"boss\":true},\"deposit_black_money_coffre\":{\"boss\":true},\"manage_grades\":{\"boss\":true},\"withdraw_cash_coffre\":{\"boss\":true},\"deposit_weapon_chest_society\":{\"boss\":true},\"create_grade\":{\"boss\":true},\"remove_item_chest\":{\"boss\":true},\"chest\":{\"boss\":true},\"weapons_chest\":{\"boss\":true},\"open_boss\":{\"boss\":true},\"dposit_item_chest_society\":{\"boss\":true},\"items_chest:society\":{\"boss\":true},\"demote_player\":{\"boss\":true},\"remove_item_chest_society\":{\"boss\":true},\"deposit_item_chest\":{\"boss\":true},\"weapons_chest_society\":{\"boss\":true},\"promote_player\":{\"boss\":true},\"editClothes\":{\"boss\":true}}', '{\"x\":106.642578125,\"y\":-1299.41162109375,\"z\":28.76897048950195}', '{\"x\":108.66100311279297,\"y\":-1305.61962890625,\"z\":28.76774215698242}', '{\"sprite\":121,\"active\":true,\"position\":{\"x\":125.80050659179688,\"y\":-1295.0428466796876,\"z\":29.25549507141113},\"color\":7}', '0', 1, '[]', '{\"x\":109.80492401123049,\"y\":-1305.447998046875,\"z\":29.25551033020019}'),
(64, 'vangelico', 'Vangelico', '{\"items\":[],\"weapons_boss\":[],\"accounts\":{\"black_money\":0,\"society\":2725,\"cash\":0},\"weapons\":[],\"items_boss\":[]}', '{\"promote_player\":{\"boss\":true},\"deposit_weapon_chest\":{\"boss\":true},\"change_salary_grade\":{\"boss\":true},\"items_chest:society\":{\"boss\":true},\"change_permissions_grade\":{\"boss\":true},\"remove_weapon_chest_society\":{\"boss\":true},\"manage_employeds\":{\"boss\":true},\"rename_grade\":{\"boss\":true},\"withdraw_money_society\":{\"boss\":true},\"deposit_item_chest\":{\"boss\":true},\"editClothes\":{\"boss\":true},\"remove_item_chest_society\":{\"boss\":true},\"deposit_cash_coffre\":{\"boss\":true},\"deposit_money_society\":{\"boss\":true},\"change_number_grade\":{\"boss\":true},\"withdraw_black_money_coffre\":{\"boss\":true},\"dposit_item_chest_society\":{\"boss\":true},\"unmote_player\":{\"boss\":true},\"weapons_chest_society\":{\"boss\":true},\"create_grade\":{\"boss\":true},\"weapons_chest\":{\"boss\":true},\"delete_grade\":{\"boss\":true},\"recruit_player\":{\"boss\":true},\"demote_player\":{\"boss\":true},\"deposit_weapon_chest_society\":{\"boss\":true},\"items_chest\":{\"boss\":true},\"chest\":{\"boss\":true},\"rename_label_grade\":{\"boss\":true},\"withdraw_cash_coffre\":{\"boss\":true},\"deposit_black_money_coffre\":{\"boss\":true},\"manage_grades\":{\"boss\":true},\"open_boss\":{\"boss\":true},\"remove_item_chest\":{\"boss\":true},\"open_coffre\":{\"boss\":true},\"remove_weapon_chest\":{\"boss\":true}}', '{\"x\":-630.5894165039063,\"y\":-229.51231384277345,\"z\":38.05705642700195}', '{\"x\":-629.0260009765625,\"y\":-228.1563720703125,\"z\":38.05705642700195}', '{\"position\":{\"x\":-624.469482421875,\"y\":-232.24172973632813,\"z\":38.05701446533203},\"active\":true,\"sprite\":285,\"color\":0}', '1', 0, '[]', '\"none\"'),
(65, 'restau_pops', 'Pop\'s Diner', NULL, '{\"items_chest:society\":{\"boss\":true},\"remove_item_chest\":{\"boss\":true},\"remove_weapon_chest\":{\"boss\":true},\"deposit_item_chest\":{\"boss\":true},\"open_coffre\":{\"boss\":true},\"unmote_player\":{\"boss\":true},\"rename_grade\":{\"boss\":true},\"withdraw_money_society\":{\"boss\":true},\"deposit_cash_coffre\":{\"boss\":true},\"remove_weapon_chest_society\":{\"boss\":true},\"create_grade\":{\"boss\":true},\"deposit_black_money_coffre\":{\"boss\":true},\"deposit_money_society\":{\"boss\":true},\"recruit_player\":{\"boss\":true},\"weapons_chest_society\":{\"boss\":true},\"open_boss\":{\"boss\":true},\"editClothes\":{\"boss\":true},\"dposit_item_chest_society\":{\"boss\":true},\"withdraw_black_money_coffre\":{\"boss\":true},\"change_permissions_grade\":{\"boss\":true},\"deposit_weapon_chest_society\":{\"boss\":true},\"delete_grade\":{\"boss\":true},\"deposit_weapon_chest\":{\"boss\":true},\"change_salary_grade\":{\"boss\":true},\"manage_grades\":{\"boss\":true},\"rename_label_grade\":{\"boss\":true},\"change_number_grade\":{\"boss\":true},\"demote_player\":{\"boss\":true},\"weapons_chest\":{\"boss\":true},\"withdraw_cash_coffre\":{\"boss\":true},\"promote_player\":{\"boss\":true},\"manage_employeds\":{\"boss\":true},\"items_chest\":{\"boss\":true},\"remove_item_chest_society\":{\"boss\":true},\"chest\":{\"boss\":true}}', '{\"x\":1590.5518798828126,\"y\":6457.84765625,\"z\":26.01401901245117}', '{\"x\":1595.6212158203126,\"y\":6454.04931640625,\"z\":26.01402854919433}', '{\"active\":true,\"position\":{\"x\":1589.105712890625,\"y\":6456.9365234375,\"z\":26.01401138305664},\"color\":1,\"sprite\":267}', '0', 0, '[]', '\"none\"');
INSERT INTO `society_data` (`id`, `name`, `label`, `coffre`, `permissions`, `posCoffre`, `posBoss`, `blips`, `tax`, `cloakroom`, `clothes`, `cloakpos`) VALUES
(67, 'restau_pearls', 'Pearls', '{\"items_boss\":{\"762mm\":{\"count\":97,\"name\":\"762mm\",\"label\":\"7.62mm Munition\"}},\"weapons\":[],\"weapons_boss\":[],\"items\":{\"burgershot_biere\":{\"count\":275,\"name\":\"burgershot_biere\",\"label\":\"Bière\"},\"burgershot_cookie\":{\"count\":858,\"name\":\"burgershot_cookie\",\"label\":\"Cookie\"},\"pearls_fish\":{\"count\":157,\"name\":\"pearls_fish\",\"label\":\"Poisson\"},\"pearls_moule\":{\"count\":58,\"name\":\"pearls_moule\",\"label\":\"Moule\"},\"water\":{\"count\":508,\"name\":\"water\",\"label\":\"Eau\"},\"pearls_fishandchips\":{\"count\":79,\"name\":\"pearls_fishandchips\",\"label\":\"Fish And Chips\"},\"burgershot_sprite\":{\"count\":274,\"name\":\"burgershot_sprite\",\"label\":\"Sprite\"},\"pearls_frite\":{\"count\":55,\"name\":\"pearls_frite\",\"label\":\"Frite\"},\"pearls_moulefrite\":{\"count\":139,\"name\":\"pearls_moulefrite\",\"label\":\"Moule Frite\"},\"pearls_crevette\":{\"count\":320,\"name\":\"pearls_crevette\",\"label\":\"Crevette\"},\"pops_sauce\":{\"count\":197,\"name\":\"pops_sauce\",\"label\":\"Sauce\"}},\"accounts\":{\"society\":34360,\"cash\":0,\"black_money\":0}}', '{\"deposit_cash_coffre\":{\"boss\":true,\"sous-boss\":true,\"employed\":false},\"dposit_item_chest_society\":{\"boss\":true,\"sous-boss\":[],\"employed\":false},\"chest\":{\"boss\":true,\"sous-boss\":true,\"employed\":false},\"open_boss\":{\"boss\":true,\"sous-boss\":[],\"employed\":false},\"change_permissions_grade\":{\"boss\":true,\"sous-boss\":false,\"employed\":false},\"open_coffre\":{\"boss\":true,\"sous-boss\":true,\"employed\":true},\"deposit_weapon_chest_society\":{\"boss\":true,\"sous-boss\":[],\"employed\":false},\"items_chest\":{\"boss\":true,\"sous-boss\":[],\"employed\":true},\"unmote_player\":{\"boss\":true,\"sous-boss\":[],\"employed\":false},\"change_number_grade\":{\"boss\":true,\"sous-boss\":false,\"employed\":false},\"change_salary_grade\":{\"boss\":true,\"sous-boss\":false,\"employed\":false},\"recruit_player\":{\"boss\":true,\"sous-boss\":[],\"employed\":false},\"deposit_black_money_coffre\":{\"boss\":true,\"sous-boss\":[],\"employed\":false},\"rename_label_grade\":{\"boss\":true,\"sous-boss\":false,\"employed\":false},\"rename_grade\":{\"boss\":true,\"sous-boss\":false,\"employed\":false},\"deposit_weapon_chest\":{\"boss\":true,\"sous-boss\":[],\"employed\":false},\"deposit_item_chest\":{\"boss\":true,\"sous-boss\":[],\"employed\":true},\"withdraw_black_money_coffre\":{\"boss\":true,\"sous-boss\":[],\"employed\":false},\"editClothes\":{\"boss\":true,\"sous-boss\":false,\"employed\":false},\"remove_weapon_chest\":{\"boss\":true,\"sous-boss\":[],\"employed\":false},\"remove_weapon_chest_society\":{\"boss\":true,\"sous-boss\":[],\"employed\":false},\"promote_player\":{\"boss\":true,\"sous-boss\":[],\"employed\":false},\"remove_item_chest_society\":{\"boss\":true,\"sous-boss\":[],\"employed\":false},\"delete_grade\":{\"boss\":true,\"sous-boss\":false,\"employed\":false},\"withdraw_money_society\":{\"boss\":true,\"sous-boss\":true,\"employed\":false},\"items_chest:society\":{\"boss\":true,\"sous-boss\":[],\"employed\":false},\"deposit_money_society\":{\"boss\":true,\"sous-boss\":[],\"employed\":false},\"manage_grades\":{\"boss\":true,\"sous-boss\":false,\"employed\":false},\"demote_player\":{\"boss\":true,\"sous-boss\":[],\"employed\":false},\"weapons_chest_society\":{\"boss\":true,\"sous-boss\":[],\"employed\":false},\"manage_employeds\":{\"boss\":true,\"sous-boss\":[],\"employed\":false},\"withdraw_cash_coffre\":{\"boss\":true,\"sous-boss\":[],\"employed\":false},\"create_grade\":{\"boss\":true,\"sous-boss\":false,\"employed\":false},\"remove_item_chest\":{\"boss\":true,\"sous-boss\":[],\"employed\":true},\"weapons_chest\":{\"boss\":true,\"sous-boss\":[],\"employed\":false}}', '{\"z\":14.32817363739013,\"y\":-1191.259033203125,\"x\":-1839.0009765625}', '{\"z\":14.32764530181884,\"y\":-1178.9268798828126,\"x\":-1835.8304443359376}', '{\"active\":true,\"position\":{\"z\":14.30337715148925,\"y\":-1192.265625,\"x\":-1815.684814453125},\"sprite\":729,\"color\":3}', '0', 1, '[{\"grades\":{\"boss\":\"boss\",\"employed\":\"employed\",\"sous-boss\":\"sous-boss\"},\"grade\":true,\"data\":{\"jaw_2\":0,\"decals_2\":0,\"blemishes_2\":0,\"blush_1\":0,\"chest_3\":0,\"torso_2\":15,\"nose_2\":0,\"beard_2\":10,\"chin_2\":0,\"pants_2\":0,\"eyebrows_3\":0,\"hair_1\":10,\"dad\":30,\"makeup_3\":0,\"mom\":0,\"sex\":0,\"ears_1\":0,\"sun_2\":0,\"eyebrows_6\":0,\"face_md_weight\":0,\"nose_1\":0,\"torso_1\":11,\"skin_md_weight\":50,\"lip_thickness\":0,\"nose_4\":0,\"chain_2\":0,\"lipstick_4\":0,\"mask_1\":0,\"blemishes_1\":0,\"ears_2\":0,\"makeup_1\":0,\"bodyb_4\":0,\"helmet_2\":0,\"bags_2\":0,\"chain_1\":0,\"chest_2\":0,\"lipstick_2\":0,\"sun_1\":0,\"complexion_2\":0,\"mask_2\":0,\"age_1\":0,\"jaw_1\":0,\"cheeks_1\":0,\"chin_3\":0,\"bodyb_1\":-1,\"helmet_1\":-1,\"complexion_1\":0,\"bodyb_3\":-1,\"face_color\":0,\"eye_color\":0,\"bodyb_2\":0,\"neck_thickness\":0,\"glasses_1\":0,\"nose_6\":0,\"chest_1\":0,\"hair_color_1\":0,\"makeup_2\":0,\"eyebrows_4\":0,\"moles_1\":0,\"beard_4\":0,\"bproof_1\":0,\"nose_3\":0,\"lipstick_1\":0,\"decals_1\":0,\"shoes_1\":21,\"age_2\":0,\"cheeks_3\":0,\"bracelets_2\":0,\"bags_1\":43,\"moles_2\":0,\"beard_3\":0,\"eyebrows_2\":10,\"bproof_2\":0,\"arms_2\":0,\"chin_4\":0,\"watches_2\":0,\"eyebrows_1\":33,\"blush_2\":0,\"hair_color_2\":0,\"shoes_2\":0,\"chin_1\":0,\"makeup_4\":0,\"cheeks_2\":0,\"eye_squint\":0,\"glasses_2\":0,\"blush_3\":0,\"pants_1\":20,\"tshirt_2\":0,\"eyebrows_5\":0,\"hair_2\":0,\"lipstick_3\":0,\"tshirt_1\":50,\"bracelets_1\":-1,\"beard_1\":14,\"nose_5\":0,\"watches_1\":-1,\"arms\":11},\"name\":\"PEARLS\"},{\"grades\":{\"boss\":\"boss\",\"employed\":\"employed\",\"sous-boss\":\"sous-boss\"},\"grade\":true,\"data\":{\"bodyb_3\":-1,\"decals_2\":0,\"blemishes_2\":0,\"blush_1\":0,\"chest_3\":0,\"torso_2\":12,\"nose_2\":5,\"beard_2\":0,\"chin_2\":0,\"pants_2\":0,\"eyebrows_3\":0,\"hair_1\":219,\"dad\":30,\"makeup_3\":0,\"mom\":30,\"sex\":1,\"ears_1\":25,\"sun_2\":0,\"eyebrows_6\":0,\"face_md_weight\":78,\"nose_1\":0,\"torso_1\":28,\"skin_md_weight\":50,\"beard_4\":0,\"nose_4\":8,\"chain_2\":0,\"lipstick_4\":0,\"mask_1\":0,\"blemishes_1\":0,\"ears_2\":0,\"makeup_1\":0,\"bodyb_4\":0,\"helmet_2\":0,\"bags_2\":0,\"chain_1\":321,\"beard_1\":0,\"lipstick_2\":0,\"sun_1\":0,\"complexion_2\":0,\"arms\":0,\"age_1\":0,\"chest_2\":0,\"cheeks_1\":2,\"eye_color\":15,\"lipstick_1\":0,\"jaw_2\":0,\"complexion_1\":0,\"bodyb_1\":-1,\"face_color\":0,\"lipstick_3\":0,\"bodyb_2\":0,\"neck_thickness\":0,\"glasses_1\":66,\"nose_6\":0,\"cheeks_3\":2,\"hair_color_1\":5,\"chin_3\":0,\"eyebrows_4\":0,\"helmet_1\":-1,\"moles_1\":0,\"bproof_1\":0,\"nose_3\":9,\"makeup_4\":0,\"decals_1\":0,\"shoes_1\":221,\"age_2\":0,\"chin_4\":0,\"tshirt_1\":24,\"bags_1\":0,\"moles_2\":6,\"beard_3\":0,\"eyebrows_2\":0,\"bproof_2\":0,\"makeup_2\":0,\"arms_2\":0,\"watches_2\":0,\"eyebrows_1\":0,\"blush_2\":0,\"hair_color_2\":29,\"shoes_2\":0,\"mask_2\":0,\"tshirt_2\":3,\"lip_thickness\":2,\"eye_squint\":0,\"glasses_2\":0,\"bracelets_2\":0,\"pants_1\":23,\"cheeks_2\":0,\"eyebrows_5\":0,\"hair_2\":0,\"chin_1\":0,\"watches_1\":-1,\"bracelets_1\":-1,\"chest_1\":0,\"nose_5\":4,\"jaw_1\":0,\"blush_3\":0},\"name\":\"pearl femme\"}]', '{\"z\":14.3282241821289,\"y\":-1202.2021484375,\"x\":-1849.905029296875}'),
(68, 'boite_wiwang', 'Wiwang', '{\"items_boss\":[],\"weapons_boss\":[],\"accounts\":{\"society\":93381.76307610554,\"cash\":0,\"black_money\":0},\"weapons\":[],\"items\":{\"wiwang_juspassion\":{\"label\":\"Jus Passion Mangue\",\"name\":\"wiwang_juspassion\",\"count\":100},\"wiwang_donperignon\":{\"label\":\"Don Perignon\",\"name\":\"wiwang_donperignon\",\"count\":100},\"wiwang_vin\":{\"label\":\"Vin\",\"name\":\"wiwang_vin\",\"count\":100},\"wiwang_cocktail\":{\"label\":\"Cocktail Bora Bora\",\"name\":\"wiwang_cocktail\",\"count\":100},\"wiwang_caviar\":{\"label\":\"Caviar\",\"name\":\"wiwang_caviar\",\"count\":100},\"wiwang_macarons\":{\"label\":\"Macarons\",\"name\":\"wiwang_macarons\",\"count\":100},\"wiwang_ruinart\":{\"label\":\"Ruinart\",\"name\":\"wiwang_ruinart\",\"count\":95}}}', '{\"withdraw_cash_coffre\":{\"boss\":true},\"dposit_item_chest_society\":{\"boss\":true},\"rename_grade\":{\"boss\":true},\"chest\":{\"boss\":true},\"change_salary_grade\":{\"boss\":true},\"manage_grades\":{\"boss\":true},\"deposit_weapon_chest\":{\"boss\":true},\"create_grade\":{\"boss\":true},\"rename_label_grade\":{\"boss\":true},\"unmote_player\":{\"boss\":true},\"promote_player\":{\"boss\":true},\"withdraw_money_society\":{\"boss\":true},\"withdraw_black_money_coffre\":{\"boss\":true},\"remove_weapon_chest\":{\"boss\":true},\"deposit_weapon_chest_society\":{\"boss\":true},\"delete_grade\":{\"boss\":true},\"weapons_chest\":{\"boss\":true},\"change_permissions_grade\":{\"boss\":true},\"recruit_player\":{\"boss\":true},\"remove_item_chest_society\":{\"boss\":true},\"weapons_chest_society\":{\"boss\":true},\"demote_player\":{\"boss\":true},\"change_number_grade\":{\"boss\":true},\"deposit_black_money_coffre\":{\"boss\":true},\"items_chest\":{\"boss\":true},\"deposit_cash_coffre\":{\"boss\":true},\"manage_employeds\":{\"boss\":true},\"open_coffre\":{\"boss\":true},\"deposit_money_society\":{\"boss\":true},\"open_boss\":{\"boss\":true},\"items_chest:society\":{\"boss\":true},\"editClothes\":{\"boss\":true},\"deposit_item_chest\":{\"boss\":true},\"remove_weapon_chest_society\":{\"boss\":true},\"remove_item_chest\":{\"boss\":true}}', '{\"y\":-687.7308959960938,\"x\":-815.381103515625,\"z\":123.41831970214844}', '{\"y\":-691.3907470703125,\"x\":-820.621826171875,\"z\":127.38679504394533}', '{\"sprite\":93,\"color\":7,\"active\":true,\"position\":{\"y\":-686.4660034179688,\"x\":-817.693603515625,\"z\":123.41832733154296}}', '1', 1, '[]', '{\"y\":-683.3983764648438,\"x\":-820.3956298828125,\"z\":123.4223403930664}'),
(69, 'boite_pacific', 'Pacific Bluffs', '{\"items_boss\":{\"pacific_brochettes\":{\"label\":\"Brochettes de fruits frais\",\"name\":\"pacific_brochettes\",\"count\":5},\"pacific_smoothie\":{\"label\":\"Smoothie tropical\",\"name\":\"pacific_smoothie\",\"count\":5},\"pacific_pina\":{\"label\":\"Piña Colada\",\"name\":\"pacific_pina\",\"count\":3},\"pacific_coco\":{\"label\":\"Eau de coco\",\"name\":\"pacific_coco\",\"count\":5},\"pacific_chips\":{\"label\":\"Chips de banane plantain\",\"name\":\"pacific_chips\",\"count\":5},\"pacific_mojito\":{\"label\":\"Mojito \",\"name\":\"pacific_mojito\",\"count\":5},\"pacific_margarita\":{\"label\":\"Margarita \",\"name\":\"pacific_margarita\",\"count\":5}},\"weapons_boss\":[],\"accounts\":{\"society\":101000.0,\"cash\":0,\"black_money\":0},\"weapons\":[],\"items\":{\"pacific_brochettes\":{\"label\":\"Brochettes de fruits frais\",\"name\":\"pacific_brochettes\",\"count\":28},\"pacific_smoothie\":{\"label\":\"Smoothie tropical\",\"name\":\"pacific_smoothie\",\"count\":50},\"pacific_pina\":{\"label\":\"Piña Colada\",\"name\":\"pacific_pina\",\"count\":45},\"pacific_coco\":{\"label\":\"Eau de coco\",\"name\":\"pacific_coco\",\"count\":50},\"pacific_chips\":{\"label\":\"Chips de banane plantain\",\"name\":\"pacific_chips\",\"count\":50},\"pacific_mojito\":{\"label\":\"Mojito \",\"name\":\"pacific_mojito\",\"count\":48},\"pacific_margarita\":{\"label\":\"Margarita \",\"name\":\"pacific_margarita\",\"count\":50}}}', '{\"withdraw_cash_coffre\":{\"boss\":true,\"Barman\":false,\"Sécurité\":false,\"dj\":false},\"dposit_item_chest_society\":{\"boss\":true,\"Barman\":[],\"Sécurité\":[],\"dj\":true},\"rename_grade\":{\"boss\":true,\"Barman\":false,\"Sécurité\":false,\"dj\":false},\"chest\":{\"boss\":true,\"Barman\":false,\"Sécurité\":false,\"dj\":false},\"change_salary_grade\":{\"boss\":true,\"Barman\":false,\"Sécurité\":false,\"dj\":false},\"manage_grades\":{\"boss\":true,\"Barman\":false,\"Sécurité\":false,\"dj\":false},\"deposit_weapon_chest\":{\"boss\":true,\"Barman\":[],\"Sécurité\":[],\"dj\":[]},\"create_grade\":{\"boss\":true,\"Barman\":false,\"Sécurité\":false,\"dj\":false},\"rename_label_grade\":{\"boss\":true,\"Barman\":false,\"Sécurité\":false,\"dj\":false},\"unmote_player\":{\"boss\":true,\"Barman\":false,\"Sécurité\":false,\"dj\":false},\"promote_player\":{\"boss\":true,\"Barman\":false,\"Sécurité\":[],\"dj\":false},\"withdraw_money_society\":{\"boss\":true,\"Barman\":false,\"Sécurité\":false,\"dj\":false},\"withdraw_black_money_coffre\":{\"boss\":true,\"Barman\":false,\"Sécurité\":false,\"dj\":false},\"remove_weapon_chest\":{\"boss\":true,\"Barman\":false,\"Sécurité\":false,\"dj\":false},\"deposit_weapon_chest_society\":{\"boss\":true,\"Barman\":[],\"Sécurité\":[],\"dj\":[]},\"delete_grade\":{\"boss\":true,\"Barman\":false,\"Sécurité\":false,\"dj\":false},\"weapons_chest\":{\"boss\":true,\"Barman\":false,\"Sécurité\":false,\"dj\":false},\"change_permissions_grade\":{\"boss\":true,\"Barman\":false,\"Sécurité\":false,\"dj\":false},\"recruit_player\":{\"boss\":true,\"Barman\":false,\"Sécurité\":[],\"dj\":true},\"remove_item_chest_society\":{\"boss\":true,\"Barman\":false,\"Sécurité\":false,\"dj\":false},\"weapons_chest_society\":{\"boss\":true,\"Barman\":false,\"Sécurité\":false,\"dj\":false},\"deposit_item_chest\":{\"boss\":true,\"Barman\":[],\"Sécurité\":[],\"dj\":[]},\"change_number_grade\":{\"boss\":true,\"Barman\":false,\"Sécurité\":false,\"dj\":false},\"editClothes\":{\"boss\":true,\"Barman\":false,\"Sécurité\":[],\"dj\":false},\"deposit_black_money_coffre\":{\"boss\":true,\"Barman\":[],\"Sécurité\":[],\"dj\":[]},\"items_chest\":{\"boss\":true,\"Barman\":false,\"Sécurité\":false,\"dj\":false},\"manage_employeds\":{\"boss\":true,\"Barman\":false,\"Sécurité\":false,\"dj\":false},\"open_coffre\":{\"boss\":true,\"Barman\":[],\"Sécurité\":[],\"dj\":false},\"deposit_money_society\":{\"boss\":true,\"Barman\":[],\"Sécurité\":true,\"dj\":[]},\"open_boss\":{\"boss\":true,\"Barman\":false,\"Sécurité\":false,\"dj\":false},\"deposit_cash_coffre\":{\"boss\":true,\"Barman\":[],\"Sécurité\":[],\"dj\":[]},\"demote_player\":{\"boss\":true,\"Barman\":false,\"Sécurité\":false,\"dj\":false},\"items_chest:society\":{\"boss\":true,\"Barman\":false,\"Sécurité\":false,\"dj\":false},\"remove_weapon_chest_society\":{\"boss\":true,\"Barman\":false,\"Sécurité\":false,\"dj\":false},\"remove_item_chest\":{\"boss\":true,\"Barman\":false,\"Sécurité\":false,\"dj\":false}}', '{\"y\":36.9053955078125,\"x\":-3022.68603515625,\"z\":10.14832782745361}', '{\"y\":100.24765014648438,\"x\":-3053.260986328125,\"z\":12.82001209259033}', '{\"sprite\":93,\"color\":7,\"active\":true,\"position\":{\"y\":86.63282775878906,\"x\":-3018.800048828125,\"z\":11.5861759185791}}', '0', 1, '[{\"grade\":false,\"name\":\"Sécurité\",\"grades\":[],\"data\":{\"shoes_1\":12,\"glasses_1\":62,\"lipstick_1\":0,\"hair_2\":0,\"bodyb_4\":0,\"glasses_2\":0,\"beard_4\":0,\"makeup_2\":0,\"ears_1\":-1,\"face_color\":0,\"dad\":31,\"hair_color_2\":10,\"eyebrows_6\":0,\"eye_squint\":0,\"nose_5\":0,\"tshirt_2\":0,\"age_1\":0,\"sun_1\":0,\"mask_2\":0,\"makeup_3\":0,\"helmet_1\":-1,\"chain_1\":0,\"chest_2\":0,\"jaw_2\":0,\"torso_1\":111,\"bodyb_2\":0,\"age_2\":0,\"eye_color\":10,\"skin_md_weight\":50,\"chin_2\":0,\"chin_1\":0,\"mom\":0,\"lip_thickness\":10,\"jaw_1\":0,\"arms_2\":0,\"bproof_2\":0,\"neck_thickness\":1,\"bodyb_1\":0,\"blush_2\":0,\"blemishes_1\":0,\"moles_2\":0,\"hair_color_1\":0,\"watches_1\":-1,\"cheeks_3\":0,\"decals_2\":0,\"bags_2\":0,\"arms\":12,\"cheeks_1\":0,\"chest_1\":0,\"lipstick_2\":0,\"beard_1\":3,\"complexion_2\":0,\"cheeks_2\":0,\"moles_1\":0,\"nose_6\":0,\"torso_2\":3,\"nose_3\":6,\"nose_1\":0,\"bproof_1\":100,\"eyebrows_1\":0,\"makeup_1\":0,\"hair_1\":12,\"beard_3\":0,\"helmet_2\":0,\"mask_1\":280,\"face_md_weight\":0,\"bracelets_1\":-1,\"pants_2\":0,\"blemishes_2\":0,\"decals_1\":0,\"pants_1\":10,\"chain_2\":0,\"nose_4\":0,\"sex\":0,\"lipstick_3\":0,\"bracelets_2\":0,\"lipstick_4\":0,\"nose_2\":0,\"chest_3\":0,\"bodyb_3\":-1,\"watches_2\":0,\"eyebrows_5\":0,\"eyebrows_3\":0,\"ears_2\":0,\"complexion_1\":0,\"bags_1\":0,\"chin_4\":0,\"chin_3\":0,\"sun_2\":0,\"makeup_4\":0,\"eyebrows_4\":0,\"shoes_2\":6,\"beard_2\":10,\"blush_3\":0,\"blush_1\":0,\"eyebrows_2\":10,\"tshirt_1\":229}},{\"grade\":false,\"name\":\"Barman\",\"grades\":[],\"data\":{\"shoes_1\":3,\"glasses_1\":62,\"lipstick_1\":0,\"hair_2\":0,\"bodyb_4\":0,\"glasses_2\":0,\"beard_4\":0,\"makeup_2\":0,\"ears_1\":-1,\"face_color\":0,\"dad\":31,\"hair_color_2\":10,\"bracelets_2\":0,\"eye_squint\":0,\"nose_5\":0,\"tshirt_2\":4,\"age_1\":0,\"sun_1\":0,\"mask_2\":0,\"makeup_3\":0,\"helmet_1\":-1,\"nose_1\":0,\"chest_2\":0,\"jaw_2\":0,\"torso_1\":11,\"bodyb_2\":0,\"age_2\":0,\"eye_color\":10,\"skin_md_weight\":50,\"chin_2\":0,\"chin_1\":0,\"mom\":0,\"lip_thickness\":10,\"jaw_1\":0,\"arms_2\":0,\"bproof_2\":0,\"neck_thickness\":1,\"bodyb_1\":0,\"blush_2\":0,\"bags_2\":0,\"moles_2\":0,\"hair_color_1\":0,\"watches_1\":-1,\"cheeks_3\":0,\"decals_2\":0,\"blemishes_2\":0,\"arms\":11,\"helmet_2\":0,\"chest_1\":0,\"lipstick_2\":0,\"beard_1\":3,\"complexion_2\":0,\"cheeks_2\":0,\"moles_1\":0,\"face_md_weight\":0,\"torso_2\":2,\"nose_3\":6,\"eyebrows_5\":0,\"bproof_1\":0,\"eyebrows_1\":0,\"makeup_1\":0,\"hair_1\":12,\"beard_3\":0,\"nose_6\":0,\"watches_2\":0,\"chain_2\":0,\"bracelets_1\":-1,\"pants_2\":3,\"decals_1\":0,\"blemishes_1\":0,\"blush_3\":0,\"eyebrows_4\":0,\"nose_4\":0,\"sex\":0,\"lipstick_3\":0,\"pants_1\":10,\"lipstick_4\":0,\"eyebrows_6\":0,\"chest_3\":0,\"bodyb_3\":-1,\"cheeks_1\":0,\"nose_2\":0,\"eyebrows_3\":0,\"ears_2\":0,\"complexion_1\":0,\"bags_1\":0,\"chin_4\":0,\"chin_3\":0,\"sun_2\":0,\"makeup_4\":0,\"chain_1\":0,\"shoes_2\":2,\"beard_2\":10,\"mask_1\":280,\"blush_1\":0,\"eyebrows_2\":10,\"tshirt_1\":7}}]', '{\"y\":83.89933013916016,\"x\":-3028.209228515625,\"z\":12.35983371734619}'),
(70, 'restau_catcafe', 'CatCafe', NULL, '{\"chest\":{\"boss\":true},\"weapons_chest\":{\"boss\":true},\"create_grade\":{\"boss\":true},\"deposit_item_chest\":{\"boss\":true},\"deposit_weapon_chest\":{\"boss\":true},\"unmote_player\":{\"boss\":true},\"withdraw_money_society\":{\"boss\":true},\"items_chest\":{\"boss\":true},\"items_chest:society\":{\"boss\":true},\"remove_item_chest\":{\"boss\":true},\"remove_item_chest_society\":{\"boss\":true},\"open_boss\":{\"boss\":true},\"deposit_black_money_coffre\":{\"boss\":true},\"remove_weapon_chest\":{\"boss\":true},\"rename_label_grade\":{\"boss\":true},\"deposit_cash_coffre\":{\"boss\":true},\"delete_grade\":{\"boss\":true},\"deposit_money_society\":{\"boss\":true},\"dposit_item_chest_society\":{\"boss\":true},\"open_coffre\":{\"boss\":true},\"change_salary_grade\":{\"boss\":true},\"withdraw_cash_coffre\":{\"boss\":true},\"withdraw_black_money_coffre\":{\"boss\":true},\"editClothes\":{\"boss\":true},\"demote_player\":{\"boss\":true},\"promote_player\":{\"boss\":true},\"deposit_weapon_chest_society\":{\"boss\":true},\"manage_employeds\":{\"boss\":true},\"rename_grade\":{\"boss\":true},\"change_number_grade\":{\"boss\":true},\"change_permissions_grade\":{\"boss\":true},\"remove_weapon_chest_society\":{\"boss\":true},\"manage_grades\":{\"boss\":true},\"recruit_player\":{\"boss\":true},\"weapons_chest_society\":{\"boss\":true}}', '{\"x\":-589.2982788085938,\"y\":-1067.9344482421876,\"z\":22.35098457336425}', '{\"x\":-577.4599609375,\"y\":-1067.5218505859376,\"z\":26.61410140991211}', '{\"sprite\":89,\"position\":{\"x\":-580.9511108398438,\"y\":-1071.050048828125,\"z\":22.32953071594238},\"color\":34,\"active\":true}', '0', 1, '[]', '{\"x\":-586.5808715820313,\"y\":-1050.059814453125,\"z\":22.34414291381836}'),
(71, 'bar_tequila', 'Tequila', NULL, '{\"chest\":{\"boss\":true},\"weapons_chest\":{\"boss\":true},\"create_grade\":{\"boss\":true},\"deposit_item_chest\":{\"boss\":true},\"deposit_weapon_chest\":{\"boss\":true},\"unmote_player\":{\"boss\":true},\"withdraw_money_society\":{\"boss\":true},\"items_chest\":{\"boss\":true},\"items_chest:society\":{\"boss\":true},\"remove_item_chest\":{\"boss\":true},\"remove_item_chest_society\":{\"boss\":true},\"open_boss\":{\"boss\":true},\"deposit_black_money_coffre\":{\"boss\":true},\"remove_weapon_chest\":{\"boss\":true},\"rename_label_grade\":{\"boss\":true},\"deposit_cash_coffre\":{\"boss\":true},\"delete_grade\":{\"boss\":true},\"deposit_money_society\":{\"boss\":true},\"dposit_item_chest_society\":{\"boss\":true},\"open_coffre\":{\"boss\":true},\"change_salary_grade\":{\"boss\":true},\"withdraw_cash_coffre\":{\"boss\":true},\"withdraw_black_money_coffre\":{\"boss\":true},\"editClothes\":{\"boss\":true},\"demote_player\":{\"boss\":true},\"promote_player\":{\"boss\":true},\"deposit_weapon_chest_society\":{\"boss\":true},\"manage_employeds\":{\"boss\":true},\"rename_grade\":{\"boss\":true},\"change_number_grade\":{\"boss\":true},\"change_permissions_grade\":{\"boss\":true},\"remove_weapon_chest_society\":{\"boss\":true},\"manage_grades\":{\"boss\":true},\"recruit_player\":{\"boss\":true},\"weapons_chest_society\":{\"boss\":true}}', '{\"x\":-561.85595703125,\"y\":289.775390625,\"z\":82.1761703491211}', '{\"x\":-576.2147827148438,\"y\":288.4426574707031,\"z\":79.17679595947266}', '{\"sprite\":93,\"position\":{\"x\":-564.6791381835938,\"y\":275.5182800292969,\"z\":83.04684448242188},\"color\":66,\"active\":true}', '0', 1, '[]', '{\"x\":-563.2454223632813,\"y\":287.3268737792969,\"z\":85.37666320800781}'),
(72, 'bar_beachclub', 'Beach Club', NULL, '{\"chest\":{\"boss\":true},\"weapons_chest\":{\"boss\":true},\"create_grade\":{\"boss\":true},\"deposit_item_chest\":{\"boss\":true},\"deposit_weapon_chest\":{\"boss\":true},\"unmote_player\":{\"boss\":true},\"withdraw_money_society\":{\"boss\":true},\"items_chest\":{\"boss\":true},\"items_chest:society\":{\"boss\":true},\"remove_item_chest\":{\"boss\":true},\"remove_item_chest_society\":{\"boss\":true},\"open_boss\":{\"boss\":true},\"deposit_black_money_coffre\":{\"boss\":true},\"remove_weapon_chest\":{\"boss\":true},\"rename_label_grade\":{\"boss\":true},\"deposit_cash_coffre\":{\"boss\":true},\"delete_grade\":{\"boss\":true},\"deposit_money_society\":{\"boss\":true},\"dposit_item_chest_society\":{\"boss\":true},\"open_coffre\":{\"boss\":true},\"change_salary_grade\":{\"boss\":true},\"withdraw_cash_coffre\":{\"boss\":true},\"withdraw_black_money_coffre\":{\"boss\":true},\"editClothes\":{\"boss\":true},\"demote_player\":{\"boss\":true},\"promote_player\":{\"boss\":true},\"deposit_weapon_chest_society\":{\"boss\":true},\"manage_employeds\":{\"boss\":true},\"rename_grade\":{\"boss\":true},\"change_number_grade\":{\"boss\":true},\"change_permissions_grade\":{\"boss\":true},\"remove_weapon_chest_society\":{\"boss\":true},\"manage_grades\":{\"boss\":true},\"recruit_player\":{\"boss\":true},\"weapons_chest_society\":{\"boss\":true}}', '{\"x\":-1831.4942626953126,\"y\":-771.742919921875,\"z\":8.63294315338134}', '{\"x\":-1829.4952392578126,\"y\":-774.0812377929688,\"z\":8.63290119171142}', '{\"sprite\":93,\"position\":{\"x\":-1833.158203125,\"y\":-776.1387939453125,\"z\":8.63294792175293},\"color\":36,\"active\":true}', '0', 1, '[]', '{\"x\":-1830.2406005859376,\"y\":-762.0389404296875,\"z\":8.31728839874267}'),
(74, 'ltd_arena', 'LTD Arena', NULL, '{\"chest\":{\"boss\":true},\"weapons_chest\":{\"boss\":true},\"create_grade\":{\"boss\":true},\"deposit_item_chest\":{\"boss\":true},\"deposit_weapon_chest\":{\"boss\":true},\"unmote_player\":{\"boss\":true},\"withdraw_money_society\":{\"boss\":true},\"items_chest\":{\"boss\":true},\"items_chest:society\":{\"boss\":true},\"remove_item_chest\":{\"boss\":true},\"remove_item_chest_society\":{\"boss\":true},\"open_boss\":{\"boss\":true},\"deposit_black_money_coffre\":{\"boss\":true},\"remove_weapon_chest\":{\"boss\":true},\"rename_label_grade\":{\"boss\":true},\"deposit_cash_coffre\":{\"boss\":true},\"delete_grade\":{\"boss\":true},\"deposit_money_society\":{\"boss\":true},\"dposit_item_chest_society\":{\"boss\":true},\"open_coffre\":{\"boss\":true},\"change_salary_grade\":{\"boss\":true},\"withdraw_cash_coffre\":{\"boss\":true},\"withdraw_black_money_coffre\":{\"boss\":true},\"editClothes\":{\"boss\":true},\"demote_player\":{\"boss\":true},\"promote_player\":{\"boss\":true},\"deposit_weapon_chest_society\":{\"boss\":true},\"manage_employeds\":{\"boss\":true},\"rename_grade\":{\"boss\":true},\"change_number_grade\":{\"boss\":true},\"change_permissions_grade\":{\"boss\":true},\"remove_weapon_chest_society\":{\"boss\":true},\"manage_grades\":{\"boss\":true},\"recruit_player\":{\"boss\":true},\"weapons_chest_society\":{\"boss\":true}}', '{\"x\":-354.58465576171877,\"y\":-1476.4898681640626,\"z\":30.74797439575195}', '{\"x\":-351.9770202636719,\"y\":-1481.4559326171876,\"z\":30.74867630004882}', '{\"sprite\":59,\"position\":{\"x\":-342.2063903808594,\"y\":-1483.3114013671876,\"z\":30.72286415100097},\"color\":2,\"active\":true}', '0', 1, '[]', '{\"x\":-355.1205139160156,\"y\":-1479.0557861328126,\"z\":30.74793624877929}'),
(75, 'garage_octacyp', 'Octa Cyp Garage', '{\"weapons_boss\":[],\"items_boss\":[],\"weapons\":[],\"items\":[],\"accounts\":{\"cash\":0,\"black_money\":0,\"society\":0}}', '{\"weapons_chest_society\":{\"boss\":true},\"deposit_cash_coffre\":{\"boss\":true},\"remove_weapon_chest_society\":{\"boss\":true},\"open_coffre\":{\"boss\":true},\"recruit_player\":{\"boss\":true},\"open_boss\":{\"boss\":true},\"deposit_weapon_chest_society\":{\"boss\":true},\"withdraw_money_society\":{\"boss\":true},\"weapons_chest\":{\"boss\":true},\"dposit_item_chest_society\":{\"boss\":true},\"deposit_item_chest\":{\"boss\":true},\"rename_label_grade\":{\"boss\":true},\"deposit_weapon_chest\":{\"boss\":true},\"manage_grades\":{\"boss\":true},\"editClothes\":{\"boss\":true},\"deposit_black_money_coffre\":{\"boss\":true},\"change_number_grade\":{\"boss\":true},\"items_chest\":{\"boss\":true},\"delete_grade\":{\"boss\":true},\"unmote_player\":{\"boss\":true},\"chest\":{\"boss\":true},\"remove_item_chest\":{\"boss\":true},\"withdraw_cash_coffre\":{\"boss\":true},\"items_chest:society\":{\"boss\":true},\"withdraw_black_money_coffre\":{\"boss\":true},\"change_permissions_grade\":{\"boss\":true},\"remove_weapon_chest\":{\"boss\":true},\"promote_player\":{\"boss\":true},\"demote_player\":{\"boss\":true},\"remove_item_chest_society\":{\"boss\":true},\"manage_employeds\":{\"boss\":true},\"change_salary_grade\":{\"boss\":true},\"deposit_money_society\":{\"boss\":true},\"rename_grade\":{\"boss\":true},\"create_grade\":{\"boss\":true}}', '{\"y\":-1363.70361328125,\"z\":34.91529846191406,\"x\":-193.67124938964845}', '{\"y\":-1362.3480224609376,\"z\":34.91531372070312,\"x\":-195.7763824462891}', '{\"active\":true,\"position\":{\"y\":-1377.9495849609376,\"z\":31.25924301147461,\"x\":-201.8139190673828},\"sprite\":446,\"color\":2}', '0', 1, '[]', '{\"y\":-1371.2496337890626,\"z\":34.91531372070312,\"x\":-192.8826446533203}'),
(76, 'garage_driveline', 'Driveline Garage', '{\"accounts\":{\"black_money\":0,\"cash\":0,\"society\":0},\"weapons_boss\":[],\"items_boss\":[],\"items\":[],\"weapons\":[]}', '{\"weapons_chest\":{\"boss\":true},\"remove_weapon_chest\":{\"boss\":true},\"items_chest:society\":{\"boss\":true},\"create_grade\":{\"boss\":true},\"remove_item_chest\":{\"boss\":true},\"chest\":{\"boss\":true},\"deposit_weapon_chest_society\":{\"boss\":true},\"delete_grade\":{\"boss\":true},\"change_permissions_grade\":{\"boss\":true},\"change_number_grade\":{\"boss\":true},\"remove_weapon_chest_society\":{\"boss\":true},\"withdraw_cash_coffre\":{\"boss\":true},\"unmote_player\":{\"boss\":true},\"deposit_weapon_chest\":{\"boss\":true},\"demote_player\":{\"boss\":true},\"manage_employeds\":{\"boss\":true},\"weapons_chest_society\":{\"boss\":true},\"change_salary_grade\":{\"boss\":true},\"dposit_item_chest_society\":{\"boss\":true},\"deposit_money_society\":{\"boss\":true},\"open_coffre\":{\"boss\":true},\"deposit_black_money_coffre\":{\"boss\":true},\"promote_player\":{\"boss\":true},\"rename_grade\":{\"boss\":true},\"manage_grades\":{\"boss\":true},\"deposit_cash_coffre\":{\"boss\":true},\"recruit_player\":{\"boss\":true},\"open_boss\":{\"boss\":true},\"rename_label_grade\":{\"boss\":true},\"deposit_item_chest\":{\"boss\":true},\"items_chest\":{\"boss\":true},\"editClothes\":{\"boss\":true},\"remove_item_chest_society\":{\"boss\":true},\"withdraw_money_society\":{\"boss\":true},\"withdraw_black_money_coffre\":{\"boss\":true}}', '{\"y\":-416.0677490234375,\"x\":-816.6361083984375,\"z\":36.6374626159668}', '{\"y\":-412.0268249511719,\"x\":-810.2774047851563,\"z\":36.67690658569336}', '{\"sprite\":446,\"position\":{\"y\":-428.0570068359375,\"x\":-826.0863647460938,\"z\":36.641357421875},\"color\":27,\"active\":true}', '0', 1, '[]', '{\"y\":-413.7039184570313,\"x\":-816.5299682617188,\"z\":40.38003921508789}'),
(77, 'garage_eastcustoms', 'East Customs', '{\"weapons_boss\":[],\"items\":[],\"accounts\":{\"cash\":0,\"black_money\":0,\"society\":0},\"weapons\":[],\"items_boss\":[]}', '{\"dposit_item_chest_society\":{\"boss\":true},\"remove_item_chest_society\":{\"boss\":true},\"deposit_weapon_chest_society\":{\"boss\":true},\"remove_weapon_chest\":{\"boss\":true},\"withdraw_money_society\":{\"boss\":true},\"deposit_black_money_coffre\":{\"boss\":true},\"deposit_weapon_chest\":{\"boss\":true},\"open_coffre\":{\"boss\":true},\"withdraw_cash_coffre\":{\"boss\":true},\"demote_player\":{\"boss\":true},\"unmote_player\":{\"boss\":true},\"items_chest\":{\"boss\":true},\"remove_item_chest\":{\"boss\":true},\"promote_player\":{\"boss\":true},\"create_grade\":{\"boss\":true},\"deposit_money_society\":{\"boss\":true},\"rename_grade\":{\"boss\":true},\"change_permissions_grade\":{\"boss\":true},\"items_chest:society\":{\"boss\":true},\"change_salary_grade\":{\"boss\":true},\"recruit_player\":{\"boss\":true},\"deposit_cash_coffre\":{\"boss\":true},\"open_boss\":{\"boss\":true},\"chest\":{\"boss\":true},\"manage_grades\":{\"boss\":true},\"withdraw_black_money_coffre\":{\"boss\":true},\"weapons_chest\":{\"boss\":true},\"editClothes\":{\"boss\":true},\"remove_weapon_chest_society\":{\"boss\":true},\"deposit_item_chest\":{\"boss\":true},\"change_number_grade\":{\"boss\":true},\"weapons_chest_society\":{\"boss\":true},\"manage_employeds\":{\"boss\":true},\"rename_label_grade\":{\"boss\":true},\"delete_grade\":{\"boss\":true}}', '{\"z\":34.8885383605957,\"y\":-2099.921875,\"x\":898.4995727539063}', '{\"z\":34.88854217529297,\"y\":-2099.382568359375,\"x\":886.8599853515625}', '{\"position\":{\"z\":30.50685119628906,\"y\":-2113.13671875,\"x\":869.548095703125},\"sprite\":446,\"active\":true,\"color\":27}', '0', 1, '[]', '{\"z\":30.46023941040039,\"y\":-2097.070556640625,\"x\":877.8755493164063}'),
(78, 'garage_paletocustoms', 'Paleto Customs', NULL, '{\"chest\":{\"boss\":true},\"weapons_chest\":{\"boss\":true},\"create_grade\":{\"boss\":true},\"deposit_item_chest\":{\"boss\":true},\"deposit_weapon_chest\":{\"boss\":true},\"unmote_player\":{\"boss\":true},\"withdraw_money_society\":{\"boss\":true},\"items_chest\":{\"boss\":true},\"items_chest:society\":{\"boss\":true},\"remove_item_chest\":{\"boss\":true},\"remove_item_chest_society\":{\"boss\":true},\"open_boss\":{\"boss\":true},\"deposit_black_money_coffre\":{\"boss\":true},\"remove_weapon_chest\":{\"boss\":true},\"rename_label_grade\":{\"boss\":true},\"deposit_cash_coffre\":{\"boss\":true},\"delete_grade\":{\"boss\":true},\"deposit_money_society\":{\"boss\":true},\"dposit_item_chest_society\":{\"boss\":true},\"open_coffre\":{\"boss\":true},\"change_salary_grade\":{\"boss\":true},\"withdraw_cash_coffre\":{\"boss\":true},\"withdraw_black_money_coffre\":{\"boss\":true},\"editClothes\":{\"boss\":true},\"demote_player\":{\"boss\":true},\"promote_player\":{\"boss\":true},\"deposit_weapon_chest_society\":{\"boss\":true},\"manage_employeds\":{\"boss\":true},\"rename_grade\":{\"boss\":true},\"change_number_grade\":{\"boss\":true},\"change_permissions_grade\":{\"boss\":true},\"remove_weapon_chest_society\":{\"boss\":true},\"manage_grades\":{\"boss\":true},\"recruit_player\":{\"boss\":true},\"weapons_chest_society\":{\"boss\":true}}', '{\"x\":-242.16453552246095,\"y\":6073.89990234375,\"z\":31.38951110839843}', '{\"x\":-229.12408447265626,\"y\":6079.478515625,\"z\":31.37823867797851}', '{\"sprite\":446,\"position\":{\"x\":869.548095703125,\"y\":-2113.13671875,\"z\":30.50685119628906},\"color\":60,\"active\":true}', '0', 1, '[]', '{\"x\":-247.47232055664063,\"y\":6072.17578125,\"z\":31.38492393493652}'),
(79, 'garage_speedhunters', 'Speed Hunters', NULL, '{\"deposit_cash_coffre\":{\"boss\":true},\"remove_weapon_chest\":{\"boss\":true},\"create_grade\":{\"boss\":true},\"weapons_chest\":{\"boss\":true},\"withdraw_cash_coffre\":{\"boss\":true},\"manage_grades\":{\"boss\":true},\"withdraw_money_society\":{\"boss\":true},\"demote_player\":{\"boss\":true},\"change_permissions_grade\":{\"boss\":true},\"withdraw_black_money_coffre\":{\"boss\":true},\"remove_item_chest_society\":{\"boss\":true},\"delete_grade\":{\"boss\":true},\"remove_item_chest\":{\"boss\":true},\"editClothes\":{\"boss\":true},\"manage_employeds\":{\"boss\":true},\"unmote_player\":{\"boss\":true},\"dposit_item_chest_society\":{\"boss\":true},\"deposit_weapon_chest_society\":{\"boss\":true},\"items_chest\":{\"boss\":true},\"recruit_player\":{\"boss\":true},\"change_number_grade\":{\"boss\":true},\"change_salary_grade\":{\"boss\":true},\"rename_label_grade\":{\"boss\":true},\"rename_grade\":{\"boss\":true},\"open_coffre\":{\"boss\":true},\"promote_player\":{\"boss\":true},\"deposit_black_money_coffre\":{\"boss\":true},\"items_chest:society\":{\"boss\":true},\"remove_weapon_chest_society\":{\"boss\":true},\"weapons_chest_society\":{\"boss\":true},\"deposit_weapon_chest\":{\"boss\":true},\"chest\":{\"boss\":true},\"deposit_item_chest\":{\"boss\":true},\"open_boss\":{\"boss\":true},\"deposit_money_society\":{\"boss\":true}}', '{\"x\":2731.2177734375,\"y\":3499.056884765625,\"z\":55.52353286743164}', '{\"x\":2728.6318359375,\"y\":3483.97412109375,\"z\":61.58583450317383}', '{\"position\":{\"x\":2750.90234375,\"y\":3471.458740234375,\"z\":55.68634033203125},\"color\":48,\"active\":true,\"sprite\":446}', '0', 1, '[]', '{\"x\":2730.07568359375,\"y\":3496.480712890625,\"z\":55.52352523803711}');

-- --------------------------------------------------------

--
-- Structure de la table `sunny_afk_players`
--

CREATE TABLE `sunny_afk_players` (
  `UniqueID` int(11) DEFAULT 0,
  `points` longtext DEFAULT '0',
  `time` longtext DEFAULT '0',
  `inZone` tinyint(1) DEFAULT 0,
  `skin` longtext DEFAULT 'none',
  `playerName` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `sunny_clothes`
--

CREATE TABLE `sunny_clothes` (
  `id` int(11) NOT NULL,
  `type` varchar(60) NOT NULL,
  `identifier` varchar(60) DEFAULT NULL,
  `name` longtext DEFAULT NULL,
  `data` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `sunny_trunk`
--

CREATE TABLE `sunny_trunk` (
  `info` longtext DEFAULT NULL,
  `data` longtext DEFAULT NULL,
  `id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `territoires`
--

CREATE TABLE `territoires` (
  `id` int(11) NOT NULL,
  `territory_name` varchar(100) NOT NULL,
  `id_crew` int(11) DEFAULT NULL,
  `score_total` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

CREATE TABLE `users` (
  `UniqueID` int(11) NOT NULL,
  `identifier` varchar(50) DEFAULT NULL,
  `money` int(11) DEFAULT NULL,
  `playerName` longtext DEFAULT NULL,
  `skin` longtext DEFAULT NULL,
  `job` varchar(50) DEFAULT 'unemployed',
  `job_grade` int(11) DEFAULT 0,
  `job2` varchar(255) DEFAULT 'unemployed2',
  `job2_grade` int(11) DEFAULT 0,
  `loadout` longtext NOT NULL DEFAULT '[]',
  `inventory` longtext NOT NULL DEFAULT '[]',
  `accounts` longtext DEFAULT NULL,
  `position` varchar(255) DEFAULT NULL,
  `bank` int(11) DEFAULT NULL,
  `permission_level` int(11) DEFAULT NULL,
  `permission_group` varchar(50) DEFAULT NULL,
  `firstname` varchar(50) DEFAULT '',
  `lastname` varchar(50) DEFAULT '',
  `dateofbirth` varchar(25) DEFAULT '',
  `sex` varchar(10) DEFAULT '',
  `height` varchar(5) DEFAULT '',
  `status` longtext DEFAULT NULL,
  `clothes` longtext DEFAULT NULL,
  `tattoos` longtext DEFAULT NULL,
  `phone_number` varchar(10) DEFAULT NULL,
  `is_dead` tinyint(1) DEFAULT 0,
  `last_property` varchar(255) DEFAULT NULL,
  `rank` varchar(50) DEFAULT NULL,
  `ip` longtext DEFAULT NULL,
  `life` longtext DEFAULT NULL,
  `connected` tinyint(1) DEFAULT 0,
  `sunnycoins` int(11) NOT NULL DEFAULT 0,
  `totalCoins` text NOT NULL DEFAULT '0',
  `warns` longtext NOT NULL DEFAULT '[]',
  `boutiquereward` tinyint(4) DEFAULT 0,
  `apps` text DEFAULT NULL,
  `widget` text DEFAULT NULL,
  `bt` text DEFAULT NULL,
  `charinfo` text DEFAULT NULL,
  `metadata` mediumtext DEFAULT NULL,
  `cryptocurrency` longtext DEFAULT NULL,
  `cryptocurrencytransfers` text DEFAULT NULL,
  `phonePos` text DEFAULT NULL,
  `spotify` text DEFAULT NULL,
  `ringtone` text DEFAULT NULL,
  `first_screen_showed` int(11) DEFAULT NULL,
  `xp` int(11) DEFAULT 1,
  `vie` int(55) NOT NULL DEFAULT 200,
  `report` longtext DEFAULT NULL CHECK (json_valid(`report`)),
  `reports_taken` int(11) DEFAULT 0,
  `ranks` varchar(255) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- --------------------------------------------------------

--
-- Structure de la table `user_licenses`
--

CREATE TABLE `user_licenses` (
  `id` int(11) NOT NULL,
  `type` varchar(60) NOT NULL,
  `owner` varchar(60) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `vehicles_boutique`
--

CREATE TABLE `vehicles_boutique` (
  `name` longtext DEFAULT NULL,
  `label` longtext DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `type` longtext NOT NULL DEFAULT 'car'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `vehicles_boutique`
--

INSERT INTO `vehicles_boutique` (`name`, `label`, `price`, `type`) VALUES
('sultanrs', 'Sultanrs', 1000, 'car');

-- --------------------------------------------------------

--
-- Structure de la table `vehicle_catalogue`
--

CREATE TABLE `vehicle_catalogue` (
  `name` varchar(60) NOT NULL,
  `label` varchar(60) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `vehicle_catalogue`
--

INSERT INTO `vehicle_catalogue` (`name`, `label`) VALUES
('compacts', 'Compacts'),
('coupes', 'Coupes'),
('motorcycles', 'Motos'),
('muscle', 'Muscle'),
('offroad', 'Off Road'),
('sedans', 'Sedans'),
('sports', 'Sports'),
('sportsclassics', 'Sports Classics'),
('super', 'Super'),
('suvs', 'SUVs'),
('vans', 'Vans');

-- --------------------------------------------------------

--
-- Structure de la table `vehicle_categories`
--

CREATE TABLE `vehicle_categories` (
  `name` varchar(60) NOT NULL,
  `label` varchar(60) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `vehicle_categories`
--

INSERT INTO `vehicle_categories` (`name`, `label`) VALUES
('compacts', 'Compacts'),
('coupes', 'Coupes'),
('ENTREPRISE', 'Entreprise'),
('Imports', 'Imports'),
('muscle', 'Muscle'),
('offroad', 'Off Road'),
('sedans', 'Sedans'),
('sports', 'Sports'),
('sportsclassics', 'Sports Classics'),
('super', 'Super'),
('suvs', 'SUVs'),
('vans', 'Vans');

-- --------------------------------------------------------

--
-- Structure de la table `vehicules`
--

CREATE TABLE `vehicules` (
  `id` int(12) NOT NULL,
  `job` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `model` varchar(255) NOT NULL,
  `price` int(12) NOT NULL,
  `category` varchar(255) NOT NULL,
  `ytd` varchar(255) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `vehicules`
--

INSERT INTO `vehicules` (`id`, `job`, `name`, `model`, `price`, `category`, `ytd`, `image`) VALUES
(3, 'cardealer', 'Alpha', 'alpha', 60000, 'sports', NULL, NULL),
(4, 'cardealer', 'asbo', 'asbo', 8000, 'compacts', NULL, NULL),
(5, 'cardealer', 'Asea', 'asea', 5500, 'sedans', NULL, NULL),
(6, 'cardealer', 'asterope', 'asterope', 45000, 'sedans', NULL, NULL),
(8, 'motodealer', 'Avarus', 'avarus', 25000, 'motorcycles', NULL, NULL),
(9, 'motodealer', 'Bagger', 'bagger', 20000, 'motorcycles', NULL, NULL),
(12, 'cardealer', 'Baller Sport', 'baller4', 60000, 'suvs', NULL, NULL),
(13, 'cardealer', 'Banshee', 'banshee', 70000, 'sports', NULL, NULL),
(14, 'cardealer', 'Banshee 900R', 'banshee2', 47000, 'super', NULL, NULL),
(15, 'motodealer', 'Bati 801', 'bati', 20000, 'motorcycles', NULL, NULL),
(16, 'motodealer', 'Bati 801RR', 'bati2', 40000, 'motorcycles', NULL, NULL),
(17, 'cardealer', 'Bestia GTS', 'bestiagts', 95000, 'sports', NULL, NULL),
(18, 'motodealer', 'BF400', 'bf400', 25000, 'motorcycles', NULL, NULL),
(19, 'cardealer', 'Bf Injection', 'bfinjection', 16000, 'offroad', NULL, NULL),
(20, 'cardealer', 'Bifta', 'bifta', 12000, 'offroad', NULL, NULL),
(21, 'cardealer', 'Bison', 'bison', 45000, 'vans', NULL, NULL),
(22, 'cardealer', 'bison2', 'bison2', 20000, 'vans', NULL, NULL),
(23, 'cardealer', 'bjxl', 'bjxl', 45000, 'suvs', NULL, NULL),
(24, 'cardealer', 'Blade', 'blade', 15000, 'muscle', NULL, NULL),
(25, 'cardealer', 'Blazer', 'blazer', 6500, 'offroad', NULL, NULL),
(26, 'cardealer', 'Blazer Sport', 'blazer4', 8500, 'offroad', NULL, NULL),
(27, 'cardealer', 'Blista', 'blista', 8000, 'compacts', NULL, NULL),
(28, 'cardealer', 'blista2', 'blista2', 45000, 'sports', NULL, NULL),
(29, 'cardealer', 'blista3', 'blista3', 45000, 'sports', NULL, NULL),
(30, 'cardealer', 'BMX', 'bmx', 160, 'motorcycles', NULL, NULL),
(31, 'cardealer', 'Bobcat XL', 'bobcatxl', 32000, 'vans', NULL, NULL),
(32, 'cardealer', 'bodhi2', 'bodhi2', 45000, 'offroad', NULL, NULL),
(33, 'cardealer', 'Brawler', 'brawler', 45000, 'offroad', NULL, NULL),
(34, 'cardealer', 'Brioso R/A', 'brioso', 18000, 'compacts', NULL, NULL),
(35, 'cardealer', 'brioso2', 'brioso2', 8000, 'compacts', NULL, NULL),
(36, 'cardealer', 'Btype', 'btype', 62000, 'sportsclassics', NULL, NULL),
(37, 'cardealer', 'Btype Hotroad', 'btype2', 155000, 'sportsclassics', NULL, NULL),
(38, 'cardealer', 'Btype Luxe', 'btype3', 85000, 'sportsclassics', NULL, NULL),
(39, 'cardealer', 'Buccaneer', 'buccaneer', 18000, 'muscle', NULL, NULL),
(40, 'cardealer', 'Buccaneer Rider', 'buccaneer2', 24000, 'muscle', NULL, NULL),
(41, 'cardealer', 'Buffalo', 'buffalo', 22000, 'sports', NULL, NULL),
(42, 'cardealer', 'Buffalo S', 'buffalo2', 26000, 'sports', NULL, NULL),
(44, 'cardealer', 'Bullet', 'bullet', 90000, 'super', NULL, NULL),
(45, 'cardealer', 'burrito2', 'burrito2', 20000, 'vans', NULL, NULL),
(46, 'cardealer', 'Burrito', 'burrito3', 49000, 'vans', NULL, NULL),
(47, 'cardealer', 'burrito4', 'burrito4', 20000, 'vans', NULL, NULL),
(49, 'cardealer', 'Carbonizzare', 'carbonizzare', 75000, 'sports', NULL, NULL),
(50, 'motodealer', 'Carbon RS', 'carbonrs', 38000, 'motorcycles', NULL, NULL),
(51, 'cardealer', 'Casco', 'casco', 55000, 'sportsclassics', NULL, NULL),
(52, 'cardealer', 'cavalcade', 'cavalcade', 45000, 'suvs', NULL, NULL),
(53, 'cardealer', 'Cavalcade', 'cavalcade2', 55000, 'suvs', NULL, NULL),
(54, 'cardealer', 'Cheburek', 'cheburek', 20000, 'sedans', NULL, NULL),
(57, 'cardealer', 'Chimera', 'chimera', 25000, 'motorcycles', NULL, NULL),
(58, 'cardealer', 'Chino', 'chino', 15000, 'muscle', NULL, NULL),
(59, 'cardealer', 'Chino Luxe', 'chino2', 19000, 'muscle', NULL, NULL),
(60, 'motodealer', 'Cliffhanger', 'cliffhanger', 20000, 'motorcycles', NULL, NULL),
(61, 'cardealer', 'clique', 'clique', 45000, 'muscle', NULL, NULL),
(62, 'cardealer', 'club', 'club', 8000, 'compacts', NULL, NULL),
(63, 'cardealer', 'cog55', 'cog55', 45000, 'sedans', NULL, NULL),
(64, 'cardealer', 'Cognoscenti Cabrio', 'cogcabrio', 55000, 'coupes', NULL, NULL),
(65, 'cardealer', 'Cognoscenti', 'cognoscenti', 55000, 'sedans', NULL, NULL),
(66, 'cardealer', 'Comet', 'comet2', 72000, 'sports', NULL, NULL),
(67, 'cardealer', 'Comet 5', 'comet5', 145000, 'sports', NULL, NULL),
(68, 'cardealer', 'Contender', 'contender', 180000, 'suvs', NULL, NULL),
(69, 'cardealer', 'Coquette', 'coquette', 65000, 'sports', NULL, NULL),
(70, 'cardealer', 'Coquette Classic', 'coquette2', 40000, 'sportsclassics', NULL, NULL),
(71, 'cardealer', 'Coquette BlackFin', 'coquette3', 55000, 'muscle', NULL, NULL),
(72, 'cardealer', 'Cruiser', 'cruiser', 510, 'motorcycles', NULL, NULL),
(73, 'cardealer', 'Cyclone', 'cyclone', 189000, 'super', NULL, NULL),
(74, 'motodealer', 'Daemon', 'daemon', 20000, 'motorcycles', NULL, NULL),
(75, 'motodealer', 'Daemon High', 'daemon2', 30000, 'motorcycles', NULL, NULL),
(76, 'motodealer', 'Defiler', 'defiler', 30000, 'motorcycles', NULL, NULL),
(78, 'cardealer', 'deviant', 'deviant', 45000, 'muscle', NULL, NULL),
(79, 'motodealer', 'diablous', 'diablous', 45000, 'motorcycles', NULL, NULL),
(80, 'motodealer', 'diablous2', 'diablous2', 45000, 'motorcycles', NULL, NULL),
(81, 'cardealer', 'dilettante', 'dilettante', 8000, 'compacts', NULL, NULL),
(82, 'cardealer', 'dloader', 'dloader', 45000, 'offroad', NULL, NULL),
(83, 'cardealer', 'Dominator', 'dominator', 35000, 'muscle', NULL, NULL),
(84, 'cardealer', 'dominator2', 'dominator2', 45000, 'muscle', NULL, NULL),
(85, 'cardealer', 'dominator3', 'dominator3', 45000, 'muscle', NULL, NULL),
(86, 'motodealer', 'Double T', 'double', 28000, 'motorcycles', NULL, NULL),
(87, 'cardealer', 'drafter', 'drafter', 90000, 'sports', NULL, NULL),
(88, 'cardealer', 'Dubsta', 'dubsta', 45000, 'suvs', NULL, NULL),
(89, 'cardealer', 'Dubsta Luxuary', 'dubsta2', 90000, 'suvs', NULL, NULL),
(90, 'cardealer', 'Bubsta 6x6', 'dubsta3', 120000, 'offroad', NULL, NULL),
(91, 'cardealer', 'Dukes', 'dukes', 28000, 'muscle', NULL, NULL),
(92, 'cardealer', 'dukes3', 'dukes3', 45000, 'muscle', NULL, NULL),
(93, 'cardealer', 'Dune Buggy', 'dune', 8000, 'offroad', NULL, NULL),
(94, 'cardealer', 'dynasty', 'dynasty', 20000, 'sports', NULL, NULL),
(95, 'cardealer', 'Elegy', 'elegy', 90000, 'sports', NULL, NULL),
(96, 'cardealer', 'Elegy sport', 'elegy2', 95000, 'sports', NULL, NULL),
(97, 'cardealer', 'ellie', 'ellie', 45000, 'muscle', NULL, NULL),
(99, 'cardealer', 'Emperor', 'emperor', 8500, 'sedans', NULL, NULL),
(100, 'cardealer', 'emperor2', 'emperor2', 45000, 'sedans', NULL, NULL),
(101, 'motodealer', 'Enduro', 'enduro', 5500, 'motorcycles', NULL, NULL),
(104, 'motodealer', 'Esskey', 'esskey', 4200, 'motorcycles', NULL, NULL),
(105, 'cardealer', 'everon', 'everon', 45000, 'offroad', NULL, NULL),
(106, 'cardealer', 'Exemplar', 'exemplar', 56000, 'coupes', NULL, NULL),
(107, 'cardealer', 'F620', 'f620', 40000, 'coupes', NULL, NULL),
(108, 'cardealer', 'Faction', 'faction', 20000, 'muscle', NULL, NULL),
(109, 'cardealer', 'Faction Rider', 'faction2', 30000, 'muscle', NULL, NULL),
(110, 'cardealer', 'fagaloa', 'fagaloa', 20000, 'sports', NULL, NULL),
(112, 'motodealer', 'Faggio', 'faggio', 1900, 'motorcycles', NULL, NULL),
(113, 'motodealer', 'Vespa', 'faggio2', 2800, 'motorcycles', NULL, NULL),
(114, 'motodealer', 'faggio3', 'faggio3', 7000, 'motorcycles', NULL, NULL),
(115, 'motodealer', 'fcr', 'fcr', 45000, 'motorcycles', NULL, NULL),
(116, 'motodealer', 'fcr2', 'fcr2', 45000, 'motorcycles', NULL, NULL),
(117, 'cardealer', 'Felon', 'felon', 42000, 'coupes', NULL, NULL),
(118, 'cardealer', 'Felon GT', 'felon2', 55000, 'coupes', NULL, NULL),
(119, 'cardealer', 'Feltzer', 'feltzer2', 55000, 'sports', NULL, NULL),
(120, 'cardealer', 'Stirling GT', 'feltzer3', 65000, 'sportsclassics', NULL, NULL),
(121, 'cardealer', 'Fixter', 'fixter', 225, 'motorcycles', NULL, NULL),
(122, 'cardealer', 'flashgt', 'flashgt', 55000, 'sports', NULL, NULL),
(124, 'cardealer', 'Fhantom', 'fq2', 17000, 'suvs', NULL, NULL),
(125, 'cardealer', 'freecrawler', 'freecrawler', 45000, 'offroad', NULL, NULL),
(126, 'cardealer', 'Fugitive', 'fugitive', 12000, 'sedans', NULL, NULL),
(128, 'cardealer', 'Furore GT', 'furoregt', 45000, 'sports', NULL, NULL),
(129, 'cardealer', 'Fusilade', 'fusilade', 40000, 'sports', NULL, NULL),
(130, 'cardealer', 'futo', 'futo', 31000, 'sports', NULL, NULL),
(131, 'motodealer', 'Gargoyle', 'gargoyle', 16500, 'motorcycles', NULL, NULL),
(132, 'cardealer', 'Gauntlet', 'gauntlet', 30000, 'muscle', NULL, NULL),
(133, 'cardealer', 'gauntlet2', 'gauntlet2', 45000, 'muscle', NULL, NULL),
(134, 'cardealer', 'gauntlet3', 'gauntlet3', 45000, 'muscle', NULL, NULL),
(135, 'cardealer', 'gauntlet4', 'gauntlet4', 45000, 'muscle', NULL, NULL),
(136, 'cardealer', 'gauntlet5', 'gauntlet5', 45000, 'muscle', NULL, NULL),
(137, 'cardealer', 'gb200', 'gb200', 45000, 'sports', NULL, NULL),
(138, 'cardealer', 'Gang Burrito', 'gburrito', 45000, 'vans', NULL, NULL),
(139, 'cardealer', 'Burrito', 'gburrito2', 29000, 'vans', NULL, NULL),
(140, 'cardealer', 'Glendale', 'glendale', 16500, 'sedans', NULL, NULL),
(141, 'cardealer', 'glendale2', 'glendale2', 45000, 'sedans', NULL, NULL),
(142, 'cardealer', 'gp1', 'gp1', 112000, 'super', NULL, NULL),
(143, 'cardealer', 'Grabger', 'granger', 50000, 'suvs', NULL, NULL),
(144, 'cardealer', 'Gresley', 'gresley', 47500, 'suvs', NULL, NULL),
(145, 'cardealer', 'GT 500', 'gt500', 78500, 'sportsclassics', NULL, NULL),
(146, 'cardealer', 'Guardian', 'guardian', 235000, 'offroad', NULL, NULL),
(147, 'cardealer', 'habanero', 'habanero', 45000, 'suvs', NULL, NULL),
(148, 'motodealer', 'Hakuchou', 'hakuchou', 75000, 'motorcycles', NULL, NULL),
(149, 'motodealer', 'Hakuchou Sport', 'hakuchou2', 150000, 'motorcycles', NULL, NULL),
(150, 'cardealer', 'hellion', 'hellion', 45000, 'offroad', NULL, NULL),
(151, 'cardealer', 'Hermes', 'hermes', 255000, 'muscle', NULL, NULL),
(152, 'motodealer', 'Hexer', 'hexer', 12000, 'motorcycles', NULL, NULL),
(153, 'cardealer', 'Hotknife', 'hotknife', 125000, 'muscle', NULL, NULL),
(154, 'cardealer', 'hotring', 'hotring', 42000, 'sports', NULL, NULL),
(155, 'cardealer', 'Huntley S', 'huntley', 40000, 'suvs', NULL, NULL),
(156, 'cardealer', 'Hustler', 'hustler', 290000, 'muscle', NULL, NULL),
(157, 'cardealer', 'imorgon', 'imorgon', 70000, 'sports', NULL, NULL),
(158, 'cardealer', 'impaler', 'impaler', 45000, 'muscle', NULL, NULL),
(159, 'cardealer', 'Infernus', 'infernus', 180000, 'super', NULL, NULL),
(160, 'cardealer', 'infernus2', 'infernus2', 142000, 'sports', NULL, NULL),
(161, 'cardealer', 'ingot', 'ingot', 45000, 'sedans', NULL, NULL),
(162, 'motodealer', 'Innovation', 'innovation', 23500, 'motorcycles', NULL, NULL),
(163, 'cardealer', 'Intruder', 'intruder', 7500, 'sedans', NULL, NULL),
(164, 'cardealer', 'Issi', 'issi2', 10000, 'compacts', NULL, NULL),
(165, 'cardealer', 'issi3', 'issi3', 8000, 'compacts', NULL, NULL),
(166, 'cardealer', 'issi7', 'issi7', 80000, 'sports', NULL, NULL),
(167, 'cardealer', 'italigtb', 'italigtb', 129000, 'super', NULL, NULL),
(168, 'cardealer', 'italigtb2', 'italigtb2', 120000, 'super', NULL, NULL),
(169, 'cardealer', 'italigto', 'italigto', 110000, 'sports', NULL, NULL),
(171, 'cardealer', 'Jackal', 'jackal', 38000, 'coupes', NULL, NULL),
(172, 'cardealer', 'Jester', 'jester', 65000, 'sports', NULL, NULL),
(174, 'cardealer', 'jester3', 'jester3', 42000, 'sports', NULL, NULL),
(175, 'cardealer', 'Journey', 'journey', 42000, 'vans', NULL, NULL),
(176, 'cardealer', 'jugular', 'jugular', 165000, 'sports', NULL, NULL),
(177, 'cardealer', 'kalahari', 'kalahari', 45000, 'offroad', NULL, NULL),
(178, 'cardealer', 'Kamacho', 'kamacho', 170000, 'offroad', NULL, NULL),
(179, 'cardealer', 'kanjo', 'kanjo', 8000, 'compacts', NULL, NULL),
(180, 'cardealer', 'Khamelion', 'khamelion', 83000, 'sports', NULL, NULL),
(181, 'cardealer', 'komoda', 'komoda', 95000, 'sports', NULL, NULL),
(183, 'cardealer', 'Kuruma', 'kuruma', 100000, 'sports', NULL, NULL),
(184, 'cardealer', 'Landstalker', 'landstalker', 35000, 'suvs', NULL, NULL),
(185, 'cardealer', 'landstalker2', 'landstalker2', 45000, 'suvs', NULL, NULL),
(187, 'cardealer', 'locust', 'locust', 70000, 'sports', NULL, NULL),
(188, 'cardealer', 'Lynx', 'lynx', 50000, 'sports', NULL, NULL),
(189, 'cardealer', 'Mamba', 'mamba', 70000, 'sports', NULL, NULL),
(192, 'motodealer', 'Manchez', 'manchez', 5300, 'motorcycles', NULL, NULL),
(193, 'motodealer', 'Manchez2', 'manchez2', 14000, 'motorcycles', NULL, NULL),
(194, 'cardealer', 'Massacro', 'massacro', 65000, 'sports', NULL, NULL),
(196, 'cardealer', 'Mesa', 'mesa', 16000, 'suvs', NULL, NULL),
(197, 'cardealer', 'Mesa Trail', 'mesa3', 40000, 'suvs', NULL, NULL),
(198, 'cardealer', 'michelli', 'michelli', 31000, 'sports', NULL, NULL),
(199, 'cardealer', 'Minivan', 'minivan', 13000, 'vans', NULL, NULL),
(200, 'cardealer', 'minivan2', 'minivan2', 20000, 'vans', NULL, NULL),
(201, 'cardealer', 'Monroe', 'monroe', 55000, 'sportsclassics', NULL, NULL),
(202, 'cardealer', 'Moonbeam', 'moonbeam', 18000, 'vans', NULL, NULL),
(203, 'cardealer', 'Moonbeam Rider', 'moonbeam2', 35000, 'vans', NULL, NULL),
(204, 'cardealer', 'nebula', 'nebula', 31000, 'sports', NULL, NULL),
(205, 'motodealer', 'Nemesis', 'nemesis', 25000, 'motorcycles', NULL, NULL),
(206, 'cardealer', 'Neon', 'neon', 150000, 'sports', NULL, NULL),
(209, 'motodealer', 'Nightblade', 'nightblade', 65000, 'motorcycles', NULL, NULL),
(210, 'cardealer', 'Nightshade', 'nightshade', 65000, 'muscle', NULL, NULL),
(211, 'cardealer', '9F', 'ninef', 85000, 'sports', NULL, NULL),
(212, 'cardealer', '9F Cabrio', 'ninef2', 95000, 'sports', NULL, NULL),
(213, 'cardealer', 'novak', 'novak', 45000, 'suvs', NULL, NULL),
(214, 'cardealer', 'Omnis', 'omnis', 45000, 'sports', NULL, NULL),
(216, 'cardealer', 'oracle', 'oracle', 45000, 'coupes', NULL, NULL),
(217, 'cardealer', 'Oracle XS', 'oracle2', 35000, 'coupes', NULL, NULL),
(219, 'cardealer', 'outlaw', 'outlaw', 45000, 'offroad', NULL, NULL),
(220, 'cardealer', 'Panto', 'panto', 5000, 'compacts', NULL, NULL),
(222, 'cardealer', 'paragon', 'paragon', 115000, 'sports', NULL, NULL),
(223, 'cardealer', 'Pariah', 'pariah', 142000, 'sports', NULL, NULL),
(224, 'cardealer', 'Patriot', 'patriot', 55000, 'suvs', NULL, NULL),
(225, 'cardealer', 'patriot2', 'patriot2', 125000, 'suvs', NULL, NULL),
(226, 'motodealer', 'PCJ-600', 'pcj', 10800, 'motorcycles', NULL, NULL),
(227, 'cardealer', 'penetrator', 'penetrator', 142000, 'super', NULL, NULL),
(228, 'cardealer', 'Penumbra', 'penumbra', 28000, 'sports', NULL, NULL),
(229, 'cardealer', 'penumbra2', 'penumbra2', 32500, 'sports', NULL, NULL),
(230, 'cardealer', 'peyote', 'peyote', 20000, 'sports', NULL, NULL),
(231, 'cardealer', 'peyote2', 'peyote2', 45000, 'muscle', NULL, NULL),
(234, 'cardealer', 'Phoenix', 'phoenix', 12500, 'muscle', NULL, NULL),
(235, 'cardealer', 'Picador', 'picador', 18000, 'muscle', NULL, NULL),
(236, 'cardealer', 'Pigalle', 'pigalle', 20000, 'sportsclassics', NULL, NULL),
(239, 'cardealer', 'Prairie', 'prairie', 12000, 'compacts', NULL, NULL),
(240, 'cardealer', 'Premier', 'premier', 18000, 'sedans', NULL, NULL),
(241, 'cardealer', 'primo', 'primo', 35000, 'sedans', NULL, NULL),
(242, 'cardealer', 'Primo Custom', 'primo2', 45000, 'sedans', NULL, NULL),
(244, 'cardealer', 'Radius', 'radi', 29000, 'suvs', NULL, NULL),
(245, 'cardealer', 'raiden', 'raiden', 137500, 'sports', NULL, NULL),
(246, 'cardealer', 'rancherxl', 'rancherxl', 45000, 'offroad', NULL, NULL),
(247, 'cardealer', 'Rapid GT', 'rapidgt', 87000, 'sports', NULL, NULL),
(251, 'motodealer', 'ratbike', 'ratbike', 45000, 'motorcycles', NULL, NULL),
(252, 'cardealer', 'ratloader', 'ratloader', 45000, 'muscle', NULL, NULL),
(253, 'cardealer', 'ratloader2', 'ratloader2', 45000, 'muscle', NULL, NULL),
(254, 'cardealer', 'Reaper', 'reaper', 150000, 'super', NULL, NULL),
(255, 'cardealer', 'rebel', 'rebel', 45000, 'offroad', NULL, NULL),
(256, 'cardealer', 'Rebel', 'rebel2', 35000, 'offroad', NULL, NULL),
(257, 'cardealer', 'rebla', 'rebla', 45000, 'suvs', NULL, NULL),
(258, 'cardealer', 'Regina', 'regina', 5000, 'sedans', NULL, NULL),
(261, 'cardealer', 'Revolter', 'revolter', 161000, 'sports', NULL, NULL),
(262, 'cardealer', 'rhapsody', 'rhapsody', 8000, 'compacts', NULL, NULL),
(263, 'cardealer', 'riata', 'riata', 165000, 'offroad', NULL, NULL),
(264, 'cardealer', 'Rocoto', 'rocoto', 45000, 'suvs', NULL, NULL),
(265, 'motodealer', 'Ruffian', 'ruffian', 13900, 'motorcycles', NULL, NULL),
(266, 'cardealer', 'ruiner', 'ruiner', 45000, 'muscle', NULL, NULL),
(268, 'cardealer', 'Rumpo', 'rumpo', 15000, 'vans', NULL, NULL),
(270, 'cardealer', 'ruston', 'ruston', 55000, 'sports', NULL, NULL),
(272, 'cardealer', 'Sabre Turbo', 'sabregt', 20000, 'muscle', NULL, NULL),
(273, 'cardealer', 'Sabre GT', 'sabregt2', 25000, 'muscle', NULL, NULL),
(274, 'motodealer', 'Sanchez', 'sanchez', 9000, 'motorcycles', NULL, NULL),
(275, 'motodealer', 'Sanchez Sport', 'sanchez2', 10000, 'motorcycles', NULL, NULL),
(276, 'motodealer', 'Sanctus', 'sanctus', 50000, 'motorcycles', NULL, NULL),
(277, 'cardealer', 'Sandking', 'sandking', 55000, 'offroad', NULL, NULL),
(278, 'cardealer', 'sandking2', 'sandking2', 45000, 'offroad', NULL, NULL),
(280, 'cardealer', 'SC1', 'sc1', 160300, 'super', NULL, NULL),
(281, 'cardealer', 'Schafter', 'schafter2', 25000, 'sedans', NULL, NULL),
(282, 'cardealer', 'Schafter V12', 'schafter3', 50000, 'sports', NULL, NULL),
(283, 'cardealer', 'schafter4', 'schafter4', 55000, 'sports', NULL, NULL),
(284, 'cardealer', 'schlagen', 'schlagen', 82000, 'sports', NULL, NULL),
(286, 'cardealer', 'Scorcher', 'scorcher', 280, 'motorcycles', NULL, NULL),
(287, 'cardealer', 'Seminole', 'seminole', 25000, 'suvs', NULL, NULL),
(288, 'cardealer', 'seminole2', 'seminole2', 45000, 'suvs', NULL, NULL),
(289, 'cardealer', 'Sentinel', 'sentinel', 32000, 'coupes', NULL, NULL),
(290, 'cardealer', 'Sentinel XS', 'sentinel2', 40000, 'coupes', NULL, NULL),
(292, 'cardealer', 'serrano', 'serrano', 45000, 'suvs', NULL, NULL),
(293, 'cardealer', 'Seven 70', 'seven70', 69000, 'sports', NULL, NULL),
(294, 'cardealer', 'ETR1', 'sheava', 220000, 'super', NULL, NULL),
(295, 'cardealer', 'Slam Van', 'slamvan3', 21000, 'muscle', NULL, NULL),
(296, 'motodealer', 'Sovereign', 'sovereign', 35000, 'motorcycles', NULL, NULL),
(297, 'cardealer', 'specter', 'specter', 45000, 'sports', NULL, NULL),
(299, 'cardealer', 'speedo', 'speedo', 20000, 'vans', NULL, NULL),
(300, 'cardealer', 'speedo2', 'speedo2', 20000, 'vans', NULL, NULL),
(302, 'cardealer', 'squaddie', 'squaddie', 45000, 'suvs', NULL, NULL),
(303, 'cardealer', 'stafford', 'stafford', 45000, 'sedans', NULL, NULL),
(304, 'cardealer', 'stalion', 'stalion', 45000, 'muscle', NULL, NULL),
(305, 'cardealer', 'Stalion2', 'stalion2', 45000, 'muscle', NULL, NULL),
(306, 'cardealer', 'stanier', 'stanier', 45000, 'sedans', NULL, NULL),
(307, 'cardealer', 'Stinger', 'stinger', 80000, 'sportsclassics', NULL, NULL),
(308, 'cardealer', 'Stinger GT', 'stingergt', 75000, 'sportsclassics', NULL, NULL),
(309, 'cardealer', 'stratum', 'stratum', 45000, 'sedans', NULL, NULL),
(310, 'cardealer', 'Streiter', 'streiter', 125000, 'sports', NULL, NULL),
(311, 'cardealer', 'Stretch', 'stretch', 125000, 'sedans', NULL, NULL),
(312, 'motodealer', 'stryder', 'stryder', 55000, 'motorcycles', NULL, NULL),
(313, 'cardealer', 'sugoi', 'sugoi', 29000, 'sports', NULL, NULL),
(314, 'cardealer', 'Sultan', 'sultan', 61000, 'sports', NULL, NULL),
(315, 'cardealer', 'sultan2', 'sultan2', 20000, 'sports', NULL, NULL),
(316, 'cardealer', 'Sultan RS', 'sultanrs', 85000, 'sports', NULL, NULL),
(317, 'cardealer', 'Super Diamond', 'superd', 130000, 'sedans', NULL, NULL),
(318, 'cardealer', 'Surano', 'surano', 50000, 'sports', NULL, NULL),
(319, 'cardealer', 'Surfer', 'surfer', 12000, 'vans', NULL, NULL),
(321, 'cardealer', 'surge', 'surge', 45000, 'sedans', NULL, NULL),
(322, 'cardealer', 'swinger', 'swinger', 37000, 'sports', NULL, NULL),
(325, 'cardealer', 'Tailgater', 'tailgater', 30000, 'sedans', NULL, NULL),
(327, 'cardealer', 'Tampa', 'tampa', 16000, 'muscle', NULL, NULL),
(328, 'cardealer', 'Drift Tampa', 'tampa2', 80000, 'sports', NULL, NULL),
(329, 'cardealer', 'tempesta', 'tempesta', 185000, 'super', NULL, NULL),
(332, 'motodealer', 'Thrust', 'thrust', 24000, 'motorcycles', NULL, NULL),
(334, 'cardealer', 'torero', 'torero', 98000, 'sports', NULL, NULL),
(335, 'cardealer', 'tornado', 'tornado', 20000, 'sports', NULL, NULL),
(340, 'cardealer', 'tornado6', 'tornado6', 45000, 'sports', NULL, NULL),
(341, 'cardealer', 'toros', 'toros', 91000, 'suvs', NULL, NULL),
(342, 'cardealer', 'Tri bike', 'tribike', 520, 'motorcycles', NULL, NULL),
(343, 'cardealer', 'Tri bike', 'tribike2', 520, 'motorcycles', NULL, NULL),
(344, 'cardealer', 'Tri bike', 'tribike3', 520, 'motorcycles', NULL, NULL),
(345, 'cardealer', 'Trophy Truck', 'trophytruck', 60000, 'offroad', NULL, NULL),
(346, 'cardealer', 'Trophy Truck Limited', 'trophytruck2', 80000, 'offroad', NULL, NULL),
(347, 'cardealer', 'Tropos', 'tropos', 40000, 'sports', NULL, NULL),
(348, 'cardealer', 'tulip', 'tulip', 45000, 'muscle', NULL, NULL),
(349, 'cardealer', 'turismo2', 'turismo2', 122000, 'sports', NULL, NULL),
(354, 'motodealer', 'Vader', 'vader', 12200, 'motorcycles', NULL, NULL),
(356, 'cardealer', 'vagrant', 'vagrant', 45000, 'offroad', NULL, NULL),
(357, 'cardealer', 'vamos', 'vamos', 45000, 'muscle', NULL, NULL),
(358, 'cardealer', 'Verlierer', 'verlierer2', 70000, 'sports', NULL, NULL),
(359, 'cardealer', 'verus', 'verus', 45000, 'offroad', NULL, NULL),
(360, 'cardealer', 'Vigero', 'vigero', 12500, 'muscle', NULL, NULL),
(361, 'motodealer', 'vindicator', 'vindicator', 45000, 'motorcycles', NULL, NULL),
(362, 'cardealer', 'Virgo', 'virgo', 14000, 'muscle', NULL, NULL),
(363, 'cardealer', 'virgo2', 'virgo2', 45000, 'muscle', NULL, NULL),
(364, 'cardealer', 'virgo3', 'virgo3', 45000, 'muscle', NULL, NULL),
(365, 'cardealer', 'Viseris', 'viseris', 87500, 'sportsclassics', NULL, NULL),
(367, 'cardealer', 'Voltic', 'voltic', 90000, 'super', NULL, NULL),
(368, 'cardealer', 'Voodoo', 'voodoo', 22000, 'muscle', NULL, NULL),
(370, 'motodealer', 'Vortex', 'vortex', 9800, 'motorcycles', NULL, NULL),
(371, 'cardealer', 'vstr', 'vstr', 115000, 'sports', NULL, NULL),
(372, 'cardealer', 'Warrener', 'warrener', 4000, 'sedans', NULL, NULL),
(373, 'cardealer', 'Washington', 'washington', 9000, 'sedans', NULL, NULL),
(374, 'cardealer', 'weevil', 'weevil', 8000, 'compacts', NULL, NULL),
(375, 'cardealer', 'Windsor', 'windsor', 95000, 'coupes', NULL, NULL),
(376, 'cardealer', 'Windsor Drop', 'windsor2', 125000, 'coupes', NULL, NULL),
(377, 'cardealer', 'winky', 'winky', 45000, 'offroad', NULL, NULL),
(378, 'motodealer', 'Woflsbane', 'wolfsbane', 9000, 'motorcycles', NULL, NULL),
(379, 'cardealer', 'xa21', 'xa21', 70000, 'super', NULL, NULL),
(380, 'cardealer', 'XLS', 'xls', 32000, 'suvs', NULL, NULL),
(381, 'cardealer', 'Yosemite', 'yosemite', 101000, 'muscle', NULL, NULL),
(382, 'cardealer', 'yosemite2', 'yosemite2', 45000, 'muscle', NULL, NULL),
(383, 'cardealer', 'yosemite3', 'yosemite3', 45000, 'muscle', NULL, NULL),
(384, 'cardealer', 'Youga', 'youga', 10800, 'vans', NULL, NULL),
(385, 'cardealer', 'Youga Luxuary', 'youga2', 14500, 'vans', NULL, NULL),
(386, 'cardealer', 'youga3', 'youga3', 20000, 'vans', NULL, NULL),
(387, 'cardealer', 'Z190', 'z190', 90000, 'sportsclassics', NULL, NULL),
(389, 'cardealer', 'Zion', 'zion', 36000, 'coupes', NULL, NULL),
(390, 'cardealer', 'Zion Cabrio', 'zion2', 45000, 'coupes', NULL, NULL),
(391, 'cardealer', 'zion3', 'zion3', 90000, 'sports', NULL, NULL),
(392, 'motodealer', 'Zombie', 'zombiea', 9500, 'motorcycles', NULL, NULL),
(393, 'motodealer', 'Zombie Luxuary', 'zombieb', 12000, 'motorcycles', NULL, NULL),
(394, 'cardealer', 'zorrusso', 'zorrusso', 109000, 'super', NULL, NULL),
(395, 'cardealer', 'caracara2', 'caracara2', 55000, 'offroad', NULL, NULL),
(396, 'cardealer', 'Z-Type', 'ztype', 220000, 'sportsclassics', NULL, NULL),
(397, 'cardealer', 'comet6', 'comet6', 182000, 'sports', NULL, NULL),
(398, 'cardealer', 'dominator7', 'dominator7', 72000, 'sports', NULL, NULL),
(399, 'cardealer', 'dominator8', 'dominator8', 67000, 'sports', NULL, NULL),
(400, 'cardealer', 'euros', 'euros', 28000, 'sports', NULL, NULL),
(401, 'cardealer', 'futo2', 'futo2', 21000, 'compact', NULL, NULL),
(402, 'cardealer', 'rt3000', 'rt3000', 2000, 'sports', NULL, NULL),
(403, 'cardealer', 'sultan3', 'sultan3', 60000, 'sports', NULL, NULL),
(404, 'cardealer', 'tailgater2', 'tailgater2', 100000, 'sports', NULL, NULL),
(406, 'cardealer', 'vectre', 'vectre', 42000, 'sports', NULL, NULL),
(407, 'cardealer', 'remus', 'remus', 30000, 'sports', NULL, NULL),
(408, 'cardealer', 'calico', 'calico', 38000, 'sports', NULL, NULL),
(409, 'cardealer', 'cypher', 'cypher', 90000, 'sports', NULL, NULL),
(410, 'cardealer', 'jester4', 'jester4', 49000, 'sports', NULL, NULL),
(411, 'cardealer', 'zr350', 'zr350', 43000, 'sports', NULL, NULL),
(414, 'cardealer', 'Pfister Astron', 'astron', 103000, 'SUVs', NULL, NULL),
(415, 'cardealer', 'Gallivanter Baller ST', 'baller7', 55000, 'SUVs', NULL, NULL),
(416, 'cardealer', 'Bravado Buffalo STX', 'buffalo4', 42000, 'Muscle', NULL, NULL),
(418, 'cardealer', 'Lampadati Cinquemila', 'cinquemila', 65000, 'Sedans', NULL, NULL),
(419, 'cardealer', 'Pfister Comet S2 Cabrio', 'comet7', 137000, 'Sports', NULL, NULL),
(420, 'cardealer', 'Enus Deity', 'deity', 69000, 'Sedans', NULL, NULL),
(421, 'cardealer', 'Declasse Granger 3600LX', 'granger2', 65000, 'SUVs', NULL, NULL),
(423, 'cardealer', 'Obey IWagen', 'iwagen', 66000, 'SUVs', NULL, NULL),
(424, 'cardealer', 'Enus Jubilee', 'jubilee', 67000, 'SUVs', NULL, NULL),
(425, 'cardealer', 'Maibatsu Mule', 'mule5', 20000, 'Commercial', NULL, NULL),
(427, 'motodealer', 'Western Reever', 'reever', 20000, 'Motorcycles', NULL, NULL),
(428, 'motodealer', 'Nagasaki Shinobi', 'shinobi', 29000, 'Motorcycles', NULL, NULL),
(429, 'cardealer', 'Vapid Youga Custom', 'youga4', 20000, 'Vans', NULL, NULL),
(526, 'boatdealer', 'Toro', 'Toro2', 500000, 'boat', NULL, NULL),
(527, 'boatdealer', 'Speeder', 'speeder', 325000, 'boat', NULL, NULL),
(528, 'boatdealer', 'SeaShark V2', 'seashark2', 125000, 'boat', NULL, NULL),
(529, 'boatdealer', 'Marquis Voilier', 'marquis', 250000, 'boat', NULL, NULL),
(530, 'boatdealer', 'JetMax', 'jetmax', 300000, 'boat', NULL, NULL),
(532, 'boatdealer', 'Dinghy Super', 'dinghy4', 250000, 'boat', NULL, NULL),
(539, 'airdealer', 'Frogger', 'frogger', 610000, 'aircraft', NULL, NULL),
(540, 'airdealer', 'Frogger 2', 'frogger2', 800000, 'aircraft', NULL, NULL),
(541, 'airdealer', 'Havok', 'havok', 210000, 'aircraft', NULL, NULL),
(542, 'airdealer', 'Maverick', 'maverick', 750000, 'aircraft', NULL, NULL),
(545, 'airdealer', 'Supervolito 2', 'supervolito2', 1000000, 'aircraft', NULL, NULL),
(546, 'airdealer', 'Swift', 'swift', 1200000, 'aircraft', NULL, NULL),
(547, 'airdealer', 'Volatus', 'volatus', 2000000, 'aircraft', NULL, NULL),
(548, 'airdealer', 'Delta plane', 'microlight', 400000, 'aircraft', NULL, NULL),
(549, 'airdealer', 'AlphaZ1', 'alphaz1', 500000, 'aircraft', NULL, NULL),
(550, 'airdealer', 'Cuban 800', 'cuban800', 450000, 'aircraft', NULL, NULL),
(551, 'airdealer', 'Dodo', 'dodo', 550000, 'aircraft', NULL, NULL),
(552, 'airdealer', 'Duster', 'duster', 190000, 'aircraft', NULL, NULL),
(556, 'airdealer', 'Mammatus', 'mammatus', 400000, 'aircraft', NULL, NULL),
(563, 'airdealer', 'Velum sport', 'velum2', 700000, 'aircraft', NULL, NULL),
(564, 'airdealer', 'Vestra', 'vestra', 1000000, 'aircraft', NULL, NULL),
(565, 'airdealer', 'Swift 2', 'swift2', 1500000, 'aircraft', NULL, NULL),
(569, 'boatdealer', 'Yatch Semi-Luxe', 'sr650fly', 4000000, 'boat', NULL, NULL),
(638, 'cardealer', 'tyrus', 'tyrus', 340000, 'super', NULL, NULL),
(639, 'cardealer', 'tyrant', 'tyrant', 275000, 'super', NULL, NULL),
(640, 'cardealer', 'growler', 'growler', 100000, 'sports', NULL, NULL),
(641, 'cardealer', 'coquette4', 'coquette4', 410000, 'super', NULL, NULL),
(651, 'boatdealer', 'Suntrap', 'suntrap', 250000, 'boat', NULL, NULL),
(652, 'boatdealer', 'Longfin', 'longfin', 700000, 'boat', NULL, NULL),
(653, 'boatdealer', 'SeaShark V1', 'seashark', 100000, 'boat', NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `vehicules_categories`
--

CREATE TABLE `vehicules_categories` (
  `job` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `label` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `vehicules_categories`
--

INSERT INTO `vehicules_categories` (`job`, `name`, `label`) VALUES
('cardealer', 'compacts', 'Compacts'),
('cardealer', 'coupes', 'Coupés'),
('boutique', 'imports', 'Boutique'),
('motodealer', 'motorcycles', 'Moto'),
('cardealer', 'muscle', 'Muscle'),
('cardealer', 'offroad', 'Off Road'),
('cardealer', 'sedans', 'Sedans'),
('cardealer', 'sports', 'Sports'),
('cardealer', 'sportsclassics', 'Sports Classics'),
('cardealer', 'super', 'Super'),
('cardealer', 'suvs', 'SUVs'),
('cardealer', 'vans', 'Vans');

-- --------------------------------------------------------

--
-- Structure de la table `vente_leboncoin`
--

CREATE TABLE `vente_leboncoin` (
  `price` longtext DEFAULT NULL,
  `id` longtext DEFAULT NULL,
  `identifier` int(11) NOT NULL,
  `UniqueID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `vips`
--

CREATE TABLE `vips` (
  `UniqueID` int(11) NOT NULL,
  `time` int(11) NOT NULL DEFAULT 0,
  `money` tinyint(4) DEFAULT NULL,
  `arme` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `weapon_confiscate`
--

CREATE TABLE `weapon_confiscate` (
  `id` int(255) NOT NULL,
  `uniqueid` varchar(255) NOT NULL,
  `weapon_name` varchar(255) NOT NULL,
  `time` int(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `world_props`
--

CREATE TABLE `world_props` (
  `id` int(11) NOT NULL,
  `name` longtext DEFAULT NULL,
  `owner` longtext DEFAULT NULL,
  `label` longtext DEFAULT NULL,
  `position` varchar(255) DEFAULT NULL,
  `heading` varchar(255) DEFAULT NULL,
  `iid` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `xmas_calendar`
--

CREATE TABLE `xmas_calendar` (
  `id` int(11) NOT NULL,
  `identifier` varchar(64) NOT NULL,
  `day` int(11) NOT NULL,
  `opened_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `zban`
--

CREATE TABLE `zban` (
  `uniqueid` int(11) NOT NULL,
  `identifier` varchar(50) DEFAULT NULL,
  `time` int(11) DEFAULT NULL,
  `perm` tinyint(1) DEFAULT 0,
  `reason` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `addon_account`
--
ALTER TABLE `addon_account`
  ADD PRIMARY KEY (`name`);

--
-- Index pour la table `addon_account_data`
--
ALTER TABLE `addon_account_data`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `index_addon_account_data_account_name_owner` (`account_name`,`owner`),
  ADD KEY `index_addon_account_data_account_name` (`account_name`);

--
-- Index pour la table `admin_jails`
--
ALTER TABLE `admin_jails`
  ADD PRIMARY KEY (`UniqueID`);

--
-- Index pour la table `ad_admin`
--
ALTER TABLE `ad_admin`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Index pour la table `ad_banlist`
--
ALTER TABLE `ad_banlist`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `ad_unban`
--
ALTER TABLE `ad_unban`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `ad_whitelist`
--
ALTER TABLE `ad_whitelist`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `afk_daily`
--
ALTER TABLE `afk_daily`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_daily` (`uniqueid`,`date`),
  ADD KEY `idx_date` (`date`);

--
-- Index pour la table `afk_stats`
--
ALTER TABLE `afk_stats`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_player` (`uniqueid`),
  ADD KEY `idx_total_minutes` (`total_minutes`);

--
-- Index pour la table `animals_perm`
--
ALTER TABLE `animals_perm`
  ADD PRIMARY KEY (`idunique`);

--
-- Index pour la table `appel_jobs`
--
ALTER TABLE `appel_jobs`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `bcso_plainte`
--
ALTER TABLE `bcso_plainte`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`);

--
-- Index pour la table `benches_cache`
--
ALTER TABLE `benches_cache`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `billing`
--
ALTER TABLE `billing`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `blackmarket`
--
ALTER TABLE `blackmarket`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_category` (`category`);

--
-- Index pour la table `blackmarket_rank`
--
ALTER TABLE `blackmarket_rank`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `identifier` (`identifier`);

--
-- Index pour la table `blanchiment`
--
ALTER TABLE `blanchiment`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `boat_categories`
--
ALTER TABLE `boat_categories`
  ADD PRIMARY KEY (`name`);

--
-- Index pour la table `boutique`
--
ALTER TABLE `boutique`
  ADD PRIMARY KEY (`citizenID`),
  ADD UNIQUE KEY `boutique_code` (`boutique_code`);

--
-- Index pour la table `boutique_gains`
--
ALTER TABLE `boutique_gains`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `citizenId` (`citizenId`,`item`);

--
-- Index pour la table `boutique_security_logs`
--
ALTER TABLE `boutique_security_logs`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `calendar`
--
ALTER TABLE `calendar`
  ADD PRIMARY KEY (`identifier`);

--
-- Index pour la table `chasse`
--
ALTER TABLE `chasse`
  ADD UNIQUE KEY `uniqueid` (`uniqueid`);

--
-- Index pour la table `clothes_inventory`
--
ALTER TABLE `clothes_inventory`
  ADD PRIMARY KEY (`UniqueID`);

--
-- Index pour la table `crafting_benches`
--
ALTER TABLE `crafting_benches`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `crafting_players`
--
ALTER TABLE `crafting_players`
  ADD PRIMARY KEY (`identifier`);

--
-- Index pour la table `crafting_recipes`
--
ALTER TABLE `crafting_recipes`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `id` (`id`) USING BTREE;

--
-- Index pour la table `crew_liste`
--
ALTER TABLE `crew_liste`
  ADD PRIMARY KEY (`id_crew`),
  ADD UNIQUE KEY `uniq_crew_name` (`name`);

--
-- Index pour la table `crew_membres`
--
ALTER TABLE `crew_membres`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_identifier` (`identifier`),
  ADD KEY `idx_crew` (`id_crew`),
  ADD KEY `idx_grade` (`id_grade`);

--
-- Index pour la table `darkchat_messages`
--
ALTER TABLE `darkchat_messages`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `id` (`id`) USING BTREE;

--
-- Index pour la table `detention_records`
--
ALTER TABLE `detention_records`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `drugs_creator_auctions`
--
ALTER TABLE `drugs_creator_auctions`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Index pour la table `drugs_fields`
--
ALTER TABLE `drugs_fields`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `id` (`id`) USING BTREE;

--
-- Index pour la table `drugs_sell`
--
ALTER TABLE `drugs_sell`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `fine_types`
--
ALTER TABLE `fine_types`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `gangs_new`
--
ALTER TABLE `gangs_new`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `garages`
--
ALTER TABLE `garages`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `gfxmdt_avatars`
--
ALTER TABLE `gfxmdt_avatars`
  ADD KEY `id` (`id`);

--
-- Index pour la table `gfxmdt_banlist`
--
ALTER TABLE `gfxmdt_banlist`
  ADD KEY `id` (`id`);

--
-- Index pour la table `gfxmdt_department`
--
ALTER TABLE `gfxmdt_department`
  ADD KEY `id` (`id`);

--
-- Index pour la table `gfxmdt_fines`
--
ALTER TABLE `gfxmdt_fines`
  ADD KEY `id` (`id`);

--
-- Index pour la table `gfxmdt_notifications`
--
ALTER TABLE `gfxmdt_notifications`
  ADD KEY `id` (`id`);

--
-- Index pour la table `gfxmdt_offenders`
--
ALTER TABLE `gfxmdt_offenders`
  ADD KEY `id` (`id`);

--
-- Index pour la table `gfxmdt_polices`
--
ALTER TABLE `gfxmdt_polices`
  ADD KEY `id` (`id`);

--
-- Index pour la table `gfxmdt_records`
--
ALTER TABLE `gfxmdt_records`
  ADD KEY `id` (`id`);

--
-- Index pour la table `gfxmdt_wanteds`
--
ALTER TABLE `gfxmdt_wanteds`
  ADD KEY `id` (`id`);

--
-- Index pour la table `gloveboxitems`
--
ALTER TABLE `gloveboxitems`
  ADD PRIMARY KEY (`plate`),
  ADD KEY `id` (`id`);

--
-- Index pour la table `gunfight_stats`
--
ALTER TABLE `gunfight_stats`
  ADD PRIMARY KEY (`identifier`);

--
-- Index pour la table `harvestable_items`
--
ALTER TABLE `harvestable_items`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `id` (`id`) USING BTREE;

--
-- Index pour la table `illegal_drugs_sell`
--
ALTER TABLE `illegal_drugs_sell`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `illegal_laboratory`
--
ALTER TABLE `illegal_laboratory`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `items`
--
ALTER TABLE `items`
  ADD PRIMARY KEY (`name`);

--
-- Index pour la table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`name`);

--
-- Index pour la table `jobs_armories`
--
ALTER TABLE `jobs_armories`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `id` (`id`,`marker_id`,`identifier`) USING BTREE;

--
-- Index pour la table `jobs_data`
--
ALTER TABLE `jobs_data`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `jobs_shops`
--
ALTER TABLE `jobs_shops`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `marker_id` (`marker_id`) USING BTREE,
  ADD KEY `id` (`id`) USING BTREE;

--
-- Index pour la table `jobs_wardrobes`
--
ALTER TABLE `jobs_wardrobes`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `identifier` (`identifier`) USING BTREE;

--
-- Index pour la table `job_garages`
--
ALTER TABLE `job_garages`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `job_grades`
--
ALTER TABLE `job_grades`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `laboratories`
--
ALTER TABLE `laboratories`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `id` (`id`) USING BTREE;

--
-- Index pour la table `licenses`
--
ALTER TABLE `licenses`
  ADD PRIMARY KEY (`type`);

--
-- Index pour la table `luxucex_accounts`
--
ALTER TABLE `luxucex_accounts`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `player` (`char_id`) USING BTREE,
  ADD UNIQUE KEY `address` (`address`),
  ADD KEY `char_id` (`char_id`);

--
-- Index pour la table `luxucex_market_transactions`
--
ALTER TABLE `luxucex_market_transactions`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `luxucex_positions`
--
ALTER TABLE `luxucex_positions`
  ADD PRIMARY KEY (`code`);

--
-- Index pour la table `luxucex_tradinghistory`
--
ALTER TABLE `luxucex_tradinghistory`
  ADD PRIMARY KEY (`key`);

--
-- Index pour la table `luxucex_transfers`
--
ALTER TABLE `luxucex_transfers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_luxucex_transfers_luxucex_accounts` (`sender`),
  ADD KEY `FK_luxucex_transfers_luxucex_accounts_2` (`receiver`);

--
-- Index pour la table `maintenant`
--
ALTER TABLE `maintenant`
  ADD PRIMARY KEY (`active`);

--
-- Index pour la table `moto_categories`
--
ALTER TABLE `moto_categories`
  ADD PRIMARY KEY (`name`);

--
-- Index pour la table `nv_banking_data`
--
ALTER TABLE `nv_banking_data`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_uuid` (`uuid`),
  ADD UNIQUE KEY `unique_iban` (`iban`);

--
-- Index pour la table `nv_cloth`
--
ALTER TABLE `nv_cloth`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `identifier_UNIQUE` (`identifier`);

--
-- Index pour la table `open_car`
--
ALTER TABLE `open_car`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `owned_vehicles`
--
ALTER TABLE `owned_vehicles`
  ADD PRIMARY KEY (`plate`);

--
-- Index pour la table `ox_doorlock`
--
ALTER TABLE `ox_doorlock`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `ox_inventory`
--
ALTER TABLE `ox_inventory`
  ADD UNIQUE KEY `owner` (`owner`,`name`);

--
-- Index pour la table `pausemenu_battlepass_data`
--
ALTER TABLE `pausemenu_battlepass_data`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `pausemenu_commands`
--
ALTER TABLE `pausemenu_commands`
  ADD UNIQUE KEY `command` (`command`) USING HASH;

--
-- Index pour la table `pausemenu_guidebook`
--
ALTER TABLE `pausemenu_guidebook`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `pausemenu_keybinds`
--
ALTER TABLE `pausemenu_keybinds`
  ADD UNIQUE KEY `key` (`key`) USING HASH;

--
-- Index pour la table `players_gofast`
--
ALTER TABLE `players_gofast`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `license_identifier` (`license_identifier`);

--
-- Index pour la table `players_props`
--
ALTER TABLE `players_props`
  ADD UNIQUE KEY `id` (`id`);

--
-- Index pour la table `players_territories`
--
ALTER TABLE `players_territories`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `player_clothes`
--
ALTER TABLE `player_clothes`
  ADD PRIMARY KEY (`UniqueID`);

--
-- Index pour la table `player_entreprise`
--
ALTER TABLE `player_entreprise`
  ADD PRIMARY KEY (`name`);

--
-- Index pour la table `player_gallery`
--
ALTER TABLE `player_gallery`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Index pour la table `player_inventory_clothes`
--
ALTER TABLE `player_inventory_clothes`
  ADD PRIMARY KEY (`UniqueID`);

--
-- Index pour la table `player_jails`
--
ALTER TABLE `player_jails`
  ADD PRIMARY KEY (`UniqueID`);

--
-- Index pour la table `player_leboncoin`
--
ALTER TABLE `player_leboncoin`
  ADD UNIQUE KEY `identifier` (`identifier`) USING HASH;

--
-- Index pour la table `player_livraisons`
--
ALTER TABLE `player_livraisons`
  ADD PRIMARY KEY (`uniqueid`);

--
-- Index pour la table `player_ltdsales`
--
ALTER TABLE `player_ltdsales`
  ADD PRIMARY KEY (`uid`);

--
-- Index pour la table `playlists`
--
ALTER TABLE `playlists`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `playlist_songs`
--
ALTER TABLE `playlist_songs`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `police_plainte`
--
ALTER TABLE `police_plainte`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`);

--
-- Index pour la table `properties`
--
ALTER TABLE `properties`
  ADD PRIMARY KEY (`propertiesID`);

--
-- Index pour la table `radiocar_music`
--
ALTER TABLE `radiocar_music`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `radiocar_owned`
--
ALTER TABLE `radiocar_owned`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `radiocar_playlist`
--
ALTER TABLE `radiocar_playlist`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `rcore_tattoos`
--
ALTER TABLE `rcore_tattoos`
  ADD PRIMARY KEY (`identifier`),
  ADD UNIQUE KEY `rcore_tattoos_identifier_uindex` (`identifier`);

--
-- Index pour la table `rcore_tattoos_business`
--
ALTER TABLE `rcore_tattoos_business`
  ADD PRIMARY KEY (`name`);

--
-- Index pour la table `reset_logs`
--
ALTER TABLE `reset_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_last_reset` (`last_reset`);

--
-- Index pour la table `slots_inventory`
--
ALTER TABLE `slots_inventory`
  ADD PRIMARY KEY (`UniqueID`);

--
-- Index pour la table `society_data`
--
ALTER TABLE `society_data`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `sunny_clothes`
--
ALTER TABLE `sunny_clothes`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `sunny_trunk`
--
ALTER TABLE `sunny_trunk`
  ADD UNIQUE KEY `id` (`id`);

--
-- Index pour la table `territoires`
--
ALTER TABLE `territoires`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_territory_name` (`territory_name`),
  ADD KEY `idx_score_total` (`score_total`),
  ADD KEY `idx_id_crew` (`id_crew`);

--
-- Index pour la table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`UniqueID`),
  ADD UNIQUE KEY `identifier` (`identifier`);

--
-- Index pour la table `user_licenses`
--
ALTER TABLE `user_licenses`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `vehicle_catalogue`
--
ALTER TABLE `vehicle_catalogue`
  ADD PRIMARY KEY (`name`);

--
-- Index pour la table `vehicle_categories`
--
ALTER TABLE `vehicle_categories`
  ADD PRIMARY KEY (`name`);

--
-- Index pour la table `vehicules`
--
ALTER TABLE `vehicules`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Index pour la table `vehicules_categories`
--
ALTER TABLE `vehicules_categories`
  ADD PRIMARY KEY (`name`);

--
-- Index pour la table `vente_leboncoin`
--
ALTER TABLE `vente_leboncoin`
  ADD UNIQUE KEY `id` (`id`) USING HASH;

--
-- Index pour la table `vips`
--
ALTER TABLE `vips`
  ADD PRIMARY KEY (`UniqueID`);

--
-- Index pour la table `weapon_confiscate`
--
ALTER TABLE `weapon_confiscate`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `world_props`
--
ALTER TABLE `world_props`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`);

--
-- Index pour la table `xmas_calendar`
--
ALTER TABLE `xmas_calendar`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `identifier` (`identifier`,`day`);

--
-- Index pour la table `zban`
--
ALTER TABLE `zban`
  ADD PRIMARY KEY (`uniqueid`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `addon_account_data`
--
ALTER TABLE `addon_account_data`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=53;

--
-- AUTO_INCREMENT pour la table `ad_admin`
--
ALTER TABLE `ad_admin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `ad_banlist`
--
ALTER TABLE `ad_banlist`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT pour la table `ad_unban`
--
ALTER TABLE `ad_unban`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `ad_whitelist`
--
ALTER TABLE `ad_whitelist`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `afk_daily`
--
ALTER TABLE `afk_daily`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `afk_stats`
--
ALTER TABLE `afk_stats`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `animals_perm`
--
ALTER TABLE `animals_perm`
  MODIFY `idunique` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT pour la table `appel_jobs`
--
ALTER TABLE `appel_jobs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `bcso_plainte`
--
ALTER TABLE `bcso_plainte`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `benches_cache`
--
ALTER TABLE `benches_cache`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `billing`
--
ALTER TABLE `billing`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=869;

--
-- AUTO_INCREMENT pour la table `blackmarket`
--
ALTER TABLE `blackmarket`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `blackmarket_rank`
--
ALTER TABLE `blackmarket_rank`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `blanchiment`
--
ALTER TABLE `blanchiment`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;

--
-- AUTO_INCREMENT pour la table `boutique_gains`
--
ALTER TABLE `boutique_gains`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=261;

--
-- AUTO_INCREMENT pour la table `boutique_security_logs`
--
ALTER TABLE `boutique_security_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `crafting_benches`
--
ALTER TABLE `crafting_benches`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `crafting_recipes`
--
ALTER TABLE `crafting_recipes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `crew_liste`
--
ALTER TABLE `crew_liste`
  MODIFY `id_crew` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `crew_membres`
--
ALTER TABLE `crew_membres`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `darkchat_messages`
--
ALTER TABLE `darkchat_messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT pour la table `detention_records`
--
ALTER TABLE `detention_records`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT pour la table `drugs_creator_auctions`
--
ALTER TABLE `drugs_creator_auctions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `drugs_fields`
--
ALTER TABLE `drugs_fields`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `drugs_sell`
--
ALTER TABLE `drugs_sell`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `gangs_new`
--
ALTER TABLE `gangs_new`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT pour la table `garages`
--
ALTER TABLE `garages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=249;

--
-- AUTO_INCREMENT pour la table `gfxmdt_avatars`
--
ALTER TABLE `gfxmdt_avatars`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `gfxmdt_banlist`
--
ALTER TABLE `gfxmdt_banlist`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `gfxmdt_department`
--
ALTER TABLE `gfxmdt_department`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `gfxmdt_fines`
--
ALTER TABLE `gfxmdt_fines`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=53;

--
-- AUTO_INCREMENT pour la table `gfxmdt_notifications`
--
ALTER TABLE `gfxmdt_notifications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=54;

--
-- AUTO_INCREMENT pour la table `gfxmdt_offenders`
--
ALTER TABLE `gfxmdt_offenders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `gfxmdt_polices`
--
ALTER TABLE `gfxmdt_polices`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `gfxmdt_records`
--
ALTER TABLE `gfxmdt_records`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `gfxmdt_wanteds`
--
ALTER TABLE `gfxmdt_wanteds`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `gloveboxitems`
--
ALTER TABLE `gloveboxitems`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `harvestable_items`
--
ALTER TABLE `harvestable_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `illegal_drugs_sell`
--
ALTER TABLE `illegal_drugs_sell`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT pour la table `illegal_laboratory`
--
ALTER TABLE `illegal_laboratory`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `jobs_armories`
--
ALTER TABLE `jobs_armories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `jobs_data`
--
ALTER TABLE `jobs_data`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `jobs_shops`
--
ALTER TABLE `jobs_shops`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `jobs_wardrobes`
--
ALTER TABLE `jobs_wardrobes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `job_garages`
--
ALTER TABLE `job_garages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `job_grades`
--
ALTER TABLE `job_grades`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3275;

--
-- AUTO_INCREMENT pour la table `laboratories`
--
ALTER TABLE `laboratories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `luxucex_accounts`
--
ALTER TABLE `luxucex_accounts`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT pour la table `luxucex_market_transactions`
--
ALTER TABLE `luxucex_market_transactions`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `luxucex_tradinghistory`
--
ALTER TABLE `luxucex_tradinghistory`
  MODIFY `key` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `luxucex_transfers`
--
ALTER TABLE `luxucex_transfers`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `nv_banking_data`
--
ALTER TABLE `nv_banking_data`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `nv_cloth`
--
ALTER TABLE `nv_cloth`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `open_car`
--
ALTER TABLE `open_car`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=434;

--
-- AUTO_INCREMENT pour la table `ox_doorlock`
--
ALTER TABLE `ox_doorlock`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=587;

--
-- AUTO_INCREMENT pour la table `pausemenu_battlepass_data`
--
ALTER TABLE `pausemenu_battlepass_data`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=360;

--
-- AUTO_INCREMENT pour la table `pausemenu_guidebook`
--
ALTER TABLE `pausemenu_guidebook`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `players_gofast`
--
ALTER TABLE `players_gofast`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT pour la table `players_props`
--
ALTER TABLE `players_props`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT pour la table `players_territories`
--
ALTER TABLE `players_territories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `player_gallery`
--
ALTER TABLE `player_gallery`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `player_ltdsales`
--
ALTER TABLE `player_ltdsales`
  MODIFY `uid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2046;

--
-- AUTO_INCREMENT pour la table `playlists`
--
ALTER TABLE `playlists`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=57;

--
-- AUTO_INCREMENT pour la table `playlist_songs`
--
ALTER TABLE `playlist_songs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT pour la table `police_plainte`
--
ALTER TABLE `police_plainte`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `properties`
--
ALTER TABLE `properties`
  MODIFY `propertiesID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT pour la table `radiocar_music`
--
ALTER TABLE `radiocar_music`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=477;

--
-- AUTO_INCREMENT pour la table `radiocar_owned`
--
ALTER TABLE `radiocar_owned`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `radiocar_playlist`
--
ALTER TABLE `radiocar_playlist`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `reset_logs`
--
ALTER TABLE `reset_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `society_data`
--
ALTER TABLE `society_data`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=80;

--
-- AUTO_INCREMENT pour la table `sunny_clothes`
--
ALTER TABLE `sunny_clothes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT pour la table `territoires`
--
ALTER TABLE `territoires`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `users`
--
ALTER TABLE `users`
  MODIFY `UniqueID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT pour la table `user_licenses`
--
ALTER TABLE `user_licenses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=391;

--
-- AUTO_INCREMENT pour la table `vehicules`
--
ALTER TABLE `vehicules`
  MODIFY `id` int(12) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=665;

--
-- AUTO_INCREMENT pour la table `weapon_confiscate`
--
ALTER TABLE `weapon_confiscate`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT pour la table `world_props`
--
ALTER TABLE `world_props`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT pour la table `xmas_calendar`
--
ALTER TABLE `xmas_calendar`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `luxucex_transfers`
--
ALTER TABLE `luxucex_transfers`
  ADD CONSTRAINT `FK_luxucex_transfers_luxucex_accounts` FOREIGN KEY (`sender`) REFERENCES `luxucex_accounts` (`address`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_luxucex_transfers_luxucex_accounts_2` FOREIGN KEY (`receiver`) REFERENCES `luxucex_accounts` (`address`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `territoires`
--
ALTER TABLE `territoires`
  ADD CONSTRAINT `fk_territoires_crew` FOREIGN KEY (`id_crew`) REFERENCES `crew_liste` (`id_crew`) ON DELETE SET NULL ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
