-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Dec 06, 2023 at 02:11 PM
-- Server version: 8.0.31
-- PHP Version: 8.0.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `services_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `adds`
--

DROP TABLE IF EXISTS `adds`;
CREATE TABLE IF NOT EXISTS `adds` (
  `Add_id` int NOT NULL AUTO_INCREMENT,
  `Add_quantity` int NOT NULL,
  `Brand_id` int DEFAULT NULL,
  `Holder_id` int DEFAULT NULL,
  `Employee_id` int DEFAULT NULL,
  `Add_time` datetime NOT NULL,
  `AddSummary_id` int DEFAULT NULL,
  PRIMARY KEY (`Add_id`)
) ENGINE=MyISAM AUTO_INCREMENT=49 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `adds`
--

INSERT INTO `adds` (`Add_id`, `Add_quantity`, `Brand_id`, `Holder_id`, `Employee_id`, `Add_time`, `AddSummary_id`) VALUES
(48, 15, 18, 1, 1, '2023-12-06 10:14:08', 4),
(47, 30, 17, 1, 1, '2023-12-05 10:02:08', 3),
(46, 10, 1, 1, 1, '2023-12-05 09:11:44', 2),
(45, 10, 8, 1, 1, '2023-12-04 16:25:17', 1),
(44, 10, 7, 1, 1, '2023-12-04 16:25:09', 1),
(43, 10, 1, 1, 1, '2023-12-04 16:25:01', 1);

-- --------------------------------------------------------

--
-- Table structure for table `adds_summary`
--

DROP TABLE IF EXISTS `adds_summary`;
CREATE TABLE IF NOT EXISTS `adds_summary` (
  `AddSummary_id` int NOT NULL,
  `NumOfBrands` int NOT NULL,
  `Holder_id` int DEFAULT NULL,
  `Employee_id` int DEFAULT NULL,
  `AddSummary_time` datetime NOT NULL,
  PRIMARY KEY (`AddSummary_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `adds_summary`
--

INSERT INTO `adds_summary` (`AddSummary_id`, `NumOfBrands`, `Holder_id`, `Employee_id`, `AddSummary_time`) VALUES
(4, 0, 1, 1, '2023-12-06 10:14:08'),
(3, 0, 1, 1, '2023-12-05 10:02:08'),
(2, 0, 1, 1, '2023-12-05 09:11:44'),
(1, 0, 1, 1, '2023-12-04 16:25:01');

-- --------------------------------------------------------

--
-- Table structure for table `brands`
--

DROP TABLE IF EXISTS `brands`;
CREATE TABLE IF NOT EXISTS `brands` (
  `Brand_id` int NOT NULL AUTO_INCREMENT,
  `Brand_Name` varchar(40) NOT NULL,
  `Now_quantity` int NOT NULL,
  `requests` int NOT NULL,
  `adds` int NOT NULL,
  `dues` int NOT NULL,
  `needs` int UNSIGNED NOT NULL,
  PRIMARY KEY (`Brand_id`)
) ENGINE=MyISAM AUTO_INCREMENT=70 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `brands`
--

