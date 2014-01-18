CREATE DATABASE  IF NOT EXISTS `semedcontratos` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `semedcontratos`;
-- MySQL dump 10.13  Distrib 5.6.13, for Win32 (x86)
--
-- Host: localhost    Database: semedcontratos
-- ------------------------------------------------------
-- Server version	5.6.15

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
-- Table structure for table `tb_cargos`
--

DROP TABLE IF EXISTS `tb_cargos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_cargos` (
  `codigo_cargo` int(11) NOT NULL AUTO_INCREMENT,
  `nome_cargo` varchar(45) NOT NULL,
  `salario_hora_cargo` float NOT NULL,
  `grupo_ocupacional_cargo` varchar(15) NOT NULL,
  `clausula_primeira_cargo` varchar(7) NOT NULL,
  PRIMARY KEY (`codigo_cargo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_cargos`
--

LOCK TABLES `tb_cargos` WRITE;
/*!40000 ALTER TABLE `tb_cargos` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_cargos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_cidades`
--

DROP TABLE IF EXISTS `tb_cidades`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_cidades` (
  `codigo_cidade` int(11) NOT NULL AUTO_INCREMENT,
  `nome_cidade` varchar(45) NOT NULL,
  `uf_cidade` varchar(2) NOT NULL,
  PRIMARY KEY (`codigo_cidade`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_cidades`
--

LOCK TABLES `tb_cidades` WRITE;
/*!40000 ALTER TABLE `tb_cidades` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_cidades` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_contratos`
--

DROP TABLE IF EXISTS `tb_contratos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_contratos` (
  `codigo_contrato` int(11) NOT NULL,
  `justificativa_contrato` varchar(100) NOT NULL,
  `periodo_contrato` varchar(30) NOT NULL,
  `salario_contrato` float NOT NULL,
  `data_contrato` varchar(10) NOT NULL,
  `ano_seletivo_contrato` int(4) NOT NULL,
  `obs_contrato` varchar(250) DEFAULT NULL,
  `jornada_trabalho_contrato` int(3) NOT NULL,
  `codigo_pessoa` int(11) NOT NULL,
  `codigo_cargo` int(11) NOT NULL,
  PRIMARY KEY (`codigo_contrato`),
  KEY `fk_tb_contratos_tb_pessoas1_idx` (`codigo_pessoa`),
  KEY `fk_tb_contratos_tb_cargos1_idx` (`codigo_cargo`),
  CONSTRAINT `fk_tb_contratos_tb_pessoas1` FOREIGN KEY (`codigo_pessoa`) REFERENCES `tb_pessoas` (`codigo_pessoa`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tb_contratos_tb_cargos1` FOREIGN KEY (`codigo_cargo`) REFERENCES `tb_cargos` (`codigo_cargo`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_contratos`
--

LOCK TABLES `tb_contratos` WRITE;
/*!40000 ALTER TABLE `tb_contratos` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_contratos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_contratos_local_trabalho`
--

DROP TABLE IF EXISTS `tb_contratos_local_trabalho`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_contratos_local_trabalho` (
  `codigo_contrato` int(11) NOT NULL,
  `codigo_local_trabalho` int(11) NOT NULL,
  PRIMARY KEY (`codigo_local_trabalho`,`codigo_contrato`),
  KEY `fk_tb_contratos_local_trabalho_tb_contratos1_idx` (`codigo_contrato`),
  KEY `fk_tb_contratos_local_trabalho_tb_local_trabalho1_idx` (`codigo_local_trabalho`),
  CONSTRAINT `fk_tb_contratos_local_trabalho_tb_contratos1` FOREIGN KEY (`codigo_contrato`) REFERENCES `tb_contratos` (`codigo_contrato`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tb_contratos_local_trabalho_tb_local_trabalho1` FOREIGN KEY (`codigo_local_trabalho`) REFERENCES `tb_local_trabalho` (`codigo_local_trabalho`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_contratos_local_trabalho`
--

LOCK TABLES `tb_contratos_local_trabalho` WRITE;
/*!40000 ALTER TABLE `tb_contratos_local_trabalho` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_contratos_local_trabalho` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_horarios`
--

DROP TABLE IF EXISTS `tb_horarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_horarios` (
  `codigo_horario` int(11) NOT NULL AUTO_INCREMENT,
  `horario_periodo_horario` varchar(15) NOT NULL,
  `descricao_periodo_horario` varchar(15) NOT NULL,
  PRIMARY KEY (`codigo_horario`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_horarios`
--

LOCK TABLES `tb_horarios` WRITE;
/*!40000 ALTER TABLE `tb_horarios` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_horarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_horarios_local_trabalho`
--

DROP TABLE IF EXISTS `tb_horarios_local_trabalho`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_horarios_local_trabalho` (
  `codigo_horario` int(11) NOT NULL,
  `codigo_local_trabalho` int(11) NOT NULL,
  PRIMARY KEY (`codigo_horario`,`codigo_local_trabalho`),
  KEY `fk_tb_horarios_local_trabalho_tb_local_trabalho1_idx` (`codigo_horario`),
  KEY `fk_tb_horarios_local_trabalho_tb_horarios1_idx` (`codigo_local_trabalho`),
  CONSTRAINT `fk_tb_horarios_local_trabalho_tb_local_trabalho1` FOREIGN KEY (`codigo_horario`) REFERENCES `tb_local_trabalho` (`codigo_local_trabalho`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tb_horarios_local_trabalho_tb_horarios1` FOREIGN KEY (`codigo_local_trabalho`) REFERENCES `tb_horarios` (`codigo_horario`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_horarios_local_trabalho`
--

LOCK TABLES `tb_horarios_local_trabalho` WRITE;
/*!40000 ALTER TABLE `tb_horarios_local_trabalho` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_horarios_local_trabalho` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_local_trabalho`
--

DROP TABLE IF EXISTS `tb_local_trabalho`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_local_trabalho` (
  `codigo_local_trabalho` int(11) NOT NULL AUTO_INCREMENT,
  `nome_local_trabalho` varchar(45) NOT NULL,
  `responsavel_local_trabalho` varchar(45) DEFAULT NULL,
  `telefone_local_trabalho` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`codigo_local_trabalho`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_local_trabalho`
--

LOCK TABLES `tb_local_trabalho` WRITE;
/*!40000 ALTER TABLE `tb_local_trabalho` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_local_trabalho` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_mural`
--

DROP TABLE IF EXISTS `tb_mural`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_mural` (
  `codigo_mural` int(11) NOT NULL,
  `usuario_mural` varchar(45) NOT NULL,
  `data_mural` varchar(15) NOT NULL,
  `conteudo_mural` varchar(200) NOT NULL,
  PRIMARY KEY (`codigo_mural`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_mural`
--

LOCK TABLES `tb_mural` WRITE;
/*!40000 ALTER TABLE `tb_mural` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_mural` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_pessoas`
--

DROP TABLE IF EXISTS `tb_pessoas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_pessoas` (
  `codigo_pessoa` int(11) NOT NULL AUTO_INCREMENT,
  `nome_pessoa` varchar(50) NOT NULL,
  `cpf_pessoa` varchar(16) NOT NULL,
  `rg_pessoa` varchar(20) NOT NULL,
  `nacionalidade_pessoa` varchar(20) NOT NULL,
  `estado_civil_pessoa` varchar(20) NOT NULL,
  `bairro_pessoa` varchar(45) NOT NULL,
  `endereco_pessoa` varchar(250) NOT NULL,
  `email_pessoa` varchar(45) DEFAULT NULL,
  `telefone1_pessoa` varchar(15) NOT NULL,
  `telefone2_pessoa` varchar(15) DEFAULT NULL,
  `inst_medio_pessoa` varchar(45) DEFAULT NULL,
  `ano_medio_pessoa` int(4) DEFAULT NULL,
  `desc_graduacao1_pessoa` varchar(45) DEFAULT NULL,
  `inst_graduacao1_pessoa` varchar(45) DEFAULT NULL,
  `ano_graduacao1_pessoa` int(4) DEFAULT NULL,
  `desc_graduacao2_pessoa` varchar(45) DEFAULT NULL,
  `inst_graduacao2_pessoa` varchar(45) DEFAULT NULL,
  `ano_graduacao2_pessoa` int(4) DEFAULT NULL,
  `desc_pos1_pessoa` varchar(45) DEFAULT NULL,
  `inst_pos1_pessoa` varchar(45) DEFAULT NULL,
  `ano_pos1_pessoa` int(4) DEFAULT NULL,
  `desc_pos2_pessoa` varchar(45) DEFAULT NULL,
  `inst_pos2_pessoa` varchar(45) DEFAULT NULL,
  `ano_pos2_pessoa` int(4) DEFAULT NULL,
  `desc_mestrado_pessoa` varchar(45) DEFAULT NULL,
  `inst_mestrado_pessoa` varchar(45) DEFAULT NULL,
  `ano_mestrado_pessoa` int(4) DEFAULT NULL,
  `desc_doutorado_pessoa` varchar(45) DEFAULT NULL,
  `inst_doutorado_pessoa` varchar(45) DEFAULT NULL,
  `ano_doutorado_pessoa` int(4) DEFAULT NULL,
  `codigo_cidade` int(11) NOT NULL,
  PRIMARY KEY (`codigo_pessoa`),
  KEY `fk_tb_pessoas_tb_cidades_idx` (`codigo_cidade`),
  CONSTRAINT `fk_tb_pessoas_tb_cidades` FOREIGN KEY (`codigo_cidade`) REFERENCES `tb_cidades` (`codigo_cidade`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_pessoas`
--

LOCK TABLES `tb_pessoas` WRITE;
/*!40000 ALTER TABLE `tb_pessoas` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_pessoas` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-01-18 16:59:35
