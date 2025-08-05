/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19-11.8.2-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: devasports
-- ------------------------------------------------------
-- Server version	11.8.2-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*M!100616 SET @OLD_NOTE_VERBOSITY=@@NOTE_VERBOSITY, NOTE_VERBOSITY=0 */;

--
-- Table structure for table `app_brand`
--

DROP TABLE IF EXISTS `app_brand`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `app_brand` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_brand`
--

LOCK TABLES `app_brand` WRITE;
/*!40000 ALTER TABLE `app_brand` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `app_brand` VALUES
(2,'Adidas'),
(5,'Apex'),
(4,'Bata'),
(1,'Nike'),
(3,'Puma');
/*!40000 ALTER TABLE `app_brand` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `app_cart`
--

DROP TABLE IF EXISTS `app_cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `app_cart` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `session_key` varchar(40) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_cart`
--

LOCK TABLES `app_cart` WRITE;
/*!40000 ALTER TABLE `app_cart` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `app_cart` VALUES
(1,'hpe569q8tn5wf1x047b346b4z6v0ufd5','2025-07-15 22:11:19.437585'),
(2,'y0xozgznh2af4b9l839gcennxby44wl8','2025-07-15 22:23:00.956475'),
(3,'if1v1l105s48y05f205d1o6qj7w6vxpa','2025-07-19 18:13:43.425034'),
(4,'dtmmb42guwsc3aipb88tqg50udrg6706','2025-07-20 15:28:08.081913'),
(5,'xejqu5z20d2t41v4yydyn0msbb1ykh2o','2025-07-21 16:10:41.665628'),
(6,'sxfvhz34r91an7pmjo54e526r16v5fg8','2025-07-22 18:02:25.990283');
/*!40000 ALTER TABLE `app_cart` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `app_cartitem`
--

DROP TABLE IF EXISTS `app_cartitem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `app_cartitem` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `quantity` int(10) unsigned NOT NULL CHECK (`quantity` >= 0),
  `cart_id` bigint(20) NOT NULL,
  `product_variant_id` bigint(20) NOT NULL,
  `size_id` bigint(20) NOT NULL,
  `color_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `app_cartitem_cart_id_ed211dc5_fk_app_cart_id` (`cart_id`),
  KEY `app_cartitem_product_variant_id_afe941e2_fk_app_produ` (`product_variant_id`),
  KEY `app_cartitem_size_id_148dfd00_fk_app_size_id` (`size_id`),
  KEY `app_cartitem_color_id_62ed450b_fk_app_color_id` (`color_id`),
  CONSTRAINT `app_cartitem_cart_id_ed211dc5_fk_app_cart_id` FOREIGN KEY (`cart_id`) REFERENCES `app_cart` (`id`),
  CONSTRAINT `app_cartitem_color_id_62ed450b_fk_app_color_id` FOREIGN KEY (`color_id`) REFERENCES `app_color` (`id`),
  CONSTRAINT `app_cartitem_product_variant_id_afe941e2_fk_app_produ` FOREIGN KEY (`product_variant_id`) REFERENCES `app_productvariant` (`id`),
  CONSTRAINT `app_cartitem_size_id_148dfd00_fk_app_size_id` FOREIGN KEY (`size_id`) REFERENCES `app_size` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_cartitem`
--