INSERT INTO `brands` (`Brand_id`, `Brand_Name`, `Now_quantity`, `requests`, `adds`, `dues`, `needs`) VALUES
(1, 'باكيت شاي أخضر 100 فتلة', 90, -30, 20, 200, 110),
(2, 'باكيت شاي الربيع 100 فتلة', 0, -10, 0, 150, 150),
(3, 'باكيت نعناع 100 فتلة', 29, 0, 0, 200, 171),
(4, 'باكيت نعناع 12 فتلة', 31, 0, 0, 150, 119),
(5, 'باكت كاكاو', 10, -10, 0, 100, 90),
(6, 'باكيت كركاديه 12 فتلة', 16, 0, 0, 80, 64),
(7, 'باكيت كركاديه 100 فتلة', 70, -5, 10, 50, 0),
(8, 'باكيت ينسون 100 فتلة', 34, -6, 10, 50, 16),
(9, 'باكيت ينسون 12 فتلة', 32, 0, 0, 50, 18),
(10, 'باكيت قرفة زنجبيل 12 فتلة', 35, 0, 0, 40, 5),
(11, 'شاي الربيع اكسبريس سايب', 0, 0, 0, 20, 20),
(12, 'قرفة بالجنزبيل 20 فتلة', 41, 0, 0, 41, 0),
(13, 'قرفة سادة 12 فتلة', 3, 0, 0, 10, 7),
(14, 'نعناع 20 فتلة', 16, -2, 0, 20, 4),
(15, 'شاي العروسة 100 فتلة', 38, -6, 0, 50, 12),
(16, 'سكر', 972, -50, 0, 1000, 28),
(17, 'شاي العروسة 40 جم', 6, -38, 30, 20, 14),
(18, 'حليب', 200, -20, 15, 250, 50),
(19, 'برطمان نسكافيه 200 جرام', 28, -1, 0, 35, 7),
(20, 'برطمان نسكافيه 50 جرام', 25, 0, 0, 50, 25),
(21, 'بن محوج عبدالمعبود 250 جم', 49, 0, 0, 55, 6),
(22, 'بن سادة عبدالمعبود 250 جم', 36, 0, 0, 50, 14),
(23, 'بن سادة ابوعوف 250 جم', 32, 0, 0, 50, 18),
(24, 'كرتونة اكواب بلاستيك', 60, 0, 0, 100, 40),
(25, 'كرتونة اكواب شاي', 53, 0, 0, 100, 47),
(26, 'كرتونة اكواب قهوة', 70, 0, 0, 100, 30),
(27, 'علب مناديل', 20, 0, 0, 80, 60),
(28, 'بكر تواليت', 47, 0, 0, 60, 13),
(29, 'صابون سايل 4 لتر', 29, 0, 0, 35, 6),
(30, 'مناديل سحب', 86, 0, 0, 80, 0),
(31, 'مناديل xxl', 25, 0, 0, 30, 5),
(32, 'اريال', 45, 0, 0, 50, 5),
(33, 'زجاجة هاربك', 30, 0, 0, 40, 10),
(34, 'ملمع اثاث', 22, 0, 0, 30, 8),
(35, 'زجاجة ديتول 4 لتر', 15, 0, 0, 30, 15),
(36, 'صابون وجه', 9, -10, 0, 30, 21),
(37, 'زجاجة صابون هاند وش', 26, 0, 0, 30, 4),
(38, 'زجاجة ديتول رش', 30, 0, 0, 30, 0),
(39, 'معطر جليد', 20, 0, 0, 30, 10),
(40, 'زجاجة بيروسول', 18, 0, 0, 30, 12),
(41, 'زجاجة فنيك', 15, 0, 0, 30, 15),
(42, 'زجاجة كلور', 20, 0, 0, 20, 0),
(43, 'لفة سلك مواعين', 20, 0, 0, 30, 10),
(44, 'اسبونشات صغيرة', 20, 0, 0, 30, 10),
(45, 'اكياس قمامة صغيرة', 50, 0, 0, 150, 100),
(46, 'اكياس قمامة كبيرة', 60, 0, 0, 150, 90),
(47, 'اكياس قمامة وسط', 15, 0, 0, 20, 5),
(48, 'ملمع زجاج', 0, 0, 0, 10, 10),
(49, 'فلاش', 8, 0, 0, 10, 2),
(50, ' منظف اسطح 1 لتر', 45, 0, 0, 50, 5),
(51, 'منظف ايدي 2 لتر', 10, 0, 0, 15, 5),
(52, 'مكانس', 2, 0, 0, 5, 3),
(53, 'جردل مسح', 0, 0, 0, 5, 5),
(54, 'حوض حمام', 2, 0, 0, 5, 3),
(55, 'بانيو', 0, 0, 0, 3, 3),
(56, 'اكرة شباك', 0, 0, 0, 5, 5),
(57, 'سبت غسيل', 0, 0, 0, 5, 5),
(58, 'كالون باب', 0, 0, 0, 5, 5),
(59, 'شطاف قاعدة', 10, 0, 0, 10, 0),
(60, 'خلاط حوض', 0, 0, 0, 10, 10),
(61, 'خلاط وش', 1, 0, 0, 5, 4),
(62, 'كالون بدون قلب', 0, 0, 0, 5, 5),
(63, 'اكرة باب', 0, 0, 0, 5, 5),
(64, 'دش', 4, 0, 0, 5, 1),
(65, 'مساحات', 8, 0, 0, 10, 2),
(66, 'سخانات', 0, 0, 0, 5, 5),
(67, 'ملايات', 26, 0, 0, 30, 4),
(68, 'سيليكون', 27, 0, 0, 30, 3),
(69, 'علبة بخاخ فارغ', 0, 0, 0, 5, 5);

