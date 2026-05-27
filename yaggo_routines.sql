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
-- Temporary view structure for view `v_carrinho_resumo`
--

DROP TABLE IF EXISTS `v_carrinho_resumo`;
/*!50001 DROP VIEW IF EXISTS `v_carrinho_resumo`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_carrinho_resumo` AS SELECT 
 1 AS `usuario_id`,
 1 AS `qtd_itens`,
 1 AS `total_unidades`,
 1 AS `subtotal`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_pedidos_completos`
--

DROP TABLE IF EXISTS `v_pedidos_completos`;
/*!50001 DROP VIEW IF EXISTS `v_pedidos_completos`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_pedidos_completos` AS SELECT 
 1 AS `id`,
 1 AS `codigo`,
 1 AS `usuario_id`,
 1 AS `nome_cliente`,
 1 AS `telefone`,
 1 AS `endereco`,
 1 AS `complemento`,
 1 AS `pagamento`,
 1 AS `subtotal`,
 1 AS `taxa_entrega`,
 1 AS `total`,
 1 AS `status`,
 1 AS `criado_em`,
 1 AS `atualizado_em`,
 1 AS `qtd_itens`,
 1 AS `total_unidades`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `v_carrinho_resumo`
--

/*!50001 DROP VIEW IF EXISTS `v_carrinho_resumo`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_carrinho_resumo` AS select `c`.`usuario_id` AS `usuario_id`,count(0) AS `qtd_itens`,sum(`c`.`quantidade`) AS `total_unidades`,sum((`p`.`preco` * `c`.`quantidade`)) AS `subtotal` from (`carrinho` `c` join `produtos` `p` on((`p`.`id` = `c`.`produto_id`))) group by `c`.`usuario_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_pedidos_completos`
--

/*!50001 DROP VIEW IF EXISTS `v_pedidos_completos`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_pedidos_completos` AS select `ped`.`id` AS `id`,`ped`.`codigo` AS `codigo`,`ped`.`usuario_id` AS `usuario_id`,`ped`.`nome_cliente` AS `nome_cliente`,`ped`.`telefone` AS `telefone`,`ped`.`endereco` AS `endereco`,`ped`.`complemento` AS `complemento`,`ped`.`pagamento` AS `pagamento`,`ped`.`subtotal` AS `subtotal`,`ped`.`taxa_entrega` AS `taxa_entrega`,`ped`.`total` AS `total`,`ped`.`status` AS `status`,`ped`.`criado_em` AS `criado_em`,`ped`.`atualizado_em` AS `atualizado_em`,count(`ip`.`id`) AS `qtd_itens`,sum(`ip`.`quantidade`) AS `total_unidades` from (`pedidos` `ped` left join `itens_pedido` `ip` on((`ip`.`pedido_id` = `ped`.`id`))) group by `ped`.`id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-05-26 21:21:02
