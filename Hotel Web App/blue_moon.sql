-- phpMyAdmin SQL Dump
-- version 4.9.5
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: May 12, 2021 at 05:01 PM
-- Server version: 5.7.24
-- PHP Version: 7.4.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `blue_moon`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `activeGuests` (IN `depature_date` DATE)  BEGIN
SELECT CONCAT(guests.firstname, " ", guests.firstname) AS Name, mobile, rooms.rooms_name AS "Room Name"
FROM guests
JOIN bookings
ON guests.guests_id = bookings.guests_fk
JOIN rooms ON rooms.rooms_id = bookings.room_fk
WHERE (bookings.date_from >= NOW() AND bookings.date_to <= depature_date)AND bookings.status_fk = 1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `guestCounty` (IN `countyStr` VARCHAR(25))  BEGIN
SELECT COUNT(guests.guests_id) AS "Number of customer from Essex"
FROM guests
JOIN bookings
ON guests.guests_id = bookings.guests_fk
WHERE guests.county LIKE CONCAT('%',countyStr,'%');
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `roomAvailability` (IN `room_name` VARCHAR(20), IN `date_from` DATE, IN `date_to` DATE)  BEGIN
SELECT rooms.rooms_name AS "Room Name",
IF (COUNT(bookings.room_fk) > 0, 'Booked','Not booked') AS Availability, COUNT(bookings.room_fk) AS Occurrence
FROM bookings
JOIN rooms
ON bookings.room_fk = rooms.rooms_id
WHERE bookings.date_from >= date_from AND bookings.date_to <= date_to AND rooms.rooms_name = room_name;

END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `bookings`
--