-- --------------------------------------------------------

--
-- Table structure for table `departments`
--

DROP TABLE IF EXISTS `departments`;
CREATE TABLE IF NOT EXISTS `departments` (
  `Department_id` int NOT NULL AUTO_INCREMENT,
  `Department_name` varchar(40) NOT NULL,
  PRIMARY KEY (`Department_id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `departments`
--

INSERT INTO `departments` (`Department_id`, `Department_name`) VALUES
(1, 'المهمات'),
(2, 'الأمن'),
(3, 'الكامب'),
(4, 'الكنترول'),
(5, 'GPC');

-- --------------------------------------------------------

--
-- Table structure for table `dues`
--

DROP TABLE IF EXISTS `dues`;
CREATE TABLE IF NOT EXISTS `dues` (
  `Brand_id` int DEFAULT NULL,
  `Department_id` int DEFAULT NULL,
  `Quantity` int NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `dues`
--

INSERT INTO `dues` (`Brand_id`, `Department_id`, `Quantity`) VALUES
(1, 1, 10),
(1, 2, 8),
(1, 3, 35),
(1, 4, 2),
(1, 5, 15),
(2, 1, 8),
(2, 2, 5),
(2, 3, 30),
(2, 4, 5),
(2, 5, 10),
(3, 1, 3),
(3, 2, 2),
(3, 3, 5),
(3, 4, 2),
(3, 5, 3),
(4, 1, 7),
(4, 2, 9),
(4, 3, 10),
(4, 4, 5),
(4, 5, 5),
(5, 1, 10),
(5, 2, 10),
(5, 3, 10),
(5, 4, 10),
(5, 5, 10),
(6, 1, 7),
(6, 2, 7),
(6, 3, 12),
(6, 4, 8),
(6, 5, 8),
(7, 1, 12),
(7, 2, 12),
(7, 3, 10),
(7, 4, 6),
(7, 5, 7),
(8, 1, 15),
(8, 2, 15),
(8, 3, 20),
(8, 4, 5),
(8, 5, 10),
(9, 1, 10),
(9, 2, 10),
(9, 3, 30),
(9, 4, 3),
(9, 5, 7),
(10, 1, 8),
(10, 2, 8),
(10, 3, 20),
(10, 4, 10),
(10, 5, 12);

-- --------------------------------------------------------

--
-- Table structure for table `employees`
--

DROP TABLE IF EXISTS `employees`;
CREATE TABLE IF NOT EXISTS `employees` (
  `Employee_id` int NOT NULL AUTO_INCREMENT,
  `Employee_name` varchar(40) NOT NULL,
  PRIMARY KEY (`Employee_id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `employees`
--

INSERT INTO `employees` (`Employee_id`, `Employee_name`) VALUES
(1, 'محمد فؤاد'),
(2, 'أحمد جلال'),
(3, 'هاني نور'),
(4, 'أحمد عمارة');

-- --------------------------------------------------------

--
-- Table structure for table `holders`
--

DROP TABLE IF EXISTS `holders`;
CREATE TABLE IF NOT EXISTS `holders` (
  `Holder_id` int NOT NULL AUTO_INCREMENT,
  `Holder_name` varchar(40) NOT NULL,
  PRIMARY KEY (`Holder_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `holders`
--

INSERT INTO `holders` (`Holder_id`, `Holder_name`) VALUES
(1, 'الإدارة'),
(2, 'جابكو');

-- --------------------------------------------------------

--
-- Table structure for table `requests`
--

DROP TABLE IF EXISTS `requests`;
CREATE TABLE IF NOT EXISTS `requests` (
  `Request_id` int NOT NULL AUTO_INCREMENT,
  `Request_quantity` int NOT NULL,
  `Brand_id` int DEFAULT NULL,
  `Department_id` int DEFAULT NULL,
  `Employee_id` int DEFAULT NULL,
  `Request_time` datetime NOT NULL,
  `RequestSummary_id` int DEFAULT NULL,
  PRIMARY KEY (`Request_id`)
) ENGINE=MyISAM AUTO_INCREMENT=89 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `requests`
--

INSERT INTO `requests` (`Request_id`, `Request_quantity`, `Brand_id`, `Department_id`, `Employee_id`, `Request_time`, `RequestSummary_id`) VALUES
(88, 1, 19, 3, 1, '2023-12-06 10:21:16', 8),
(87, 3, 17, 3, 1, '2023-12-06 10:20:17', 8),
(86, 2, 17, 2, 1, '2023-12-06 10:19:21', 8),
(85, 10, 36, 1, 1, '2023-12-06 10:17:30', 8),
(84, 3, 17, 2, 1, '2023-12-06 10:12:57', 7),
(83, 2, 16, 2, 1, '2023-12-06 10:12:46', 7),
(82, 2, 14, 2, 1, '2023-12-06 10:12:27', 7),
(81, 10, 5, 3, 1, '2023-12-06 10:07:24', 6),
(80, 8, 16, 3, 1, '2023-12-05 10:09:56', 5),
(79, 6, 15, 3, 1, '2023-12-05 10:09:44', 5),
(78, 5, 2, 3, 1, '2023-12-05 10:09:23', 5),
(77, 30, 17, 3, 1, '2023-12-05 09:27:46', 4),
(76, 40, 16, 3, 1, '2023-12-05 09:27:28', 4),
(75, 20, 18, 3, 1, '2023-12-05 09:27:16', 4),
(74, 5, 1, 3, 1, '2023-12-05 09:12:18', 3),
(73, 5, 2, 5, 1, '2023-12-04 17:16:25', 2),
(72, 5, 1, 5, 1, '2023-12-04 17:16:14', 2),
(71, 6, 8, 3, 1, '2023-12-04 16:21:49', 1),
(70, 5, 7, 3, 1, '2023-12-04 16:21:32', 1),
(69, 20, 1, 3, 1, '2023-12-04 16:21:06', 1);

-- --------------------------------------------------------

--
-- Table structure for table `requests_summary`
--

DROP TABLE IF EXISTS `requests_summary`;
CREATE TABLE IF NOT EXISTS `requests_summary` (
  `RequestSummary_id` int NOT NULL,
  `NumOfBrands` int NOT NULL,
  `Department_id` int DEFAULT NULL,
  `Employee_id` int DEFAULT NULL,
  `RequestSummary_time` datetime NOT NULL,
  PRIMARY KEY (`RequestSummary_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `requests_summary`
--

INSERT INTO `requests_summary` (`RequestSummary_id`, `NumOfBrands`, `Department_id`, `Employee_id`, `RequestSummary_time`) VALUES
(8, 0, 1, 1, '2023-12-06 10:17:30'),
(7, 0, 2, 1, '2023-12-06 10:12:27'),
(6, 0, 3, 1, '2023-12-06 10:07:24'),
(5, 0, 3, 1, '2023-12-05 10:09:23'),
(4, 0, 3, 1, '2023-12-05 09:27:16'),
(3, 0, 3, 1, '2023-12-05 09:12:18'),
(2, 0, 5, 1, '2023-12-04 17:16:14'),
(1, 0, 3, 1, '2023-12-04 16:21:06');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
