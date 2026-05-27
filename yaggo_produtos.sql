CREATE DATABASE  IF NOT EXISTS `yaggo` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `yaggo`;
-- MySQL dump 10.13  Distrib 8.0.43, for macos15 (arm64)
--
-- Host: 127.0.0.1    Database: yaggo
-- ------------------------------------------------------
-- Server version	8.0.41

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `produtos`
--

DROP TABLE IF EXISTS `produtos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `produtos` (
  `id` varchar(10) NOT NULL,
  `categoria_id` varchar(20) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `descricao` varchar(300) NOT NULL,
  `preco` decimal(8,2) NOT NULL,
  `imagem` varchar(100) NOT NULL,
  `emoji` varchar(10) NOT NULL DEFAULT 0xF09F8D94,
  `popular` tinyint(1) NOT NULL DEFAULT '0',
  `ativo` tinyint(1) NOT NULL DEFAULT '1',
  `criado_em` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `atualizado_em` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_produto_categoria` (`categoria_id`),
  CONSTRAINT `fk_produto_categoria` FOREIGN KEY (`categoria_id`) REFERENCES `categorias` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produtos`
--

LOCK TABLES `produtos` WRITE;
/*!40000 ALTER TABLE `produtos` DISABLE KEYS */;
INSERT INTO `produtos` VALUES ('p1','burgers','Smash Clássico','Blend 180g, queijo cheddar, alface, tomate e molho especial da casa.',28.90,'smash_classico.png','?',1,1,'2026-05-26 23:47:12','2026-05-26 23:47:12'),('p10','drinks','Refrigerante Lata','Lata 350ml — Coca-Cola, Guaraná ou Sprite.',8.90,'refrigerante_lata.png','?',0,1,'2026-05-26 23:47:12','2026-05-26 23:47:12'),('p11','desserts','Brownie Quente','Brownie de chocolate belga com sorvete de creme e calda.',16.90,'brownie_quente.png','?',1,1,'2026-05-26 23:47:12','2026-05-26 23:47:12'),('p12','desserts','Sorvete Artesanal','2 bolas — chocolate, morango ou creme.',14.90,'sorvete_artesanal.png','?',0,1,'2026-05-26 23:47:12','2026-05-26 23:47:12'),('p2','burgers','Double Smash','Dois blends 120g, bacon crocante, duplo cheddar e cebola crispy.',38.90,'double_smash.png','?',0,1,'2026-05-26 23:47:12','2026-05-26 23:47:12'),('p3','burgers','Urban Supremo','Blend 200g, queijo brie, geleia de pimenta, rúcula e maionese trufada.',45.90,'urban_supremo.png','?',1,1,'2026-05-26 23:47:12','2026-05-26 23:47:12'),('p4','burgers','Chicken Crispy','Frango empanado crocante, cheddar, picles e molho buffalo.',32.90,'chicken_crispy.png','?',0,1,'2026-05-26 23:47:12','2026-05-26 23:47:12'),('p5','combos','Combo Clássico','Smash Clássico + fritas M + refrigerante 350ml.',44.90,'combo_classico.png','?',1,1,'2026-05-26 23:47:12','2026-05-26 23:47:12'),('p6','combos','Combo Double','Double Smash + fritas G + refrigerante 350ml.',54.90,'combo_double.png','?',0,1,'2026-05-26 23:47:12','2026-05-26 23:47:12'),('p7','combos','Combo Supremo','Urban Supremo + fritas G + suco natural 300ml.',62.90,'combo_supremo.png','?',0,1,'2026-05-26 23:47:12','2026-05-26 23:47:12'),('p8','drinks','Milkshake Baunilha','Milkshake cremoso de baunilha com chantilly e calda.',18.90,'milkshake_baunilha.png','?',0,1,'2026-05-26 23:47:12','2026-05-26 23:47:12'),('p9','drinks','Suco de Laranja','Suco natural de laranja espremido na hora, 400ml.',12.90,'suco_laranja.png','?',0,1,'2026-05-26 23:47:12','2026-05-26 23:47:12');
/*!40000 ALTER TABLE `produtos` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-05-26 21:21:02
