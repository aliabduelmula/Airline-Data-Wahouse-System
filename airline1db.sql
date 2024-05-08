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
-- Database: `airline1db`
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
(1, 'FL100', 'JFK', 'LAX', '08:00:00', '11:00:00'),
(2, 'FL101', 'LAX', 'ORD', '12:00:00', '15:00:00'),
(3, 'FL102', 'ORD', 'ATL', '16:00:00', '19:00:00'),
(4, 'FL103', 'ATL', 'JFK', '20:00:00', '23:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `passengers`
--

CREATE TABLE `passengers` (
  `Pid` int(11) NOT NULL,
  `Name` varchar(100) DEFAULT NULL,
  `Dates` date DEFAULT NULL,
  `Totalcost` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `passengers`
--

INSERT INTO `passengers` (`Pid`, `Name`, `Dates`, `Totalcost`) VALUES
(1, 'John Doe', '2023-04-01', 200.00),
(2, 'Jane Smith', '2023-04-02', 300.00),
(3, 'Alex Johnson', '2023-04-03', 250.00),
(4, 'Samantha Brown', '2023-04-04', 150.00);

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
(1, 1, 'JFK', 'LAX', 200.00),
(2, 2, 'LAX', 'ORD', 300.00),
(3, 3, 'ORD', 'ATL', 250.00),
(4, 4, 'ATL', 'JFK', 150.00);

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
