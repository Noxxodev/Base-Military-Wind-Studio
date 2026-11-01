-- =====================================================================
--  WIND STUDIO - Base Militaire V2
--  Fichier SQL d'installation (toutes les tables + données de base)
--
--  1. Créez une base de données vide (utf8mb4).
--  2. Sélectionnez-la, puis importez ce fichier (phpMyAdmin, HeidiSQL...).
--
--  Ce fichier peut être importé plusieurs fois sans erreur ni doublon.
--  Documentation : https://wind-studio-1.gitbook.io/wind-studio-docs/
-- =====================================================================

SET NAMES utf8mb4;

-- =====================================================================
--  TABLES
-- =====================================================================

-- ---------------------------------------------------------------
-- ESX
-- ---------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(60) NOT NULL,
  `ssn` varchar(11) NOT NULL,
  `accounts` longtext DEFAULT NULL,
  `group` varchar(50) DEFAULT 'user',
  `inventory` longtext DEFAULT NULL,
  `job` varchar(20) DEFAULT 'unemployed',
  `job_grade` int(11) DEFAULT 0,
  `job2` varchar(20) DEFAULT 'unemployed',
  `job2_grade` int(11) DEFAULT 0,
  `loadout` longtext DEFAULT NULL,
  `metadata` longtext DEFAULT NULL,
  `position` longtext DEFAULT NULL,
  `skin` longtext DEFAULT NULL,
  `status` longtext DEFAULT NULL,
  `firstname` varchar(50) DEFAULT NULL,
  `lastname` varchar(50) DEFAULT NULL,
  `dateofbirth` varchar(25) DEFAULT NULL,
  `sex` varchar(10) DEFAULT NULL,
  `height` int(11) DEFAULT NULL,
  `death_time` int(11) NOT NULL DEFAULT 0,
  `playtime` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`identifier`),
  UNIQUE KEY `unique_ssn` (`ssn`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `jobs` (
  `name` varchar(50) NOT NULL,
  `label` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `job_grades` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `job_name` varchar(50) DEFAULT NULL,
  `grade` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `label` varchar(50) NOT NULL,
  `salary` int(11) NOT NULL,
  `skin_male` longtext NOT NULL,
  `skin_female` longtext NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `job_grade` (`job_name`,`grade`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `jobs2` (
  `name` varchar(50) NOT NULL,
  `label` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `job2_grades` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `job_name` varchar(50) DEFAULT NULL,
  `grade` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `label` varchar(50) NOT NULL,
  `salary` int(11) NOT NULL,
  `skin_male` longtext NOT NULL,
  `skin_female` longtext NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `job_grade` (`job_name`,`grade`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `items` (
  `name` varchar(50) NOT NULL,
  `label` varchar(50) NOT NULL,
  `weight` int(11) NOT NULL DEFAULT 1,
  `rare` tinyint(4) NOT NULL DEFAULT 0,
  `can_remove` tinyint(4) NOT NULL DEFAULT 1,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `licenses` (
  `type` varchar(60) NOT NULL,
  `label` varchar(60) NOT NULL,
  PRIMARY KEY (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `user_licenses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(60) NOT NULL,
  `owner` varchar(60) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `esx_user_licenses_owner` (`owner`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `addon_account` (
  `name` varchar(60) NOT NULL,
  `label` varchar(100) NOT NULL,
  `shared` int(11) NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `addon_account_data` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_name` varchar(100) DEFAULT NULL,
  `money` int(11) NOT NULL,
  `owner` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_addon_account_data_account_name_owner` (`account_name`,`owner`),
  KEY `index_addon_account_data_account_name` (`account_name`),
  KEY `esx_addon_account_data_owner` (`owner`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `owned_vehicles` (
  `owner` varchar(60) NOT NULL,
  `plate` varchar(12) NOT NULL,
  `vehicle` longtext DEFAULT NULL,
  `type` varchar(20) NOT NULL DEFAULT 'car',
  `job` varchar(20) DEFAULT NULL,
  `stored` tinyint(4) NOT NULL DEFAULT 0,
  `parking` varchar(60) DEFAULT NULL,
  `pound` varchar(60) DEFAULT NULL,
  `glovebox` longtext DEFAULT NULL,
  `trunk` longtext DEFAULT NULL,
  PRIMARY KEY (`plate`),
  KEY `owner` (`owner`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ---------------------------------------------------------------
-- OX
-- ---------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `ox_inventory` (
  `owner` varchar(60) DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `data` longtext DEFAULT NULL,
  `lastupdated` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  UNIQUE KEY `owner` (`owner`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `ox_doorlock` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `data` longtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `playerskins` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(255) NOT NULL,
  `model` varchar(255) NOT NULL,
  `skin` text NOT NULL,
  `active` tinyint(4) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `citizenid` (`citizenid`),
  KEY `active` (`active`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

CREATE TABLE IF NOT EXISTS `player_outfits` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(50) DEFAULT NULL,
  `outfitname` varchar(50) NOT NULL DEFAULT '0',
  `model` varchar(50) DEFAULT NULL,
  `props` varchar(1000) DEFAULT NULL,
  `components` varchar(1500) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `citizenid_outfitname_model` (`citizenid`,`outfitname`,`model`),
  KEY `citizenid` (`citizenid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

CREATE TABLE IF NOT EXISTS `player_outfit_codes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `outfitid` int(11) NOT NULL,
  `code` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `FK_player_outfit_codes_player_outfits` (`outfitid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

CREATE TABLE IF NOT EXISTS `management_outfits` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `job_name` varchar(50) NOT NULL,
  `type` varchar(50) NOT NULL,
  `minrank` int(11) NOT NULL DEFAULT 0,
  `name` varchar(50) NOT NULL DEFAULT 'Cool Outfit',
  `gender` varchar(50) NOT NULL DEFAULT 'male',
  `model` varchar(50) DEFAULT NULL,
  `props` varchar(1000) DEFAULT NULL,
  `components` varchar(1500) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- ---------------------------------------------------------------
-- Wind Studio
-- ---------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `ws_ban` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(60) NOT NULL,
  `playername` varchar(255) NOT NULL,
  `reason` text NOT NULL,
  `time` bigint(20) NOT NULL,
  `staff` varchar(255) NOT NULL,
  `banid` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `identifier` (`identifier`),
  KEY `banid` (`banid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `ws_jail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `license` varchar(60) NOT NULL,
  `playername` varchar(255) NOT NULL,
  `tempjail` int(11) NOT NULL DEFAULT 0,
  `raison` text NOT NULL,
  `staffjail` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `license` (`license`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `ws_report` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `reportid` int(11) NOT NULL,
  `playername` varchar(255) NOT NULL,
  `playerid` int(11) NOT NULL,
  `identifier` varchar(60) NOT NULL,
  `reason` text NOT NULL,
  `staff` varchar(255) DEFAULT NULL,
  `openedat` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `reportid` (`reportid`),
  KEY `identifier` (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `ws_staff_reports` (
  `identifier` varchar(60) NOT NULL,
  `staffname` varchar(255) NOT NULL,
  `count` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `ws_sanctions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(60) NOT NULL,
  `playername` varchar(255) NOT NULL,
  `type` varchar(20) NOT NULL,
  `reason` text NOT NULL,
  `staff` varchar(255) NOT NULL,
  `date` varchar(32) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `identifier` (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `ws_builder_outfit` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `job` varchar(50) NOT NULL,
  `outfit_name` varchar(255) NOT NULL,
  `outfit` longtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `job` (`job`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `ws_flag_point` (
  `job_name` varchar(255) NOT NULL,
  `points` int(11) NOT NULL,
  PRIMARY KEY (`job_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `ws_flag_capture` (
  `zone` int(11) NOT NULL,
  `color` int(11) NOT NULL DEFAULT 0,
  `owner_job` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`zone`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- =====================================================================
--  DONNÉES DE BASE
-- =====================================================================

-- ---------------------------------------------------------------
-- Jobs
-- ---------------------------------------------------------------

INSERT IGNORE INTO `jobs` (`name`, `label`) VALUES
('unemployed', 'Civil'),
('shadow', 'Shadow'),
('kortac', 'Kortac'),
('reacon', 'Reacon');

INSERT IGNORE INTO `jobs2` (`name`, `label`) VALUES
('unemployed', 'Unemployed');

INSERT IGNORE INTO `job2_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
('unemployed', 0, 'unemployed', 'Unemployed', 0, '{}', '{}');

-- ---------------------------------------------------------------
-- Grades (15 grades par armée, les grades 10 à 14 ont accès au menu patron)
-- ---------------------------------------------------------------

INSERT IGNORE INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
('unemployed', 0, 'unemployed', 'Civil', 200, '{}', '{}'),

('shadow', 0, 'soldat', 'Soldat', 20, '{}', '{}'),
('shadow', 1, 'caporal', 'Caporal', 25, '{}', '{}'),
('shadow', 2, 'caporal_chef', 'Caporal Chef', 30, '{}', '{}'),
('shadow', 3, 'sergent', 'Sergent', 35, '{}', '{}'),
('shadow', 4, 'sergent_chef', 'Sergent Chef', 40, '{}', '{}'),
('shadow', 5, 'adjudant', 'Adjudant', 45, '{}', '{}'),
('shadow', 6, 'adjudant_chef', 'Adjudant Chef', 50, '{}', '{}'),
('shadow', 7, 'major', 'Major', 55, '{}', '{}'),
('shadow', 8, 'aspirant', 'Aspirant', 60, '{}', '{}'),
('shadow', 9, 'sous_lieutenant', 'Sous Lieutenant', 65, '{}', '{}'),
('shadow', 10, 'lieutenant', 'Lieutenant', 70, '{}', '{}'),
('shadow', 11, 'capitaine', 'Capitaine', 80, '{}', '{}'),
('shadow', 12, 'commandant', 'Commandant', 90, '{}', '{}'),
('shadow', 13, 'lieutenant_colonel', 'Lieutenant Colonel', 100, '{}', '{}'),
('shadow', 14, 'colonel', 'Colonel', 120, '{}', '{}'),

('kortac', 0, 'soldat', 'Soldat', 20, '{}', '{}'),
('kortac', 1, 'caporal', 'Caporal', 25, '{}', '{}'),
('kortac', 2, 'caporal_chef', 'Caporal Chef', 30, '{}', '{}'),
('kortac', 3, 'sergent', 'Sergent', 35, '{}', '{}'),
('kortac', 4, 'sergent_chef', 'Sergent Chef', 40, '{}', '{}'),
('kortac', 5, 'adjudant', 'Adjudant', 45, '{}', '{}'),
('kortac', 6, 'adjudant_chef', 'Adjudant Chef', 50, '{}', '{}'),
('kortac', 7, 'major', 'Major', 55, '{}', '{}'),
('kortac', 8, 'aspirant', 'Aspirant', 60, '{}', '{}'),
('kortac', 9, 'sous_lieutenant', 'Sous Lieutenant', 65, '{}', '{}'),
('kortac', 10, 'lieutenant', 'Lieutenant', 70, '{}', '{}'),
('kortac', 11, 'capitaine', 'Capitaine', 80, '{}', '{}'),
('kortac', 12, 'commandant', 'Commandant', 90, '{}', '{}'),
('kortac', 13, 'lieutenant_colonel', 'Lieutenant Colonel', 100, '{}', '{}'),
('kortac', 14, 'colonel', 'Colonel', 120, '{}', '{}'),

('reacon', 0, 'soldat', 'Soldat', 20, '{}', '{}'),
('reacon', 1, 'caporal', 'Caporal', 25, '{}', '{}'),
('reacon', 2, 'caporal_chef', 'Caporal Chef', 30, '{}', '{}'),
('reacon', 3, 'sergent', 'Sergent', 35, '{}', '{}'),
('reacon', 4, 'sergent_chef', 'Sergent Chef', 40, '{}', '{}'),
('reacon', 5, 'adjudant', 'Adjudant', 45, '{}', '{}'),
('reacon', 6, 'adjudant_chef', 'Adjudant Chef', 50, '{}', '{}'),
('reacon', 7, 'major', 'Major', 55, '{}', '{}'),
('reacon', 8, 'aspirant', 'Aspirant', 60, '{}', '{}'),
('reacon', 9, 'sous_lieutenant', 'Sous Lieutenant', 65, '{}', '{}'),
('reacon', 10, 'lieutenant', 'Lieutenant', 70, '{}', '{}'),
('reacon', 11, 'capitaine', 'Capitaine', 80, '{}', '{}'),
('reacon', 12, 'commandant', 'Commandant', 90, '{}', '{}'),
('reacon', 13, 'lieutenant_colonel', 'Lieutenant Colonel', 100, '{}', '{}'),
('reacon', 14, 'colonel', 'Colonel', 120, '{}', '{}');

-- ---------------------------------------------------------------
-- Comptes des armées (menu patron)
-- ---------------------------------------------------------------

INSERT IGNORE INTO `addon_account` (`name`, `label`, `shared`) VALUES
('society_shadow', 'Shadow', 1),
('society_kortac', 'Kortac', 1),
('society_reacon', 'Reacon', 1);

INSERT IGNORE INTO `addon_account_data` (`account_name`, `money`, `owner`) VALUES
('society_shadow', 0, NULL),
('society_kortac', 0, NULL),
('society_reacon', 0, NULL);

-- ---------------------------------------------------------------
-- Licences
-- ---------------------------------------------------------------

INSERT IGNORE INTO `licenses` (`type`, `label`) VALUES
('weapon', 'Permis de port d''arme');

-- ---------------------------------------------------------------
-- Tableau des scores des points de capture (une ligne par armée)
-- ---------------------------------------------------------------

INSERT IGNORE INTO `ws_flag_point` (`job_name`, `points`) VALUES
('shadow', 0),
('kortac', 0),
('reacon', 0);
