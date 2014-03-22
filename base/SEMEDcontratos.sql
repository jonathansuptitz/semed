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
  `grupo_ocupacional_cargo` varchar(45) NOT NULL,
  `clausula_primeira_cargo` varchar(2000) NOT NULL,
  PRIMARY KEY (`codigo_cargo`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_cargos`
--

LOCK TABLES `tb_cargos` WRITE;
/*!40000 ALTER TABLE `tb_cargos` DISABLE KEYS */;
INSERT INTO `tb_cargos` VALUES (3,'Professor',20,'AA','Clausula teste Professor'),(4,'Diretor',50,'BB','Clausula Teste Diretor');
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
  PRIMARY KEY (`codigo_cidade`)
) ENGINE=InnoDB AUTO_INCREMENT=5565 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_cidades`
--

LOCK TABLES `tb_cidades` WRITE;
/*!40000 ALTER TABLE `tb_cidades` DISABLE KEYS */;
INSERT INTO `tb_cidades` VALUES (4413,'Abdon Batista'),(4414,'Abelardo Luz'),(4415,'Agrolândia'),(4416,'Agronômica'),(4417,'Água Doce'),(4418,'Águas de Chapecó'),(4419,'Águas Frias'),(4420,'Águas Mornas'),(4421,'Alfredo Wagner'),(4422,'Alto Bela Vista'),(4423,'Anchieta'),(4424,'Angelina'),(4425,'Anita Garibaldi'),(4426,'Anitápolis'),(4427,'Antônio Carlos'),(4428,'Apiúna'),(4429,'Arabutã'),(4430,'Araquari'),(4431,'Araranguá'),(4432,'Armazém'),(4433,'Arroio Trinta'),(4434,'Arvoredo'),(4435,'Ascurra'),(4436,'Atalanta'),(4437,'Aurora'),(4438,'Balneário Arroio do Silva'),(4439,'Balneário Barra do Sul'),(4440,'Balneário Camboriú'),(4441,'Balneário Gaivota'),(4442,'Bandeirante'),(4443,'Barra Bonita'),(4444,'Barra Velha'),(4445,'Bela Vista do Toldo'),(4446,'Belmonte'),(4447,'Benedito Novo'),(4448,'Biguaçu'),(4449,'Blumenau'),(4450,'Bocaina do Sul'),(4451,'Bom Jardim da Serra'),(4452,'Bom Jesus'),(4453,'Bom Jesus do Oeste'),(4454,'Bom Retiro'),(4455,'Bombinhas'),(4456,'Botuverá'),(4457,'Braço do Norte'),(4458,'Braço do Trombudo'),(4459,'Brunópolis'),(4460,'Brusque'),(4461,'Caçador'),(4462,'Caibi'),(4463,'Calmon'),(4464,'Camboriú'),(4465,'Campo Alegre'),(4466,'Campo Belo do Sul'),(4467,'Campo Erê'),(4468,'Campos Novos'),(4469,'Canelinha'),(4470,'Canoinhas'),(4471,'Capão Alto'),(4472,'Capinzal'),(4473,'Capivari de Baixo'),(4474,'Catanduvas'),(4475,'Caxambu do Sul'),(4476,'Celso Ramos'),(4477,'Cerro Negro'),(4478,'Chapadão do Lageado'),(4479,'Chapecó'),(4480,'Cocal do Sul'),(4481,'Concórdia'),(4482,'Cordilheira Alta'),(4483,'Coronel Freitas'),(4484,'Coronel Martins'),(4485,'Correia Pinto'),(4486,'Corupá'),(4487,'Criciúma'),(4488,'Cunha Porã'),(4489,'Cunhataí'),(4490,'Curitibanos'),(4491,'Descanso'),(4492,'Dionísio Cerqueira'),(4493,'Dona Emma'),(4494,'Doutor Pedrinho'),(4495,'Entre Rios'),(4496,'Ermo'),(4497,'Erval Velho'),(4498,'Faxinal dos Guedes'),(4499,'Flor do Sertão'),(4500,'Florianópolis'),(4501,'Formosa do Sul'),(4502,'Forquilhinha'),(4503,'Fraiburgo'),(4504,'Frei Rogério'),(4505,'Galvão'),(4506,'Garopaba'),(4507,'Garuva'),(4508,'Gaspar'),(4509,'Governador Celso Ramos'),(4510,'Grão Pará'),(4511,'Gravatal'),(4512,'Guabiruba'),(4513,'Guaraciaba'),(4514,'Guaramirim'),(4515,'Guarujá do Sul'),(4516,'Guatambú'),(4517,'Herval d`Oeste'),(4518,'Ibiam'),(4519,'Ibicaré'),(4520,'Ibirama'),(4521,'Içara'),(4522,'Ilhota'),(4523,'Imaruí'),(4524,'Imbituba'),(4525,'Imbuia'),(4526,'Indaial'),(4527,'Iomerê'),(4528,'Ipira'),(4529,'Iporã do Oeste'),(4530,'Ipuaçu'),(4531,'Ipumirim'),(4532,'Iraceminha'),(4533,'Irani'),(4534,'Irati'),(4535,'Irineópolis'),(4536,'Itá'),(4537,'Itaiópolis'),(4538,'Itajaí'),(4539,'Itapema'),(4540,'Itapiranga'),(4541,'Itapoá'),(4542,'Ituporanga'),(4543,'Jaborá'),(4544,'Jacinto Machado'),(4545,'Jaguaruna'),(4546,'Jaraguá do Sul'),(4547,'Jardinópolis'),(4548,'Joaçaba'),(4549,'Joinville'),(4550,'José Boiteux'),(4551,'Jupiá'),(4552,'Lacerdópolis'),(4553,'Lages'),(4554,'Laguna'),(4555,'Lajeado Grande'),(4556,'Laurentino'),(4557,'Lauro Muller'),(4558,'Lebon Régis'),(4559,'Leoberto Leal'),(4560,'Lindóia do Sul'),(4561,'Lontras'),(4562,'Luiz Alves'),(4563,'Luzerna'),(4564,'Macieira'),(4565,'Mafra'),(4566,'Major Gercino'),(4567,'Major Vieira'),(4568,'Maracajá'),(4569,'Maravilha'),(4570,'Marema'),(4571,'Massaranduba'),(4572,'Matos Costa'),(4573,'Meleiro'),(4574,'Mirim Doce'),(4575,'Modelo'),(4576,'Mondaí'),(4577,'Monte Carlo'),(4578,'Monte Castelo'),(4579,'Morro da Fumaça'),(4580,'Morro Grande'),(4581,'Navegantes'),(4582,'Nova Erechim'),(4583,'Nova Itaberaba'),(4584,'Nova Trento'),(4585,'Nova Veneza'),(4586,'Novo Horizonte'),(4587,'Orleans'),(4588,'Otacílio Costa'),(4589,'Ouro'),(4590,'Ouro Verde'),(4591,'Paial'),(4592,'Painel'),(4593,'Palhoça'),(4594,'Palma Sola'),(4595,'Palmeira'),(4596,'Palmitos'),(4597,'Papanduva'),(4598,'Paraíso'),(4599,'Passo de Torres'),(4600,'Passos Maia'),(4601,'Paulo Lopes'),(4602,'Pedras Grandes'),(4603,'Penha'),(4604,'Peritiba'),(4605,'Petrolândia'),(4606,'Piçarras'),(4607,'Pinhalzinho'),(4608,'Pinheiro Preto'),(4609,'Piratuba'),(4610,'Planalto Alegre'),(4611,'Pomerode'),(4612,'Ponte Alta'),(4613,'Ponte Alta do Norte'),(4614,'Ponte Serrada'),(4615,'Porto Belo'),(4616,'Porto União'),(4617,'Pouso Redondo'),(4618,'Praia Grande'),(4619,'Presidente Castelo Branco'),(4620,'Presidente Getúlio'),(4621,'Presidente Nereu'),(4622,'Princesa'),(4623,'Quilombo'),(4624,'Rancho Queimado'),(4625,'Rio das Antas'),(4626,'Rio do Campo'),(4627,'Rio do Oeste'),(4628,'Rio do Sul'),(4629,'Rio dos Cedros'),(4630,'Rio Fortuna'),(4631,'Rio Negrinho'),(4632,'Rio Rufino'),(4633,'Riqueza'),(4634,'Rodeio'),(4635,'Romelândia'),(4636,'Salete'),(4637,'Saltinho'),(4638,'Salto Veloso'),(4639,'Sangão'),(4640,'Santa Cecília'),(4641,'Santa Helena'),(4642,'Santa Rosa de Lima'),(4643,'Santa Rosa do Sul'),(4644,'Santa Terezinha'),(4645,'Santa Terezinha do Progresso'),(4646,'Santiago do Sul'),(4647,'Santo Amaro da Imperatriz'),(4648,'São Bento do Sul'),(4649,'São Bernardino'),(4650,'São Bonifácio'),(4651,'São Carlos'),(4652,'São Cristovão do Sul'),(4653,'São Domingos'),(4654,'São Francisco do Sul'),(4655,'São João Batista'),(4656,'São João do Itaperiú'),(4657,'São João do Oeste'),(4658,'São João do Sul'),(4659,'São Joaquim'),(4660,'São José'),(4661,'São José do Cedro'),(4662,'São José do Cerrito'),(4663,'São Lourenço do Oeste'),(4664,'São Ludgero'),(4665,'São Martinho'),(4666,'São Miguel da Boa Vista'),(4667,'São Miguel do Oeste'),(4668,'São Pedro de Alcântara'),(4669,'Saudades'),(4670,'Schroeder'),(4671,'Seara'),(4672,'Serra Alta'),(4673,'Siderópolis'),(4674,'Sombrio'),(4675,'Sul Brasil'),(4676,'Taió'),(4677,'Tangará'),(4678,'Tigrinhos'),(4679,'Tijucas'),(4680,'Timbé do Sul'),(4681,'Timbó'),(4682,'Timbó Grande'),(4683,'Três Barras'),(4684,'Treviso'),(4685,'Treze de Maio'),(4686,'Treze Tílias'),(4687,'Trombudo Central'),(4688,'Tubarão'),(4689,'Tunápolis'),(4690,'Turvo'),(4691,'União do Oeste'),(4692,'Urubici'),(4693,'Urupema'),(4694,'Urussanga'),(4695,'Vargeão'),(4696,'Vargem'),(4697,'Vargem Bonita'),(4698,'Vidal Ramos'),(4699,'Videira'),(4700,'Vitor Meireles'),(4701,'Witmarsum'),(4702,'Xanxerê'),(4703,'Xavantina'),(4704,'Xaxim'),(4705,'Zortéa');
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
  `justificativa_contrato` varchar(300) NOT NULL,
  `periodo_inicial_contrato` varchar(10) NOT NULL,
  `periodo_final_contrato` varchar(10) NOT NULL,
  `salario_contrato` float NOT NULL,
  `data_contrato` varchar(10) NOT NULL,
  `ano_seletivo_contrato` int(4) NOT NULL,
  `obs_contrato` varchar(250) DEFAULT NULL,
  `jornada_trabalho_contrato` int(3) NOT NULL,
  `codigo_pessoa` int(11) NOT NULL,
  `codigo_cargo` int(11) NOT NULL,
  `testemunha_1_contrato` varchar(100) NOT NULL,
  `cpf_teste_1_contrato` varchar(16) NOT NULL,
  `testemunha_2_contrato` varchar(100) NOT NULL,
  `cpf_teste_2_contrato` varchar(16) NOT NULL,
  `tipo_contratacao_contrato` varchar(20) NOT NULL,
  PRIMARY KEY (`codigo_contrato`),
  KEY `fk_tb_contratos_tb_pessoas1_idx` (`codigo_pessoa`),
  KEY `fk_tb_contratos_tb_cargos1_idx` (`codigo_cargo`),
  CONSTRAINT `fk_tb_contratos_tb_cargos1` FOREIGN KEY (`codigo_cargo`) REFERENCES `tb_cargos` (`codigo_cargo`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_tb_contratos_tb_pessoas1` FOREIGN KEY (`codigo_pessoa`) REFERENCES `tb_pessoas` (`codigo_pessoa`) ON DELETE RESTRICT ON UPDATE RESTRICT
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
  matutino boolean,
  vespertino boolean,
  noturno boolean,
  PRIMARY KEY (`codigo_local_trabalho`,`codigo_contrato`),
  
  KEY `fk_tb_contratos_local_trabalho_tb_contratos1_idx` (`codigo_contrato`),
  KEY `fk_tb_contratos_local_trabalho_tb_local_trabalho1_idx` (`codigo_local_trabalho`),
  
	CONSTRAINT `fk_tb_contratos_local_trabalho_tb_contratos1` FOREIGN KEY (`codigo_contrato`) REFERENCES `tb_contratos` (`codigo_contrato`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_tb_contratos_local_trabalho_tb_local_trabalho1` FOREIGN KEY (`codigo_local_trabalho`) REFERENCES `tb_local_trabalho` (`codigo_local_trabalho`) ON DELETE RESTRICT ON UPDATE RESTRICT
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
  `horario_matutino_trabalho` varchar(15) DEFAULT NULL,
  `horario_vespertino_trabalho` varchar(15) DEFAULT NULL,
  `horario_noturno_trabalho` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`codigo_local_trabalho`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_local_trabalho`
--

LOCK TABLES `tb_local_trabalho` WRITE;
/*!40000 ALTER TABLE `tb_local_trabalho` DISABLE KEYS */;
INSERT INTO `tb_local_trabalho` VALUES (3,'Emir Ropelato','Diretora Emir','(47)1111-1111','07:30 - 11:30','13:30 - 17:30',' - '),(4,'Ruy Barbosa','Diretor Ruy','(47)2222-2222','07:30 - 11:30','13:30 - 17:30','18:45 - 22:20'),(5,'CEDUP Timbó','Diretora CEDUP','(47)3333-3333',' - ',' - ','18:45 - 22:20');
/*!40000 ALTER TABLE `tb_local_trabalho` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_mural`
--

DROP TABLE IF EXISTS `tb_mural`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_mural` (
  `codigo_mural` int(11) NOT NULL AUTO_INCREMENT,
  `usuario_mural` varchar(45) NOT NULL,
  `data_mural` varchar(20) NOT NULL,
  `conteudo_mural` varchar(200) NOT NULL,
  PRIMARY KEY (`codigo_mural`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_mural`
--

LOCK TABLES `tb_mural` WRITE;
/*!40000 ALTER TABLE `tb_mural` DISABLE KEYS */;
INSERT INTO `tb_mural` VALUES (1,'Roberto Luiz Debarba','21/2/2014 00:42:09','Recado de Teste'),(2,'Roberto Luiz Debarba','21/2/2014 00:42:23','teste 2'),(3,'Roberto','24/2/2014 13:50:05','teste 3'),(4,'roberto','24/2/2014 13:53:30','teste 4'),(5,'Roberto','24/2/2014 13:54:00','teste 5');
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
  `nascimento_pessoa` varchar(10) NOT NULL,
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
  `cep_pessoa` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`codigo_pessoa`),
  KEY `fk_tb_pessoas_tb_cidades_idx` (`codigo_cidade`),
  CONSTRAINT `fk_tb_pessoas_tb_cidades` FOREIGN KEY (`codigo_cidade`) REFERENCES `tb_cidades` (`codigo_cidade`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_pessoas`
--

LOCK TABLES `tb_pessoas` WRITE;
/*!40000 ALTER TABLE `tb_pessoas` DISABLE KEYS */;
INSERT INTO `tb_pessoas` VALUES (3,'Roberto Luiz Debarba','000.000.000-00','123.123.132-12','24/03/1995','Brasileiro','Solteiro(a)','Nações','Rua Egito, 574','roberto.debarba@gmail.com','(47)3382-1947','(47)9948-4130','Ruy Barbosa',2012,'Informática','CEDUP Timbó',2014,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,4681,'89120-000'),(4,'Jonathan Eli Suptittz','111.111.111-11','123.123.123-12','12/12/1000','Brasileiro','Solteiro(a)','Centro','Rua Tal, 111','jonny.suptitz@gmail.com','(47)3333-3333','(99)9999-9999','Ruy Barbosa',2009,'informática','CEDUP Timbó',2014,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,4681,'89120-000');
/*!40000 ALTER TABLE `tb_pessoas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_usuarios`
--

DROP TABLE IF EXISTS `tb_usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_usuarios` (
  `codigo_usuario` int(11) NOT NULL AUTO_INCREMENT,
  `login_usuario` varchar(20) NOT NULL,
  `senha_usuario` varchar(20) NOT NULL,
  `nome_usuario` varchar(45) NOT NULL,
  `nivel_acesso_usuario` int(1) NOT NULL,
  PRIMARY KEY (`codigo_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_usuarios`
--

LOCK TABLES `tb_usuarios` WRITE;
/*!40000 ALTER TABLE `tb_usuarios` DISABLE KEYS */;
INSERT INTO `tb_usuarios` VALUES (1,'roberto.debarba','luiz5505','Roberto Luiz Debarba',1),(2,'1','1','Beta Tester',1);
/*!40000 ALTER TABLE `tb_usuarios` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-03-07 13:04:08
