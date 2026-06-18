CREATE TABLE IF NOT EXISTS `case_rewards` (
  `identifier` varchar(90) NOT NULL,
  `case_id` varchar(50) DEFAULT NULL,
  `reward_name` varchar(50) DEFAULT NULL,
  `reward_value` longtext DEFAULT NULL,
  KEY `identifier` (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `boutique_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uniqueid` int(11) NOT NULL,
  `data` longtext DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `uniqueid` (`uniqueid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `boutique_offers` (
  `offer_id` varchar(50) NOT NULL,
  `start_time` bigint(20) NOT NULL,
  PRIMARY KEY (`offer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

ALTER TABLE `users` 
ADD COLUMN IF NOT EXISTS `sunnycoins` int(11) DEFAULT 0,
ADD COLUMN IF NOT EXISTS `totalCoins` int(11) DEFAULT 0;

ALTER TABLE `owned_vehicles` 
ADD COLUMN IF NOT EXISTS `boutique` tinyint(1) DEFAULT 0;