-- MySQL dump 10.13  Distrib 8.0.35, for Linux (x86_64)
--
-- Host: 0.0.0.0    Database: zeprise
-- ------------------------------------------------------
-- Server version	8.0.32

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `addresses`
--

DROP TABLE IF EXISTS `addresses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `addresses` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `studio_id` bigint unsigned NOT NULL,
  `customer_id` bigint unsigned NOT NULL,
  `district_id` bigint unsigned NOT NULL,
  `thana_id` bigint unsigned NOT NULL,
  `street_address` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `addresses_studio_id_index` (`studio_id`),
  KEY `addresses_customer_id_index` (`customer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `addresses`
--

LOCK TABLES `addresses` WRITE;
/*!40000 ALTER TABLE `addresses` DISABLE KEYS */;
INSERT INTO `addresses` VALUES (1,1,9,63,484,'Mirpur-10, Dhaka, Bangladesh.','A','+8801345678909','2024-01-07 11:25:36','2024-01-07 11:25:36'),(2,1,10,63,484,'Mirpur-10, Dhaka, Bangladesh.','A','+8801345678907','2024-01-07 11:26:03','2024-01-07 11:26:03'),(3,1,11,63,484,'Mirpur-10, Dhaka, Bangladesh.','A','+8801793448623','2024-01-07 11:33:57','2024-01-07 11:33:57'),(4,1,12,63,484,'Mirpur-10, Dhaka, Bangladesh.','B','+8801234554546','2024-01-07 12:17:44','2024-01-07 12:17:44');
/*!40000 ALTER TABLE `addresses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `attribute_option_product`
--

DROP TABLE IF EXISTS `attribute_option_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `attribute_option_product` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `studio_id` bigint unsigned NOT NULL,
  `attribute_id` bigint unsigned NOT NULL,
  `option_id` bigint unsigned NOT NULL,
  `product_id` bigint unsigned NOT NULL,
  `custom_value` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `attribute_option_product_studio_id_index` (`studio_id`),
  KEY `attribute_option_product_attribute_id_index` (`attribute_id`),
  KEY `attribute_option_product_option_id_index` (`option_id`),
  KEY `attribute_option_product_product_id_index` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attribute_option_product`
--

LOCK TABLES `attribute_option_product` WRITE;
/*!40000 ALTER TABLE `attribute_option_product` DISABLE KEYS */;
/*!40000 ALTER TABLE `attribute_option_product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `attributes`
--

DROP TABLE IF EXISTS `attributes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `attributes` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `studio_id` bigint unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_enabled` tinyint(1) NOT NULL DEFAULT '0',
  `is_searchable` tinyint(1) NOT NULL DEFAULT '0',
  `is_filterable` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `attributes_studio_id_name_unique` (`studio_id`,`name`),
  UNIQUE KEY `attributes_studio_id_slug_unique` (`studio_id`,`slug`),
  KEY `attributes_studio_id_index` (`studio_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attributes`
--

LOCK TABLES `attributes` WRITE;
/*!40000 ALTER TABLE `attributes` DISABLE KEYS */;
INSERT INTO `attributes` VALUES (1,1,'Color','color',NULL,'colorpicker',1,0,1,'2024-01-08 03:48:35','2024-01-08 07:56:39'),(2,1,'Size','size',NULL,'checkbox',1,1,1,'2024-01-08 04:34:41','2024-01-08 04:34:41');
/*!40000 ALTER TABLE `attributes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `brands`
--

DROP TABLE IF EXISTS `brands`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `brands` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `studio_id` bigint unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci,
  `position` smallint unsigned NOT NULL DEFAULT '0',
  `is_enabled` tinyint(1) NOT NULL DEFAULT '1',
  `is_searchable` tinyint(1) NOT NULL DEFAULT '1',
  `seo_title` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `seo_description` varchar(160) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `brands_studio_id_name_unique` (`studio_id`,`name`),
  UNIQUE KEY `brands_studio_id_slug_unique` (`studio_id`,`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `brands`
--

LOCK TABLES `brands` WRITE;
/*!40000 ALTER TABLE `brands` DISABLE KEYS */;
INSERT INTO `brands` VALUES (1,1,'Alex Harison','alex-harison',NULL,2,0,1,NULL,NULL,'2024-01-06 06:30:23','2024-01-06 08:44:17'),(2,1,'Exceptional','exceptional',NULL,1,0,1,NULL,NULL,'2024-01-06 08:28:58','2024-01-06 08:44:17');
/*!40000 ALTER TABLE `brands` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `studio_id` bigint unsigned NOT NULL,
  `parent_id` bigint unsigned DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci,
  `position` smallint unsigned NOT NULL DEFAULT '0',
  `is_enabled` tinyint(1) NOT NULL DEFAULT '1',
  `is_searchable` tinyint(1) NOT NULL DEFAULT '1',
  `seo_title` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `seo_description` varchar(160) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `categories_studio_id_name_unique` (`studio_id`,`name`),
  UNIQUE KEY `categories_studio_id_slug_unique` (`studio_id`,`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (1,1,NULL,'Women','women',NULL,0,1,1,NULL,NULL,'2024-01-06 09:30:31','2024-01-06 09:30:31'),(2,1,NULL,'Men','men',NULL,0,0,1,NULL,NULL,'2024-01-06 09:31:50','2024-01-06 12:33:14'),(3,1,2,'Accessories','accessories',NULL,0,1,1,NULL,NULL,'2024-01-06 10:27:52','2024-01-06 10:27:52'),(4,1,3,'Bags','bags',NULL,0,1,1,NULL,NULL,'2024-01-06 10:53:16','2024-01-06 10:53:16'),(5,4,NULL,'Exceptional','exceptional',NULL,0,1,1,NULL,NULL,'2024-01-06 12:10:12','2024-01-06 12:10:12');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category_product`
--

DROP TABLE IF EXISTS `category_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category_product` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `category_id` bigint unsigned NOT NULL,
  `product_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category_product`
--

LOCK TABLES `category_product` WRITE;
/*!40000 ALTER TABLE `category_product` DISABLE KEYS */;
INSERT INTO `category_product` VALUES (1,1,1,NULL,NULL);
/*!40000 ALTER TABLE `category_product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `connected_accounts`
--

DROP TABLE IF EXISTS `connected_accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `connected_accounts` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `provider` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `provider_user_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nickname` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `avatar` text COLLATE utf8mb4_unicode_ci,
  `token` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `refresh_token` text COLLATE utf8mb4_unicode_ci,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `connected_accounts_user_id_foreign` (`user_id`),
  CONSTRAINT `connected_accounts_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `connected_accounts`
--

LOCK TABLES `connected_accounts` WRITE;
/*!40000 ALTER TABLE `connected_accounts` DISABLE KEYS */;
/*!40000 ALTER TABLE `connected_accounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customers`
--

DROP TABLE IF EXISTS `customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customers` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `studio_id` bigint unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `customers_studio_id_phone_unique` (`studio_id`,`phone`),
  KEY `customers_studio_id_index` (`studio_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customers`
--

LOCK TABLES `customers` WRITE;
/*!40000 ALTER TABLE `customers` DISABLE KEYS */;
INSERT INTO `customers` VALUES (1,1,'Alex Harison','+8801793448624','$2y$12$ol1GfYojlqkW/3kCc0lvcerRRaVexn41oY1KgxVf0BTOHE7khDGBK',NULL,'2024-01-07 09:13:11','2024-01-07 09:13:11'),(3,1,'Has Address','+8801898889898','$2y$12$eu5J7OGYOZx.yKG..zDNYe/HkSUDG0Nih.EQjRoZGJPZ9fDKJdbpe',NULL,'2024-01-07 10:53:13','2024-01-07 10:53:13'),(8,1,'Has Password','+8801898998989','$2y$12$cRc/F3BdocCG1p/PzUVR5.FuDqME..xG5RfgfnYX3V81dbNthZZzm',NULL,'2024-01-07 11:17:34','2024-01-07 11:17:34'),(11,1,'A','+8801793448623','$2y$12$kfVC.cj.DM0XBHhc64JTfuqzBDLmfoKXk6fBdnWfETTSv1axxPXyi',NULL,'2024-01-07 11:33:57','2024-01-07 12:47:58'),(12,1,'B','+8801234554546','$2y$12$of6G8cTLELA5j5.j8uR8DOD8.z.nOGnB01oR8mK2fBSYcG1aKRSYC',NULL,'2024-01-07 12:17:44','2024-01-07 12:17:44');
/*!40000 ALTER TABLE `customers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `districts`
--

DROP TABLE IF EXISTS `districts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `districts` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `districts`
--

LOCK TABLES `districts` WRITE;
/*!40000 ALTER TABLE `districts` DISABLE KEYS */;
INSERT INTO `districts` VALUES (1,'Bagerhat'),(2,'Bandarban'),(3,'Barguna'),(4,'Barisal'),(5,'Bhola'),(6,'Bogura'),(7,'Brahmanbaria'),(8,'Chandpur'),(9,'Chapainawabganj'),(10,'Chattogram'),(11,'Chuadanga'),(12,'Comilla'),(13,'Coxsbazar'),(14,'Dhaka'),(15,'Dinajpur'),(16,'Faridpur'),(17,'Feni'),(18,'Gaibandha'),(19,'Gazipur'),(20,'Gopalganj'),(21,'Habiganj'),(22,'Jamalpur'),(23,'Jashore'),(24,'Jhalakathi'),(25,'Jhenaidah'),(26,'Joypurhat'),(27,'Khagrachhari'),(28,'Khulna'),(29,'Kishoreganj'),(30,'Kurigram'),(31,'Kushtia'),(32,'Lakshmipur'),(33,'Lalmonirhat'),(34,'Madaripur'),(35,'Magura'),(36,'Manikganj'),(37,'Meherpur'),(38,'Moulvibazar'),(39,'Munshiganj'),(40,'Mymensingh'),(41,'Naogaon'),(42,'Narail'),(43,'Narayanganj'),(44,'Narsingdi'),(45,'Natore'),(46,'Netrokona'),(47,'Nilphamari'),(48,'Noakhali'),(49,'Pabna'),(50,'Panchagarh'),(51,'Patuakhali'),(52,'Pirojpur'),(53,'Rajbari'),(54,'Rajshahi'),(55,'Rangamati'),(56,'Rangpur'),(57,'Satkhira'),(58,'Shariatpur'),(59,'Sherpur'),(60,'Sirajganj'),(61,'Sunamganj'),(62,'Sylhet'),(63,'Tangail'),(64,'Thakurgaon');
/*!40000 ALTER TABLE `districts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `failed_jobs`
--

DROP TABLE IF EXISTS `failed_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `failed_jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `failed_jobs`
--

LOCK TABLES `failed_jobs` WRITE;
/*!40000 ALTER TABLE `failed_jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `failed_jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `feature_consumptions`
--

DROP TABLE IF EXISTS `feature_consumptions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `feature_consumptions` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `consumption` decimal(8,2) unsigned DEFAULT NULL,
  `expired_at` timestamp NULL DEFAULT NULL,
  `feature_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `subscriber_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `subscriber_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `feature_consumptions_feature_id_foreign` (`feature_id`),
  KEY `feature_consumptions_subscriber_type_subscriber_id_index` (`subscriber_type`,`subscriber_id`),
  CONSTRAINT `feature_consumptions_feature_id_foreign` FOREIGN KEY (`feature_id`) REFERENCES `features` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `feature_consumptions`
--

LOCK TABLES `feature_consumptions` WRITE;
/*!40000 ALTER TABLE `feature_consumptions` DISABLE KEYS */;
/*!40000 ALTER TABLE `feature_consumptions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `feature_plan`
--

DROP TABLE IF EXISTS `feature_plan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `feature_plan` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `charges` decimal(8,2) DEFAULT NULL,
  `feature_id` bigint unsigned NOT NULL,
  `plan_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `feature_plan_feature_id_foreign` (`feature_id`),
  KEY `feature_plan_plan_id_foreign` (`plan_id`),
  CONSTRAINT `feature_plan_feature_id_foreign` FOREIGN KEY (`feature_id`) REFERENCES `features` (`id`) ON DELETE CASCADE,
  CONSTRAINT `feature_plan_plan_id_foreign` FOREIGN KEY (`plan_id`) REFERENCES `plans` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `feature_plan`
--

LOCK TABLES `feature_plan` WRITE;
/*!40000 ALTER TABLE `feature_plan` DISABLE KEYS */;
INSERT INTO `feature_plan` VALUES (1,10.00,1,1,NULL,NULL),(2,50.00,1,2,NULL,NULL),(3,NULL,2,2,NULL,NULL),(4,100.00,1,3,NULL,NULL),(5,NULL,2,3,NULL,NULL);
/*!40000 ALTER TABLE `feature_plan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `feature_tickets`
--

DROP TABLE IF EXISTS `feature_tickets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `feature_tickets` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `charges` decimal(8,2) DEFAULT NULL,
  `expired_at` timestamp NULL DEFAULT NULL,
  `feature_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `subscriber_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `subscriber_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `feature_tickets_feature_id_foreign` (`feature_id`),
  KEY `feature_tickets_subscriber_type_subscriber_id_index` (`subscriber_type`,`subscriber_id`),
  CONSTRAINT `feature_tickets_feature_id_foreign` FOREIGN KEY (`feature_id`) REFERENCES `features` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `feature_tickets`
--

LOCK TABLES `feature_tickets` WRITE;
/*!40000 ALTER TABLE `feature_tickets` DISABLE KEYS */;
/*!40000 ALTER TABLE `feature_tickets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `features`
--

DROP TABLE IF EXISTS `features`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `features` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `consumable` tinyint(1) NOT NULL,
  `quota` tinyint(1) NOT NULL DEFAULT '0',
  `postpaid` tinyint(1) NOT NULL DEFAULT '0',
  `periodicity` int unsigned DEFAULT NULL,
  `periodicity_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `features`
--

LOCK TABLES `features` WRITE;
/*!40000 ALTER TABLE `features` DISABLE KEYS */;
INSERT INTO `features` VALUES (1,'daily-order',1,0,0,1,'Day',NULL,'2024-01-04 15:22:29','2024-01-04 15:22:29'),(2,'custom-domain',0,0,0,NULL,NULL,NULL,'2024-01-04 15:22:29','2024-01-04 15:22:29');
/*!40000 ALTER TABLE `features` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `media`
--

DROP TABLE IF EXISTS `media`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `media` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `model_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint unsigned NOT NULL,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `collection_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `file_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mime_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `disk` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `conversions_disk` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `size` bigint unsigned NOT NULL,
  `manipulations` json NOT NULL,
  `custom_properties` json NOT NULL,
  `generated_conversions` json NOT NULL,
  `responsive_images` json NOT NULL,
  `order_column` int unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `media_uuid_unique` (`uuid`),
  KEY `media_model_type_model_id_index` (`model_type`,`model_id`),
  KEY `media_order_column_index` (`order_column`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `media`
--

LOCK TABLES `media` WRITE;
/*!40000 ALTER TABLE `media` DISABLE KEYS */;
INSERT INTO `media` VALUES (1,'App\\Models\\Shop\\Brand',1,'cd66a03e-43b1-4e81-ba79-247a963a8a26','default','1676226384-Bowl-Spoon-Utensil-Holder-Dish-Clamp-Pot-Pan-Gripper-Clip-Hot-Dish-Plate-Bowl-Clip-Tongs-Silicone-Handle-(2)','01HKEX5TTDMP8RBD32RAW4AGA5.png','image/png','public','public',426082,'[]','[]','[]','[]',1,'2024-01-06 08:10:36','2024-01-06 08:10:36'),(2,'App\\Models\\Shop\\Brand',2,'633ff9d7-fbb2-407f-8570-b028c0dbd75e','default','Sumon Ahmed','01HKEY7F6D9GDD1TDYPXVA91ZS.png','image/png','public','public',1050530,'[]','[]','[]','[]',1,'2024-01-06 08:28:58','2024-01-06 08:28:58'),(3,'App\\Models\\Shop\\Category',2,'5e5c751c-b37e-4806-90ce-8606e5e9714a','default','Resources-Tree','01HKFC6Q0A8A36J8JNM7FBSCGQ.png','image/png','public','public',26927,'[]','[]','[]','[]',1,'2024-01-06 12:33:14','2024-01-06 12:33:14'),(4,'App\\Models\\Shop\\Product',1,'79021626-ca6e-4738-9822-38985fe0c5e0','product-images','Screenshot from 2024-01-02 14-31-58','01HKH4C2V671QJZ21137W00Z7C.png','image/png','public','public',83974,'[]','[]','[]','[]',1,'2024-01-07 04:54:50','2024-01-07 04:54:50'),(5,'App\\Models\\Shop\\Product',1,'dcb0c35a-ec92-405d-bd47-54af8c2cedda','product-images','Resources-Tree','01HKH4EEQ769HE544PG3QFTPF4.png','image/png','public','public',26927,'[]','[]','[]','[]',2,'2024-01-07 04:56:08','2024-01-07 04:56:08');
/*!40000 ALTER TABLE `media` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `migrations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (1,'2014_10_12_000000_create_users_table',1),(2,'2014_10_12_100000_create_password_reset_tokens_table',1),(3,'2019_08_19_000000_create_failed_jobs_table',1),(4,'2019_12_14_000001_create_personal_access_tokens_table',1),(5,'2022_02_01_233701_create_plans_table',1),(6,'2022_02_01_235539_create_subscriptions_table',1),(7,'2022_02_01_235540_create_features_table',1),(8,'2022_02_02_000527_create_feature_consumptions_table',1),(9,'2022_02_03_001206_create_subscription_renewals_table',1),(10,'2022_02_04_001622_create_feature_plan_table',1),(11,'2022_02_25_001622_create_feature_tickets_table',1),(15,'2023_12_27_044227_create_notifications_table',1),(16,'2024_01_04_151546_create_brands_table',1),(17,'2023_12_25_164554_create_permission_tables',2),(18,'2024_01_04_153011_create_connected_accounts_table',3),(19,'2024_01_04_153012_modify_users_table_nullable_password',3),(22,'2024_01_05_145654_create_districts_table',4),(23,'2024_01_05_145703_create_thanas_table',4),(24,'2023_12_24_134042_create_studios_table',5),(25,'2024_01_06_060453_create_categories_table',5),(26,'2024_01_06_072857_create_media_table',5),(27,'2024_01_06_130054_create_category_product_table',6),(28,'2023_12_25_060823_create_products_table',7),(33,'2024_01_06_152414_create_addresses_table',8),(34,'2024_01_06_152425_create_customers_table',8),(35,'2024_01_07_143611_create_attributes_table',9),(36,'2024_01_07_143757_create_options_table',10),(37,'2024_01_07_145344_create_attribute_option_product_table',11);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `model_has_permissions`
--

DROP TABLE IF EXISTS `model_has_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `model_has_permissions` (
  `permission_id` bigint unsigned NOT NULL,
  `model_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint unsigned NOT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  UNIQUE KEY `model_has_permissions_permission_model_type_primary` (`user_id`,`permission_id`,`model_id`,`model_type`),
  KEY `model_has_permissions_model_id_model_type_index` (`model_id`,`model_type`),
  KEY `model_has_permissions_team_foreign_key_index` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `model_has_permissions`
--

LOCK TABLES `model_has_permissions` WRITE;
/*!40000 ALTER TABLE `model_has_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `model_has_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `model_has_roles`
--

DROP TABLE IF EXISTS `model_has_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `model_has_roles` (
  `role_id` bigint unsigned NOT NULL,
  `model_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint unsigned NOT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  UNIQUE KEY `model_has_roles_role_model_type_primary` (`user_id`,`role_id`,`model_id`,`model_type`),
  KEY `model_has_roles_model_id_model_type_index` (`model_id`,`model_type`),
  KEY `model_has_roles_team_foreign_key_index` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `model_has_roles`
--

LOCK TABLES `model_has_roles` WRITE;
/*!40000 ALTER TABLE `model_has_roles` DISABLE KEYS */;
INSERT INTO `model_has_roles` VALUES (1,'App\\Models\\User',1,NULL),(1,'App\\Models\\User',2,2);
/*!40000 ALTER TABLE `model_has_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notifications`
--

DROP TABLE IF EXISTS `notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notifications` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `notifiable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `notifiable_id` bigint unsigned NOT NULL,
  `data` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `read_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `notifications_notifiable_type_notifiable_id_index` (`notifiable_type`,`notifiable_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notifications`
--

LOCK TABLES `notifications` WRITE;
/*!40000 ALTER TABLE `notifications` DISABLE KEYS */;
/*!40000 ALTER TABLE `notifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `options`
--

DROP TABLE IF EXISTS `options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `options` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `attribute_id` bigint unsigned NOT NULL,
  `value` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `position` smallint unsigned NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `options_studio_id_key_unique` (`key`),
  KEY `options_attribute_id_index` (`attribute_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `options`
--

LOCK TABLES `options` WRITE;
/*!40000 ALTER TABLE `options` DISABLE KEYS */;
INSERT INTO `options` VALUES (1,2,'XS','xs',0,'2024-01-08 07:53:07','2024-01-08 07:53:07'),(2,2,'SM','sm',0,'2024-01-08 07:54:36','2024-01-08 07:54:36'),(3,2,'MD','md',0,'2024-01-08 07:55:21','2024-01-08 07:55:21'),(4,2,'LG','lg',0,'2024-01-08 07:55:29','2024-01-08 07:55:29'),(5,2,'XL','xl',0,'2024-01-08 07:55:38','2024-01-08 07:55:38'),(6,1,'red','red',0,'2024-01-10 13:29:58','2024-01-10 13:29:58'),(7,1,'green','green',0,'2024-01-10 13:30:22','2024-01-10 13:30:22'),(8,1,'blue','blue',0,'2024-01-10 13:30:36','2024-01-10 13:30:36'),(9,1,'#333','333',0,'2024-01-10 13:31:06','2024-01-10 13:31:06');
/*!40000 ALTER TABLE `options` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_reset_tokens`
--

DROP TABLE IF EXISTS `password_reset_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_reset_tokens`
--

LOCK TABLES `password_reset_tokens` WRITE;
/*!40000 ALTER TABLE `password_reset_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_reset_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permissions`
--

DROP TABLE IF EXISTS `permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `permissions` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `permissions_name_guard_name_unique` (`name`,`guard_name`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permissions`
--

LOCK TABLES `permissions` WRITE;
/*!40000 ALTER TABLE `permissions` DISABLE KEYS */;
INSERT INTO `permissions` VALUES (1,'view_product','web','2024-01-04 15:22:53','2024-01-04 15:22:53'),(2,'view_any_product','web','2024-01-04 15:22:53','2024-01-04 15:22:53'),(3,'create_product','web','2024-01-04 15:22:53','2024-01-04 15:22:53'),(4,'update_product','web','2024-01-04 15:22:53','2024-01-04 15:22:53'),(5,'restore_product','web','2024-01-04 15:22:53','2024-01-04 15:22:53'),(6,'restore_any_product','web','2024-01-04 15:22:53','2024-01-04 15:22:53'),(7,'replicate_product','web','2024-01-04 15:22:53','2024-01-04 15:22:53'),(8,'reorder_product','web','2024-01-04 15:22:53','2024-01-04 15:22:53'),(9,'delete_product','web','2024-01-04 15:22:53','2024-01-04 15:22:53'),(10,'delete_any_product','web','2024-01-04 15:22:53','2024-01-04 15:22:53'),(11,'force_delete_product','web','2024-01-04 15:22:53','2024-01-04 15:22:53'),(12,'force_delete_any_product','web','2024-01-04 15:22:53','2024-01-04 15:22:53'),(13,'view_shield::role','web','2024-01-04 15:22:53','2024-01-04 15:22:53'),(14,'view_any_shield::role','web','2024-01-04 15:22:53','2024-01-04 15:22:53'),(15,'create_shield::role','web','2024-01-04 15:22:53','2024-01-04 15:22:53'),(16,'update_shield::role','web','2024-01-04 15:22:53','2024-01-04 15:22:53'),(17,'delete_shield::role','web','2024-01-04 15:22:53','2024-01-04 15:22:53'),(18,'delete_any_shield::role','web','2024-01-04 15:22:53','2024-01-04 15:22:53'),(19,'view_user','web','2024-01-04 15:22:53','2024-01-04 15:22:53'),(20,'view_any_user','web','2024-01-04 15:22:53','2024-01-04 15:22:53'),(21,'create_user','web','2024-01-04 15:22:53','2024-01-04 15:22:53'),(22,'update_user','web','2024-01-04 15:22:53','2024-01-04 15:22:53'),(23,'restore_user','web','2024-01-04 15:22:53','2024-01-04 15:22:53'),(24,'restore_any_user','web','2024-01-04 15:22:53','2024-01-04 15:22:53'),(25,'replicate_user','web','2024-01-04 15:22:53','2024-01-04 15:22:53'),(26,'reorder_user','web','2024-01-04 15:22:53','2024-01-04 15:22:53'),(27,'delete_user','web','2024-01-04 15:22:53','2024-01-04 15:22:53'),(28,'delete_any_user','web','2024-01-04 15:22:53','2024-01-04 15:22:53'),(29,'force_delete_user','web','2024-01-04 15:22:53','2024-01-04 15:22:53'),(30,'force_delete_any_user','web','2024-01-04 15:22:53','2024-01-04 15:22:53');
/*!40000 ALTER TABLE `permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `personal_access_tokens`
--

DROP TABLE IF EXISTS `personal_access_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `personal_access_tokens` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `personal_access_tokens`
--

LOCK TABLES `personal_access_tokens` WRITE;
/*!40000 ALTER TABLE `personal_access_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `personal_access_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `plans`
--

DROP TABLE IF EXISTS `plans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `plans` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `grace_days` int NOT NULL DEFAULT '0',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `periodicity` int unsigned DEFAULT NULL,
  `periodicity_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `plans`
--

LOCK TABLES `plans` WRITE;
/*!40000 ALTER TABLE `plans` DISABLE KEYS */;
INSERT INTO `plans` VALUES (1,0,'free',NULL,NULL,NULL,'2024-01-04 15:22:29','2024-01-04 15:22:29'),(2,7,'silver',1,'Month',NULL,'2024-01-04 15:22:30','2024-01-04 15:22:30'),(3,7,'gold',1,'Month',NULL,'2024-01-04 15:22:30','2024-01-04 15:22:30');
/*!40000 ALTER TABLE `plans` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `studio_id` bigint unsigned NOT NULL,
  `brand_id` bigint unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sku` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `barcode` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci,
  `security_stock` bigint unsigned NOT NULL DEFAULT '0',
  `is_featured` tinyint(1) NOT NULL DEFAULT '0',
  `is_enabled` tinyint(1) NOT NULL DEFAULT '0',
  `old_price` decimal(10,2) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `type` enum('deliverable','downloadable') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `backorder` tinyint(1) NOT NULL DEFAULT '0',
  `seo_title` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `seo_description` varchar(160) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `requires_shipping` tinyint(1) NOT NULL DEFAULT '0',
  `weight_value` decimal(10,5) unsigned DEFAULT '0.00000',
  `weight_unit` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'kg',
  `height_value` decimal(10,5) unsigned DEFAULT '0.00000',
  `height_unit` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'cm',
  `width_value` decimal(10,5) unsigned DEFAULT '0.00000',
  `width_unit` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'cm',
  `depth_value` decimal(10,5) unsigned DEFAULT '0.00000',
  `depth_unit` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'cm',
  `volume_value` decimal(10,5) unsigned DEFAULT '0.00000',
  `volume_unit` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'l',
  `published_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `products_studio_id_name_unique` (`studio_id`,`name`),
  UNIQUE KEY `products_studio_id_slug_unique` (`studio_id`,`slug`),
  UNIQUE KEY `products_studio_id_sku_unique` (`studio_id`,`sku`),
  UNIQUE KEY `products_studio_id_barcode_unique` (`studio_id`,`barcode`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,1,1,'Alex Product','alex-product','AP','AB','a p',3,0,1,125.00,100.00,NULL,1,NULL,NULL,1,0.00000,'kg',0.00000,'cm',0.00000,'cm',0.00000,'cm',0.00000,'l','2024-01-06 00:00:00','2024-01-06 14:10:35','2024-01-07 04:56:08');
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role_has_permissions`
--

DROP TABLE IF EXISTS `role_has_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `role_has_permissions` (
  `permission_id` bigint unsigned NOT NULL,
  `role_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`permission_id`,`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role_has_permissions`
--

LOCK TABLES `role_has_permissions` WRITE;
/*!40000 ALTER TABLE `role_has_permissions` DISABLE KEYS */;
INSERT INTO `role_has_permissions` VALUES (1,1),(2,1),(3,1),(4,1),(5,1),(6,1),(7,1),(8,1),(9,1),(10,1),(11,1),(12,1),(13,1),(14,1),(15,1),(16,1),(17,1),(18,1),(19,1),(20,1),(21,1),(22,1),(23,1),(24,1),(25,1),(26,1),(27,1),(28,1),(29,1),(30,1);
/*!40000 ALTER TABLE `role_has_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `roles_user_id_name_guard_name_unique` (`user_id`,`name`,`guard_name`),
  KEY `roles_team_foreign_key_index` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,NULL,'super_admin','web','2024-01-04 15:22:53','2024-01-04 15:22:53');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `studio_user`
--

DROP TABLE IF EXISTS `studio_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `studio_user` (
  `studio_id` bigint unsigned NOT NULL,
  `user_id` bigint unsigned NOT NULL,
  `owner` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`studio_id`,`user_id`),
  KEY `studio_user_studio_id_index` (`studio_id`),
  KEY `studio_user_user_id_index` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `studio_user`
--

LOCK TABLES `studio_user` WRITE;
/*!40000 ALTER TABLE `studio_user` DISABLE KEYS */;
INSERT INTO `studio_user` VALUES (1,2,1,NULL,NULL),(4,2,1,NULL,NULL);
/*!40000 ALTER TABLE `studio_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `studios`
--

DROP TABLE IF EXISTS `studios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `studios` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `about` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `district_id` bigint unsigned NOT NULL,
  `thana_id` bigint unsigned NOT NULL,
  `street_address` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `facebook` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `instagram` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tiktok` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `youtube` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `studios_slug_unique` (`slug`),
  UNIQUE KEY `studios_email_unique` (`email`),
  UNIQUE KEY `studios_phone_unique` (`phone`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `studios`
--

LOCK TABLES `studios` WRITE;
/*!40000 ALTER TABLE `studios` DISABLE KEYS */;
INSERT INTO `studios` VALUES (1,'Alex Harison','alex-harison','alexharisont20@gmail.com','+8801793448624','alex',63,484,'Mirpur-10, Dhaka, Bangladesh.','https://fb.me','https://insta.gram','https://tik.tok',NULL,'2024-01-06 07:32:28','2024-01-06 07:32:28'),(4,'Exceptional','exceptional','exceptional@gmail.com','+8801793448625','ex',63,484,'Mirpur-10, Dhaka, Bangladesh.','https://fb.me',NULL,NULL,NULL,'2024-01-06 11:53:59','2024-01-06 11:53:59');
/*!40000 ALTER TABLE `studios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subscription_renewals`
--

DROP TABLE IF EXISTS `subscription_renewals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `subscription_renewals` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `overdue` tinyint(1) NOT NULL,
  `renewal` tinyint(1) NOT NULL,
  `subscription_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subscription_renewals`
--

LOCK TABLES `subscription_renewals` WRITE;
/*!40000 ALTER TABLE `subscription_renewals` DISABLE KEYS */;
/*!40000 ALTER TABLE `subscription_renewals` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subscriptions`
--

DROP TABLE IF EXISTS `subscriptions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `subscriptions` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `plan_id` bigint unsigned NOT NULL,
  `canceled_at` timestamp NULL DEFAULT NULL,
  `expired_at` timestamp NULL DEFAULT NULL,
  `grace_days_ended_at` timestamp NULL DEFAULT NULL,
  `started_at` date NOT NULL,
  `suppressed_at` timestamp NULL DEFAULT NULL,
  `was_switched` tinyint(1) NOT NULL DEFAULT '0',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `subscriber_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `subscriber_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `subscriptions_subscriber_type_subscriber_id_index` (`subscriber_type`,`subscriber_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subscriptions`
--

LOCK TABLES `subscriptions` WRITE;
/*!40000 ALTER TABLE `subscriptions` DISABLE KEYS */;
INSERT INTO `subscriptions` VALUES (1,1,NULL,NULL,NULL,'2024-01-06',NULL,0,NULL,'2024-01-06 04:30:36','2024-01-06 04:30:36','App\\Models\\Studio',1),(2,1,NULL,NULL,NULL,'2024-01-06',NULL,0,NULL,'2024-01-06 07:32:28','2024-01-06 07:32:28','App\\Models\\Studio',1),(3,1,NULL,NULL,NULL,'2024-01-06',NULL,0,NULL,'2024-01-06 11:53:59','2024-01-06 11:53:59','App\\Models\\Studio',4);
/*!40000 ALTER TABLE `subscriptions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `thanas`
--

DROP TABLE IF EXISTS `thanas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `thanas` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `district_id` bigint unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `thanas_district_id_index` (`district_id`)
) ENGINE=InnoDB AUTO_INCREMENT=495 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `thanas`
--

LOCK TABLES `thanas` WRITE;
/*!40000 ALTER TABLE `thanas` DISABLE KEYS */;
INSERT INTO `thanas` VALUES (1,1,'Fakirhat'),(2,1,'Bagerhat Sadar'),(3,1,'Mollahat'),(4,1,'Sarankhola'),(5,1,'Rampal'),(6,1,'Morrelganj'),(7,1,'Kachua'),(8,1,'Mongla'),(9,1,'Chitalmari'),(10,2,'Bandarban Sadar'),(11,2,'Alikadam'),(12,2,'Naikhongchhari'),(13,2,'Rowangchhari'),(14,2,'Lama'),(15,2,'Ruma'),(16,2,'Thanchi'),(17,3,'Amtali'),(18,3,'Barguna Sadar'),(19,3,'Betagi'),(20,3,'Bamna'),(21,3,'Pathorghata'),(22,3,'Taltali'),(23,4,'Barisal Sadar'),(24,4,'Bakerganj'),(25,4,'Babuganj'),(26,4,'Wazirpur'),(27,4,'Banaripara'),(28,4,'Gournadi'),(29,4,'Agailjhara'),(30,4,'Mehendiganj'),(31,4,'Muladi'),(32,4,'Hizla'),(33,5,'Bhola Sadar'),(34,5,'Borhan Sddin'),(35,5,'Charfesson'),(36,5,'Doulatkhan'),(37,5,'Monpura'),(38,5,'Tazumuddin'),(39,5,'Lalmohan'),(40,6,'Kahaloo'),(41,6,'Bogra Sadar'),(42,6,'Shariakandi'),(43,6,'Shajahanpur'),(44,6,'Dupchanchia'),(45,6,'Adamdighi'),(46,6,'Nondigram'),(47,6,'Sonatala'),(48,6,'Dhunot'),(49,6,'Gabtali'),(50,6,'Sherpur'),(51,6,'Shibganj'),(52,7,'Brahmanbaria Sadar'),(53,7,'Kasba'),(54,7,'Nasirnagar'),(55,7,'Sarail'),(56,7,'Ashuganj'),(57,7,'Akhaura'),(58,7,'Nabinagar'),(59,7,'Bancharampur'),(60,7,'Bijoynagar'),(61,8,'Haimchar'),(62,8,'Kachua'),(63,8,'Shahrasti'),(64,8,'Chandpur Sadar'),(65,8,'Matlab South'),(66,8,'Hajiganj'),(67,8,'Matlab North'),(68,8,'Faridgonj'),(69,9,'Chapainawabganj Sadar'),(70,9,'Gomostapur'),(71,9,'Nachol'),(72,9,'Bholahat'),(73,9,'Shibganj'),(74,10,'Rangunia'),(75,10,'Sitakunda'),(76,10,'Mirsharai'),(77,10,'Patiya'),(78,10,'Sandwip'),(79,10,'Banshkhali'),(80,10,'Boalkhali'),(81,10,'Anwara'),(82,10,'Chandanaish'),(83,10,'Satkania'),(84,10,'Lohagara'),(85,10,'Hathazari'),(86,10,'Fatikchhari'),(87,10,'Raozan'),(88,10,'Karnafuli'),(89,11,'Chuadanga Sadar'),(90,11,'Alamdanga'),(91,11,'Damurhuda'),(92,11,'Jibannagar'),(93,12,'Debidwar'),(94,12,'Barura'),(95,12,'Brahmanpara'),(96,12,'Chandina'),(97,12,'Chauddagram'),(98,12,'Daudkandi'),(99,12,'Homna'),(100,12,'Laksam'),(101,12,'Muradnagar'),(102,12,'Nangalkot'),(103,12,'Comilla Sadar'),(104,12,'Meghna'),(105,12,'Monohargonj'),(106,12,'Sadarsouth'),(107,12,'Titas'),(108,12,'Burichang'),(109,12,'Lalmai'),(110,13,'Coxsbazar Sadar'),(111,13,'Chakaria'),(112,13,'Kutubdia'),(113,13,'Ukhiya'),(114,13,'Moheshkhali'),(115,13,'Pekua'),(116,13,'Ramu'),(117,13,'Teknaf'),(118,13,'Eidgaon'),(119,14,'Savar'),(120,14,'Dhamrai'),(121,14,'Keraniganj'),(122,14,'Nawabganj'),(123,14,'Dohar'),(124,15,'Nawabganj'),(125,15,'Birganj'),(126,15,'Ghoraghat'),(127,15,'Birampur'),(128,15,'Parbatipur'),(129,15,'Bochaganj'),(130,15,'Kaharol'),(131,15,'Fulbari'),(132,15,'Dinajpur Sadar'),(133,15,'Hakimpur'),(134,15,'Khansama'),(135,15,'Birol'),(136,15,'Chirirbandar'),(137,16,'Faridpur Sadar'),(138,16,'Alfadanga'),(139,16,'Boalmari'),(140,16,'Sadarpur'),(141,16,'Nagarkanda'),(142,16,'Bhanga'),(143,16,'Charbhadrasan'),(144,16,'Madhukhali'),(145,16,'Saltha'),(146,17,'Chhagalnaiya'),(147,17,'Feni Sadar'),(148,17,'Sonagazi'),(149,17,'Fulgazi'),(150,17,'Parshuram'),(151,17,'Daganbhuiyan'),(152,18,'Sadullapur'),(153,18,'Gaibandha Sadar'),(154,18,'Palashbari'),(155,18,'Saghata'),(156,18,'Gobindaganj'),(157,18,'Sundarganj'),(158,18,'Phulchari'),(159,19,'Kaliganj'),(160,19,'Kaliakair'),(161,19,'Kapasia'),(162,19,'Gazipur Sadar'),(163,19,'Sreepur'),(164,20,'Gopalganj Sadar'),(165,20,'Kashiani'),(166,20,'Tungipara'),(167,20,'Kotalipara'),(168,20,'Muksudpur'),(169,21,'Nabiganj'),(170,21,'Bahubal'),(171,21,'Ajmiriganj'),(172,21,'Baniachong'),(173,21,'Lakhai'),(174,21,'Chunarughat'),(175,21,'Habiganj Sadar'),(176,21,'Madhabpur'),(177,22,'Jamalpur Sadar'),(178,22,'Melandah'),(179,22,'Islampur'),(180,22,'Dewangonj'),(181,22,'Sarishabari'),(182,22,'Madarganj'),(183,22,'Bokshiganj'),(184,23,'Manirampur'),(185,23,'Abhaynagar'),(186,23,'Bagherpara'),(187,23,'Chougachha'),(188,23,'Jhikargacha'),(189,23,'Keshabpur'),(190,23,'Jessore Sadar'),(191,23,'Sharsha'),(192,24,'Jhalakathi Sadar'),(193,24,'Kathalia'),(194,24,'Nalchity'),(195,24,'Rajapur'),(196,25,'Jhenaidah Sadar'),(197,25,'Shailkupa'),(198,25,'Harinakundu'),(199,25,'Kaliganj'),(200,25,'Kotchandpur'),(201,25,'Moheshpur'),(202,26,'Akkelpur'),(203,26,'Kalai'),(204,26,'Khetlal'),(205,26,'Panchbibi'),(206,26,'Joypurhat Sadar'),(207,27,'Khagrachhari Sadar'),(208,27,'Dighinala'),(209,27,'Panchari'),(210,27,'Laxmichhari'),(211,27,'Mohalchari'),(212,27,'Manikchari'),(213,27,'Ramgarh'),(214,27,'Matiranga'),(215,27,'Guimara'),(216,28,'Paikgasa'),(217,28,'Fultola'),(218,28,'Digholia'),(219,28,'Rupsha'),(220,28,'Terokhada'),(221,28,'Dumuria'),(222,28,'Botiaghata'),(223,28,'Dakop'),(224,28,'Koyra'),(225,29,'Itna'),(226,29,'Katiadi'),(227,29,'Bhairab'),(228,29,'Tarail'),(229,29,'Hossainpur'),(230,29,'Pakundia'),(231,29,'Kuliarchar'),(232,29,'Kishoreganj Sadar'),(233,29,'Karimgonj'),(234,29,'Bajitpur'),(235,29,'Austagram'),(236,29,'Mithamoin'),(237,29,'Nikli'),(238,30,'Kurigram Sadar'),(239,30,'Nageshwari'),(240,30,'Bhurungamari'),(241,30,'Phulbari'),(242,30,'Rajarhat'),(243,30,'Ulipur'),(244,30,'Chilmari'),(245,30,'Rowmari'),(246,30,'Charrajibpur'),(247,31,'Kushtia Sadar'),(248,31,'Kumarkhali'),(249,31,'Khoksa'),(250,31,'Mirpur'),(251,31,'Daulatpur'),(252,31,'Bheramara'),(253,32,'Lakshmipur Sadar'),(254,32,'Kamalnagar'),(255,32,'Raipur'),(256,32,'Ramgati'),(257,32,'Ramganj'),(258,33,'Lalmonirhat Sadar'),(259,33,'Kaliganj'),(260,33,'Hatibandha'),(261,33,'Patgram'),(262,33,'Aditmari'),(263,34,'Madaripur Sadar'),(264,34,'Shibchar'),(265,34,'Kalkini'),(266,34,'Rajoir'),(267,34,'Dasar'),(268,35,'Shalikha'),(269,35,'Sreepur'),(270,35,'Magura Sadar'),(271,35,'Mohammadpur'),(272,36,'Harirampur'),(273,36,'Saturia'),(274,36,'Manikganj Sadar'),(275,36,'Gior'),(276,36,'Shibaloy'),(277,36,'Doulatpur'),(278,36,'Singiar'),(279,37,'Mujibnagar'),(280,37,'Meherpur Sadar'),(281,37,'Gangni'),(282,38,'Barlekha'),(283,38,'Kamolganj'),(284,38,'Kulaura'),(285,38,'Moulvibazar Sadar'),(286,38,'Rajnagar'),(287,38,'Sreemangal'),(288,38,'Juri'),(289,39,'Munshiganj Sadar'),(290,39,'Sreenagar'),(291,39,'Sirajdikhan'),(292,39,'Louhajanj'),(293,39,'Gajaria'),(294,39,'Tongibari'),(295,40,'Fulbaria'),(296,40,'Trishal'),(297,40,'Bhaluka'),(298,40,'Muktagacha'),(299,40,'Mymensingh Sadar'),(300,40,'Dhobaura'),(301,40,'Phulpur'),(302,40,'Haluaghat'),(303,40,'Gouripur'),(304,40,'Gafargaon'),(305,40,'Iswarganj'),(306,40,'Nandail'),(307,40,'Tarakanda'),(308,41,'Mohadevpur'),(309,41,'Badalgachi'),(310,41,'Patnitala'),(311,41,'Dhamoirhat'),(312,41,'Niamatpur'),(313,41,'Manda'),(314,41,'Atrai'),(315,41,'Raninagar'),(316,41,'Naogaon Sadar'),(317,41,'Porsha'),(318,41,'Sapahar'),(319,42,'Narail Sadar'),(320,42,'Lohagara'),(321,42,'Kalia'),(322,43,'Araihazar'),(323,43,'Bandar'),(324,43,'Narayanganj Sadar'),(325,43,'Rupganj'),(326,43,'Sonargaon'),(327,44,'Belabo'),(328,44,'Monohardi'),(329,44,'Narsingdi Sadar'),(330,44,'Palash'),(331,44,'Raipura'),(332,44,'Shibpur'),(333,45,'Natore Sadar'),(334,45,'Singra'),(335,45,'Baraigram'),(336,45,'Bagatipara'),(337,45,'Lalpur'),(338,45,'Gurudaspur'),(339,45,'Naldanga'),(340,46,'Barhatta'),(341,46,'Durgapur'),(342,46,'Kendua'),(343,46,'Atpara'),(344,46,'Madan'),(345,46,'Khaliajuri'),(346,46,'Kalmakanda'),(347,46,'Mohongonj'),(348,46,'Purbadhala'),(349,46,'Netrokona Sadar'),(350,47,'Syedpur'),(351,47,'Domar'),(352,47,'Dimla'),(353,47,'Jaldhaka'),(354,47,'Kishorganj'),(355,47,'Nilphamari Sadar'),(356,48,'Noakhali Sadar'),(357,48,'Companiganj'),(358,48,'Begumganj'),(359,48,'Hatia'),(360,48,'Subarnachar'),(361,48,'Kabirhat'),(362,48,'Senbug'),(363,48,'Chatkhil'),(364,48,'Sonaimori'),(365,49,'Sujanagar'),(366,49,'Ishurdi'),(367,49,'Bhangura'),(368,49,'Pabna Sadar'),(369,49,'Bera'),(370,49,'Atghoria'),(371,49,'Chatmohar'),(372,49,'Santhia'),(373,49,'Faridpur'),(374,50,'Panchagarh Sadar'),(375,50,'Debiganj'),(376,50,'Boda'),(377,50,'Atwari'),(378,50,'Tetulia'),(379,51,'Bauphal'),(380,51,'Patuakhali Sadar'),(381,51,'Dumki'),(382,51,'Dashmina'),(383,51,'Kalapara'),(384,51,'Mirzaganj'),(385,51,'Galachipa'),(386,51,'Rangabali'),(387,52,'Pirojpur Sadar'),(388,52,'Nazirpur'),(389,52,'Kawkhali'),(390,52,'Zianagar'),(391,52,'Bhandaria'),(392,52,'Mathbaria'),(393,52,'Nesarabad'),(394,53,'Rajbari Sadar'),(395,53,'Goalanda'),(396,53,'Pangsa'),(397,53,'Baliakandi'),(398,53,'Kalukhali'),(399,54,'Paba'),(400,54,'Durgapur'),(401,54,'Mohonpur'),(402,54,'Charghat'),(403,54,'Puthia'),(404,54,'Bagha'),(405,54,'Godagari'),(406,54,'Tanore'),(407,54,'Bagmara'),(408,55,'Rangamati Sadar'),(409,55,'Kaptai'),(410,55,'Kawkhali'),(411,55,'Baghaichari'),(412,55,'Barkal'),(413,55,'Langadu'),(414,55,'Rajasthali'),(415,55,'Belaichari'),(416,55,'Juraichari'),(417,55,'Naniarchar'),(418,56,'Rangpur Sadar'),(419,56,'Gangachara'),(420,56,'Taragonj'),(421,56,'Badargonj'),(422,56,'Mithapukur'),(423,56,'Pirgonj'),(424,56,'Kaunia'),(425,56,'Pirgacha'),(426,57,'Assasuni'),(427,57,'Debhata'),(428,57,'Kalaroa'),(429,57,'Satkhira Sadar'),(430,57,'Shyamnagar'),(431,57,'Tala'),(432,57,'Kaliganj'),(433,58,'Shariatpur Sadar'),(434,58,'Naria'),(435,58,'Zajira'),(436,58,'Gosairhat'),(437,58,'Bhedarganj'),(438,58,'Damudya'),(439,59,'Sherpur Sadar'),(440,59,'Nalitabari'),(441,59,'Sreebordi'),(442,59,'Nokla'),(443,59,'Jhenaigati'),(444,60,'Belkuchi'),(445,60,'Chauhali'),(446,60,'Kamarkhand'),(447,60,'Kazipur'),(448,60,'Raigonj'),(449,60,'Shahjadpur'),(450,60,'Sirajganj Sadar'),(451,60,'Tarash'),(452,60,'Ullapara'),(453,61,'Sunamganj Sadar'),(454,61,'South Sunamganj'),(455,61,'Bishwambarpur'),(456,61,'Chhatak'),(457,61,'Jagannathpur'),(458,61,'Dowarabazar'),(459,61,'Tahirpur'),(460,61,'Dharmapasha'),(461,61,'Jamalganj'),(462,61,'Shalla'),(463,61,'Derai'),(464,61,'Madhyanagar'),(465,62,'Balaganj'),(466,62,'Beanibazar'),(467,62,'Bishwanath'),(468,62,'Companiganj'),(469,62,'Fenchuganj'),(470,62,'Golapganj'),(471,62,'Gowainghat'),(472,62,'Jaintiapur'),(473,62,'Kanaighat'),(474,62,'Sylhet Sadar'),(475,62,'Zakiganj'),(476,62,'Dakshinsurma'),(477,62,'Osmaninagar'),(478,63,'Basail'),(479,63,'Bhuapur'),(480,63,'Delduar'),(481,63,'Ghatail'),(482,63,'Gopalpur'),(483,63,'Madhupur'),(484,63,'Mirzapur'),(485,63,'Nagarpur'),(486,63,'Sakhipur'),(487,63,'Tangail Sadar'),(488,63,'Kalihati'),(489,63,'Dhanbari'),(490,64,'Thakurgaon Sadar'),(491,64,'Pirganj'),(492,64,'Ranisankail'),(493,64,'Haripur'),(494,64,'Baliadangi');
/*!40000 ALTER TABLE `thanas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Sumon aHmeD','bdsumon4u@gmail.com',NULL,'$2y$12$YtUBqa5lsTJ8FTT37JfrquHh0gNcji/eFByakl7m0FmBl/YWeG81K',NULL,'2024-01-04 15:23:08','2024-01-04 15:23:08'),(2,'Alex Harison','alexharisont20@gmail.com',NULL,'$2y$12$VsKrneSIJrhT9PRZ9cJCV.P9PhIrc27umesEGsiJuyEmfHcY61qoe',NULL,'2024-01-05 14:37:54','2024-01-07 12:47:01');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-01-13 21:35:57
