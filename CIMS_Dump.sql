-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: localhost    Database: financial_management
-- ------------------------------------------------------
-- Server version	8.0.34

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
-- Table structure for table `account_asset_relations`
--

DROP TABLE IF EXISTS `account_asset_relations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `account_asset_relations` (
  `relation_id` int NOT NULL AUTO_INCREMENT,
  `account_id` int DEFAULT NULL,
  `asset_id` int DEFAULT NULL,
  `quantity` int DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`relation_id`),
  KEY `account_id` (`account_id`),
  KEY `asset_id` (`asset_id`),
  CONSTRAINT `account_asset_relations_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`account_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `account_asset_relations_ibfk_2` FOREIGN KEY (`asset_id`) REFERENCES `assets` (`asset_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_asset_relations`
--

LOCK TABLES `account_asset_relations` WRITE;
/*!40000 ALTER TABLE `account_asset_relations` DISABLE KEYS */;
/*!40000 ALTER TABLE `account_asset_relations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `account_changes_log`
--

DROP TABLE IF EXISTS `account_changes_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `account_changes_log` (
  `change_id` int NOT NULL AUTO_INCREMENT,
  `account_id` int DEFAULT NULL,
  `previous_type` varchar(100) DEFAULT NULL,
  `new_type` varchar(100) DEFAULT NULL,
  `change_date` datetime DEFAULT NULL,
  PRIMARY KEY (`change_id`),
  KEY `account_id` (`account_id`),
  CONSTRAINT `account_changes_log_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_changes_log`
--

LOCK TABLES `account_changes_log` WRITE;
/*!40000 ALTER TABLE `account_changes_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `account_changes_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `account_holdings`
--

DROP TABLE IF EXISTS `account_holdings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `account_holdings` (
  `holding_id` int NOT NULL AUTO_INCREMENT,
  `account_id` int DEFAULT NULL,
  `asset_id` int DEFAULT NULL,
  `quantity` int DEFAULT NULL,
  PRIMARY KEY (`holding_id`),
  KEY `account_id` (`account_id`),
  KEY `asset_id` (`asset_id`),
  CONSTRAINT `account_holdings_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`account_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `account_holdings_ibfk_2` FOREIGN KEY (`asset_id`) REFERENCES `assets` (`asset_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_holdings`
--

LOCK TABLES `account_holdings` WRITE;
/*!40000 ALTER TABLE `account_holdings` DISABLE KEYS */;
INSERT INTO `account_holdings` VALUES (1,1,1,1);
/*!40000 ALTER TABLE `account_holdings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `accounts`
--

DROP TABLE IF EXISTS `accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `accounts` (
  `account_id` int NOT NULL AUTO_INCREMENT,
  `type` varchar(100) DEFAULT NULL,
  `opening_date` date DEFAULT NULL,
  `customer_id` int DEFAULT NULL,
  PRIMARY KEY (`account_id`),
  KEY `customer_id` (`customer_id`),
  CONSTRAINT `accounts_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts`
--

LOCK TABLES `accounts` WRITE;
/*!40000 ALTER TABLE `accounts` DISABLE KEYS */;
INSERT INTO `accounts` VALUES (1,'Savings','2021-01-10',1),(2,'Checking','2021-02-15',2),(3,'Investment','2021-03-20',3);
/*!40000 ALTER TABLE `accounts` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `AfterAccountUpdate` AFTER UPDATE ON `accounts` FOR EACH ROW BEGIN
    INSERT INTO account_changes_log (account_id, previous_type, new_type, change_date)
    VALUES (NEW.account_id, OLD.type, NEW.type, NOW());
 
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `assets`
--

DROP TABLE IF EXISTS `assets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `assets` (
  `asset_id` int NOT NULL AUTO_INCREMENT,
  `details` text,
  PRIMARY KEY (`asset_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assets`
--

LOCK TABLES `assets` WRITE;
/*!40000 ALTER TABLE `assets` DISABLE KEYS */;
INSERT INTO `assets` VALUES (1,'Stocks - Tech Companies'),(2,'Bonds - Government'),(3,'Real Estate Investment Trusts');
/*!40000 ALTER TABLE `assets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `client_activity`
--

DROP TABLE IF EXISTS `client_activity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `client_activity` (
  `activity_id` int NOT NULL AUTO_INCREMENT,
  `customer_id` int DEFAULT NULL,
  `staff_id` int DEFAULT NULL,
  `description` text,
  `date` date DEFAULT NULL,
  PRIMARY KEY (`activity_id`),
  KEY `customer_id` (`customer_id`),
  KEY `staff_id` (`staff_id`),
  CONSTRAINT `client_activity_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `client_activity_ibfk_2` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`staff_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `client_activity`
--

LOCK TABLES `client_activity` WRITE;
/*!40000 ALTER TABLE `client_activity` DISABLE KEYS */;
INSERT INTO `client_activity` VALUES (1,1,1,'Portfolio Review','2021-04-01'),(2,2,2,'Investment Strategy Meeting','2021-04-02'),(3,3,3,'Account Setup','2021-04-03'),(4,1,1,'Investment Discussion','2023-01-03'),(5,2,1,'Portfolio Review','2023-01-04'),(6,3,2,'Account Setup','2023-01-05'),(7,1,2,'Risk Assessment','2023-01-06'),(8,2,3,'Investment Plan Update','2023-01-07'),(9,3,3,'Regular Check-in','2023-01-08');
/*!40000 ALTER TABLE `client_activity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customers`
--

DROP TABLE IF EXISTS `customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customers` (
  `customer_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `contact_info` varchar(255) DEFAULT NULL,
  `risk_tolerance_level` varchar(50) DEFAULT NULL,
  `advisor_id` int DEFAULT NULL,
  PRIMARY KEY (`customer_id`),
  KEY `advisor_id` (`advisor_id`),
  CONSTRAINT `customers_ibfk_1` FOREIGN KEY (`advisor_id`) REFERENCES `staff` (`staff_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customers`
--

LOCK TABLES `customers` WRITE;
/*!40000 ALTER TABLE `customers` DISABLE KEYS */;
INSERT INTO `customers` VALUES (1,'Bob Brown','bob@example.com','Moderate',1),(2,'Sara Davis','sara@example.com','High',2),(3,'Mike Wilson','mike@example.com','Low',3);
/*!40000 ALTER TABLE `customers` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `BeforeCustomerDelete` BEFORE DELETE ON `customers` FOR EACH ROW BEGIN
    DELETE FROM client_activity WHERE customer_id = OLD.customer_id;
    DELETE FROM transactions WHERE account_id IN (SELECT account_id FROM accounts WHERE customer_id = OLD.customer_id);
    DELETE FROM account_holdings WHERE account_id IN (SELECT account_id FROM accounts WHERE customer_id = OLD.customer_id);
    DELETE FROM investment_reviews WHERE account_id IN (SELECT account_id FROM accounts WHERE customer_id = OLD.customer_id);
    DELETE FROM financial_reports WHERE account_id IN (SELECT account_id FROM accounts WHERE customer_id = OLD.customer_id);
    DELETE FROM accounts WHERE customer_id = OLD.customer_id;
    DELETE FROM staff_customer_relations WHERE customer_id = OLD.customer_id;

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `financial_reports`
--

DROP TABLE IF EXISTS `financial_reports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `financial_reports` (
  `report_id` int NOT NULL AUTO_INCREMENT,
  `account_id` int DEFAULT NULL,
  `report_date` date DEFAULT NULL,
  `content` text,
  PRIMARY KEY (`report_id`),
  KEY `account_id` (`account_id`),
  CONSTRAINT `financial_reports_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`account_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `financial_reports`
--

LOCK TABLES `financial_reports` WRITE;
/*!40000 ALTER TABLE `financial_reports` DISABLE KEYS */;
/*!40000 ALTER TABLE `financial_reports` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `investment_reviews`
--

DROP TABLE IF EXISTS `investment_reviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `investment_reviews` (
  `review_id` int NOT NULL AUTO_INCREMENT,
  `account_id` int DEFAULT NULL,
  `review_date` date DEFAULT NULL,
  `comments` text,
  PRIMARY KEY (`review_id`),
  KEY `account_id` (`account_id`),
  CONSTRAINT `investment_reviews_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`account_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `investment_reviews`
--

LOCK TABLES `investment_reviews` WRITE;
/*!40000 ALTER TABLE `investment_reviews` DISABLE KEYS */;
/*!40000 ALTER TABLE `investment_reviews` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `market_data`
--

DROP TABLE IF EXISTS `market_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `market_data` (
  `data_id` int NOT NULL AUTO_INCREMENT,
  `asset_id` int DEFAULT NULL,
  `date` date DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `volume` int DEFAULT NULL,
  PRIMARY KEY (`data_id`),
  KEY `asset_id` (`asset_id`),
  CONSTRAINT `market_data_ibfk_1` FOREIGN KEY (`asset_id`) REFERENCES `assets` (`asset_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `market_data`
--

LOCK TABLES `market_data` WRITE;
/*!40000 ALTER TABLE `market_data` DISABLE KEYS */;
INSERT INTO `market_data` VALUES (1,1,'2023-01-01',2.00,3),(2,1,'2023-01-02',102.00,450),(3,1,'2023-01-03',101.50,400),(4,1,'2023-01-04',103.00,420),(5,1,'2023-01-05',104.00,510),(6,1,'2023-01-06',103.50,460),(7,1,'2023-01-07',102.50,480),(8,1,'2023-01-08',105.00,500),(9,1,'2023-01-09',106.00,520),(10,1,'2023-01-10',107.00,510),(11,2,'2023-01-01',200.00,200),(12,2,'2023-01-02',198.00,300),(13,2,'2023-01-03',197.00,250),(14,2,'2023-01-04',199.00,280),(15,2,'2023-01-05',201.00,300),(16,2,'2023-01-06',200.50,310),(17,2,'2023-01-07',202.00,320),(18,2,'2023-01-08',203.00,330),(19,2,'2023-01-09',204.00,340),(20,2,'2023-01-10',205.00,350),(21,3,'2023-01-01',50.00,1000),(22,3,'2023-01-02',49.50,1500),(23,3,'2023-01-03',48.00,1400),(24,3,'2023-01-04',48.50,1300),(25,3,'2023-01-05',49.00,1200),(26,3,'2023-01-06',50.50,1100),(27,3,'2023-01-07',51.00,1150),(28,3,'2023-01-08',51.50,1200),(29,3,'2023-01-09',52.00,1250),(30,3,'2023-01-10',53.00,1300);
/*!40000 ALTER TABLE `market_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `staff`
--

DROP TABLE IF EXISTS `staff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `staff` (
  `staff_id` int NOT NULL AUTO_INCREMENT,
  `s_password` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `position` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`staff_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `staff`
--

LOCK TABLES `staff` WRITE;
/*!40000 ALTER TABLE `staff` DISABLE KEYS */;
INSERT INTO `staff` VALUES (1,'password123','John Doe','Financial Advisor'),(2,'password456','Jane Smith','Investment Manager'),(3,'password789','Alice Johnson','Account Manager');
/*!40000 ALTER TABLE `staff` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `staff_customer_relations`
--

DROP TABLE IF EXISTS `staff_customer_relations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `staff_customer_relations` (
  `relation_id` int NOT NULL AUTO_INCREMENT,
  `staff_id` int DEFAULT NULL,
  `customer_id` int DEFAULT NULL,
  PRIMARY KEY (`relation_id`),
  KEY `staff_id` (`staff_id`),
  KEY `customer_id` (`customer_id`),
  CONSTRAINT `staff_customer_relations_ibfk_1` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`staff_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `staff_customer_relations_ibfk_2` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `staff_customer_relations`
--

LOCK TABLES `staff_customer_relations` WRITE;
/*!40000 ALTER TABLE `staff_customer_relations` DISABLE KEYS */;
/*!40000 ALTER TABLE `staff_customer_relations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transactions`
--

DROP TABLE IF EXISTS `transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transactions` (
  `transaction_id` int NOT NULL AUTO_INCREMENT,
  `account_id` int DEFAULT NULL,
  `asset_id` int DEFAULT NULL,
  `quantity` int DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `transaction_date` date DEFAULT NULL,
  PRIMARY KEY (`transaction_id`),
  KEY `account_id` (`account_id`),
  KEY `asset_id` (`asset_id`),
  CONSTRAINT `transactions_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`account_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `transactions_ibfk_2` FOREIGN KEY (`asset_id`) REFERENCES `assets` (`asset_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `transactions_chk_1` CHECK ((`price` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transactions`
--

LOCK TABLES `transactions` WRITE;
/*!40000 ALTER TABLE `transactions` DISABLE KEYS */;
INSERT INTO `transactions` VALUES (1,1,1,10,150.00,'2021-03-01'),(2,2,2,5,200.00,'2021-03-02'),(3,3,3,2,500.00,'2021-03-03'),(4,1,1,1,10.00,'2023-12-07');
/*!40000 ALTER TABLE `transactions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'financial_management'
--

--
-- Dumping routines for database 'financial_management'
--
/*!50003 DROP PROCEDURE IF EXISTS `AddMarketData` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddMarketData`(IN p_asset_id INT, IN p_date DATE, IN p_price DECIMAL(10, 2), IN p_volume INT)
BEGIN
    INSERT INTO market_data (asset_id, date, price, volume) 
    VALUES (p_asset_id, p_date, p_price, p_volume);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `AddNewCustomer` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddNewCustomer`(IN p_name VARCHAR(255), IN p_contact_info VARCHAR(255), IN p_risk_tolerance_level VARCHAR(50), IN p_advisor_id INT)
BEGIN
    INSERT INTO customers (name, contact_info, risk_tolerance_level, advisor_id) 
    VALUES (p_name, p_contact_info, p_risk_tolerance_level, p_advisor_id);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DeleteMarketData` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteMarketData`(IN p_data_id INT)
BEGIN
    DELETE FROM market_data
    WHERE data_id = p_data_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ExecuteTransaction` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ExecuteTransaction`(
    IN p_account_id INT, 
    IN p_asset_id INT, 
    IN p_quantity INT, 
    IN p_price DECIMAL(10, 2)
)
BEGIN
	DECLARE current_quantity INT DEFAULT 0;
	-- check whether price > 0
    IF p_price < 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Price cannot be negative';
        
    END IF;
        
	-- get asset quantity and check whether selling is feasible 
    SELECT quantity INTO current_quantity
    FROM account_holdings
    WHERE account_id = p_account_id AND asset_id = p_asset_id;
    IF p_quantity < 0 AND ABS(p_quantity) > current_quantity THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Insufficient Asset to Sell';
    END IF;
    
    INSERT INTO transactions (account_id, asset_id, quantity, price, transaction_date) 
    VALUES (p_account_id, p_asset_id, p_quantity, p_price, NOW());

    -- check whether the accounts have the asset
    IF EXISTS (SELECT * FROM account_holdings WHERE account_id = p_account_id AND asset_id = p_asset_id) THEN
        UPDATE account_holdings
        SET quantity = quantity + p_quantity 
        WHERE account_id = p_account_id AND asset_id = p_asset_id;
    ELSE
        INSERT INTO account_holdings (account_id, asset_id, quantity)
        VALUES (p_account_id, p_asset_id, p_quantity);
    END IF;

    COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UpdateCustomer` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateCustomer`(
    IN p_customer_id INT,
    IN p_name VARCHAR(255),
    IN p_contact_info VARCHAR(255),
    IN p_risk_tolerance_level VARCHAR(50),
    IN p_advisor_id INT
)
BEGIN
    UPDATE customers
    SET
        name = IF(p_name IS NOT NULL AND p_name != '', p_name, name),
        contact_info = IF(p_contact_info IS NOT NULL AND p_contact_info != '', p_contact_info, contact_info),
        risk_tolerance_level = IF(p_risk_tolerance_level IS NOT NULL AND p_risk_tolerance_level != '', p_risk_tolerance_level, risk_tolerance_level),
        advisor_id = IF(p_advisor_id IS NOT NULL AND p_advisor_id != 0, p_advisor_id, advisor_id)
    WHERE customer_id = p_customer_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UpdateMarketData` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateMarketData`(IN p_data_id INT, IN p_price DECIMAL(10, 2), IN p_volume INT)
BEGIN
    UPDATE market_data
    SET price = p_price, volume = p_volume
    WHERE data_id = p_data_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-12-08 10:01:22
