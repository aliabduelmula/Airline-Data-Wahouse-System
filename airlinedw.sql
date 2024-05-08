-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 08, 2024 at 05:41 AM
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
-- Database: `airlinedw`
--

-- --------------------------------------------------------

--
-- Table structure for table `airline_dim`
--

CREATE TABLE `airline_dim` (
  `Airline` varchar(50) NOT NULL,
  `HQ` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `airline_dim`
--

INSERT INTO `airline_dim` (`Airline`, `HQ`) VALUES
('AirMAC', 'San Francisco'),
('AirMSC', 'New York');

-- --------------------------------------------------------

--
-- Table structure for table `date_dim`
--

CREATE TABLE `date_dim` (
  `Date` date NOT NULL,
  `Time` time DEFAULT NULL,
  `Day` varchar(20) DEFAULT NULL,
  `Week` int(11) DEFAULT NULL,
  `Month` varchar(20) DEFAULT NULL,
  `Year` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `date_dim`
--

INSERT INTO `date_dim` (`Date`, `Time`, `Day`, `Week`, `Month`, `Year`) VALUES
('2023-04-01', '00:00:00', 'Sunday', 13, 'April', 2023),
('2023-04-02', '00:00:00', 'Monday', 14, 'April', 2023),
('2023-04-03', '00:00:00', 'Tuesday', 14, 'April', 2023),
('2023-04-04', '00:00:00', 'Wednesday', 14, 'April', 2023);

-- --------------------------------------------------------

--
-- Table structure for table `flights_dim`
--

CREATE TABLE `flights_dim` (
  `Fid` int(11) NOT NULL,
  `FNumber` varchar(20) DEFAULT NULL,
  `From` varchar(50) DEFAULT NULL,
  `To` varchar(50) DEFAULT NULL,
  `Depttime` time DEFAULT NULL,
  `Arrivtime` time DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `flights_dim`
--

INSERT INTO `flights_dim` (`Fid`, `FNumber`, `From`, `To`, `Depttime`, `Arrivtime`) VALUES
(1, 'FL100', 'JFK', 'LAX', '08:00:00', '11:00:00'),
(2, 'FL101', 'LAX', 'ORD', '12:00:00', '15:00:00'),
(3, 'FL102', 'ORD', 'ATL', '16:00:00', '19:00:00'),
(4, 'FL103', 'ATL', 'JFK', '20:00:00', '23:00:00'),
(5, 'FL104', 'SFO', 'SEA ', '09:00:00', '12:30:00'),
(6, 'FL201', 'SEA', 'DEN', '12:30:00', '15:00:00'),
(7, 'FL202', 'DEN', 'MIA', '16:00:00', '20:00:00'),
(8, 'FL203', 'MIA', 'SFO', '21:00:00', '00:30:00');

-- --------------------------------------------------------

--
-- Table structure for table `flight_fact`
--

CREATE TABLE `flight_fact` (
  `Pid` int(11) DEFAULT NULL,
  `Fid` int(11) DEFAULT NULL,
  `Airline` varchar(50) DEFAULT NULL,
  `Date` date DEFAULT NULL,
  `Totalcost` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `flight_fact`
--

INSERT INTO `flight_fact` (`Pid`, `Fid`, `Airline`, `Date`, `Totalcost`) VALUES
(1, 1, 'AirMAC', '2023-04-01', 200.00),
(2, 2, 'AirMSC', '2023-04-02', 300.00),
(3, 3, 'AirMAC', '2023-04-03', 250.00),
(4, 4, 'AirMSC', '2023-04-04', 150.00),
(6, 6, 'AirMSC', '2023-04-05', 180.00),
(7, 7, 'AirMSC', '2023-04-05', 300.00),
(8, 8, 'AirMSC', '2023-04-05', 190.00);

-- --------------------------------------------------------

--
-- Table structure for table `passenger_dim`
--

CREATE TABLE `passenger_dim` (
  `Pid` int(11) NOT NULL,
  `Name` varchar(100) DEFAULT NULL,
  `Date` date DEFAULT NULL,
  `Totalcost` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `passenger_dim`
--

INSERT INTO `passenger_dim` (`Pid`, `Name`, `Date`, `Totalcost`) VALUES
(1, 'John Doe', '2023-04-01', 200.00),
(2, 'Jane Smith', '2023-04-02', 300.00),
(3, 'Alex Johnson', '2023-04-03', 250.00),
(4, 'Samantha Brown', '2023-04-04', 150.00),
(5, 'Chris Green\r\n', '2023-04-05', 220.00),
(6, 'Pat Kim', '2023-04-06', 180.00),
(7, 'Jordan Lee', '2023-04-07', 300.00),
(8, 'Casey Hill', '2023-04-08', 190.00);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `airline_dim`
--
ALTER TABLE `airline_dim`
  ADD PRIMARY KEY (`Airline`);

--
-- Indexes for table `date_dim`
--
ALTER TABLE `date_dim`
  ADD PRIMARY KEY (`Date`);

--
-- Indexes for table `flights_dim`
--
ALTER TABLE `flights_dim`
  ADD PRIMARY KEY (`Fid`);

--
-- Indexes for table `passenger_dim`
--
ALTER TABLE `passenger_dim`
  ADD PRIMARY KEY (`Pid`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
