-- MySQL dump 10.13  Distrib 8.0.44, for Win64 (x86_64)
--
-- Host: switchback.proxy.rlwy.net    Database: railway
-- ------------------------------------------------------
-- Server version	9.4.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (1,'ไฟฟ้า','ปัญหาเกี่ยวกับระบบไฟฟ้า','2025-06-19 04:01:12'),(2,'ประปา','ปัญหาเกี่ยวกับระบบประปา','2025-06-19 04:01:12'),(3,'แอร์','ปัญหาเกี่ยวกับเครื่องปรับอากาศ','2025-06-19 04:01:12'),(4,'คอมพิวเตอร์','ปัญหาเกี่ยวกับอุปกรณ์คอมพิวเตอร์','2025-06-19 04:01:12'),(5,'อื่นๆ','ปัญหาอื่นๆ','2025-06-19 04:01:12');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `completion_images`
--

DROP TABLE IF EXISTS `completion_images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `completion_images` (
  `id` int NOT NULL AUTO_INCREMENT,
  `repair_request_id` int NOT NULL,
  `file_path` varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL,
  `file_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `file_size` int DEFAULT '0',
  `uploaded_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `repair_request_id` (`repair_request_id`),
  CONSTRAINT `completion_images_ibfk_1` FOREIGN KEY (`repair_request_id`) REFERENCES `repair_requests` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `completion_images`
--

LOCK TABLES `completion_images` WRITE;
/*!40000 ALTER TABLE `completion_images` DISABLE KEYS */;
INSERT INTO `completion_images` VALUES (1,12,'http://localhost:5000/uploads/completion-images/completion-1756459822771-95903504.jpg','free-nature-images.jpg',200951,'2025-08-29 09:30:22'),(2,13,'http://localhost:5000/uploads/completion-images/completion-1756460177885-42920656.jpg','ai-generated-picture-of-a-tiger-walking-in-the-forest-photo.jpg',13348,'2025-08-29 09:36:17');
/*!40000 ALTER TABLE `completion_images` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `repair_images`
--

DROP TABLE IF EXISTS `repair_images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `repair_images` (
  `id` int NOT NULL AUTO_INCREMENT,
  `repair_request_id` int NOT NULL,
  `file_path` varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL,
  `file_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `file_size` int NOT NULL,
  `uploaded_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_repair_request_id` (`repair_request_id`),
  CONSTRAINT `repair_images_ibfk_1` FOREIGN KEY (`repair_request_id`) REFERENCES `repair_requests` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='ตารางเก็บรูปภาพหลายรูปสำหรับการแจ้งซ่อมแต่ละรายการ';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `repair_images`
--

LOCK TABLES `repair_images` WRITE;
/*!40000 ALTER TABLE `repair_images` DISABLE KEYS */;
INSERT INTO `repair_images` VALUES (1,1,'uploads/repair-images/repair-1752735802054-727149495.PNG','Capture.PNG',203081,'2025-07-17 07:03:22'),(2,2,'uploads/repair-images/repair-1752737140162-237246520.jpg','ai-generated-picture-of-a-tiger-walking-in-the-forest-photo.jpg',13348,'2025-07-17 07:25:40'),(3,3,'uploads/repair-images/repair-1752808587291-513070188.png','13971546034058.png',532353,'2025-07-18 03:16:27'),(6,6,'uploads/repair-images/repair-1755582327139-27316032.jpg','free-nature-images.jpg',200951,'2025-08-19 05:45:27'),(7,7,'http://localhost:3000/uploads/repair-images/repair-1756445067746-948356918.jpg','bird-8788491_1280.jpg',168056,'2025-08-29 05:24:27'),(8,8,'uploads/repair-images/repair-1756445168260-935631468.jpg','ai-generated-picture-of-a-tiger-walking-in-the-forest-photo.jpg',13348,'2025-08-29 05:26:08'),(15,12,'http://localhost:5000/uploads/repair-images/repair-1756457314648-282056090.jpg','ai-generated-picture-of-a-tiger-walking-in-the-forest-photo.jpg',13348,'2025-08-29 08:48:34'),(16,13,'http://localhost:5000/uploads/repair-images/repair-1756460163402-947953020.jpg','bird-8788491_1280.jpg',168056,'2025-08-29 09:36:03'),(18,14,'uploads/repair-images/repair-1771169552843-218181632.png','Screenshot 2024-08-13 224722.png',425803,'2026-02-15 15:32:34');
/*!40000 ALTER TABLE `repair_images` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `repair_requests`
--

DROP TABLE IF EXISTS `repair_requests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `repair_requests` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `category_id` int DEFAULT NULL,
  `location` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `building_id` int DEFAULT NULL,
  `room_id` int DEFAULT NULL,
  `priority` enum('low','medium','high','urgent') COLLATE utf8mb4_unicode_ci DEFAULT 'medium',
  `status` enum('pending','assigned','in_progress','completed','cancelled') COLLATE utf8mb4_unicode_ci DEFAULT 'pending',
  `completion_details` text COLLATE utf8mb4_unicode_ci,
  `requester_id` int NOT NULL,
  `assigned_to` int DEFAULT NULL,
  `image_path` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `completed_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `category_id` (`category_id`),
  KEY `requester_id` (`requester_id`),
  KEY `assigned_to` (`assigned_to`),
  KEY `idx_status` (`status`),
  KEY `idx_priority` (`priority`),
  KEY `idx_created_at` (`created_at`),
  KEY `idx_building_id` (`building_id`),
  KEY `idx_room_id` (`room_id`),
  CONSTRAINT `repair_requests_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`),
  CONSTRAINT `repair_requests_ibfk_2` FOREIGN KEY (`requester_id`) REFERENCES `users` (`id`),
  CONSTRAINT `repair_requests_ibfk_3` FOREIGN KEY (`assigned_to`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `repair_requests`
--

LOCK TABLES `repair_requests` WRITE;
/*!40000 ALTER TABLE `repair_requests` DISABLE KEYS */;
INSERT INTO `repair_requests` VALUES (1,'ไฟไหม้','ไฟไหม้ ห้องดำไปหมดเลย',1,'อาคาร 5 ชั้น 2 ปฏิบัติการกลางเทคโนโลยีเภสัชกรรม',NULL,NULL,'medium','assigned','',1,2,NULL,'2025-07-17 07:03:22','2025-07-18 09:21:56',NULL),(2,'เสือหลุด','เสือหลุดออกมาจกกรง',5,'อาคาร 2 ชั้น 2 เครื่องมือกลาง',NULL,NULL,'high','in_progress','',3,2,NULL,'2025-07-17 07:25:40','2025-07-18 09:19:10',NULL),(3,'ไฟไหม้','ไฟไหม้ ห้องวายวอดด',1,'อาคาร 1 ชั้น 3 เฟื่องฟ้า',NULL,NULL,'high','pending','',1,NULL,NULL,'2025-07-18 03:16:27','2025-07-18 09:20:46',NULL),(4,'น้ำท่วม','น้ำท่วงแทงค์',2,'อาคาร 1 ชั้น 3 ห้องเฟื่องฟ้า 3',NULL,NULL,'urgent','pending',NULL,1,NULL,NULL,'2025-07-21 04:14:32','2025-07-21 04:35:29',NULL),(6,'test123','test data 1234',4,'อาคาร 7 ชั้น 1 ห้องฏิบัติการยาฉีด',NULL,NULL,'urgent','pending',NULL,1,NULL,NULL,'2025-08-19 05:45:27','2025-08-19 05:45:27',NULL),(7,'test file path image','test Path image database นะจ๊ะ',5,'อาคาร 2 ชั้น 3 ห้องบรรยายผักหวาน (308)',NULL,NULL,'medium','pending',NULL,1,NULL,NULL,'2025-08-29 05:24:27','2025-08-29 05:24:27',NULL),(8,'tester path image อีกอัน','ลองtest อันเก่า',5,'อาคาร 12 ชั้น 1 ห้อง12 อาคารใหม่',NULL,NULL,'medium','pending',NULL,1,NULL,NULL,'2025-08-29 05:26:08','2025-08-29 05:26:08',NULL),(9,'เำพเพะ้ะั่ัีา','ดำพ้ะ่ัีาีำำแำแำพ้ั',4,'อาคาร 9 ชั้น 1 หอพระด้านหน้า',NULL,NULL,'medium','pending',NULL,1,NULL,NULL,'2025-08-29 05:26:48','2025-08-29 05:26:48',NULL),(10,'feeefefefefefe','fwefwfewfwfwfe',2,'อาคาร 6 ชั้น 1 ห้องพักอาจารย์ 7',NULL,NULL,'high','pending',NULL,1,NULL,NULL,'2025-08-29 05:30:52','2025-08-29 05:30:52',NULL),(11,'fweguuykbtfrv','wfefergrthr',5,'ภายนอกอาคาร: fwgregrtjhtjy',NULL,NULL,'medium','pending',NULL,1,NULL,NULL,'2025-08-29 05:54:35','2025-08-29 05:54:35',NULL),(12,'ddddddddddd','weeeeeeeeeeeeeeeeeeeeeeeeeeeee',4,'อาคาร 7 ชั้น 1 ห้องฏิบัติการยาฉีด',NULL,NULL,'medium','assigned','oooooooooooooooooooooooooooooo',1,2,NULL,'2025-08-29 06:21:15','2025-08-29 09:35:38','2025-08-29 09:30:22'),(13,'เพำเพะ่ะัไดำดำำอ','ดดำพเพะ้ะั่ะั่ะ',4,'อาคาร 1 ชั้น 1 ห้องชั้น10 ใหม่',NULL,NULL,'medium','completed','เพำ้พะ่ะัา่ัีาัาัี',1,2,NULL,'2025-08-29 09:36:03','2025-08-29 09:36:17','2025-08-29 09:36:17'),(14,'test deploy website','test deploy',4,'อาคาร 7 ชั้น 1 ห้องฏิบัติการยาฉีด',NULL,NULL,'high','pending','',1,NULL,NULL,'2026-02-15 08:10:29','2026-02-15 15:32:35',NULL);
/*!40000 ALTER TABLE `repair_requests` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rooms`
--

DROP TABLE IF EXISTS `rooms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rooms` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `building` int NOT NULL,
  `floor` int NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `is_active` tinyint(1) DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_building_floor` (`building`,`floor`),
  KEY `idx_name` (`name`),
  KEY `idx_building_floor_name` (`building`,`floor`,`name`),
  KEY `idx_active` (`is_active`)
) ENGINE=InnoDB AUTO_INCREMENT=185 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rooms`
--

LOCK TABLES `rooms` WRITE;
/*!40000 ALTER TABLE `rooms` DISABLE KEYS */;
INSERT INTO `rooms` VALUES (1,'ห้องการเงิน การคลังและพัสดุ',1,1,NULL,1,'2025-07-17 08:11:09','2025-07-17 08:11:09'),(2,'ห้องโถงบริการการศึกษา',1,1,NULL,1,'2025-07-17 08:11:09','2025-07-17 08:11:09'),(3,'ห้องงานบริการการศึกษา',1,1,NULL,1,'2025-07-17 08:11:09','2025-07-17 08:11:09'),(4,'ห้องพักอาจารย์ 1',1,1,NULL,1,'2025-07-17 08:11:09','2025-07-21 04:15:05'),(5,'ห้องพักอาจารย์ 14',1,2,NULL,1,'2025-07-17 08:11:09','2025-07-17 08:11:09'),(6,'ห้อง Counselling',1,2,NULL,1,'2025-07-17 08:11:09','2025-07-17 08:11:09'),(7,'ห้องพักอาจารย์ 15',1,2,NULL,1,'2025-07-17 08:11:09','2025-07-17 08:11:09'),(8,'ห้องพวงคราม',1,2,NULL,1,'2025-07-17 08:11:09','2025-07-17 08:11:09'),(9,'ห้องพักอาจารย์ 11',1,2,NULL,1,'2025-07-17 08:11:09','2025-07-17 08:11:09'),(10,'ห้องเฟื่องฟ้า1',1,3,'ดาดฟ้า',1,'2025-07-17 08:11:09','2025-07-21 04:15:34'),(11,'ห้องเฟื่องฟ้า2',1,3,'ดาดฟ้า',1,'2025-07-17 08:11:09','2025-07-21 04:15:39'),(12,'ห้องเฟื่องฟ้า 3',1,3,'ดาดฟ้า',1,'2025-07-17 08:11:09','2025-07-17 08:11:09'),(13,'ห้องเครื่องสำอางค์',2,1,NULL,1,'2025-07-17 08:11:09','2025-07-17 08:11:09'),(14,'ห้องปฏิบัติการจุลวิทยา 1',2,1,NULL,1,'2025-07-17 08:11:09','2025-07-17 08:11:09'),(15,'ห้องปฏิบัติการจุลวิทยา 2',2,1,NULL,1,'2025-07-17 08:11:09','2025-07-17 08:11:09'),(16,'ห้องปฏิบัติการจุลวิทยา 3',2,1,NULL,1,'2025-07-17 08:11:09','2025-07-17 08:11:09'),(18,'ห้องเครื่องมือกลาง 2',2,2,NULL,1,'2025-07-17 08:11:09','2025-07-22 07:35:01'),(25,'ห้องบรรยายผักหวาน (308)',2,3,NULL,1,'2025-07-17 08:11:09','2025-07-17 08:11:09'),(26,'ห้องพักอาจารย์ 6',2,4,NULL,1,'2025-07-17 08:11:09','2025-07-17 08:11:09'),(27,'ห้องปฏิบัติการยาเม็ด 1',3,1,NULL,1,'2025-07-17 08:11:09','2025-07-22 03:37:08'),(28,'ห้องปฏิบัติการยาเม็ด 2',3,1,NULL,1,'2025-07-17 08:11:09','2025-07-22 03:37:08'),(29,'ห้องปฏิบัติการยาเม็ด 3',3,1,NULL,1,'2025-07-17 08:11:09','2025-07-22 03:37:08'),(30,'ห้องปฏิบัติการยาเม็ด 4',3,1,NULL,1,'2025-07-17 08:11:09','2025-07-22 03:37:08'),(31,'ห้องปฏิบัติการยาเม็ด 5',3,1,NULL,1,'2025-07-17 08:11:09','2025-07-22 03:37:08'),(32,'ห้องปฏิบัติการยาเม็ด 6',3,1,NULL,1,'2025-07-17 08:11:09','2025-07-22 03:37:08'),(33,'ห้องปฏิบัติการยาเม็ด 7',3,1,NULL,1,'2025-07-17 08:11:09','2025-07-22 03:37:08'),(34,'ห้องปฏิบัติการยาเม็ด 8',3,1,NULL,1,'2025-07-17 08:11:09','2025-07-22 03:37:08'),(35,'ห้องปฏิบัติการยาเม็ด 9',3,1,NULL,1,'2025-07-17 08:11:09','2025-07-22 03:37:08'),(36,'ห้องปฏิบัติการยาเม็ด 10',3,1,NULL,1,'2025-07-17 08:11:09','2025-07-22 03:37:08'),(37,'ห้องปฏิบัติการและวิจัย เภสัชเคมี 1',3,1,NULL,1,'2025-07-17 08:11:09','2025-07-22 03:37:08'),(38,'ห้องปฏิบัติการและวิจัย เภสัชเคมี 2',3,1,NULL,1,'2025-07-17 08:11:09','2025-07-22 03:37:08'),(39,'ห้องปฏิบัติการและวิจัย เภสัชเคมี 3',3,1,NULL,1,'2025-07-17 08:11:09','2025-07-22 03:37:08'),(40,'ห้องปฏิบัติการและวิจัย เภสัชเคมี 4',3,1,NULL,1,'2025-07-17 08:11:09','2025-07-22 03:37:08'),(41,'ห้องบรรยายผักเสี้ยว (212)',3,2,NULL,1,'2025-07-17 08:11:09','2025-07-22 03:37:08'),(42,'ห้องปฏิบัติการเภสัชเคมี 1',3,2,NULL,1,'2025-07-17 08:11:09','2025-07-22 03:37:08'),(43,'ห้องปฏิบัติการเภสัชเคมี 2',3,2,NULL,1,'2025-07-17 08:11:09','2025-07-22 03:37:08'),(44,'ห้องปฏิบัติการเภสัชเคมี 3',3,2,NULL,1,'2025-07-17 08:11:09','2025-07-22 03:37:09'),(45,'ห้องปฏิบัติการเภสัชเคมี 4',3,2,NULL,1,'2025-07-17 08:11:09','2025-07-22 03:37:09'),(46,'ห้องปฏิบัติการเภสัชเคมี 5',3,2,NULL,1,'2025-07-17 08:11:09','2025-07-22 03:37:09'),(47,'ห้องปฏิบัติการเภสัชเคมี 6',3,2,NULL,1,'2025-07-17 08:11:09','2025-07-22 03:37:09'),(48,'ห้องปฏิบัติการเภสัชเคมี 7',3,2,NULL,1,'2025-07-17 08:11:09','2025-07-22 03:37:09'),(49,'ห้องปฏิบัติการเภสัชเคมี 8',3,2,NULL,1,'2025-07-17 08:11:09','2025-07-22 03:37:09'),(50,'ห้องปฏิบัติการกลางภาคบริบาล (ห้องไบโอ)',3,3,NULL,1,'2025-07-17 08:11:09','2025-07-22 03:37:09'),(51,'ห้องเก็บสารเคมี (อาจารย์ไชยวัฒน์)',3,3,NULL,1,'2025-07-17 08:11:09','2025-07-22 03:37:09'),(52,'ห้องเลี้ยงเซลล์',3,3,NULL,1,'2025-07-17 08:11:09','2025-07-22 03:37:09'),(53,'ห้องประชุม 6',3,3,NULL,1,'2025-07-17 08:11:09','2025-07-22 03:37:09'),(54,'ห้องพักอาจารย์ไชยวัฒน์',3,3,NULL,1,'2025-07-17 08:11:09','2025-07-22 03:37:09'),(55,'ห้องปฏิบัติการเภสัชเคมี',3,3,NULL,1,'2025-07-17 08:11:09','2025-07-22 07:38:37'),(59,'ห้องพักอาจารย์ 4',3,3,NULL,1,'2025-07-17 08:11:09','2025-07-22 03:37:09'),(60,'ห้องบรรยายผักแว่น (401)',3,4,NULL,1,'2025-07-17 08:11:09','2025-07-22 03:37:10'),(61,'ห้องพักอาจารย์ 5',3,4,NULL,1,'2025-07-17 08:11:09','2025-07-22 03:37:10'),(62,'ศูนย์นวัตกรรมสุขภาพองค์รวมโภชน์เภสัชภัณฑ์ 1',3,4,NULL,1,'2025-07-17 08:11:09','2025-07-22 03:37:09'),(63,'ศูนย์นวัตกรรมสุขภาพองค์รวมโภชน์เภสัชภัณฑ์ 2',3,4,NULL,1,'2025-07-17 08:11:09','2025-07-22 03:37:09'),(64,'ศูนย์นวัตกรรมสุขภาพองค์รวมโภชน์เภสัชภัณฑ์ 3',3,4,NULL,1,'2025-07-17 08:11:09','2025-07-22 03:37:09'),(65,'ศูนย์นวัตกรรมสุขภาพองค์รวมโภชน์เภสัชภัณฑ์ 4',3,4,NULL,1,'2025-07-17 08:11:09','2025-07-22 03:37:09'),(66,'ห้องปฏิบัติการ',3,4,NULL,1,'2025-07-17 08:11:09','2025-07-22 03:37:10'),(67,'ห้องเครื่องมือกลาง 3',3,4,NULL,1,'2025-07-17 08:11:09','2025-07-22 07:39:27'),(75,'ห้องดนตรี',3,5,NULL,1,'2025-07-17 08:11:09','2025-07-22 03:37:10'),(76,'ห้องปฏิบัติการชั้น 5',3,5,NULL,1,'2025-07-17 08:11:09','2025-07-22 07:39:52'),(87,'ห้องใต้ดินหน่วยอาคาร',4,0,'ใต้ดิน',1,'2025-07-17 08:11:09','2025-07-17 08:11:09'),(88,'งานบริหารงานทั่วไป',4,1,NULL,1,'2025-07-17 08:11:09','2025-07-17 08:11:09'),(89,'งานนโยบายและแผน',4,1,NULL,1,'2025-07-17 08:11:09','2025-07-17 08:11:09'),(90,'งานบริหารงานวิจัยและวิเทศน์สัมพันธ์',4,1,NULL,1,'2025-07-17 08:11:09','2025-07-17 08:11:09'),(91,'ห้องพักอาจารย์ 10',4,1,NULL,1,'2025-07-17 08:11:09','2025-07-17 08:11:09'),(92,'ห้องภาควิชาบริบาลเภสัชกรรม',4,1,NULL,1,'2025-07-17 08:11:09','2025-07-17 08:11:09'),(93,'ห้องเขียวมะกอก',4,1,NULL,1,'2025-07-17 08:11:09','2025-07-17 08:11:09'),(94,'ภาควิชาวิทยาศาสตร์เภสัชกรรม',4,1,NULL,1,'2025-07-17 08:11:09','2025-07-17 08:11:09'),(95,'พิพัธภัณฑ์สมุนไพร',4,1,NULL,1,'2025-07-17 08:11:09','2025-07-17 08:11:09'),(96,'ห้องร้านขายยาสมุนไพร (หอมไกล)',4,1,NULL,1,'2025-07-17 08:11:09','2025-07-17 08:11:09'),(97,'สำนักงานคณบดี',4,2,NULL,1,'2025-07-17 08:11:09','2025-07-17 08:11:09'),(98,'ห้องผู้ช่วยคณบดี',4,2,NULL,1,'2025-07-17 08:11:09','2025-07-17 08:11:09'),(99,'ห้องประชุม 1',4,2,NULL,1,'2025-07-17 08:11:09','2025-07-17 08:11:09'),(100,'ห้องประชุม 2',4,2,NULL,1,'2025-07-17 08:11:09','2025-07-17 08:11:09'),(101,'ห้องประชุม 3',4,2,NULL,1,'2025-07-17 08:11:09','2025-07-17 08:11:09'),(102,'ห้องประชุม 4',4,2,NULL,1,'2025-07-17 08:11:09','2025-07-17 08:11:09'),(103,'ห้องประชุม 5',4,2,NULL,1,'2025-07-17 08:11:09','2025-07-17 08:11:09'),(104,'ห้องออนไลน์ 1',4,2,NULL,1,'2025-07-17 08:11:09','2025-07-17 08:11:09'),(105,'ห้องออนไลน์ 2',4,2,NULL,1,'2025-07-17 08:11:09','2025-07-17 08:11:09'),(106,'ห้องออนไลน์ 3',4,2,NULL,1,'2025-07-17 08:11:09','2025-07-17 08:11:09'),(107,'ห้องออนไลน์ 4',4,2,NULL,1,'2025-07-17 08:11:09','2025-07-17 08:11:09'),(108,'หน่วย IT และ ห้องควบคุม Server',4,2,NULL,1,'2025-07-17 08:11:09','2025-07-17 08:11:09'),(109,'ห้องเพาะเลี้ยงเนื้อเยื่อ',4,2,NULL,1,'2025-07-17 08:11:09','2025-07-17 08:11:09'),(110,'หน่วยฝึกงานและพัฒนาวิชาชีพ',4,2,NULL,1,'2025-07-17 08:11:09','2025-07-17 08:11:09'),(111,'ห้องพุดซ้อน 1',4,2,NULL,1,'2025-07-17 08:11:09','2025-07-17 08:11:09'),(112,'ห้องพุดซ้อน 2',4,2,NULL,1,'2025-07-17 08:11:09','2025-07-17 08:11:09'),(113,'ห้องพุดซ้อน 3',4,2,NULL,1,'2025-07-17 08:11:09','2025-07-17 08:11:09'),(114,'ห้องพุทธชาด',4,3,NULL,1,'2025-07-17 08:11:09','2025-07-17 08:11:09'),(115,'ห้อง PCTC ศูนย์ฝึกอบรมบริบาลเภสัชกรรม',4,3,NULL,1,'2025-07-17 08:11:09','2025-07-17 08:11:09'),(116,'ห้องสมุด',4,3,NULL,1,'2025-07-17 08:11:09','2025-07-17 08:11:09'),(117,'ห้องศูนย์นวัตกรรมสมุนไพร',4,3,NULL,1,'2025-07-17 08:11:09','2025-07-17 08:11:09'),(118,'ห้องปฏิบัติการ เภสัชเวท',4,4,NULL,1,'2025-07-17 08:11:09','2025-07-17 08:11:09'),(119,'ห้องบัณฑิต 1',4,4,NULL,1,'2025-07-17 08:11:09','2025-07-17 08:11:09'),(120,'ห้องราชาวดี',4,4,NULL,1,'2025-07-17 08:11:09','2025-07-17 08:11:09'),(121,'ห้องสุนทรี (ห้องเก็บของข้างห้องสสี)',4,4,NULL,1,'2025-07-17 08:11:09','2025-07-17 08:11:09'),(122,'ห้องพักอาจารย์ 9',4,4,NULL,1,'2025-07-17 08:11:09','2025-07-17 08:11:09'),(123,'ห้องพุทธรักษา',4,4,NULL,1,'2025-07-17 08:11:09','2025-07-17 08:11:09'),(124,'ห้องเครื่องมือกลาง 1',4,5,NULL,1,'2025-07-17 08:11:09','2025-07-17 08:11:09'),(125,'ห้องพุดตาล',4,5,NULL,1,'2025-07-17 08:11:09','2025-07-17 08:11:09'),(126,'ห้องประชุมสสี',4,5,NULL,1,'2025-07-17 08:11:09','2025-07-17 08:11:09'),(127,'ห้องเครื่องลิฟท์หน้าภาคบริบาลฯ',4,6,'ดาดฟ้า',1,'2025-07-17 08:11:09','2025-07-17 08:11:09'),(128,'ห้องเครื่องลิฟท์หน้าภาควิทย์ฯ',4,6,'ดาดฟ้า',1,'2025-07-17 08:11:09','2025-07-17 08:11:09'),(129,'ห้อง Derm X',5,1,NULL,1,'2025-07-17 08:11:09','2025-07-17 08:11:09'),(130,'ห้องระบาด',5,1,NULL,1,'2025-07-17 08:11:09','2025-07-17 08:11:09'),(131,'ห้องพักบัณฑิต 2',5,2,NULL,1,'2025-07-17 08:11:09','2025-07-17 08:11:09'),(132,'ห้องปฏิบัติการกลางเทคโนโลยีเภสัชกรรม',5,2,NULL,1,'2025-07-17 08:11:09','2025-07-17 08:11:09'),(133,'ห้องปฏิบัติ (Lab นักศึกษา)',5,2,NULL,1,'2025-07-17 08:11:09','2025-07-17 08:11:09'),(134,'ห้องพักอาจารย์ 8',5,2,NULL,1,'2025-07-17 08:11:09','2025-07-17 08:11:09'),(135,'ห้องปฏิบัติการกลางทางเทคโนโลยี ฯ',5,3,NULL,1,'2025-07-17 08:11:09','2025-07-17 08:11:09'),(136,'ห้องปฏิบัติการ (เครื่องสำอางค์)',5,3,NULL,1,'2025-07-17 08:11:09','2025-07-17 08:11:09'),(137,'ห้องปฏิบัติการ',5,3,NULL,1,'2025-07-17 08:11:09','2025-07-22 07:43:17'),(138,'ห้องวิจัยเลี้ยงเซลล์ 2',5,3,NULL,1,'2025-07-17 08:11:09','2025-07-17 08:11:09'),(139,'ห้องเครื่องมือ (ห้องขัดผิว)',5,3,NULL,1,'2025-07-17 08:11:09','2025-07-17 08:11:09'),(140,'ห้องเครื่องมือ',5,3,NULL,1,'2025-07-17 08:11:09','2025-07-17 08:11:09'),(141,'ห้องพักอาจารย์ 2',5,3,NULL,1,'2025-07-17 08:11:09','2025-07-17 08:11:09'),(142,'ห้องพักอาจารย์ 7',6,1,NULL,1,'2025-07-17 08:11:09','2025-07-22 07:43:48'),(148,'Co-working space ',6,2,NULL,1,'2025-07-17 08:11:09','2025-07-22 07:44:25'),(155,'ห้องบรรยายกระถินณรงค์',6,2,NULL,1,'2025-07-17 08:11:09','2025-07-17 08:11:09'),(156,'ห้องฏิบัติการยาฉีด',7,1,NULL,1,'2025-07-17 08:11:09','2025-07-17 08:11:09'),(157,'โรงงานเครื่องสำอางค์ 1',8,1,NULL,1,'2025-07-17 08:11:09','2025-07-17 08:11:09'),(158,'โรงงานเครื่องสำอางค์ 2',8,1,NULL,1,'2025-07-17 08:11:09','2025-07-17 08:11:09'),(159,'โรงงานเครื่องสำอางค์ 3',8,1,NULL,1,'2025-07-17 08:11:09','2025-07-17 08:11:09'),(160,'โรงงานเครื่องสำอางค์ 4',8,1,NULL,1,'2025-07-17 08:11:09','2025-07-17 08:11:09'),(161,'โรงงานเครื่องสำอางค์ 5',8,1,NULL,1,'2025-07-17 08:11:09','2025-07-17 08:11:09'),(162,'โรงงานเครื่องสำอางค์ 6',8,1,NULL,1,'2025-07-17 08:11:09','2025-07-17 08:11:09'),(163,'โรงงานเครื่องสำอางค์ 7',8,1,NULL,1,'2025-07-17 08:11:09','2025-07-17 08:11:09'),(164,'โรงงานเครื่องสำอางค์ 8',8,1,NULL,1,'2025-07-17 08:11:09','2025-07-17 08:11:09'),(165,'โรงงานเครื่องสำอางค์ 9',8,1,NULL,1,'2025-07-17 08:11:09','2025-07-17 08:11:09'),(166,'โรงงานเครื่องสำอางค์ 10',8,1,NULL,1,'2025-07-17 08:11:09','2025-07-17 08:11:09'),(167,'โรงงานเครื่องสำอางค์ 11',8,1,NULL,1,'2025-07-17 08:11:09','2025-07-17 08:11:09'),(168,'โรงงานเครื่องสำอางค์ 12',8,1,NULL,1,'2025-07-17 08:11:09','2025-07-17 08:11:09'),(169,'โรงงานเครื่องสำอางค์ 13',8,1,NULL,1,'2025-07-17 08:11:09','2025-07-17 08:11:09'),(170,'โรงงานเครื่องสำอางค์ 14',8,1,NULL,1,'2025-07-17 08:11:09','2025-07-17 08:11:09'),(171,'หอพระด้านหน้า',9,1,'หน้าคณะ',1,'2025-07-17 08:11:09','2025-07-17 08:11:09'),(172,'หอพักนักศึกษา',9,1,'หอพัก',1,'2025-07-17 08:11:09','2025-07-17 08:11:09'),(173,'ห้องตัวอย่าง',11,1,'ห้องตัวอย่างสำหรับ11',0,'2025-07-21 09:20:46','2025-07-22 07:22:23'),(174,'ห้องตัวอย่างชั้น 5',2,5,'ห้องตัวอย่างสำหรับชั้น 5',1,'2025-07-22 03:07:53','2025-07-22 03:07:53'),(175,'ห้องตัวอย่างชั้น 3',2,3,'ห้องตัวอย่างสำหรับชั้น 3',1,'2025-07-22 03:18:25','2025-07-22 03:18:25'),(176,'ห้องตัวอย่าง',100,1,'ห้องตัวอย่างสำหรับ100',0,'2025-07-22 03:37:22','2025-07-22 07:22:18'),(178,'ห้องชั้น10 ใหม่',10,1,'ห้องตัวอย่างสำหรับอาคาร 10',1,'2025-07-22 07:48:53','2025-07-22 07:49:40'),(179,'ห้องตัวอย่างชั้น 2',9,2,'ห้องตัวอย่างสำหรับชั้น 2',1,'2025-07-22 08:34:50','2025-07-22 08:34:50'),(180,'ห้องตัวอย่างชั้น 3',9,3,'ห้องตัวอย่างสำหรับชั้น 3',1,'2025-07-22 08:34:52','2025-07-22 08:34:52'),(181,'ห้อง12 อาคารใหม่',12,1,'ห้องตัวอย่างสำหรับอาคาร 12',1,'2025-07-23 04:11:13','2025-07-23 04:11:51'),(182,'ห้องตัวอย่างชั้น 2',12,2,'ห้องตัวอย่างสำหรับชั้น 2',1,'2025-07-23 04:11:19','2025-07-23 04:11:19'),(183,'ห้องตัวอย่างชั้น 3',12,3,'ห้องตัวอย่างสำหรับชั้น 3',1,'2025-07-23 04:11:22','2025-07-23 04:11:22'),(184,'ห้องตัวอย่าง',13,1,'ห้องตัวอย่างสำหรับอาคาร 13',1,'2025-08-19 05:46:39','2025-08-19 05:46:39');
/*!40000 ALTER TABLE `rooms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `status_history`
--

DROP TABLE IF EXISTS `status_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `status_history` (
  `id` int NOT NULL AUTO_INCREMENT,
  `repair_request_id` int NOT NULL,
  `old_status` enum('pending','assigned','in_progress','completed','cancelled') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `new_status` enum('pending','assigned','in_progress','completed','cancelled') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `updated_by` int NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `completion_images` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  PRIMARY KEY (`id`),
  KEY `repair_request_id` (`repair_request_id`),
  KEY `updated_by` (`updated_by`),
  CONSTRAINT `status_history_ibfk_1` FOREIGN KEY (`repair_request_id`) REFERENCES `repair_requests` (`id`) ON DELETE CASCADE,
  CONSTRAINT `status_history_ibfk_2` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `status_history_chk_1` CHECK (json_valid(`completion_images`))
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `status_history`
--

LOCK TABLES `status_history` WRITE;
/*!40000 ALTER TABLE `status_history` DISABLE KEYS */;
INSERT INTO `status_history` VALUES (1,1,'pending','assigned',NULL,1,'2025-07-17 07:23:27',NULL),(2,2,'pending','in_progress',NULL,1,'2025-07-17 07:26:49',NULL),(3,3,'pending','pending',NULL,1,'2025-07-18 03:17:38',NULL),(4,12,'pending','assigned',NULL,1,'2025-08-29 09:25:55',NULL),(5,12,'assigned','in_progress',NULL,1,'2025-08-29 09:29:22',NULL),(6,12,'in_progress','completed','oooooooooooooooooooooooooooooo',1,'2025-08-29 09:30:22',NULL),(7,12,'completed','assigned','oooooooooooooooooooooooooooooo',1,'2025-08-29 09:35:38',NULL),(8,13,'pending','completed','เพำ้พะ่ะัา่ัีาัาัี',1,'2025-08-29 09:36:17',NULL),(9,14,'pending','pending',NULL,1,'2026-02-15 15:32:35',NULL);
/*!40000 ALTER TABLE `status_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `system_settings`
--

DROP TABLE IF EXISTS `system_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `system_settings` (
  `id` int NOT NULL AUTO_INCREMENT,
  `setting_key` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `setting_value` text COLLATE utf8mb4_unicode_ci,
  `setting_type` enum('string','number','boolean','json') COLLATE utf8mb4_unicode_ci DEFAULT 'string',
  `description` text COLLATE utf8mb4_unicode_ci,
  `is_sensitive` tinyint(1) DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `setting_key` (`setting_key`),
  KEY `idx_setting_key` (`setting_key`)
) ENGINE=InnoDB AUTO_INCREMENT=1633 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `system_settings`
--

LOCK TABLES `system_settings` WRITE;
/*!40000 ALTER TABLE `system_settings` DISABLE KEYS */;
INSERT INTO `system_settings` VALUES (1,'line_channel_access_token','bkIG1WDD83IHJKua7Ayeh+5r2XfJywrCGkJzYn/xdPj3hGslOetmPXKtVKkoLDS1YSxacNSaA3KmwY1VD0qLSDSVrA4KLzklDhW0ZvATF5+eDVtu9fcaHWu+E+8lotC30WvJ1J9rBN+w19QWovINSAdB04t89/1O/w1cDnyilFU=','string','LINE Channel Access Token สำหรับส่งข้อความ',1,'2025-07-02 04:18:43','2025-07-02 09:24:53'),(2,'line_channel_secret','4f29a2a6361743a51f88d346e497b50e','string','LINE Channel Secret สำหรับยืนยันตัวตน',1,'2025-07-02 04:18:43','2025-07-02 09:24:53'),(3,'line_group_id','C8a6a7f9b1438f91ed4ef9721d2c0cd2a','string','LINE Group ID หรือ Room ID สำหรับส่งแจ้งเตือน',0,'2025-07-02 04:18:43','2025-07-02 09:24:53'),(4,'line_notifications_enabled','true','boolean','เปิด/ปิดการแจ้งเตือนผ่าน LINE',0,'2025-07-02 04:18:43','2025-07-02 09:24:53'),(5,'line_webhook_url','','string','URL สำหรับรับ Webhook จาก LINE',0,'2025-07-02 04:18:43','2025-07-02 09:24:53'),(6,'system_name','ระบบแจ้งซ่อม','string','ชื่อระบบ',0,'2025-07-02 04:18:43','2025-07-02 09:24:53'),(7,'admin_email','','string','อีเมลผู้ดูแลระบบ',0,'2025-07-02 04:18:43','2025-07-02 09:24:53'),(8,'notification_new_repair','true','boolean','แจ้งเตือนเมื่อมีการแจ้งซ่อมใหม่',0,'2025-07-02 04:18:43','2025-07-02 09:24:53'),(9,'notification_status_update','true','boolean','แจ้งเตือนเมื่อมีการอัพเดทสถานะ',0,'2025-07-02 04:18:43','2025-07-02 09:24:53'),(10,'max_image_size_mb','5','number','ขนาดไฟล์รูปภาพสูงสุด (MB)',0,'2025-07-02 04:18:43','2025-07-02 09:24:53'),(11,'max_images_per_request','50','number','จำนวนรูปภาพสูงสุดต่อการแจ้งซ่อม',0,'2025-07-02 04:18:43','2025-07-02 09:24:53');
/*!40000 ALTER TABLE `system_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tech_report_request`
--

DROP TABLE IF EXISTS `tech_report_request`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tech_report_request` (
  `report_id` int NOT NULL AUTO_INCREMENT,
  `request_id` int NOT NULL,
  `report_comment` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_by` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`report_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tech_report_request`
--

LOCK TABLES `tech_report_request` WRITE;
/*!40000 ALTER TABLE `tech_report_request` DISABLE KEYS */;
INSERT INTO `tech_report_request` VALUES (1,184,'รอสั่งของครับ (แก้ไข)','EP160047','2025-08-29 16:20:42');
/*!40000 ALTER TABLE `tech_report_request` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `full_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `role` enum('admin','technician','user') COLLATE utf8mb4_unicode_ci DEFAULT 'user',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `last_login` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`),
  KEY `idx_role` (`role`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'admin','admin@test.com','$2b$10$9wzrqtrGA185wB14FZBSturfKIQpCHGUDvuYQXMP8O0lkqLFTMV8q','Admin',NULL,'admin','2025-06-19 06:22:38','2026-02-15 15:34:38','2026-02-15 15:34:38'),(2,'tech','Tech@test.com','$2b$10$wuWgRwX0R03wK4FC3bTTEumQLXVZ6G5adra/BDq1833U8DR/J2sNe','Tech','1233445566','technician','2025-06-24 07:36:31','2025-08-29 09:26:43','2025-08-29 09:26:43'),(3,'user','user@test.com','$2a$12$g7vG8PhLhXKptRaQmJ7ZEOUMUX.H0hnhSIKkM5JqWZ3quOsMLcCVW','User',NULL,'user','2025-06-19 06:22:38','2025-07-17 07:24:44','2025-07-17 07:24:44'),(4,'admin1','admin1@test.com','admin123','admin1','NULL','admin','2026-02-15 07:03:40','2026-02-15 07:03:40',NULL);
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

-- Dump completed on 2026-02-16  0:42:59
