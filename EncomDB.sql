CREATE DATABASE  IF NOT EXISTS `encom` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_bin */;
USE `encom`;
-- MySQL dump 10.13  Distrib 5.7.17, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: encom
-- ------------------------------------------------------
-- Server version	5.7.20-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `categoria`
--

DROP TABLE IF EXISTS `categoria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categoria` (
  `idCategoria` int(11) NOT NULL,
  `nombre` varchar(45) CHARACTER SET utf8 NOT NULL,
  PRIMARY KEY (`idCategoria`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categoria`
--

LOCK TABLES `categoria` WRITE;
/*!40000 ALTER TABLE `categoria` DISABLE KEYS */;
INSERT INTO `categoria` VALUES (1,'Microprocesadores'),(2,'Almacenamiento'),(3,'Memorias'),(4,'Fuentes'),(5,'Motherboards');
/*!40000 ALTER TABLE `categoria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cliente`
--

DROP TABLE IF EXISTS `cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cliente` (
  `idCliente` int(11) NOT NULL,
  `usuario` varchar(45) CHARACTER SET utf8 NOT NULL,
  `contrasenia` varchar(45) CHARACTER SET utf8 NOT NULL,
  `tipo_usuario` bit(1) NOT NULL,
  `nombre` varchar(45) CHARACTER SET utf8 NOT NULL,
  `apellido` varchar(45) CHARACTER SET utf8 NOT NULL,
  `dni` varchar(8) CHARACTER SET utf8 NOT NULL,
  `fec_nac` date NOT NULL,
  `email` varchar(60) CHARACTER SET utf8 NOT NULL,
  PRIMARY KEY (`idCliente`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cliente`
--

LOCK TABLES `cliente` WRITE;
/*!40000 ALTER TABLE `cliente` DISABLE KEYS */;
INSERT INTO `cliente` VALUES (1,'admin','encom1234','','Andres','Malvestiti','39249660','1996-02-16','andres-malvestiti@hotmail.com'),(2,'john','doe','\0','John','Doe','11111111','1960-01-01','johndoe@gmail.com');
/*!40000 ALTER TABLE `cliente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `producto`
--

DROP TABLE IF EXISTS `producto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `producto` (
  `idProducto` int(11) NOT NULL,
  `nombre` varchar(60) CHARACTER SET utf8 NOT NULL,
  `descripcion` varchar(300) CHARACTER SET utf8 NOT NULL,
  `precio` decimal(7,0) NOT NULL,
  `img_path` varchar(255) CHARACTER SET utf8 NOT NULL,
  `subcategoria_idCat` int(11) NOT NULL,
  `subcategoria_idSubcat` int(11) NOT NULL,
  PRIMARY KEY (`idProducto`),
  KEY `fk_producto_subcategoria1_idx` (`subcategoria_idCat`,`subcategoria_idSubcat`),
  CONSTRAINT `fk_producto_subcategoria1` FOREIGN KEY (`subcategoria_idCat`, `subcategoria_idSubcat`) REFERENCES `subcategoria` (`idCat`, `idSubcat`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `producto`
--

LOCK TABLES `producto` WRITE;
/*!40000 ALTER TABLE `producto` DISABLE KEYS */;
INSERT INTO `producto` VALUES (1,'Intel Core i5','Procesadores de gama media o media-alta de la marca Intel. Se caracterizan por un precio asequible y prestaciones decentes. Suelen emplearse en ordenadores preparados para ejecutar programas complejos o juegos que necesiten potencia ligeramente superior.',5000,'img8583048704188615129.png',1,1),(2,'Intel Core i3','Procesadores de gama media de la marca Intel. Evolución de la familia Intel Core i3.',2000,'img-6773814515430349175.png',1,1),(3,'Intel Core i7','Intel Core i7 es una familia de procesadores 4 y 6 núcleos de la arquitectura Intel x86-64. Gama alta de la familia Intel.',3500,'img-5900490551649309349.png',1,1),(5,'Intel Core i9',' El procesador más ajustado de este nuevo nivel de procesadores de Intel sería el Core i9-7800X, que con sus 6 núcleos, 12 hilos y una memoria caché L2 de 8,25 MB ofrecerá una frecuencia de reloj de 3,5 GHz que llegará hasta los 4.0 GHz con el modo Turbo Clock 2.0.',23000,'img-3121739314622015557.png',1,1),(6,'Intel Celeron G470','Cantidad de núcleos: 1\r\nCantidad de subprocesos: 2\r\nFrecuencia básica del procesador: 2,00 GHz\r\nCaché: 1,5 MB SmartCache\r\nVelocidad del bus: 5 GT/s DMI',1500,'img-3301003913910740018.png',1,1),(7,'Intel Pentium G1630','Cantidad de núcleos: 2\r\nCantidad de subprocesos: 2\r\nFrecuencia básica del procesador: 2,80 GHz\r\nCaché: 2 MB SmartCache\r\nVelocidad del bus: 5 GT/s DMI',1800,'img-7761511022901922274.png',1,1),(8,'Memoria Ram Adata XPG ','Modelo: AX3U1600W4G11-SB\r\nCapacidad: 4Gb\r\nFrecuencia: 1600Mhz - DDR3\r\nDisipador Negro',1650,'img-704473717952058425.png',3,1),(9,'Memoria Ram Corsair Vengeance','Modeo: Lpx \r\nCapacidad: 64gb (8 X 8gb) \r\nTipo: Ddr4 Dram',3150,'img-3966598897083306663.png',3,2),(10,'Disco Western Digital Caviar','Modeo: Black \r\nCapacidad: 1Tb',3150,'img.png',2,1),(11,'SSD Kingston KC300','Modeo: 7MM KIT  \r\nCapacidad: 240GB',3150,'img-3134221912147904370.png',2,2),(12,'Fuente Noganet Generica','Modeo: ATX \r\nCapacidad: 500W',350,'img-1185392123443022965.png',4,1),(13,'Fuente Pc Cirkuit Planet +80','Modeo: Ckp800w Bronze\r\nCapacidad: 800W',1749,'img-104790142584525587.png',4,2),(14,'Motherboard Gigabyte','Modeo: Ga-ax370 Gaming K5 \r\nAm4 Ddr4',4789,'img-4676660064109979769.png',5,1),(15,'Motherboard Asus Maximus VI','Modeo: Gene Z87\r\nSocket 1150',4100,'img-1604295034886314748.png',5,2),(16,'AMD FX-6300 B','Modeo: Black Edition\r\nFrecuencia 3.5Ghz\r\nNucleos: 6',2289,'img-5432887525395350508.png',1,2),(17,'AMD Bulldozer Fx 8350','# OF CPU CORES	8\r\n# OF THREADS	8\r\nBASE CLOCK SPEED	4 GHz\r\nMAX TURBO CORE SPEED	4.2 GHz',4440,'img-8906251759755326384.png',1,2);
/*!40000 ALTER TABLE `producto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subcategoria`
--

DROP TABLE IF EXISTS `subcategoria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `subcategoria` (
  `idCat` int(11) NOT NULL,
  `idSubcat` int(11) NOT NULL,
  `nombre` varchar(45) CHARACTER SET utf8 NOT NULL,
  PRIMARY KEY (`idCat`,`idSubcat`),
  CONSTRAINT `idCat` FOREIGN KEY (`idCat`) REFERENCES `categoria` (`idCategoria`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subcategoria`
--

LOCK TABLES `subcategoria` WRITE;
/*!40000 ALTER TABLE `subcategoria` DISABLE KEYS */;
INSERT INTO `subcategoria` VALUES (1,1,'Intel'),(1,2,'AMD'),(2,1,'Discos Rigidos'),(2,2,'Discos de Estado Solido'),(3,1,'DDR3'),(3,2,'DDR4'),(4,1,'Genericas'),(4,2,'+80'),(5,1,'AM4'),(5,2,'1150');
/*!40000 ALTER TABLE `subcategoria` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-05-02 15:36:38