LOCK TABLES `app_cartitem` WRITE;
/*!40000 ALTER TABLE `app_cartitem` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `app_cartitem` VALUES
(2,1,2,1,1,1),
(3,1,2,2,1,1),
(15,1,1,2,1,1),
(16,1,1,3,1,1),
(17,1,3,1,1,1),
(21,1,6,2,1,1);
/*!40000 ALTER TABLE `app_cartitem` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `app_category`
--

DROP TABLE IF EXISTS `app_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `app_category` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_category`
--

LOCK TABLES `app_category` WRITE;
/*!40000 ALTER TABLE `app_category` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `app_category` VALUES
(2,'Jackets'),
(5,'Shoes'),
(3,'Shorts'),
(4,'Sleeveless'),
(1,'T-Shirts');
/*!40000 ALTER TABLE `app_category` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `app_color`
--

DROP TABLE IF EXISTS `app_color`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `app_color` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_color`
--

LOCK TABLES `app_color` WRITE;
/*!40000 ALTER TABLE `app_color` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `app_color` VALUES
(2,'Blue'),
(3,'Green'),
(1,'Red'),
(4,'White');
/*!40000 ALTER TABLE `app_color` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `app_product`
--

DROP TABLE IF EXISTS `app_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `app_product` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  `description` longtext NOT NULL,
  `category_id` bigint(20) NOT NULL,
  `brand_id` bigint(20) NOT NULL,
  `base_price` decimal(10,2) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `app_product_category_id_023742a5_fk_app_category_id` (`category_id`),
  KEY `app_product_brand_id_23d83d7f_fk_app_brand_id` (`brand_id`),
  CONSTRAINT `app_product_brand_id_23d83d7f_fk_app_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `app_brand` (`id`),
  CONSTRAINT `app_product_category_id_023742a5_fk_app_category_id` FOREIGN KEY (`category_id`) REFERENCES `app_category` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_product`
--

LOCK TABLES `app_product` WRITE;
/*!40000 ALTER TABLE `app_product` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `app_product` VALUES
(1,'Adidas Cotton T-Shirt','Aaadias is best',1,2,200.00,1),
(2,'NikeCotton Jackets','Nike jackets are best f',2,1,200.00,1),
(3,'Court Shatter Low Sneakers','Court Shatter Low Sneakers',5,3,969.00,1);
/*!40000 ALTER TABLE `app_product` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `app_productvariant`
--

DROP TABLE IF EXISTS `app_productvariant`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `app_productvariant` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `color_id` bigint(20) NOT NULL,
  `product_id` bigint(20) NOT NULL,
  `sku` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `sku` (`sku`),
  KEY `app_productvariant_product_id_70fb12a4` (`product_id`),
  KEY `app_productvariant_color_id_c7d6e961` (`color_id`),
  CONSTRAINT `app_productvariant_color_id_c7d6e961_fk_app_color_id` FOREIGN KEY (`color_id`) REFERENCES `app_color` (`id`),
  CONSTRAINT `app_productvariant_product_id_70fb12a4_fk_app_product_id` FOREIGN KEY (`product_id`) REFERENCES `app_product` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_productvariant`
--

LOCK TABLES `app_productvariant` WRITE;
/*!40000 ALTER TABLE `app_productvariant` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `app_productvariant` VALUES
(1,1,1,'20'),
(2,3,1,'10'),
(3,4,2,'5'),
(4,4,3,'2');
/*!40000 ALTER TABLE `app_productvariant` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `app_productvariantimage`
--

DROP TABLE IF EXISTS `app_productvariantimage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `app_productvariantimage` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `image1` varchar(100) DEFAULT NULL,
  `image2` varchar(100) DEFAULT NULL,
  `image3` varchar(100) DEFAULT NULL,
  `image4` varchar(100) DEFAULT NULL,
  `variant_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `variant_id` (`variant_id`),
  CONSTRAINT `app_productvariantim_variant_id_f1c844d5_fk_app_produ` FOREIGN KEY (`variant_id`) REFERENCES `app_productvariant` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_productvariantimage`
--

LOCK TABLES `app_productvariantimage` WRITE;
/*!40000 ALTER TABLE `app_productvariantimage` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `app_productvariantimage` VALUES
(1,'product_images/Addidas1.webp','product_images/Addidas2.webp','product_images/Addidas3.webp','product_images/Addidas4webp.webp',1),
(2,'product_images/Addidas1_green.webp','product_images/Addidas2_green.webp','product_images/Addidas3_green.webp','product_images/Addidas4_green.webp',2),
(4,'product_images/Nike_Jacket.webp','product_images/Nike_Jacket2.webp','product_images/Nike_Jacket3.webp','product_images/Nike_Jacket4webp.jpeg',3),
(5,'product_images/pumma.jpg','product_images/pumma2.jpg','product_images/pumma23jpg.jpg','product_images/pumma4pg.jpg',4);
/*!40000 ALTER TABLE `app_productvariantimage` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `app_productvariantsize`
--

DROP TABLE IF EXISTS `app_productvariantsize`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `app_productvariantsize` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `price` decimal(10,2) NOT NULL,
  `stock` int(10) unsigned NOT NULL CHECK (`stock` >= 0),
  `size_id` bigint(20) NOT NULL,
  `variant_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `app_productvariantsize_variant_id_size_id_0c3b8bf9_uniq` (`variant_id`,`size_id`),
  KEY `app_productvariantsize_size_id_b53d7af2_fk_app_size_id` (`size_id`),
  CONSTRAINT `app_productvariantsi_variant_id_11d7da3e_fk_app_produ` FOREIGN KEY (`variant_id`) REFERENCES `app_productvariant` (`id`),
  CONSTRAINT `app_productvariantsize_size_id_b53d7af2_fk_app_size_id` FOREIGN KEY (`size_id`) REFERENCES `app_size` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_productvariantsize`
--

LOCK TABLES `app_productvariantsize` WRITE;
/*!40000 ALTER TABLE `app_productvariantsize` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `app_productvariantsize` VALUES
(1,500.00,4,1,1),
(2,800.00,6,4,1),
(3,999.00,2,5,1),
(4,200.00,1,3,2),
(5,400.00,5,1,2),
(6,600.00,4,4,2),
(7,200.00,2,1,3),
(8,300.00,4,3,3),
(9,400.00,6,4,3),
(10,699.00,4,6,4),
(11,799.00,3,7,4),
(12,849.00,2,8,4);
/*!40000 ALTER TABLE `app_productvariantsize` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `app_size`
--

DROP TABLE IF EXISTS `app_size`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `app_size` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `size_label` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `size_label` (`size_label`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_size`
--

LOCK TABLES `app_size` WRITE;
/*!40000 ALTER TABLE `app_size` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `app_size` VALUES
(9,'10'),
(6,'7'),
(7,'8'),
(8,'9'),
(1,'L'),
(3,'M'),
(2,'X'),
(4,'Xl'),
(5,'XXL');
/*!40000 ALTER TABLE `app_size` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=69 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `auth_permission` VALUES
(1,'Can add log entry',1,'add_logentry'),
(2,'Can change log entry',1,'change_logentry'),
(3,'Can delete log entry',1,'delete_logentry'),
(4,'Can view log entry',1,'view_logentry'),
(5,'Can add permission',2,'add_permission'),
(6,'Can change permission',2,'change_permission'),
(7,'Can delete permission',2,'delete_permission'),
(8,'Can view permission',2,'view_permission'),
(9,'Can add group',3,'add_group'),
(10,'Can change group',3,'change_group'),
(11,'Can delete group',3,'delete_group'),
(12,'Can view group',3,'view_group'),
(13,'Can add user',4,'add_user'),
(14,'Can change user',4,'change_user'),
(15,'Can delete user',4,'delete_user'),
(16,'Can view user',4,'view_user'),
(17,'Can add content type',5,'add_contenttype'),
(18,'Can change content type',5,'change_contenttype'),
(19,'Can delete content type',5,'delete_contenttype'),
(20,'Can view content type',5,'view_contenttype'),
(21,'Can add session',6,'add_session'),
(22,'Can change session',6,'change_session'),
(23,'Can delete session',6,'delete_session'),
(24,'Can view session',6,'view_session'),
(25,'Can add product',7,'add_product'),
(26,'Can change product',7,'change_product'),
(27,'Can delete product',7,'delete_product'),
(28,'Can view product',7,'view_product'),
(29,'Can add product variant',8,'add_productvariant'),
(30,'Can change product variant',8,'change_productvariant'),
(31,'Can delete product variant',8,'delete_productvariant'),
(32,'Can view product variant',8,'view_productvariant'),
(33,'Can add category',9,'add_category'),
(34,'Can change category',9,'change_category'),
(35,'Can delete category',9,'delete_category'),
(36,'Can view category',9,'view_category'),
(37,'Can add brand',10,'add_brand'),
(38,'Can change brand',10,'change_brand'),
(39,'Can delete brand',10,'delete_brand'),
(40,'Can view brand',10,'view_brand'),
(41,'Can add product variant image',11,'add_productvariantimage'),
(42,'Can change product variant image',11,'change_productvariantimage'),
(43,'Can delete product variant image',11,'delete_productvariantimage'),
(44,'Can view product variant image',11,'view_productvariantimage'),
(45,'Can add color',12,'add_color'),
(46,'Can change color',12,'change_color'),
(47,'Can delete color',12,'delete_color'),
(48,'Can view color',12,'view_color'),
(49,'Can add size',13,'add_size'),
(50,'Can change size',13,'change_size'),
(51,'Can delete size',13,'delete_size'),
(52,'Can view size',13,'view_size'),
(53,'Can add product variant size',14,'add_productvariantsize'),
(54,'Can change product variant size',14,'change_productvariantsize'),
(55,'Can delete product variant size',14,'delete_productvariantsize'),
(56,'Can view product variant size',14,'view_productvariantsize'),
(57,'Can add cart',15,'add_cart'),
(58,'Can change cart',15,'change_cart'),
(59,'Can delete cart',15,'delete_cart'),
(60,'Can view cart',15,'view_cart'),
(61,'Can add cart item',16,'add_cartitem'),
(62,'Can change cart item',16,'change_cartitem'),
(63,'Can delete cart item',16,'delete_cartitem'),
(64,'Can view cart item',16,'view_cartitem'),
(65,'Can add custom user',17,'add_customuser'),
(66,'Can change custom user',17,'change_customuser'),
(67,'Can delete custom user',17,'delete_customuser'),
(68,'Can view custom user',17,'view_customuser');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `auth_user` VALUES
(1,'pbkdf2_sha256$1000000$gxYZxoWlBokxXkFo0yxYf5$KLprYXe97Svo5BB21T0MyZLtSqYDZlNSJ05cufofqhs=','2025-07-07 17:00:41.950292',1,'Bhagyesh','','','bhagyesh@gmail.com',1,1,'2025-07-07 17:00:11.286668'),
(2,'pbkdf2_sha256$1000000$YLs4QcuF82Z7FZXNyDFm6M$RH6LP+zat1lxOqgIoMqPAaCbkvFkPJvnP9OflmzNVXo=','2025-07-19 18:54:15.707199',1,'DevaSporst','','','bhagyesh@gmail.com',1,1,'2025-07-19 18:53:24.454304'),
(3,'pbkdf2_sha256$1000000$lkHHk1s0vIPCGWmv9vaRlA$cCKMf2CPhvLnPTOnU2v5EDIX4zXBHJAZJmFIJS9faGc=','2025-07-21 15:38:59.694050',1,'DevaSports','','','deva@gmail.com',1,1,'2025-07-21 15:38:41.184843');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_groups` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext DEFAULT NULL,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL CHECK (`action_flag` >= 0),
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `django_admin_log` VALUES
(1,'2025-07-07 17:32:36.420774','1','Nike',1,'[{\"added\": {}}]',10,1),
(2,'2025-07-07 17:32:44.710080','2','Adidas',1,'[{\"added\": {}}]',10,1),
(3,'2025-07-07 17:32:52.649983','3','Puma',1,'[{\"added\": {}}]',10,1),
(4,'2025-07-07 17:33:02.482901','4','Bata',1,'[{\"added\": {}}]',10,1),
(5,'2025-07-07 17:33:11.447800','5','Apex',1,'[{\"added\": {}}]',10,1),
(6,'2025-07-07 17:33:28.216915','1','T-Shirts',1,'[{\"added\": {}}]',9,1),
(7,'2025-07-07 17:33:33.964268','2','Jackets',1,'[{\"added\": {}}]',9,1),
(8,'2025-07-07 17:33:40.680289','3','Shorts',1,'[{\"added\": {}}]',9,1),
(9,'2025-07-07 17:33:48.405481','4','Sleeveless',1,'[{\"added\": {}}]',9,1),
(10,'2025-07-07 17:33:54.823264','1','Red',1,'[{\"added\": {}}]',12,1),
(11,'2025-07-07 17:34:00.563276','2','Blue',1,'[{\"added\": {}}]',12,1),
(12,'2025-07-07 17:34:05.231591','3','Green',1,'[{\"added\": {}}]',12,1),
(13,'2025-07-07 17:34:19.079230','4','Yellow',1,'[{\"added\": {}}]',12,1),
(14,'2025-07-07 17:35:22.010183','1','L',1,'[{\"added\": {}}]',13,1),
(15,'2025-07-07 17:35:27.226596','2','X',1,'[{\"added\": {}}]',13,1),
(16,'2025-07-07 17:35:32.300469','3','M',1,'[{\"added\": {}}]',13,1),
(17,'2025-07-07 17:35:36.081572','4','Xl',1,'[{\"added\": {}}]',13,1),
(18,'2025-07-07 17:35:41.408965','5','XXL',1,'[{\"added\": {}}]',13,1),
(19,'2025-07-07 17:36:25.093101','1','Adidas Cotton T-Shirt (Adidas) - T-Shirts',1,'[{\"added\": {}}]',7,1),
(20,'2025-07-07 17:37:11.867696','1','Adidas Cotton T-Shirt - Red',1,'[{\"added\": {}}, {\"added\": {\"name\": \"product variant size\", \"object\": \"Adidas Cotton T-Shirt - Red - L\"}}, {\"added\": {\"name\": \"product variant size\", \"object\": \"Adidas Cotton T-Shirt - Red - Xl\"}}, {\"added\": {\"name\": \"product variant size\", \"object\": \"Adidas Cotton T-Shirt - Red - XXL\"}}]',8,1),
(21,'2025-07-07 17:37:53.924835','2','Adidas Cotton T-Shirt - Green',1,'[{\"added\": {}}, {\"added\": {\"name\": \"product variant size\", \"object\": \"Adidas Cotton T-Shirt - Green - M\"}}, {\"added\": {\"name\": \"product variant size\", \"object\": \"Adidas Cotton T-Shirt - Green - L\"}}, {\"added\": {\"name\": \"product variant size\", \"object\": \"Adidas Cotton T-Shirt - Green - Xl\"}}]',8,1),
(22,'2025-07-07 17:38:21.166832','1','Images for Adidas Cotton T-Shirt - Red',1,'[{\"added\": {}}]',11,1),
(23,'2025-07-07 17:38:41.840741','2','Images for Adidas Cotton T-Shirt - Green',1,'[{\"added\": {}}]',11,1),
(24,'2025-07-07 17:48:27.370767','2','NikeCotton T-Shirt (Nike) - Jackets',1,'[{\"added\": {}}]',7,1),
(25,'2025-07-07 17:49:10.391062','3','NikeCotton T-Shirt - Yellow',1,'[{\"added\": {}}, {\"added\": {\"name\": \"product variant size\", \"object\": \"NikeCotton T-Shirt - Yellow - L\"}}, {\"added\": {\"name\": \"product variant size\", \"object\": \"NikeCotton T-Shirt - Yellow - M\"}}, {\"added\": {\"name\": \"product variant size\", \"object\": \"NikeCotton T-Shirt - Yellow - Xl\"}}]',8,1),
(26,'2025-07-07 17:50:00.897067','3','Images for NikeCotton T-Shirt - Yellow',1,'[{\"added\": {}}]',11,1),
(27,'2025-07-07 17:51:13.177340','3','Images for NikeCotton T-Shirt - Yellow',3,'',11,1),
(28,'2025-07-07 17:52:13.545994','4','Images for NikeCotton T-Shirt - Yellow',1,'[{\"added\": {}}]',11,1),
(29,'2025-07-21 15:41:18.256602','2','NikeCotton Jackets (Nike) - Jackets',2,'[{\"changed\": {\"fields\": [\"Name\"]}}]',7,3),
(30,'2025-07-21 15:41:40.163143','4','Images for NikeCotton Jackets - Yellow',2,'[{\"changed\": {\"fields\": [\"Image1\"]}}]',11,3),
(31,'2025-07-21 15:43:25.221086','4','Images for NikeCotton Jackets - Yellow',2,'[{\"changed\": {\"fields\": [\"Image2\", \"Image3\"]}}]',11,3),
(32,'2025-07-21 15:44:32.813226','4','Images for NikeCotton Jackets - Yellow',2,'[{\"changed\": {\"fields\": [\"Image4\"]}}]',11,3),
(33,'2025-07-21 15:45:12.565335','4','White',2,'[{\"changed\": {\"fields\": [\"Name\"]}}]',12,3),
(34,'2025-07-21 15:47:51.645602','1','Images for Adidas Cotton T-Shirt - Red',2,'[{\"changed\": {\"fields\": [\"Image1\", \"Image2\", \"Image3\", \"Image4\"]}}]',11,3),
(35,'2025-07-21 15:49:56.920864','2','Images for Adidas Cotton T-Shirt - Green',2,'[{\"changed\": {\"fields\": [\"Image1\", \"Image2\", \"Image3\"]}}]',11,3),
(36,'2025-07-21 15:51:19.378171','2','Images for Adidas Cotton T-Shirt - Green',2,'[{\"changed\": {\"fields\": [\"Image4\"]}}]',11,3),
(37,'2025-07-21 15:54:58.713996','6','Pu',1,'[{\"added\": {}}]',10,3),
(38,'2025-07-21 15:55:22.198645','5','Shoes',1,'[{\"added\": {}}]',9,3),
(39,'2025-07-21 15:55:50.691430','3','Court Shatter Low Sneakers (Puma) - Shoes',1,'[{\"added\": {}}]',7,3),
(40,'2025-07-21 15:56:22.583622','6','7',1,'[{\"added\": {}}]',13,3),
(41,'2025-07-21 15:56:25.321566','7','8',1,'[{\"added\": {}}]',13,3),
(42,'2025-07-21 15:56:27.952150','8','9',1,'[{\"added\": {}}]',13,3),
(43,'2025-07-21 15:56:31.072916','9','10',1,'[{\"added\": {}}]',13,3),
(44,'2025-07-21 15:57:42.445599','4','Court Shatter Low Sneakers - White',1,'[{\"added\": {}}, {\"added\": {\"name\": \"product variant size\", \"object\": \"Court Shatter Low Sneakers - White - 7\"}}, {\"added\": {\"name\": \"product variant size\", \"object\": \"Court Shatter Low Sneakers - White - 8\"}}, {\"added\": {\"name\": \"product variant size\", \"object\": \"Court Shatter Low Sneakers - White - 9\"}}]',8,3),
(45,'2025-07-21 16:04:05.972028','5','Images for Court Shatter Low Sneakers - White',1,'[{\"added\": {}}]',11,3),
(46,'2025-07-23 00:26:01.571502','6','Pu',3,'',10,3);
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `django_content_type` VALUES
(1,'admin','logentry'),
(10,'app','brand'),
(15,'app','cart'),
(16,'app','cartitem'),
(9,'app','category'),
(12,'app','color'),
(17,'app','customuser'),
(7,'app','product'),
(8,'app','productvariant'),
(11,'app','productvariantimage'),
(14,'app','productvariantsize'),
(13,'app','size'),
(3,'auth','group'),
(2,'auth','permission'),
(4,'auth','user'),
(5,'contenttypes','contenttype'),
(6,'sessions','session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `django_migrations` VALUES
(1,'contenttypes','0001_initial','2025-07-07 16:58:31.387597'),
(2,'auth','0001_initial','2025-07-07 16:58:31.686495'),
(3,'admin','0001_initial','2025-07-07 16:58:31.773448'),
(4,'admin','0002_logentry_remove_auto_add','2025-07-07 16:58:31.789512'),
(5,'admin','0003_logentry_add_action_flag_choices','2025-07-07 16:58:31.797514'),
(6,'app','0001_initial','2025-07-07 16:58:31.895165'),
(7,'app','0002_category_product_category','2025-07-07 16:58:31.965759'),
(8,'app','0003_brand_product_brand','2025-07-07 16:58:32.033644'),
(9,'app','0004_alter_productvariant_unique_together_and_more','2025-07-07 16:58:32.122239'),
(10,'app','0005_alter_productvariant_unique_together_and_more','2025-07-07 16:58:32.577850'),
(11,'app','0006_color_size_productvariant_sku_and_more','2025-07-07 16:58:32.843780'),
(12,'app','0007_alter_productvariant_sku','2025-07-07 16:58:32.996425'),
(13,'app','0008_alter_productvariant_sku','2025-07-07 16:58:33.082163'),
(14,'app','0009_alter_productvariant_color_alter_productvariant_size_and_more','2025-07-07 16:58:33.767232'),
(15,'contenttypes','0002_remove_content_type_name','2025-07-07 16:58:33.820805'),
(16,'auth','0002_alter_permission_name_max_length','2025-07-07 16:58:33.853667'),
(17,'auth','0003_alter_user_email_max_length','2025-07-07 16:58:33.871601'),
(18,'auth','0004_alter_user_username_opts','2025-07-07 16:58:33.875909'),
(19,'auth','0005_alter_user_last_login_null','2025-07-07 16:58:33.908235'),
(20,'auth','0006_require_contenttypes_0002','2025-07-07 16:58:33.909893'),
(21,'auth','0007_alter_validators_add_error_messages','2025-07-07 16:58:33.915254'),
(22,'auth','0008_alter_user_username_max_length','2025-07-07 16:58:33.931316'),
(23,'auth','0009_alter_user_last_name_max_length','2025-07-07 16:58:33.949747'),
(24,'auth','0010_alter_group_name_max_length','2025-07-07 16:58:33.964989'),
(25,'auth','0011_update_proxy_permissions','2025-07-07 16:58:33.972517'),
(26,'auth','0012_alter_user_first_name_max_length','2025-07-07 16:58:33.986070'),
(27,'sessions','0001_initial','2025-07-07 16:58:34.012193'),
(28,'app','0010_color_size_product_base_price_product_is_active_and_more','2025-07-07 17:04:09.896895'),
(29,'app','0011_remove_productvariant_price_and_more','2025-07-07 17:29:19.296977'),
(30,'app','0012_cart_cartitem','2025-07-15 21:44:45.392602'),
(31,'app','0013_customuser','2025-07-20 16:03:23.250995'),
(32,'app','0014_customuser_first_name_alter_customuser_is_superuser','2025-07-20 16:03:23.323316'),
(33,'app','0015_delete_customuser','2025-07-20 16:03:23.384360'),
(34,'app','0016_cartitem_size','2025-07-22 17:45:12.778797'),
(35,'app','0017_cartitem_color','2025-07-23 00:00:31.805171'),
(36,'app','0018_customuser','2025-07-24 16:11:15.328951'),
(37,'app','0019_delete_customuser','2025-07-24 16:11:15.374041'),
(38,'app','0020_customuser','2025-07-24 16:12:25.801914'),
(39,'app','0021_delete_customuser','2025-07-24 16:12:31.246062');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `django_session` VALUES
('1edjpxnlcqsg8tfj2n2ah7kojpi4yre4','.eJxVjDsOwjAQBe_iGln2xr-lpOcM1vqHA8iW4qRC3B0ipYD2zcx7MU_bWv028uLnxM4M2Ol3CxQfue0g3andOo-9rcsc-K7wgw5-7Sk_L4f7d1Bp1G_tsgoWtSkJjRSIiXRwtgCitJJsmDAiiuwgFGXyBA4K2EhCmqQK6Im9P9AkNzg:1udChL:1jk3VMyz6GbeItIOFqxJxOJ4x-cT67-szyQe95627Gg','2025-08-02 18:54:15.711626'),
('dtmmb42guwsc3aipb88tqg50udrg6706','e30:1udDCW:rHqoWbb48jJtSTZk21GCPsnNVeABHQAm4ZEoHKnE98A','2025-08-02 19:26:28.196579'),
('hpe569q8tn5wf1x047b346b4z6v0ufd5','.eJxVjMEOwiAQBf-FsyGwwAIevfsNBFiQqqFJaU_Gf9cmPej1zcx7sRC3tYVtlCVMxM5MstPvlmJ-lL4Dusd-m3me-7pMie8KP-jg15nK83K4fwctjvat0TpXazFSe9LWOFDJS-G9hGqKKkKiIrCaFDhEFJCdgRoxImZBXib2_gCvfDaX:1uYpCr:VYlSXbbaCZbGmnpV1TIhESYL-wj1pd1a-vaBFIRfy48','2025-07-21 17:00:41.952028'),
('sxfvhz34r91an7pmjo54e526r16v5fg8','e30:1ubowb:yk2SZQifjFnLy8Wg5Iigow7NHFnKHJMCLNbgrCl4dFk','2025-07-29 23:20:17.508932'),
('xejqu5z20d2t41v4yydyn0msbb1ykh2o','.eJxVjEEOwiAQRe_C2pChQ6F16d4zNMMMSNVAUtqV8e7apAvd_vfef6mJtjVPW4vLNIs6K1Sn3y0QP2LZgdyp3KrmWtZlDnpX9EGbvlaJz8vh_h1kavlbE3rpxYIPXW8GNg4sRGedJxDLjMZzGocQJCEYRrFoMGIC6Ui8Ga16fwDRiDeH:1udsbT:0_Ms0pq99W1o7KqcrsvJeRSl1TvhOBPhCFyRXg-xEaQ','2025-08-04 15:38:59.714430'),
('y0xozgznh2af4b9l839gcennxby44wl8','e30:1ubo2x:lt__dHD0LQnNX_pr8qJob8h6giooK05FpP_SothA7DY','2025-07-29 22:22:47.341173');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;
commit;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*M!100616 SET NOTE_VERBOSITY=@OLD_NOTE_VERBOSITY */;

-- Dump completed on 2025-07-24 21:44:51
