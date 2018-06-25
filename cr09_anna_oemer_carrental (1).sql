-- phpMyAdmin SQL Dump
-- version 4.8.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Erstellungszeit: 25. Jun 2018 um 07:49
-- Server-Version: 10.1.33-MariaDB
-- PHP-Version: 7.2.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Datenbank: `cr09_anna_oemer_carrental`
--

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `additional_invoice`
--

CREATE TABLE `additional_invoice` (
  `id` smallint(5) UNSIGNED NOT NULL,
  `window` smallint(5) DEFAULT NULL,
  `tire` smallint(5) DEFAULT NULL,
  `mileage` int(11) DEFAULT NULL,
  `ticket` int(11) DEFAULT NULL,
  `fk_reservation` smallint(5) NOT NULL,
  `fuel` enum('Full','Empty') NOT NULL,
  `fk_insurance` varchar(20) NOT NULL,
  `total_sum` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `add_driver`
--

CREATE TABLE `add_driver` (
  `id` smallint(5) UNSIGNED NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `licence` varchar(30) NOT NULL,
  `age` enum('25+','25-') NOT NULL,
  `birthdate` date NOT NULL,
  `fk_reservation` smallint(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `car`
--

CREATE TABLE `car` (
  `id` smallint(5) UNSIGNED NOT NULL,
  `transmission` enum('manual','auto') NOT NULL,
  `fuel` enum('diesel','gas') NOT NULL,
  `class` enum('sedan','suv','van','sports') NOT NULL,
  `seats` enum('2','4','5','7','8','9') NOT NULL,
  `brand` enum('vw','bmw','audi','renault','toyota') NOT NULL,
  `fk_reservation` smallint(5) NOT NULL,
  `available` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `credit_card`
--

CREATE TABLE `credit_card` (
  `number` int(20) UNSIGNED NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `birthdate` date NOT NULL,
  `company` enum('visa','amex','mastercard') NOT NULL,
  `valid_date` date NOT NULL,
  `ccv_no` smallint(3) NOT NULL,
  `street` varchar(30) NOT NULL,
  `city` varchar(30) NOT NULL,
  `citycode` int(11) NOT NULL,
  `country` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `customer`
--

CREATE TABLE `customer` (
  `id` smallint(5) UNSIGNED NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `driver_fn` varchar(30) NOT NULL,
  `driver_ln` varchar(30) NOT NULL,
  `birthdate` date NOT NULL,
  `licence` varchar(30) NOT NULL,
  `fk_reservation` smallint(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Daten für Tabelle `customer`
--

INSERT INTO `customer` (`id`, `first_name`, `last_name`, `driver_fn`, `driver_ln`, `birthdate`, `licence`, `fk_reservation`) VALUES
(1, 'Dan', 'Med', 'Dan', 'Med', '1994-08-30', 'D230495', 0),
(2, 'Anna', 'Oe', 'Anna', 'Oe', '1996-04-20', 'F29853853', 0),
(3, 'Mario', 'Ma', 'Christoph', 'Ha', '1990-05-24', 'G4928343985', 0);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `do_location`
--

CREATE TABLE `do_location` (
  `code` varchar(10) NOT NULL,
  `dropoff_date` datetime NOT NULL,
  `fk_invoice` smallint(5) NOT NULL,
  `fk_reservation` smallint(5) NOT NULL,
  `fk_car` smallint(5) NOT NULL,
  `opening` time NOT NULL,
  `closing` time NOT NULL,
  `loc_phone` int(11) NOT NULL,
  `street` varchar(30) NOT NULL,
  `city` varchar(30) NOT NULL,
  `citycode` int(11) NOT NULL,
  `country` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `insurance`
--

CREATE TABLE `insurance` (
  `mix` varchar(20) NOT NULL,
  `age` enum('25+','25-','','') NOT NULL,
  `window` enum('Y','N','','') NOT NULL,
  `lost_key` enum('Y','N','','') NOT NULL,
  `passenger` enum('Y','N','','') NOT NULL,
  `comp_cover` enum('Y','N','','') NOT NULL,
  `acc_damn_excess` int(11) NOT NULL,
  `fk_reservation` smallint(5) NOT NULL,
  `fk_invoice` smallint(5) NOT NULL,
  `sum_in` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `invoice`
--

CREATE TABLE `invoice` (
  `id` smallint(5) UNSIGNED NOT NULL,
  `fk_customer` smallint(5) NOT NULL,
  `issue_date` date NOT NULL,
  `fk_poloc` varchar(10) NOT NULL,
  `no_rent_days` smallint(3) NOT NULL,
  `rent_per_day` smallint(5) NOT NULL,
  `fk_insurance` varchar(20) NOT NULL,
  `one_way_fee` smallint(5) NOT NULL,
  `voucher` smallint(5) DEFAULT NULL,
  `rent_total` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `pu_location`
--

CREATE TABLE `pu_location` (
  `code` varchar(10) NOT NULL,
  `pickup_date` datetime NOT NULL,
  `fk_invoice` smallint(5) NOT NULL,
  `fk_reservation` smallint(5) NOT NULL,
  `fk_car` varchar(5) NOT NULL,
  `opening` time NOT NULL,
  `closing` time NOT NULL,
  `loc_phone` int(11) NOT NULL,
  `street` varchar(30) NOT NULL,
  `city` varchar(30) NOT NULL,
  `citycode` int(11) NOT NULL,
  `country` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `reservation`
--

CREATE TABLE `reservation` (
  `id` smallint(5) UNSIGNED NOT NULL,
  `fk_invoice` smallint(5) NOT NULL,
  `fk_customer` smallint(5) NOT NULL,
  `fk_car` smallint(5) NOT NULL,
  `pickup_date` date NOT NULL,
  `dropoff_date` date NOT NULL,
  `fk_poloc` varchar(10) NOT NULL,
  `fk_doloc` varchar(10) NOT NULL,
  `fk_credit` int(20) NOT NULL,
  `voucher` int(11) DEFAULT NULL,
  `age` enum('25+','25-') NOT NULL,
  `fk_insurance` varchar(20) NOT NULL,
  `one_way` enum('Y','N') NOT NULL,
  `add_driver` enum('Y','N') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `staff`
--

CREATE TABLE `staff` (
  `id` smallint(5) UNSIGNED NOT NULL,
  `first_name` varchar(20) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `position` enum('associate','trainee','manager') NOT NULL,
  `birthdate` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Indizes der exportierten Tabellen
--

--
-- Indizes für die Tabelle `additional_invoice`
--
ALTER TABLE `additional_invoice`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_insurance` (`fk_insurance`);

--
-- Indizes für die Tabelle `add_driver`
--
ALTER TABLE `add_driver`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `car`
--
ALTER TABLE `car`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `credit_card`
--
ALTER TABLE `credit_card`
  ADD PRIMARY KEY (`number`);

--
-- Indizes für die Tabelle `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `do_location`
--
ALTER TABLE `do_location`
  ADD PRIMARY KEY (`code`);

--
-- Indizes für die Tabelle `insurance`
--
ALTER TABLE `insurance`
  ADD PRIMARY KEY (`mix`);

--
-- Indizes für die Tabelle `invoice`
--
ALTER TABLE `invoice`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_poloc` (`fk_poloc`),
  ADD KEY `fk_insurance` (`fk_insurance`);

--
-- Indizes für die Tabelle `pu_location`
--
ALTER TABLE `pu_location`
  ADD PRIMARY KEY (`code`);

--
-- Indizes für die Tabelle `reservation`
--
ALTER TABLE `reservation`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_poloc` (`fk_poloc`),
  ADD KEY `fk_insurance` (`fk_insurance`);

--
-- Indizes für die Tabelle `staff`
--
ALTER TABLE `staff`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT für exportierte Tabellen
--

--
-- AUTO_INCREMENT für Tabelle `additional_invoice`
--
ALTER TABLE `additional_invoice`
  MODIFY `id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `add_driver`
--
ALTER TABLE `add_driver`
  MODIFY `id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `car`
--
ALTER TABLE `car`
  MODIFY `id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `customer`
--
ALTER TABLE `customer`
  MODIFY `id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT für Tabelle `invoice`
--
ALTER TABLE `invoice`
  MODIFY `id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `reservation`
--
ALTER TABLE `reservation`
  MODIFY `id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `staff`
--
ALTER TABLE `staff`
  MODIFY `id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Constraints der exportierten Tabellen
--

--
-- Constraints der Tabelle `additional_invoice`
--
ALTER TABLE `additional_invoice`
  ADD CONSTRAINT `additional_invoice_ibfk_1` FOREIGN KEY (`fk_insurance`) REFERENCES `insurance` (`mix`);

--
-- Constraints der Tabelle `invoice`
--
ALTER TABLE `invoice`
  ADD CONSTRAINT `invoice_ibfk_1` FOREIGN KEY (`fk_poloc`) REFERENCES `pu_location` (`code`),
  ADD CONSTRAINT `invoice_ibfk_2` FOREIGN KEY (`fk_insurance`) REFERENCES `insurance` (`mix`);

--
-- Constraints der Tabelle `reservation`
--
ALTER TABLE `reservation`
  ADD CONSTRAINT `reservation_ibfk_1` FOREIGN KEY (`fk_poloc`) REFERENCES `do_location` (`code`),
  ADD CONSTRAINT `reservation_ibfk_2` FOREIGN KEY (`fk_poloc`) REFERENCES `pu_location` (`code`),
  ADD CONSTRAINT `reservation_ibfk_3` FOREIGN KEY (`fk_insurance`) REFERENCES `insurance` (`mix`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
