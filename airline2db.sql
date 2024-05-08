-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 08, 2024 at 05:40 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `airline2db`
--

-- --------------------------------------------------------

--
-- Table structure for table `flights`
--

CREATE TABLE `flights` (
  `Fid` int(11) NOT NULL,
  `FNumber` varchar(20) DEFAULT NULL,
  `From` varchar(50) DEFAULT NULL,
  `To` varchar(50) DEFAULT NULL,
  `Depttime` time DEFAULT NULL,
  `Arrivtime` time DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `flights`
--

INSERT INTO `flights` (`Fid`, `FNumber`, `From`, `To`, `Depttime`, `Arrivtime`) VALUES
(5, 'FL200', 'SFO', 'SEA', '09:00:00', '11:30:00'),
(6, 'FL201', 'SEA', 'DEN', '12:30:00', '15:00:00'),
(7, 'FL202', 'DEN', 'MIA', '16:00:00', '20:00:00'),
(8, 'FL203', 'MIA', 'SFO', '21:00:00', '00:30:00');

-- --------------------------------------------------------

--
-- Table structure for table `passengers`
--

CREATE TABLE `passengers` (
  `Pid` int(11) NOT NULL,
  `Name` varchar(100) DEFAULT NULL,
  `Date` date DEFAULT NULL,
  `Totalcost` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `passengers`
--

INSERT INTO `passengers` (`Pid`, `Name`, `Date`, `Totalcost`) VALUES
(5, 'Chris Green', '2023-04-05', 220.00),
(6, 'Pat Kim', '2023-04-06', 180.00),
(7, 'Jordan Lee', '2023-04-07', 300.00),
(8, 'Casey Hill', '2023-04-08', 190.00);

-- --------------------------------------------------------

--
-- Table structure for table `takesflight`
--

CREATE TABLE `takesflight` (
  `Pid` int(11) DEFAULT NULL,
  `Fid` int(11) DEFAULT NULL,
  `From` varchar(50) DEFAULT NULL,
  `To` varchar(50) DEFAULT NULL,
  `Ticketcost` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `takesflight`
--

INSERT INTO `takesflight` (`Pid`, `Fid`, `From`, `To`, `Ticketcost`) VALUES
(5, 5, 'SFO', 'SEA', 220.00),
(6, 6, 'SEA', 'DEN', 180.00),
(7, 7, 'DEN', 'MIA', 300.00),
(8, 8, 'MIA', 'SFO', 190.00);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `flights`
--
ALTER TABLE `flights`
  ADD PRIMARY KEY (`Fid`);

--
-- Indexes for table `passengers`
--
ALTER TABLE `passengers`
  ADD PRIMARY KEY (`Pid`);

--
-- Indexes for table `takesflight`
--
ALTER TABLE `takesflight`
  ADD KEY `Pid` (`Pid`),
  ADD KEY `Fid` (`Fid`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `takesflight`
--
ALTER TABLE `takesflight`
  ADD CONSTRAINT `takesflight_ibfk_1` FOREIGN KEY (`Pid`) REFERENCES `passengers` (`Pid`),
  ADD CONSTRAINT `takesflight_ibfk_2` FOREIGN KEY (`Fid`) REFERENCES `flights` (`Fid`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