CREATE TABLE `bookings` (
  `bookings_id` int(11) NOT NULL,
  `guests_fk` int(11) NOT NULL,
  `date_from` date NOT NULL,
  `date_to` date DEFAULT NULL,
  `room_fk` int(11) DEFAULT NULL,
  `status_fk` int(11) DEFAULT NULL,
  `menu_fk` int(11) DEFAULT NULL,
  `services_fk` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `bookings`
--

INSERT INTO `bookings` (`bookings_id`, `guests_fk`, `date_from`, `date_to`, `room_fk`, `status_fk`, `menu_fk`, `services_fk`) VALUES
(1, 18, '2019-01-04', '2019-01-17', 3, 1, 10, 8),
(2, 20, '2019-01-05', '2019-01-29', 15, 1, 27, 16),
(3, 60, '2019-02-06', '2019-02-13', 3, 1, 15, 4),
(4, 11, '2020-01-04', '2020-01-13', 14, 1, 25, 3),
(5, 41, '2021-01-03', '2021-01-14', 17, 1, 20, 5),
(6, 31, '2019-01-01', '2019-01-19', 8, 1, 22, 14),
(7, 10, '2019-01-08', '2019-01-17', 9, 1, 19, 2),
(8, 35, '2019-09-07', '2019-09-24', 7, 1, 29, 3),
(9, 7, '2019-01-08', '2019-01-10', 6, 1, 26, 7),
(10, 12, '2019-03-09', '2019-03-25', 3, 1, 14, 8),
(11, 21, '2019-01-08', '2019-01-26', 20, 1, 20, 1),
(12, 34, '2019-01-05', '2019-01-22', 7, 1, 28, 14),
(13, 15, '2019-01-10', '2019-01-13', 6, 1, 21, 15),
(14, 12, '2019-01-07', '2019-01-24', 10, 1, 22, 1),
(15, 32, '2019-02-03', '2019-02-15', 6, 1, 14, 11),
(16, 4, '2019-01-02', '2019-01-15', 16, 1, 4, 17),
(17, 29, '2019-01-02', '2019-01-08', 4, 1, 10, 1),
(18, 10, '2019-01-08', '2019-01-24', 15, 1, 4, 6),
(19, 3, '2019-01-05', '2019-01-24', 13, 1, 22, 8),
(20, 5, '2019-01-09', '2019-01-17', 1, 1, 7, 5),
(21, 55, '2019-01-04', '2019-01-17', 18, 1, 27, 2),
(22, 19, '2018-01-06', '2018-01-19', 17, 1, 23, 11),
(23, 58, '2019-01-06', '2019-01-20', 17, 2, 3, 13),
(24, 35, '2019-01-08', '2019-01-28', 15, 1, 7, 16),
(25, 19, '2019-05-06', '2019-05-26', 6, 1, 24, 5),
(26, 48, '2019-01-02', '2019-01-14', 14, 1, 11, 11),
(27, 4, '2019-01-08', '2019-01-22', 4, 1, 11, 5),
(28, 34, '2019-01-09', '2019-01-13', 11, 1, 20, 9),
(29, 9, '2019-12-04', '2019-12-13', 9, 2, 8, 13),
(30, 20, '2019-01-23', '2019-01-24', 4, 1, 8, 4),
(31, 36, '2021-03-04', '2021-03-10', 2, 1, 18, 12),
(32, 19, '2021-03-01', '2021-03-06', 16, 1, 4, 16),
(33, 58, '2021-03-02', '2021-03-24', 14, 2, 27, 10),
(34, 36, '2021-03-24', '2021-04-30', 1, 1, 30, 17),
(35, 33, '2021-03-24', '2021-04-30', 14, 1, 8, 2),
(36, 48, '2021-10-14', '2021-05-19', 18, 1, 10, 10),
(37, 85, '2020-07-12', '2020-07-15', 11, 2, 27, 9),
(38, 65, '2020-10-11', '2020-11-12', 30, 1, 16, 17),
(39, 32, '2021-07-13', '2021-09-13', 29, 1, 25, 4),
(40, 35, '2022-02-05', '2022-04-09', 28, 1, 20, 3),
(41, 32, '2021-07-15', '2021-12-25', 24, 1, 23, 4),
(42, 38, '2020-07-31', NULL, NULL, 1, 24, 11),
(43, 81, '2021-05-30', NULL, NULL, 1, 21, 9),
(44, 99, '2021-12-14', NULL, NULL, 1, 1, 10),
(45, 100, '2021-08-21', NULL, NULL, 1, 1, 5),
(46, 99, '2022-02-03', NULL, NULL, 1, 30, 14),
(47, 89, '2022-02-06', NULL, NULL, 1, 30, 3),
(48, 52, '2021-04-06', NULL, NULL, 1, 28, 4),
(49, 98, '2020-10-17', NULL, NULL, 1, 21, 11),
(50, 79, '2021-08-29', NULL, NULL, 1, 19, 11),
(51, 31, '2021-06-24', NULL, NULL, 1, 30, 1),
(52, 80, '2020-06-25', NULL, NULL, 1, 4, 9),
(53, 71, '2020-08-31', NULL, NULL, 2, 21, 6),
(54, 100, '2021-06-07', NULL, NULL, 1, 30, 3),
(55, 61, '2020-04-12', NULL, NULL, 1, 26, 13),
(56, 55, '2020-12-05', NULL, NULL, 1, 11, 5),
(57, 87, '2021-09-23', NULL, NULL, 1, 6, 17),
(58, 69, '2020-07-28', NULL, NULL, 1, 28, 4),
(59, 52, '2020-09-21', NULL, NULL, 1, 30, 3),
(60, 70, '2021-03-02', NULL, NULL, 1, 5, 17),
(61, 76, '2020-05-17', NULL, NULL, NULL, 25, 7),
(62, 48, '2021-10-29', NULL, NULL, NULL, 19, 1),
(63, 33, '2020-10-22', NULL, NULL, NULL, 21, 17),
(64, 52, '2021-11-28', NULL, NULL, NULL, 15, 12),
(65, 98, '2020-03-05', NULL, NULL, NULL, 14, 12),
(66, 93, '2021-12-05', NULL, NULL, NULL, 23, 3),
(67, 67, '2021-07-09', NULL, NULL, NULL, 12, 16),
(68, 52, '2021-06-29', NULL, NULL, NULL, 23, 17),
(69, 80, '2021-10-09', NULL, NULL, NULL, 17, 2),
(70, 56, '2020-10-16', NULL, NULL, NULL, 17, 12),
(71, 38, '2021-11-22', NULL, NULL, NULL, 2, 2),
(72, 80, '2020-05-29', NULL, NULL, NULL, 17, 8),
(73, 37, '2021-11-04', NULL, NULL, NULL, 21, 15),
(74, 33, '2021-11-21', NULL, NULL, NULL, 24, 16),
(75, 42, '2021-10-27', NULL, NULL, NULL, 26, 1),
(76, 34, '2021-08-19', NULL, NULL, NULL, 25, 6),
(77, 96, '2020-05-01', NULL, NULL, NULL, 19, 11),
(78, 90, '2020-04-14', NULL, NULL, NULL, 20, 3),
(79, 94, '2021-09-03', NULL, NULL, NULL, 11, 16),
(80, 85, '2021-12-24', NULL, NULL, NULL, 24, 17),
(81, 93, '2021-04-03', NULL, NULL, NULL, 29, 3),
(82, 39, '2021-07-14', NULL, NULL, NULL, 11, 16),
(83, 98, '2021-02-06', NULL, NULL, NULL, 26, 2),
(84, 72, '2021-09-18', NULL, NULL, NULL, 8, 12),
(85, 87, '2021-10-11', NULL, NULL, NULL, 23, 2),
(86, 95, '2021-10-15', NULL, NULL, NULL, 29, 8),
(87, 85, '2021-09-25', NULL, NULL, NULL, 16, 15),
(88, 76, '2020-04-29', NULL, NULL, NULL, 22, 15),
(89, 97, '2020-03-15', NULL, NULL, NULL, 4, 16),
(90, 96, '2020-12-01', NULL, NULL, NULL, 10, 17),
(91, 34, '2021-01-30', NULL, NULL, NULL, 11, 4),
(92, 59, '2021-03-19', NULL, NULL, NULL, 21, 1),
(93, 86, '2021-07-20', NULL, NULL, NULL, 14, 10),
(94, 50, '2021-03-01', NULL, NULL, NULL, 5, 10),
(95, 39, '2021-10-07', NULL, NULL, NULL, 12, 5),
(96, 83, '2021-06-12', NULL, NULL, NULL, 13, 13),
(97, 90, '2020-12-17', NULL, NULL, NULL, 1, 12),
(98, 69, '2021-06-26', NULL, NULL, NULL, 24, 7),
(99, 84, '2020-10-01', NULL, NULL, NULL, 27, 13),
(100, 30, '2021-11-17', NULL, NULL, NULL, 5, 11),
(101, 71, '2021-10-20', NULL, NULL, NULL, 1, 14),
(102, 78, '2022-01-29', NULL, NULL, NULL, 18, 3),
(103, 48, '2021-01-19', NULL, NULL, NULL, 28, 5),
(104, 91, '2020-10-04', NULL, NULL, NULL, 24, 15),
(105, 70, '2021-08-20', NULL, NULL, NULL, 8, 11),
(106, 81, '2021-06-08', NULL, NULL, NULL, 27, 7),
(107, 47, '2021-06-02', NULL, NULL, NULL, 22, 2),
(108, 46, '2021-04-29', NULL, NULL, NULL, 27, 8),
(109, 80, '2020-04-18', NULL, NULL, NULL, 10, 15),
(110, 64, '2022-02-12', NULL, NULL, NULL, 28, 16),
(111, 51, '2021-11-21', NULL, NULL, NULL, 19, 16),
(112, 84, '2020-10-12', NULL, NULL, NULL, 10, 17),
(113, 44, '2021-04-24', NULL, NULL, NULL, 23, 2),
(114, 76, '2020-04-26', NULL, NULL, NULL, 25, 9),
(115, 64, '2020-09-11', NULL, NULL, NULL, 23, 5),
(116, 91, '2020-12-06', NULL, NULL, NULL, 12, 14),
(117, 76, '2021-08-16', NULL, NULL, NULL, 18, 4),
(118, 91, '2020-12-10', NULL, NULL, NULL, 24, 11),
(119, 81, '2021-09-02', NULL, NULL, NULL, 5, 11),
(120, 66, '2021-02-17', NULL, NULL, NULL, 12, 1),
(121, 83, '2021-10-24', '2021-10-28', 1, 1, 16, 8),
(122, 45, '2020-11-21', '2020-11-23', 28, 1, 14, 3),
(123, 95, '2021-02-23', '2021-05-20', 2, 1, 22, 8),
(124, 88, '2022-05-31', '2021-08-04', 22, 1, 7, 12),
(125, 51, '2021-11-13', '2021-12-15', 12, 1, 27, 2),
(126, 52, '2021-02-18', '2021-03-17', 11, 1, 24, 6),
(127, 98, '2020-03-16', '2021-07-14', 9, 1, 10, 7),
(128, 35, '2021-05-27', '2021-07-30', 16, 1, 5, 16),
(129, 62, '2020-06-11', '2021-07-14', 3, 1, 26, 10),
(130, 97, '2020-06-24', '2021-10-29', 4, 1, 25, 16),
(131, 85, '2021-01-13', '2021-07-02', 8, 1, 16, 15),
(132, 77, '2022-03-03', '2022-09-09', 12, 1, 6, 8),
(133, 85, '2021-11-23', '2022-06-10', 19, 1, 12, 15);

-- --------------------------------------------------------

--
-- Table structure for table `cancellations`
--

CREATE TABLE `cancellations` (
  `cancellations_id` int(11) NOT NULL,
  `bookings_fk` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `cancellations`
--

INSERT INTO `cancellations` (`cancellations_id`, `bookings_fk`) VALUES
(1, 23),
(2, 29);

-- --------------------------------------------------------

--
-- Table structure for table `employees`
--

CREATE TABLE `employees` (
  `employees_id` int(11) NOT NULL,
  `firstname` varchar(40) NOT NULL,
  `lastname` varchar(40) NOT NULL,
  `email` varchar(50) NOT NULL,
  `address` varchar(50) NOT NULL,
  `city` varchar(30) NOT NULL,
  `postcode` varchar(30) DEFAULT NULL,
  `gender` int(11) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `start_date` date NOT NULL,
  `employee_role_fk` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `employees`
--

INSERT INTO `employees` (`employees_id`, `firstname`, `lastname`, `email`, `address`, `city`, `postcode`, `gender`, `dob`, `phone`, `start_date`, `employee_role_fk`) VALUES
(1, 'Carter', 'Cohen', 'risus.Donec@quamquis.edu', '664-3677 Volutpat St.', 'Remscheid', 'KC3T 4UW', 1, '2060-04-06', '0945 073 1940', '2020-08-08', 6),
(2, 'Bradley', 'Lowe', 'egestas@risus.net', '7363 Ultrices St.', 'Paradise', 'VK7Y 2UI', 1, '1976-04-03', '07128 497315', '2020-01-13', 1),
(3, 'Ryder', 'Parsons', 'nunc.sit.amet@loremvitaeodio.org', '2006 Gravida Avenue', 'Barrhead', '', 1, '1998-01-08', '0800 803732', '2020-07-08', 8),
(4, 'Giacomo', 'Warren', 'sem.consequat.nec@orci.org', '173-1730 Pede, St.', 'Soledad de Graciano Sánchez', 'QP3 2CZ', 1, '1995-02-27', '055 9946 6122', '2020-02-20', 10),
(5, 'Damon', 'Bishop', 'eget@molestie.ca', '251-9510 A St.', 'Abbateggio', '', 1, '1972-07-09', '(0171) 765 8353', '2020-03-23', 8),
(6, 'Brock', 'Barton', 'ut.quam.vel@vehiculaPellentesque.com', 'Ap #838-7781 Etiam St.', 'Orlando', '', 1, '1981-04-15', '0500 869447', '2020-03-24', 9),
(7, 'Holmes', 'Larsen', 'iaculis@accumsan.ca', 'P.O. Box 355, 8802 Turpis Av.', 'Lloydminster', '', 1, '1979-10-03', '07692 531581', '2020-09-30', 7),
(8, 'Hedley', 'Wynn', 'at.velit@Phasellusvitae.org', 'Ap #750-8476 Integer St.', 'Houffalize', '', 1, '1987-02-27', '(01528) 530476', '2020-09-22', 3),
(9, 'Zane', 'Hughes', 'ultrices@magnis.net', '2351 Pharetra. St.', 'Devon', '', 1, '1996-01-17', '055 4711 6785', '2020-08-20', 3),
(10, 'Chadwick', 'Hardin', 'ac.mattis@necanteMaecenas.org', 'P.O. Box 705, 2384 Luctus St.', 'Itapipoca', '1563 YG', 1, '1981-09-15', '07624 035021', '2020-05-10', 5),
(11, 'Cooper', 'Rivas', 'pede.ultrices.a@duinec.co.uk', '209-9114 Ligula. Street', 'Shrewsbury', 'A8M 8BZ', 1, '1993-08-24', '055 5733 3323', '2020-08-10', 8),
(12, 'Gavin', 'Macias', 'magnis.dis.parturient@urnasuscipitnonummy.co.uk', 'P.O. Box 652, 9190 Ridiculus St.', 'Norman Wells', '', 1, '1989-07-07', '(01718) 93234', '2020-01-19', 4),
(13, 'Hakeem', 'Church', 'dictum.eu.eleifend@vitae.edu', '1540 Parturient Street', 'Nothomb', 'U85 2RR', 1, '1974-07-25', '(016977) 0020', '2020-05-08', 10),
(14, 'Damian', 'Obrien', 'Maecenas.ornare.egestas@magnaPraesent.co.uk', '854-7776 Neque Av.', 'Murree', '0385 PP', 1, '1986-07-04', '0800 1111', '2020-06-06', 4),
(15, 'Connor', 'Vazquez', 'dui.quis@lectusante.co.uk', '8393 Lectus St.', 'Hines Creek', '5569 AI', 1, '1977-12-23', '0800 1111', '2020-09-13', 5),
(16, 'Hilel', 'Love', 'Proin@quisturpis.org', 'Ap #562-9918 Tincidunt Road', 'Oostakker', '6766 TZ', 1, '1976-06-13', '0500 921016', '2020-12-24', 10),
(17, 'Jameson', 'Woodard', 'tellus.justo@euismodac.com', 'P.O. Box 596, 5472 Sem Rd.', 'Göttingen', '8071 GW', 1, '1979-04-12', '(018756) 06980', '2020-07-27', 3),
(18, 'Channing', 'Clemons', 'quam.dignissim@in.org', '818-3401 Massa. Rd.', 'Sacramento', 'Y7 1TW', 1, '1996-02-15', '0800 207377', '2020-08-02', 8),
(19, 'Hasad', 'Knight', 'adipiscing.non.luctus@Suspendissenon.com', '8283 Egestas St.', 'Pemuco', '', 1, '1987-03-22', '055 7093 4113', '2020-01-28', 4),
(20, 'Daniel', 'Vance', 'rhoncus.Proin.nisl@orciUt.com', 'P.O. Box 863, 3405 Vivamus St.', 'Notre-Dame-du-Nord', 'C0Y 9JN', 1, '1984-12-14', '(016977) 5688', '2020-06-25', 3),
(21, 'Cherokee', 'Mccarthy', 'lorem.luctus@morbitristiquesenectus.ca', 'Ap #364-3542 Ligula Street', 'Belo Horizonte', '', 3, '2020-09-09', '0800 1111', '2020-12-08', 5),
(22, 'Olga', 'Dennis', 'Proin@odioEtiam.co.uk', '4457 Mattis St.', 'Montpelier', '', 2, '2020-06-13', '056 8370 5771', '2020-10-22', 7),
(23, 'Gretchen', 'Schultz', 'quis@velitjusto.ca', 'P.O. Box 411, 457 Ridiculus Av.', 'Kayseri', '', 3, '2021-12-16', '0989 493 3558', '2020-04-04', 5),
(24, 'Alyssa', 'Lindsay', 'Donec.nibh@molestieorcitincidunt.co.uk', 'Ap #731-7269 Ultricies Avenue', 'Aubagne', '', 3, '2020-05-05', '(025) 4672 3043', '2021-12-03', 6),
(25, 'Tanisha', 'Kerr', 'turpis.vitae@feugiat.com', '107-8679 Ultrices. St.', 'Bhir', '', 3, '2021-07-27', '0324 598 3907', '2021-03-09', 8),
(26, 'Alisa', 'Fox', 'Vivamus.nisi.Mauris@Quisque.co.uk', '9543 Sit St.', 'Viggianello', '', 4, '2020-11-12', '0839 788 4902', '2020-12-05', 6),
(27, 'Rae', 'Parrish', 'at@magnatellusfaucibus.com', '4510 Lectus Ave', 'Laarne', 'K9 7EN', 4, '2021-09-15', '0800 329170', '2020-11-01', 4),
(28, 'Quinn', 'Montoya', 'porttitor.vulputate@lectus.co.uk', 'Ap #127-2337 Sociis Av.', 'Çermik', 'L9 6NH', 3, '2020-09-07', '0854 908 1470', '2021-12-31', 8),
(29, 'Amanda', 'Moore', 'in.consequat.enim@ac.org', '610-7023 Etiam St.', 'Wabamun', 'O0 1YQ', 2, '2021-06-01', '(027) 8850 2496', '2020-09-07', 3),
(30, 'Gillian', 'Wooten', 'ullamcorper.magna@ultriciesornare.org', 'P.O. Box 890, 3259 Purus. Rd.', 'Whyalla', 'B47 8BB', 4, '2020-05-08', '056 9390 0024', '2021-02-04', 4),
(31, 'Gail', 'King', 'magna.Duis.dignissim@augueSedmolestie.ca', 'P.O. Box 161, 6666 Elit Street', 'Castle Douglas', '', 3, '2021-03-05', '0313 949 2354', '2021-07-24', 5),
(32, 'Azalia', 'Greer', 'ante.dictum.mi@nibh.edu', 'Ap #348-6557 A Road', 'Lang', '', 4, '2020-11-15', '0500 179402', '2020-04-03', 5),
(33, 'Selma', 'Myers', 'commodo@nonsapienmolestie.com', 'P.O. Box 983, 1385 Erat. Rd.', 'Nacimiento', 'GV7P 5EF', 3, '2021-10-16', '(018686) 17041', '2022-01-21', 3),
(34, 'Cassandra', 'Schwartz', 'tincidunt.aliquam.arcu@euaccumsansed.ca', 'Ap #818-3324 Cras Av.', 'Coldstream', '', 2, '2021-08-03', '0312 975 8904', '2021-07-18', 4),
(35, 'Jorden', 'Graves', 'eleifend.egestas@Morbiquisurna.co.uk', '214-8555 Fringilla Road', 'Ludhiana', 'EF31 2IE', 4, '2021-07-09', '076 5606 4685', '2020-08-18', 4),
(36, 'Ulla', 'Richardson', 'mauris.a@mollisvitaeposuere.org', '5337 Non Street', 'Blind River', '', 2, '2020-09-18', '076 8431 8237', '2021-03-11', 5),
(37, 'Noel', 'Farley', 'et@lobortistellus.net', '713-7484 Pellentesque Rd.', 'Kirkland', 'GA80 4EC', 4, '2021-02-23', '0857 944 4737', '2021-03-11', 6),
(38, 'Denise', 'Dorsey', 'at.velit@ornare.ca', '683-5664 Mattis. Ave', 'Cercepiccola', 'ZI58 3TV', 2, '2020-10-13', '(0161) 479 9056', '2020-10-26', 5),
(39, 'MacKensie', 'Bishop', 'ac@dolorsit.net', 'Ap #703-8532 A, Av.', 'Gloucester', '', 4, '2021-04-17', '07935 993160', '2020-05-06', 6),
(40, 'Destiny', 'Yates', 'et.malesuada.fames@dictumPhasellusin.net', 'Ap #197-8361 Velit Ave', 'Montebelluna', '', 3, '2020-05-05', '055 4185 0004', '2021-12-31', 5),
(41, 'Nige', 'sdfsd', 'ooioj', 'sdfsdf', 'sdfsdf', NULL, NULL, NULL, NULL, '2021-04-19', NULL),
(42, 'Anne', 'Boylene', 'anne.boylene@gmail.com', '87 Queens Close', 'Kings', NULL, 2, '1990-12-07', '071230000', '2021-12-01', NULL),
(43, 'Luna', 'Moon', 'moon@gmail.com', '23 ', 'London', 'SE2', 2, '2020-11-05', '07444444', '2021-04-01', NULL),
(44, 'Test', 'New ', '@gmail.com', '99 condi drive', 'Dagenham', 'DN 23', 1, '2001-06-14', '07900000000', '2021-04-05', NULL),
(45, 'Michaala', 'Yerusalem', 'michaa@gmail.com', '12 set stone', 'Bornmouth', 'bn59', 1, '1999-06-24', '0999', '2021-04-08', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `employees_roles`
--

CREATE TABLE `employees_roles` (
  `employees_roles_id` int(11) NOT NULL,
  `role_name` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `employees_roles`
--

INSERT INTO `employees_roles` (`employees_roles_id`, `role_name`) VALUES
(1, 'General Manager'),
(2, 'Front Officer Manager'),
(3, 'Guest Service Agent'),
(4, 'Security'),
(5, 'Communications'),
(6, 'Director of Sales'),
(7, 'Sales Manager'),
(8, 'House Person'),
(9, 'Room Attendant'),
(10, 'Chief Maintenance Engineer'),
(11, 'Executive Housekeeper');

-- --------------------------------------------------------

--
-- Table structure for table `food`
--

CREATE TABLE `food` (
  `food_id` int(11) NOT NULL,
  `food_name` varchar(60) NOT NULL,
  `menu_fk` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `food`
--

INSERT INTO `food` (`food_id`, `food_name`, `menu_fk`) VALUES
(1, 'Gyro Sandwhich', 19),
(2, 'Broccoli', 29),
(3, 'Lasagna', 11),
(4, 'Ravioli', 17),
(5, 'Cheese', 11),
(6, 'Fried Rice ', 23),
(7, 'Cheesecake', 29),
(8, 'weetabix', 6),
(9, 'Bagel', 12),
(10, 'Fried Rice ', 24),
(11, 'Fried Pork Chops and Gravy ', 11),
(12, 'Hot Dogs', 6),
(13, 'Mashed Potatoes ', 22),
(14, 'beef stew', 3),
(15, 'Kiwi', 25),
(16, 'beef stew', 9),
(17, 'Sausage', 21),
(18, 'Biscuits and Gravy', 11),
(19, 'beef stew', 24),
(20, 'Sausage', 6),
(21, 'Tamale', 26),
(22, 'Croissant ', 6),
(23, 'Gyro Sandwhich', 4),
(24, 'Broccoli', 20),
(25, 'Mac and Cheese ', 19),
(26, 'Pizza', 8),
(27, 'Marinara Sauce', 14),
(28, 'Salsa', 3),
(29, 'Pudding', 22),
(30, ' Reece\'s Peanut Cups', 19),
(31, 'Hot Dogs', 23),
(32, 'Pizza', 13),
(33, 'Orange', 16),
(34, 'pie', 28),
(35, 'cornflakes', 1),
(36, 'Fried Zucchini Blossoms', 9),
(37, 'Fried Rice ', 22),
(38, 'Ice Cream Cake', 13),
(39, 'Mashed Potatoes ', 28),
(40, 'Cantalope', 5),
(41, 'pie', 4),
(42, 'Enchilada', 23),
(43, 'Sweet Potatoe', 25),
(44, 'Tacos', 28),
(45, 'Chicken Nuggets', 3),
(46, 'Biscuits and Gravy', 8),
(47, ' Pumpkin Pie', 8),
(48, 'Eggs', 19),
(49, '', 16),
(50, 'Cantalope', 12),
(51, ' Bread', 24),
(52, 'Lasagna', 28),
(53, 'Donuts', 9),
(54, 'Marinara Sauce', 2),
(55, 'Hot Dogs', 8),
(56, 'Kiwi', 27),
(57, 'Onion Rings', 19),
(58, 'Apple', 2),
(59, 'Tamale', 12),
(60, 'Sweet Potatoe', 17),
(61, 'Enchilada', 6),
(62, 'noodles', 8),
(63, 'Gyro Sandwhich', 14),
(64, 'desserts', 30),
(65, 'Pizza', 10),
(66, 'desserts', 2),
(67, 'Bacon', 11),
(68, 'Burger ', 7),
(69, 'Tomato ', 6),
(70, 'Broccoli', 17),
(71, 'Broccoli', 23),
(72, 'beef stew', 12),
(73, 'Donuts', 9),
(74, 'Stuffing', 7),
(75, 'Ribs', 23),
(76, 'pie', 1),
(77, 'Mashed Potatoes ', 28),
(78, 'Mashed Potatoes ', 27),
(79, 'Mac and Cheese ', 16),
(80, 'Ice Cream Cake', 24),
(81, 'Roasted Chicken and Garlic', 20),
(82, 'Brownies', 11),
(83, 'Sushi ', 10),
(84, 'Grilled Chicken', 4),
(85, 'French Toast', 24),
(86, 'Soup ', 2),
(87, 'Mac and Cheese ', 22),
(88, 'Grilled Chicken', 27),
(89, 'Hot Dogs', 2),
(90, 'Bacon', 1),
(91, 'Crepes', 20),
(92, 'Tater Tots', 13),
(93, 'Fried Pork Chops and Gravy ', 20),
(94, 'Olive Garden Breadsticks', 10),
(95, 'Banana', 4),
(96, 'Carrot Cake', 13),
(97, 'Chicken Nuggets', 8),
(98, 'Fried Chicken', 13),
(99, 'Green Beans', 27),
(100, 'beef stew', 3);

-- --------------------------------------------------------

--
-- Table structure for table `genders`
--

CREATE TABLE `genders` (
  `genders_id` int(11) NOT NULL,
  `genders_name` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `genders`
--

INSERT INTO `genders` (`genders_id`, `genders_name`) VALUES
(1, 'Male'),
(2, 'Female'),
(3, 'Other'),
(4, 'Prefer not to say');

-- --------------------------------------------------------

--
-- Table structure for table `guests`
--

CREATE TABLE `guests` (
  `guests_id` int(11) NOT NULL,
  `username` varchar(20) DEFAULT NULL,
  `password` varchar(20) DEFAULT NULL,
  `firstname` varchar(20) NOT NULL,
  `lastname` varchar(20) NOT NULL,
  `dob` date DEFAULT NULL,
  `address` varchar(50) DEFAULT NULL,
  `city` varchar(25) DEFAULT NULL,
  `county` varchar(25) DEFAULT NULL,
  `postcode` varchar(20) DEFAULT NULL,
  `mobile` varchar(20) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `gender` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `guests`
--

INSERT INTO `guests` (`guests_id`, `username`, `password`, `firstname`, `lastname`, `dob`, `address`, `city`, `county`, `postcode`, `mobile`, `email`, `gender`) VALUES
(1, 'jane', 'malone', 'Jane', 'Malone', '1990-09-06', 'P.O. Box 604, 8204 Sed St.', 'Ferness', 'NA', 'H6D 4QH', '(017753) 82437', 'nisi.Aenean@vitae.ca', 2),
(2, 'tim', 'tim', 'Timothy', 'Cotton', '1978-08-01', '590-7723 Donec Road', 'Galway', 'C', 'CM1 1SA', '0834 136 6806', 'odio.semper.cursus@Cras.net', 1),
(3, 'zia', 'morin', 'Zia', 'Morin', '1976-04-22', '562-2506 Maecenas Avenue', 'Cork', 'M', '', '(01121) 70659', 'orci@sedleoCras.org', 1),
(4, 'daq', 'daq', 'Daquan', 'Gilliam', '1977-09-02', 'P.O. Box 329, 884 Ullamcorper. Rd.', 'Belfast', 'Ulster', '', '0936 737 5770', 'eu.eleifend@nonegestas.org', 1),
(5, 'martha', 'wallas', 'Martha', 'Walls', '1997-08-01', 'P.O. Box 626, 6503 Urna Road', 'Bridgnorth', 'SA', 'T3E 3NX', '0500 030496', 'sit.amet.ante@quis.co.uk', 1),
(6, 'shannon', 'shannon', 'Shannon', 'Stevely', '1976-01-16', 'Ap #341-5644 Gravida Ave', 'Banff', 'Banffshire', 'IQ0T 0EA', '0800 1111', 'ultrices@ultricesposuerecubilia.com', 1),
(7, '', '', 'Otto', 'Stevenson', '1980-06-28', 'P.O. Box 157, 6211 Nec Avenue', 'Hinckley', 'Leicestershire', 'Q63 1TC', '0380 600 5122', 'elit@cursusluctus.edu', 2),
(8, '', '', 'Philip', 'Holloway', '1971-07-27', 'Ap #231-8314 Volutpat. St.', 'Cork', 'M', '', '(0115) 479 3159', 'aliquet@tinciduntpede.net', 1),
(9, '', '', 'Dawn', 'Hinton', '1994-11-16', 'P.O. Box 668, 8571 Nec St.', 'Galway', 'C', '', '0889 571 0583', 'elit.pharetra@purus.org', 2),
(10, '', '', 'Marny', 'Ballard', '1985-11-06', '987-3538 Ipsum Street', 'Belfast', 'U', '', '0384 471 6574', 'Morbi@aliquet.co.uk', 2),
(11, '', '', 'Brennan', 'Bernard', '1974-11-23', '903-7369 Et, St.', 'Galway', 'Connacht', '', '(0111) 714 9028', 'diam.eu.dolor@nec.edu', 2),
(12, '', '', 'Shelley', 'Lucas', '1974-02-10', 'Ap #291-8591 Parturient Street', 'Newtonmore', 'IN', 'TV7U 7ZT', '(022) 3488 8232', 'nec.ante@sed.edu', 1),
(13, '', '', 'Carl', 'Humphrey', '1971-05-24', '445-560 Donec Road', 'Belfast', 'Ulster', '', '076 9381 1299', 'amet.metus.Aliquam@Nullaeuneque.net', 2),
(14, '', '', 'Anne', 'Moses', '1970-12-11', 'Ap #870-5668 Est, Rd.', 'Stockton-on-Tees', 'DU', 'SF5J 6AK', '(01430) 182328', 'lectus.justo.eu@ultrices.net', 1),
(15, '', '', 'Autumn', 'Castro', '1976-02-22', '764-9298 Nec Ave', 'Carlisle', 'CU', 'FT00 1ER', '0800 893958', 'nulla.In.tincidunt@rutrumFuscedolor.com', 2),
(16, '', '', 'Henry', 'Rhodes', '1997-12-03', '473 Elit. Ave', 'Ludlow', 'SA', 'UL8R 0IK', '076 3525 8940', 'risus@Nunc.com', 1),
(17, '', '', 'Harriet', 'Caldwell', '1993-05-13', '4985 Vel Rd.', 'Cork', 'M', '', '0967 309 4037', 'erat.vel@magnaatortor.co.uk', 2),
(18, '', '', 'Kiayada', 'Donaldson', '1982-01-24', 'P.O. Box 915, 2326 Neque. Street', 'Sudbury', 'Suffolk', 'K9 9ET', '0935 361 0982', 'eros.turpis.non@ornaretortor.com', 1),
(19, '', '', 'Belle', 'Bartlett', '1988-08-21', 'Ap #537-273 Risus. Ave', 'Alloa', 'Clackmannanshire', 'SJ8H 1HW', '070 3709 3119', 'euismod.est.arcu@aaliquet.ca', 2),
(20, '', '', 'Zelenia', 'Horne', '1997-09-18', '3240 Nunc. Road', 'Belfast', 'U', '', '(01163) 84272', 'lacinia.at@laciniaatiaculis.co.uk', 2),
(21, '', '', 'Dominique', 'Phillips', '2001-03-25', 'Ap #735-5610 Nisi Av.', 'Gloucester', 'GL', 'Z88 0KH', '070 4624 7741', 'facilisis.magna@elit.com', 1),
(22, '', '', 'Karyn', 'Tran', '1990-12-15', 'P.O. Box 555, 6335 In, Ave', 'Tillicoultry', 'CL', 'DX3 2NO', '0500 793558', 'gravida@ultricesposuere.org', 3),
(23, '', '', 'Melinda', 'Wolf', '1995-08-31', 'P.O. Box 221, 9781 Nisi Road', 'Port Glasgow', 'RF', 'SI90 7GS', '0356 409 6189', 'rutrum.magna.Cras@velitegestas.ca', 2),
(24, '', '', 'Quyn', 'Robles', '1994-01-10', 'P.O. Box 791, 6089 Ultrices. Rd.', 'Barrhead', 'Renfrewshire', 'OT09 6TY', '070 7431 1431', 'sociis.natoque@Nullamsuscipitest.ca', 1),
(25, '', '', 'Garrett', 'Mccarty', '2002-12-04', '255 Vivamus Avenue', 'Haverhill', 'Suffolk', 'VI8 5IP', '0800 1111', 'varius@Quisquenonummy.org', 1),
(26, '', '', 'Demetrius', 'Russo', '2003-08-01', 'Ap #126-9919 Mollis Road', 'Peterborough', 'Northamptonshire', 'PX83 9MK', '07624 185727', 'Phasellus@vel.org', 1),
(27, '', '', 'Maggy', 'Huber', '1993-08-07', 'P.O. Box 281, 7739 Sit Street', 'King\'s Lynn', 'Norfolk', 'IL8 9OO', '(01124) 29932', 'magna.Praesent@Nullam.ca', 2),
(28, '', '', 'Ifeoma', 'Golden', '1996-01-16', 'Ap #889-9540 Feugiat St.', 'New Radnor', 'Radnorshire', 'X1E 7UM', '0845 46 45', 'facilisis.Suspendisse.commodo@sedturpisnec.com', 3),
(29, '', '', 'Gareth', 'Williamson', '1994-01-04', '1796 Dolor. Ave', 'Solihull', 'WA', 'BO5H 3VN', '056 6687 4988', 'amet.consectetuer@veliteget.co.uk', 1),
(30, '', '', 'Mufutau', 'Cherry', '2002-09-28', '226-7673 Aliquet Rd.', 'Bromyard', 'Herefordshire', 'OD1T 6WC', '070 3791 5651', 'dolor.Donec@Quisquefringilla.co.uk', 1),
(31, '', '', 'Grady', 'Rosales', '1991-09-25', 'Ap #574-5612 Sit Rd.', 'Tregaron', 'CG', 'A1 0OS', '(01697) 681049', 'gravida.molestie@orciquis.com', 3),
(32, '', '', 'Renee', 'Fulton', '1992-01-18', '865 Pellentesque. St.', 'Tewkesbury', 'Gloucestershire', 'M85 6GD', '0968 163 4468', 'magna.Praesent@adipiscingnonluctus.ca', 3),
(33, '', '', 'Anjolie', 'Brennan', '1993-11-23', 'P.O. Box 133, 4807 Molestie Av.', 'Walsall', 'Staffordshire', 'AZ8 2RB', '055 3389 8194', 'tristique.neque@tempor.net', 1),
(34, '', '', 'Tate', 'Church', '2002-05-18', '1730 Fermentum Street', 'Sromness', 'OK', 'KG40 2LY', '(01162) 797380', 'Donec.porttitor@cursuspurus.net', 1),
(35, '', '', 'Justina', 'Dillon', '1992-05-31', '3901 Et, Av.', 'Derby', 'Derbyshire', 'LH8 8GQ', '07624 361306', 'rutrum.Fusce.dolor@dictumeuplacerat.edu', 3),
(36, '', '', 'Kevin', 'Mccoy', '1993-07-06', '6193 Egestas Rd.', 'Newtonmore', 'Inverness-shire', 'YL5N 8UE', '07624 819630', 'elit.pede.malesuada@tellusidnunc.ca', 2),
(37, '', '', 'Kane', 'Sweet', '1993-04-25', '314-7302 Nulla Ave', 'Haverfordwest', 'PE', 'G0 6FE', '07624 565695', 'mi.Duis.risus@tincidunt.org', 1),
(38, '', '', 'Xenos', 'Mullen', '1991-02-28', 'Ap #890-7431 Semper St.', 'Leicester', 'LE', 'YM9H 2JG', '0800 759 9946', 'Aliquam.rutrum@nuncInat.co.uk', 2),
(39, '', '', 'Lillith', 'Trujillo', '2000-04-20', 'P.O. Box 753, 8385 Eget Street', 'Birmingham', 'WA', 'EX0 1BJ', '055 6008 4879', 'Mauris.non@rutrum.com', 1),
(40, '', '', 'Harper', 'Noel', '1991-03-01', 'Ap #737-4916 Habitant Road', 'Shrewsbury', 'Shropshire', 'TT4 4RI', '(016977) 0872', 'mi@Donecfringilla.co.uk', 3),
(41, '', '', 'Dominique', 'Sampson', '1999-09-01', '4099 In Av.', 'Tillicoultry', 'CL', 'DO9 4AN', '0800 024 5374', 'montes@semut.org', 2),
(42, '', '', 'Tanner', 'Bates', '1990-12-20', 'Ap #656-366 Lacinia Road', 'Grimsby', 'Lincolnshire', 'JT42 8XQ', '07624 451349', 'congue.turpis.In@vel.ca', 3),
(43, '', '', 'Faith', 'Carpenter', '2003-11-02', '3782 Enim. Avenue', 'Greenlaw', 'Berwickshire', 'D5 2MU', '0933 151 6317', 'facilisis.lorem.tristique@euturpis.com', 2),
(44, '', '', 'Zorita', 'Schmidt', '1990-12-21', 'Ap #557-5060 Maecenas St.', 'Castle Douglas', 'Kirkcudbrightshire', 'BX27 4CW', '07675 319111', 'sociis.natoque.penatibus@Aeneangravidanunc.co.uk', 3),
(45, '', '', 'Iola', 'Griffin', '1994-12-25', 'Ap #163-9981 Venenatis St.', 'Corby', 'NT', 'KJ1 1JG', '(0141) 461 3939', 'vulputate.lacus@dictummi.com', 3),
(46, '', '', 'Rigel', 'Rutledge', '1999-07-15', '950-879 Enim. Road', 'Clovenfords', 'SE', 'GT37 6PA', '0396 735 0184', 'sit@ornareplacerat.edu', 2),
(47, '', '', 'Flynn', 'Terry', '2002-02-25', 'Ap #761-2028 Auctor, St.', 'Cheltenham', 'GL', 'VU45 0YB', '07883 305592', 'Phasellus@libero.com', 3),
(48, '', '', 'Galvin', 'Goodman', '1999-11-23', 'Ap #325-7426 Tincidunt Ave', 'Wrexham', 'DE', 'U34 6JY', '07624 710343', 'amet@egestashendrerit.edu', 2),
(49, '', '', 'Jacqueline', 'Brady', '1996-05-11', 'P.O. Box 508, 7574 Morbi St.', 'Whitehaven', 'CU', 'V2 3BW', '0800 346035', 'hymenaeos@utquamvel.org', 3),
(50, '', '', 'Solomon', 'Vaughn', '1998-07-21', '5024 Id St.', 'Ferness', 'NA', 'JQ3Z 1PE', '0500 251729', 'metus.facilisis@acfermentum.net', 2),
(51, '', '', 'Ainsley', 'Green', '1990-08-22', '634-3828 Ullamcorper, Av.', 'Barrhead', 'RF', 'O9 5BU', '0500 418322', 'parturient.montes.nascetur@facilisi.edu', 1),
(52, '', '', 'Claudia', 'Burke', '1991-04-27', '647 Eu, Avenue', 'Southampton', 'HA', 'XA6 6XU', '(01651) 496483', 'Pellentesque.tincidunt@Nullam.com', 2),
(53, '', '', 'Neville', 'Kim', '2003-10-31', '7766 Erat Rd.', 'Uppingham. Cottesmore', 'Rutland', 'L7 8GH', '055 0134 7049', 'at.velit.Pellentesque@vitaedolorDonec.net', 2),
(54, '', '', 'Blaze', 'Kirk', '2002-04-11', '6801 Sodales Road', 'Abingdon', 'Berkshire', 'PH8O 7ZU', '0800 1111', 'in.lobortis.tellus@ridiculus.co.uk', 1),
(55, '', '', 'Wade', 'Edwards', '1998-06-25', '8435 Ligula Ave', 'Bristol', 'Gloucestershire', 'A23 2NZ', '07624 708211', 'eu.placerat.eget@adipiscingMaurismolestie.edu', 1),
(56, '', '', 'Geoffrey', 'Hogan', '2002-11-23', 'P.O. Box 167, 8816 Mauris St.', 'Hawick', 'Roxburghshire', 'FL6 9PB', '056 7569 0466', 'ipsum.ac@nequesedsem.net', 2),
(57, '', '', 'Cherokee', 'Hudson', '1990-11-04', 'P.O. Box 656, 9931 Mauris St.', 'Selkirk', 'SE', 'KE6 6ZU', '0800 823037', 'neque.In.ornare@lobortisquis.edu', 2),
(58, '', '', 'Eugenia', 'Shepherd', '1996-01-11', 'Ap #419-4185 Lobortis Avenue', 'Lowestoft', 'Suffolk', 'IG6 5BB', '(024) 0300 5065', 'eget.mollis@torquentper.net', 1),
(59, '', '', 'Dahlia', 'Berg', '1997-01-02', '897-2393 Vivamus Street', 'Kendal', 'Westmorland', 'RV57 6GK', '0867 086 9592', 'urna.Vivamus@placerategetvenenatis.org', 1),
(60, '', '', 'Rama', 'Rodriguez', '1999-11-17', '372-9120 Turpis Avenue', 'Appleby', 'Westmorland', 'H9P 8XU', '(016977) 8528', 'Curae.Donec.tincidunt@vestibulum.edu', 2),
(61, '', '', 'Travis', 'Bowers', '1995-08-06', '647-7292 A Road', 'Market Drayton', 'Shropshire', 'U2 1CB', '0845 46 42', 'eget@Nulladignissim.com', 1),
(62, '', '', 'Palmer', 'Cleveland', '1978-05-31', '333-6814 Risus. Av.', 'Basildon', 'Essex', 'KY76 5IT', '07980 764151', 'nec@quamdignissimpharetra.co.uk', 1),
(63, '', '', 'Kane', 'Oneill', '2067-07-22', 'P.O. Box 388, 9603 Vel Rd.', 'Bath', 'Somerset', 'N3 4DE', '(0111) 118 7217', 'risus@dictum.com', 1),
(64, '', '', 'Kelly', 'Carver', '2060-09-08', '194-7839 Morbi Road', 'North Berwick', 'East Lothian', 'CD0A 6SR', '(0112) 253 8142', 'volutpat@facilisisSuspendissecommodo.edu', 1),
(65, '', '', 'Gregory', 'Ross', '1981-01-10', 'Ap #544-8736 Sem Ave', 'Mansfield', 'Nottinghamshire', 'I8 2IS', '070 6041 9998', 'lobortis.quis@egetipsumSuspendisse.ca', 1),
(66, '', '', 'Ishmael', 'Henson', '2001-05-28', 'P.O. Box 158, 529 Gravida Rd.', 'Bath', 'Somerset', 'Q88 7HG', '(0115) 221 3717', 'amet.ante.Vivamus@commodohendreritDonec.com', 1),
(67, '', '', 'Ross', 'Fitzpatrick', '2060-05-08', '5158 Non Rd.', 'East Linton', 'East Lothian', 'VE58 1BD', '0310 437 5294', 'id@nisiAenean.ca', 1),
(68, '', '', 'Tate', 'Butler', '1994-02-06', '1273 Aliquet. Road', 'Ely', 'Cambridgeshire', 'UM0 3HF', '(01172) 04680', 'sodales@fringillaporttitor.co.uk', 1),
(69, '', '', 'Daquan', 'Fischer', '1994-01-03', 'P.O. Box 194, 3488 Diam. Rd.', 'Southampton', 'Hampshire', 'BF6 4WG', '076 7871 9192', 'ut@posuerevulputatelacus.net', 1),
(70, '', '', 'Malcolm', 'Holland', '1972-06-17', '6749 Non, Avenue', 'Scalloway', 'Shetland', 'LP3V 3TD', '(023) 2097 7426', 'ullamcorper.Duis@quam.co.uk', 1),
(71, '', '', 'Hamilton', 'Macdonald', '2001-05-09', '417-9653 Est. Street', 'Bromley', 'Kent', 'S0K 8XA', '(0114) 170 2972', 'lorem@elitpellentesquea.co.uk', 1),
(72, '', '', 'Sebastian', 'Everett', '1979-01-22', '310-654 Cras Avenue', 'Melrose', 'Roxburghshire', 'KC65 5RD', '055 0901 5869', 'viverra.Donec@quam.co.uk', 1),
(73, '', '', 'Dillon', 'Lamb', '2060-07-25', '738-5559 Rutrum Avenue', 'Matlock', 'Derbyshire', 'G8 2CB', '0500 739440', 'facilisis@ultricies.co.uk', 1),
(74, '', '', 'Armando', 'Daniels', '1983-08-26', 'Ap #694-4548 Gravida Av.', 'Leominster', 'Herefordshire', 'IF8J 0OY', '0954 401 4144', 'dui.quis@semvitaealiquam.net', 1),
(75, '', '', 'Malcolm', 'Nash', '2001-08-01', '7066 Euismod Road', 'Kirriemuir', 'Angus', 'XX8H 5SG', '(0111) 791 2396', 'a@lobortisquis.org', 1),
(76, '', '', 'Trevor', 'Buckley', '1978-06-12', '245-4324 Metus St.', 'Newtown', 'Montgomeryshire', 'GU54 1HZ', '(029) 1469 0326', 'vitae.sodales@aliquetProin.edu', 1),
(77, '', '', 'Jordan', 'Hudson', '1975-09-07', '873-1306 Mauris Road', 'Tongue', 'Sutherland', 'O8Y 8TL', '07466 025298', 'Quisque.ac@nunc.edu', 1),
(78, '', '', 'Vernon', 'Lester', '1977-10-06', 'Ap #178-5671 Nulla. Avenue', 'Bristol', 'Gloucestershire', 'OI8P 6LY', '07663 010141', 'tellus.justo.sit@iaculisaliquet.edu', 1),
(79, '', '', 'Salvador', 'Hayes', '1984-06-22', '184-456 Fusce Rd.', 'Aylesbury', 'Buckinghamshire', 'Z8 1ES', '0880 613 7695', 'Lorem.ipsum.dolor@lectus.org', 1),
(80, '', '', 'Ralph', 'Shannon', '1970-09-22', '675-7338 Ut Street', 'Bracknell', 'Berkshire', 'S55 7XK', '076 4571 4167', 'Donec@adipiscinglacus.com', 1),
(81, '', '', 'Merritt', 'Riggs', '2067-02-10', 'P.O. Box 990, 9713 Varius Rd.', 'Troon', 'Ayrshire', 'R5 0FQ', '0845 46 40', 'Aliquam.vulputate@vulputateposuere.ca', 1),
(82, '', '', 'Cullen', 'Sampson', '1989-06-01', '2911 Sociis Rd.', 'Birmingham', 'Warwickshire', 'KB41 4GX', '0500 961246', 'sit.amet@ligulaconsectetuerrhoncus.ca', 1),
(83, '', '', 'Alfonso', 'Schroeder', '1973-02-04', '275 Eu St.', 'Hull', 'Yorkshire', 'X1T 0BE', '076 5583 2383', 'Cras.pellentesque.Sed@felispurusac.com', 1),
(84, '', '', 'Jameson', 'Bell', '2069-05-05', '320-7551 Integer St.', 'Arbroath', 'Angus', 'U8J 4UJ', '076 6806 8233', 'mauris@ipsumDonecsollicitudin.com', 1),
(85, '', '', 'Gavin', 'Gibbs', '1995-09-06', 'Ap #642-8550 Cursus. St.', 'Matlock', 'Derbyshire', 'WR6 8QL', '(020) 1935 6585', 'felis.eget.varius@VivamusrhoncusDonec.co.uk', 1),
(86, '', '', 'Lance', 'Mccall', '1998-04-24', 'Ap #388-1560 Nisi Rd.', 'Stoke-on-Trent', 'Staffordshire', 'NW92 7KA', '(0118) 896 0847', 'vel.lectus.Cum@Lorem.net', 1),
(87, '', '', 'Magee', 'Dalton', '1986-05-29', 'P.O. Box 941, 7044 Pede St.', 'Cawdor', 'Nairnshire', 'MP6I 9KM', '(01377) 337820', 'Vivamus@eget.org', 1),
(88, '', '', 'Jarrod', 'Humphrey', '1986-01-23', '3269 Enim. Road', 'Paignton', 'Devon', 'D66 6KX', '(01188) 478905', 'nisl@tortoratrisus.ca', 1),
(89, '', '', 'Valentine', 'Sosa', '1971-10-10', '8252 Per St.', 'Stranraer', 'Wigtownshire', 'CF0J 2QX', '0837 742 2968', 'montes@Suspendisse.net', 1),
(90, '', '', 'Simon', 'Delgado', '1988-01-23', '4779 Dui. Ave', 'Clovenfords', 'Selkirkshire', 'F1G 6UV', '(01182) 025155', 'erat.Vivamus.nisi@vel.co.uk', 1),
(91, '', '', 'Christian', 'Nichols', '2067-06-08', '650-9519 Donec St.', 'Colchester', 'Essex', 'HY5 9KI', '056 3341 1519', 'egestas.Fusce@Quisqueornaretortor.net', 1),
(92, '', '', 'Ivan', 'Mccoy', '2060-07-27', '184-2352 Feugiat St.', 'Market Drayton', 'Shropshire', 'AC03 5WS', '07624 414122', 'Cras@Sedcongue.com', 1),
(93, '', '', 'Joseph', 'Castaneda', '1991-11-07', '514-1388 Ut Av.', 'Barnstaple', 'Devon', 'F10 2BG', '(023) 7401 9634', 'Aliquam.erat.volutpat@turpisnonenim.ca', 1),
(94, '', '', 'Garth', 'Schmidt', '1984-10-02', '595-9213 Proin Road', 'Kircudbright', 'Kirkcudbrightshire', 'Y41 6QE', '0800 372 8464', 'nascetur@anteipsumprimis.edu', 1),
(95, '', '', 'Vance', 'Giles', '1973-08-03', '678-5539 Ut Avenue', 'Buckie', 'Banffshire', 'F9 6WS', '076 8234 1535', 'nunc.id@laciniavitae.net', 1),
(96, '', '', 'Lee', 'Murphy', '1986-11-05', '209-5528 Luctus St.', 'Lutterworth', 'Leicestershire', 'K07 4FT', '070 8711 9244', 'ultrices.posuere.cubilia@penatibus.co.uk', 1),
(97, '', '', 'Zachery', 'Schroeder', '2061-06-30', 'Ap #847-4666 Tellus Rd.', 'Ross-on-Wye', 'Herefordshire', 'J46 7SG', '(016977) 5864', 'tempus.risus@tellusloremeu.org', 1),
(98, '', '', 'Nissim', 'Santiago', '1995-06-24', 'P.O. Box 263, 6545 Ultrices St.', 'Machynlleth', 'Montgomeryshire', 'U4F 8AH', '(016977) 9559', 'Quisque.varius@pellentesquemassalobortis.net', 1),
(99, '', '', 'Mufutau', 'Norris', '1992-12-30', 'Ap #771-466 Lacinia St.', 'Milford Haven', 'Pembrokeshire', 'BG7 9WJ', '(018608) 88525', 'sem@etmagnis.co.uk', 1),
(100, '', '', 'Macon', 'Serrano', '1988-04-19', 'Ap #473-9005 Orci Av.', 'Bridgend', 'Glamorgan', 'HV69 7BN', '0822 388 9518', 'lacinia@Aeneanmassa.edu', 1),
(101, 'mumu', 'mumu', 'Mufaro', 'Kuguyo', NULL, NULL, NULL, NULL, NULL, NULL, 'mufarokuguyo@yahoo.co.uk', 2),
(102, NULL, NULL, 'Shannah', 'Mwase', '1995-06-15', '2035 St Marys', 'Harare', 'Chitown', 'PO box xg60', NULL, 'mwase@gmail.com', 2),
(103, NULL, NULL, 'Regardo', 'Pedro', '2000-11-16', '153', 'Northampton', 'North', 'NE', NULL, 'r.predro@gmail.com', 1),
(104, NULL, NULL, 'Jim', 'Brown', '1969-11-21', '37 boom boc', 'Belveder', 'Westminister', 'W1 R34', NULL, 'jim.brown@music.co.uk', 1);

-- --------------------------------------------------------

--
-- Table structure for table `menu`
--

CREATE TABLE `menu` (
  `menu_id` int(11) NOT NULL,
  `menu_name` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `menu`
--

INSERT INTO `menu` (`menu_id`, `menu_name`) VALUES
(1, 'Tso\'Boy Sandwich'),
(2, 'Capriottie'),
(3, 'Grilled Cheese'),
(4, 'Spazzo'),
(5, 'Salvo lamb sandwich'),
(6, 'Shrimp & Taco'),
(7, '21\'s Bugger'),
(8, 'Tops burger'),
(9, 'Georgia Chicken'),
(10, 'Prosciutto pie'),
(11, 'Pincho'),
(12, 'Bacon Wisconsin'),
(13, 'Lewi pizza'),
(14, 'Chill Lick Chicken'),
(15, 'Carls Chips'),
(16, 'Cod for life'),
(17, 'Haddock sandwich'),
(18, 'Twist and Turn'),
(19, 'Lappotte'),
(20, 'Jimmy Chew'),
(21, 'Veggie is life'),
(22, 'Meatless'),
(23, 'Lambo jambo'),
(24, 'Kings of Kings'),
(25, 'Deck of the west'),
(26, 'Life of mars'),
(27, 'Beefy is litty'),
(28, 'Children plaza'),
(29, 'Zousss '),
(30, 'Sonia soup');

-- --------------------------------------------------------

--
-- Table structure for table `reviews`
--

CREATE TABLE `reviews` (
  `reviews_id` int(11) NOT NULL,
  `rating` int(11) NOT NULL,
  `comment` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `roomhistory`
--

CREATE TABLE `roomhistory` (
  `roomHistory_id` int(11) NOT NULL,
  `rooms_id` int(11) NOT NULL,
  `rooms_name` varchar(20) NOT NULL,
  `rooms_type` varchar(20) NOT NULL,
  `price` int(11) NOT NULL,
  `audit` varchar(20) NOT NULL,
  `timestamp` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `roomhistory`
--

INSERT INTO `roomhistory` (`roomHistory_id`, `rooms_id`, `rooms_name`, `rooms_type`, `price`, `audit`, `timestamp`) VALUES
(1, 4, 'Zues', 'Quad', 200, 'updated', '2021-03-16 17:42:38'),
(2, 1, 'Lato', 'Single', 50, 'updated', '2021-04-19 18:36:45'),
(3, 29, 'South-side', 'Twin', 522, 'updated', '2021-04-19 18:37:05'),
(4, 1, 'Lato', 'Single', 50, 'updated', '2021-04-23 13:43:19'),
(5, 10, 'Decker', 'Luxurious Suite', 1200, 'updated', '2021-05-12 12:25:15');

-- --------------------------------------------------------

--
-- Table structure for table `rooms`
--

CREATE TABLE `rooms` (
  `rooms_id` int(11) NOT NULL,
  `rooms_name` varchar(20) NOT NULL,
  `rooms_type` varchar(20) NOT NULL,
  `price` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `rooms`
--

INSERT INTO `rooms` (`rooms_id`, `rooms_name`, `rooms_type`, `price`) VALUES
(1, 'Lato', 'Single', 70),
(2, 'Dianna', 'Double', 85),
(3, 'Aphrodite', 'Tripple', 150),
(4, 'Zues', 'Quad', 400),
(5, 'Blue', 'Queen', 150),
(6, 'Dark Moon', 'King', 72),
(7, 'Red Moon', 'Twin', 49),
(8, 'Moonrise', 'Double-Double', 50),
(9, 'Sun-Set', 'Suite', 300),
(10, 'Decker', 'Luxurious Suite', 1200),
(11, 'LA', 'Luxurious Suite', 600),
(12, 'Angels', 'Luxurious Suite', 900),
(13, 'Qwam', 'Luxurious Suite', 1500),
(14, 'Blue Star', 'Luxurious Suite', 500),
(15, 'Night Star', 'King', 400),
(16, 'Morning Star', 'King', 450),
(17, 'Sunrise', 'King', 500),
(18, 'Divine', 'King', 320),
(19, 'Yum', 'King', 210),
(20, 'Tingles', 'Single', 119),
(21, 'Dip', 'Single', 675),
(22, 'Sweet ties', 'Single', 84),
(23, 'Pop Smoke', 'Single', 67),
(24, 'Papi', 'Quad', 144),
(25, 'The woo', 'Quad', 144),
(26, 'Queen Alexandra', 'Quad', 1000),
(27, 'Husky', 'Quad', 228),
(28, 'Bexley', 'Twin', 234),
(29, 'South-side', 'Twin', 520),
(30, 'West-side', 'Twin', 90);

--
-- Triggers `rooms`
--
DELIMITER $$
CREATE TRIGGER `room_before_update` BEFORE UPDATE ON `rooms` FOR EACH ROW BEGIN
INSERT INTO roomHistory (
    roomHistory_id,
    rooms_id,
    rooms_name,
    rooms_type,
    price,
    audit,
    timestamp)
    VALUES
    (NULL,
     OLD.rooms_id,
     OLD.rooms_name,
     OLD.rooms_type,
     OLD.price,
     "updated",
     NOW());

END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `rooms_count`
--

CREATE TABLE `rooms_count` (
  `rooms_count_id` int(11) NOT NULL,
  `rooms_fk` int(11) NOT NULL,
  `count` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `rooms_count`
--

INSERT INTO `rooms_count` (`rooms_count_id`, `rooms_fk`, `count`) VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 3),
(4, 4, 4),
(5, 5, 3),
(6, 6, 6),
(7, 7, 2),
(8, 8, 4),
(9, 9, 9),
(10, 10, 4),
(11, 11, 4),
(12, 12, 5),
(13, 13, 3),
(14, 14, 4),
(15, 15, 3),
(16, 16, 5),
(17, 17, 5),
(18, 18, 5),
(19, 19, 5),
(20, 20, 1),
(21, 21, 1),
(22, 22, 1),
(23, 23, 1),
(24, 24, 4),
(25, 25, 2),
(26, 26, 4),
(27, 27, 4),
(28, 28, 2),
(29, 29, 2),
(30, 30, 2);

-- --------------------------------------------------------

--
-- Table structure for table `rooms_status`
--

CREATE TABLE `rooms_status` (
  `rooms_status_id` int(11) NOT NULL,
  `status` tinyint(4) NOT NULL,
  `date_from` datetime NOT NULL,
  `date_to` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `services`
--

CREATE TABLE `services` (
  `services_id` int(11) NOT NULL,
  `services_name` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `services`
--

INSERT INTO `services` (`services_id`, `services_name`) VALUES
(1, 'Breakfast'),
(2, 'Parking'),
(3, 'Romance packages'),
(4, 'Visitors passes'),
(5, 'Flowers'),
(6, 'Kids playground'),
(7, 'Restaurant'),
(8, 'Wellness'),
(9, 'Shuttle'),
(10, 'Brothel'),
(11, 'Bar'),
(12, 'Tourism'),
(13, 'High speed internet'),
(14, 'Parking'),
(15, 'Room services'),
(16, 'Butler service'),
(17, 'Fitness suite');

-- --------------------------------------------------------

--
-- Table structure for table `status`
--

CREATE TABLE `status` (
  `status_id` int(11) NOT NULL,
  `status_name` varchar(14) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `status`
--

INSERT INTO `status` (`status_id`, `status_name`) VALUES
(1, 'active'),
(2, 'cancelled');

-- --------------------------------------------------------

--
-- Table structure for table `suppliers`
--

CREATE TABLE `suppliers` (
  `suppliers_id` int(11) NOT NULL,
  `suppliers_name` varchar(40) NOT NULL,
  `suppliers_phone` varchar(20) NOT NULL,
  `suppliers_email` varchar(50) DEFAULT NULL,
  `supplies_fk` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `suppliers`
--

INSERT INTO `suppliers` (`suppliers_id`, `suppliers_name`, `suppliers_phone`, `suppliers_email`, `supplies_fk`) VALUES
(1, 'Et Netus Et Corp.', '(016977) 3517', 'mi.tempor@blanditNamnulla.com', 11),
(2, 'Sit Company', '0500 178175', 'dictum@Quisque.org', 2),
(3, 'Cursus Foundation', '056 4439 0282', 'pharetra@odioa.com', 2),
(4, 'Sollicitudin A Malesuada Company', '(013150) 78612', 'Donec.sollicitudin.adipiscing@cubilia.com', 5),
(5, 'Quisque LLC', '(01136) 31361', 'molestie.sodales.Mauris@interdum.edu', 3),
(6, 'Mi Tempor Lorem Institute', '07624 567521', 'consectetuer.euismod@diamlorem.org', 2),
(7, 'Ullamcorper Inc.', '070 8590 9314', 'aliquet.magna@ametorci.net', 14),
(8, 'Nec Diam Associates', '07062 218007', 'Vivamus.rhoncus@Quisqueimperdiet.edu', 9),
(9, 'Dapibus Id Blandit Inc.', '(016977) 5657', 'Nulla.semper@nec.co.uk', 1),
(10, 'Sed Sapien Nunc Incorporated', '0845 46 49', 'sed.turpis@nulla.edu', 7),
(11, 'Magnis Dis Parturient PC', '056 3531 0929', 'erat.Vivamus.nisi@ultricessit.org', 3),
(12, 'Non Enim Commodo Inc.', '(01175) 87918', 'a.arcu@eratin.org', 5),
(13, 'Lorem Incorporated', '076 0851 0091', 'eu@lorem.co.uk', 4),
(14, 'Non Sollicitudin Ltd', '(0171) 655 5044', 'egestas.rhoncus.Proin@urna.co.uk', 4),
(15, 'Magna A PC', '(028) 3186 0046', 'elementum.at.egestas@ipsumportaelit.org', 6),
(16, 'Ac Urna Company', '07624 034094', 'iaculis.aliquet@arcuVestibulum.com', 6),
(17, 'Enim PC', '0800 158315', 'in@Duis.net', 12),
(18, 'Ipsum Associates', '0355 276 9054', 'Duis@ante.org', 11),
(19, 'Mauris Ipsum Corporation', '076 2017 5955', 'orci@neceleifendnon.co.uk', 5),
(20, 'Eu Arcu Industries', '0840 358 9565', 'augue.ac.ipsum@estmollis.edu', 5),
(21, 'Vitae Foundation', '(0151) 358 1563', 'commodo@in.edu', 11),
(22, 'Morbi PC', '070 0391 4905', 'augue.eu@pedesagittisaugue.com', 11),
(23, 'Nunc Ltd', '(0111) 013 7133', 'Duis.dignissim@convallisconvallis.edu', 6),
(24, 'Ante Incorporated', '(01180) 457188', 'metus.Aenean@quislectusNullam.com', 10),
(25, 'Ipsum Sodales Purus Inc.', '(029) 1344 7419', 'dolor.Quisque@nislQuisquefringilla.ca', 3),
(26, 'Consequat Auctor Nunc LLP', '(021) 1045 8205', 'dui@velitjustonec.edu', 13),
(27, 'In Inc.', '(017673) 63693', 'ligula.tortor@lacus.org', 13),
(28, 'Ut Nisi A Corp.', '0800 679522', 'purus@acorciUt.edu', 13),
(29, 'Nisl LLP', '07499 737470', 'elit@congueelit.org', 12),
(30, 'Id Consulting', '0896 054 0810', 'augue@utmolestie.ca', 5),
(31, 'Ornare Libero At LLP', '070 9066 3468', 'ac.libero.nec@erat.com', 5),
(32, 'Neque Corporation', '(016977) 6949', 'vel.nisl@risusa.net', 8),
(33, 'Sit Limited', '0500 630117', 'faucibus.Morbi.vehicula@consectetueradipiscing.org', 12),
(34, 'Fringilla Donec Feugiat Ltd', '076 2413 3994', 'et.libero@nequeetnunc.ca', 8),
(35, 'Nibh Enim Institute', '07010 444393', 'enim.gravida@Morbi.edu', 4),
(36, 'Vestibulum Ante LLC', '(0101) 068 9717', 'elit@commodotinciduntnibh.net', 8),
(37, 'Lacus Quisque Purus LLP', '0967 264 3711', 'tortor.Nunc@torquent.com', 13),
(38, 'Lorem Corporation', '0800 1111', 'nec@sedduiFusce.ca', 14),
(39, 'Erat Institute', '(029) 8493 4272', 'non.leo.Vivamus@ut.org', 1),
(40, 'Ornare Industries', '076 3220 5856', 'gravida.Praesent.eu@ornareInfaucibus.org', 4);

-- --------------------------------------------------------

--
-- Table structure for table `supplies`
--

CREATE TABLE `supplies` (
  `supplies_id` int(11) NOT NULL,
  `supplies_name` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `supplies`
--

INSERT INTO `supplies` (`supplies_id`, `supplies_name`) VALUES
(1, 'Bar'),
(2, 'Food'),
(3, 'Beverage'),
(4, 'Hotel Bathroom'),
(5, 'Hotel Bedroom'),
(6, 'Children\'s Amenities'),
(7, 'Guest Amenities'),
(8, 'Toiletries'),
(9, 'Eco Friendly Products'),
(10, 'PPE'),
(11, 'Kitchen'),
(12, 'House keeping'),
(13, 'Kitchen'),
(14, 'Reception');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `username` varchar(40) NOT NULL,
  `password` varchar(40) NOT NULL,
  `firstname` varchar(30) NOT NULL,
  `lastname` varchar(30) NOT NULL,
  `email` varchar(50) DEFAULT NULL,
  `dob` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `username`, `password`, `firstname`, `lastname`, `email`, `dob`) VALUES
(1, 'tim', 'tim', 'Tim', 'Briggs', 'Tim.briggs@gmail.com', '1998-01-15'),
(2, 'shannon', 'shannon', 'Shannon', 'Stevely', 'sstevely@gmail.com', '1999-05-23'),
(3, 'lucy', 'lucy', 'Lucy', 'Chiganze', 'chiganzelucy@yahoo.co.uk', '1995-03-03');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `bookings`
--
ALTER TABLE `bookings`
  ADD PRIMARY KEY (`bookings_id`),
  ADD KEY `Bguests_fk` (`guests_fk`),
  ADD KEY `Brooms_fk` (`room_fk`),
  ADD KEY `Bstatus_fk` (`status_fk`),
  ADD KEY `Bmenu_fk` (`menu_fk`),
  ADD KEY `Bservices_fk` (`services_fk`);

--
-- Indexes for table `cancellations`
--
ALTER TABLE `cancellations`
  ADD PRIMARY KEY (`cancellations_id`),
  ADD KEY `Cbookings_fk` (`bookings_fk`);

--
-- Indexes for table `employees`
--
ALTER TABLE `employees`
  ADD PRIMARY KEY (`employees_id`),
  ADD KEY `Eemployee_fk` (`employee_role_fk`),
  ADD KEY `Egender_fk` (`gender`);

--
-- Indexes for table `employees_roles`
--
ALTER TABLE `employees_roles`
  ADD PRIMARY KEY (`employees_roles_id`);

--
-- Indexes for table `food`
--
ALTER TABLE `food`
  ADD PRIMARY KEY (`food_id`),
  ADD KEY `fmenu_fk` (`menu_fk`);

--
-- Indexes for table `genders`
--
ALTER TABLE `genders`
  ADD PRIMARY KEY (`genders_id`);

--
-- Indexes for table `guests`
--
ALTER TABLE `guests`
  ADD PRIMARY KEY (`guests_id`),
  ADD KEY `Ggenders_fk` (`gender`);

--
-- Indexes for table `menu`
--
ALTER TABLE `menu`
  ADD PRIMARY KEY (`menu_id`);

--
-- Indexes for table `reviews`
--
ALTER TABLE `reviews`
  ADD PRIMARY KEY (`reviews_id`);

--
-- Indexes for table `roomhistory`
--
ALTER TABLE `roomhistory`
  ADD PRIMARY KEY (`roomHistory_id`);

--
-- Indexes for table `rooms`
--
ALTER TABLE `rooms`
  ADD PRIMARY KEY (`rooms_id`);

--
-- Indexes for table `rooms_count`
--
ALTER TABLE `rooms_count`
  ADD PRIMARY KEY (`rooms_count_id`),
  ADD KEY `Rooms_fk` (`rooms_fk`);

--
-- Indexes for table `rooms_status`
--
ALTER TABLE `rooms_status`
  ADD PRIMARY KEY (`rooms_status_id`);

--
-- Indexes for table `services`
--
ALTER TABLE `services`
  ADD PRIMARY KEY (`services_id`);

--
-- Indexes for table `status`
--
ALTER TABLE `status`
  ADD PRIMARY KEY (`status_id`);

--
-- Indexes for table `suppliers`
--
ALTER TABLE `suppliers`
  ADD PRIMARY KEY (`suppliers_id`);

--
-- Indexes for table `supplies`
--
ALTER TABLE `supplies`
  ADD PRIMARY KEY (`supplies_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `bookings`
--
ALTER TABLE `bookings`
  MODIFY `bookings_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=134;

--
-- AUTO_INCREMENT for table `cancellations`
--
ALTER TABLE `cancellations`
  MODIFY `cancellations_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `employees`
--
ALTER TABLE `employees`
  MODIFY `employees_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT for table `employees_roles`
--
ALTER TABLE `employees_roles`
  MODIFY `employees_roles_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `food`
--
ALTER TABLE `food`
  MODIFY `food_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=101;

--
-- AUTO_INCREMENT for table `genders`
--
ALTER TABLE `genders`
  MODIFY `genders_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `guests`
--
ALTER TABLE `guests`
  MODIFY `guests_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=105;

--
-- AUTO_INCREMENT for table `menu`
--
ALTER TABLE `menu`
  MODIFY `menu_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `reviews`
--
ALTER TABLE `reviews`
  MODIFY `reviews_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `roomhistory`
--
ALTER TABLE `roomhistory`
  MODIFY `roomHistory_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `rooms`
--
ALTER TABLE `rooms`
  MODIFY `rooms_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `rooms_count`
--
ALTER TABLE `rooms_count`
  MODIFY `rooms_count_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `rooms_status`
--
ALTER TABLE `rooms_status`
  MODIFY `rooms_status_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `services`
--
ALTER TABLE `services`
  MODIFY `services_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `status`
--
ALTER TABLE `status`
  MODIFY `status_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `suppliers`
--
ALTER TABLE `suppliers`
  MODIFY `suppliers_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT for table `supplies`
--
ALTER TABLE `supplies`
  MODIFY `supplies_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `bookings`
--
ALTER TABLE `bookings`
  ADD CONSTRAINT `Bguests_fk` FOREIGN KEY (`guests_fk`) REFERENCES `guests` (`guests_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `Bmenu_fk` FOREIGN KEY (`menu_fk`) REFERENCES `menu` (`menu_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `Brooms_fk` FOREIGN KEY (`room_fk`) REFERENCES `rooms` (`rooms_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `Bservices_fk` FOREIGN KEY (`services_fk`) REFERENCES `services` (`services_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `Bstatus_fk` FOREIGN KEY (`status_fk`) REFERENCES `status` (`status_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `cancellations`
--
ALTER TABLE `cancellations`
  ADD CONSTRAINT `Cbookings_fk` FOREIGN KEY (`bookings_fk`) REFERENCES `bookings` (`bookings_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `employees`
--
ALTER TABLE `employees`
  ADD CONSTRAINT `Eemployee_fk` FOREIGN KEY (`employee_role_fk`) REFERENCES `employees_roles` (`employees_roles_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `Egender_fk` FOREIGN KEY (`gender`) REFERENCES `genders` (`genders_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `food`
--
ALTER TABLE `food`
  ADD CONSTRAINT `fmenu_fk` FOREIGN KEY (`menu_fk`) REFERENCES `menu` (`menu_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `guests`
--
ALTER TABLE `guests`
  ADD CONSTRAINT `Ggenders_fk` FOREIGN KEY (`gender`) REFERENCES `genders` (`genders_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `rooms_count`
--
ALTER TABLE `rooms_count`
  ADD CONSTRAINT `Rooms_fk` FOREIGN KEY (`rooms_fk`) REFERENCES `rooms` (`rooms_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
