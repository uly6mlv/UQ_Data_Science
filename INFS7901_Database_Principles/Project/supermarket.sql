-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 15, 2020 at 05:21 AM
-- Server version: 10.4.11-MariaDB
-- PHP Version: 7.4.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `supermarket`
--

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `CustomerID` int(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`CustomerID`) VALUES
(11000),
(11001),
(11002),
(11003),
(11004),
(11005),
(11007),
(11008),
(11009),
(11010),
(11011),
(11012),
(11013),
(11014),
(11015),
(11016),
(11017),
(11018),
(11019),
(11020),
(11021),
(11022),
(11023),
(11024),
(11025),
(11026),
(11027),
(11028),
(11029),
(11030),
(11031),
(11059),
(11060),
(11061),
(11062),
(11063);

-- --------------------------------------------------------

--
-- Table structure for table `guests`
--

CREATE TABLE `guests` (
  `CustomerID` int(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `guests`
--

INSERT INTO `guests` (`CustomerID`) VALUES
(11059),
(11060),
(11061),
(11062),
(11063);

-- --------------------------------------------------------

--
-- Table structure for table `members`
--

CREATE TABLE `members` (
  `CustomerID` int(5) NOT NULL,
  `FirstName` varchar(20) NOT NULL,
  `LastName` varchar(20) NOT NULL,
  `BirthDate` date NOT NULL,
  `Gender` varchar(1) NOT NULL,
  `EmailAddress` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `members`
--

INSERT INTO `members` (`CustomerID`, `FirstName`, `LastName`, `BirthDate`, `Gender`, `EmailAddress`) VALUES
(11000, 'JON', 'YANG', '1966-08-04', 'M', 'jon24@infs7901.com'),
(11001, 'EUGENE', 'HUANG', '1965-05-14', 'M', 'eugene10@infs7901.com'),
(11002, 'RUBEN', 'TORRES', '1965-08-12', 'M', 'ruben35@infs7901.com'),
(11003, 'CHRISTY', 'ZHU', '1968-02-15', 'F', 'christy12@infs7901.com'),
(11004, 'ELIZABETH', 'JOHNSON', '1968-08-08', 'F', 'elizabeth5@infs7901.com'),
(11005, 'JULIO', 'RUIZ', '0000-00-00', 'M', 'julio1@infs7901.com'),
(11007, 'MARCO', 'MEHTA', '1964-05-09', 'M', 'marco14@infs7901.com'),
(11008, 'ROBIN', 'VERHOFF', '1964-07-07', 'F', 'rob4@infs7901.com'),
(11009, 'SHANNON', 'CARLSON', '1964-04-01', 'M', 'shannon38@infs7901.com'),
(11010, 'JACQUELYN', 'SUAREZ', '1964-02-06', 'F', 'jacquelyn20@infs7901.com'),
(11011, 'CURTIS', 'LU', '1963-11-04', 'M', 'curtis9@infs7901.com'),
(11012, 'LAUREN', 'WALKER', '1968-01-18', 'F', 'lauren41@infs7901.com'),
(11013, 'IAN', 'JENKINS', '1968-08-06', 'M', 'ian47@infs7901.com'),
(11014, 'SYDNEY', 'BENNETT', '1968-05-09', 'F', 'sydney23@infs7901.com'),
(11015, 'CHLOE', 'YOUNG', '1979-02-27', 'F', 'chloe23@infs7901.com'),
(11016, 'WYATT', 'HILL', '1979-04-28', 'M', 'wyatt32@infs7901.com'),
(11017, 'SHANNON', 'WANG', '1944-06-26', 'F', 'shannon1@infs7901.com'),
(11018, 'CLARENCE', 'RAI', '1944-10-09', 'M', 'clarence32@infs7901.com'),
(11019, 'LUKE', 'LAL', '1978-03-07', 'M', 'luke18@infs7901.com'),
(11020, 'JORDAN', 'KING', '1978-09-20', 'M', 'jordan73@infs7901.com'),
(11021, 'DESTINY', 'WILSON', '1978-09-03', 'F', 'destiny7@infs7901.com'),
(11022, 'ETHAN', 'ZHANG', '1978-10-12', 'M', 'ethan20@infs7901.com'),
(11023, 'SETH', 'EDWARDS', '1978-10-11', 'M', 'seth46@infs7901.com'),
(11024, 'RUSSELL', 'XIE', '1978-09-17', 'M', 'russell7@infs7901.com'),
(11025, 'ALEJANDRO', 'BECK', '1945-12-23', 'M', 'alejandro45@infs7901.com'),
(11026, 'HAROLD', 'SAI', '1946-04-03', 'M', 'harold3@infs7901.com'),
(11027, 'JESSIE', 'ZHAO', '1946-12-07', 'M', 'jessie16@infs7901.com'),
(11028, 'JILL', 'JIMENEZ', '1946-04-11', 'F', 'jill13@infs7901.com'),
(11029, 'JIMMY', 'MORENO', '1946-12-21', 'M', 'jimmy9@infs7901.com'),
(11030, 'BETHANY', 'YUAN', '1947-02-22', 'F', 'bethany10@infs7901.com'),
(11031, 'THERESA', 'RAMOS', '1947-08-22', 'F', 'theresa13@infs7901.com');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `ProductID` int(3) NOT NULL,
  `ProductSubcategoryID` int(2) NOT NULL,
  `ProductSKU` varchar(10) NOT NULL,
  `ProductName` varchar(32) NOT NULL,
  `ModelName` varchar(30) NOT NULL,
  `ProductDescription` varchar(250) NOT NULL,
  `ProductColor` varchar(15) NOT NULL,
  `ProductSize` varchar(2) NOT NULL,
  `ProductStyle` varchar(1) NOT NULL,
  `ProductCost` decimal(8,4) NOT NULL,
  `ProductPrice` decimal(8,4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`ProductID`, `ProductSubcategoryID`, `ProductSKU`, `ProductName`, `ModelName`, `ProductDescription`, `ProductColor`, `ProductSize`, `ProductStyle`, `ProductCost`, `ProductPrice`) VALUES
(214, 31, 'HL-U509-R', 'Sport-100 Helmet, Red', 'Sport-100', 'Universal fit, well-vented, lightweight , snap-on visor.', 'Red', '0', '0', '13.0863', '34.9900'),
(215, 31, 'HL-U509', 'Sport-100 Helmet, Black', 'Sport-100', 'Universal fit, well-vented, lightweight , snap-on visor.', 'Black', '0', '0', '12.0278', '33.6442'),
(218, 23, 'SO-B909-M', 'Mountain Bike Socks, M', 'Mountain Bike Socks', 'Combination of natural and synthetic fibers stays dry and provides just the right cushioning.', 'White', 'M', 'U', '3.3963', '9.5000'),
(219, 23, 'SO-B909-L', 'Mountain Bike Socks, L', 'Mountain Bike Socks', 'Combination of natural and synthetic fibers stays dry and provides just the right cushioning.', 'White', 'L', 'U', '3.3963', '9.5000'),
(220, 31, 'HL-U509-B', 'Sport-100 Helmet, Blue', 'Sport-100', 'Universal fit, well-vented, lightweight , snap-on visor.', 'Blue', '0', '0', '12.0278', '33.6442'),
(223, 19, 'CA-1098', 'AWC Logo Cap', 'Cycling Cap', 'Traditional style with a flip-up brim; one-size fits all.', 'Multi', '0', 'U', '5.7052', '8.6442'),
(226, 21, 'LJ-0192-S', 'Long-Sleeve Logo Jersey, S', 'Long-Sleeve Logo Jersey', 'Unisex long-sleeve AWC logo microfiber cycling jersey', 'Multi', 'S', 'U', '31.7244', '48.0673'),
(229, 21, 'LJ-0192-M', 'Long-Sleeve Logo Jersey, M', 'Long-Sleeve Logo Jersey', 'Unisex long-sleeve AWC logo microfiber cycling jersey', 'Multi', 'M', 'U', '31.7244', '48.0673'),
(232, 21, 'LJ-0192-L', 'Long-Sleeve Logo Jersey, L', 'Long-Sleeve Logo Jersey', 'Unisex long-sleeve AWC logo microfiber cycling jersey', 'Multi', 'L', 'U', '31.7244', '48.0673'),
(235, 21, 'LJ-0192-X', 'Long-Sleeve Logo Jersey, XL', 'Long-Sleeve Logo Jersey', 'Unisex long-sleeve AWC logo microfiber cycling jersey', 'Multi', 'XL', 'U', '31.7244', '48.0673'),
(238, 14, 'FR-R92R-62', 'HL Road Frame - Red, 62', 'HL Road Frame', 'Our lightest and best quality aluminum frame made from the newest alloy; it is welded and heat-treated for strength. Our innovative design results in maximum comfort and performance.', 'Red', '62', 'U', '747.9682', '1263.4598'),
(241, 14, 'FR-R92R-44', 'HL Road Frame - Red, 44', 'HL Road Frame', 'Our lightest and best quality aluminum frame made from the newest alloy; it is welded and heat-treated for strength. Our innovative design results in maximum comfort and performance.', 'Red', '44', 'U', '747.9682', '1263.4598'),
(244, 14, 'FR-R92R-48', 'HL Road Frame - Red, 48', 'HL Road Frame', 'Our lightest and best quality aluminum frame made from the newest alloy; it is welded and heat-treated for strength. Our innovative design results in maximum comfort and performance.', 'Red', '48', 'U', '747.9682', '1263.4598'),
(247, 14, 'FR-R92R-52', 'HL Road Frame - Red, 52', 'HL Road Frame', 'Our lightest and best quality aluminum frame made from the newest alloy; it is welded and heat-treated for strength. Our innovative design results in maximum comfort and performance.', 'Red', '52', 'U', '747.9682', '1263.4598'),
(250, 14, 'FR-R92R-56', 'HL Road Frame - Red, 56', 'HL Road Frame', 'Our lightest and best quality aluminum frame made from the newest alloy; it is welded and heat-treated for strength. Our innovative design results in maximum comfort and performance.', 'Red', '56', 'U', '747.9682', '1263.4598'),
(253, 14, 'FR-R38B-58', 'LL Road Frame - Black, 58', 'LL Road Frame', 'The LL Frame provides a safe comfortable ride, while offering superior bump absorption in a value-priced aluminum frame.', 'Black', '58', 'U', '176.1997', '297.6346'),
(256, 14, 'FR-R38B-60', 'LL Road Frame - Black, 60', 'LL Road Frame', 'The LL Frame provides a safe comfortable ride, while offering superior bump absorption in a value-priced aluminum frame.', 'Black', '60', 'U', '176.1997', '297.6346'),
(259, 14, 'FR-R38B-62', 'LL Road Frame - Black, 62', 'LL Road Frame', 'The LL Frame provides a safe comfortable ride, while offering superior bump absorption in a value-priced aluminum frame.', 'Black', '62', 'U', '176.1997', '297.6346'),
(262, 14, 'FR-R38R-44', 'LL Road Frame - Red, 44', 'LL Road Frame', 'The LL Frame provides a safe comfortable ride, while offering superior bump absorption in a value-priced aluminum frame.', 'Red', '44', 'U', '181.4857', '306.5636'),
(264, 14, 'FR-R38R-48', 'LL Road Frame - Red, 48', 'LL Road Frame', 'The LL Frame provides a safe comfortable ride, while offering superior bump absorption in a value-priced aluminum frame.', 'Red', '48', 'U', '181.4857', '306.5636'),
(266, 14, 'FR-R38R-52', 'LL Road Frame - Red, 52', 'LL Road Frame', 'The LL Frame provides a safe comfortable ride, while offering superior bump absorption in a value-priced aluminum frame.', 'Red', '52', 'U', '181.4857', '306.5636'),
(268, 14, 'FR-R38R-58', 'LL Road Frame - Red, 58', 'LL Road Frame', 'The LL Frame provides a safe comfortable ride, while offering superior bump absorption in a value-priced aluminum frame.', 'Red', '58', 'U', '181.4857', '306.5636'),
(270, 14, 'FR-R38R-60', 'LL Road Frame - Red, 60', 'LL Road Frame', 'The LL Frame provides a safe comfortable ride, while offering superior bump absorption in a value-priced aluminum frame.', 'Red', '60', 'U', '181.4857', '306.5636'),
(272, 14, 'FR-R38R-62', 'LL Road Frame - Red, 62', 'LL Road Frame', 'The LL Frame provides a safe comfortable ride, while offering superior bump absorption in a value-priced aluminum frame.', 'Red', '62', 'U', '181.4857', '306.5636'),
(274, 14, 'FR-R72R-44', 'ML Road Frame - Red, 44', 'ML Road Frame', 'Made from the same aluminum alloy as our top-of-the line HL frame, the ML features a lightweight down-tube milled to the perfect diameter for optimal strength. Men\'s version.', 'Red', '44', 'U', '352.1394', '594.8300'),
(275, 14, 'FR-R72R-48', 'ML Road Frame - Red, 48', 'ML Road Frame', 'Made from the same aluminum alloy as our top-of-the line HL frame, the ML features a lightweight down-tube milled to the perfect diameter for optimal strength. Men\'s version.', 'Red', '48', 'U', '352.1394', '594.8300'),
(276, 14, 'FR-R72R-52', 'ML Road Frame - Red, 52', 'ML Road Frame', 'Made from the same aluminum alloy as our top-of-the line HL frame, the ML features a lightweight down-tube milled to the perfect diameter for optimal strength. Men\'s version.', 'Red', '52', 'U', '352.1394', '594.8300'),
(277, 14, 'FR-R72R-58', 'ML Road Frame - Red, 58', 'ML Road Frame', 'Made from the same aluminum alloy as our top-of-the line HL frame, the ML features a lightweight down-tube milled to the perfect diameter for optimal strength. Men\'s version.', 'Red', '58', 'U', '352.1394', '594.8300'),
(278, 14, 'FR-R72R-60', 'ML Road Frame - Red, 60', 'ML Road Frame', 'Made from the same aluminum alloy as our top-of-the line HL frame, the ML features a lightweight down-tube milled to the perfect diameter for optimal strength. Men\'s version.', 'Red', '60', 'U', '352.1394', '594.8300'),
(279, 14, 'FR-R38B-44', 'LL Road Frame - Black, 44', 'LL Road Frame', 'The LL Frame provides a safe comfortable ride, while offering superior bump absorption in a value-priced aluminum frame.', 'Black', '44', 'U', '176.1997', '297.6346'),
(282, 14, 'FR-R38B-48', 'LL Road Frame - Black, 48', 'LL Road Frame', 'The LL Frame provides a safe comfortable ride, while offering superior bump absorption in a value-priced aluminum frame.', 'Black', '48', 'U', '176.1997', '297.6346'),
(285, 14, 'FR-R38B-52', 'LL Road Frame - Black, 52', 'LL Road Frame', 'The LL Frame provides a safe comfortable ride, while offering superior bump absorption in a value-priced aluminum frame.', 'Black', '52', 'U', '176.1997', '297.6346'),
(288, 12, 'FR-M94S-42', 'HL Mountain Frame - Silver, 42', 'HL Mountain Frame', 'Each frame is hand-crafted in our Bothell facility to the optimum diameter and wall-thickness required of a premium mountain frame. The heat-treated welded aluminum frame has a larger diameter tube that absorbs the bumps.', 'Silver', '42', 'U', '623.8403', '1204.3248'),
(291, 12, 'FR-M94S-44', 'HL Mountain Frame - Silver, 44', 'HL Mountain Frame', 'Each frame is hand-crafted in our Bothell facility to the optimum diameter and wall-thickness required of a premium mountain frame. The heat-treated welded aluminum frame has a larger diameter tube that absorbs the bumps.', 'Silver', '44', 'U', '706.8110', '1364.5000'),
(292, 12, 'FR-M94S-52', 'HL Mountain Frame - Silver, 48', 'HL Mountain Frame', 'Each frame is hand-crafted in our Bothell facility to the optimum diameter and wall-thickness required of a premium mountain frame. The heat-treated welded aluminum frame has a larger diameter tube that absorbs the bumps.', 'Silver', '48', 'U', '706.8110', '1364.5000'),
(293, 12, 'FR-M94S-46', 'HL Mountain Frame - Silver, 46', 'HL Mountain Frame', 'Each frame is hand-crafted in our Bothell facility to the optimum diameter and wall-thickness required of a premium mountain frame. The heat-treated welded aluminum frame has a larger diameter tube that absorbs the bumps.', 'Silver', '46', 'U', '623.8403', '1204.3248'),
(296, 12, 'FR-M94B-42', 'HL Mountain Frame - Black, 42', 'HL Mountain Frame', 'Each frame is hand-crafted in our Bothell facility to the optimum diameter and wall-thickness required of a premium mountain frame. The heat-treated welded aluminum frame has a larger diameter tube that absorbs the bumps.', 'Black', '42', 'U', '617.0281', '1191.1739'),
(299, 12, 'FR-M94B-44', 'HL Mountain Frame - Black, 44', 'HL Mountain Frame', 'Each frame is hand-crafted in our Bothell facility to the optimum diameter and wall-thickness required of a premium mountain frame. The heat-treated welded aluminum frame has a larger diameter tube that absorbs the bumps.', 'Black', '44', 'U', '699.0928', '1349.6000'),
(300, 12, 'FR-M94B-48', 'HL Mountain Frame - Black, 48', 'HL Mountain Frame', 'Each frame is hand-crafted in our Bothell facility to the optimum diameter and wall-thickness required of a premium mountain frame. The heat-treated welded aluminum frame has a larger diameter tube that absorbs the bumps.', 'Black', '48', 'U', '699.0928', '1349.6000'),
(301, 12, 'FR-M94B-46', 'HL Mountain Frame - Black, 46', 'HL Mountain Frame', 'Each frame is hand-crafted in our Bothell facility to the optimum diameter and wall-thickness required of a premium mountain frame. The heat-treated welded aluminum frame has a larger diameter tube that absorbs the bumps.', 'Black', '46', 'U', '617.0281', '1191.1739'),
(304, 12, 'FR-M94B-38', 'HL Mountain Frame - Black, 38', 'HL Mountain Frame', 'Each frame is hand-crafted in our Bothell facility to the optimum diameter and wall-thickness required of a premium mountain frame. The heat-treated welded aluminum frame has a larger diameter tube that absorbs the bumps.', 'Black', '38', 'U', '617.0281', '1191.1739'),
(307, 12, 'FR-M94S-38', 'HL Mountain Frame - Silver, 38', 'HL Mountain Frame', 'Each frame is hand-crafted in our Bothell facility to the optimum diameter and wall-thickness required of a premium mountain frame. The heat-treated welded aluminum frame has a larger diameter tube that absorbs the bumps.', 'Silver', '38', 'U', '623.8403', '1204.3248'),
(310, 2, 'BK-R93R-62', 'Road-150 Red, 62', 'Road-150', 'This bike is ridden by race winners. Developed with the Adventure Works Cycles professional race team, it has a extremely light heat-treated aluminum frame, and steering that allows precision control.', 'Red', '62', 'U', '2171.2942', '3578.2700'),
(311, 2, 'BK-R93R-44', 'Road-150 Red, 44', 'Road-150', 'This bike is ridden by race winners. Developed with the Adventure Works Cycles professional race team, it has a extremely light heat-treated aluminum frame, and steering that allows precision control.', 'Red', '44', 'U', '2171.2942', '3578.2700'),
(312, 2, 'BK-R93R-48', 'Road-150 Red, 48', 'Road-150', 'This bike is ridden by race winners. Developed with the Adventure Works Cycles professional race team, it has a extremely light heat-treated aluminum frame, and steering that allows precision control.', 'Red', '48', 'U', '2171.2942', '3578.2700'),
(313, 2, 'BK-R93R-52', 'Road-150 Red, 52', 'Road-150', 'This bike is ridden by race winners. Developed with the Adventure Works Cycles professional race team, it has a extremely light heat-treated aluminum frame, and steering that allows precision control.', 'Red', '52', 'U', '2171.2942', '3578.2700'),
(314, 2, 'BK-R93R-56', 'Road-150 Red, 56', 'Road-150', 'This bike is ridden by race winners. Developed with the Adventure Works Cycles professional race team, it has a extremely light heat-treated aluminum frame, and steering that allows precision control.', 'Red', '56', 'U', '2171.2942', '3578.2700'),
(315, 2, 'BK-R68R-58', 'Road-450 Red, 58', 'Road-450', 'A true multi-sport bike that offers streamlined riding and a revolutionary design. Aerodynamic design lets you ride with the pros, and the gearing will conquer hilly roads.', 'Red', '58', 'U', '884.7083', '1457.9900'),
(316, 2, 'BK-R68R-60', 'Road-450 Red, 60', 'Road-450', 'A true multi-sport bike that offers streamlined riding and a revolutionary design. Aerodynamic design lets you ride with the pros, and the gearing will conquer hilly roads.', 'Red', '60', 'U', '884.7083', '1457.9900'),
(317, 2, 'BK-R68R-44', 'Road-450 Red, 44', 'Road-450', 'A true multi-sport bike that offers streamlined riding and a revolutionary design. Aerodynamic design lets you ride with the pros, and the gearing will conquer hilly roads.', 'Red', '44', 'U', '884.7083', '1457.9900'),
(318, 2, 'BK-R68R-48', 'Road-450 Red, 48', 'Road-450', 'A true multi-sport bike that offers streamlined riding and a revolutionary design. Aerodynamic design lets you ride with the pros, and the gearing will conquer hilly roads.', 'Red', '48', 'U', '884.7083', '1457.9900'),
(319, 2, 'BK-R68R-52', 'Road-450 Red, 52', 'Road-450', 'A true multi-sport bike that offers streamlined riding and a revolutionary design. Aerodynamic design lets you ride with the pros, and the gearing will conquer hilly roads.', 'Red', '52', 'U', '884.7083', '1457.9900'),
(320, 2, 'BK-R50R-58', 'Road-650 Red, 58', 'Road-650', 'Value-priced bike with many features of our top-of-the-line models. Has the same light, stiff frame, and the quick acceleration we\'re famous for.', 'Red', '58', 'U', '413.1463', '699.0982'),
(322, 2, 'BK-R50R-60', 'Road-650 Red, 60', 'Road-650', 'Value-priced bike with many features of our top-of-the-line models. Has the same light, stiff frame, and the quick acceleration we\'re famous for.', 'Red', '60', 'U', '413.1463', '699.0982'),
(324, 2, 'BK-R50R-62', 'Road-650 Red, 62', 'Road-650', 'Value-priced bike with many features of our top-of-the-line models. Has the same light, stiff frame, and the quick acceleration we\'re famous for.', 'Red', '62', 'U', '413.1463', '699.0982'),
(326, 2, 'BK-R50R-44', 'Road-650 Red, 44', 'Road-650', 'Value-priced bike with many features of our top-of-the-line models. Has the same light, stiff frame, and the quick acceleration we\'re famous for.', 'Red', '44', 'U', '413.1463', '699.0982'),
(328, 2, 'BK-R50R-48', 'Road-650 Red, 48', 'Road-650', 'Value-priced bike with many features of our top-of-the-line models. Has the same light, stiff frame, and the quick acceleration we\'re famous for.', 'Red', '48', 'U', '413.1463', '699.0982'),
(330, 2, 'BK-R50R-52', 'Road-650 Red, 52', 'Road-650', 'Value-priced bike with many features of our top-of-the-line models. Has the same light, stiff frame, and the quick acceleration we\'re famous for.', 'Red', '52', 'U', '413.1463', '699.0982'),
(332, 2, 'BK-R50B-58', 'Road-650 Black, 58', 'Road-650', 'Value-priced bike with many features of our top-of-the-line models. Has the same light, stiff frame, and the quick acceleration we\'re famous for.', 'Black', '58', 'U', '413.1463', '699.0982'),
(334, 2, 'BK-R50B-60', 'Road-650 Black, 60', 'Road-650', 'Value-priced bike with many features of our top-of-the-line models. Has the same light, stiff frame, and the quick acceleration we\'re famous for.', 'Black', '60', 'U', '413.1463', '699.0982'),
(336, 2, 'BK-R50B-62', 'Road-650 Black, 62', 'Road-650', 'Value-priced bike with many features of our top-of-the-line models. Has the same light, stiff frame, and the quick acceleration we\'re famous for.', 'Black', '62', 'U', '413.1463', '699.0982'),
(338, 2, 'BK-R50B-44', 'Road-650 Black, 44', 'Road-650', 'Value-priced bike with many features of our top-of-the-line models. Has the same light, stiff frame, and the quick acceleration we\'re famous for.', 'Black', '44', 'U', '413.1463', '699.0982'),
(340, 2, 'BK-R50B-48', 'Road-650 Black, 48', 'Road-650', 'Value-priced bike with many features of our top-of-the-line models. Has the same light, stiff frame, and the quick acceleration we\'re famous for.', 'Black', '48', 'U', '413.1463', '699.0982'),
(342, 2, 'BK-R50B-52', 'Road-650 Black, 52', 'Road-650', 'Value-priced bike with many features of our top-of-the-line models. Has the same light, stiff frame, and the quick acceleration we\'re famous for.', 'Black', '52', 'U', '413.1463', '699.0982'),
(344, 1, 'BK-M82S-38', 'Mountain-100 Silver, 38', 'Mountain-100', 'Top-of-the-line competition mountain bike. Performance-enhancing options include the innovative HL Frame, super-smooth front suspension, and traction for all terrain.', 'Silver', '38', 'U', '1912.1544', '3399.9900'),
(345, 1, 'BK-M82S-42', 'Mountain-100 Silver, 42', 'Mountain-100', 'Top-of-the-line competition mountain bike. Performance-enhancing options include the innovative HL Frame, super-smooth front suspension, and traction for all terrain.', 'Silver', '42', 'U', '1912.1544', '3399.9900'),
(346, 1, 'BK-M82S-44', 'Mountain-100 Silver, 44', 'Mountain-100', 'Top-of-the-line competition mountain bike. Performance-enhancing options include the innovative HL Frame, super-smooth front suspension, and traction for all terrain.', 'Silver', '44', 'U', '1912.1544', '3399.9900'),
(347, 1, 'BK-M82S-48', 'Mountain-100 Silver, 48', 'Mountain-100', 'Top-of-the-line competition mountain bike. Performance-enhancing options include the innovative HL Frame, super-smooth front suspension, and traction for all terrain.', 'Silver', '48', 'U', '1912.1544', '3399.9900'),
(348, 1, 'BK-M82B-38', 'Mountain-100 Black, 38', 'Mountain-100', 'Top-of-the-line competition mountain bike. Performance-enhancing options include the innovative HL Frame, super-smooth front suspension, and traction for all terrain.', 'Black', '38', 'U', '1898.0944', '3374.9900'),
(349, 1, 'BK-M82B-42', 'Mountain-100 Black, 42', 'Mountain-100', 'Top-of-the-line competition mountain bike. Performance-enhancing options include the innovative HL Frame, super-smooth front suspension, and traction for all terrain.', 'Black', '42', 'U', '1898.0944', '3374.9900'),
(350, 1, 'BK-M82B-44', 'Mountain-100 Black, 44', 'Mountain-100', 'Top-of-the-line competition mountain bike. Performance-enhancing options include the innovative HL Frame, super-smooth front suspension, and traction for all terrain.', 'Black', '44', 'U', '1898.0944', '3374.9900'),
(351, 1, 'BK-M82B-48', 'Mountain-100 Black, 48', 'Mountain-100', 'Top-of-the-line competition mountain bike. Performance-enhancing options include the innovative HL Frame, super-smooth front suspension, and traction for all terrain.', 'Black', '48', 'U', '1898.0944', '3374.9900'),
(352, 1, 'BK-M68S-38', 'Mountain-200 Silver, 38', 'Mountain-200', 'Serious back-country riding. Perfect for all levels of competition. Uses the same HL Frame as the Mountain-100.', 'Silver', '38', 'U', '1117.8559', '2071.4196'),
(354, 1, 'BK-M68S-42', 'Mountain-200 Silver, 42', 'Mountain-200', 'Serious back-country riding. Perfect for all levels of competition. Uses the same HL Frame as the Mountain-100.', 'Silver', '42', 'U', '1117.8559', '2071.4196'),
(356, 1, 'BK-M68S-46', 'Mountain-200 Silver, 46', 'Mountain-200', 'Serious back-country riding. Perfect for all levels of competition. Uses the same HL Frame as the Mountain-100.', 'Silver', '46', 'U', '1117.8559', '2071.4196'),
(358, 1, 'BK-M68B-38', 'Mountain-200 Black, 38', 'Mountain-200', 'Serious back-country riding. Perfect for all levels of competition. Uses the same HL Frame as the Mountain-100.', 'Black', '38', 'U', '1105.8100', '2049.0982'),
(360, 1, 'BK-M68B-42', 'Mountain-200 Black, 42', 'Mountain-200', 'Serious back-country riding. Perfect for all levels of competition. Uses the same HL Frame as the Mountain-100.', 'Black', '42', 'U', '1105.8100', '2049.0982'),
(362, 1, 'BK-M68B-46', 'Mountain-200 Black, 46', 'Mountain-200', 'Serious back-country riding. Perfect for all levels of competition. Uses the same HL Frame as the Mountain-100.', 'Black', '46', 'U', '1105.8100', '2049.0982'),
(364, 1, 'BK-M47B-38', 'Mountain-300 Black, 38', 'Mountain-300', 'For true trail addicts.  An extremely durable bike that will go anywhere and keep you in control on challenging terrain - without breaking your budget.', 'Black', '38', 'U', '598.4354', '1079.9900'),
(365, 1, 'BK-M47B-40', 'Mountain-300 Black, 40', 'Mountain-300', 'For true trail addicts.  An extremely durable bike that will go anywhere and keep you in control on challenging terrain - without breaking your budget.', 'Black', '40', 'U', '598.4354', '1079.9900'),
(366, 1, 'BK-M47B-44', 'Mountain-300 Black, 44', 'Mountain-300', 'For true trail addicts.  An extremely durable bike that will go anywhere and keep you in control on challenging terrain - without breaking your budget.', 'Black', '44', 'U', '598.4354', '1079.9900'),
(367, 1, 'BK-M47B-48', 'Mountain-300 Black, 48', 'Mountain-300', 'For true trail addicts.  An extremely durable bike that will go anywhere and keep you in control on challenging terrain - without breaking your budget.', 'Black', '48', 'U', '598.4354', '1079.9900'),
(368, 2, 'BK-R89R-44', 'Road-250 Red, 44', 'Road-250', 'Alluminum-alloy frame provides a light, stiff ride, whether you are racing in the velodrome or on a demanding club ride on country roads.', 'Red', '44', 'U', '1518.7864', '2443.3500'),
(369, 2, 'BK-R89R-48', 'Road-250 Red, 48', 'Road-250', 'Alluminum-alloy frame provides a light, stiff ride, whether you are racing in the velodrome or on a demanding club ride on country roads.', 'Red', '48', 'U', '1518.7864', '2443.3500'),
(370, 2, 'BK-R89R-52', 'Road-250 Red, 52', 'Road-250', 'Alluminum-alloy frame provides a light, stiff ride, whether you are racing in the velodrome or on a demanding club ride on country roads.', 'Red', '52', 'U', '1518.7864', '2443.3500'),
(371, 2, 'BK-R89R-58', 'Road-250 Red, 58', 'Road-250', 'Alluminum-alloy frame provides a light, stiff ride, whether you are racing in the velodrome or on a demanding club ride on country roads.', 'Red', '58', 'U', '1320.6838', '2181.5625'),
(373, 2, 'BK-R89B-44', 'Road-250 Black, 44', 'Road-250', 'Alluminum-alloy frame provides a light, stiff ride, whether you are racing in the velodrome or on a demanding club ride on country roads.', 'Black', '44', 'U', '1320.6838', '2181.5625'),
(375, 2, 'BK-R89B-48', 'Road-250 Black, 48', 'Road-250', 'Alluminum-alloy frame provides a light, stiff ride, whether you are racing in the velodrome or on a demanding club ride on country roads.', 'Black', '48', 'U', '1320.6838', '2181.5625'),
(377, 2, 'BK-R89B-52', 'Road-250 Black, 52', 'Road-250', 'Alluminum-alloy frame provides a light, stiff ride, whether you are racing in the velodrome or on a demanding club ride on country roads.', 'Black', '52', 'U', '1320.6838', '2181.5625'),
(379, 2, 'BK-R89B-58', 'Road-250 Black, 58', 'Road-250', 'Alluminum-alloy frame provides a light, stiff ride, whether you are racing in the velodrome or on a demanding club ride on country roads.', 'Black', '58', 'U', '1320.6838', '2181.5625'),
(381, 2, 'BK-R64Y-38', 'Road-550-W Yellow, 38', 'Road-550-W', 'Same technology as all of our Road series bikes, but the frame is sized for a woman.  Perfect all-around bike for road or racing.', 'Yellow', '38', 'W', '605.6492', '1000.4375'),
(383, 2, 'BK-R64Y-40', 'Road-550-W Yellow, 40', 'Road-550-W', 'Same technology as all of our Road series bikes, but the frame is sized for a woman.  Perfect all-around bike for road or racing.', 'Yellow', '40', 'W', '605.6492', '1000.4375'),
(385, 2, 'BK-R64Y-42', 'Road-550-W Yellow, 42', 'Road-550-W', 'Same technology as all of our Road series bikes, but the frame is sized for a woman.  Perfect all-around bike for road or racing.', 'Yellow', '42', 'W', '605.6492', '1000.4375'),
(387, 2, 'BK-R64Y-44', 'Road-550-W Yellow, 44', 'Road-550-W', 'Same technology as all of our Road series bikes, but the frame is sized for a woman.  Perfect all-around bike for road or racing.', 'Yellow', '44', 'W', '605.6492', '1000.4375'),
(389, 2, 'BK-R64Y-48', 'Road-550-W Yellow, 48', 'Road-550-W', 'Same technology as all of our Road series bikes, but the frame is sized for a woman.  Perfect all-around bike for road or racing.', 'Yellow', '48', 'W', '605.6492', '1000.4375'),
(391, 10, 'FK-1639', 'LL Fork', 'LL Fork', 'Stout design absorbs shock and offers more precise steering.', 'NA', '0', '0', '65.8097', '148.2200'),
(392, 10, 'FK-5136', 'ML Fork', 'ML Fork', 'Composite road fork with an aluminum steerer tube.', 'NA', '0', '0', '77.9176', '175.4900'),
(393, 10, 'FK-9939', 'HL Fork', 'HL Fork', 'High-performance carbon road fork with curved legs.', 'NA', '0', '0', '101.8936', '229.4900'),
(394, 11, 'HS-0296', 'LL Headset', 'LL Headset', 'Threadless headset provides quality at an economical price.', 'NA', '0', '0', '15.1848', '34.2000'),
(395, 11, 'HS-2451', 'ML Headset', 'ML Headset', 'Sealed cartridge keeps dirt out.', 'NA', '0', '0', '45.4168', '102.2900'),
(396, 11, 'HS-3479', 'HL Headset', 'HL Headset', 'High-quality 1\" threadless headset with a grease port for quick lubrication.', 'NA', '0', '0', '55.3801', '124.7300'),
(397, 4, 'HB-M243', 'LL Mountain Handlebars', 'LL Mountain Handlebars', 'All-purpose bar for on or off-road.', 'NA', '0', '0', '17.9780', '40.4909'),
(399, 4, 'HB-M763', 'ML Mountain Handlebars', 'ML Mountain Handlebars', 'Tough aluminum alloy bars for downhill.', 'NA', '0', '0', '24.9932', '56.2909'),
(401, 4, 'HB-M918', 'HL Mountain Handlebars', 'HL Mountain Handlebars', 'Flat bar strong enough for the pro circuit.', 'NA', '0', '0', '48.5453', '109.3364'),
(403, 4, 'HB-R504', 'LL Road Handlebars', 'LL Road Handlebars', 'Unique shape provides easier reach to the levers.', 'NA', '0', '0', '17.9780', '40.4909'),
(405, 4, 'HB-R720', 'ML Road Handlebars', 'ML Road Handlebars', 'Anatomically shaped aluminum tube bar will suit all riders.', 'NA', '0', '0', '24.9932', '56.2909'),
(407, 4, 'HB-R956', 'HL Road Handlebars', 'HL Road Handlebars', 'Designed for racers; high-end anatomically shaped bar from aluminum alloy.', 'NA', '0', '0', '48.5453', '109.3364'),
(409, 12, 'FR-M63B-38', 'ML Mountain Frame - Black, 38', 'ML Mountain Frame-W', 'The ML frame is a heat-treated aluminum frame made with the same detail and quality as our HL frame. It offers superior performance. Men\'s version.', 'Black', '38', 'U', '185.8193', '348.7600'),
(410, 17, 'FW-M423', 'LL Mountain Front Wheel', 'LL Mountain Front Wheel', 'Replacement mountain wheel for entry-level rider.', 'Black', '0', '0', '26.9708', '60.7450'),
(411, 17, 'FW-M762', 'ML Mountain Front Wheel', 'ML Mountain Front Wheel', 'Replacement mountain wheel for the casual to serious rider.', 'Black', '0', '0', '92.8071', '209.0250'),
(412, 17, 'FW-M928', 'HL Mountain Front Wheel', 'HL Mountain Front Wheel', 'High-performance mountain replacement wheel.', 'Black', '0', '0', '133.2955', '300.2150'),
(413, 17, 'FW-R623', 'LL Road Front Wheel', 'LL Road Front Wheel', 'Replacement road front wheel for entry-level cyclist.', 'Black', '0', '0', '37.9909', '85.5650'),
(414, 17, 'FW-R762', 'ML Road Front Wheel', 'ML Road Front Wheel', 'Sturdy alloy features a quick-release hub.', 'Black', '0', '0', '110.2829', '248.3850'),
(415, 17, 'FW-R820', 'HL Road Front Wheel', 'HL Road Front Wheel', 'Strong wheel with double-walled rim.', 'Black', '0', '0', '146.5466', '330.0600'),
(416, 17, 'FW-T905', 'Touring Front Wheel', 'Touring Front Wheel', 'Aerodynamic rims for smooth riding.', 'Black', '0', '0', '96.7964', '218.0100'),
(417, 14, 'FR-R72Y-38', 'ML Road Frame-W - Yellow, 38', 'ML Road Frame-W', 'Made from the same aluminum alloy as our top-of-the line HL frame, the ML features a lightweight down-tube milled to the perfect diameter for optimal strength. Women\'s version.', 'Yellow', '38', 'W', '300.1188', '540.7545'),
(419, 17, 'RW-M423', 'LL Mountain Rear Wheel', 'LL Mountain Rear Wheel', 'Replacement mountain wheel for entry-level rider.', 'Black', '0', '0', '38.9588', '87.7450'),
(420, 17, 'RW-M762', 'ML Mountain Rear Wheel', 'ML Mountain Rear Wheel', 'Replacement mountain wheel for the casual to serious rider.', 'Black', '0', '0', '104.7951', '236.0250'),
(421, 17, 'RW-M928', 'HL Mountain Rear Wheel', 'HL Mountain Rear Wheel', 'High-performance mountain replacement wheel.', 'Black', '0', '0', '145.2835', '327.2150'),
(422, 17, 'RW-R623', 'LL Road Rear Wheel', 'LL Road Rear Wheel', 'Replacement road rear wheel for entry-level cyclist.', 'Black', '0', '0', '49.9789', '112.5650'),
(423, 17, 'RW-R762', 'ML Road Rear Wheel', 'ML Road Rear Wheel', 'Aluminum alloy rim with stainless steel spokes; built for speed.', 'Black', '0', '0', '122.2709', '275.3850'),
(424, 17, 'RW-R820', 'HL Road Rear Wheel', 'HL Road Rear Wheel', 'Strong rear wheel with double-walled rim.', 'Black', '0', '0', '158.5346', '357.0600'),
(425, 17, 'RW-T905', 'Touring Rear Wheel', 'Touring Rear Wheel', 'Excellent aerodynamic rims guarantee a smooth ride.', 'Black', '0', '0', '108.7844', '245.0100'),
(426, 12, 'FR-M63B-40', 'ML Mountain Frame - Black, 40', 'ML Mountain Frame', 'The ML frame is a heat-treated aluminum frame made with the same detail and quality as our HL frame. It offers superior performance. Women\'s version.', 'Black', '40', 'U', '185.8193', '348.7600'),
(427, 12, 'FR-M63B-44', 'ML Mountain Frame - Black, 44', 'ML Mountain Frame', 'The ML frame is a heat-treated aluminum frame made with the same detail and quality as our HL frame. It offers superior performance. Women\'s version.', 'Black', '44', 'U', '185.8193', '348.7600'),
(428, 12, 'FR-M63B-48', 'ML Mountain Frame - Black, 48', 'ML Mountain Frame', 'The ML frame is a heat-treated aluminum frame made with the same detail and quality as our HL frame. It offers superior performance. Women\'s version.', 'Black', '48', 'U', '185.8193', '348.7600'),
(429, 14, 'FR-R72Y-40', 'ML Road Frame-W - Yellow, 40', 'ML Road Frame-W', 'Made from the same aluminum alloy as our top-of-the line HL frame, the ML features a lightweight down-tube milled to the perfect diameter for optimal strength. Women\'s version.', 'Yellow', '40', 'W', '300.1188', '540.7545'),
(431, 14, 'FR-R72Y-42', 'ML Road Frame-W - Yellow, 42', 'ML Road Frame-W', 'Made from the same aluminum alloy as our top-of-the line HL frame, the ML features a lightweight down-tube milled to the perfect diameter for optimal strength. Women\'s version.', 'Yellow', '42', 'W', '300.1188', '540.7545'),
(433, 14, 'FR-R72Y-44', 'ML Road Frame-W - Yellow, 44', 'ML Road Frame-W', 'Made from the same aluminum alloy as our top-of-the line HL frame, the ML features a lightweight down-tube milled to the perfect diameter for optimal strength. Women\'s version.', 'Yellow', '44', 'W', '300.1188', '540.7545'),
(435, 14, 'FR-R72Y-48', 'ML Road Frame-W - Yellow, 48', 'ML Road Frame-W', 'Made from the same aluminum alloy as our top-of-the line HL frame, the ML features a lightweight down-tube milled to the perfect diameter for optimal strength. Women\'s version.', 'Yellow', '48', 'W', '300.1188', '540.7545'),
(437, 14, 'FR-R92B-62', 'HL Road Frame - Black, 62', 'HL Road Frame', 'Our lightest and best quality aluminum frame made from the newest alloy; it is welded and heat-treated for strength. Our innovative design results in maximum comfort and performance.', 'Black', '62', 'U', '722.2568', '1301.3636'),
(439, 14, 'FR-R92B-44', 'HL Road Frame - Black, 44', 'HL Road Frame', 'Our lightest and best quality aluminum frame made from the newest alloy; it is welded and heat-treated for strength. Our innovative design results in maximum comfort and performance.', 'Black', '44', 'U', '722.2568', '1301.3636'),
(441, 14, 'FR-R92B-48', 'HL Road Frame - Black, 48', 'HL Road Frame', 'Our lightest and best quality aluminum frame made from the newest alloy; it is welded and heat-treated for strength. Our innovative design results in maximum comfort and performance.', 'Black', '48', 'U', '722.2568', '1301.3636'),
(443, 14, 'FR-R92B-52', 'HL Road Frame - Black, 52', 'HL Road Frame', 'Our lightest and best quality aluminum frame made from the newest alloy; it is welded and heat-treated for strength. Our innovative design results in maximum comfort and performance.', 'Black', '52', 'U', '722.2568', '1301.3636'),
(445, 22, 'SH-M897-S', 'Men\'s Sports Shorts, S', 'Men\'s Sports Shorts', 'Men\'s 8-panel racing shorts - lycra with an elastic waistband and leg grippers.', 'Black', 'S', 'M', '24.7459', '59.9900'),
(446, 35, 'PA-T100', 'Touring-Panniers, Large', 'Touring-Panniers', 'Durable, water-proof nylon construction with easy access. Large enough for weekend trips.', 'Grey', '0', '0', '51.5625', '125.0000'),
(447, 34, 'LO-C100', 'Cable Lock', 'Cable Lock', 'Wraps to fit front and rear tires, carrier and 2 keys included.', 'NA', '0', '0', '10.3125', '25.0000'),
(448, 36, 'PU-0452', 'Minipump', 'Minipump', 'Designed for convenience. Fits in your pocket. Aluminum barrel. 160psi rated.', 'NA', '0', '0', '8.2459', '19.9900'),
(449, 36, 'PU-M044', 'Mountain Pump', 'Mountain Pump', 'Simple and light-weight. Emergency patches stored in handle.', 'NA', '0', '0', '10.3084', '24.9900'),
(450, 33, 'LT-T990', 'Taillights - Battery-Powered', 'Taillight', 'Affordable light for safe night riding - uses 3 AAA batteries', 'NA', '0', '0', '5.7709', '13.9900'),
(451, 33, 'LT-H902', 'Headlights - Dual-Beam', 'Headlights - Dual-Beam', 'Rechargeable dual-beam headlight.', 'NA', '0', '0', '14.4334', '34.9900'),
(452, 33, 'LT-H903', 'Headlights - Weatherproof', 'Headlights - Weatherproof', 'Rugged weatherproof headlight.', 'NA', '0', '0', '18.5584', '44.9900'),
(453, 22, 'SH-M897-M', 'Men\'s Sports Shorts, M', 'Men\'s Sports Shorts', 'Men\'s 8-panel racing shorts - lycra with an elastic waistband and leg grippers.', 'Black', 'M', 'M', '24.7459', '59.9900'),
(454, 22, 'SH-M897-L', 'Men\'s Sports Shorts, L', 'Men\'s Sports Shorts', 'Men\'s 8-panel racing shorts - lycra with an elastic waistband and leg grippers.', 'Black', 'L', 'M', '24.7459', '59.9900'),
(455, 22, 'SH-M897-X', 'Men\'s Sports Shorts, XL', 'Men\'s Sports Shorts', 'Men\'s 8-panel racing shorts - lycra with an elastic waistband and leg grippers.', 'Black', 'XL', 'M', '24.7459', '59.9900'),
(456, 24, 'TG-W091-S', 'Women\'s Tights, S', 'Women\'s Tights', 'Warm spandex tights for winter riding; seamless chamois construction eliminates pressure points.', 'Black', 'S', 'W', '30.9334', '74.9900'),
(457, 24, 'TG-W091-M', 'Women\'s Tights, M', 'Women\'s Tights', 'Warm spandex tights for winter riding; seamless chamois construction eliminates pressure points.', 'Black', 'M', 'W', '30.9334', '74.9900'),
(458, 24, 'TG-W091-L', 'Women\'s Tights, L', 'Women\'s Tights', 'Warm spandex tights for winter riding; seamless chamois construction eliminates pressure points.', 'Black', 'L', 'W', '30.9334', '74.9900'),
(459, 18, 'SB-M891-S', 'Men\'s Bib-Shorts, S', 'Men\'s Bib-Shorts', 'Designed for the AWC team with stay-put straps, moisture-control, chamois padding, and leg grippers.', 'Multi', 'S', 'M', '37.1209', '89.9900'),
(460, 18, 'SB-M891-M', 'Men\'s Bib-Shorts, M', 'Men\'s Bib-Shorts', 'Designed for the AWC team with stay-put straps, moisture-control, chamois padding, and leg grippers.', 'Multi', 'M', 'M', '37.1209', '89.9900'),
(461, 18, 'SB-M891-L', 'Men\'s Bib-Shorts, L', 'Men\'s Bib-Shorts', 'Designed for the AWC team with stay-put straps, moisture-control, chamois padding, and leg grippers.', 'Multi', 'L', 'M', '37.1209', '89.9900'),
(462, 20, 'GL-H102-S', 'Half-Finger Gloves, S', 'Half-Finger Gloves', 'Full padding, improved finger flex, durable palm, adjustable closure.', 'Black', 'S', 'U', '9.7136', '23.5481'),
(464, 20, 'GL-H102-M', 'Half-Finger Gloves, M', 'Half-Finger Gloves', 'Full padding, improved finger flex, durable palm, adjustable closure.', 'Black', 'M', 'U', '9.7136', '23.5481'),
(466, 20, 'GL-H102-L', 'Half-Finger Gloves, L', 'Half-Finger Gloves', 'Full padding, improved finger flex, durable palm, adjustable closure.', 'Black', 'L', 'U', '9.7136', '23.5481'),
(468, 20, 'GL-F110-S', 'Full-Finger Gloves, S', 'Full-Finger Gloves', 'Synthetic palm, flexible knuckles, breathable mesh upper. Worn by the AWC team riders.', 'Black', 'S', 'U', '15.6709', '37.9900'),
(469, 20, 'GL-F110-M', 'Full-Finger Gloves, M', 'Full-Finger Gloves', 'Synthetic palm, flexible knuckles, breathable mesh upper. Worn by the AWC team riders.', 'Black', 'M', 'U', '15.6709', '37.9900'),
(470, 20, 'GL-F110-L', 'Full-Finger Gloves, L', 'Full-Finger Gloves', 'Synthetic palm, flexible knuckles, breathable mesh upper. Worn by the AWC team riders.', 'Black', 'L', 'U', '15.6709', '37.9900'),
(471, 25, 'VE-C304-S', 'Classic Vest, S', 'Classic Vest', 'Light-weight, wind-resistant, packs to fit into a pocket.', 'Blue', 'S', 'U', '23.7490', '63.5000'),
(472, 25, 'VE-C304-M', 'Classic Vest, M', 'Classic Vest', 'Light-weight, wind-resistant, packs to fit into a pocket.', 'Blue', 'M', 'U', '23.7490', '63.5000'),
(473, 25, 'VE-C304-L', 'Classic Vest, L', 'Classic Vest', 'Light-weight, wind-resistant, packs to fit into a pocket.', 'Blue', 'L', 'U', '23.7490', '63.5000'),
(474, 22, 'SH-W890-S', 'Women\'s Mountain Shorts, S', 'Women\'s Mountain Shorts', 'Heavy duty, abrasion-resistant shorts feature seamless, lycra inner shorts with anti-bacterial chamois for comfort.', 'Black', 'S', 'W', '26.1763', '69.9900'),
(475, 22, 'SH-W890-M', 'Women\'s Mountain Shorts, M', 'Women\'s Mountain Shorts', 'Heavy duty, abrasion-resistant shorts feature seamless, lycra inner shorts with anti-bacterial chamois for comfort.', 'Black', 'M', 'W', '26.1763', '69.9900'),
(476, 22, 'SH-W890-L', 'Women\'s Mountain Shorts, L', 'Women\'s Mountain Shorts', 'Heavy duty, abrasion-resistant shorts feature seamless, lycra inner shorts with anti-bacterial chamois for comfort.', 'Black', 'L', 'W', '26.1763', '69.9900'),
(477, 28, 'WB-H098', 'Water Bottle - 30 oz.', 'Water Bottle', 'AWC logo water bottle - holds 30 oz; leak-proof.', 'NA', '0', '0', '1.8663', '4.9900'),
(478, 28, 'BC-M005', 'Mountain Bottle Cage', 'Mountain Bottle Cage', 'Tough aluminum cage holds bottle securly on tough terrain.', 'NA', '0', '0', '3.7363', '9.9900'),
(479, 28, 'BC-R205', 'Road Bottle Cage', 'Road Bottle Cage', 'Aluminum cage is lighter than our mountain version; perfect for long distance trips.', 'NA', '0', '0', '3.3623', '8.9900'),
(480, 37, 'PK-7098', 'Patch Kit/8 Patches', 'Patch kit', 'Includes 8 different size patches, glue and sandpaper.', 'NA', '0', '0', '0.8565', '2.2900'),
(481, 23, 'SO-R809-M', 'Racing Socks, M', 'Racing Socks', 'Thin, lightweight and durable with cuffs that stay up.', 'White', 'M', 'U', '3.3623', '8.9900'),
(482, 23, 'SO-R809-L', 'Racing Socks, L', 'Racing Socks', 'Thin, lightweight and durable with cuffs that stay up.', 'White', 'L', 'U', '3.3623', '8.9900'),
(483, 26, 'RA-H123', 'Hitch Rack - 4-Bike', 'Hitch Rack - 4-Bike', 'Carries 4 bikes securely; steel construction, fits 2\" receiver hitch.', 'NA', '0', '0', '44.8800', '120.0000'),
(484, 29, 'CL-9009', 'Bike Wash - Dissolver', 'Bike Wash', 'Washes off the toughest road grime; dissolves grease, environmentally safe. 1-liter bottle.', 'NA', '0', '0', '2.9733', '7.9500'),
(485, 30, 'FE-6654', 'Fender Set - Mountain', 'Fender Set - Mountain', 'Clip-on fenders fit most mountain bikes.', 'NA', '0', '0', '8.2205', '21.9800'),
(486, 27, 'ST-1401', 'All-Purpose Bike Stand', 'All-Purpose Bike Stand', 'Perfect all-purpose bike stand for working on your bike at home. Quick-adjusting clamps and steel construction.', 'NA', '0', '0', '59.4660', '159.0000'),
(487, 32, 'HY-1023-70', 'Hydration Pack - 70 oz.', 'Hydration Pack', 'Versatile 70 oz hydration pack offers extra storage, easy-fill access, and a waist belt.', 'Silver', '70', '0', '20.5663', '54.9900'),
(488, 21, 'SJ-0194-S', 'Short-Sleeve Classic Jersey, S', 'Short-Sleeve Classic Jersey', 'Short sleeve classic breathable jersey with superior moisture control, front zipper, and 3 back pockets.', 'Yellow', 'S', 'U', '41.5723', '53.9900'),
(489, 21, 'SJ-0194-M', 'Short-Sleeve Classic Jersey, M', 'Short-Sleeve Classic Jersey', 'Short sleeve classic breathable jersey with superior moisture control, front zipper, and 3 back pockets.', 'Yellow', 'M', 'U', '41.5723', '53.9900'),
(490, 21, 'SJ-0194-L', 'Short-Sleeve Classic Jersey, L', 'Short-Sleeve Classic Jersey', 'Short sleeve classic breathable jersey with superior moisture control, front zipper, and 3 back pockets.', 'Yellow', 'L', 'U', '41.5723', '53.9900'),
(491, 21, 'SJ-0194-X', 'Short-Sleeve Classic Jersey, XL', 'Short-Sleeve Classic Jersey', 'Short sleeve classic breathable jersey with superior moisture control, front zipper, and 3 back pockets.', 'Yellow', 'XL', 'U', '41.5723', '53.9900'),
(492, 16, 'FR-T98Y-60', 'HL Touring Frame - Yellow, 60', 'HL Touring Frame', 'The HL aluminum frame is custom-shaped for both good looks and strength; it will withstand the most rigorous challenges of daily riding. Men\'s version.', 'Yellow', '60', 'U', '601.7437', '1003.9100'),
(493, 16, 'FR-T67Y-62', 'LL Touring Frame - Yellow, 62', 'LL Touring Frame', 'Lightweight butted aluminum frame provides a more upright riding position for a trip around town.  Our ground-breaking design provides optimum comfort.', 'Yellow', '62', 'U', '199.8519', '333.4200'),
(494, 16, 'FR-T98Y-46', 'HL Touring Frame - Yellow, 46', 'HL Touring Frame', 'The HL aluminum frame is custom-shaped for both good looks and strength; it will withstand the most rigorous challenges of daily riding. Men\'s version.', 'Yellow', '46', 'U', '601.7437', '1003.9100'),
(495, 16, 'FR-T98Y-50', 'HL Touring Frame - Yellow, 50', 'HL Touring Frame', 'The HL aluminum frame is custom-shaped for both good looks and strength; it will withstand the most rigorous challenges of daily riding. Men\'s version.', 'Yellow', '50', 'U', '601.7437', '1003.9100'),
(496, 16, 'FR-T98Y-54', 'HL Touring Frame - Yellow, 54', 'HL Touring Frame', 'The HL aluminum frame is custom-shaped for both good looks and strength; it will withstand the most rigorous challenges of daily riding. Men\'s version.', 'Yellow', '54', 'U', '601.7437', '1003.9100'),
(497, 16, 'FR-T98U-46', 'HL Touring Frame - Blue, 46', 'HL Touring Frame', 'The HL aluminum frame is custom-shaped for both good looks and strength; it will withstand the most rigorous challenges of daily riding. Men\'s version.', 'Blue', '46', 'U', '601.7437', '1003.9100'),
(498, 16, 'FR-T98U-50', 'HL Touring Frame - Blue, 50', 'HL Touring Frame', 'The HL aluminum frame is custom-shaped for both good looks and strength; it will withstand the most rigorous challenges of daily riding. Men\'s version.', 'Blue', '50', 'U', '601.7437', '1003.9100'),
(499, 16, 'FR-T98U-54', 'HL Touring Frame - Blue, 54', 'HL Touring Frame', 'The HL aluminum frame is custom-shaped for both good looks and strength; it will withstand the most rigorous challenges of daily riding. Men\'s version.', 'Blue', '54', 'U', '601.7437', '1003.9100'),
(500, 16, 'FR-T98U-60', 'HL Touring Frame - Blue, 60', 'HL Touring Frame', 'The HL aluminum frame is custom-shaped for both good looks and strength; it will withstand the most rigorous challenges of daily riding. Men\'s version.', 'Blue', '60', 'U', '601.7437', '1003.9100'),
(501, 9, 'RD-2308', 'Rear Derailleur', 'Rear Derailleur', 'Wide-link design.', 'Silver', '0', '0', '53.9282', '121.4600'),
(502, 16, 'FR-T67U-50', 'LL Touring Frame - Blue, 50', 'LL Touring Frame', 'Lightweight butted aluminum frame provides a more upright riding position for a trip around town.  Our ground-breaking design provides optimum comfort.', 'Blue', '50', 'U', '199.8519', '333.4200'),
(503, 16, 'FR-T67U-54', 'LL Touring Frame - Blue, 54', 'LL Touring Frame', 'Lightweight butted aluminum frame provides a more upright riding position for a trip around town.  Our ground-breaking design provides optimum comfort.', 'Blue', '54', 'U', '199.8519', '333.4200'),
(504, 16, 'FR-T67U-58', 'LL Touring Frame - Blue, 58', 'LL Touring Frame', 'Lightweight butted aluminum frame provides a more upright riding position for a trip around town.  Our ground-breaking design provides optimum comfort.', 'Blue', '58', 'U', '199.8519', '333.4200'),
(505, 16, 'FR-T67U-62', 'LL Touring Frame - Blue, 62', 'LL Touring Frame', 'Lightweight butted aluminum frame provides a more upright riding position for a trip around town.  Our ground-breaking design provides optimum comfort.', 'Blue', '62', 'U', '199.8519', '333.4200'),
(506, 16, 'FR-T67Y-44', 'LL Touring Frame - Yellow, 44', 'LL Touring Frame', 'Lightweight butted aluminum frame provides a more upright riding position for a trip around town.  Our ground-breaking design provides optimum comfort.', 'Yellow', '44', 'U', '199.8519', '333.4200'),
(507, 16, 'FR-T67Y-50', 'LL Touring Frame - Yellow, 50', 'LL Touring Frame', 'Lightweight butted aluminum frame provides a more upright riding position for a trip around town.  Our ground-breaking design provides optimum comfort.', 'Yellow', '50', 'U', '199.8519', '333.4200'),
(508, 16, 'FR-T67Y-54', 'LL Touring Frame - Yellow, 54', 'LL Touring Frame', 'Lightweight butted aluminum frame provides a more upright riding position for a trip around town.  Our ground-breaking design provides optimum comfort.', 'Yellow', '54', 'U', '199.8519', '333.4200'),
(509, 16, 'FR-T67Y-58', 'LL Touring Frame - Yellow, 58', 'LL Touring Frame', 'Lightweight butted aluminum frame provides a more upright riding position for a trip around town.  Our ground-breaking design provides optimum comfort.', 'Yellow', '58', 'U', '199.8519', '333.4200'),
(510, 16, 'FR-T67U-44', 'LL Touring Frame - Blue, 44', 'LL Touring Frame', 'Lightweight butted aluminum frame provides a more upright riding position for a trip around town.  Our ground-breaking design provides optimum comfort.', 'Blue', '44', 'U', '199.8519', '333.4200'),
(511, 12, 'FR-M63S-40', 'ML Mountain Frame-W - Silver, 40', 'ML Mountain Frame-W', 'The ML frame is a heat-treated aluminum frame made with the same detail and quality as our HL frame. It offers superior performance. Men\'s version.', 'Silver', '40', 'W', '199.3757', '364.0900'),
(512, 12, 'FR-M63S-42', 'ML Mountain Frame-W - Silver, 42', 'ML Mountain Frame-W', 'The ML frame is a heat-treated aluminum frame made with the same detail and quality as our HL frame. It offers superior performance. Men\'s version.', 'Silver', '42', 'W', '199.3757', '364.0900'),
(513, 12, 'FR-M63S-46', 'ML Mountain Frame-W - Silver, 46', 'ML Mountain Frame-W', 'The ML frame is a heat-treated aluminum frame made with the same detail and quality as our HL frame. It offers superior performance. Men\'s version.', 'Silver', '46', 'W', '199.3757', '364.0900'),
(514, 6, 'RB-9231', 'Rear Brakes', 'Rear Brakes', '0', 'Silver', '0', '0', '47.2860', '106.5000'),
(515, 15, 'SE-M236', 'LL Mountain Seat/Saddle', 'LL Mountain Seat/Saddle 2', 'Synthetic leather. Features gel for increased comfort.', 'NA', '0', '0', '12.0413', '27.1200'),
(516, 15, 'SE-M798', 'ML Mountain Seat/Saddle', 'ML Mountain Seat/Saddle 2', 'Designed to absorb shock.', 'NA', '0', '0', '17.3782', '39.1400'),
(517, 15, 'SE-M940', 'HL Mountain Seat/Saddle', 'HL Mountain Seat/Saddle 2', 'Anatomic design for a full-day of riding in comfort. Durable leather.', 'NA', '0', '0', '23.3722', '52.6400'),
(518, 15, 'SE-R581', 'LL Road Seat/Saddle', 'LL Road Seat/Saddle 1', 'Lightweight foam-padded saddle.', 'NA', '0', '0', '12.0413', '27.1200'),
(519, 15, 'SE-R908', 'ML Road Seat/Saddle', 'ML Road Seat/Saddle 2', 'Rubber bumpers absorb bumps.', 'NA', '0', '0', '17.3782', '39.1400'),
(520, 15, 'SE-R995', 'HL Road Seat/Saddle', 'HL Road Seat/Saddle 2', 'Lightweight kevlar racing saddle. Leather.', 'NA', '0', '0', '23.3722', '52.6400'),
(521, 15, 'SE-T312', 'LL Touring Seat/Saddle', 'LL Touring Seat/Saddle', 'Comfortable, ergonomically shaped gel saddle.', 'NA', '0', '0', '12.0413', '27.1200'),
(522, 15, 'SE-T762', 'ML Touring Seat/Saddle', 'ML Touring Seat/Saddle', 'New design relieves pressure for long rides.', 'NA', '0', '0', '17.3782', '39.1400'),
(523, 15, 'SE-T924', 'HL Touring Seat/Saddle', 'HL Touring Seat/Saddle', 'Cut-out shell for a more comfortable ride.', 'NA', '0', '0', '23.3722', '52.6400'),
(524, 12, 'FR-M21S-42', 'LL Mountain Frame - Silver, 42', 'LL Mountain Frame', 'Our best value utilizing the same, ground-breaking frame technology as the ML aluminum frame.', 'Silver', '42', 'U', '144.5938', '264.0500'),
(525, 12, 'FR-M21S-44', 'LL Mountain Frame - Silver, 44', 'LL Mountain Frame', 'Our best value utilizing the same, ground-breaking frame technology as the ML aluminum frame.', 'Silver', '44', 'U', '144.5938', '264.0500'),
(526, 12, 'FR-M21S-48', 'LL Mountain Frame - Silver, 48', 'LL Mountain Frame', 'Our best value utilizing the same, ground-breaking frame technology as the ML aluminum frame.', 'Silver', '48', 'U', '144.5938', '264.0500'),
(527, 12, 'FR-M21S-52', 'LL Mountain Frame - Silver, 52', 'LL Mountain Frame', 'Our best value utilizing the same, ground-breaking frame technology as the ML aluminum frame.', 'Silver', '52', 'U', '144.5938', '264.0500'),
(528, 37, 'TT-M928', 'Mountain Tire Tube', 'Mountain Tire Tube', 'Self-sealing tube.', 'NA', '0', '0', '1.8663', '4.9900'),
(529, 37, 'TT-R982', 'Road Tire Tube', 'Road Tire Tube', 'Conventional all-purpose tube.', 'NA', '0', '0', '1.4923', '3.9900'),
(530, 37, 'TT-T092', 'Touring Tire Tube', 'Touring Tire Tube', 'General purpose tube.', 'NA', '0', '0', '1.8663', '4.9900'),
(531, 12, 'FR-M21B-42', 'LL Mountain Frame - Black, 42', 'LL Mountain Frame', 'Our best value utilizing the same, ground-breaking frame technology as the ML aluminum frame.', 'Black', '42', 'U', '136.7850', '249.7900');
INSERT INTO `products` (`ProductID`, `ProductSubcategoryID`, `ProductSKU`, `ProductName`, `ModelName`, `ProductDescription`, `ProductColor`, `ProductSize`, `ProductStyle`, `ProductCost`, `ProductPrice`) VALUES
(532, 12, 'FR-M21B-44', 'LL Mountain Frame - Black, 44', 'LL Mountain Frame', 'Our best value utilizing the same, ground-breaking frame technology as the ML aluminum frame.', 'Black', '44', 'U', '136.7850', '249.7900'),
(533, 12, 'FR-M21B-48', 'LL Mountain Frame - Black, 48', 'LL Mountain Frame', 'Our best value utilizing the same, ground-breaking frame technology as the ML aluminum frame.', 'Black', '48', 'U', '136.7850', '249.7900'),
(534, 12, 'FR-M21B-52', 'LL Mountain Frame - Black, 52', 'LL Mountain Frame', 'Our best value utilizing the same, ground-breaking frame technology as the ML aluminum frame.', 'Black', '52', 'U', '136.7850', '249.7900'),
(535, 37, 'TI-M267', 'LL Mountain Tire', 'LL Mountain Tire', 'Comparible traction, less expensive wire bead casing.', 'NA', '0', '0', '9.3463', '24.9900'),
(536, 37, 'TI-M602', 'ML Mountain Tire', 'ML Mountain Tire', 'Great traction, high-density rubber.', 'NA', '0', '0', '11.2163', '29.9900'),
(537, 37, 'TI-M823', 'HL Mountain Tire', 'HL Mountain Tire', 'Incredible traction, lightweight carbon reinforced.', 'NA', '0', '0', '13.0900', '35.0000'),
(538, 37, 'TI-R092', 'LL Road Tire', 'LL Road Tire', 'Same great treads as more expensive tire with a less expensive wire bead casing.', 'NA', '0', '0', '8.0373', '21.4900'),
(539, 37, 'TI-R628', 'ML Road Tire', 'ML Road Tire', 'Higher density rubber.', 'NA', '0', '0', '9.3463', '24.9900'),
(540, 37, 'TI-R982', 'HL Road Tire', 'HL Road Tire', 'Lightweight carbon reinforced  for an unrivaled ride at an un-compromised weight.', 'NA', '0', '0', '12.1924', '32.6000'),
(541, 37, 'TI-T723', 'Touring Tire', 'Touring Tire', 'High-density rubber.', 'NA', '0', '0', '10.8423', '28.9900'),
(542, 13, 'PD-M282', 'LL Mountain Pedal', 'LL Mountain Pedal', 'Expanded platform so you can ride in any shoes; great for all-around riding.', 'Silver/Black', '0', '0', '17.9776', '40.4900'),
(543, 13, 'PD-M340', 'ML Mountain Pedal', 'ML Mountain Pedal', 'Lightweight, durable, clipless pedal with adjustable tension.', 'Silver/Black', '0', '0', '27.5680', '62.0900'),
(544, 13, 'PD-M562', 'HL Mountain Pedal', 'HL Mountain Pedal', 'Stainless steel; designed to shed mud easily.', 'Silver/Black', '0', '0', '35.9596', '80.9900'),
(545, 13, 'PD-R347', 'LL Road Pedal', 'LL Road Pedal', 'Clipless pedals - aluminum.', 'Silver/Black', '0', '0', '17.9776', '40.4900'),
(546, 13, 'PD-R563', 'ML Road Pedal', 'ML Road Pedal', 'Lightweight aluminum alloy construction.', 'Silver/Black', '0', '0', '27.5680', '62.0900'),
(547, 13, 'PD-R853', 'HL Road Pedal', 'HL Road Pedal', 'Top-of-the-line clipless pedals with adjustable tension.', 'Silver/Black', '0', '0', '35.9596', '80.9900'),
(548, 13, 'PD-T852', 'Touring Pedal', 'Touring Pedal', 'A stable pedal for all-day riding.', 'Silver/Black', '0', '0', '35.9596', '80.9900'),
(549, 12, 'FR-M63S-38', 'ML Mountain Frame-W - Silver, 38', 'ML Mountain Frame-W', 'The ML frame is a heat-treated aluminum frame made with the same detail and quality as our HL frame. It offers superior performance. Men\'s version.', 'Silver', '38', 'W', '199.3757', '364.0900'),
(550, 12, 'FR-M21B-40', 'LL Mountain Frame - Black, 40', 'LL Mountain Frame', 'Our best value utilizing the same, ground-breaking frame technology as the ML aluminum frame.', 'Black', '40', 'U', '136.7850', '249.7900'),
(551, 12, 'FR-M21S-40', 'LL Mountain Frame - Silver, 40', 'LL Mountain Frame', 'Our best value utilizing the same, ground-breaking frame technology as the ML aluminum frame.', 'Silver', '40', 'U', '144.5938', '264.0500'),
(552, 9, 'FD-2342', 'Front Derailleur', 'Front Derailleur', 'Wide-link design.', 'Silver', '0', '0', '40.6216', '91.4900'),
(553, 4, 'HB-T721', 'LL Touring Handlebars', 'LL Touring Handlebars', 'Unique shape reduces fatigue for entry level riders.', 'NA', '0', '0', '20.4640', '46.0900'),
(554, 4, 'HB-T928', 'HL Touring Handlebars', 'HL Touring Handlebars', 'A light yet stiff aluminum bar for long distance riding.', 'NA', '0', '0', '40.6571', '91.5700'),
(555, 6, 'FB-9873', 'Front Brakes', 'Front Brakes', 'All-weather brake pads; provides superior stopping by applying more surface to the rim.', 'Silver', '0', '0', '47.2860', '106.5000'),
(556, 8, 'CS-4759', 'LL Crankset', 'LL Crankset', 'Super rigid spindle.', 'Black', '0', '0', '77.9176', '175.4900'),
(557, 8, 'CS-6583', 'ML Crankset', 'ML Crankset', 'High-strength crank arm.', 'Black', '0', '0', '113.8816', '256.4900'),
(558, 8, 'CS-9183', 'HL Crankset', 'HL Crankset', 'Triple crankset; alumunim crank arm; flawless shifting.', 'Black', '0', '0', '179.8156', '404.9900'),
(559, 7, 'CH-0234', 'Chain', 'Chain', 'Superior shifting performance.', 'Silver', '0', '0', '8.9866', '20.2400'),
(560, 3, 'BK-T44U-60', 'Touring-2000 Blue, 60', 'Touring-2000', 'The plush custom saddle keeps you riding all day,  and there\'s plenty of space to add panniers and bike bags to the newly-redesigned carrier.  This bike has stability when fully-loaded.', 'Blue', '60', 'U', '755.1508', '1214.8500'),
(561, 3, 'BK-T79Y-46', 'Touring-1000 Yellow, 46', 'Touring-1000', 'Travel in style and comfort. Designed for maximum comfort and safety. Wide gear range takes on all hills. High-tech aluminum alloy construction provides durability without added weight.', 'Yellow', '46', 'U', '1481.9379', '2384.0700'),
(562, 3, 'BK-T79Y-50', 'Touring-1000 Yellow, 50', 'Touring-1000', 'Travel in style and comfort. Designed for maximum comfort and safety. Wide gear range takes on all hills. High-tech aluminum alloy construction provides durability without added weight.', 'Yellow', '50', 'U', '1481.9379', '2384.0700'),
(563, 3, 'BK-T79Y-54', 'Touring-1000 Yellow, 54', 'Touring-1000', 'Travel in style and comfort. Designed for maximum comfort and safety. Wide gear range takes on all hills. High-tech aluminum alloy construction provides durability without added weight.', 'Yellow', '54', 'U', '1481.9379', '2384.0700'),
(564, 3, 'BK-T79Y-60', 'Touring-1000 Yellow, 60', 'Touring-1000', 'Travel in style and comfort. Designed for maximum comfort and safety. Wide gear range takes on all hills. High-tech aluminum alloy construction provides durability without added weight.', 'Yellow', '60', 'U', '1481.9379', '2384.0700'),
(565, 3, 'BK-T18U-54', 'Touring-3000 Blue, 54', 'Touring-3000', 'All-occasion value bike with our basic comfort and safety features. Offers wider, more stable tires for a ride around town or weekend trip.', 'Blue', '54', 'U', '461.4448', '742.3500'),
(566, 3, 'BK-T18U-58', 'Touring-3000 Blue, 58', 'Touring-3000', 'All-occasion value bike with our basic comfort and safety features. Offers wider, more stable tires for a ride around town or weekend trip.', 'Blue', '58', 'U', '461.4448', '742.3500'),
(567, 3, 'BK-T18U-62', 'Touring-3000 Blue, 62', 'Touring-3000', 'All-occasion value bike with our basic comfort and safety features. Offers wider, more stable tires for a ride around town or weekend trip.', 'Blue', '62', 'U', '461.4448', '742.3500'),
(568, 3, 'BK-T18Y-44', 'Touring-3000 Yellow, 44', 'Touring-3000', 'All-occasion value bike with our basic comfort and safety features. Offers wider, more stable tires for a ride around town or weekend trip.', 'Yellow', '44', 'U', '461.4448', '742.3500'),
(569, 3, 'BK-T18Y-50', 'Touring-3000 Yellow, 50', 'Touring-3000', 'All-occasion value bike with our basic comfort and safety features. Offers wider, more stable tires for a ride around town or weekend trip.', 'Yellow', '50', 'U', '461.4448', '742.3500'),
(570, 3, 'BK-T18Y-54', 'Touring-3000 Yellow, 54', 'Touring-3000', 'All-occasion value bike with our basic comfort and safety features. Offers wider, more stable tires for a ride around town or weekend trip.', 'Yellow', '54', 'U', '461.4448', '742.3500'),
(571, 3, 'BK-T18Y-58', 'Touring-3000 Yellow, 58', 'Touring-3000', 'All-occasion value bike with our basic comfort and safety features. Offers wider, more stable tires for a ride around town or weekend trip.', 'Yellow', '58', 'U', '461.4448', '742.3500'),
(572, 3, 'BK-T18Y-62', 'Touring-3000 Yellow, 62', 'Touring-3000', 'All-occasion value bike with our basic comfort and safety features. Offers wider, more stable tires for a ride around town or weekend trip.', 'Yellow', '62', 'U', '461.4448', '742.3500'),
(573, 3, 'BK-T79U-46', 'Touring-1000 Blue, 46', 'Touring-1000', 'Travel in style and comfort. Designed for maximum comfort and safety. Wide gear range takes on all hills. High-tech aluminum alloy construction provides durability without added weight.', 'Blue', '46', 'U', '1481.9379', '2384.0700'),
(574, 3, 'BK-T79U-50', 'Touring-1000 Blue, 50', 'Touring-1000', 'Travel in style and comfort. Designed for maximum comfort and safety. Wide gear range takes on all hills. High-tech aluminum alloy construction provides durability without added weight.', 'Blue', '50', 'U', '1481.9379', '2384.0700'),
(575, 3, 'BK-T79U-54', 'Touring-1000 Blue, 54', 'Touring-1000', 'Travel in style and comfort. Designed for maximum comfort and safety. Wide gear range takes on all hills. High-tech aluminum alloy construction provides durability without added weight.', 'Blue', '54', 'U', '1481.9379', '2384.0700'),
(576, 3, 'BK-T79U-60', 'Touring-1000 Blue, 60', 'Touring-1000', 'Travel in style and comfort. Designed for maximum comfort and safety. Wide gear range takes on all hills. High-tech aluminum alloy construction provides durability without added weight.', 'Blue', '60', 'U', '1481.9379', '2384.0700'),
(577, 3, 'BK-T44U-46', 'Touring-2000 Blue, 46', 'Touring-2000', 'The plush custom saddle keeps you riding all day,  and there\'s plenty of space to add panniers and bike bags to the newly-redesigned carrier.  This bike has stability when fully-loaded.', 'Blue', '46', 'U', '755.1508', '1214.8500'),
(578, 3, 'BK-T44U-50', 'Touring-2000 Blue, 50', 'Touring-2000', 'The plush custom saddle keeps you riding all day,  and there\'s plenty of space to add panniers and bike bags to the newly-redesigned carrier.  This bike has stability when fully-loaded.', 'Blue', '50', 'U', '755.1508', '1214.8500'),
(579, 3, 'BK-T44U-54', 'Touring-2000 Blue, 54', 'Touring-2000', 'The plush custom saddle keeps you riding all day,  and there\'s plenty of space to add panniers and bike bags to the newly-redesigned carrier.  This bike has stability when fully-loaded.', 'Blue', '54', 'U', '755.1508', '1214.8500'),
(580, 2, 'BK-R79Y-40', 'Road-350-W Yellow, 40', 'Road-350-W', 'Cross-train, race, or just socialize on a sleek, aerodynamic bike designed for a woman.  Advanced seat technology provides comfort all day.', 'Yellow', '40', 'W', '1082.5100', '1700.9900'),
(581, 2, 'BK-R79Y-42', 'Road-350-W Yellow, 42', 'Road-350-W', 'Cross-train, race, or just socialize on a sleek, aerodynamic bike designed for a woman.  Advanced seat technology provides comfort all day.', 'Yellow', '42', 'W', '1082.5100', '1700.9900'),
(582, 2, 'BK-R79Y-44', 'Road-350-W Yellow, 44', 'Road-350-W', 'Cross-train, race, or just socialize on a sleek, aerodynamic bike designed for a woman.  Advanced seat technology provides comfort all day.', 'Yellow', '44', 'W', '1082.5100', '1700.9900'),
(583, 2, 'BK-R79Y-48', 'Road-350-W Yellow, 48', 'Road-350-W', 'Cross-train, race, or just socialize on a sleek, aerodynamic bike designed for a woman.  Advanced seat technology provides comfort all day.', 'Yellow', '48', 'W', '1082.5100', '1700.9900'),
(584, 2, 'BK-R19B-58', 'Road-750 Black, 58', 'Road-750', 'Entry level adult bike; offers a comfortable ride cross-country or down the block. Quick-release hubs and rims.', 'Black', '58', 'U', '343.6496', '539.9900'),
(585, 3, 'BK-T18U-44', 'Touring-3000 Blue, 44', 'Touring-3000', 'All-occasion value bike with our basic comfort and safety features. Offers wider, more stable tires for a ride around town or weekend trip.', 'Blue', '44', 'U', '461.4448', '742.3500'),
(586, 3, 'BK-T18U-50', 'Touring-3000 Blue, 50', 'Touring-3000', 'All-occasion value bike with our basic comfort and safety features. Offers wider, more stable tires for a ride around town or weekend trip.', 'Blue', '50', 'U', '461.4448', '742.3500'),
(587, 1, 'BK-M38S-38', 'Mountain-400-W Silver, 38', 'Mountain-400-W', 'This bike delivers a high-level of performance on a budget. It is responsive and maneuverable, and offers peace-of-mind when you decide to go off-road.', 'Silver', '38', 'W', '419.7784', '769.4900'),
(588, 1, 'BK-M38S-40', 'Mountain-400-W Silver, 40', 'Mountain-400-W', 'This bike delivers a high-level of performance on a budget. It is responsive and maneuverable, and offers peace-of-mind when you decide to go off-road.', 'Silver', '40', 'W', '419.7784', '769.4900'),
(589, 1, 'BK-M38S-42', 'Mountain-400-W Silver, 42', 'Mountain-400-W', 'This bike delivers a high-level of performance on a budget. It is responsive and maneuverable, and offers peace-of-mind when you decide to go off-road.', 'Silver', '42', 'W', '419.7784', '769.4900'),
(590, 1, 'BK-M38S-46', 'Mountain-400-W Silver, 46', 'Mountain-400-W', 'This bike delivers a high-level of performance on a budget. It is responsive and maneuverable, and offers peace-of-mind when you decide to go off-road.', 'Silver', '46', 'W', '419.7784', '769.4900'),
(591, 1, 'BK-M18S-40', 'Mountain-500 Silver, 40', 'Mountain-500', 'Suitable for any type of riding, on or off-road. Fits any budget. Smooth-shifting with a comfortable ride.', 'Silver', '40', 'U', '308.2179', '564.9900'),
(592, 1, 'BK-M18S-42', 'Mountain-500 Silver, 42', 'Mountain-500', 'Suitable for any type of riding, on or off-road. Fits any budget. Smooth-shifting with a comfortable ride.', 'Silver', '42', 'U', '308.2179', '564.9900'),
(593, 1, 'BK-M18S-44', 'Mountain-500 Silver, 44', 'Mountain-500', 'Suitable for any type of riding, on or off-road. Fits any budget. Smooth-shifting with a comfortable ride.', 'Silver', '44', 'U', '308.2179', '564.9900'),
(594, 1, 'BK-M18S-48', 'Mountain-500 Silver, 48', 'Mountain-500', 'Suitable for any type of riding, on or off-road. Fits any budget. Smooth-shifting with a comfortable ride.', 'Silver', '48', 'U', '308.2179', '564.9900'),
(595, 1, 'BK-M18S-52', 'Mountain-500 Silver, 52', 'Mountain-500', 'Suitable for any type of riding, on or off-road. Fits any budget. Smooth-shifting with a comfortable ride.', 'Silver', '52', 'U', '308.2179', '564.9900'),
(596, 1, 'BK-M18B-40', 'Mountain-500 Black, 40', 'Mountain-500', 'Suitable for any type of riding, on or off-road. Fits any budget. Smooth-shifting with a comfortable ride.', 'Black', '40', 'U', '294.5797', '539.9900'),
(597, 1, 'BK-M18B-42', 'Mountain-500 Black, 42', 'Mountain-500', 'Suitable for any type of riding, on or off-road. Fits any budget. Smooth-shifting with a comfortable ride.', 'Black', '42', 'U', '294.5797', '539.9900'),
(598, 1, 'BK-M18B-44', 'Mountain-500 Black, 44', 'Mountain-500', 'Suitable for any type of riding, on or off-road. Fits any budget. Smooth-shifting with a comfortable ride.', 'Black', '44', 'U', '294.5797', '539.9900'),
(599, 1, 'BK-M18B-48', 'Mountain-500 Black, 48', 'Mountain-500', 'Suitable for any type of riding, on or off-road. Fits any budget. Smooth-shifting with a comfortable ride.', 'Black', '48', 'U', '294.5797', '539.9900'),
(600, 1, 'BK-M18B-52', 'Mountain-500 Black, 52', 'Mountain-500', 'Suitable for any type of riding, on or off-road. Fits any budget. Smooth-shifting with a comfortable ride.', 'Black', '52', 'U', '294.5797', '539.9900'),
(601, 5, 'BB-7421', 'LL Bottom Bracket', 'LL Bottom Bracket', 'Chromoly steel.', 'NA', '0', '0', '23.9716', '53.9900'),
(602, 5, 'BB-8107', 'ML Bottom Bracket', 'ML Bottom Bracket', 'Aluminum alloy cups; large diameter spindle.', 'NA', '0', '0', '44.9506', '101.2400'),
(603, 5, 'BB-9108', 'HL Bottom Bracket', 'HL Bottom Bracket', 'Aluminum alloy cups and a hollow axle.', 'NA', '0', '0', '53.9416', '121.4900'),
(604, 2, 'BK-R19B-44', 'Road-750 Black, 44', 'Road-750', 'Entry level adult bike; offers a comfortable ride cross-country or down the block. Quick-release hubs and rims.', 'Black', '44', 'U', '343.6496', '539.9900'),
(605, 2, 'BK-R19B-48', 'Road-750 Black, 48', 'Road-750', 'Entry level adult bike; offers a comfortable ride cross-country or down the block. Quick-release hubs and rims.', 'Black', '48', 'U', '343.6496', '539.9900'),
(606, 2, 'BK-R19B-52', 'Road-750 Black, 52', 'Road-750', 'Entry level adult bike; offers a comfortable ride cross-country or down the block. Quick-release hubs and rims.', 'Black', '52', 'U', '343.6496', '539.9900');

-- --------------------------------------------------------

--
-- Table structure for table `product_categories`
--

CREATE TABLE `product_categories` (
  `ProductCategoryID` int(1) NOT NULL,
  `CategoryName` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `product_categories`
--

INSERT INTO `product_categories` (`ProductCategoryID`, `CategoryName`) VALUES
(1, 'Bikes'),
(2, 'Components'),
(3, 'Clothing'),
(4, 'Accessories'),
(5, 'Sport');

-- --------------------------------------------------------

--
-- Table structure for table `product_subcategories`
--

CREATE TABLE `product_subcategories` (
  `ProductSubcategoryID` int(2) NOT NULL,
  `SubcategoryName` varchar(20) NOT NULL,
  `ProductCategoryID` int(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `product_subcategories`
--

INSERT INTO `product_subcategories` (`ProductSubcategoryID`, `SubcategoryName`, `ProductCategoryID`) VALUES
(1, 'Mountain Bikes', 1),
(2, 'Road Bikes', 1),
(3, 'Touring Bikes', 1),
(4, 'Handlebars', 2),
(5, 'Bottom Brackets', 2),
(6, 'Brakes', 2),
(7, 'Chains', 2),
(8, 'Cranksets', 2),
(9, 'Derailleurs', 2),
(10, 'Forks', 2),
(11, 'Headsets', 2),
(12, 'Mountain Frames', 2),
(13, 'Pedals', 2),
(14, 'Road Frames', 2),
(15, 'Saddles', 2),
(16, 'Touring Frames', 2),
(17, 'Wheels', 2),
(18, 'Bib-Shorts', 3),
(19, 'Caps', 3),
(20, 'Gloves', 3),
(21, 'Jerseys', 3),
(22, 'Shorts', 3),
(23, 'Socks', 3),
(24, 'Tights', 3),
(25, 'Vests', 3),
(26, 'Bike Racks', 4),
(27, 'Bike Stands', 4),
(28, 'Bottles and Cages', 4),
(29, 'Cleaners', 4),
(30, 'Fenders', 4),
(31, 'Helmets', 4),
(32, 'Hydration Packs', 4),
(33, 'Lights', 4),
(34, 'Locks', 4),
(35, 'Panniers', 4),
(36, 'Pumps', 4),
(37, 'Tires and Tubes', 4),
(38, 'Football', 5),
(39, 'Basketball', 5),
(40, 'Volleyball', 5);

-- --------------------------------------------------------

--
-- Table structure for table `sales`
--

CREATE TABLE `sales` (
  `OrderDate` date NOT NULL,
  `StockDate` date NOT NULL,
  `OrderNumber` varchar(7) NOT NULL,
  `ProductID` int(3) NOT NULL,
  `CustomerID` int(5) NOT NULL,
  `TerritoryID` int(2) NOT NULL,
  `OrderLineItem` int(2) NOT NULL,
  `OrderQuantity` int(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `sales`
--

INSERT INTO `sales` (`OrderDate`, `StockDate`, `OrderNumber`, `ProductID`, `CustomerID`, `TerritoryID`, `OrderLineItem`, `OrderQuantity`) VALUES
('2017-01-01', '2003-09-04', 'SO61269', 215, 11019, 4, 1, 1),
('2017-01-01', '2003-10-21', 'SO61269', 229, 11019, 4, 2, 1),
('2017-02-03', '2003-09-04', 'SO61285', 540, 11026, 1, 1, 1),
('2017-02-03', '2003-12-13', 'SO61285', 529, 11026, 1, 2, 2),
('2017-02-03', '2003-09-24', 'SO61285', 214, 11026, 1, 3, 1),
('2017-02-10', '2003-09-27', 'SO61286', 536, 11007, 6, 1, 2),
('2017-02-10', '2003-10-24', 'SO61286', 528, 11007, 6, 2, 2),
('2017-03-04', '2003-10-21', 'SO61301', 377, 11015, 1, 1, 1),
('2017-03-04', '2003-09-28', 'SO61301', 529, 11015, 1, 2, 2),
('2017-03-04', '2003-10-23', 'SO61301', 540, 11015, 1, 3, 1);

-- --------------------------------------------------------

--
-- Table structure for table `territories`
--

CREATE TABLE `territories` (
  `TerritoryID` int(2) NOT NULL,
  `Region` varchar(20) NOT NULL,
  `Country` varchar(20) NOT NULL,
  `Continent` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `territories`
--

INSERT INTO `territories` (`TerritoryID`, `Region`, `Country`, `Continent`) VALUES
(1, 'Northwest', 'United States', 'North America'),
(2, 'Northeast', 'United States', 'North America'),
(3, 'Central', 'United States', 'North America'),
(4, 'Southwest', 'United States', 'North America'),
(5, 'Southeast', 'United States', 'North America'),
(6, 'Canada', 'Canada', 'North America'),
(7, 'France', 'France', 'Europe'),
(8, 'Germany', 'Germany', 'Europe'),
(9, 'Australia', 'Australia', 'Pacific'),
(10, 'United Kingdom', 'United Kingdom', 'Europe');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`CustomerID`);

--
-- Indexes for table `guests`
--
ALTER TABLE `guests`
  ADD PRIMARY KEY (`CustomerID`);

--
-- Indexes for table `members`
--
ALTER TABLE `members`
  ADD PRIMARY KEY (`CustomerID`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`ProductID`),
  ADD KEY `ProductSubcategoryKey` (`ProductSubcategoryID`);

--
-- Indexes for table `product_categories`
--
ALTER TABLE `product_categories`
  ADD PRIMARY KEY (`ProductCategoryID`);

--
-- Indexes for table `product_subcategories`
--
ALTER TABLE `product_subcategories`
  ADD PRIMARY KEY (`ProductSubcategoryID`,`ProductCategoryID`),
  ADD KEY `ProductCategoryKey` (`ProductCategoryID`);

--
-- Indexes for table `sales`
--
ALTER TABLE `sales`
  ADD PRIMARY KEY (`OrderNumber`,`OrderLineItem`),
  ADD KEY `ProductKey` (`ProductID`,`CustomerID`,`TerritoryID`),
  ADD KEY `CustomerKey` (`CustomerID`),
  ADD KEY `TerritoryKey` (`TerritoryID`);

--
-- Indexes for table `territories`
--
ALTER TABLE `territories`
  ADD PRIMARY KEY (`TerritoryID`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `Products_ibfk_1` FOREIGN KEY (`ProductSubcategoryID`) REFERENCES `product_subcategories` (`ProductSubcategoryID`);

--
-- Constraints for table `product_subcategories`
--
ALTER TABLE `product_subcategories`
  ADD CONSTRAINT `Product_Subcategories_ibfk_1` FOREIGN KEY (`ProductCategoryID`) REFERENCES `product_categories` (`ProductCategoryID`);

--
-- Constraints for table `sales`
--
ALTER TABLE `sales`
  ADD CONSTRAINT `Sales_ibfk_1` FOREIGN KEY (`ProductID`) REFERENCES `products` (`ProductID`),
  ADD CONSTRAINT `Sales_ibfk_2` FOREIGN KEY (`CustomerID`) REFERENCES `members` (`CustomerID`),
  ADD CONSTRAINT `Sales_ibfk_3` FOREIGN KEY (`TerritoryID`) REFERENCES `territories` (`TerritoryID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
