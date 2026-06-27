-- ============================================================
-- qs-housing v5.3.38 - Database Schema
-- Run this SQL in your database before starting the script.
-- ============================================================

-- Main house locations table
CREATE TABLE IF NOT EXISTS `houselocations` (
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(255) NOT NULL,
    `label` VARCHAR(255) DEFAULT NULL,
    `coords` LONGTEXT DEFAULT NULL,
    `tier` VARCHAR(50) DEFAULT NULL,
    `garage` LONGTEXT DEFAULT NULL,
    `garageShell` LONGTEXT DEFAULT NULL,
    `price` INT(11) DEFAULT 0,
    `defaultPrice` INT(11) DEFAULT 0,
    `mlo` LONGTEXT DEFAULT NULL,
    `ipl` LONGTEXT DEFAULT NULL,
    `creator` VARCHAR(255) DEFAULT NULL,
    `creatorJob` VARCHAR(100) DEFAULT NULL,
    `creatorGotMoney` TINYINT(1) DEFAULT 0,
    `board` LONGTEXT DEFAULT NULL,
    `blip` LONGTEXT DEFAULT NULL,
    `permissions` LONGTEXT DEFAULT NULL,
    `upgrades` LONGTEXT DEFAULT NULL,
    `apartmentCount` INT(11) DEFAULT 0,
    `paymentMethod` VARCHAR(50) DEFAULT 'cash',
    `doorbellSound` VARCHAR(255) DEFAULT NULL,
    `assistantZoneMessagesEnabled` TINYINT(1) NOT NULL DEFAULT 1,
    `allowPlantInside` TINYINT(1) DEFAULT 1,
    `allowPlantOutside` TINYINT(1) DEFAULT 1,
    `photos` LONGTEXT DEFAULT '[]',
    `description` TEXT DEFAULT '',
    `hideFromBrowser` TINYINT(1) DEFAULT 0,
    PRIMARY KEY (`id`),
    UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Player houses (ownership, rent, keys)
CREATE TABLE IF NOT EXISTS `player_houses` (
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `house` VARCHAR(255) NOT NULL,
    `citizenid` VARCHAR(255) DEFAULT NULL,
    `owner` VARCHAR(255) DEFAULT NULL,
    `keyholders` LONGTEXT DEFAULT NULL,
    `credit` INT(11) DEFAULT 0,
    `creditPrice` INT(11) DEFAULT 0,
    `rentable` TINYINT(1) DEFAULT NULL,
    `rented` TINYINT(1) DEFAULT NULL,
    `rentPrice` INT(11) DEFAULT NULL,
    `rent_furnished` TINYINT(1) DEFAULT NULL,
    `purchasable` TINYINT(1) DEFAULT NULL,
    `sale_furnished` TINYINT(1) DEFAULT NULL,
    `stash` LONGTEXT DEFAULT NULL,
    `outfit` LONGTEXT DEFAULT NULL,
    `logout` LONGTEXT DEFAULT NULL,
    `charge` LONGTEXT DEFAULT NULL,
    `tablet` LONGTEXT DEFAULT NULL,
    `console` LONGTEXT DEFAULT NULL,
    `decorateStash` LONGTEXT DEFAULT NULL,
    `decorations` LONGTEXT DEFAULT NULL,
    `vaultCodes` LONGTEXT DEFAULT NULL,
    `lights_on` TINYINT(1) DEFAULT 0,
    `lights_on_since` BIGINT DEFAULT NULL,
    `rentNextChargeAt` DATETIME DEFAULT NULL,
    PRIMARY KEY (`id`),
    KEY `house` (`house`),
    KEY `citizenid` (`citizenid`),
    KEY `owner` (`owner`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- House objects (external objects placed in the world)
CREATE TABLE IF NOT EXISTS `house_objects` (
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `creator` VARCHAR(255) DEFAULT NULL,
    `coords` LONGTEXT DEFAULT NULL,
    `model` VARCHAR(255) DEFAULT NULL,
    `house` VARCHAR(255) DEFAULT '',
    `construction` VARCHAR(255) DEFAULT NULL,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- House decorations (furniture placed inside houses)
CREATE TABLE IF NOT EXISTS `house_decorations` (
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `creator` VARCHAR(255) DEFAULT NULL,
    `house` VARCHAR(255) NOT NULL,
    `modelName` VARCHAR(255) DEFAULT NULL,
    `coords` LONGTEXT DEFAULT NULL,
    `rotation` LONGTEXT DEFAULT NULL,
    `inStash` TINYINT(1) DEFAULT 0,
    `inHouse` TINYINT(1) DEFAULT 1,
    `created` BIGINT DEFAULT NULL,
    `uniq` VARCHAR(255) DEFAULT NULL,
    `lightData` LONGTEXT DEFAULT NULL,
    `wallartData` LONGTEXT DEFAULT NULL,
    `price` INT(11) DEFAULT 0,
    PRIMARY KEY (`id`),
    KEY `house` (`house`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- House rent payments
CREATE TABLE IF NOT EXISTS `house_rents` (
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `house` VARCHAR(255) NOT NULL,
    `identifier` VARCHAR(255) DEFAULT NULL,
    `payed` TINYINT(1) DEFAULT 0,
    `date` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    KEY `house` (`house`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- House bills (electricity, water, internet)
CREATE TABLE IF NOT EXISTS `house_bills` (
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `house` VARCHAR(255) NOT NULL,
    `total` INT(11) DEFAULT 0,
    `breakdown` LONGTEXT DEFAULT NULL,
    `payed` TINYINT(1) DEFAULT 0,
    `payed_by` VARCHAR(255) DEFAULT NULL,
    `payed_at` TIMESTAMP NULL DEFAULT NULL,
    `date` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    KEY `house` (`house`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Stolen furniture (robbery system)
CREATE TABLE IF NOT EXISTS `house_stolen_furniture` (
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `identifier` VARCHAR(255) NOT NULL,
    `house` VARCHAR(255) DEFAULT NULL,
    `modelName` VARCHAR(255) DEFAULT NULL,
    `label` VARCHAR(255) DEFAULT NULL,
    `price` INT(11) DEFAULT 0,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    KEY `identifier` (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Furniture catalog items
CREATE TABLE IF NOT EXISTS `qs_housing_furnitures` (
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `creator` VARCHAR(255) DEFAULT NULL,
    `category_key` VARCHAR(255) DEFAULT NULL,
    `object` VARCHAR(255) DEFAULT NULL,
    `label` VARCHAR(255) DEFAULT NULL,
    `description` TEXT DEFAULT '',
    `price` INT(11) DEFAULT 0,
    `img` VARCHAR(500) DEFAULT '',
    `colorlabel` VARCHAR(255) DEFAULT '',
    `type` VARCHAR(100) DEFAULT NULL,
    `stash` LONGTEXT DEFAULT NULL,
    `offset` LONGTEXT DEFAULT NULL,
    `colors` LONGTEXT DEFAULT NULL,
    PRIMARY KEY (`id`),
    KEY `category_key` (`category_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Furniture shops
CREATE TABLE IF NOT EXISTS `qs_housing_furniture_shops` (
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(255) DEFAULT NULL,
    `enter` LONGTEXT DEFAULT NULL,
    `blip` LONGTEXT DEFAULT NULL,
    `categories` LONGTEXT DEFAULT NULL,
    `creator` VARCHAR(255) DEFAULT NULL,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Furniture orders (delivery system)
CREATE TABLE IF NOT EXISTS `house_furniture_orders` (
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `house` VARCHAR(255) NOT NULL,
    `buyer_identifier` VARCHAR(255) DEFAULT NULL,
    `model_name` VARCHAR(255) DEFAULT NULL,
    `price` INT(11) DEFAULT 0,
    `payload_json` LONGTEXT DEFAULT NULL,
    `status` ENUM('pending','ready','collected','cancelled') DEFAULT 'pending',
    `deliver_at` DATETIME DEFAULT NULL,
    `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP,
    `updated_at` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    KEY `house` (`house`),
    KEY `status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Meta keys (physical key items)
CREATE TABLE IF NOT EXISTS `house_meta_keys` (
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `house` VARCHAR(255) NOT NULL,
    `key_id` VARCHAR(255) NOT NULL,
    `owner_identifier` VARCHAR(255) DEFAULT NULL,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    KEY `house` (`house`),
    KEY `key_id` (`key_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- House plants (qs-weed integration)
CREATE TABLE IF NOT EXISTS `house_plants` (
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `house` VARCHAR(255) NOT NULL,
    `coords` LONGTEXT DEFAULT NULL,
    `type` VARCHAR(100) DEFAULT NULL,
    `stage` INT(11) DEFAULT 0,
    `water` FLOAT DEFAULT 100,
    `fertilizer` FLOAT DEFAULT 100,
    `health` FLOAT DEFAULT 100,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    KEY `house` (`house`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
