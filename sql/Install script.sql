﻿--
CREATE DATABASE `venenumBonus`;
USE `venenumBonus`;
-- MySQL dump 10.13  Distrib 5.6.17, for Win32 (x86)
--
-- Host: 127.0.0.1    Database: venenumBonus		Autor Database: Samira Roters, Inga Saatz		Autor Population and Revision: Püppi Lawless, Inga Saatz   
-- ---------------------------------------------venenumBonus---------
-- Server version	5.6.20
--

--
SET SQL_SAFE_UPDATES=0;

--
-- Table structure for table `getraenkemarkt`
--
DROP TABLE IF EXISTS `tbl_getraenkemarkt`;
CREATE TABLE `tbl_getraenkemarkt` (
  `Getraenkemarkt_ID` int(10) unsigned NOT NULL,
  `name` varchar(45) NOT NULL,
  `ustid` varchar(11) NOT NULL,
  `strasse` varchar(45) NOT NULL,
  `wohnort` varchar(45) NOT NULL,
  `plz` char(5) NOT NULL,
  `tel` varchar(15) NOT NULL,
  `mail` varchar(45) NOT NULL,
  PRIMARY KEY (`Getraenkemarkt_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

--
-- Table structure for table `tbl_mitarbeiter`
--
DROP TABLE IF EXISTS `tbl_mitarbeiter`;
CREATE TABLE `tbl_mitarbeiter` (
  `Mitarbeiter_ID` int(10) unsigned NOT NULL ,
  `Getraenkemarkt_NR` int(10) unsigned NOT NULL,
  `passwort` varchar(255) DEFAULT NULL,
  `anrede` varchar(45) NOT NULL,
  `vorname` varchar(45) NOT NULL,
  `nachname` varchar(45) DEFAULT NULL,
  `tel` varchar(15) DEFAULT NULL,
  `mail` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`Mitarbeiter_ID`),
  FOREIGN KEY (`Getraenkemarkt_NR`) REFERENCES tbl_getraenkemarkt(Getraenkemarkt_ID)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;


--
-- Table structure for table `tbl_rolle`
--
DROP TABLE IF EXISTS `tbl_rolle`;
CREATE TABLE `tbl_rolle` (
  `Rolle_ID` int(10) unsigned NOT NULL ,
  `Mitarbeiter_NR` int(10) unsigned NOT NULL,
  `text` varchar(45) NOT NULL,
  `kuerzel` char(5) NOT NULL,
  PRIMARY KEY (`Rolle_ID`),
  FOREIGN KEY (`Mitarbeiter_NR`) REFERENCES tbl_mitarbeiter (Mitarbeiter_ID)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=latin1;


--
-- Table structure for table `tbl_kunde`
--
DROP TABLE IF EXISTS `tbl_kunde`;
CREATE TABLE `tbl_kunde` (
  `Kunde_ID` int(10) unsigned NOT NULL ,
  `passwort` varchar(45) NOT NULL,
  `anrede` varchar(45) NOT NULL,
  `vorname` varchar(45) NOT NULL,
  `nachname` varchar(45) NOT NULL,
  `geburtsdatum` date NOT NULL,
  `strasse` varchar(45) NOT NULL,
  `wohnort` varchar(45) NOT NULL,
  `plz` char(5) NOT NULL,
  `tel` varchar(15) NOT NULL,
  `mail` varchar(45) NOT NULL,
  `konto_nr` varchar(12) NOT NULL,
  `blz` char(8) NOT NULL,
  `bankname` varchar(45) NOT NULL,
  PRIMARY KEY (`Kunde_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


--
-- Table structure for table `tbl_artikelkategorie`
--
DROP TABLE IF EXISTS `tbl_artikelkategorie`;
CREATE TABLE `tbl_artikelkategorie` (
  `Artikelkategorie_ID` int(10) unsigned NOT NULL ,
  `bezeichnung` varchar(45) NOT NULL,
  `Parent_ID` int(10) unsigned,
  PRIMARY KEY (`Artikelkategorie_ID`),
  FOREIGN KEY (Parent_ID) REFERENCES tbl_artikelkategorie(Artikelkategorie_ID)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;

--
-- Table structure for table `tbl_artikel`
--

DROP TABLE IF EXISTS `tbl_artikel`;
CREATE TABLE `tbl_artikel` (
  `Artikel_ID` int(10) unsigned NOT NULL ,
  `Artikelkategorie_NR` int(10) unsigned NOT NULL,
  `preis` double NOT NULL,
  `bezeichnung` varchar(45) NOT NULL,
  `inhalt` double NOT NULL,
  `inhaltsbeschreibung` varchar(45) NOT NULL,
  PRIMARY KEY (`Artikel_ID`),
  FOREIGN KEY (`Artikelkategorie_NR`) REFERENCES tbl_artikelkategorie (Artikelkategorie_ID)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

--
-- Table structure for table `tbl_getraenkemarkt_artikel`
--

DROP TABLE IF EXISTS `tbl_getraenkemarkt_artikel`;
CREATE TABLE `tbl_getraenkemarkt_artikel` (
  `Artikel_ID` int(10) unsigned NOT NULL ,
  `Getraenkemarkt_NR` int(10) unsigned NOT NULL,
  `Anzahl` int(10) unsigned NOT NULL,
  PRIMARY KEY (`Artikel_ID`, Getraenkemarkt_NR),
  FOREIGN KEY (`Artikel_ID`) REFERENCES tbl_artikel (Artikel_ID),
  FOREIGN KEY (`Getraenkemarkt_NR`) REFERENCES tbl_getraenkemarkt (Getraenkemarkt_ID)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;



--
-- Table structure for table `tbl_warenkorb`
--
DROP TABLE IF EXISTS `tbl_warenkorb`;
CREATE TABLE `tbl_warenkorb` (
  `Kunde_NR` int(10) unsigned NOT NULL,
  `Artikel_NR` int(10) unsigned NOT NULL,
  `Getraenkemarkt_NR` int(10) unsigned NOT NULL,
  `anzahl` int(10) unsigned NOT NULL,
  PRIMARY KEY (`Kunde_NR`,`Artikel_NR`),
  FOREIGN KEY (`Artikel_NR`) REFERENCES tbl_artikel (Artikel_ID),
  FOREIGN KEY (`Kunde_NR`) REFERENCES tbl_kunde (Kunde_ID),
  FOREIGN KEY (`Getraenkemarkt_NR`) REFERENCES tbl_getraenkemarkt (Getraenkemarkt_ID)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


--
-- Table structure for table `tbl_bestellung`
--
DROP TABLE IF EXISTS `tbl_bestellung`;
CREATE TABLE `tbl_bestellung` (
  `Bestellung_ID` int(10) unsigned NOT NULL ,
  `Kunde_NR` int(10) unsigned NOT NULL,
  `Getraenkemarkt_NR` int(10) unsigned NOT NULL,
  `bestelldatum` date NOT NULL,
  `bestellstatus` varchar(45) DEFAULT NULL,
  `wunschtermin` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`Bestellung_ID`),
  FOREIGN KEY (`Kunde_NR`) REFERENCES tbl_kunde(Kunde_ID),
  FOREIGN KEY (`Getraenkemarkt_NR`) REFERENCES tbl_getraenkemarkt (Getraenkemarkt_ID)  
) ENGINE=InnoDB AUTO_INCREMENT=208 DEFAULT CHARSET=latin1;


--
-- Table structure for table `tbl_bestellposition`
--
DROP TABLE IF EXISTS `tbl_bestellposition`;
CREATE TABLE `tbl_bestellposition` (
  `Bestellposition_ID` int(10) unsigned NOT NULL ,
  `Bestellung_NR` int(10) unsigned NOT NULL,
  `Artikel_NR` int(10) unsigned NOT NULL,
  `anzahl` int(10) unsigned NOT NULL,
  `reduktion` double default 0,
  PRIMARY KEY (`Bestellposition_ID`),
  FOREIGN KEY (`Bestellung_NR`) REFERENCES tbl_bestellung (Bestellung_ID), 
  FOREIGN KEY (`Artikel_NR`) REFERENCES tbl_artikel (Artikel_ID)
  ) ENGINE=InnoDB AUTO_INCREMENT=118 DEFAULT CHARSET=latin1;


--
-- Table structure for table `tbl_lieferbezirk`
--
DROP TABLE IF EXISTS `tbl_lieferbezirk`;
CREATE TABLE `tbl_lieferbezirk` (
  `Lieferbezirk_ID` int(10) unsigned NOT NULL ,
  `plz` char(5) NOT NULL,
  PRIMARY KEY (`Lieferbezirk_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

--
-- Table structure for table `tbl_lieferer`
--
DROP TABLE IF EXISTS `tbl_lieferer`;
CREATE TABLE `tbl_lieferer` (
  `Lieferer_ID` int(10) unsigned NOT NULL ,
  `passwort` varchar(45) NOT NULL,
  `anrede` varchar(45) NOT NULL,
  `vorname` varchar(45) NOT NULL,
  `nachname` varchar(45) NOT NULL,
  `geburtsdatum` date NOT NULL,
  `strasse` varchar(45) NOT NULL,
  `wohnort` varchar(45) NOT NULL,
  `plz` char(5) NOT NULL,
  `tel` varchar(15) NOT NULL,
  `mail` varchar(45) NOT NULL,
  `beschreibung` varchar(45) NOT NULL,
  `konto_nr` varchar(12) NOT NULL,
  `blz` char(8) NOT NULL,
  `bankname` varchar(45) NOT NULL,
  PRIMARY KEY (`Lieferer_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;


--
-- Table structure for table `tbl_getraenkemarkt_has_lieferer`
--
DROP TABLE IF EXISTS `tbl_getraenkemarkt_has_lieferer`;
CREATE TABLE `tbl_getraenkemarkt_has_lieferer` (
  `Lieferer_NR` int(10) unsigned NOT NULL,
  `Getraenkemarkt_NR` int(10) unsigned NOT NULL,
  PRIMARY KEY (`Lieferer_NR`,`Getraenkemarkt_NR`),
  FOREIGN KEY (`Getraenkemarkt_NR`) REFERENCES tbl_getraenkemarkt (Getraenkemarkt_ID),
  FOREIGN KEY (`Lieferer_NR`) REFERENCES tbl_lieferer(Lieferer_ID)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


--
-- Table structure for table `tbl_lieferer_lieferbezirk`
--
DROP TABLE IF EXISTS `tbl_lieferer_lieferbezirk`;
CREATE TABLE `tbl_lieferer_lieferbezirk` (
	`Lieferbezirk_NR` int(10) unsigned NOT NULL, 
	`Lieferer_NR` int(10) unsigned NOT NULL,
	`Lieferzeit` varchar(45) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL,
	`Lieferpreis` double unsigned NOT NULL,
	PRIMARY KEY (`Lieferbezirk_NR`,`Lieferer_NR`),
	FOREIGN KEY (`Lieferbezirk_NR`) REFERENCES tbl_lieferbezirk(Lieferbezirk_ID),
	FOREIGN KEY (`Lieferer_NR`) REFERENCES tbl_lieferer(Lieferer_ID)	
) ENGINE=InnoDB CHARSET=latin1;

--
-- Table structure for table `tbl_liefererbestaetigung`
--
DROP TABLE IF EXISTS `tbl_liefererbestaetigung`;
CREATE TABLE `tbl_liefererbestaetigung` (
  `Lieferbestaetigung_ID` int(10) unsigned NOT NULL ,
  `Lieferer_NR` int(10) unsigned NOT NULL,
  `Bestellung_NR` int(10) unsigned NOT NULL,
  `liefertermin` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`Lieferbestaetigung_ID`),
  FOREIGN KEY (`Bestellung_NR`) REFERENCES tbl_bestellung (Bestellung_ID),
  FOREIGN KEY (`Lieferer_NR`) REFERENCES tbl_lieferer(Lieferer_ID)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=latin1;


  
-- 	-------------------------------------------------------------------------------------------------------------------------
--						DATENDUMP
-- 	-------------------------------------------------------------------------------------------------------------------------
--
-- Dumping data for table `getraenkemarkt`
--
INSERT INTO `tbl_getraenkemarkt` VALUES (1,'Trinkgut','23','Hamstrasse','Maieskuel','39850','3333333','trinkgut@mail.de'),(2,'Top','123','Maustraße','Maieskuel','39846','7788889','top@mail.de'),(3,'Stille Wasser','','','Maieskuel','39846','',''),(4,'Prost','333','Bierstraße','Maieskuel','39001','7788456','prost@mail.de');


--
-- Dumping data for table `tbl_mitarbeiter`
--
INSERT INTO `tbl_mitarbeiter` VALUES (1,1,'roxi','Herr','Walter','Wendolin','233002','ww@mail.de');
INSERT INTO `tbl_mitarbeiter` VALUES (2,1,'walti','Frau','Roxane','Wendolin','233002','roxi@mail.de');
INSERT INTO `tbl_mitarbeiter` VALUES (3,2,'Pumpi','Frau','Hannelore','Hahnenpatt','233003','hanni@mail.de');


--
-- Dumping data for table `tbl_rolle`
--
INSERT INTO `tbl_rolle` VALUES (14,1,'Leitung','RW');
INSERT INTO `tbl_rolle` VALUES (15,2,'Verkauf','WW');
INSERT INTO `tbl_rolle` VALUES (21,3,'Leitung','HH');
INSERT INTO `tbl_rolle` VALUES (22,3,'Verkauf','HH');



--
-- Dumping data for table `tbl_kunde`
--
INSERT INTO `tbl_kunde` VALUES (1,'gg','Frau','Herta','Mueller','1921-10-04','Neuerstrasse','Maieskuel','39850','0231-4445632','fritz@hotmail.de','1466215','35040083','Kommerzbank Maieskuel'),
(6,'Geld','Herr','Dagobert','Duck','1930-09-24','Am Geldspeicher 5','Maieskuel','39850','0345-567832','dd@gmx.de','111','370000','Sparkasse Maieskuel'),
(7,'CharlieMonson','Frau','Freya','Wille','1979-05-22','Feldweg 5','Maieskuel','39846','0345-9647893','freyaw@satannet.org','87352673','370000','Sparkasse Maieskuel'),
(8,'AsbachUralt','Herr','Hubert','Humbug','1966-04-12','Am Markt 88','Maieskuel','39846','0345-6342781','hubihum@yahoo.com','87634562','370000','Sparkasse Maieskuel'),
(9,'BornToP***','Frau','Amber','Love','1983-02-04','Rotlichtgasse 7','Maieskuel','39846','0345-7432556','amberlove@forsale.de','63764329','370000','Sparkasse Maieskuel'),
(10,'Yeyo','Herr','P.','Usher','1988-02-22','Rotlichtgasse 4','Maieskuel','39000','0345-7489523','Drugstore@gmx.at','73489234','380000','Sparkasse Übersee'),
(11,'Minka','Frau','Kriemhild','Kratzbaum','1944-05-23','Feldweg 17','Maieskuel','39000','0345-5367489','katzenlady@whiskas.de','6478239','370000','Sparkasse Maieskuel'),
(12,'SmithWesson','Herr','A.','S. S. Assin','1967-06-29','Am Friedhof 666','Maieskuel','39846','0346-7456273','gunfreak@hotmail.com','7325672','380000','Sparkasse Übersee'),
(13,'Leberwurst','Frau','Mathilda','Metzger','1977-04-24','Am Markt 1','Maieskuel','39846','0346-7526378','metzgereimetzger@gmx.de','466278','370000','Sparkasse Maieskuel'),
(14,'VladTheImpaler','Herr','Vlad','Draculea','1431-09-09','Am Friedhof 77','Maieskuel','39001','0346-6423458','tepes@gmx.ru','356784','370000','Sparkasse Maieskuel'),
(2,'Scrubadubdub','Herr','Jeffrey','Döhmer','1960-03-21','An der Schokoladenfabrik 8','Maieskuel','39846','567394876','jeff@gmx.de','6734567','370000','Sparkasse Maieskuel'),
(4,'LuckyStrike','Frau','Pueppi','Lawless','1983-10-24','Freier Fall 24','Maieskuel','39846','75385','plawless@gmx.de','7853456','370000','Sparkasse Maieskuel'),
(5,'justinchantal','Frau','Stefanie','Meier','1979-11-04','Am Markt 20','Maieskuel','39846','356721','mutti@yahoo.com','3657823','370000','Sparkasse Maieskuel'),
(3,'MyLittlePony','Herr','Rupert','Ratte','1963-07-22','Rotlichtgasse 55','Maieskuel','39846','436783','harleyfahrer@web.de','6345672','370000','Sparkasse Maieskuel'),
(16,'','','','','1990-12-12','','','','','','','',''),(17,'','','','','1998-01-12','','','','','','','','');
UPDATE tbl_kunde SET `vorname`='Vladimir', `nachname`='Drach' WHERE `Kunde_ID`='14';
UPDATE `venenumBonus`.`tbl_kunde` SET `passwort`='curare', `anrede`='Herr', `vorname`='Georg', `nachname`='Hausierer', `geburtsdatum`='1990-12-12', `strasse`='Am Trigger 88', `wohnort`='Orakel', `plz`='39850', `tel`='0346-465483', `mail`='rodentizid@web.de', `konto_nr`='5236785', `blz`='370001', `bankname`='Sparkasse Orakel' WHERE `Kunde_ID`='16';
UPDATE `venenumBonus`.`tbl_kunde` SET `konto_nr`='39830' WHERE `Kunde_ID`='4';
UPDATE `venenumBonus`.`tbl_kunde` SET `mail`='angelofdeath666@gmx.de' WHERE `Kunde_ID`='4';
UPDATE `venenumBonus`.`tbl_kunde` SET `passwort`='armani', `anrede`='Frau', `vorname`='Chantal', `nachname`='Schulze', `geburtsdatum`='1998-01-12', `strasse`='An der Schokoladenfabrik 8', `wohnort`='Maieskuel', `plz`='39000', `tel`='0346-7834572', `mail`='discomaus18@gmx.net', `konto_nr`='635432', `blz`='370000', `bankname`='Sparkasse Maieskuel' WHERE `Kunde_ID`='17';
INSERT INTO `venenumBonus`.`tbl_kunde` (`Kunde_ID`, `passwort`, `anrede`, `vorname`, `nachname`, `geburtsdatum`, `strasse`, `wohnort`, `plz`, `tel`, `mail`, `konto_nr`, `blz`, `bankname`) VALUES ('18', 'golfV', 'Herr', 'Pierre', 'Bauklo', '1998-02-28', 'Feldweg 6', 'Maieskuel', '39850', '0346-4386743', 'tuning@web.net', '78325672', '370000', 'Sparkasse Maieskuel');
INSERT INTO `venenumBonus`.`tbl_kunde` (`Kunde_ID`, `passwort`, `anrede`, `vorname`, `nachname`, `geburtsdatum`, `strasse`, `wohnort`, `plz`, `tel`, `mail`, `konto_nr`, `blz`, `bankname`) VALUES ('19', 'sicituradastra', 'Herr', 'Marco', 'Mark', '1977-05-30', 'Am Markt 35', 'Maieskuel', '39850', '0346-24532876', 'tittytwister@web.de', '36892563738', '370000', 'Sparkasse Maieskuel');
UPDATE `venenumBonus`.`tbl_kunde` SET `mail`='fritz@maieskuel.de' WHERE `Kunde_ID`='1';
UPDATE `venenumBonus`.`tbl_kunde` SET `mail`='jeff@maieskuel.de' WHERE `Kunde_ID`='2';
UPDATE `venenumBonus`.`tbl_kunde` SET `mail`='harleyfahrer@maieskuel.de' WHERE `Kunde_ID`='3';
UPDATE `venenumBonus`.`tbl_kunde` SET `mail`='angelofdeath666@gmxl.de' WHERE `Kunde_ID`='4';
UPDATE `venenumBonus`.`tbl_kunde` SET `mail`='mutti@maieskuel.de' WHERE `Kunde_ID`='5';
UPDATE `venenumBonus`.`tbl_kunde` SET `mail`='dd@maieskuel.de' WHERE `Kunde_ID`='6';
UPDATE `venenumBonus`.`tbl_kunde` SET `mail`='freyaw@maieskuel.de' WHERE `Kunde_ID`='7';
UPDATE `venenumBonus`.`tbl_kunde` SET `mail`='hubihum@maieskuel.de' WHERE `Kunde_ID`='8';
UPDATE `venenumBonus`.`tbl_kunde` SET `mail`='amberlove@maieskuel.de' WHERE `Kunde_ID`='9';
UPDATE `venenumBonus`.`tbl_kunde` SET `mail`='Drugstore@maieskuel.de' WHERE `Kunde_ID`='10';
UPDATE `venenumBonus`.`tbl_kunde` SET `mail`='katzenlady@maieskuel.de' WHERE `Kunde_ID`='11';
UPDATE `venenumBonus`.`tbl_kunde` SET `mail`='gunfreak@maieskuel.de' WHERE `Kunde_ID`='12';
UPDATE `venenumBonus`.`tbl_kunde` SET `mail`='metzgereimetzger@maieskuel.de' WHERE `Kunde_ID`='13';
UPDATE `venenumBonus`.`tbl_kunde` SET `mail`='tepes@maieskuel.de' WHERE `Kunde_ID`='14';
UPDATE `venenumBonus`.`tbl_kunde` SET `mail`='rodentizid@maieskuel.de' WHERE `Kunde_ID`='16';
UPDATE `venenumBonus`.`tbl_kunde` SET `mail`='discomaus18@maieskuel.de' WHERE `Kunde_ID`='17';
UPDATE `venenumBonus`.`tbl_kunde` SET `mail`='tuning@maieskuel.de' WHERE `Kunde_ID`='18';
UPDATE `venenumBonus`.`tbl_kunde` SET `mail`='tittytwister@maieskuel.de' WHERE `Kunde_ID`='19';
UPDATE `venenumBonus`.`tbl_kunde` SET `geburtsdatum`='1991-08-09' WHERE `Kunde_ID`='18';


--
-- Dumping data for table `tbl_artikelkategorie`
--
INSERT INTO `tbl_artikelkategorie` VALUES
(0, 'Getraenke', NULL),(1,'Alkoholfreie',0),(2,'Saefte',1),(3,'Wasser',1),(4,'Limonade',1),(5,'Alkoholhaltige',0),(6,'Wein',5),(7,'Bier',5),(8,'Milchhaltige',0),(9,'Milchsorte',8),(10,'Spezielles',0);
INSERT INTO `venenumBonus`.`tbl_artikelkategorie` (`Artikelkategorie_ID`, `bezeichnung`, `Parent_ID`) VALUES ('11', 'Whiskey', '5');
INSERT INTO `venenumBonus`.`tbl_artikelkategorie` (`Artikelkategorie_ID`, `bezeichnung`, `Parent_ID`) VALUES ('12', 'Sekt', '5');
UPDATE `venenumBonus`.`tbl_artikelkategorie` SET `bezeichnung`='Kölsch' WHERE `Artikelkategorie_ID`='7';
INSERT INTO `venenumBonus`.`tbl_artikelkategorie` (`Artikelkategorie_ID`, `bezeichnung`, `Parent_ID`) VALUES ('13', 'Cola', '4');
INSERT INTO `venenumBonus`.`tbl_artikelkategorie` (`Artikelkategorie_ID`, `bezeichnung`, `Parent_ID`) VALUES ('14', 'Kaffeegetränk', '9');
INSERT INTO `venenumBonus`.`tbl_artikelkategorie` (`Artikelkategorie_ID`, `bezeichnung`, `Parent_ID`) VALUES ('15', 'H-Milch', '9');
INSERT INTO `venenumBonus`.`tbl_artikelkategorie` (`Artikelkategorie_ID`, `bezeichnung`, `Parent_ID`) VALUES ('16', 'Kakao', '9');
INSERT INTO `venenumBonus`.`tbl_artikelkategorie` (`Artikelkategorie_ID`, `bezeichnung`, `Parent_ID`) VALUES ('17', 'Pils', '5');
INSERT INTO `venenumBonus`.`tbl_artikelkategorie` (`Artikelkategorie_ID`, `bezeichnung`, `Parent_ID`) VALUES ('18', 'Apfelsaft', '2');
INSERT INTO `venenumBonus`.`tbl_artikelkategorie` (`Artikelkategorie_ID`, `bezeichnung`, `Parent_ID`) VALUES ('19', 'Orangensaft', '2');



--
-- Dumping data for table `tbl_artikel`
--
INSERT INTO `tbl_artikel` VALUES (1,2,2.95,'Multisaft',0.5,'Fruchtsaft'),(2,3,2.95,'Bonaqua',0.5,'Kohlensäurehaltig'),(3,4,2.95,'Cola',0.5,'Kohlensäurehaltig'),(4,6,5,'Bordeaux',0.5,'Alk'),(5,7,2.5,'Pils',0.5,'Alk'),(6,9,2.55,'LatteGetraenk',0.5,'Enthält Milch'),(7,2,2.55,'Kirschsaft',0.5,'Fruchtsaft'),(8,10,65.95,'Sanguis',0.5,'');

--
-- Dumping data for table `tbl_getraenkemarkt_artikel`
--
INSERT INTO `tbl_getraenkemarkt_artikel` VALUES (1,1,2),(2,1,3),(3,1,4),(4,1,6),(5,1,7),(6,1,9),(7,1,2),(8,3,10),(1,2,3),(2,2,4),(3,2,2),(4,2,16),(5,2,1),(6,2,0),(7,2,2);


--
-- Dumping data for table `tbl_bestellung`
--
INSERT INTO `tbl_bestellung` VALUES (50,6,3, '2016-07-21','abgeschlossen','2016-07-23 15:00:00'),(49,14,3, '2016-07-21','abgeschlossen','2016-07-23 14:30:00'),(48,10,1, '2016-07-21','abgeschlossen','2016-07-23 11:30:00'),(47,1,3, '2016-07-20','abgeschlossen','2016-07-24 14:00:00'),(46,4,2,'2016-07-20','abgeschlossen','2016-07-22 12:00:00'),(45,3,1,'2016-07-20','abgeschlossen','2016-07-23 15:00:00'),(44,7,2,'2016-07-20','abgeschlossen','2016-07-21 14:00:00'),(43,11,3,'2016-07-20','abgeschlossen','2016-07-25 16:00:00'),(51,12,1,'2016-07-22','bestellt','2016-07-26 17:00:00'),(52,8,1,'2016-07-22','bestellt','2016-07-26 07:00:00'),(53,9,2,'2016-07-22','bestellt','2016-07-26 11:00:00'),(54,11,3,'2016-07-23','bestellt','2016-08-01 14:00:00'),(55,5,1,'2016-07-23','abgeschlossen','2016-07-25 12:00:00'),(56,2,2,'2016-07-23','abgeschlossen','2016-07-25 14:10:00'),(57,6,3,'2016-07-23','bestellt','2016-07-31 14:30:00'),(58,13,1,'2016-07-24','bestellt','2016-08-02 16:00:00'),(59,7,2,'2016-07-24','bestellt','2016-08-01 07:00:00'),(60,14,3,'2016-07-25','bestellt','2016-08-04 16:00:00'), (61, 9,2, '2016-07-25', 'bestellt', '2016-07-31 14:00:00');


--
-- Dumping data for table `tbl_bestellposition`
--
INSERT INTO `tbl_bestellposition` VALUES (117,60,8,20,0),(116,59,3,10,0), (115,58,2,25,0), (114,57,8,9,0),(113,56,7,4,0),(112,55,5,18,0), (111,54,8,4,0), (110,53,1,4,0), (109,52,3,15,0), (108,51,4,4,0), (107,50,8,8,0), (106,49,8,5,0),(105,48,1,10,0), (104,47,8,7,0), (103,46,2,20,0), (102,45,6,10,0), (101,44,5,12,0), (100,43,8,6,0), (118, 61, 4, 4, 0);

--
-- Dumping data for table `tbl_lieferbezirk`
--
INSERT INTO `tbl_lieferbezirk` VALUES (1,'39850'),(2,'39846'),(3,'39001'), (4,'39000');
-- Table structure for table `tbl_lieferer`
--

--
-- Dumping data for table `tbl_lieferer`
--
INSERT INTO `tbl_lieferer` VALUES (1,'ee29','Herr','Lars','Mayer','1980-10-20','Maustrasse','Maieskuel','39846','6666666','lars@hotmail.de','gut','777980 ','370000','Sparkasse Maieskuelbank'),(2,'\"geheim\"','Frau','Anastasia','Mueller','1992-10-06','Recistraße','Maieskuel','39850','0165230985','anast@gmx.de','angemessen','777347','370000','Sparkasse Maieskuelbank'),(3,'Eric','Herr','Eric','Beckers','1982-06-08','Hamstraße','Maieskuel','39846','0234 / 588323','Eric@gmx.de','vertrauenswürdig','310 441 722','370000','Sparkasse Maieskuelbank'),(4,'nemesis','Herr','Dorian','Graie','1983-10-24','Freier Fall 66','Maieskuel','39846','666-23-666','aod666@gmx.de','seltsam aber zuverlässig','123456789','370000','Sparkasse Maieskuelbank');


--
-- Dumping data for table `tbl_getraenkemarkt_has_lieferer`
--
INSERT INTO `tbl_getraenkemarkt_has_lieferer` VALUES (1,1),(2,2),(2,3),(3,2),(3,3),(4,4);


--
-- Dumping data for table `tbl_liefererbestaetigung`
--
INSERT INTO `tbl_liefererbestaetigung`
(Lieferbestaetigung_ID,Lieferer_NR,Bestellung_NR) VALUES 
(16,2,48),
(15,3,47),
(14,4,46),
(13,4,45),
(12,2,44),
(11,3,43),
(17,3,49),
(18,3,50),
(19,4,51),
(20,2,52),
(21,2,53),
(22,3,54),
(23,1,55),
(24,4,56),
(25,3,57),
(26,4,58),
(27,2,59),
(28,3,60),
(31,2,61);


--
-- Dumping data for table `tbl_lieferer_lieferbezirk`
--
INSERT INTO `tbl_lieferer_lieferbezirk` VALUES (1,1,'Zwischen 14 und 16 Uhr',5),(2,2,'Zwischen 7 und 13 Uhr',5),(2,3,'Ab 16 Uhr',50),(3,4,'Ab 16 Uhr',5);



--
-- Dumping data for table `tbl_warenkorb`
--
INSERT INTO `tbl_warenkorb` VALUES (3,3,2,2),(3,5,2,4),(5,1,2,5);


