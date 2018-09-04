-- MySQL dump 10.13  Distrib 5.5.57, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: pfcase
-- ------------------------------------------------------
-- Server version	5.5.57-0ubuntu0.14.04.1

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
-- Table structure for table `account`
--

DROP TABLE IF EXISTS `account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `account` (
  `userid` varchar(25) NOT NULL,
  `email` varchar(80) NOT NULL,
  `role` varchar(10) NOT NULL,
  PRIMARY KEY (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account`
--

LOCK TABLES `account` WRITE;
/*!40000 ALTER TABLE `account` DISABLE KEYS */;
INSERT INTO `account` VALUES ('admin','Your E-mail address','admin');
/*!40000 ALTER TABLE `account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `caselist`
--

DROP TABLE IF EXISTS `caselist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `caselist` (
  `caseid` int(11) NOT NULL AUTO_INCREMENT,
  `casename` varchar(50) NOT NULL COMMENT '用例名称',
  `belongmodulea` varchar(25) NOT NULL COMMENT '所属一级功能模块名',
  `belongmoduleb` varchar(25) NOT NULL COMMENT '所属二级功能模块名',
  `belongmodulec` varchar(25) NOT NULL COMMENT '所属三级功能模块名',
  `priority` tinyint(4) NOT NULL COMMENT '用例等级',
  `casestep` text NOT NULL COMMENT '用例步骤',
  `reviewed` tinyint(4) NOT NULL DEFAULT '0' COMMENT '已评审?',
  `automated` tinyint(4) NOT NULL DEFAULT '0' COMMENT '已自动化?',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT '已删除?',
  `creator` varchar(25) NOT NULL COMMENT '创建人',
  `modifier` varchar(25) NOT NULL COMMENT '修改人',
  `createtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updatetime` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  PRIMARY KEY (`caseid`),
  KEY `idx_belongmodule` (`belongmodulea`,`belongmoduleb`,`belongmodulec`),
  KEY `idx_priority` (`priority`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='用例表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `caselist`
--

LOCK TABLES `caselist` WRITE;
/*!40000 ALTER TABLE `caselist` DISABLE KEYS */;
INSERT INTO `caselist` VALUES (1,'1','2','3','4',5,'6',1,1,1,'1','2','2018-01-11 23:16:27','2018-01-11 23:16:27'),(2,'1','2','3','4',5,'6',1,1,1,'1','2','2018-01-11 23:16:51','2018-01-11 23:16:51');
/*!40000 ALTER TABLE `caselist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dapps`
--

DROP TABLE IF EXISTS `dapps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dapps` (
  `dappid` int(11) NOT NULL AUTO_INCREMENT,
  `dappname` varchar(80) NOT NULL COMMENT 'dapp名称',
  `dapplink` varchar(200) NOT NULL COMMENT 'dapp链接',
  `dappicon` varchar(200) NOT NULL COMMENT 'dapp图像链接',
  `enabled` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否有效',
  `seq` tinyint(4) NOT NULL DEFAULT '0' COMMENT '序列',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT '已删除?',
  `createtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updatetime` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  PRIMARY KEY (`dappid`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='dapp列表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dapps`
--

LOCK TABLES `dapps` WRITE;
/*!40000 ALTER TABLE `dapps` DISABLE KEYS */;
INSERT INTO `dapps` VALUES (1,'创世神犬','http://h5.ibeechat.com/webview/crypto-dog','http://beechat-web-cn.oss-cn-qingdao.aliyuncs.com/static/res/images/pets_dog/pet_dog_0.png',0,1,0,'2018-01-13 05:51:17','2018-01-13 05:51:17'),(2,'幸运转盘','http://h5.ibeechat.com/webview/lottery','http://beechat-web-cn.oss-cn-qingdao.aliyuncs.com/static/res/images/dapp/ic_02lottery_dapps3x.png ',0,1,0,'2018-01-13 05:51:17','2018-01-13 05:51:17'),(3,'限时领Bee','http://h5.ibeechat.com/webview/spread','http://beechat-web-cn.oss-cn-qingdao.aliyuncs.com/static/res/images/dapp/ic_01beepoints_dapps_3x.png',0,1,0,'2018-01-13 05:51:17','2018-01-13 05:51:17'),(4,'英雄社区','http://bitbird.org/webview_beechat/native_hero_community','http://beechat-web-cn.oss-cn-qingdao.aliyuncs.com/static/res/images/dapp/ic_04hero_dapps_3x.png',0,1,0,'2018-01-13 05:51:17','2018-01-13 05:51:17'),(5,'区块链指数','http://bitbird.org/webview_beechat/blockchainindexes','http://beechat-web-cn.oss-cn-qingdao.aliyuncs.com/static/res/images/dapp/ic_03index_dapps3x.png',0,1,0,'2018-01-13 05:51:17','2018-01-13 05:51:17'),(6,'短线助手','http://bitbird.org/webview_beechat/assistant','http://beechat-web-cn.oss-cn-qingdao.aliyuncs.com/static/res/images/dapp/ic_06assistant_dapps3x.png',0,1,0,'2018-01-13 05:51:17','2018-01-13 05:51:17'),(7,'智能配仓','http://bitbird.org/webview_beechat/smartplan','http://beechat-web-cn.oss-cn-qingdao.aliyuncs.com/static/res/images/dapp/ic_04combination_dapps3x.png',0,1,0,'2018-01-13 05:51:17','2018-01-13 05:51:17'),(8,'加仓点','http://bitbird.org/webview_beechat/buyprice','http://beechat-web-cn.oss-cn-qingdao.aliyuncs.com/static/res/images/dapp/ic_05warehouse_dapps3x.png',0,1,0,'2018-01-13 05:51:17','2018-01-13 05:51:17');
/*!40000 ALTER TABLE `dapps` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `groups`
--

DROP TABLE IF EXISTS `groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `groups` (
  `groupid` int(11) NOT NULL AUTO_INCREMENT,
  `groupname` varchar(80) NOT NULL COMMENT '群组名称',
  `grouplink` varchar(200) NOT NULL COMMENT '群组链接',
  `groupicon` varchar(200) NOT NULL COMMENT '群组图像链接',
  `enabled` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否有效',
  `seq` tinyint(4) NOT NULL DEFAULT '0' COMMENT '序列',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT '已删陿?',
  `createtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updatetime` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  PRIMARY KEY (`groupid`)
) ENGINE=InnoDB AUTO_INCREMENT=151 DEFAULT CHARSET=utf8 COMMENT='群列衿';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `groups`
--

LOCK TABLES `groups` WRITE;
/*!40000 ALTER TABLE `groups` DISABLE KEYS */;
INSERT INTO `groups` VALUES (1,'Ripple XRP','https://t.me/Ripple','01-Ripple XRP.jpg',1,1,0,'2018-01-13 06:24:54','2018-01-13 06:24:54'),(2,'Binance English','https://t.me/binanceexchange','02-Binance-English.jpg',1,1,0,'2018-01-13 06:24:54','2018-01-13 06:24:54'),(3,'Litecoin LTC','https://t.me/Litecoin','03-Litecoin-LTC.jpg',1,1,0,'2018-01-13 06:24:54','2018-01-13 06:24:54'),(4,'Quantstamp','https://t.me/quantstamp','04-Quantstamp.jpg',1,1,0,'2018-01-13 06:24:54','2018-01-13 06:24:54'),(5,'Electroneum','https://t.me/electroneum','05-Electroneum.jpg',1,1,0,'2018-01-13 06:24:54','2018-01-13 06:24:54'),(6,'币安官方中文群','https://t.me/BinanceChinese','06-Official-Chinese-group-of-coins.jpg',1,1,0,'2018-01-13 06:24:54','2018-01-13 06:24:54'),(7,'DigiByte Official','https://t.me/DigiByteCoin','07-DigiByte-Official.jpg',1,1,0,'2018-01-13 06:24:54','2018-01-13 06:24:54'),(8,'CYBERMILES VIET NAM','https://t.me/cybermilesvn','08-CYBERMILES-VIET-NAM.jpg',1,1,0,'2018-01-13 06:24:54','2018-01-13 06:24:54'),(9,'Wavesnews and Announcements','https://t.me/wavesnews','09-Wavesnews-and-Announcements.jpg',1,1,0,'2018-01-13 06:24:54','2018-01-13 06:24:54'),(10,'CyberMiles','https://t.me/cybermilestoken ','10-CyberMiles.jpg',1,1,0,'2018-01-13 06:24:54','2018-01-13 06:24:54'),(11,'Omise GO (Unofficial))','https://t.me/OmiseGo','11-Omise-GO-(Unofficial).jpg',1,1,0,'2018-01-13 06:24:54','2018-01-13 06:24:54'),(12,'RaiBlocks Community','https://t.me/raiblockscommunity','12-RaiBlocks-Community.jpg',1,1,0,'2018-01-13 06:24:54','2018-01-13 06:24:54'),(13,'RaiBlocks (English chat)','https://t.me/raiblocks','13-RaiBlocks-(English-chat).jpg',1,1,0,'2018-01-13 06:24:54','2018-01-13 06:24:54'),(14,'QTUM','https://t.me/qtumofficial','14-QTUM.jpg',1,1,0,'2018-01-13 06:24:54','2018-01-13 06:24:54'),(15,'Civic Network Supporters','https://t.me/civicplatform','15-Civic-Network-Supporters.jpg',1,1,0,'2018-01-13 06:24:54','2018-01-13 06:24:54'),(16,'Quantstamp announcements','https://t.me/quantstampANN','16-Quantstamp-announcements.jpg',1,1,0,'2018-01-13 06:24:54','2018-01-13 06:24:54'),(17,'Bitshares DEX','://t.me/BitSharesDEX','17-Bitshares-DEX.jpg',1,1,0,'2018-01-13 06:24:54','2018-01-13 06:24:54'),(18,'VeChain Official English','https://t.me/vechain_official_english','18-VeChain-Official-English.jpg',1,1,0,'2018-01-13 06:24:54','2018-01-13 06:24:54'),(19,'EOS中文','https://t.me/EOSCN','19-EOS-Chinese.jpg',1,1,0,'2018-01-13 06:24:54','2018-01-13 06:24:54'),(20,'@Gold_Diamond93','https://t.me/Gold_Diamond93','20-@Gold_Diamond93.jpg',1,1,0,'2018-01-13 06:24:54','2018-01-13 06:24:54'),(21,'Kcash-CN','https://t.me/KcashOfficial','21-Kcash-CN.jpg',1,1,0,'2018-01-13 06:24:54','2018-01-13 06:24:54'),(22,'Enjin Coin (ENJ)','https://t.me/enjin_coin','22-Enjin-Coin-(ENJ).jpg',1,1,0,'2018-01-13 06:24:54','2018-01-13 06:24:54'),(23,'Cardano Community Trollbox - A','https://t.me/cardano','23-Cardano-Community-Trollbox-A.jpg',1,1,0,'2018-01-13 06:24:54','2018-01-13 06:24:54'),(24,'Monero XMR','https://t.me/monero','24-Monero-XMR.jpg',1,1,0,'2018-01-13 06:24:54','2018-01-13 06:24:54'),(25,'Monaco Card','https://t.me/MonacoCard','25-Monaco-Card.jpg',1,1,0,'2018-01-13 06:24:54','2018-01-13 06:24:54'),(26,'COBINHOOD','https://t.me/cobinhood','26-COBINHOOD.jpg',1,1,0,'2018-01-13 06:24:54','2018-01-13 06:24:54'),(27,'REGALCOIN OFFICIAL','https://t.me/regalcoinofficial','27-REGALCOIN-OFFICIAL.jpg',1,1,0,'2018-01-13 06:24:54','2018-01-13 06:24:54'),(28,'Skycoin - Building the new internet','https://t.me/Skycoin','28-Skycoin-Building-the-new-internet.jpg',1,1,0,'2018-01-13 06:24:54','2018-01-13 06:24:54'),(29,'Substratum Community','https://t.me/SubstratumCommunity','29-Substratum-Community.jpg',1,1,0,'2018-01-13 06:24:54','2018-01-13 06:24:54'),(30,'Siacoin SC','https://t.me/SiaCoin','30-Siacoin-SC.jpg',1,1,0,'2018-01-13 06:24:54','2018-01-13 06:24:54'),(31,'Bitcore_BTX','https://t.me/bitcore_btx_official','31-Bitcore_BTX.jpg',1,1,0,'2018-01-13 06:24:54','2018-01-13 06:24:54'),(32,'WAVE ART','https://t.me/waves_arts','32-WAVE-ART.jpg',1,1,0,'2018-01-13 06:24:54','2018-01-13 06:24:54'),(33,'SONM','https://t.me/sonm_eng','33-SONM.jpg',1,1,0,'2018-01-13 06:24:54','2018-01-13 06:24:54'),(34,'Cardano (ADA) Maingroup','https://t.me/CardanoMaingroup','34-Cardano-(ADA)-Maingroup',1,1,0,'2018-01-13 06:24:54','2018-01-13 06:24:54'),(35,'Huobi.pro-Official','https://t.me/huobiproofficial','35-Huobi.pro-Official.jpg',1,1,0,'2018-01-13 06:24:54','2018-01-13 06:24:54'),(36,'Cryptonex (CNX)','https://t.me/cryptonexCNX','36-Cryptonex-(CNX).jpg',1,1,0,'2018-01-13 06:24:54','2018-01-13 06:24:54'),(37,'Sυpєrทєτ 4G','https://t.me/Supernet4G','37-Sυpєrทєτ-4G.jpg',1,1,0,'2018-01-13 06:24:54','2018-01-13 06:24:54'),(38,'Achain','https://t.me/AchainOfficial','38-Achain.jpg',1,1,0,'2018-01-13 06:24:54','2018-01-13 06:24:54'),(39,'æternity','https://t.me/aeternity','39-æternity.jpg',1,1,0,'2018-01-13 06:24:54','2018-01-13 06:24:54'),(40,'CyberMiles繁体中文群','https://t.me/CyberMiles','40-CyberMiles-Traditional-Chinese-group.jpg',1,1,0,'2018-01-13 06:24:54','2018-01-13 06:24:54'),(41,'AdEx Network','https://t.me/adexnetwork','41-AdEx-Network.jpg',1,1,0,'2018-01-13 06:24:54','2018-01-13 06:24:54'),(42,'YobitPumpGroup','https://t.me/Yobit_Pump_Group','42-YobitPumpGroup.jpg',1,1,0,'2018-01-13 06:24:54','2018-01-13 06:24:54'),(43,'Reddcoin','https://t.me/ReddcoinOfficial','43-Reddcoin.jpg',1,1,0,'2018-01-13 06:24:54','2018-01-13 06:24:54'),(44,'Stratis Platform','https://t.me/StratisPlatform','44-Stratis-Platform.jpg',1,1,0,'2018-01-13 06:24:54','2018-01-13 06:24:54'),(45,'PayPie','https://t.me/PayPieTokens','45-PayPie.jpg',1,1,0,'2018-01-13 06:24:54','2018-01-13 06:24:54'),(46,'WINGS Chat','https://t.me/wingschat','46-WINGS-Chat.jpg',1,1,0,'2018-01-13 06:24:54','2018-01-13 06:24:54'),(47,'Presearch Community','https://t.me/presearch','47-Presearch-Community.jpg',1,1,0,'2018-01-13 06:24:54','2018-01-13 06:24:54'),(48,'Funfair FUN','https://t.me/FunFairTech','48-Funfair-FUN.jpg',1,1,0,'2018-01-13 06:24:54','2018-01-13 06:24:54'),(49,'NAV Coin','https://t.me/navcoin','49-NAV-Coin.jpg',1,1,0,'2018-01-13 06:24:54','2018-01-13 06:24:54'),(50,'Ethereum Centurion','https://t.me/Ethereum_Centurion','50-Ethereum-Centurion.jpg',1,1,0,'2018-01-13 06:24:54','2018-01-13 06:24:54'),(51,'Zcoin (XZC)','https://t.me/zcoinproject','51-Zcoin-(XZC).jpg',1,1,0,'2018-01-13 06:24:54','2018-01-13 06:24:54'),(52,'district0x','https://t.me/district0x','52-district0x.jpg',1,1,0,'2018-01-13 06:24:54','2018-01-13 06:24:54'),(53,'AirSwap Community','https://t.me/airswap','53-AirSwap-Community.jpg',1,1,0,'2018-01-13 06:24:54','2018-01-13 06:24:54'),(54,'Chainlink Community','https://t.me/chainlink','54-Chainlink-Community.jpg',1,1,0,'2018-01-13 06:24:54','2018-01-13 06:24:54'),(55,'ZEN','https://t.me/zencash','55-ZEN.jpg',1,1,0,'2018-01-13 06:24:54','2018-01-13 06:24:54'),(56,'Bitcoin Trading Signals','https://t.me/bitcoinsignals','56-Bitcoin-Trading-Signals.jpg',1,1,0,'2018-01-13 06:24:54','2018-01-13 06:24:54'),(57,'@Move to t.me/ethos_io','https://t.me/Bitquence','57-@Move-to-t.me-ethos_io.jpg',1,1,0,'2018-01-13 06:24:54','2018-01-13 06:24:54'),(58,'Substratum Link Portal','https://t.me/substratum','58-Substratum-Link-Portal.jpg',1,1,0,'2018-01-13 06:24:54','2018-01-13 06:24:54'),(59,'Monero Gold - XRG','https://t.me/monerogold_xrg','59-Monero-Gold-XRG.jpg',1,1,0,'2018-01-13 06:24:54','2018-01-13 06:24:54'),(60,'Viacoin','https://t.me/viacoin','60-Viacoin.jpg',1,1,0,'2018-01-13 06:24:54','2018-01-13 06:24:54'),(61,'Yobit pump group','https://t.me/yobits','61-Yobit-pump-group.jpg',1,1,0,'2018-01-13 06:24:54','2018-01-13 06:24:54'),(62,'SmartMesh Official','https://t.me/SmartMesh','62-SmartMesh-Official.jpg',1,1,0,'2018-01-13 06:24:54','2018-01-13 06:24:54'),(63,'Electroneum Cash','https://t.me/electroneumcash','63-Electroneum-Cash.jpg',1,1,0,'2018-01-13 06:24:54','2018-01-13 06:24:54'),(64,'Nuls Community','https://t.me/Nulsio','64-Nuls-Community.jpg',1,1,0,'2018-01-13 06:24:54','2018-01-13 06:24:54'),(65,'PayPie Announcements Channel','https://t.me/PayPie','65-PayPie-Announcements-Channel.jpg',1,1,0,'2018-01-13 06:24:54','2018-01-13 06:24:54'),(66,'Groestlcoin GRS','https://t.me/groestl','66-Groestlcoin-GRS.jpg',1,1,0,'2018-01-13 06:24:54','2018-01-13 06:24:54'),(67,'Komodo Platform Official','https://t.me/KomodoPlatform_Official','67-Komodo-Platform-Official.jpg',1,1,0,'2018-01-13 06:24:54','2018-01-13 06:24:54'),(68,'Coindash#Public','https://t.me/coindash','68-Coindash#Public.jpg',1,1,0,'2018-01-13 06:24:54','2018-01-13 06:24:54'),(69,'Peercoin >< Peercoin.chat','https://t.me/peercoin','69-Peercoin-Peercoin.chat.jpg',1,1,0,'2018-01-13 06:24:54','2018-01-13 06:24:54'),(70,'Steemit.com','https://t.me/steemitdotcom','70-Steemit.com.jpg',1,1,0,'2018-01-13 06:24:54','2018-01-13 06:24:54'),(71,'Vertcoin','https://t.me/VertcoinCrypto','71-Vertcoin.jpg',1,1,0,'2018-01-13 06:24:54','2018-01-13 06:24:54'),(72,'PotCoin','https://t.me/potcoin420','72-PotCoin.jpg',1,1,0,'2018-01-13 06:24:54','2018-01-13 06:24:54'),(73,'Loopring','https://t.me/loopringfans','73-Loopring.jpg',1,1,0,'2018-01-13 06:24:54','2018-01-13 06:24:54'),(74,'RaiBlocksID','https://t.me/raiblocksid','74-RaiBlocksID.jpg',1,1,0,'2018-01-13 06:24:54','2018-01-13 06:24:54'),(75,'流量矿石交流群','https://t.me/lltoken','75-Flow-ore-AC-group.jpg',1,1,0,'2018-01-13 06:24:54','2018-01-13 06:24:54'),(76,'比原链官方群','https://t.me/bytomchinese','76-Original-chain-official-group.jpg',1,1,0,'2018-01-13 06:24:54','2018-01-13 06:24:54'),(77,'BYTEBALL - telegram.me/byteball','https://t.me/byteball','77-BYTEBALL-telegram.me-byteball.jpg',1,1,0,'2018-01-13 06:24:54','2018-01-13 06:24:54'),(78,'Adex Trading (unofficial)','https://t.me/adex_trading','78-Adex-Trading-(unofficial).jpg',1,1,0,'2018-01-13 06:24:54','2018-01-13 06:24:54'),(79,'GameCredits','https://t.me/gamecreditsglobal','79-GameCredits.jpg',1,1,0,'2018-01-13 06:24:54','2018-01-13 06:24:54'),(80,'ICONOMI ICO','https://t.me/iconomi','80-ICONOMI-ICO.jpg',1,1,0,'2018-01-13 06:24:54','2018-01-13 06:24:54'),(81,'Bitcoin Indonesia『UNOFFICIAL』','https://t.me/Bitcoin_Indonesia','81-Bitcoin-Indonesia-UNOFFICIAL.jpg',1,1,0,'2018-01-13 06:24:54','2018-01-13 06:24:54'),(82,'VeChain 官方社区','https://t.me/vechain_officia_CN','82-VeChain-Official-Community.jpg',1,1,0,'2018-01-13 06:24:54','2018-01-13 06:24:54'),(83,'Metal Cult','https://t.me/metalcult','83-Metal-Cult.jpg',1,1,0,'2018-01-13 06:24:54','2018-01-13 06:24:54'),(84,'Чемпионат мира 2018','https://t.me/ticketsfootball','84-Чемпионат-мира-2018.jpg',1,1,0,'2018-01-13 06:24:54','2018-01-13 06:24:54'),(85,'Ethereum FundMe','https://t.me/EthereumFundMe','85-Ethereum-FundMe.jpg',1,1,0,'2018-01-13 06:24:54','2018-01-13 06:24:54'),(86,'// substratum ci //','https://t.me/substratumci','86-substratum-ci.jpg',1,1,0,'2018-01-13 06:24:54','2018-01-13 06:24:54'),(87,'Monacoin MONA','https://t.me/monacoin','87-Monacoin-MONA.jpg',1,1,0,'2018-01-13 06:24:54','2018-01-13 06:24:54'),(88,'Monacoin MONA','https://t.me/monacoin','88-Monacoin-MONA.jpg',1,1,0,'2018-01-13 06:24:54','2018-01-13 06:24:54'),(89,'※Upbit Pumping Room※','https://t.me/UpbitPumpingRoom','89-※Upbit-Pumping-Room※.jpg',1,1,0,'2018-01-13 06:24:54','2018-01-13 06:24:54'),(90,'Гороскоп БЛИЗНЕЦЫ','https://t.me/h_gemini','90-Гороскоп БЛИЗНЕЦЫ.jpg',1,1,0,'2018-01-13 06:24:54','2018-01-13 06:24:54'),(91,'Augur Project REP','https://t.me/AugurProject','91-Augur-Project-REP.jpg',1,1,0,'2018-01-13 06:24:54','2018-01-13 06:24:54'),(92,'æternity_cn','https://t.me/aeternity_cn','92-æternity_cn.jpg',1,1,0,'2018-01-13 06:24:54','2018-01-13 06:24:54'),(93,'Status Network Talk','https://t.me/StatusNetworkChat','93-Status-Network-Talk.jpg',1,1,0,'2018-01-13 06:24:54','2018-01-13 06:24:54'),(94,'Decred DCR','https://t.me/Decred','94-Decred-DCR.jpg',1,1,0,'2018-01-13 06:24:54','2018-01-13 06:24:54'),(95,'UPbit 코인 정보','https://t.me/UPbit','95-UPbit-코인-정보.jpg',1,1,0,'2018-01-13 06:24:54','2018-01-13 06:24:54'),(96,'Bitshares Traders Group','https://t.me/Bitshares_Traders','96-Bitshares-Traders-Group.jpg',1,1,0,'2018-01-13 06:24:54','2018-01-13 06:24:54'),(97,'Minexcoin','https://t.me/minexcoin','97-Minexcoin.jpg',1,1,0,'2018-01-13 06:24:54','2018-01-13 06:24:54'),(98,'Binance Coin','https://t.me/Binance','98-Binance-Coin.jpg',1,1,0,'2018-01-13 06:24:54','2018-01-13 06:24:54'),(99,'BitcoinStake','https://t.me/bitcoinstakecommunity','99-BitcoinStake.jpg',1,1,0,'2018-01-13 06:24:54','2018-01-13 06:24:54'),(100,'Cardano Announcement','https://t.me/CardanoAnnouncement','100-Cardano-Announcement.jpg',1,1,0,'2018-01-13 06:24:54','2018-01-13 06:24:54'),(101,'STORJ Russian Chat','https://t.me/storjRU','101-STORJ-Russian-Chat.jpg',1,1,0,'2018-01-13 06:24:54','2018-01-13 06:24:54'),(102,'Omise Go 中文讨论 (CN)','https://t.me/OmiseGoCN','102-Omise-Go-(CN).jpg',1,1,0,'2018-01-13 06:24:54','2018-01-13 06:24:54'),(103,'Counterparty XCP','https://t.me/Counterparty','103-Counterparty-XCP.jpg',1,1,0,'2018-01-13 06:24:54','2018-01-13 06:24:54'),(104,'The Verge','https://t.me/verge','104-The-Verge.jpg',1,1,0,'2018-01-13 06:24:54','2018-01-13 06:24:54'),(105,'Крипто сигналы','https://t.me/BittrexF','105-Крипто-сигналы.jpg',1,1,0,'2018-01-13 06:24:54','2018-01-13 06:24:54'),(106,'Gridcoin','https://t.me/gridcoin','106-Gridcoin.jpg',1,1,0,'2018-01-13 06:24:54','2018-01-13 06:24:54'),(107,'코인원 ETH 가격알림','https://t.me/coinone_eth','107-코인원-ETH-가격알림.jpg',1,1,0,'2018-01-13 06:24:54','2018-01-13 06:24:54'),(108,'Factom FCT','https://t.me/FactomFCT','108-Factom-FCT.jpg',1,1,0,'2018-01-13 06:24:54','2018-01-13 06:24:54'),(109,'MAIDSAFECOIN MAID','https://t.me/maidsafecoin','109-MAIDSAFECOIN-MAID.jpg',1,1,0,'2018-01-13 06:24:54','2018-01-13 06:24:54'),(110,'Cofound.it.','https://t.me/cofounditchat','110-Cofound.it.jpg',1,1,0,'2018-01-13 06:24:54','2018-01-13 06:24:54'),(111,'Electroneums - UNOFFICIAL','https://t.me/electroneums','111-Electroneums-UNOFFICIAL.jpg',1,1,0,'2018-01-13 06:24:54','2018-01-13 06:24:54'),(112,'Nuls中文社区','https://t.me/Nulscn','112-Nuls-Chinese-community.jpg',1,1,0,'2018-01-13 06:24:54','2018-01-13 06:24:54'),(113,'Bancor [RU]','https://t.me/Bancor_RU','113-Bancor-[RU].jpg',1,1,0,'2018-01-13 06:24:54','2018-01-13 06:24:54'),(114,'LiveCoinWatch.com Cryptocurrency Group','https://t.me/livecoinwatch','114-LiveCoinWatch.com-Cryptocurrency-Group.jpg',1,1,0,'2018-01-13 06:24:54','2018-01-13 06:24:54'),(115,'Delphy天算官方交流群','https://t.me/Delphyfans','115-Delphy-Official-communication-group.jpg',1,1,0,'2018-01-13 06:24:54','2018-01-13 06:24:54'),(116,'Ubiq','https://t.me/Ubiqsmart','116-Ubiq.jpg',1,1,0,'2018-01-13 06:24:54','2018-01-13 06:24:54'),(117,'Bytecoin','https://t.me/Bytecoin','117-Bytecoin.jpg',1,1,0,'2018-01-13 06:24:54','2018-01-13 06:24:54'),(118,'COINEGG官方中文群','https://t.me/coineggofficial','118-COINEGG-Official-Chinese-group.jpg',1,1,0,'2018-01-13 06:24:54','2018-01-13 06:24:54'),(119,'Pillar Project','https://t.me/pillarproject','119-Pillar-Project.jpg',1,1,0,'2018-01-13 06:24:54','2018-01-13 06:24:54'),(120,'Veritaseum','https://t.me/veritaseum','120-Veritaseum.jpg',1,1,0,'2018-01-13 06:24:54','2018-01-13 06:24:54'),(121,'Streamr DATA','https://t.me/streamrdata','121-Streamr-DATA.jpg',1,1,0,'2018-01-13 06:24:54','2018-01-13 06:24:54'),(122,'Populous','https://t.me/Populous','122-Populous.jpg',1,1,0,'2018-01-13 06:24:54','2018-01-13 06:24:54'),(123,'HitBTC Pumpers','https://t.me/HitBTCPumpers','123-HitBTC-Pumpers.jpg',1,1,0,'2018-01-13 06:24:54','2018-01-13 06:24:54'),(124,'COBINHOOD零手续费交易所','https://t.me/COBINHOOD_ZH','124-COBINHOOD-Zero-handling-exchange.jpg',1,1,0,'2018-01-13 06:24:54','2018-01-13 06:24:54'),(125,'BtcTrade.im中文官方群','https://t.me/btctradeofficial','125-BtcTrade.im-Chinese-official-group.jpg',1,1,0,'2018-01-13 06:24:54','2018-01-13 06:24:54'),(126,'Dragonex用户交流群','https://t.me/Dragonex_io','126-Dragonex-User-exchange-group.jpg',1,1,0,'2018-01-13 06:24:54','2018-01-13 06:24:54'),(127,'district0x Network','https://t.me/district0xNetwork','127-district0x-Network.jpg',1,1,0,'2018-01-13 06:24:54','2018-01-13 06:24:54'),(128,'OTN - Open Trading Network','https://t.me/opentn','128-OTN-Open-Trading-Network.jpg',1,1,0,'2018-01-13 06:24:55','2018-01-13 06:24:55'),(129,'MediShares Info Channel','https://t.me/medishares','129-MediShares-Info-Channel.jpg',1,1,0,'2018-01-13 06:24:55','2018-01-13 06:24:55'),(130,'ReddCoinRU (RDD)','https://t.me/ReddCoinRU','130-ReddCoinRU-(RDD).jpg',1,1,0,'2018-01-13 06:24:55','2018-01-13 06:24:55'),(131,'FirstBlood Official Telegram','https://t.me/firstbloodio','131-FirstBlood-Official-Telegram.jpg',1,1,0,'2018-01-13 06:24:55','2018-01-13 06:24:55'),(132,'Skycoin Bounty Program','https://t.me/skycoinbounty','132-Skycoin-Bounty-Program.jpg',1,1,0,'2018-01-13 06:24:55','2018-01-13 06:24:55'),(133,'æternity [RU]','https://t.me/aeternityRU','133-æternity-[RU].jpg',1,1,0,'2018-01-13 06:24:55','2018-01-13 06:24:55'),(134,'Melonport','https://t.me/melonport','134-Melonport.jpg',1,1,0,'2018-01-13 06:24:55','2018-01-13 06:24:55'),(135,'流量矿石官方交流群','https://t.me/lltoken_com','135-Official-exchange-group-of-flow-ore.jpg',1,1,0,'2018-01-13 06:24:55','2018-01-13 06:24:55'),(136,'Oh my tickets!','https://t.me/Oh_my_tickets','136-Oh-my-tickets.jpg',1,1,0,'2018-01-13 06:24:55','2018-01-13 06:24:55'),(137,'Ubiquiti Networks - Brasil','https://t.me/ubiquitibr','137-Ubiquiti-Networks-Brasil.jpg',1,1,0,'2018-01-13 06:24:55','2018-01-13 06:24:55'),(138,'Skycoin News','https://t.me/skycoinnews','138-Skycoin-News.jpg',1,1,0,'2018-01-13 06:24:55','2018-01-13 06:24:55'),(139,'Decentraland Korea','https://t.me/decentralandkorea','139-Decentraland-Korea.jpg',1,1,0,'2018-01-13 06:24:55','2018-01-13 06:24:55'),(140,'Blocknet','https://t.me/Blocknet','140-Blocknet.jpg',1,1,0,'2018-01-13 06:24:55','2018-01-13 06:24:55'),(141,'Official Counterparty Chat','https://t.me/Counterparty_XCP','141-Official-Counterparty-Chat.jpg',1,1,0,'2018-01-13 06:24:55','2018-01-13 06:24:55'),(142,'Syscoin','https://t.me/syscoin','142-Syscoin.jpg',1,1,0,'2018-01-13 06:24:55','2018-01-13 06:24:55'),(143,'Delphy天算官方公告栏','https://t.me/DelphyBulletinBoard','143-Delphy-days-official-bulletin-board.jpg',1,1,0,'2018-01-13 06:24:55','2018-01-13 06:24:55'),(144,'Syscoin KR','https://t.me/SyscoinOfficialKR','144-Syscoin-KR.jpg',1,1,0,'2018-01-13 06:24:55','2018-01-13 06:24:55'),(145,'LinkEye Chinese','https://t.me/LinkEyeProject','145-LinkEye-Chinese.jpg',1,1,0,'2018-01-13 06:24:55','2018-01-13 06:24:55'),(146,'Poloniex Trollbox2!','https://t.me/poloniex2','146-Poloniex-Trollbox2.jpg',1,1,0,'2018-01-13 06:24:55','2018-01-13 06:24:55'),(147,'SiacoinRU (SC)','https://t.me/SiacoinRU','147-SiacoinRU-(SC).jpg',1,1,0,'2018-01-13 06:24:55','2018-01-13 06:24:55'),(148,'金牛财经JinNiu.cn','https://t.me/jinniu','148-Taurus-Finance-JinNiu.cn.jpg',1,1,0,'2018-01-13 06:24:55','2018-01-13 06:24:55'),(149,'Iconomi ICN Español','https://t.me/IconomiES','149-Iconomi-ICN-Español.jpg',1,1,0,'2018-01-13 06:24:55','2018-01-13 06:24:55'),(150,'Siacoin SC 中文讨论 (CN)','https://t.me/SiacoinCN','150-Siacoin-SC-(CN).jpg',1,1,0,'2018-01-13 06:24:56','2018-01-13 06:24:56');
/*!40000 ALTER TABLE `groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rank`
--

DROP TABLE IF EXISTS `rank`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rank` (
  `rankid` int(11) NOT NULL AUTO_INCREMENT,
  `taskname` varchar(25) NOT NULL COMMENT '任务名称',
  `owner` varchar(25) NOT NULL COMMENT '任务执行人',
  `score` tinyint(4) NOT NULL DEFAULT '0' COMMENT '评分',
  `reason` text NOT NULL COMMENT '评分理由',
  PRIMARY KEY (`rankid`),
  KEY `idx_owner` (`owner`),
  KEY `idx_owner_score` (`owner`,`score`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='积分排行表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rank`
--

LOCK TABLES `rank` WRITE;
/*!40000 ALTER TABLE `rank` DISABLE KEYS */;
/*!40000 ALTER TABLE `rank` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recommend`
--

DROP TABLE IF EXISTS `recommend`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `recommend` (
  `recommendid` int(11) NOT NULL AUTO_INCREMENT,
  `recommendname` varchar(80) NOT NULL COMMENT 'recommend名称',
  `recommendlink` varchar(200) NOT NULL COMMENT 'recommend链接',
  `recommendicon` varchar(200) NOT NULL COMMENT 'recommend图像链接',
  `enabled` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否有效',
  `seq` tinyint(4) NOT NULL DEFAULT '0' COMMENT '序列',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT '已删除?',
  `createtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updatetime` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  PRIMARY KEY (`recommendid`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='drecommend列表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recommend`
--

LOCK TABLES `recommend` WRITE;
/*!40000 ALTER TABLE `recommend` DISABLE KEYS */;
INSERT INTO `recommend` VALUES (1,'推荐群','http://115.159.183.91:3001/panda/','xxx.png',1,1,0,'2018-02-09 09:05:35','2018-02-09 09:05:35'),(2,'行情','http://sosobtc.me/soso/kline_list','xxx.png',1,1,0,'2018-02-09 09:05:49','2018-02-09 09:05:49'),(3,'DAPP','DAPP','xxx.png',1,1,0,'2018-02-09 09:05:49','2018-02-09 09:05:49');
/*!40000 ALTER TABLE `recommend` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `signon`
--

DROP TABLE IF EXISTS `signon`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `signon` (
  `username` varchar(25) NOT NULL,
  `password` varchar(25) NOT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `signon`
--

LOCK TABLES `signon` WRITE;
/*!40000 ALTER TABLE `signon` DISABLE KEYS */;
INSERT INTO `signon` VALUES ('admin','Your Password');
/*!40000 ALTER TABLE `signon` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `task`
--

DROP TABLE IF EXISTS `task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `task` (
  `taskid` int(11) NOT NULL AUTO_INCREMENT,
  `taskname` varchar(25) NOT NULL COMMENT '任务名称',
  `prepared` tinyint(4) NOT NULL DEFAULT '0' COMMENT '用例已分配?',
  `owner` varchar(25) NOT NULL COMMENT '任务执行人',
  `taskdone` tinyint(4) NOT NULL DEFAULT '0' COMMENT '全部用例已执行完成?(auto generated)',
  `taskscore` tinyint(4) NOT NULL DEFAULT '0' COMMENT '任务执行质量平均分(auto generated)',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT '已删除?',
  `creator` varchar(25) NOT NULL COMMENT '创建人',
  `modifier` varchar(25) NOT NULL COMMENT '修改人',
  `createtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updatetime` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  PRIMARY KEY (`taskid`),
  KEY `idx_owner` (`owner`),
  KEY `idx_taskdone` (`taskdone`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='任务表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task`
--

LOCK TABLES `task` WRITE;
/*!40000 ALTER TABLE `task` DISABLE KEYS */;
/*!40000 ALTER TABLE `task` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `taskcase`
--

DROP TABLE IF EXISTS `taskcase`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `taskcase` (
  `taskid` int(11) NOT NULL DEFAULT '0' COMMENT '任务id',
  `caseid` int(11) NOT NULL COMMENT '用例id',
  `casedone` tinyint(4) NOT NULL DEFAULT '0' COMMENT '某用例已执行完成?',
  `evaluated` tinyint(4) NOT NULL DEFAULT '0' COMMENT '某用例已评分?',
  `casescore` tinyint(4) NOT NULL DEFAULT '0' COMMENT '用例执行质量评分',
  `bugurl` varchar(255) NOT NULL DEFAULT '' COMMENT 'Bug URL',
  PRIMARY KEY (`taskid`,`caseid`),
  KEY `idx_taskid` (`taskid`),
  KEY `idx_taskid_casescore` (`taskid`,`casescore`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='任务用例关系表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `taskcase`
--

LOCK TABLES `taskcase` WRITE;
/*!40000 ALTER TABLE `taskcase` DISABLE KEYS */;
/*!40000 ALTER TABLE `taskcase` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-02-09 18:06:43
