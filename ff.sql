-- MySQL dump 10.13  Distrib 8.0.36, for Linux (x86_64)
--
-- Host: 10.22.1.11    Database: darpan
-- ------------------------------------------------------
-- Server version	5.5.5-10.6.18-MariaDB-0ubuntu0.22.04.1

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
-- Table structure for table `address`
--

DROP TABLE IF EXISTS `address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `address` (
  `Sno` int(11) NOT NULL AUTO_INCREMENT,
  `application_no` varchar(15) NOT NULL,
  `line_1_C` varchar(60) DEFAULT NULL,
  `line_2_C` varchar(60) DEFAULT NULL,
  `current_state` varchar(100) DEFAULT NULL,
  `current_district` varchar(100) DEFAULT NULL,
  `current_city` varchar(30) DEFAULT NULL,
  `current_pin` int(6) DEFAULT NULL,
  `line_1_P` varchar(60) DEFAULT NULL,
  `line_2_P` varchar(60) DEFAULT NULL,
  `p_state` varchar(100) NOT NULL,
  `p_dis` varchar(100) NOT NULL,
  `p_city` varchar(30) DEFAULT NULL,
  `p_pin` int(6) DEFAULT NULL,
  PRIMARY KEY (`application_no`),
  KEY `Sno` (`Sno`),
  KEY `fk_address_state_idx` (`current_state`,`p_state`),
  KEY `fk_address_2_state_idx` (`p_state`),
  KEY `fk_address_1_district_idx` (`current_district`),
  KEY `fk_address_district_c_idx` (`current_state`,`current_district`),
  KEY `fk_address_district_p` (`p_state`,`p_dis`),
  CONSTRAINT `fk_address_2_state` FOREIGN KEY (`p_state`) REFERENCES `states` (`state_name_english`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_address_district_c` FOREIGN KEY (`current_state`, `current_district`) REFERENCES `district` (`state_name_english`, `district_name_english`),
  CONSTRAINT `fk_address_district_p` FOREIGN KEY (`p_state`, `p_dis`) REFERENCES `district` (`state_name_english`, `district_name_english`),
  CONSTRAINT `fk_address_personal` FOREIGN KEY (`application_no`) REFERENCES `personal` (`application_no`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `address`
--

LOCK TABLES `address` WRITE;
/*!40000 ALTER TABLE `address` DISABLE KEYS */;
INSERT INTO `address` VALUES (13,'100100710484','dsfsdf','dsfsd','Arunachal Pradesh','Changlang','sdfsd',344234,'dsfsdf','dsfsd','Arunachal Pradesh','Changlang','sdfsd',344234),(11,'100100715151','fdgfdg443','gfdf45','Andhra Pradesh','Annamayya','fdgdf',534543,'fdgfdg443','gfdf45','Andhra Pradesh','Annamayya','fdgdf',534543),(14,'100100738703','654654','thtfgytf','Andaman And Nicobar Islands','Nicobars','fhgfhfhg',676576,'654654','thtfgytf','Andaman And Nicobar Islands','Nicobars','fhgfhfhg',676576),(2,'100100740695','fsdf','fdsfs','Karnataka','Gadag','dsfdsf',434234,'fsdf','fdsfs','Karnataka','Gadag','dsfdsf',434234),(12,'100100754418','gfdgfgfgfdgfgv','gfdsgfg','Goa','North Goa','fgfgf',565465,'gfdgfgfgfdgfgv','gfdsgfg','Goa','North Goa','fgfgf',565465),(10,'100100756184','cxzc','xzcz','Andaman And Nicobar Islands','North And Middle Andaman','xcxzc',332132,'cxzc','xzcz','Andaman And Nicobar Islands','North And Middle Andaman','xcxzc',332132),(6,'100100766784','fsdf','fdsfs','Karnataka','Belagavi','dsfdsf',434234,'fsdf','fdsfs','Karnataka','Hassan','dsfdsf',434234),(4,'100100767583','7567','Din Dayal colony','Chandigarh','Chandigarh','kolapuri',565476,'7567','Din Dayal colony','Chandigarh','Chandigarh','kolapuri',565476),(8,'100100771725','fsdf','fdsfs','Karnataka','Belagavi','dsfdsf',434234,'fsdf','fdsfs','Karnataka','Chitradurga','dsfdsf',434234);
/*!40000 ALTER TABLE `address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `advert_master`
--

DROP TABLE IF EXISTS `advert_master`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `advert_master` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `advert_name` varchar(100) DEFAULT NULL,
  `opening_date` varchar(45) DEFAULT NULL,
  `closing_date` varchar(45) DEFAULT NULL,
  `file_path` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `advert_master`
--

LOCK TABLES `advert_master` WRITE;
/*!40000 ALTER TABLE `advert_master` DISABLE KEYS */;
INSERT INTO `advert_master` VALUES (98,'CEP11','2025-11-19','2027-10-19','/var/www/uploads_files_backend/admin_uploads/PYTHON PROGRAMMING NOTES.pdf');
/*!40000 ALTER TABLE `advert_master` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `age_relaxation`
--

DROP TABLE IF EXISTS `age_relaxation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `age_relaxation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `relaxation_in` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `relaxation_in_UNIQUE` (`relaxation_in`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `age_relaxation`
--

LOCK TABLES `age_relaxation` WRITE;
/*!40000 ALTER TABLE `age_relaxation` DISABLE KEYS */;
INSERT INTO `age_relaxation` VALUES (12,'Central Government employee'),(2,'Ex-Serviceman'),(4,'OBC'),(10,'PwD'),(8,'SC'),(6,'ST');
/*!40000 ALTER TABLE `age_relaxation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `application_status`
--

DROP TABLE IF EXISTS `application_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `application_status` (
  `SN` int(11) NOT NULL AUTO_INCREMENT,
  `user` varchar(50) DEFAULT NULL,
  `application_no` varchar(15) NOT NULL,
  `status` varchar(10) DEFAULT NULL,
  `step` int(11) NOT NULL,
  `updated_time` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`SN`),
  KEY `fk_application_reg` (`user`),
  KEY `fk_application_personal_idx` (`application_no`),
  KEY `fk_applicationStatus_personal_idx` (`application_no`),
  CONSTRAINT `fk_application_personal` FOREIGN KEY (`application_no`) REFERENCES `personal` (`application_no`),
  CONSTRAINT `fk_application_reg` FOREIGN KEY (`user`) REFERENCES `registration_user` (`user`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `application_status`
--

LOCK TABLES `application_status` WRITE;
/*!40000 ALTER TABLE `application_status` DISABLE KEYS */;
INSERT INTO `application_status` VALUES (2,'9k.deepak.9k@gmail.com','100100740695','COMPLETED',5,'2025-08-04 10:59:44'),(4,'dk@mail','100100767583','COMPLETED',5,'2025-08-08 06:41:34'),(6,'dk@mail','100100766784','COMPLETED',5,'2024-01-26 22:31:13'),(8,'dk@mail','100100771725','COMPLETED',5,'2024-01-26 22:42:40'),(10,'dk@mail','100100756184','INCOMPLETE',2,'2024-01-30 01:23:36'),(12,'dk@mail','100100767501','INCOMPLETE',1,'2024-02-04 20:14:36'),(13,'dk@mail','100100715151','COMPLETED',5,'2024-02-09 21:35:58'),(14,'dk@mail','100100793677','INCOMPLETE',1,'2024-02-09 21:50:45'),(16,'dk@mail','100100754418','COMPLETED',5,'2024-02-09 22:45:28'),(18,'dk@mail','100100710484','INCOMPLETE',4,'2024-02-09 23:29:11'),(20,'dk@mail','100100738703','COMPLETED',5,'2024-02-09 23:23:18');
/*!40000 ALTER TABLE `application_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bank_account`
--

DROP TABLE IF EXISTS `bank_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bank_account` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `bank_name` varchar(100) DEFAULT NULL,
  `account_no` varchar(45) DEFAULT NULL,
  `ifsc_code` varchar(45) DEFAULT NULL,
  `account_holder` varchar(100) DEFAULT NULL,
  `amount` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bank_account`
--

LOCK TABLES `bank_account` WRITE;
/*!40000 ALTER TABLE `bank_account` DISABLE KEYS */;
INSERT INTO `bank_account` VALUES (32,'dhfgdk','98459847598787','SBIN0008000','ggiuhgkhu uohoui','87');
/*!40000 ALTER TABLE `bank_account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `category_UNIQUE` (`category`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (4,'EWS'),(6,'OBC'),(8,'SC'),(10,'ST'),(2,'UnReserved');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `class_division`
--

DROP TABLE IF EXISTS `class_division`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `class_division` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `class_division` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `class_division`
--

LOCK TABLES `class_division` WRITE;
/*!40000 ALTER TABLE `class_division` DISABLE KEYS */;
INSERT INTO `class_division` VALUES (2,'I'),(4,'II'),(6,'III');
/*!40000 ALTER TABLE `class_division` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `discipline`
--

DROP TABLE IF EXISTS `discipline`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `discipline` (
  `SN` int(11) NOT NULL AUTO_INCREMENT,
  `discipline` varchar(80) NOT NULL,
  `post_id` int(11) NOT NULL,
  `duration_req` varchar(145) DEFAULT NULL,
  PRIMARY KEY (`SN`),
  UNIQUE KEY `discipline_UNIQUE` (`discipline`),
  KEY `post_dis_id` (`post_id`),
  CONSTRAINT `post_dis_id` FOREIGN KEY (`post_id`) REFERENCES `posts` (`post_id`)
) ENGINE=InnoDB AUTO_INCREMENT=72 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `discipline`
--

LOCK TABLES `discipline` WRITE;
/*!40000 ALTER TABLE `discipline` DISABLE KEYS */;
INSERT INTO `discipline` VALUES (67,'PROJECT STORE OFFICER(PSO)',83,'10'),(69,'PROJECT SENIOR ADMIN ASSISTANT(PSAA)',83,'6'),(71,'PROJECT ADMIN ASSISTANT(PAA)',83,'3');
/*!40000 ALTER TABLE `discipline` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `district`
--

DROP TABLE IF EXISTS `district`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `district` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `state_code` int(11) NOT NULL,
  `state_name_english` varchar(100) NOT NULL,
  `district_code` varchar(10) DEFAULT NULL,
  `district_name_english` varchar(100) NOT NULL,
  `last_updated` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`district_name_english`,`state_name_english`),
  UNIQUE KEY `index3` (`state_code`,`district_name_english`),
  UNIQUE KEY `uniq_state_district` (`state_name_english`,`district_name_english`),
  KEY `ix_district_id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1572 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `district`
--

LOCK TABLES `district` WRITE;
/*!40000 ALTER TABLE `district` DISABLE KEYS */;
INSERT INTO `district` VALUES (1240,36,'Telangana','501','Adilabad','2024-10-07'),(300,23,'Madhya Pradesh','667','Agar-Malwa','2024-10-07'),(302,9,'Uttar Pradesh','118','Agra','2024-10-07'),(1242,24,'Gujarat','438','Ahmedabad','2024-10-07'),(596,27,'Maharashtra','466','Ahmednagar','2024-10-07'),(1244,15,'Mizoram','261','Aizawl','2024-10-07'),(304,8,'Rajasthan','86','Ajmer','2024-10-07'),(1246,27,'Maharashtra','467','Akola','2024-10-07'),(2,32,'Kerala','554','Alappuzha','2024-10-07'),(1248,9,'Uttar Pradesh','119','Aligarh','2024-10-07'),(306,19,'West Bengal','664','Alipurduar','2024-10-07'),(1250,23,'Madhya Pradesh','639','Alirajpur','2024-10-07'),(598,28,'Andhra Pradesh','745','Alluri Sitharama Raju','2024-10-07'),(308,5,'Uttarakhand','45','Almora','2024-10-07'),(1252,8,'Rajasthan','87','Alwar','2024-10-07'),(310,6,'Haryana','58','Ambala','2024-10-07'),(4,9,'Uttar Pradesh','121','Ambedkar Nagar','2024-10-07'),(1254,9,'Uttar Pradesh','640','Amethi','2024-10-07'),(312,27,'Maharashtra','468','Amravati','2024-10-07'),(314,24,'Gujarat','439','Amreli','2024-10-07'),(6,3,'Punjab','27','Amritsar','2024-10-07'),(600,9,'Uttar Pradesh','154','Amroha','2024-10-07'),(602,28,'Andhra Pradesh','744','Anakapalli','2024-10-07'),(926,24,'Gujarat','440','Anand','2024-10-07'),(928,28,'Andhra Pradesh','502','Ananthapuramu','2024-10-07'),(316,1,'Jammu And Kashmir','1','Anantnag','2024-10-07'),(604,12,'Arunachal Pradesh','628','Anjaw','2024-10-07'),(318,28,'Andhra Pradesh','753','Annamayya','2024-10-07'),(930,21,'Odisha','344','Anugul','2024-10-07'),(606,8,'Rajasthan','776','Anupgarh','2024-10-07'),(932,23,'Madhya Pradesh','390','Anuppur','2024-10-07'),(934,10,'Bihar','188','Araria','2024-10-07'),(936,33,'Tamil Nadu','610','Ariyalur','2024-10-07'),(8,24,'Gujarat','672','Arvalli','2024-10-07'),(10,10,'Bihar','611','Arwal','2024-10-07'),(938,23,'Madhya Pradesh','391','Ashoknagar','2024-10-07'),(608,9,'Uttar Pradesh','122','Auraiya','2024-10-07'),(12,10,'Bihar','189','Aurangabad','2024-10-07'),(610,9,'Uttar Pradesh','140','Ayodhya','2024-10-07'),(1256,9,'Uttar Pradesh','123','Azamgarh','2024-10-07'),(1258,29,'Karnataka','524','Bagalkote','2024-10-07'),(1260,5,'Uttarakhand','46','Bageshwar','2024-10-07'),(940,9,'Uttar Pradesh','124','Baghpat','2024-10-07'),(14,9,'Uttar Pradesh','125','Bahraich','2024-10-07'),(612,18,'Assam','739','Bajali','2024-10-07'),(320,18,'Assam','616','Baksa','2024-10-07'),(942,23,'Madhya Pradesh','392','Balaghat','2024-10-07'),(614,21,'Odisha','345','Balangir','2024-10-07'),(322,21,'Odisha','346','Baleshwar','2024-10-07'),(1262,29,'Karnataka','528','Ballari','2024-10-07'),(324,9,'Uttar Pradesh','126','Ballia','2024-10-07'),(16,22,'Chhattisgarh','646','Balod','2024-10-07'),(326,22,'Chhattisgarh','644','Balodabazar-Bhatapara','2024-10-07'),(944,8,'Rajasthan','775','Balotra','2024-10-07'),(18,9,'Uttar Pradesh','127','Balrampur','2024-10-07'),(20,22,'Chhattisgarh','649','Balrampur-Ramanujganj','2024-10-07'),(946,24,'Gujarat','441','Banas Kantha','2024-10-07'),(328,9,'Uttar Pradesh','128','Banda','2024-10-07'),(22,1,'Jammu And Kashmir','623','Bandipora','2024-10-07'),(330,10,'Bihar','190','Banka','2024-10-07'),(332,19,'West Bengal','305','Bankura','2024-10-07'),(948,8,'Rajasthan','88','Banswara','2024-10-07'),(1264,28,'Andhra Pradesh','750','Bapatla','2024-10-07'),(616,9,'Uttar Pradesh','129','Bara Banki','2024-10-07'),(334,1,'Jammu And Kashmir','3','Baramulla','2024-10-07'),(950,8,'Rajasthan','89','Baran','2024-10-07'),(336,9,'Uttar Pradesh','130','Bareilly','2024-10-07'),(952,21,'Odisha','347','Bargarh','2024-10-07'),(1266,8,'Rajasthan','90','Barmer','2024-10-07'),(1268,3,'Punjab','605','Barnala','2024-10-07'),(1270,18,'Assam','280','Barpeta','2024-10-07'),(338,23,'Madhya Pradesh','393','Barwani','2024-10-07'),(1272,22,'Chhattisgarh','374','Bastar','2024-10-07'),(954,9,'Uttar Pradesh','131','Basti','2024-10-07'),(340,3,'Punjab','28','Bathinda','2024-10-07'),(956,8,'Rajasthan','774','Beawar','2024-10-07'),(24,27,'Maharashtra','470','Beed','2024-10-07'),(342,10,'Bihar','191','Begusarai','2024-10-07'),(344,29,'Karnataka','527','Belagavi','2024-10-07'),(26,22,'Chhattisgarh','650','Bemetara','2024-10-07'),(958,29,'Karnataka','526','Bengaluru Rural','2024-10-07'),(28,29,'Karnataka','525','Bengaluru Urban','2024-10-07'),(1274,23,'Madhya Pradesh','394','Betul','2024-10-07'),(30,9,'Uttar Pradesh','179','Bhadohi','2024-10-07'),(618,36,'Telangana','690','Bhadradri Kothagudem','2024-10-07'),(1276,21,'Odisha','348','Bhadrak','2024-10-07'),(346,10,'Bihar','192','Bhagalpur','2024-10-07'),(32,27,'Maharashtra','471','Bhandara','2024-10-07'),(620,8,'Rajasthan','91','Bharatpur','2024-10-07'),(960,24,'Gujarat','442','Bharuch','2024-10-07'),(1278,24,'Gujarat','443','Bhavnagar','2024-10-07'),(1280,8,'Rajasthan','92','Bhilwara','2024-10-07'),(34,23,'Madhya Pradesh','395','Bhind','2024-10-07'),(1282,6,'Haryana','59','Bhiwani','2024-10-07'),(622,10,'Bihar','193','Bhojpur','2024-10-07'),(962,23,'Madhya Pradesh','396','Bhopal','2024-10-07'),(1284,29,'Karnataka','529','Bidar','2024-10-07'),(36,22,'Chhattisgarh','636','Bijapur','2024-10-07'),(1286,9,'Uttar Pradesh','132','Bijnor','2024-10-07'),(624,8,'Rajasthan','93','Bikaner','2024-10-07'),(348,22,'Chhattisgarh','375','Bilaspur','2024-10-07'),(1288,2,'Himachal Pradesh','15','Bilaspur','2024-10-07'),(626,19,'West Bengal','307','Birbhum','2024-10-07'),(350,14,'Manipur','252','Bishnupur','2024-10-07'),(352,18,'Assam','705','Biswanath','2024-10-07'),(1290,20,'Jharkhand','322','Bokaro','2024-10-07'),(1292,18,'Assam','281','Bongaigaon','2024-10-07'),(38,24,'Gujarat','676','Botad','2024-10-07'),(964,21,'Odisha','349','Boudh','2024-10-07'),(354,9,'Uttar Pradesh','133','Budaun','2024-10-07'),(1294,1,'Jammu And Kashmir','2','Budgam','2024-10-07'),(356,9,'Uttar Pradesh','134','Bulandshahr','2024-10-07'),(966,27,'Maharashtra','472','Buldhana','2024-10-07'),(358,8,'Rajasthan','94','Bundi','2024-10-07'),(968,23,'Madhya Pradesh','397','Burhanpur','2024-10-07'),(1296,10,'Bihar','194','Buxar','2024-10-07'),(360,18,'Assam','282','Cachar','2024-10-07'),(1298,7,'Delhi','77','Central','2024-10-07'),(362,29,'Karnataka','531','Chamarajanagara','2024-10-07'),(1300,2,'Himachal Pradesh','16','Chamba','2024-10-07'),(40,5,'Uttarakhand','47','Chamoli','2024-10-07'),(364,5,'Uttarakhand','48','Champawat','2024-10-07'),(1302,15,'Mizoram','262','Champhai','2024-10-07'),(42,9,'Uttar Pradesh','135','Chandauli','2024-10-07'),(44,14,'Manipur','253','Chandel','2024-10-07'),(1304,4,'Chandigarh','44','Chandigarh','2024-10-07'),(46,27,'Maharashtra','473','Chandrapur','2024-10-07'),(970,12,'Arunachal Pradesh','229','Changlang','2024-10-07'),(366,18,'Assam','708','Charaideo','2024-10-07'),(628,6,'Haryana','701','Charki Dadri','2024-10-07'),(972,20,'Jharkhand','323','Chatra','2024-10-07'),(1306,33,'Tamil Nadu','730','Chengalpattu','2024-10-07'),(368,33,'Tamil Nadu','568','Chennai','2024-10-07'),(48,23,'Madhya Pradesh','398','Chhatarpur','2024-10-07'),(1308,27,'Maharashtra','469','Chhatrapati Sambhajinagar','2024-10-07'),(1310,23,'Madhya Pradesh','399','Chhindwara','2024-10-07'),(50,24,'Gujarat','668','Chhotaudepur','2024-10-07'),(630,29,'Karnataka','630','Chikkaballapura','2024-10-07'),(974,29,'Karnataka','532','Chikkamagaluru','2024-10-07'),(370,18,'Assam','612','Chirang','2024-10-07'),(976,29,'Karnataka','533','Chitradurga','2024-10-07'),(1312,9,'Uttar Pradesh','136','Chitrakoot','2024-10-07'),(632,28,'Andhra Pradesh','503','Chittoor','2024-10-07'),(978,8,'Rajasthan','95','Chittorgarh','2024-10-07'),(980,13,'Nagaland','758','Chumoukedima','2024-10-07'),(1314,14,'Manipur','254','Churachandpur','2024-10-07'),(982,8,'Rajasthan','96','Churu','2024-10-07'),(372,33,'Tamil Nadu','569','Coimbatore','2024-10-07'),(984,19,'West Bengal','308','Cooch Behar','2024-10-07'),(1316,33,'Tamil Nadu','570','Cuddalore','2024-10-07'),(1318,21,'Odisha','350','Cuttack','2024-10-07'),(986,38,'The Dadra And Nagar Haveli And Daman And Diu','465','Dadra And Nagar Haveli','2024-10-07'),(52,24,'Gujarat','445','Dahod','2024-10-07'),(634,22,'Chhattisgarh','376','Dakshin Bastar Dantewada','2024-10-07'),(54,19,'West Bengal','310','Dakshin Dinajpur','2024-10-07'),(1320,29,'Karnataka','534','Dakshina Kannada','2024-10-07'),(1322,38,'The Dadra And Nagar Haveli And Daman And Diu','463','Daman','2024-10-07'),(56,23,'Madhya Pradesh','400','Damoh','2024-10-07'),(58,24,'Gujarat','444','Dangs','2024-10-07'),(1324,10,'Bihar','195','Darbhanga','2024-10-07'),(60,19,'West Bengal','309','Darjeeling','2024-10-07'),(636,18,'Assam','283','Darrang','2024-10-07'),(374,23,'Madhya Pradesh','401','Datia','2024-10-07'),(1326,8,'Rajasthan','97','Dausa','2024-10-07'),(62,29,'Karnataka','535','Davangere','2024-10-07'),(1328,8,'Rajasthan','767','Deeg','2024-10-07'),(638,5,'Uttarakhand','49','Dehradun','2024-10-07'),(640,21,'Odisha','351','Deogarh','2024-10-07'),(988,20,'Jharkhand','324','Deoghar','2024-10-07'),(1330,9,'Uttar Pradesh','137','Deoria','2024-10-07'),(990,24,'Gujarat','674','Devbhumi Dwarka','2024-10-07'),(1332,23,'Madhya Pradesh','402','Dewas','2024-10-07'),(64,16,'Tripura','269','Dhalai','2024-10-07'),(992,22,'Chhattisgarh','377','Dhamtari','2024-10-07'),(376,20,'Jharkhand','325','Dhanbad','2024-10-07'),(1334,23,'Madhya Pradesh','403','Dhar','2024-10-07'),(1336,27,'Maharashtra','488','Dharashiv','2024-10-07'),(378,33,'Tamil Nadu','571','Dharmapuri','2024-10-07'),(380,29,'Karnataka','536','Dharwad','2024-10-07'),(642,18,'Assam','284','Dhemaji','2024-10-07'),(66,21,'Odisha','352','Dhenkanal','2024-10-07'),(382,8,'Rajasthan','98','Dholpur','2024-10-07'),(644,18,'Assam','285','Dhubri','2024-10-07'),(1338,27,'Maharashtra','474','Dhule','2024-10-07'),(646,12,'Arunachal Pradesh','230','Dibang Valley','2024-10-07'),(384,18,'Assam','286','Dibrugarh','2024-10-07'),(648,8,'Rajasthan','768','Didwana-Kuchaman','2024-10-07'),(994,18,'Assam','299','Dima Hasao','2024-10-07'),(650,13,'Nagaland','244','Dimapur','2024-10-07'),(652,33,'Tamil Nadu','572','Dindigul','2024-10-07'),(68,23,'Madhya Pradesh','404','Dindori','2024-10-07'),(654,38,'The Dadra And Nagar Haveli And Daman And Diu','464','Diu','2024-10-07'),(656,1,'Jammu And Kashmir','4','Doda','2024-10-07'),(1340,28,'Andhra Pradesh','747','Dr. B.R. Ambedkar Konaseema','2024-10-07'),(70,8,'Rajasthan','769','Dudu','2024-10-07'),(996,20,'Jharkhand','326','Dumka','2024-10-07'),(658,8,'Rajasthan','99','Dungarpur','2024-10-07'),(386,22,'Chhattisgarh','378','Durg','2024-10-07'),(998,7,'Delhi','78','East','2024-10-07'),(388,17,'Meghalaya','273','East Garo Hills','2024-10-07'),(1002,28,'Andhra Pradesh','505','East Godavari','2024-10-07'),(72,17,'Meghalaya','657','East Jaintia Hills','2024-10-07'),(1342,12,'Arunachal Pradesh','231','East Kameng','2024-10-07'),(1004,17,'Meghalaya','274','East Khasi Hills','2024-10-07'),(660,12,'Arunachal Pradesh','232','East Siang','2024-10-07'),(1006,20,'Jharkhand','327','East Singhbum','2024-10-07'),(1000,17,'Meghalaya','740','Eastern West Khasi Hills','2024-10-07'),(74,28,'Andhra Pradesh','748','Eluru','2024-10-07'),(662,32,'Kerala','555','Ernakulam','2024-10-07'),(76,33,'Tamil Nadu','573','Erode','2024-10-07'),(664,9,'Uttar Pradesh','138','Etah','2024-10-07'),(1344,9,'Uttar Pradesh','139','Etawah','2024-10-07'),(1346,6,'Haryana','60','Faridabad','2024-10-07'),(390,3,'Punjab','29','Faridkot','2024-10-07'),(666,9,'Uttar Pradesh','141','Farrukhabad','2024-10-07'),(668,6,'Haryana','61','Fatehabad','2024-10-07'),(392,3,'Punjab','30','Fatehgarh Sahib','2024-10-07'),(670,9,'Uttar Pradesh','142','Fatehpur','2024-10-07'),(78,3,'Punjab','651','Fazilka','2024-10-07'),(80,3,'Punjab','31','Ferozepur','2024-10-07'),(1348,9,'Uttar Pradesh','143','Firozabad','2024-10-07'),(672,29,'Karnataka','537','Gadag','2024-10-07'),(1008,27,'Maharashtra','475','Gadchiroli','2024-10-07'),(1010,21,'Odisha','353','Gajapati','2024-10-07'),(1012,1,'Jammu And Kashmir','626','Ganderbal','2024-10-07'),(82,24,'Gujarat','446','Gandhinagar','2024-10-07'),(1350,8,'Rajasthan','100','Ganganagar','2024-10-07'),(674,8,'Rajasthan','771','Gangapurcity','2024-10-07'),(676,11,'Sikkim','225','Gangtok','2024-10-07'),(394,21,'Odisha','354','Ganjam','2024-10-07'),(84,20,'Jharkhand','328','Garhwa','2024-10-07'),(86,22,'Chhattisgarh','645','Gariyaband','2024-10-07'),(1014,22,'Chhattisgarh','734','Gaurela-Pendra-Marwahi','2024-10-07'),(396,9,'Uttar Pradesh','144','Gautam Buddha Nagar','2024-10-07'),(88,10,'Bihar','196','Gaya','2024-10-07'),(678,9,'Uttar Pradesh','145','Ghaziabad','2024-10-07'),(398,9,'Uttar Pradesh','146','Ghazipur','2024-10-07'),(1018,24,'Gujarat','675','Gir Somnath','2024-10-07'),(1016,20,'Jharkhand','329','Giridih','2024-10-07'),(1020,18,'Assam','287','Goalpara','2024-10-07'),(400,20,'Jharkhand','330','Godda','2024-10-07'),(1352,18,'Assam','288','Golaghat','2024-10-07'),(90,16,'Tripura','654','Gomati','2024-10-07'),(680,9,'Uttar Pradesh','147','Gonda','2024-10-07'),(1022,27,'Maharashtra','476','Gondia','2024-10-07'),(682,10,'Bihar','197','Gopalganj','2024-10-07'),(1354,9,'Uttar Pradesh','148','Gorakhpur','2024-10-07'),(92,20,'Jharkhand','331','Gumla','2024-10-07'),(1356,23,'Madhya Pradesh','406','Guna','2024-10-07'),(1024,28,'Andhra Pradesh','506','Guntur','2024-10-07'),(684,3,'Punjab','32','Gurdaspur','2024-10-07'),(402,6,'Haryana','62','Gurugram','2024-10-07'),(686,23,'Madhya Pradesh','407','Gwalior','2024-10-07'),(1358,11,'Sikkim','228','Gyalshing','2024-10-07'),(688,18,'Assam','289','Hailakandi','2024-10-07'),(94,2,'Himachal Pradesh','17','Hamirpur','2024-10-07'),(1360,9,'Uttar Pradesh','149','Hamirpur','2024-10-07'),(96,36,'Telangana','686','Hanumakonda','2024-10-07'),(690,8,'Rajasthan','101','Hanumangarh','2024-10-07'),(404,9,'Uttar Pradesh','661','Hapur','2024-10-07'),(98,23,'Madhya Pradesh','408','Harda','2024-10-07'),(692,9,'Uttar Pradesh','150','Hardoi','2024-10-07'),(100,5,'Uttarakhand','50','Haridwar','2024-10-07'),(102,29,'Karnataka','539','Hassan','2024-10-07'),(406,9,'Uttar Pradesh','163','Hathras','2024-10-07'),(408,29,'Karnataka','540','Haveri','2024-10-07'),(694,20,'Jharkhand','332','Hazaribagh','2024-10-07'),(696,27,'Maharashtra','477','Hingoli','2024-10-07'),(410,6,'Haryana','63','Hisar','2024-10-07'),(412,15,'Mizoram','726','Hnahthial','2024-10-07'),(1026,18,'Assam','709','Hojai','2024-10-07'),(1028,19,'West Bengal','312','Hooghly','2024-10-07'),(1030,3,'Punjab','33','Hoshiarpur','2024-10-07'),(1032,19,'West Bengal','313','Howrah','2024-10-07'),(414,36,'Telangana','507','Hyderabad','2024-10-07'),(1362,32,'Kerala','556','Idukki','2024-10-07'),(1364,14,'Manipur','255','Imphal East','2024-10-07'),(1034,14,'Manipur','256','Imphal West','2024-10-07'),(1366,23,'Madhya Pradesh','410','Indore','2024-10-07'),(1036,23,'Madhya Pradesh','411','Jabalpur','2024-10-07'),(104,21,'Odisha','355','Jagatsinghapur','2024-10-07'),(698,36,'Telangana','681','Jagitial','2024-10-07'),(106,8,'Rajasthan','102','Jaipur','2024-10-07'),(1368,8,'Rajasthan','783','Jaipur (Gramin)','2024-10-07'),(1370,8,'Rajasthan','103','Jaisalmer','2024-10-07'),(700,21,'Odisha','356','Jajapur','2024-10-07'),(1038,3,'Punjab','34','Jalandhar','2024-10-07'),(416,9,'Uttar Pradesh','151','Jalaun','2024-10-07'),(1040,27,'Maharashtra','478','Jalgaon','2024-10-07'),(418,27,'Maharashtra','479','Jalna','2024-10-07'),(108,8,'Rajasthan','104','Jalore','2024-10-07'),(110,19,'West Bengal','314','Jalpaiguri','2024-10-07'),(1042,1,'Jammu And Kashmir','5','Jammu','2024-10-07'),(420,24,'Gujarat','447','Jamnagar','2024-10-07'),(702,20,'Jharkhand','333','Jamtara','2024-10-07'),(704,10,'Bihar','198','Jamui','2024-10-07'),(1372,36,'Telangana','689','Jangoan','2024-10-07'),(706,22,'Chhattisgarh','379','Janjgir-Champa','2024-10-07'),(422,22,'Chhattisgarh','380','Jashpur','2024-10-07'),(1374,9,'Uttar Pradesh','152','Jaunpur','2024-10-07'),(112,36,'Telangana','687','Jayashankar Bhupalapally','2024-10-07'),(708,10,'Bihar','199','Jehanabad','2024-10-07'),(424,23,'Madhya Pradesh','412','Jhabua','2024-10-07'),(1376,6,'Haryana','64','Jhajjar','2024-10-07'),(114,8,'Rajasthan','105','Jhalawar','2024-10-07'),(116,9,'Uttar Pradesh','153','Jhansi','2024-10-07'),(710,19,'West Bengal','703','Jhargram','2024-10-07'),(118,21,'Odisha','357','Jharsuguda','2024-10-07'),(1044,8,'Rajasthan','106','Jhunjhunu','2024-10-07'),(426,6,'Haryana','65','Jind','2024-10-07'),(428,14,'Manipur','713','Jiribam','2024-10-07'),(430,8,'Rajasthan','107','Jodhpur','2024-10-07'),(432,8,'Rajasthan','778','Jodhpur (Gramin)','2024-10-07'),(1046,36,'Telangana','695','Jogulamba Gadwal','2024-10-07'),(434,18,'Assam','290','Jorhat','2024-10-07'),(1378,24,'Gujarat','448','Junagadh','2024-10-07'),(120,22,'Chhattisgarh','382','Kabeerdham','2024-10-07'),(436,24,'Gujarat','449','Kachchh','2024-10-07'),(712,10,'Bihar','200','Kaimur (Bhabua)','2024-10-07'),(1380,6,'Haryana','66','Kaithal','2024-10-07'),(1048,14,'Manipur','711','Kakching','2024-10-07'),(438,28,'Andhra Pradesh','746','Kakinada','2024-10-07'),(1050,29,'Karnataka','538','Kalaburagi','2024-10-07'),(440,21,'Odisha','358','Kalahandi','2024-10-07'),(122,19,'West Bengal','702','Kalimpong','2024-10-07'),(442,33,'Tamil Nadu','729','Kallakurichi','2024-10-07'),(444,36,'Telangana','685','Kamareddy','2024-10-07'),(1052,14,'Manipur','717','Kamjong','2024-10-07'),(1382,12,'Arunachal Pradesh','718','Kamle','2024-10-07'),(1054,18,'Assam','291','Kamrup','2024-10-07'),(446,18,'Assam','618','Kamrup Metro','2024-10-07'),(714,33,'Tamil Nadu','574','Kancheepuram','2024-10-07'),(716,21,'Odisha','359','Kandhamal','2024-10-07'),(1056,14,'Manipur','712','Kangpokpi','2024-10-07'),(718,2,'Himachal Pradesh','18','Kangra','2024-10-07'),(720,9,'Uttar Pradesh','155','Kannauj','2024-10-07'),(1384,33,'Tamil Nadu','575','Kanniyakumari','2024-10-07'),(448,32,'Kerala','557','Kannur','2024-10-07'),(124,9,'Uttar Pradesh','156','Kanpur Dehat','2024-10-07'),(450,9,'Uttar Pradesh','157','Kanpur Nagar','2024-10-07'),(452,3,'Punjab','35','Kapurthala','2024-10-07'),(1386,34,'Puducherry','598','Karaikal','2024-10-07'),(126,8,'Rajasthan','108','Karauli','2024-10-07'),(1058,18,'Assam','292','Karbi Anglong','2024-10-07'),(454,37,'Ladakh','6','Kargil','2024-10-07'),(1388,18,'Assam','293','Karimganj','2024-10-07'),(128,36,'Telangana','508','Karimnagar','2024-10-07'),(722,6,'Haryana','67','Karnal','2024-10-07'),(456,33,'Tamil Nadu','576','Karur','2024-10-07'),(1060,32,'Kerala','558','Kasaragod','2024-10-07'),(724,9,'Uttar Pradesh','633','Kasganj','2024-10-07'),(458,1,'Jammu And Kashmir','7','Kathua','2024-10-07'),(130,10,'Bihar','201','Katihar','2024-10-07'),(726,23,'Madhya Pradesh','413','Katni','2024-10-07'),(1390,9,'Uttar Pradesh','158','Kaushambi','2024-10-07'),(1392,8,'Rajasthan','781','Kekri','2024-10-07'),(132,21,'Odisha','360','Kendrapara','2024-10-07'),(1394,21,'Odisha','361','Kendujhar','2024-10-07'),(728,10,'Bihar','202','Khagaria','2024-10-07'),(1396,22,'Chhattisgarh','759','Khairagarh-Chhuikhadan-Gandai','2024-10-07'),(460,8,'Rajasthan','770','Khairthal-Tijara','2024-10-07'),(1062,36,'Telangana','509','Khammam','2024-10-07'),(462,23,'Madhya Pradesh','405','Khandwa (East Nimar)','2024-10-07'),(134,23,'Madhya Pradesh','414','Khargone (West Nimar)','2024-10-07'),(1064,15,'Mizoram','728','Khawzawl','2024-10-07'),(136,24,'Gujarat','450','Kheda','2024-10-07'),(138,9,'Uttar Pradesh','159','Kheri','2024-10-07'),(1066,21,'Odisha','362','Khordha','2024-10-07'),(140,16,'Tripura','652','Khowai','2024-10-07'),(142,20,'Jharkhand','606','Khunti','2024-10-07'),(730,2,'Himachal Pradesh','19','Kinnaur','2024-10-07'),(732,13,'Nagaland','614','Kiphire','2024-10-07'),(734,10,'Bihar','203','Kishanganj','2024-10-07'),(144,1,'Jammu And Kashmir','620','Kishtwar','2024-10-07'),(1068,29,'Karnataka','541','Kodagu','2024-10-07'),(736,20,'Jharkhand','334','Koderma','2024-10-07'),(1398,13,'Nagaland','245','Kohima','2024-10-07'),(1400,18,'Assam','294','Kokrajhar','2024-10-07'),(464,29,'Karnataka','542','Kolar','2024-10-07'),(146,15,'Mizoram','263','Kolasib','2024-10-07'),(1402,27,'Maharashtra','480','Kolhapur','2024-10-07'),(148,19,'West Bengal','315','Kolkata','2024-10-07'),(150,32,'Kerala','559','Kollam','2024-10-07'),(1404,22,'Chhattisgarh','643','Kondagaon','2024-10-07'),(738,29,'Karnataka','543','Koppal','2024-10-07'),(1070,21,'Odisha','363','Koraput','2024-10-07'),(1072,22,'Chhattisgarh','383','Korba','2024-10-07'),(1074,22,'Chhattisgarh','384','Korea','2024-10-07'),(152,8,'Rajasthan','109','Kota','2024-10-07'),(740,8,'Rajasthan','782','Kotputli-Behror','2024-10-07'),(742,32,'Kerala','560','Kottayam','2024-10-07'),(744,32,'Kerala','561','Kozhikode','2024-10-07'),(1076,12,'Arunachal Pradesh','677','Kra Daadi','2024-10-07'),(746,28,'Andhra Pradesh','510','Krishna','2024-10-07'),(1078,33,'Tamil Nadu','577','Krishnagiri','2024-10-07'),(748,1,'Jammu And Kashmir','622','Kulgam','2024-10-07'),(1406,2,'Himachal Pradesh','20','Kullu','2024-10-07'),(466,36,'Telangana','699','Kumuram Bheem Asifabad','2024-10-07'),(750,1,'Jammu And Kashmir','8','Kupwara','2024-10-07'),(752,28,'Andhra Pradesh','511','Kurnool','2024-10-07'),(1080,6,'Haryana','68','Kurukshetra','2024-10-07'),(1408,12,'Arunachal Pradesh','233','Kurung Kumey','2024-10-07'),(154,9,'Uttar Pradesh','160','Kushinagar','2024-10-07'),(1082,2,'Himachal Pradesh','21','Lahaul And Spiti','2024-10-07'),(1084,18,'Assam','295','Lakhimpur','2024-10-07'),(754,10,'Bihar','204','Lakhisarai','2024-10-07'),(156,31,'Lakshadweep','553','Lakshadweep District','2024-10-07'),(158,9,'Uttar Pradesh','161','Lalitpur','2024-10-07'),(160,20,'Jharkhand','335','Latehar','2024-10-07'),(756,27,'Maharashtra','481','Latur','2024-10-07'),(468,15,'Mizoram','264','Lawngtlai','2024-10-07'),(1410,37,'Ladakh','9','Leh Ladakh','2024-10-07'),(1086,12,'Arunachal Pradesh','724','Leparada','2024-10-07'),(470,20,'Jharkhand','336','Lohardaga','2024-10-07'),(162,12,'Arunachal Pradesh','234','Lohit','2024-10-07'),(1088,12,'Arunachal Pradesh','666','Longding','2024-10-07'),(164,13,'Nagaland','615','Longleng','2024-10-07'),(472,12,'Arunachal Pradesh','235','Lower Dibang Valley','2024-10-07'),(474,12,'Arunachal Pradesh','719','Lower Siang','2024-10-07'),(1090,12,'Arunachal Pradesh','236','Lower Subansiri','2024-10-07'),(1412,9,'Uttar Pradesh','162','Lucknow','2024-10-07'),(1092,3,'Punjab','36','Ludhiana','2024-10-07'),(758,15,'Mizoram','265','Lunglei','2024-10-07'),(1414,10,'Bihar','205','Madhepura','2024-10-07'),(166,10,'Bihar','206','Madhubani','2024-10-07'),(168,33,'Tamil Nadu','578','Madurai','2024-10-07'),(760,36,'Telangana','688','Mahabubabad','2024-10-07'),(1094,36,'Telangana','512','Mahabubnagar','2024-10-07'),(1096,22,'Chhattisgarh','385','Mahasamund','2024-10-07'),(1098,34,'Puducherry','599','Mahe','2024-10-07'),(170,6,'Haryana','69','Mahendragarh','2024-10-07'),(762,24,'Gujarat','451','Mahesana','2024-10-07'),(172,24,'Gujarat','669','Mahisagar','2024-10-07'),(476,9,'Uttar Pradesh','165','Mahoba','2024-10-07'),(764,9,'Uttar Pradesh','164','Mahrajganj','2024-10-07'),(174,23,'Madhya Pradesh','784','Maihar','2024-10-07'),(176,9,'Uttar Pradesh','166','Mainpuri','2024-10-07'),(178,18,'Assam','706','Majuli','2024-10-07'),(180,32,'Kerala','562','Malappuram','2024-10-07'),(182,19,'West Bengal','316','Malda','2024-10-07'),(1416,3,'Punjab','737','Malerkotla','2024-10-07'),(184,21,'Odisha','364','Malkangiri','2024-10-07'),(766,15,'Mizoram','266','Mamit','2024-10-07'),(186,36,'Telangana','684','Mancherial','2024-10-07'),(768,2,'Himachal Pradesh','22','Mandi','2024-10-07'),(478,23,'Madhya Pradesh','415','Mandla','2024-10-07'),(1100,23,'Madhya Pradesh','416','Mandsaur','2024-10-07'),(1102,29,'Karnataka','544','Mandya','2024-10-07'),(770,22,'Chhattisgarh','760','Manendragarh-Chirmiri-Bharatpur(M C B)','2024-10-07'),(1418,11,'Sikkim','226','Mangan','2024-10-07'),(1420,3,'Punjab','37','Mansa','2024-10-07'),(1422,18,'Assam','296','Marigaon','2024-10-07'),(1424,9,'Uttar Pradesh','167','Mathura','2024-10-07'),(188,9,'Uttar Pradesh','168','Mau','2024-10-07'),(1104,23,'Madhya Pradesh','766','MAUGANJ','2024-10-07'),(480,33,'Tamil Nadu','735','Mayiladuthurai','2024-10-07'),(772,21,'Odisha','365','Mayurbhanj','2024-10-07'),(482,36,'Telangana','513','Medak','2024-10-07'),(774,36,'Telangana','700','Medchal Malkajgiri','2024-10-07'),(1426,9,'Uttar Pradesh','169','Meerut','2024-10-07'),(484,9,'Uttar Pradesh','170','Mirzapur','2024-10-07'),(1428,3,'Punjab','38','Moga','2024-10-07'),(1106,22,'Chhattisgarh','761','Mohla-Manpur-Ambagarh Chouki','2024-10-07'),(486,13,'Nagaland','246','Mokokchung','2024-10-07'),(190,13,'Nagaland','247','Mon','2024-10-07'),(488,9,'Uttar Pradesh','171','Moradabad','2024-10-07'),(490,24,'Gujarat','673','Morbi','2024-10-07'),(776,23,'Madhya Pradesh','417','Morena','2024-10-07'),(192,36,'Telangana','720','Mulugu','2024-10-07'),(492,27,'Maharashtra','482','Mumbai','2024-10-07'),(494,27,'Maharashtra','483','Mumbai Suburban','2024-10-07'),(1430,22,'Chhattisgarh','647','Mungeli','2024-10-07'),(194,10,'Bihar','207','Munger','2024-10-07'),(778,19,'West Bengal','319','Murshidabad','2024-10-07'),(1432,9,'Uttar Pradesh','172','Muzaffarnagar','2024-10-07'),(1434,10,'Bihar','208','Muzaffarpur','2024-10-07'),(196,29,'Karnataka','545','Mysuru','2024-10-07'),(780,21,'Odisha','366','Nabarangpur','2024-10-07'),(782,19,'West Bengal','320','Nadia','2024-10-07'),(1108,18,'Assam','297','Nagaon','2024-10-07'),(198,33,'Tamil Nadu','579','Nagapattinam','2024-10-07'),(496,36,'Telangana','694','Nagarkurnool','2024-10-07'),(1436,8,'Rajasthan','110','Nagaur','2024-10-07'),(200,27,'Maharashtra','484','Nagpur','2024-10-07'),(202,5,'Uttarakhand','51','Nainital','2024-10-07'),(498,10,'Bihar','209','Nalanda','2024-10-07'),(1110,18,'Assam','298','Nalbari','2024-10-07'),(500,36,'Telangana','514','Nalgonda','2024-10-07'),(1112,33,'Tamil Nadu','580','Namakkal','2024-10-07'),(1438,11,'Sikkim','227','Namchi','2024-10-07'),(1114,12,'Arunachal Pradesh','678','Namsai','2024-10-07'),(784,27,'Maharashtra','485','Nanded','2024-10-07'),(786,27,'Maharashtra','486','Nandurbar','2024-10-07'),(1116,28,'Andhra Pradesh','755','Nandyal','2024-10-07'),(788,36,'Telangana','721','Narayanpet','2024-10-07'),(1440,22,'Chhattisgarh','637','Narayanpur','2024-10-07'),(1442,24,'Gujarat','452','Narmada','2024-10-07'),(204,23,'Madhya Pradesh','409','Narmadapuram','2024-10-07'),(790,23,'Madhya Pradesh','418','Narsimhapur','2024-10-07'),(206,27,'Maharashtra','487','Nashik','2024-10-07'),(208,24,'Gujarat','453','Navsari','2024-10-07'),(502,10,'Bihar','210','Nawada','2024-10-07'),(1444,21,'Odisha','367','Nayagarh','2024-10-07'),(1118,8,'Rajasthan','773','Neem Ka Thana','2024-10-07'),(792,23,'Madhya Pradesh','419','Neemuch','2024-10-07'),(1120,7,'Delhi','79','New Delhi','2024-10-07'),(794,35,'Andaman And Nicobar Islands','603','Nicobars','2024-10-07'),(796,36,'Telangana','680','Nirmal','2024-10-07'),(1446,13,'Nagaland','764','Niuland','2024-10-07'),(798,23,'Madhya Pradesh','722','Niwari','2024-10-07'),(800,36,'Telangana','516','Nizamabad','2024-10-07'),(802,13,'Nagaland','736','Noklak','2024-10-07'),(210,14,'Manipur','714','Noney','2024-10-07'),(504,7,'Delhi','80','North','2024-10-07'),(1448,19,'West Bengal','303','North 24 Parganas','2024-10-07'),(1450,35,'Andaman And Nicobar Islands','632','North And Middle Andaman','2024-10-07'),(212,7,'Delhi','81','North East','2024-10-07'),(1452,17,'Meghalaya','656','North Garo Hills','2024-10-07'),(804,30,'Goa','551','North Goa','2024-10-07'),(214,16,'Tripura','270','North Tripura','2024-10-07'),(506,7,'Delhi','82','North West','2024-10-07'),(216,28,'Andhra Pradesh','749','Ntr','2024-10-07'),(1122,21,'Odisha','368','Nuapada','2024-10-07'),(1454,6,'Haryana','604','Nuh','2024-10-07'),(806,12,'Arunachal Pradesh','723','Pakke Kessang','2024-10-07'),(808,20,'Jharkhand','337','Pakur','2024-10-07'),(1456,11,'Sikkim','741','Pakyong','2024-10-07'),(218,32,'Kerala','563','Palakkad','2024-10-07'),(220,20,'Jharkhand','338','Palamu','2024-10-07'),(222,27,'Maharashtra','665','Palghar','2024-10-07'),(1458,8,'Rajasthan','111','Pali','2024-10-07'),(1460,28,'Andhra Pradesh','751','Palnadu','2024-10-07'),(1462,6,'Haryana','619','Palwal','2024-10-07'),(1124,24,'Gujarat','454','Panch Mahals','2024-10-07'),(224,6,'Haryana','70','Panchkula','2024-10-07'),(810,23,'Madhya Pradesh','785','Pandhurna','2024-10-07'),(226,6,'Haryana','71','Panipat','2024-10-07'),(1464,23,'Madhya Pradesh','420','Panna','2024-10-07'),(508,12,'Arunachal Pradesh','237','Papum Pare','2024-10-07'),(812,27,'Maharashtra','489','Parbhani','2024-10-07'),(228,28,'Andhra Pradesh','743','Parvathipuram Manyam','2024-10-07'),(814,19,'West Bengal','704','Paschim Bardhaman','2024-10-07'),(816,19,'West Bengal','318','Paschim Medinipur','2024-10-07'),(1126,10,'Bihar','211','Pashchim Champaran','2024-10-07'),(1128,24,'Gujarat','455','Patan','2024-10-07'),(510,32,'Kerala','564','Pathanamthitta','2024-10-07'),(230,3,'Punjab','662','Pathankot','2024-10-07'),(818,3,'Punjab','41','Patiala','2024-10-07'),(820,10,'Bihar','212','Patna','2024-10-07'),(1466,5,'Uttarakhand','52','Pauri Garhwal','2024-10-07'),(822,36,'Telangana','682','Peddapalli','2024-10-07'),(1130,33,'Tamil Nadu','581','Perambalur','2024-10-07'),(1132,13,'Nagaland','613','Peren','2024-10-07'),(1468,8,'Rajasthan','772','Phalodi','2024-10-07'),(1134,13,'Nagaland','248','Phek','2024-10-07'),(1136,14,'Manipur','715','Pherzawl','2024-10-07'),(1470,9,'Uttar Pradesh','173','Pilibhit','2024-10-07'),(232,5,'Uttarakhand','53','Pithoragarh','2024-10-07'),(824,1,'Jammu And Kashmir','10','Poonch','2024-10-07'),(512,24,'Gujarat','456','Porbandar','2024-10-07'),(1138,28,'Andhra Pradesh','517','Prakasam','2024-10-07'),(1140,8,'Rajasthan','629','Pratapgarh','2024-10-07'),(826,9,'Uttar Pradesh','174','Pratapgarh','2024-10-07'),(514,9,'Uttar Pradesh','120','Prayagraj','2024-10-07'),(828,34,'Puducherry','600','Puducherry','2024-10-07'),(1142,33,'Tamil Nadu','582','Pudukkottai','2024-10-07'),(830,1,'Jammu And Kashmir','11','Pulwama','2024-10-07'),(832,27,'Maharashtra','490','Pune','2024-10-07'),(1472,19,'West Bengal','306','Purba Bardhaman','2024-10-07'),(1144,19,'West Bengal','317','Purba Medinipur','2024-10-07'),(234,10,'Bihar','213','Purbi Champaran','2024-10-07'),(236,21,'Odisha','369','Puri','2024-10-07'),(1146,10,'Bihar','214','Purnia','2024-10-07'),(1148,19,'West Bengal','321','Purulia','2024-10-07'),(516,9,'Uttar Pradesh','175','Rae Bareli','2024-10-07'),(518,29,'Karnataka','546','Raichur','2024-10-07'),(834,27,'Maharashtra','491','Raigad','2024-10-07'),(836,22,'Chhattisgarh','386','Raigarh','2024-10-07'),(838,22,'Chhattisgarh','387','Raipur','2024-10-07'),(238,23,'Madhya Pradesh','421','Raisen','2024-10-07'),(520,36,'Telangana','683','Rajanna Sircilla','2024-10-07'),(840,23,'Madhya Pradesh','422','Rajgarh','2024-10-07'),(1474,24,'Gujarat','457','Rajkot','2024-10-07'),(1150,22,'Chhattisgarh','388','Rajnandgaon','2024-10-07'),(842,1,'Jammu And Kashmir','12','Rajouri','2024-10-07'),(1152,8,'Rajasthan','112','Rajsamand','2024-10-07'),(1476,29,'Karnataka','631','Ramanagara','2024-10-07'),(1154,33,'Tamil Nadu','583','Ramanathapuram','2024-10-07'),(522,1,'Jammu And Kashmir','621','Ramban','2024-10-07'),(1478,20,'Jharkhand','607','Ramgarh','2024-10-07'),(1480,9,'Uttar Pradesh','176','Rampur','2024-10-07'),(1156,20,'Jharkhand','339','Ranchi','2024-10-07'),(240,36,'Telangana','518','Ranga Reddy','2024-10-07'),(1482,33,'Tamil Nadu','731','Ranipet','2024-10-07'),(524,23,'Madhya Pradesh','423','Ratlam','2024-10-07'),(1158,27,'Maharashtra','492','Ratnagiri','2024-10-07'),(1160,21,'Odisha','370','Rayagada','2024-10-07'),(242,1,'Jammu And Kashmir','627','Reasi','2024-10-07'),(1484,23,'Madhya Pradesh','424','Rewa','2024-10-07'),(526,6,'Haryana','72','Rewari','2024-10-07'),(528,17,'Meghalaya','276','Ri Bhoi','2024-10-07'),(530,6,'Haryana','73','Rohtak','2024-10-07'),(1486,10,'Bihar','215','Rohtas','2024-10-07'),(844,5,'Uttarakhand','54','Rudra Prayag','2024-10-07'),(1488,3,'Punjab','42','Rupnagar','2024-10-07'),(250,3,'Punjab','608','S.A.S Nagar','2024-10-07'),(846,24,'Gujarat','458','Sabar Kantha','2024-10-07'),(244,23,'Madhya Pradesh','425','Sagar','2024-10-07'),(848,9,'Uttar Pradesh','177','Saharanpur','2024-10-07'),(1162,10,'Bihar','216','Saharsa','2024-10-07'),(1164,20,'Jharkhand','340','Sahebganj','2024-10-07'),(850,15,'Mizoram','727','Saitual','2024-10-07'),(1166,22,'Chhattisgarh','762','Sakti','2024-10-07'),(852,33,'Tamil Nadu','584','Salem','2024-10-07'),(854,8,'Rajasthan','777','Salumbar','2024-10-07'),(246,10,'Bihar','217','Samastipur','2024-10-07'),(532,1,'Jammu And Kashmir','624','Samba','2024-10-07'),(534,21,'Odisha','371','Sambalpur','2024-10-07'),(856,9,'Uttar Pradesh','659','Sambhal','2024-10-07'),(1490,8,'Rajasthan','779','Sanchore','2024-10-07'),(858,36,'Telangana','691','Sangareddy','2024-10-07'),(536,27,'Maharashtra','493','Sangli','2024-10-07'),(248,3,'Punjab','43','Sangrur','2024-10-07'),(1168,9,'Uttar Pradesh','178','Sant Kabir Nagar','2024-10-07'),(1170,20,'Jharkhand','341','Saraikela Kharsawan','2024-10-07'),(860,10,'Bihar','218','Saran','2024-10-07'),(862,22,'Chhattisgarh','763','Sarangarh-Bilaigarh','2024-10-07'),(1492,27,'Maharashtra','494','Satara','2024-10-07'),(864,23,'Madhya Pradesh','426','Satna','2024-10-07'),(1172,8,'Rajasthan','113','Sawai Madhopur','2024-10-07'),(538,23,'Madhya Pradesh','427','Sehore','2024-10-07'),(540,14,'Manipur','257','Senapati','2024-10-07'),(1494,23,'Madhya Pradesh','428','Seoni','2024-10-07'),(1174,16,'Tripura','653','Sepahijala','2024-10-07'),(1176,15,'Mizoram','268','Serchhip','2024-10-07'),(866,7,'Delhi','671','Shahdara','2024-10-07'),(1178,23,'Madhya Pradesh','429','Shahdol','2024-10-07'),(252,3,'Punjab','40','Shahid Bhagat Singh Nagar','2024-10-07'),(1496,9,'Uttar Pradesh','180','Shahjahanpur','2024-10-07'),(542,8,'Rajasthan','780','Shahpura','2024-10-07'),(1498,23,'Madhya Pradesh','430','Shajapur','2024-10-07'),(868,13,'Nagaland','765','Shamator','2024-10-07'),(870,9,'Uttar Pradesh','660','Shamli','2024-10-07'),(544,10,'Bihar','219','Sheikhpura','2024-10-07'),(1180,10,'Bihar','220','Sheohar','2024-10-07'),(1500,23,'Madhya Pradesh','431','Sheopur','2024-10-07'),(876,12,'Arunachal Pradesh','725','Shi Yomi','2024-10-07'),(872,2,'Himachal Pradesh','23','Shimla','2024-10-07'),(874,29,'Karnataka','547','Shivamogga','2024-10-07'),(1502,23,'Madhya Pradesh','432','Shivpuri','2024-10-07'),(1504,1,'Jammu And Kashmir','625','Shopian','2024-10-07'),(1182,9,'Uttar Pradesh','181','Shrawasti','2024-10-07'),(878,15,'Mizoram','267','Siaha','2024-10-07'),(546,12,'Arunachal Pradesh','679','Siang','2024-10-07'),(254,9,'Uttar Pradesh','182','Siddharthnagar','2024-10-07'),(548,36,'Telangana','692','Siddipet','2024-10-07'),(1506,23,'Madhya Pradesh','433','Sidhi','2024-10-07'),(256,8,'Rajasthan','114','Sikar','2024-10-07'),(1184,20,'Jharkhand','342','Simdega','2024-10-07'),(258,27,'Maharashtra','495','Sindhudurg','2024-10-07'),(1508,23,'Madhya Pradesh','638','Singrauli','2024-10-07'),(550,2,'Himachal Pradesh','24','Sirmaur','2024-10-07'),(260,8,'Rajasthan','115','Sirohi','2024-10-07'),(262,6,'Haryana','74','Sirsa','2024-10-07'),(880,10,'Bihar','221','Sitamarhi','2024-10-07'),(1510,9,'Uttar Pradesh','183','Sitapur','2024-10-07'),(264,33,'Tamil Nadu','585','Sivaganga','2024-10-07'),(552,18,'Assam','300','Sivasagar','2024-10-07'),(1186,10,'Bihar','222','Siwan','2024-10-07'),(1188,2,'Himachal Pradesh','25','Solan','2024-10-07'),(1512,27,'Maharashtra','496','Solapur','2024-10-07'),(266,9,'Uttar Pradesh','184','Sonbhadra','2024-10-07'),(268,21,'Odisha','372','Sonepur','2024-10-07'),(882,6,'Haryana','75','Sonipat','2024-10-07'),(554,18,'Assam','301','Sonitpur','2024-10-07'),(1514,11,'Sikkim','742','Soreng','2024-10-07'),(1516,7,'Delhi','83','South','2024-10-07'),(270,19,'West Bengal','304','South 24 Parganas','2024-10-07'),(884,35,'Andaman And Nicobar Islands','602','South Andamans','2024-10-07'),(1190,7,'Delhi','670','South East','2024-10-07'),(886,17,'Meghalaya','277','South Garo Hills','2024-10-07'),(272,30,'Goa','552','South Goa','2024-10-07'),(1518,18,'Assam','707','South Salmara Mancachar','2024-10-07'),(556,16,'Tripura','271','South Tripura','2024-10-07'),(1192,7,'Delhi','84','South West','2024-10-07'),(1520,17,'Meghalaya','663','South West Garo Hills','2024-10-07'),(888,17,'Meghalaya','658','South West Khasi Hills','2024-10-07'),(890,3,'Punjab','39','Sri Muktsar Sahib','2024-10-07'),(894,28,'Andhra Pradesh','515','Sri Potti Sriramulu Nellore','2024-10-07'),(896,28,'Andhra Pradesh','754','Sri Sathya Sai','2024-10-07'),(1522,28,'Andhra Pradesh','519','Srikakulam','2024-10-07'),(892,1,'Jammu And Kashmir','13','Srinagar','2024-10-07'),(1524,22,'Chhattisgarh','642','Sukma','2024-10-07'),(558,9,'Uttar Pradesh','185','Sultanpur','2024-10-07'),(560,21,'Odisha','373','Sundargarh','2024-10-07'),(1526,10,'Bihar','223','Supaul','2024-10-07'),(1194,22,'Chhattisgarh','648','Surajpur','2024-10-07'),(562,24,'Gujarat','459','Surat','2024-10-07'),(564,24,'Gujarat','460','Surendranagar','2024-10-07'),(1196,22,'Chhattisgarh','389','Surguja','2024-10-07'),(274,36,'Telangana','696','Suryapet','2024-10-07'),(1198,14,'Manipur','258','Tamenglong','2024-10-07'),(1528,18,'Assam','756','Tamulpur','2024-10-07'),(898,24,'Gujarat','641','Tapi','2024-10-07'),(1200,3,'Punjab','609','Tarn Taran','2024-10-07'),(1202,12,'Arunachal Pradesh','238','Tawang','2024-10-07'),(1530,5,'Uttarakhand','55','Tehri Garhwal','2024-10-07'),(276,14,'Manipur','716','Tengnoupal','2024-10-07'),(1204,33,'Tamil Nadu','733','Tenkasi','2024-10-07'),(1532,27,'Maharashtra','497','Thane','2024-10-07'),(1206,33,'Tamil Nadu','586','Thanjavur','2024-10-07'),(1208,33,'Tamil Nadu','587','The Nilgiris','2024-10-07'),(278,33,'Tamil Nadu','588','Theni','2024-10-07'),(900,33,'Tamil Nadu','589','Thiruvallur','2024-10-07'),(1534,32,'Kerala','565','Thiruvananthapuram','2024-10-07'),(280,33,'Tamil Nadu','590','Thiruvarur','2024-10-07'),(566,33,'Tamil Nadu','594','Thoothukkudi','2024-10-07'),(902,14,'Manipur','259','Thoubal','2024-10-07'),(568,32,'Kerala','566','Thrissur','2024-10-07'),(282,23,'Madhya Pradesh','434','Tikamgarh','2024-10-07'),(1210,18,'Assam','302','Tinsukia','2024-10-07'),(1212,12,'Arunachal Pradesh','239','Tirap','2024-10-07'),(1536,33,'Tamil Nadu','591','Tiruchirappalli','2024-10-07'),(904,33,'Tamil Nadu','592','Tirunelveli','2024-10-07'),(1214,33,'Tamil Nadu','732','Tirupathur','2024-10-07'),(570,28,'Andhra Pradesh','752','Tirupati','2024-10-07'),(1538,33,'Tamil Nadu','634','Tiruppur','2024-10-07'),(1540,33,'Tamil Nadu','593','Tiruvannamalai','2024-10-07'),(1216,8,'Rajasthan','116','Tonk','2024-10-07'),(906,13,'Nagaland','757','Tseminyu','2024-10-07'),(572,13,'Nagaland','249','Tuensang','2024-10-07'),(908,29,'Karnataka','548','Tumakuru','2024-10-07'),(1542,8,'Rajasthan','117','Udaipur','2024-10-07'),(1544,18,'Assam','617','Udalguri','2024-10-07'),(574,5,'Uttarakhand','56','Udam Singh Nagar','2024-10-07'),(576,1,'Jammu And Kashmir','14','Udhampur','2024-10-07'),(1218,29,'Karnataka','549','Udupi','2024-10-07'),(578,23,'Madhya Pradesh','435','Ujjain','2024-10-07'),(1220,14,'Manipur','260','Ukhrul','2024-10-07'),(910,23,'Madhya Pradesh','436','Umaria','2024-10-07'),(1222,2,'Himachal Pradesh','26','Una','2024-10-07'),(284,16,'Tripura','655','Unakoti','2024-10-07'),(580,9,'Uttar Pradesh','186','Unnao','2024-10-07'),(1546,12,'Arunachal Pradesh','240','Upper Siang','2024-10-07'),(286,12,'Arunachal Pradesh','241','Upper Subansiri','2024-10-07'),(1224,22,'Chhattisgarh','381','Uttar Bastar Kanker','2024-10-07'),(582,19,'West Bengal','311','Uttar Dinajpur','2024-10-07'),(1550,5,'Uttarakhand','57','Uttar Kashi','2024-10-07'),(1548,29,'Karnataka','550','Uttara Kannada','2024-10-07'),(912,24,'Gujarat','461','Vadodara','2024-10-07'),(914,10,'Bihar','224','Vaishali','2024-10-07'),(916,24,'Gujarat','462','Valsad','2024-10-07'),(288,9,'Uttar Pradesh','187','Varanasi','2024-10-07'),(584,33,'Tamil Nadu','595','Vellore','2024-10-07'),(1226,23,'Madhya Pradesh','437','Vidisha','2024-10-07'),(1228,29,'Karnataka','738','Vijayanagar','2024-10-07'),(1230,29,'Karnataka','530','Vijayapura','2024-10-07'),(1232,36,'Telangana','698','Vikarabad','2024-10-07'),(918,33,'Tamil Nadu','596','Viluppuram','2024-10-07'),(290,33,'Tamil Nadu','597','Virudhunagar','2024-10-07'),(920,28,'Andhra Pradesh','520','Visakhapatnam','2024-10-07'),(922,28,'Andhra Pradesh','521','Vizianagaram','2024-10-07'),(586,36,'Telangana','693','Wanaparthy','2024-10-07'),(1552,36,'Telangana','522','Warangal','2024-10-07'),(292,27,'Maharashtra','498','Wardha','2024-10-07'),(1234,27,'Maharashtra','499','Washim','2024-10-07'),(1554,32,'Kerala','567','Wayanad','2024-10-07'),(924,7,'Delhi','85','West','2024-10-07'),(1556,17,'Meghalaya','278','West Garo Hills','2024-10-07'),(588,28,'Andhra Pradesh','523','West Godavari','2024-10-07'),(1558,17,'Meghalaya','275','West Jaintia Hills','2024-10-07'),(590,12,'Arunachal Pradesh','242','West Kameng','2024-10-07'),(1236,18,'Assam','710','West Karbi Anglong','2024-10-07'),(294,17,'Meghalaya','279','West Khasi Hills','2024-10-07'),(1560,12,'Arunachal Pradesh','243','West Siang','2024-10-07'),(1562,20,'Jharkhand','343','West Singhbhum','2024-10-07'),(296,16,'Tripura','272','West Tripura','2024-10-07'),(1238,13,'Nagaland','250','Wokha','2024-10-07'),(298,28,'Andhra Pradesh','504','Y.S.R.','2024-10-07'),(1564,36,'Telangana','697','Yadadri Bhuvanagiri','2024-10-07'),(1566,29,'Karnataka','635','Yadgir','2024-10-07'),(592,6,'Haryana','76','Yamunanagar','2024-10-07'),(1568,34,'Puducherry','601','Yanam','2024-10-07'),(594,27,'Maharashtra','500','Yavatmal','2024-10-07'),(1570,13,'Nagaland','251','Zunheboto','2024-10-07');
/*!40000 ALTER TABLE `district` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `education`
--

DROP TABLE IF EXISTS `education`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `education` (
  `Sno` int(11) NOT NULL AUTO_INCREMENT,
  `application_no` varchar(15) DEFAULT NULL,
  `qualification` varchar(50) DEFAULT NULL,
  `subject_` varchar(100) DEFAULT NULL,
  `passing_status` varchar(10) DEFAULT NULL,
  `passing_date` varchar(20) DEFAULT NULL,
  `boardName` varchar(150) DEFAULT NULL,
  `marking_scheme` varchar(10) DEFAULT NULL,
  `obtained_marks_CGPA` float DEFAULT NULL,
  `total_marks_CGPA` float DEFAULT NULL,
  `class_division` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`Sno`),
  KEY `application_no` (`application_no`),
  KEY `fk_education_qulification_idx` (`qualification`),
  CONSTRAINT `fk_education_personal` FOREIGN KEY (`application_no`) REFERENCES `personal` (`application_no`),
  CONSTRAINT `chk_class_division` CHECK (`class_division` in ('I','II','III','',0))
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `education`
--

LOCK TABLES `education` WRITE;
/*!40000 ALTER TABLE `education` DISABLE KEYS */;
INSERT INTO `education` VALUES (1,'100100740695','B.COM','dfsf','Pursuing','','dsfsdf','',0,0,'0'),(3,'100100767583','B.COM','ghghghg','Pass','2012-12-12','hghg hgf','per',689,76876,'I'),(4,'100100766784','B.COM','dsf','Pursuing','','lk','',0,0,'0'),(6,'100100771725','B.A.','dasd','Pursuing','','lk','',0,0,'0'),(9,'100100715151','B.COM','fdsfs','Pass','2025-09-02','dsfs','cgpa',24,34,'I'),(14,'100100754418','B.A.','fhfgh','Pass','2015-06-05','rtrtrtre','per',12,2121,'I'),(16,'100100754418','B.A.','thgfh','Pass','2015-06-05','efdf','per',456,546,'I'),(17,'100100710484','B.COM','dsfs','Pursuing','','dsfsd','',0,0,'0'),(18,'100100738703','B.A.','fgfgfdg','Pass','2015-03-04','gfgfgfg gh g ghgjj','per',56546,34654,'I');
/*!40000 ALTER TABLE `education` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `emp_data`
--

DROP TABLE IF EXISTS `emp_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `emp_data` (
  `SN` int(11) NOT NULL AUTO_INCREMENT,
  `application_no` varchar(14) DEFAULT NULL,
  `claim_years` varchar(45) DEFAULT NULL,
  `claim_months` varchar(45) DEFAULT NULL,
  `curr_emp` varchar(5) DEFAULT NULL,
  `org_type` varchar(30) DEFAULT NULL,
  `empyoment_type` varchar(30) DEFAULT NULL,
  `self_dec` tinyint(4) DEFAULT NULL,
  `contracual` varchar(5) DEFAULT NULL,
  `name_c` varchar(65) DEFAULT NULL,
  PRIMARY KEY (`SN`),
  KEY `fk_emp_personal` (`application_no`),
  CONSTRAINT `fk_emp_personal` FOREIGN KEY (`application_no`) REFERENCES `personal` (`application_no`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `emp_data`
--

LOCK TABLES `emp_data` WRITE;
/*!40000 ALTER TABLE `emp_data` DISABLE KEYS */;
INSERT INTO `emp_data` VALUES (2,'100100740695','11','0','No','','',0,'No',''),(4,'100100767583','6','0','No','','',0,'No',''),(5,'100100766784','7','0','No','','',0,'No',''),(7,'100100771725','11','0','No','','',0,'No',''),(8,'100100715151','11','0','Yes','Government Owned','Adhoc',0,'Yes','sadas'),(10,'100100754418','10','0','Yes','Government Owned','Regular',0,'Yes','vjnhjh'),(12,'100100738703','10','0','Yes','Autonomous','Visiting Fellow',0,'Yes','dcfdfcd'),(13,'100100710484','10','0','No','','',0,'No','');
/*!40000 ALTER TABLE `emp_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employment_type`
--

DROP TABLE IF EXISTS `employment_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employment_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `employment_type` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `employment_type_UNIQUE` (`employment_type`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employment_type`
--

LOCK TABLES `employment_type` WRITE;
/*!40000 ALTER TABLE `employment_type` DISABLE KEYS */;
INSERT INTO `employment_type` VALUES (4,'Adhoc'),(20,'Apprentice'),(24,'Casual'),(6,'Contract'),(22,'Part Time'),(26,'Per Diem'),(10,'Post Doctral Fellow'),(2,'Regular'),(14,'Research Associate'),(12,'Research fellow'),(8,'Temporary'),(18,'Trainee'),(16,'Visiting Fellow');
/*!40000 ALTER TABLE `employment_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `experiences`
--

DROP TABLE IF EXISTS `experiences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `experiences` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `application_no` varchar(15) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `type` varchar(100) DEFAULT NULL,
  `employment_type` varchar(100) DEFAULT NULL,
  `designation` varchar(255) NOT NULL,
  `from_date` varchar(30) NOT NULL,
  `to_date` varchar(30) NOT NULL,
  `duration` varchar(45) DEFAULT NULL,
  `experience` varchar(255) DEFAULT NULL,
  `totalDuration` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`totalDuration`)),
  PRIMARY KEY (`id`),
  KEY `application_no` (`application_no`),
  KEY `fk_experience_oraganisation` (`type`),
  KEY `fk_experience_employment` (`employment_type`),
  CONSTRAINT `fk_experience_employment` FOREIGN KEY (`employment_type`) REFERENCES `employment_type` (`employment_type`),
  CONSTRAINT `fk_experience_oraganisation` FOREIGN KEY (`type`) REFERENCES `organisation_type` (`organisation_type`),
  CONSTRAINT `fk_experience_personal` FOREIGN KEY (`application_no`) REFERENCES `personal` (`application_no`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `experiences`
--

LOCK TABLES `experiences` WRITE;
/*!40000 ALTER TABLE `experiences` DISABLE KEYS */;
INSERT INTO `experiences` VALUES (2,'100100740695','dfsd','Government Owned','Research fellow','dsfsdf','2010-08-04','2025-08-03','14 years 11 months 30 days','dsfs','{\"years\": 15, \"months\": 0, \"days\": 0}'),(3,'100100767583','fhgdh','Private','Part Time','hghgh','2013-02-12','2025-07-12','12 years 5 months 0 days','dgfgf g','{\"years\": 12, \"months\": 5, \"days\": 0}'),(4,'100100766784','dsfs','Government Owned','Adhoc','dsf','2017-05-09','2025-09-08','8 years 3 months 30 days','dsfsf','{\"years\": 8, \"months\": 4, \"days\": 0}'),(6,'100100771725','asdd','State Govt.','Research Associate','sadasdas','1999-01-07','2025-09-07','26 years 8 months 0 days','asdasd','{\"years\": 26, \"months\": 8, \"days\": 0}'),(7,'100100715151','sada','Government','Adhoc','sadad','2000-05-08','2025-09-22','25 years 4 months 14 days','asda','{\"years\": 25, \"months\": 4, \"days\": 14}'),(12,'100100754418','ththtr','Government','Regular','hgfhgfhf','2010-02-12','2015-05-06','5 years 2 months 24 days','dfdf','{\"years\": 5, \"months\": 2, \"days\": 24}'),(14,'100100754418','ghgfhgf','Central Govt.','Research Associate','ghgfh ','2016-06-05','2025-05-08','8 years 11 months 3 days','dfdfds','{\"years\": 14, \"months\": 1, \"days\": 27}'),(19,'100100738703','fgfg ','Joint Value','Part Time','tghtghf ','2010-03-23','2015-03-05','4 years 11 months 10 days','fgfdgfdgdf','{\"years\": 4, \"months\": 11, \"days\": 10}'),(21,'100100738703','fgfdg','State Govt.','Post Doctral Fellow','fgfdfd','2015-04-05','2025-05-06','10 years 1 months 1 days','dfdsfdsds','{\"years\": 15, \"months\": 0, \"days\": 11}'),(22,'100100710484','sdsa','Government Owned','Regular','sada','2003-05-05','2025-09-05','22 years 4 months 0 days','sad','{\"years\": 22, \"months\": 4, \"days\": 0}');
/*!40000 ALTER TABLE `experiences` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `identity_type`
--

DROP TABLE IF EXISTS `identity_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `identity_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identity_type` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `identity_type_UNIQUE` (`identity_type`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `identity_type`
--

LOCK TABLES `identity_type` WRITE;
/*!40000 ALTER TABLE `identity_type` DISABLE KEYS */;
INSERT INTO `identity_type` VALUES (2,'Aadhaar Card'),(8,'Other'),(4,'PAN Card'),(6,'Voter ID Card');
/*!40000 ALTER TABLE `identity_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `minority`
--

DROP TABLE IF EXISTS `minority`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `minority` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `minority_type` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `minority_type_UNIQUE` (`minority_type`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `minority`
--

LOCK TABLES `minority` WRITE;
/*!40000 ALTER TABLE `minority` DISABLE KEYS */;
INSERT INTO `minority` VALUES (2,'Buddhist'),(4,'Christian'),(6,'Jain'),(8,'Muslim'),(14,'Others'),(10,'Sikh'),(12,'Zoroastrians(Parsi)');
/*!40000 ALTER TABLE `minority` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nationality`
--

DROP TABLE IF EXISTS `nationality`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nationality` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nationality` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nationality_UNIQUE` (`nationality`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nationality`
--

LOCK TABLES `nationality` WRITE;
/*!40000 ALTER TABLE `nationality` DISABLE KEYS */;
INSERT INTO `nationality` VALUES (2,'Indian');
/*!40000 ALTER TABLE `nationality` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `newsflash`
--

DROP TABLE IF EXISTS `newsflash`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `newsflash` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` varchar(256) DEFAULT NULL,
  `flag` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_newsflash_id` (`id`),
  KEY `ix_newsflash_content` (`content`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `newsflash`
--

LOCK TABLES `newsflash` WRITE;
/*!40000 ALTER TABLE `newsflash` DISABLE KEYS */;
INSERT INTO `newsflash` VALUES (18,'Please read the full notification carefully before filling out the application form','2'),(19,'Attention Review all instructions and eligibility details before applying Ensure you submit your form within the specified dates','1');
/*!40000 ALTER TABLE `newsflash` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `organisation_type`
--

DROP TABLE IF EXISTS `organisation_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `organisation_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `organisation_type` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `organisation_type_UNIQUE` (`organisation_type`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `organisation_type`
--

LOCK TABLES `organisation_type` WRITE;
/*!40000 ALTER TABLE `organisation_type` DISABLE KEYS */;
INSERT INTO `organisation_type` VALUES (8,'Armed Forces'),(14,'Autonomous'),(6,'Central Govt.'),(2,'Government'),(4,'Government Owned'),(16,'Joint Value'),(18,'Private'),(12,'PSU(Central/States)'),(10,'State Govt.');
/*!40000 ALTER TABLE `organisation_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `other_info`
--

DROP TABLE IF EXISTS `other_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `other_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `application_no` varchar(16) NOT NULL,
  `justification` text DEFAULT NULL,
  `old_application_number` varchar(100) DEFAULT NULL,
  `any_other` varchar(3) DEFAULT NULL,
  `extra_information` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_other_info_id` (`id`),
  KEY `fk_other_personal_idx` (`application_no`),
  CONSTRAINT `fk_other_personal` FOREIGN KEY (`application_no`) REFERENCES `personal` (`application_no`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `other_info`
--

LOCK TABLES `other_info` WRITE;
/*!40000 ALTER TABLE `other_info` DISABLE KEYS */;
INSERT INTO `other_info` VALUES (2,'100100740695','sdfsdfsd','dsfs','no',NULL),(3,'100100767583','jhhhghghgh ','fghgfhgfhfghgh','no',NULL),(5,'100100766784','fsdfsdf','dsfdsf','no',NULL),(6,'100100771725','xzcv',NULL,'no',NULL),(8,'100100715151','dfsdf','sdfs','no',NULL),(9,'100100754418','ghgf ghghghg h','ghg ghghghgh','no',NULL),(10,'100100738703','xcvcxcxcvgnbvnb cgbcvbkjcvbkjfvb kfdjghfhgfoi fdouhgfodh gdfohgodh ohgoifd goifdgif','fgf gfgfdfdgdfgfgfdgf','yes','fbgfhg htfhghghhgh fjhj fjfjf');
/*!40000 ALTER TABLE `other_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `otp_verification`
--

DROP TABLE IF EXISTS `otp_verification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `otp_verification` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user` varchar(60) DEFAULT NULL,
  `mobile` varchar(10) DEFAULT NULL,
  `otp` varchar(6) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `expires_at` datetime DEFAULT NULL,
  `last_resend_time` datetime DEFAULT NULL,
  `resend_attempts` int(11) DEFAULT NULL,
  `max_resend_attempts` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_otp_verification_id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `otp_verification`
--

LOCK TABLES `otp_verification` WRITE;
/*!40000 ALTER TABLE `otp_verification` DISABLE KEYS */;
/*!40000 ALTER TABLE `otp_verification` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment_status`
--

DROP TABLE IF EXISTS `payment_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment_status` (
  `SN` int(11) NOT NULL AUTO_INCREMENT,
  `application_no` varchar(15) DEFAULT NULL,
  `status` varchar(15) DEFAULT NULL,
  `final_status` varchar(45) DEFAULT 'PENDING',
  `payment_id` varchar(60) DEFAULT NULL,
  `pay_date` varchar(45) DEFAULT NULL,
  `date_time` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`SN`),
  KEY `ix_payment_status_SN` (`SN`),
  KEY `fk_payment_personal_idx` (`application_no`),
  KEY `fk_paymentStatus_personal_idx` (`application_no`),
  CONSTRAINT `fk_paymentStatus_personal` FOREIGN KEY (`application_no`) REFERENCES `personal` (`application_no`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment_status`
--

LOCK TABLES `payment_status` WRITE;
/*!40000 ALTER TABLE `payment_status` DISABLE KEYS */;
INSERT INTO `payment_status` VALUES (2,'100100740695','COMPLETED','COMPLETED','641646546541516541646546546546','2025-08-04','2025-08-04 11:02:40'),(4,'100100767583','EXEMPTED','PENDING','-',NULL,'2025-08-08 06:41:34'),(6,'100100766784','COMPLETED','PENDING','GHJGGGHJJJJUU654678','2025-09-07','2024-02-12 22:46:58'),(8,'100100771725','COMPLETED','PENDING','15515315153513135','2026-01-13','2026-01-15 05:43:28'),(10,'100100756184','INCOMPLETE','PENDING','-',NULL,'2024-01-30 01:23:08'),(12,'100100767501','INCOMPLETE','PENDING','-',NULL,'2024-02-04 20:14:36'),(13,'100100715151','EXEMPTED','PENDING','-',NULL,'2024-02-09 21:35:58'),(14,'100100793677','INCOMPLETE','PENDING','-',NULL,'2024-02-09 21:50:45'),(16,'100100754418','EXEMPTED','PENDING','-',NULL,'2024-02-09 22:45:28'),(18,'100100710484','INCOMPLETE','PENDING','-',NULL,'2024-02-09 22:51:28'),(20,'100100738703','EXEMPTED','PENDING','-',NULL,'2024-02-09 23:23:18');
/*!40000 ALTER TABLE `payment_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `personal`
--

DROP TABLE IF EXISTS `personal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `personal` (
  `SN` int(11) NOT NULL AUTO_INCREMENT,
  `application_no` varchar(20) NOT NULL,
  `post` varchar(60) DEFAULT NULL,
  `dicipline` varchar(80) DEFAULT NULL,
  `user` varchar(50) DEFAULT NULL,
  `C_name` varchar(50) DEFAULT NULL,
  `F_name` varchar(50) DEFAULT NULL,
  `M_name` varchar(50) DEFAULT NULL,
  `gender` varchar(10) DEFAULT NULL,
  `category` varchar(50) DEFAULT NULL,
  `cert_no` varchar(20) DEFAULT '-',
  `issue_date` varchar(30) DEFAULT '-',
  `issue_state` varchar(50) DEFAULT '-',
  `marital_status` varchar(10) DEFAULT NULL,
  `nationality` varchar(150) DEFAULT NULL,
  `pwd` varchar(10) DEFAULT NULL,
  `type_disability` varchar(50) DEFAULT '-',
  `percentage_disability` varchar(30) DEFAULT '-',
  `certificate_disability` varchar(20) DEFAULT '-',
  `date_of_issue` varchar(30) DEFAULT '-',
  `identification` varchar(30) DEFAULT NULL,
  `exserve` varchar(10) DEFAULT NULL,
  `date_joining` varchar(30) DEFAULT '-',
  `date_discharge` varchar(30) DEFAULT NULL,
  `minority` varchar(45) DEFAULT NULL,
  `minority_type` varchar(100) DEFAULT NULL,
  `DOB` varchar(30) DEFAULT '-',
  `age` varchar(60) DEFAULT NULL,
  `age_relaxation` varchar(100) DEFAULT NULL,
  `relaxation_in` varchar(65) DEFAULT NULL,
  `identity_type` varchar(50) DEFAULT NULL,
  `identity_no` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`application_no`),
  UNIQUE KEY `SN` (`SN`),
  KEY `fk_personal_reg_idx` (`user`),
  KEY `fk_personal_discipline_idx` (`dicipline`),
  KEY `fk_personal_post_idx` (`post`),
  KEY `fk_personal_category_idx` (`category`),
  KEY `fk_personal_nationality_idx` (`nationality`),
  KEY `fk_personal_pwd_cat_idx` (`type_disability`),
  KEY `fk_personal_identity_idx` (`identity_type`),
  CONSTRAINT `fk_personal_category` FOREIGN KEY (`category`) REFERENCES `category` (`category`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_personal_discipline` FOREIGN KEY (`dicipline`) REFERENCES `discipline` (`discipline`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_personal_nationality` FOREIGN KEY (`nationality`) REFERENCES `nationality` (`nationality`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_personal_post` FOREIGN KEY (`post`) REFERENCES `posts` (`post_name`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_personal_reg` FOREIGN KEY (`user`) REFERENCES `registration_user` (`user`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `chk_gender` CHECK (`gender` in ('Male','Female','Others')),
  CONSTRAINT `chk_marital` CHECK (`marital_status` in ('Unmarried','Married')),
  CONSTRAINT `chk_pwd` CHECK (`pwd` in ('yes','no')),
  CONSTRAINT `chk_minority` CHECK (`minority` in ('yes','no','')),
  CONSTRAINT `chk_exserve` CHECK (`exserve` in ('yes','no',''))
) ENGINE=InnoDB AUTO_INCREMENT=1014 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `personal`
--

LOCK TABLES `personal` WRITE;
/*!40000 ALTER TABLE `personal` DISABLE KEYS */;
INSERT INTO `personal` VALUES (1010,'100100710484','PROJECT BASED MANPOWER-(PBM)','PROJECT STORE OFFICER(PSO)','dk@mail','SDF','DS','FDS','Male','UnReserved','','','','Unmarried','Indian','no','','','','','dfs','no','','','no','','2025-06-03','1 years 1 months 14 days','no','','Aadhaar Card','3423 4234 2342'),(1005,'100100715151','PROJECT BASED MANPOWER-(PBM)','PROJECT STORE OFFICER(PSO)','dk@mail','SDF','DS','FDS','Male','UnReserved','','','','Unmarried','Indian','no','','','','','fdgdf','yes','2025-09-10','2025-09-01','no','','2025-06-03','1 years 1 months 14 days','no','','Aadhaar Card','3242 3423 4234'),(1012,'100100738703','PROJECT BASED MANPOWER-(PBM)','PROJECT STORE OFFICER(PSO)','dk@mail','SDF','DS','FDS','Male','UnReserved','','','','Unmarried','Indian','yes','Cat A','Below 40%','565465636366565','2015-05-31','fgfg','yes','2014-12-12','2025-09-08','yes','Jain','2025-06-03','1 years 1 months 14 days','yes','OBC','Aadhaar Card','5657 6576 7687'),(994,'100100740695','PROJECT BASED MANPOWER-(PBM)','PROJECT STORE OFFICER(PSO)','9k.deepak.9k@gmail.com','SDF','DAS','SAD','Male','UnReserved','','','','Unmarried','Indian','no','','','','','fgfg','no','','','no','','1993-11-09','32 years 8 months 8 days','no','','Aadhaar Card','3432 4234 2424'),(1008,'100100754418','PROJECT BASED MANPOWER-(PBM)','PROJECT STORE OFFICER(PSO)','dk@mail','SDF','DS','FDS','Female','EWS','56636636333313333394','2024-12-12','Bihar','Unmarried','Indian','yes','Cat B','Below 40%','07070700090990678675','2015-09-08','gfjhjghj','yes','2015-12-12','2020-05-05','yes','Sikh','2025-06-03','1 years 1 months 14 days','yes','SC','Aadhaar Card','5151 3133 8787'),(1002,'100100756184','PROJECT BASED MANPOWER-(PBM)','PROJECT STORE OFFICER(PSO)','dk@mail','SDF','DS','FDS','Male','UnReserved','','','','Unmarried','Indian','no','','','','','x','no','','','no','','2025-06-03','1 years 1 months 14 days','no','','Aadhaar Card','5435 4353 4534'),(998,'100100766784','PROJECT BASED MANPOWER-(PBM)','PROJECT SENIOR ADMIN ASSISTANT(PSAA)','dk@mail','SDF','DS','FDS','Male','UnReserved','','','','Unmarried','Indian','no','','','','','hfgh','no','','','no','','2025-06-03','1 years 1 months 14 days','no','','Aadhaar Card','5334 5435 3453'),(1004,'100100767501','PROJECT BASED MANPOWER-(PBM)','PROJECT ADMIN ASSISTANT(PAA)','dk@mail','SDF','DS','FDS','Male','UnReserved','','','','Unmarried','Indian','no','','','','','fsf','no','','','no','','2025-06-03','1 years 1 months 14 days','no','','Aadhaar Card','4343 2423 4324'),(996,'100100767583','PROJECT BASED MANPOWER-(PBM)','PROJECT SENIOR ADMIN ASSISTANT(PSAA)','dk@mail','SDF','DS','FDS','Female','OBC','56765786876989806464','2000-12-11','Chandigarh','Unmarried','Indian','yes','Cat A','Below 40%','65734654654675767657','2000-12-12','gfgfg','no','','','yes','Jain','2025-06-03','1 years 1 months 14 days','yes','OBC','Aadhaar Card','5256 4656 2366'),(1000,'100100771725','PROJECT BASED MANPOWER-(PBM)','PROJECT STORE OFFICER(PSO)','dk@mail','SDF','DS','FDS','Male','UnReserved','','','','Unmarried','Indian','no','','','','','sadasd','no','','','no','','2025-06-03','1 years 1 months 14 days','no','','Aadhaar Card','5334 5435 3453'),(1006,'100100793677','PROJECT BASED MANPOWER-(PBM)','PROJECT SENIOR ADMIN ASSISTANT(PSAA)','dk@mail','SDF','DS','FDS','Male','EWS','dasdas','2025-09-11','Andaman And Nicobar Islands','Unmarried','Indian','no','','','','','asdasd','yes','2025-09-14','2025-09-22','no','','2025-06-03','1 years 1 months 14 days','no','','Aadhaar Card','2131 2321 3213'),(1007,'100100793678','PROJECT BASED MANPOWER-(PBM)','PROJECT SENIOR ADMIN ASSISTANT(PSAA)','dk@mail','SDF','DS','FDS','Male','EWS','dasdas','2025-09-11','Andaman And Nicobar Islands','Unmarried','Indian','no','','','','','asdasd','yes','2025-09-14','2025-09-22','no','','2025-06-03','1 years 1 months 14 days','no','','Aadhaar Card','2131 2321 3213');
/*!40000 ALTER TABLE `personal` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `posts`
--

DROP TABLE IF EXISTS `posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `posts` (
  `post_id` int(11) NOT NULL AUTO_INCREMENT,
  `post_code` varchar(10) NOT NULL,
  `post_name` varchar(60) NOT NULL,
  `advt_sn` int(11) DEFAULT NULL,
  PRIMARY KEY (`post_id`),
  UNIQUE KEY `post_name_UNIQUE` (`post_name`),
  KEY `fk_advt_sn` (`advt_sn`),
  CONSTRAINT `fk_advt_sn` FOREIGN KEY (`advt_sn`) REFERENCES `advert_master` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=86 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `posts`
--

LOCK TABLES `posts` WRITE;
/*!40000 ALTER TABLE `posts` DISABLE KEYS */;
INSERT INTO `posts` VALUES (83,'001','PROJECT BASED MANPOWER-(PBM)',NULL),(85,'231','adsad',NULL);
/*!40000 ALTER TABLE `posts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pwd_category`
--

DROP TABLE IF EXISTS `pwd_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pwd_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pwd_category` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `pwd_category_UNIQUE` (`pwd_category`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pwd_category`
--

LOCK TABLES `pwd_category` WRITE;
/*!40000 ALTER TABLE `pwd_category` DISABLE KEYS */;
INSERT INTO `pwd_category` VALUES (2,'Cat A'),(4,'Cat B'),(6,'Cat C'),(8,'Cat D');
/*!40000 ALTER TABLE `pwd_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pwd_percentage`
--

DROP TABLE IF EXISTS `pwd_percentage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pwd_percentage` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pwd_percentage` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `pwd_percentage_UNIQUE` (`pwd_percentage`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pwd_percentage`
--

LOCK TABLES `pwd_percentage` WRITE;
/*!40000 ALTER TABLE `pwd_percentage` DISABLE KEYS */;
INSERT INTO `pwd_percentage` VALUES (4,'40% & Above'),(2,'Below 40%');
/*!40000 ALTER TABLE `pwd_percentage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qualification`
--

DROP TABLE IF EXISTS `qualification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `qualification` (
  `SN` int(11) NOT NULL AUTO_INCREMENT,
  `qualification` varchar(60) NOT NULL,
  PRIMARY KEY (`SN`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qualification`
--

LOCK TABLES `qualification` WRITE;
/*!40000 ALTER TABLE `qualification` DISABLE KEYS */;
/*!40000 ALTER TABLE `qualification` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qualification_PBM`
--

DROP TABLE IF EXISTS `qualification_PBM`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `qualification_PBM` (
  `SN` int(11) NOT NULL AUTO_INCREMENT,
  `post_name` varchar(100) DEFAULT NULL,
  `qualification` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`SN`),
  UNIQUE KEY `uniq_post_qualification` (`post_name`,`qualification`)
) ENGINE=InnoDB AUTO_INCREMENT=63 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qualification_PBM`
--

LOCK TABLES `qualification_PBM` WRITE;
/*!40000 ALTER TABLE `qualification_PBM` DISABLE KEYS */;
INSERT INTO `qualification_PBM` VALUES (35,'PROJECT ADMIN ASSISTANT(PAA)','B.A'),(47,'PROJECT ADMIN ASSISTANT(PAA)','B.COM'),(39,'PROJECT ADMIN ASSISTANT(PAA)','B.SC'),(41,'PROJECT ADMIN ASSISTANT(PAA)','BCA'),(30,'PROJECT SENIOR ADMIN ASSISTANT(PSAA)','B.A.'),(31,'PROJECT SENIOR ADMIN ASSISTANT(PSAA)','B.COM'),(33,'PROJECT SENIOR ADMIN ASSISTANT(PSAA)','B.SC'),(34,'PROJECT SENIOR ADMIN ASSISTANT(PSAA)','BCA'),(62,'PROJECT SENIOR ADMIN ASSISTANT(PSAA)','JRF'),(25,'PROJECT STORE OFFICER(PSO)','B.A.'),(27,'PROJECT STORE OFFICER(PSO)','B.COM'),(28,'PROJECT STORE OFFICER(PSO)','B.SC'),(29,'PROJECT STORE OFFICER(PSO)','BCA');
/*!40000 ALTER TABLE `qualification_PBM` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `referees`
--

DROP TABLE IF EXISTS `referees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `referees` (
  `SN` int(20) NOT NULL AUTO_INCREMENT,
  `application_no` varchar(20) NOT NULL,
  `name1` varchar(45) DEFAULT NULL,
  `email1` varchar(45) DEFAULT NULL,
  `contact1` varchar(45) DEFAULT NULL,
  `address1` varchar(100) DEFAULT NULL,
  `occupation1` varchar(50) DEFAULT NULL,
  `name2` varchar(45) DEFAULT NULL,
  `email2` varchar(45) DEFAULT NULL,
  `contact2` varchar(45) DEFAULT NULL,
  `address2` varchar(100) DEFAULT NULL,
  `occupation2` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`SN`),
  UNIQUE KEY `application_no_UNIQUE` (`application_no`),
  CONSTRAINT `fk_referees_personal` FOREIGN KEY (`application_no`) REFERENCES `personal` (`application_no`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `referees`
--

LOCK TABLES `referees` WRITE;
/*!40000 ALTER TABLE `referees` DISABLE KEYS */;
INSERT INTO `referees` VALUES (1,'100100740695','sadas','sadsa@sd','4234234','erwer','fsdf','sad','dsda@fdsf','2423432423','ewrwe','fdsfs'),(3,'100100767583','shubham','s@hgmn','543569475948375','fgbf kfjghfdjkgh ',' fhefh dfhd kj','Kiran','k@gjg','457478956439574','fgfd jfg jhgfs','ijhfsdjf skd'),(5,'100100766784','sadas','sadsa@sd','4234234','erwer','fsdf','sad','dsda@fdsf','2423432423','ewrwe','fdsfs'),(6,'100100771725','sadas','sadsa@sd','4234234','erwer','fsdf','sad','dsda@fdsf','2423432423','ewrwe','fdsfs'),(7,'100100756184','zxczx','cxzcfd@dfs','3423432','sfsd','fsd','sdf','sf@sdf','432432','dfs','dfs'),(8,'100100715151','dfgd','fdg#gf@fdf','34423','sdfsd','dsfsdf','dsfsd','dsf@fs','234234','dsff','fdsfs'),(9,'100100754418','ffgfdg','fgfg@df','565','dfds','gfsgfg','ffgfdg','fgfg@df','565','dfds','fgfd'),(10,'100100710484','dsf','dff#@dfsf','32423423423','fsdfsd','sdfd','fsdf','dsf@fd','34223','dsf','dsff'),(11,'100100738703','tyttt','yhg@fg','767656767657567','6tytghtfghgfhgfhg','hgfhghgjhjhg','tyttt','yhg@fg','767656767657567','6tytghtfghgfhgfhg','fdgfdgfdgdfgfdgfdg');
/*!40000 ALTER TABLE `referees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `registration_user`
--

DROP TABLE IF EXISTS `registration_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `registration_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `mobile_no` varchar(10) NOT NULL,
  `name` varchar(50) NOT NULL,
  `father_name` varchar(50) NOT NULL,
  `mother_name` varchar(50) NOT NULL,
  `date_birth` date NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `role` varchar(10) NOT NULL DEFAULT 'candidate',
  `failed_attempts` int(11) DEFAULT 0,
  `lockout_time` datetime DEFAULT NULL,
  `ref_no` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_UNIQUE` (`user`),
  KEY `user` (`user`)
) ENGINE=InnoDB AUTO_INCREMENT=103 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `registration_user`
--

LOCK TABLES `registration_user` WRITE;
/*!40000 ALTER TABLE `registration_user` DISABLE KEYS */;
INSERT INTO `registration_user` VALUES (85,'account.div@ceptam.com','$2b$12$KEvFP/stXy.ab31kDemK1O1HEeQPMSKEOOYGSjXQDz.HfSXTrMOM2','8126988627','ACCOUNT DIV','X','X','1997-02-05','2025-03-24 08:55:53','account',0,NULL,'100100767083'),(87,'admin.div@ceptam.com','$2b$12$KEvFP/stXy.ab31kDemK1O1HEeQPMSKEOOYGSjXQDz.HfSXTrMOM2','8126988627','ADMIN DIV','X','X','1993-07-15','2025-03-24 08:58:24','admin',0,NULL,'100100739831'),(89,'9k.deepak.9k@gmail.com','$2b$12$S7Eo0zFJw.23ZJh7ZZ3BGu6eQLp9uszKyW2VonQro5MTWLDOh09O2','8126988627','SDF','DAS','SAD','1993-11-09','2025-03-24 10:49:56','candidate',0,NULL,'100100726903'),(93,'dk64387@gmail.com','$2b$12$OG9gJ.solpc8Z0c5L8kg/etf6u2NDxufyLN3KMuuVPVwjtRTRa5iq','8126988627','X','X  ','X','2025-03-27','2025-03-27 11:47:51','candidate',0,NULL,'100100792180'),(95,'dk@mail','$2b$12$VNRvhBDheUtXIGG2jalec.DKA83hS6VdGfGBWFhpMR6M6yivaaI1y','8126988627','SDF','DS','FDS','2025-06-03','2025-06-04 08:31:48','candidate',0,NULL,'100100761630'),(101,'guptanimant@gmail.com','$2b$12$vLo2rU8PzsIGfeCqKfj84OwnviejlPuITXllTNdQFgHAN8LkSg4SG','8126988627','SHUBHAM GUPTA',' GUPTA JI','GUPTAIN JI','1999-12-11','2025-06-20 04:22:39','candidate',0,NULL,'100100784365'),(102,'srajbir070@gmail.com','$2b$12$Y/pJyC8Nzf.AofKmTAJyDOv5w9Ob7zPhDzeNNQ9d7eJAdM/DtW0vy','9870146072','RAJBIR SINGH','SATBIR SINGH','PUSHPA DEVI','2000-01-01','2025-06-20 07:34:46','candidate',0,NULL,'100100782052');
/*!40000 ALTER TABLE `registration_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `states`
--

DROP TABLE IF EXISTS `states`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `states` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `state_code` int(11) NOT NULL,
  `state_name_english` varchar(100) NOT NULL,
  `state_name_local` varchar(100) DEFAULT NULL,
  `state_census2011_code` varchar(100) DEFAULT NULL,
  `state_or_ut` varchar(10) DEFAULT NULL,
  `last_updated` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `state_code` (`state_code`),
  UNIQUE KEY `state_name_english_UNIQUE` (`state_name_english`),
  KEY `ix_states_id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=73 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `states`
--

LOCK TABLES `states` WRITE;
/*!40000 ALTER TABLE `states` DISABLE KEYS */;
INSERT INTO `states` VALUES (2,12,'Arunachal Pradesh','ARUNACHAL PRADESH                                 ','12','S','2024-10-07'),(4,2,'Himachal Pradesh','HIMACHAL PRADESH                                  ','02','S','2024-10-07'),(6,23,'Madhya Pradesh','MADHYA PRADESH                                    ','23','S','2024-10-07'),(8,27,'Maharashtra','महाराष्ट्र','27','S','2024-10-07'),(10,34,'Puducherry','PUDUCHERRY','34','U','2024-10-07'),(12,9,'Uttar Pradesh','UTTAR PRADESH                                     ','09','S','2024-10-07'),(14,22,'Chhattisgarh','छत्तीसगढ़','22','S','2024-10-07'),(16,20,'Jharkhand','झारखंड','20','S','2024-10-07'),(18,17,'Meghalaya','MEGHALAYA                                         ','17','S','2024-10-07'),(20,3,'Punjab','PUNJAB                                            ','03','S','2024-10-07'),(22,16,'Tripura','ত্রিপুরা','16','S','2024-10-07'),(24,10,'Bihar','BIHAR                                             ','10','S','2024-10-07'),(26,7,'Delhi','DELHI                                             ','07','U','2024-10-07'),(28,32,'Kerala','KERALA                                            ','32','S','2024-10-07'),(30,11,'Sikkim','SIKKIM                                            ','11','S','2024-10-07'),(32,38,'The Dadra And Nagar Haveli And Daman And Diu','THE DADRA AND NAGAR HAVELI AND DAMAN AND DIU','NA','U','2024-10-07'),(34,5,'Uttarakhand','UTTARAKHAND','05','S','2024-10-07'),(36,35,'Andaman And Nicobar Islands','ANDAMAN AND NICOBAR ISLANDS                       ','35','U','2024-10-07'),(38,28,'Andhra Pradesh','ANDHRA PRADESH                                    ','28','S','2024-10-07'),(40,18,'Assam','ASSAM                                             ','18','S','2024-10-07'),(42,4,'Chandigarh','CHANDIGARH                                        ','04','U','2024-10-07'),(44,6,'Haryana','HARYANA                                           ','06','S','2024-10-07'),(46,1,'Jammu And Kashmir','JAMMU AND KASHMIR','01','U','2024-10-07'),(48,37,'Ladakh','Ladakh','00','U','2024-10-07'),(50,15,'Mizoram','MIZORAM                                           ','15','S','2024-10-07'),(52,21,'Odisha','ODISHA','21','S','2024-10-07'),(54,36,'Telangana','తెలంగాణ','00','S','2024-10-07'),(56,30,'Goa','GOA                                               ','30','S','2024-10-07'),(58,24,'Gujarat','GUJARAT                                           ','24','S','2024-10-07'),(60,29,'Karnataka','ಕರ್ನಾಟಕ','29','S','2024-10-07'),(62,31,'Lakshadweep','LAKSHADWEEP                                       ','31','U','2024-10-07'),(64,14,'Manipur','MANIPUR                                           ','14','S','2024-10-07'),(66,13,'Nagaland','NAGALAND                                          ','13','S','2024-10-07'),(68,8,'Rajasthan','RAJASTHAN                                         ','08','S','2024-10-07'),(70,33,'Tamil Nadu','TAMIL NADU                                        ','33','S','2024-10-07'),(72,19,'West Bengal','WEST BENGAL                                       ','19','S','2024-10-07');
/*!40000 ALTER TABLE `states` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subjects`
--

DROP TABLE IF EXISTS `subjects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `subjects` (
  `SN` int(11) NOT NULL AUTO_INCREMENT,
  `qualification` varchar(60) NOT NULL,
  `subject` varchar(60) NOT NULL,
  PRIMARY KEY (`SN`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subjects`
--

LOCK TABLES `subjects` WRITE;
/*!40000 ALTER TABLE `subjects` DISABLE KEYS */;
/*!40000 ALTER TABLE `subjects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trainings`
--

DROP TABLE IF EXISTS `trainings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `trainings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `application_no` varchar(20) DEFAULT NULL,
  `course` varchar(120) DEFAULT NULL,
  `course_from` varchar(15) DEFAULT NULL,
  `course_to` varchar(15) DEFAULT NULL,
  `course_details` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_trainings_id` (`id`),
  KEY `fk_trainings_personal_idx` (`application_no`),
  CONSTRAINT `fk_trainings_1_personal` FOREIGN KEY (`application_no`) REFERENCES `personal` (`application_no`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trainings`
--

LOCK TABLES `trainings` WRITE;
/*!40000 ALTER TABLE `trainings` DISABLE KEYS */;
INSERT INTO `trainings` VALUES (2,'100100715151','wer','2025-09-16','2025-09-17','ewrwer'),(5,'100100754418','hghjgjgf','2014-05-04','2015-06-05','dfdsfdgfg'),(6,'100100738703','hjhgjhgj','2015-05-04','2016-06-05','dgfgfgfdgf hhghgfh ghghghgffghknb fdfslkgjlkfjg lfkjgfg');
/*!40000 ALTER TABLE `trainings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `verify_docs`
--

DROP TABLE IF EXISTS `verify_docs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `verify_docs` (
  `SN` int(11) NOT NULL AUTO_INCREMENT,
  `application_no` varchar(15) NOT NULL,
  `candidate_name` varchar(15) NOT NULL DEFAULT '-',
  `father_name` varchar(15) NOT NULL DEFAULT '-',
  `mother_name` varchar(15) NOT NULL DEFAULT '-',
  `caste_certificate_no` varchar(15) NOT NULL DEFAULT '-',
  `caste_date` varchar(15) NOT NULL DEFAULT '-',
  `caste_state` varchar(15) NOT NULL DEFAULT '-',
  `identity_no` varchar(15) NOT NULL DEFAULT '-',
  `date_birth` varchar(15) NOT NULL DEFAULT '-',
  PRIMARY KEY (`SN`),
  KEY `fk_verify_personal` (`application_no`),
  CONSTRAINT `fk_verify_personal` FOREIGN KEY (`application_no`) REFERENCES `personal` (`application_no`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `verify_docs`
--

LOCK TABLES `verify_docs` WRITE;
/*!40000 ALTER TABLE `verify_docs` DISABLE KEYS */;
INSERT INTO `verify_docs` VALUES (2,'100100740695',' not matched','not matched','not matched','','','','not matched','not matched'),(3,'100100767583',' not matched','not matched','not matched','not matched','not matched','not matched','not matched','not matched'),(4,'100100766784',' not matched','not matched','not matched','','','','not matched','not matched'),(6,'100100771725',' not matched','not matched','not matched','','','','not matched','not matched'),(7,'100100756184',' not matched','not matched','not matched','','','','not matched','not matched'),(9,'100100767501',' not matched','not matched','not matched','','','','not matched','not matched'),(10,'100100715151',' not matched','not matched','not matched','','','','not matched','not matched'),(11,'100100793677',' not matched','not matched','not matched','not matched','not matched','not matched','not matched','not matched'),(13,'100100754418',' not matched','not matched','not matched','not matched','not matched','not matched','not matched','not matched'),(14,'100100710484',' not matched','not matched','not matched','','','','not matched','not matched'),(15,'100100738703',' not matched','not matched','not matched','','','','not matched','not matched');
/*!40000 ALTER TABLE `verify_docs` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-02-12 16:01:24
