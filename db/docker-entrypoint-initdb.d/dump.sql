-- MySQL dump 10.17  Distrib 10.3.22-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: docker-antragsgruen_database_1    Database: antragsgruen
-- ------------------------------------------------------
-- Server version	10.5.8-MariaDB-1:10.5.8+maria~focal

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `amendment`
--

DROP TABLE IF EXISTS `amendment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `amendment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `motionId` int(11) DEFAULT NULL,
  `titlePrefix` varchar(45) DEFAULT NULL,
  `changeEditorial` longtext NOT NULL,
  `changeText` longtext NOT NULL,
  `changeExplanation` longtext NOT NULL,
  `changeExplanationHtml` tinyint(4) NOT NULL DEFAULT 0,
  `cache` longtext NOT NULL,
  `dateCreation` timestamp NOT NULL DEFAULT current_timestamp(),
  `datePublication` timestamp NULL DEFAULT NULL,
  `dateResolution` timestamp NULL DEFAULT NULL,
  `status` tinyint(4) NOT NULL,
  `statusString` varchar(55) NOT NULL,
  `noteInternal` text DEFAULT NULL,
  `textFixed` tinyint(4) DEFAULT 0,
  `globalAlternative` tinyint(4) DEFAULT 0,
  `proposalStatus` tinyint(4) DEFAULT NULL,
  `proposalReferenceId` int(11) DEFAULT NULL,
  `proposalComment` text DEFAULT NULL,
  `proposalVisibleFrom` timestamp NULL DEFAULT NULL,
  `proposalNotification` timestamp NULL DEFAULT NULL,
  `proposalUserStatus` tinyint(4) DEFAULT NULL,
  `proposalExplanation` text DEFAULT NULL,
  `votingStatus` tinyint(4) DEFAULT NULL,
  `votingBlockId` int(11) DEFAULT NULL,
  `votingData` text DEFAULT NULL,
  `responsibilityId` int(11) DEFAULT NULL,
  `responsibilityComment` text DEFAULT NULL,
  `extraData` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_motionIdx` (`motionId`),
  KEY `amendment_reference_am` (`proposalReferenceId`),
  KEY `ix_amendment_voting_block` (`votingBlockId`),
  KEY `fk_amendment_responsibility` (`responsibilityId`),
  CONSTRAINT `fk_amendment_motion` FOREIGN KEY (`motionId`) REFERENCES `motion` (`id`) ON DELETE SET NULL ON UPDATE NO ACTION,
  CONSTRAINT `fk_amendment_reference_am` FOREIGN KEY (`proposalReferenceId`) REFERENCES `amendment` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_amendment_responsibility` FOREIGN KEY (`responsibilityId`) REFERENCES `user` (`id`),
  CONSTRAINT `fk_amendment_voting_block` FOREIGN KEY (`votingBlockId`) REFERENCES `votingBlock` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `amendment`
--

LOCK TABLES `amendment` WRITE;
/*!40000 ALTER TABLE `amendment` DISABLE KEYS */;
/*!40000 ALTER TABLE `amendment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `amendmentAdminComment`
--

DROP TABLE IF EXISTS `amendmentAdminComment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `amendmentAdminComment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `amendmentId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `text` mediumtext NOT NULL,
  `status` tinyint(4) NOT NULL,
  `dateCreation` timestamp NOT NULL DEFAULT current_timestamp(),
  UNIQUE KEY `id` (`id`),
  KEY `amendmentId` (`amendmentId`),
  KEY `userId` (`userId`),
  CONSTRAINT `amendmentAdminComment_ibfk_1` FOREIGN KEY (`amendmentId`) REFERENCES `amendment` (`id`),
  CONSTRAINT `amendmentAdminComment_ibfk_2` FOREIGN KEY (`userId`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `amendmentAdminComment`
--

LOCK TABLES `amendmentAdminComment` WRITE;
/*!40000 ALTER TABLE `amendmentAdminComment` DISABLE KEYS */;
/*!40000 ALTER TABLE `amendmentAdminComment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `amendmentComment`
--

DROP TABLE IF EXISTS `amendmentComment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `amendmentComment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) DEFAULT NULL,
  `amendmentId` int(11) NOT NULL,
  `parentCommentId` int(11) DEFAULT NULL,
  `paragraph` smallint(6) NOT NULL,
  `text` mediumtext NOT NULL,
  `name` text NOT NULL,
  `contactEmail` varchar(100) DEFAULT NULL,
  `dateCreation` timestamp NOT NULL DEFAULT current_timestamp(),
  `status` tinyint(4) NOT NULL,
  `replyNotification` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `fk_amendment_comment_userIdx` (`userId`),
  KEY `fk_amendment_comment_amendmentIdx` (`amendmentId`),
  KEY `fk_amendment_comment_parents` (`parentCommentId`),
  CONSTRAINT `amendmentComment_ibfk_1` FOREIGN KEY (`amendmentId`) REFERENCES `amendment` (`id`),
  CONSTRAINT `fk_amendment_comment_parents` FOREIGN KEY (`parentCommentId`) REFERENCES `amendmentComment` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_amendment_comment_user` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE SET NULL ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `amendmentComment`
--

LOCK TABLES `amendmentComment` WRITE;
/*!40000 ALTER TABLE `amendmentComment` DISABLE KEYS */;
/*!40000 ALTER TABLE `amendmentComment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `amendmentSection`
--

DROP TABLE IF EXISTS `amendmentSection`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `amendmentSection` (
  `amendmentId` int(11) NOT NULL,
  `sectionId` int(11) NOT NULL,
  `data` longtext NOT NULL,
  `dataRaw` longtext NOT NULL,
  `cache` longtext NOT NULL,
  `metadata` text DEFAULT NULL,
  PRIMARY KEY (`amendmentId`,`sectionId`),
  KEY `sectionId` (`sectionId`),
  CONSTRAINT `amendmentSection_ibfk_1` FOREIGN KEY (`amendmentId`) REFERENCES `amendment` (`id`),
  CONSTRAINT `amendmentSection_ibfk_2` FOREIGN KEY (`sectionId`) REFERENCES `consultationSettingsMotionSection` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `amendmentSection`
--

LOCK TABLES `amendmentSection` WRITE;
/*!40000 ALTER TABLE `amendmentSection` DISABLE KEYS */;
/*!40000 ALTER TABLE `amendmentSection` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `amendmentSupporter`
--

DROP TABLE IF EXISTS `amendmentSupporter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `amendmentSupporter` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `amendmentId` int(11) NOT NULL,
  `position` smallint(6) NOT NULL DEFAULT 0,
  `userId` int(11) DEFAULT NULL,
  `role` enum('initiates','supports','likes','dislikes') NOT NULL,
  `comment` mediumtext DEFAULT NULL,
  `personType` tinyint(4) DEFAULT NULL,
  `name` text DEFAULT NULL,
  `organization` text DEFAULT NULL,
  `resolutionDate` date DEFAULT NULL,
  `contactName` text DEFAULT NULL,
  `contactEmail` varchar(100) DEFAULT NULL,
  `contactPhone` varchar(100) DEFAULT NULL,
  `dateCreation` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `extraData` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_amendmentIdx` (`amendmentId`),
  KEY `fk_supporter_idx` (`userId`),
  CONSTRAINT `fk_support_amendment` FOREIGN KEY (`amendmentId`) REFERENCES `amendment` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_support_user` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `amendmentSupporter`
--

LOCK TABLES `amendmentSupporter` WRITE;
/*!40000 ALTER TABLE `amendmentSupporter` DISABLE KEYS */;
/*!40000 ALTER TABLE `amendmentSupporter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `consultation`
--

DROP TABLE IF EXISTS `consultation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `consultation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `siteId` int(11) NOT NULL,
  `urlPath` varchar(45) DEFAULT NULL,
  `wordingBase` varchar(20) NOT NULL,
  `title` varchar(200) NOT NULL,
  `titleShort` varchar(45) NOT NULL,
  `eventDateFrom` date DEFAULT NULL,
  `eventDateTo` date DEFAULT NULL,
  `amendmentNumbering` tinyint(4) NOT NULL,
  `adminEmail` varchar(150) DEFAULT NULL,
  `dateCreation` timestamp NULL DEFAULT NULL,
  `dateDeletion` timestamp NULL DEFAULT NULL,
  `settings` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `yii_url_UNIQUE` (`urlPath`,`siteId`),
  KEY `fk_consultation_siteIdx` (`siteId`),
  CONSTRAINT `fk_veranstaltung_veranstaltungsreihe1` FOREIGN KEY (`siteId`) REFERENCES `site` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `consultation`
--

LOCK TABLES `consultation` WRITE;
/*!40000 ALTER TABLE `consultation` DISABLE KEYS */;
INSERT INTO `consultation` VALUES (1,1,'std','de-programm','Base','Base',NULL,NULL,0,'admin@wir2020.local','2020-12-20 12:41:48',NULL,'{\n    \"maintenanceMode\": false,\n    \"screeningMotions\": false,\n    \"screeningAmendments\": false,\n    \"lineNumberingGlobal\": false,\n    \"iniatorsMayEdit\": false,\n    \"hideTitlePrefix\": false,\n    \"showFeeds\": true,\n    \"commentNeedsEmail\": false,\n    \"screeningComments\": false,\n    \"initiatorConfirmEmails\": false,\n    \"adminsMayEdit\": true,\n    \"editorialAmendments\": true,\n    \"globalAlternatives\": true,\n    \"proposalProcedurePage\": false,\n    \"collectingPage\": false,\n    \"sidebarNewMotions\": true,\n    \"forceLogin\": false,\n    \"managedUserAccounts\": false,\n    \"amendmentBookmarksWithNames\": false,\n    \"forceMotion\": null,\n    \"accessPwd\": null,\n    \"translationService\": null,\n    \"organisations\": null,\n    \"commentsSupportable\": false,\n    \"screeningMotionsShown\": false,\n    \"initiatorsMayReject\": false,\n    \"allowMultipleTags\": false,\n    \"odtExportHasLineNumers\": true,\n    \"pProcedureExpandAll\": true,\n    \"lineLength\": 80,\n    \"startLayoutType\": 0,\n    \"robotsPolicy\": 1,\n    \"motiondataMode\": 0,\n    \"logoUrl\": null,\n    \"emailReplyTo\": null,\n    \"emailFromName\": null\n}');
/*!40000 ALTER TABLE `consultation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `consultationAgendaItem`
--

DROP TABLE IF EXISTS `consultationAgendaItem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `consultationAgendaItem` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `consultationId` int(11) NOT NULL,
  `parentItemId` int(11) DEFAULT NULL,
  `position` int(11) NOT NULL,
  `time` varchar(20) DEFAULT NULL,
  `code` varchar(20) NOT NULL,
  `title` varchar(250) NOT NULL,
  `motionTypeId` int(11) DEFAULT NULL,
  `settings` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `consultationId` (`consultationId`),
  KEY `parentItemId` (`parentItemId`),
  KEY `motionTypeId` (`motionTypeId`),
  CONSTRAINT `consultationAgendaItem_ibfk_1` FOREIGN KEY (`consultationId`) REFERENCES `consultation` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `consultationAgendaItem_ibfk_2` FOREIGN KEY (`parentItemId`) REFERENCES `consultationAgendaItem` (`id`) ON DELETE SET NULL ON UPDATE NO ACTION,
  CONSTRAINT `consultationAgendaItem_ibfk_3` FOREIGN KEY (`motionTypeId`) REFERENCES `consultationMotionType` (`id`) ON DELETE SET NULL ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `consultationAgendaItem`
--

LOCK TABLES `consultationAgendaItem` WRITE;
/*!40000 ALTER TABLE `consultationAgendaItem` DISABLE KEYS */;
/*!40000 ALTER TABLE `consultationAgendaItem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `consultationFile`
--

DROP TABLE IF EXISTS `consultationFile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `consultationFile` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `consultationId` int(11) DEFAULT NULL,
  `siteId` int(11) DEFAULT NULL,
  `downloadPosition` mediumint(9) DEFAULT NULL,
  `filename` varchar(250) NOT NULL,
  `title` text DEFAULT NULL,
  `filesize` int(11) NOT NULL,
  `mimetype` varchar(250) NOT NULL,
  `width` int(11) DEFAULT NULL,
  `height` int(11) DEFAULT NULL,
  `data` mediumblob NOT NULL,
  `dataHash` varchar(40) NOT NULL,
  `uploadedById` int(11) DEFAULT NULL,
  `dateCreation` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `fk_file_consultation` (`consultationId`),
  KEY `consultation_file_site` (`siteId`),
  KEY `fk_file_uploaded_by` (`uploadedById`),
  CONSTRAINT `fk_consultation_file_site` FOREIGN KEY (`siteId`) REFERENCES `site` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_file_consultation` FOREIGN KEY (`consultationId`) REFERENCES `consultation` (`id`),
  CONSTRAINT `fk_file_uploaded_by` FOREIGN KEY (`uploadedById`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `consultationFile`
--

LOCK TABLES `consultationFile` WRITE;
/*!40000 ALTER TABLE `consultationFile` DISABLE KEYS */;
/*!40000 ALTER TABLE `consultationFile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `consultationLog`
--

DROP TABLE IF EXISTS `consultationLog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `consultationLog` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) DEFAULT NULL,
  `consultationId` int(11) NOT NULL,
  `actionType` smallint(6) NOT NULL,
  `actionReferenceId` int(11) NOT NULL,
  `actionTime` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `userId` (`userId`),
  KEY `consultationId` (`consultationId`,`actionTime`) USING BTREE,
  CONSTRAINT `consultationLog_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `user` (`id`),
  CONSTRAINT `consultationLog_ibfk_2` FOREIGN KEY (`consultationId`) REFERENCES `consultation` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `consultationLog`
--

LOCK TABLES `consultationLog` WRITE;
/*!40000 ALTER TABLE `consultationLog` DISABLE KEYS */;
INSERT INTO `consultationLog` VALUES (1,1,1,0,1,'2020-12-20 12:53:34');
/*!40000 ALTER TABLE `consultationLog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `consultationMotionType`
--

DROP TABLE IF EXISTS `consultationMotionType`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `consultationMotionType` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `consultationId` int(11) NOT NULL,
  `titleSingular` varchar(100) NOT NULL,
  `titlePlural` varchar(100) NOT NULL,
  `createTitle` varchar(200) NOT NULL,
  `sidebarCreateButton` tinyint(4) NOT NULL DEFAULT 1,
  `motionPrefix` varchar(10) DEFAULT NULL,
  `position` int(11) NOT NULL,
  `settings` text DEFAULT NULL,
  `cssIcon` varchar(100) DEFAULT NULL,
  `pdfLayout` int(11) NOT NULL DEFAULT 0,
  `texTemplateId` int(11) DEFAULT NULL,
  `deadlines` text DEFAULT NULL,
  `policyMotions` int(11) NOT NULL,
  `policyAmendments` int(11) NOT NULL,
  `policyComments` int(11) NOT NULL,
  `policySupportMotions` int(11) NOT NULL,
  `policySupportAmendments` int(11) NOT NULL,
  `initiatorsCanMergeAmendments` tinyint(4) NOT NULL DEFAULT 0,
  `motionLikesDislikes` int(11) NOT NULL,
  `amendmentLikesDislikes` int(11) NOT NULL,
  `supportType` int(11) NOT NULL,
  `supportTypeSettings` text DEFAULT NULL,
  `supportTypeMotions` text DEFAULT NULL,
  `supportTypeAmendments` text DEFAULT NULL,
  `amendmentMultipleParagraphs` tinyint(1) DEFAULT NULL,
  `status` smallint(6) NOT NULL,
  `layoutTwoCols` smallint(6) DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `consultationId` (`consultationId`,`position`) USING BTREE,
  KEY `texLayout` (`texTemplateId`),
  CONSTRAINT `consultationMotionType_ibfk_1` FOREIGN KEY (`consultationId`) REFERENCES `consultation` (`id`),
  CONSTRAINT `consultationMotionType_ibfk_2` FOREIGN KEY (`texTemplateId`) REFERENCES `texTemplate` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `consultationMotionType`
--

LOCK TABLES `consultationMotionType` WRITE;
/*!40000 ALTER TABLE `consultationMotionType` DISABLE KEYS */;
INSERT INTO `consultationMotionType` VALUES (1,1,'Kapitel','Kapitel','Kapitel anlegen',1,NULL,0,'{\n    \"pdfIntroduction\": \"\",\n    \"cssIcon\": \"\",\n    \"motionTitleIntro\": \"\",\n    \"hasProposedProcedure\": false,\n    \"hasResponsibilities\": false,\n    \"twoColMerging\": false\n}',NULL,0,NULL,'{\"motions\":[{\"start\":null,\"end\":null,\"title\":null}],\"amendments\":[{\"start\":null,\"end\":null,\"title\":null}]}',2,2,0,0,0,0,0,0,0,'','{\n    \"type\": 0,\n    \"initiatorCanBePerson\": true,\n    \"initiatorCanBeOrganization\": true,\n    \"minSupporters\": 1,\n    \"minSupportersFemale\": null,\n    \"maxPdfSupporters\": null,\n    \"hasOrganizations\": true,\n    \"allowMoreSupporters\": true,\n    \"hasResolutionDate\": 2,\n    \"allowSupportingAfterPublication\": false,\n    \"skipForOrganizations\": true,\n    \"contactName\": 0,\n    \"contactPhone\": 1,\n    \"contactEmail\": 2,\n    \"contactGender\": 0\n}',NULL,1,0,0);
/*!40000 ALTER TABLE `consultationMotionType` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `consultationOdtTemplate`
--

DROP TABLE IF EXISTS `consultationOdtTemplate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `consultationOdtTemplate` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `consultationId` int(11) NOT NULL,
  `type` tinyint(4) NOT NULL,
  `data` blob NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_consultationIdx` (`consultationId`),
  CONSTRAINT `fk_odt_templates` FOREIGN KEY (`consultationId`) REFERENCES `consultation` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `consultationOdtTemplate`
--

LOCK TABLES `consultationOdtTemplate` WRITE;
/*!40000 ALTER TABLE `consultationOdtTemplate` DISABLE KEYS */;
/*!40000 ALTER TABLE `consultationOdtTemplate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `consultationSettingsMotionSection`
--

DROP TABLE IF EXISTS `consultationSettingsMotionSection`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `consultationSettingsMotionSection` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `motionTypeId` int(11) NOT NULL,
  `type` int(11) NOT NULL,
  `position` smallint(6) DEFAULT NULL,
  `status` tinyint(4) NOT NULL,
  `title` varchar(100) NOT NULL,
  `data` text DEFAULT NULL,
  `fixedWidth` tinyint(4) NOT NULL,
  `required` tinyint(4) NOT NULL,
  `maxLen` int(11) DEFAULT NULL,
  `lineNumbers` tinyint(4) NOT NULL DEFAULT 0,
  `hasComments` tinyint(4) NOT NULL,
  `hasAmendments` tinyint(4) NOT NULL DEFAULT 1,
  `positionRight` smallint(6) DEFAULT 0,
  `printTitle` tinyint(4) NOT NULL DEFAULT 1,
  `settings` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `motionType` (`motionTypeId`),
  CONSTRAINT `consultationSettingsMotionSection_ibfk_1` FOREIGN KEY (`motionTypeId`) REFERENCES `consultationMotionType` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `consultationSettingsMotionSection`
--

LOCK TABLES `consultationSettingsMotionSection` WRITE;
/*!40000 ALTER TABLE `consultationSettingsMotionSection` DISABLE KEYS */;
INSERT INTO `consultationSettingsMotionSection` VALUES (1,1,0,0,0,'Kapiteltitel',NULL,0,1,0,0,0,1,0,1,NULL),(2,1,1,1,0,'Text',NULL,1,1,0,1,1,1,0,1,NULL);
/*!40000 ALTER TABLE `consultationSettingsMotionSection` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `consultationSettingsTag`
--

DROP TABLE IF EXISTS `consultationSettingsTag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `consultationSettingsTag` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `consultationId` int(11) DEFAULT NULL,
  `position` smallint(6) DEFAULT NULL,
  `title` varchar(100) NOT NULL,
  `cssicon` smallint(6) DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `consultationId` (`consultationId`),
  CONSTRAINT `consultation_tag_fk_consultation` FOREIGN KEY (`consultationId`) REFERENCES `consultation` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `consultationSettingsTag`
--

LOCK TABLES `consultationSettingsTag` WRITE;
/*!40000 ALTER TABLE `consultationSettingsTag` DISABLE KEYS */;
/*!40000 ALTER TABLE `consultationSettingsTag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `consultationText`
--

DROP TABLE IF EXISTS `consultationText`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `consultationText` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `consultationId` int(11) DEFAULT NULL,
  `siteId` int(11) DEFAULT NULL,
  `category` varchar(20) NOT NULL,
  `textId` varchar(100) NOT NULL,
  `menuPosition` int(11) DEFAULT NULL,
  `title` text DEFAULT NULL,
  `breadcrumb` text DEFAULT NULL,
  `text` longtext DEFAULT NULL,
  `editDate` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `consultation_text_unique` (`category`,`textId`,`consultationId`),
  KEY `fk_texts_consultationIdx` (`consultationId`),
  KEY `consultation_text_site` (`siteId`),
  CONSTRAINT `fk_consultation_text_site` FOREIGN KEY (`siteId`) REFERENCES `site` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_texts_consultation` FOREIGN KEY (`consultationId`) REFERENCES `consultation` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `consultationText`
--

LOCK TABLES `consultationText` WRITE;
/*!40000 ALTER TABLE `consultationText` DISABLE KEYS */;
INSERT INTO `consultationText` VALUES (1,NULL,1,'pagedata','legal',NULL,NULL,NULL,'<p><strong>Verantwortlich gemäß § 5 Telemediengesetz (TMG)</strong></p><address>x</address>','2020-12-20 11:41:48');
/*!40000 ALTER TABLE `consultationText` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `consultationUserPrivilege`
--

DROP TABLE IF EXISTS `consultationUserPrivilege`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `consultationUserPrivilege` (
  `userId` int(11) NOT NULL,
  `consultationId` int(11) NOT NULL,
  `privilegeView` tinyint(4) NOT NULL DEFAULT 0,
  `privilegeCreate` tinyint(4) NOT NULL DEFAULT 0,
  `adminSuper` tinyint(4) NOT NULL DEFAULT 0,
  `adminContentEdit` tinyint(4) NOT NULL DEFAULT 0,
  `adminScreen` tinyint(4) NOT NULL DEFAULT 0,
  `adminProposals` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`userId`,`consultationId`),
  KEY `consultationId` (`consultationId`),
  CONSTRAINT `consultationUserPrivilege_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `user` (`id`),
  CONSTRAINT `consultationUserPrivilege_ibfk_2` FOREIGN KEY (`consultationId`) REFERENCES `consultation` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `consultationUserPrivilege`
--

LOCK TABLES `consultationUserPrivilege` WRITE;
/*!40000 ALTER TABLE `consultationUserPrivilege` DISABLE KEYS */;
/*!40000 ALTER TABLE `consultationUserPrivilege` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `emailBlacklist`
--

DROP TABLE IF EXISTS `emailBlacklist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `emailBlacklist` (
  `emailHash` varchar(32) NOT NULL,
  PRIMARY KEY (`emailHash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `emailBlacklist`
--

LOCK TABLES `emailBlacklist` WRITE;
/*!40000 ALTER TABLE `emailBlacklist` DISABLE KEYS */;
/*!40000 ALTER TABLE `emailBlacklist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `emailLog`
--

DROP TABLE IF EXISTS `emailLog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `emailLog` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fromSiteId` int(11) DEFAULT NULL,
  `toEmail` varchar(200) DEFAULT NULL,
  `toUserId` int(11) DEFAULT NULL,
  `type` smallint(6) DEFAULT NULL,
  `fromEmail` varchar(200) DEFAULT NULL,
  `dateSent` timestamp NULL DEFAULT NULL,
  `subject` varchar(200) DEFAULT NULL,
  `text` mediumtext DEFAULT NULL,
  `messageId` varchar(100) NOT NULL,
  `status` smallint(6) NOT NULL,
  `error` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_mail_log_userIdx` (`toUserId`),
  KEY `fromSiteId` (`fromSiteId`),
  CONSTRAINT `emailLog_ibfk_1` FOREIGN KEY (`fromSiteId`) REFERENCES `site` (`id`),
  CONSTRAINT `fk_mail_log_user` FOREIGN KEY (`toUserId`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `emailLog`
--

LOCK TABLES `emailLog` WRITE;
/*!40000 ALTER TABLE `emailLog` DISABLE KEYS */;
INSERT INTO `emailLog` VALUES (1,1,'admin@wir2020.local',NULL,3,'Base <base@wir2020.local>','2020-12-20 12:53:34','Neuer Antrag','Es wurde ein neuer Antrag eingereicht.\nTitel: Das erste Kapitel\nAntragsteller*in: Berta Baumann\nLink: http://wir2020.local/std/Das_erste_Kapitel-59791','5fdf3b3ea095d@wir2020.local',0,NULL);
/*!40000 ALTER TABLE `emailLog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migration`
--

DROP TABLE IF EXISTS `migration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `migration` (
  `version` varchar(180) NOT NULL,
  `apply_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migration`
--

LOCK TABLES `migration` WRITE;
/*!40000 ALTER TABLE `migration` DISABLE KEYS */;
INSERT INTO `migration` VALUES ('m000000_000000_base',1443797618),('m150930_094343_amendment_multiple_paragraphs',1443797661),('m151021_084634_supporter_organization_contact_person',1445519132),('m151025_123256_user_email_change',1445802530),('m151104_092212_motion_type_deletable',1445802530),('m151104_132242_site_consultation_date_creation',1445802530),('m151106_083636_site_properties',1446801672),('m151106_183055_motion_type_two_cols',1446834722),('m160114_200337_motion_section_is_right',1452801905),('m160228_152511_motion_type_rename_initiator_form',1457086233),('m160304_095858_motion_slug',1457086236),('m160305_201135_support_separate_to_motions_and_amendments',1457209261),('m160305_214526_support_likes_dislikes',1457209261),('m160605_104819_remove_consultation_type',1457209261),('m161112_161536_add_date_delete',1457209261),('m170111_182139_motions_non_amendable',1457209261),('m170129_173812_typo_maintenance',1485711868),('m170204_191243_additional_user_fields',1486235651),('m170206_185458_supporter_contact_name',1486410534),('m170226_134156_motionInitiatorsAmendmentMerging',1489921851),('m170419_182728_delete_consultation_admin',1492626507),('m170611_195343_global_alternatives',1497211108),('m170730_094020_amendment_proposed_changes',1501417715),('m170807_193931_voting_status',1502136950),('m170826_180536_proposal_notifications',1503771800),('m170923_151852_proposal_explanation',1506180317),('m171219_173517_motion_proposed_changes',1513705579),('m171231_093702_user_organization_ids',1514713083),('m180519_180908_siteTexts',1526808262),('m180524_153540_motionTypeDeadlines',1527269132),('m180531_062049_parent_motion_ids',1527748415),('m180602_121824_motion_create_buttons',1527942369),('m180604_080335_notification_settings',1528099492),('m180605_125835_consultation_files',1528299492),('m180609_095225_consultation_text_in_menu',1528538064),('m180619_080947_email_settings_to_consultations',1529396014),('m180621_113721_login_settings_to_consultation',1529581178),('m180623_113955_motionTypeSettings',1529754995),('m180901_131243_sectionPrintTitle',1535807788),('m180902_182805_initiatorSettings',1536090959),('m180906_171118_supporterExtraData',1536090959),('m181027_094836_fix_amendment_comment_relation',1541091342),('m181027_174827_consultationFilesSite',1544887273),('m181101_161124_proposed_procedure_active',1541091342),('m190816_074556_votingData',1565941741),('m190901_065243_deleteOldMergingDrafts',1565941741),('m191101_162351_motion_responsibility',1572625790),('m191201_080255_motion_support_types',1575188572),('m191208_065712_file_downloads',1575791718),('m191222_135810_lualatex',1577023546),('m200107_113326_motionSectionSettings',1578396899),('m200125_124424_minimalistic_ui',1580379395),('m200130_100306_agenda_extension',1580379395),('m200223_161553_agenda_obsoletion',1582474676),('m200301_110040_user_settings',1583060479),('m200621_063838_amendmentMotionExtraData',1592721950);
/*!40000 ALTER TABLE `migration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `motion`
--

DROP TABLE IF EXISTS `motion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `motion` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `consultationId` int(11) NOT NULL,
  `motionTypeId` int(11) NOT NULL,
  `parentMotionId` int(11) DEFAULT NULL,
  `agendaItemId` int(11) DEFAULT NULL,
  `title` text NOT NULL,
  `titlePrefix` varchar(50) NOT NULL,
  `dateCreation` timestamp NOT NULL DEFAULT current_timestamp(),
  `datePublication` timestamp NULL DEFAULT NULL,
  `dateResolution` timestamp NULL DEFAULT NULL,
  `status` tinyint(4) NOT NULL,
  `statusString` varchar(55) DEFAULT NULL,
  `nonAmendable` tinyint(4) NOT NULL DEFAULT 0,
  `noteInternal` text DEFAULT NULL,
  `cache` longtext NOT NULL,
  `textFixed` tinyint(4) DEFAULT 0,
  `slug` varchar(100) DEFAULT NULL,
  `proposalStatus` tinyint(4) DEFAULT NULL,
  `proposalReferenceId` int(11) DEFAULT NULL,
  `proposalComment` text DEFAULT NULL,
  `proposalVisibleFrom` timestamp NULL DEFAULT NULL,
  `proposalNotification` timestamp NULL DEFAULT NULL,
  `proposalUserStatus` tinyint(4) DEFAULT NULL,
  `proposalExplanation` text DEFAULT NULL,
  `votingStatus` tinyint(4) DEFAULT NULL,
  `votingBlockId` int(11) DEFAULT NULL,
  `votingData` text DEFAULT NULL,
  `responsibilityId` int(11) DEFAULT NULL,
  `responsibilityComment` text DEFAULT NULL,
  `extraData` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `motionSlug` (`consultationId`,`slug`),
  KEY `consultation` (`consultationId`),
  KEY `parent_motion` (`parentMotionId`),
  KEY `type` (`motionTypeId`),
  KEY `motion_reference_am` (`proposalReferenceId`),
  KEY `agendaItemId` (`agendaItemId`),
  KEY `ix_motion_voting_block` (`votingBlockId`),
  KEY `fk_motion_responsibility` (`responsibilityId`),
  CONSTRAINT `fk_motion_consultation` FOREIGN KEY (`consultationId`) REFERENCES `consultation` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_motion_reference_am` FOREIGN KEY (`proposalReferenceId`) REFERENCES `motion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_motion_responsibility` FOREIGN KEY (`responsibilityId`) REFERENCES `user` (`id`),
  CONSTRAINT `fk_motion_voting_block` FOREIGN KEY (`votingBlockId`) REFERENCES `votingBlock` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_site_parent` FOREIGN KEY (`parentMotionId`) REFERENCES `motion` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `motion_ibfk_1` FOREIGN KEY (`motionTypeId`) REFERENCES `consultationMotionType` (`id`),
  CONSTRAINT `motion_ibfk_2` FOREIGN KEY (`agendaItemId`) REFERENCES `consultationAgendaItem` (`id`) ON DELETE SET NULL ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `motion`
--

LOCK TABLES `motion` WRITE;
/*!40000 ALTER TABLE `motion` DISABLE KEYS */;
INSERT INTO `motion` VALUES (1,1,1,NULL,NULL,'Das erste Kapitel','A1','2020-12-20 12:53:34','2020-12-20 12:53:34',NULL,3,NULL,0,NULL,'a:2:{s:23:\"supporters.initiatorStr\";s:13:\"Berta Baumann\";s:24:\"lines.getFirstLineNumber\";i:1;}',0,'Das_erste_Kapitel-59791',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `motion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `motionAdminComment`
--

DROP TABLE IF EXISTS `motionAdminComment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `motionAdminComment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `motionId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `text` mediumtext NOT NULL,
  `status` tinyint(4) NOT NULL,
  `dateCreation` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `userId` (`userId`),
  KEY `motionId` (`motionId`),
  CONSTRAINT `motionAdminComment_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `user` (`id`),
  CONSTRAINT `motionAdminComment_ibfk_2` FOREIGN KEY (`motionId`) REFERENCES `motion` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `motionAdminComment`
--

LOCK TABLES `motionAdminComment` WRITE;
/*!40000 ALTER TABLE `motionAdminComment` DISABLE KEYS */;
/*!40000 ALTER TABLE `motionAdminComment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `motionComment`
--

DROP TABLE IF EXISTS `motionComment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `motionComment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) DEFAULT NULL,
  `motionId` int(11) NOT NULL,
  `parentCommentId` int(11) DEFAULT NULL,
  `sectionId` int(11) DEFAULT NULL,
  `paragraph` smallint(6) NOT NULL,
  `text` mediumtext NOT NULL,
  `name` text NOT NULL,
  `contactEmail` varchar(100) DEFAULT NULL,
  `dateCreation` timestamp NOT NULL DEFAULT current_timestamp(),
  `status` tinyint(4) NOT NULL,
  `replyNotification` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `fk_comment_userIdx` (`userId`),
  KEY `fk_comment_notion_idx` (`motionId`,`sectionId`),
  KEY `fk_motion_comment_parents` (`parentCommentId`),
  CONSTRAINT `fk_motion_comment_parents` FOREIGN KEY (`parentCommentId`) REFERENCES `motionComment` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_motion_comment_user` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `motionComment_ibfk_1` FOREIGN KEY (`motionId`) REFERENCES `motion` (`id`),
  CONSTRAINT `motionComment_ibfk_2` FOREIGN KEY (`motionId`, `sectionId`) REFERENCES `motionSection` (`motionId`, `sectionId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `motionComment`
--

LOCK TABLES `motionComment` WRITE;
/*!40000 ALTER TABLE `motionComment` DISABLE KEYS */;
/*!40000 ALTER TABLE `motionComment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `motionCommentSupporter`
--

DROP TABLE IF EXISTS `motionCommentSupporter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `motionCommentSupporter` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ipHash` char(32) DEFAULT NULL,
  `cookieId` int(11) DEFAULT NULL,
  `motionCommentId` int(11) NOT NULL,
  `likes` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ip_hash_motion` (`ipHash`,`motionCommentId`),
  UNIQUE KEY `cookie_motion` (`cookieId`,`motionCommentId`),
  KEY `fk_motion_comment_supporter_commentIdx` (`motionCommentId`),
  CONSTRAINT `fk_motion_comment_supporter_comment` FOREIGN KEY (`motionCommentId`) REFERENCES `motionComment` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `motionCommentSupporter`
--

LOCK TABLES `motionCommentSupporter` WRITE;
/*!40000 ALTER TABLE `motionCommentSupporter` DISABLE KEYS */;
/*!40000 ALTER TABLE `motionCommentSupporter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `motionSection`
--

DROP TABLE IF EXISTS `motionSection`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `motionSection` (
  `motionId` int(11) NOT NULL,
  `sectionId` int(11) NOT NULL,
  `data` longtext NOT NULL,
  `dataRaw` longtext NOT NULL,
  `cache` longtext NOT NULL,
  `metadata` text DEFAULT NULL,
  PRIMARY KEY (`motionId`,`sectionId`),
  KEY `motion_section_fk_sectionIdx` (`sectionId`),
  CONSTRAINT `motion_section_fk_motion` FOREIGN KEY (`motionId`) REFERENCES `motion` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `motion_section_fk_section` FOREIGN KEY (`sectionId`) REFERENCES `consultationSettingsMotionSection` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `motionSection`
--

LOCK TABLES `motionSection` WRITE;
/*!40000 ALTER TABLE `motionSection` DISABLE KEYS */;
INSERT INTO `motionSection` VALUES (1,1,'Das erste Kapitel','','',NULL),(1,2,'<p>Gallia est omnis divisa in partes tres.</p>','<p>Gallia est omnis divisa in partes tres.</p>\r\n','',NULL);
/*!40000 ALTER TABLE `motionSection` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `motionSubscription`
--

DROP TABLE IF EXISTS `motionSubscription`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `motionSubscription` (
  `motionId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  PRIMARY KEY (`motionId`,`userId`),
  KEY `fk_motionId` (`motionId`),
  KEY `fk_userId` (`userId`),
  CONSTRAINT `fk_subscription_motion` FOREIGN KEY (`motionId`) REFERENCES `motion` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_subscription_user` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `motionSubscription`
--

LOCK TABLES `motionSubscription` WRITE;
/*!40000 ALTER TABLE `motionSubscription` DISABLE KEYS */;
/*!40000 ALTER TABLE `motionSubscription` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `motionSupporter`
--

DROP TABLE IF EXISTS `motionSupporter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `motionSupporter` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `motionId` int(11) NOT NULL,
  `position` smallint(6) NOT NULL DEFAULT 0,
  `userId` int(11) DEFAULT NULL,
  `role` enum('initiates','supports','likes','dislikes') NOT NULL,
  `comment` mediumtext DEFAULT NULL,
  `personType` tinyint(4) DEFAULT NULL,
  `name` text DEFAULT NULL,
  `organization` text DEFAULT NULL,
  `resolutionDate` date DEFAULT NULL,
  `contactName` text DEFAULT NULL,
  `contactEmail` varchar(100) DEFAULT NULL,
  `contactPhone` varchar(100) DEFAULT NULL,
  `dateCreation` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `extraData` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_supporter_idx` (`userId`),
  KEY `fk_motionIdx` (`motionId`),
  CONSTRAINT `fk_motion` FOREIGN KEY (`motionId`) REFERENCES `motion` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_supporter` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `motionSupporter`
--

LOCK TABLES `motionSupporter` WRITE;
/*!40000 ALTER TABLE `motionSupporter` DISABLE KEYS */;
INSERT INTO `motionSupporter` VALUES (1,1,0,1,'initiates',NULL,0,'Berta Baumann','',NULL,'','berta@wir2020.local','','2020-12-20 12:53:27','[]');
/*!40000 ALTER TABLE `motionSupporter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `motionTag`
--

DROP TABLE IF EXISTS `motionTag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `motionTag` (
  `motionId` int(11) NOT NULL,
  `tagId` int(11) NOT NULL,
  PRIMARY KEY (`motionId`,`tagId`),
  KEY `motion_tag_fk_tagIdx` (`tagId`),
  CONSTRAINT `motion_tag_fk_motion` FOREIGN KEY (`motionId`) REFERENCES `motion` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `motion_tag_fk_tag` FOREIGN KEY (`tagId`) REFERENCES `consultationSettingsTag` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `motionTag`
--

LOCK TABLES `motionTag` WRITE;
/*!40000 ALTER TABLE `motionTag` DISABLE KEYS */;
/*!40000 ALTER TABLE `motionTag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `site`
--

DROP TABLE IF EXISTS `site`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `site` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `subdomain` varchar(45) DEFAULT NULL,
  `title` varchar(200) NOT NULL,
  `titleShort` varchar(100) DEFAULT NULL,
  `dateCreation` timestamp NULL DEFAULT NULL,
  `dateDeletion` timestamp NULL DEFAULT NULL,
  `settings` text DEFAULT NULL,
  `currentConsultationId` int(11) DEFAULT NULL,
  `public` tinyint(4) DEFAULT 1,
  `contact` mediumtext DEFAULT NULL,
  `organization` varchar(255) DEFAULT NULL,
  `status` smallint(6) DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `subdomain_UNIQUE` (`subdomain`),
  KEY `fk_veranstaltungsreihe_veranstaltung1_idx` (`currentConsultationId`),
  CONSTRAINT `fk_site_consultation` FOREIGN KEY (`currentConsultationId`) REFERENCES `consultation` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `site`
--

LOCK TABLES `site` WRITE;
/*!40000 ALTER TABLE `site` DISABLE KEYS */;
INSERT INTO `site` VALUES (1,'std','Base','Base','2020-12-20 12:41:48',NULL,NULL,1,1,'x',NULL,0);
/*!40000 ALTER TABLE `site` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `siteAdmin`
--

DROP TABLE IF EXISTS `siteAdmin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `siteAdmin` (
  `siteId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  PRIMARY KEY (`siteId`,`userId`),
  KEY `site_admin_fk_userIdx` (`userId`),
  KEY `site_admin_fk_siteIdx` (`siteId`),
  CONSTRAINT `site_admin_fk_site` FOREIGN KEY (`siteId`) REFERENCES `site` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `site_admin_fk_user` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `siteAdmin`
--

LOCK TABLES `siteAdmin` WRITE;
/*!40000 ALTER TABLE `siteAdmin` DISABLE KEYS */;
INSERT INTO `siteAdmin` VALUES (1,1);
/*!40000 ALTER TABLE `siteAdmin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `texTemplate`
--

DROP TABLE IF EXISTS `texTemplate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `texTemplate` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `siteId` int(11) DEFAULT NULL,
  `title` varchar(100) NOT NULL,
  `texLayout` text NOT NULL,
  `texContent` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `siteId` (`siteId`),
  CONSTRAINT `texTemplate_ibfk_1` FOREIGN KEY (`siteId`) REFERENCES `site` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `texTemplate`
--

LOCK TABLES `texTemplate` WRITE;
/*!40000 ALTER TABLE `texTemplate` DISABLE KEYS */;
INSERT INTO `texTemplate` VALUES (1,NULL,'Standard (Grünes CI)','\\documentclass[paper=a4, 11pt, pagesize, parskip=half, DIV=calc]{scrartcl}\r\n\\usepackage[T1]{fontenc}\r\n\\usepackage{lmodern}\r\n\\usepackage[%LANGUAGE%]{babel}\r\n\\usepackage{fixltx2e}\r\n\\usepackage{lineno}\r\n\\usepackage{tabularx}\r\n\\usepackage{scrpage2}\r\n\\usepackage[normalem]{ulem}\r\n\\usepackage[right]{eurosym}\r\n\\usepackage{fontspec}\r\n\\usepackage{geometry}\r\n\\usepackage{color}\r\n\\usepackage{lastpage}\r\n\\usepackage[normalem]{ulem}\r\n\\usepackage{hyperref}\r\n\\usepackage{wrapfig}\r\n\\usepackage{enumitem}\r\n\\usepackage{graphicx}\r\n\\usepackage{pdfpages}\r\n\\usepackage[export]{adjustbox}\r\n\r\n\\newfontfamily\\ArvoGruen[\r\n  Path=%ASSETROOT%Arvo/\r\n]{Arvo_Gruen_1004.otf}\r\n\\newfontfamily\\ArvoRegular[\r\n  Path=%ASSETROOT%Arvo/\r\n]{Arvo-Regular_v104.ttf}\r\n\\newfontfamily\\AntragsgruenSection[\r\n  Path=%ASSETROOT%Arvo/\r\n]{Arvo-Regular_v104.ttf}\r\n\\setmainfont[\r\n  Path=%ASSETROOT%PT-Sans/,\r\n  BoldFont=PTS75F.ttf,\r\n  ItalicFont=PTS56F.ttf,\r\n  BoldItalicFont=PTS76F.ttf\r\n]{PTS55F.ttf}\r\n\r\n\\definecolor{Insert}{rgb}{0,0.6,0}\r\n\\definecolor{Delete}{rgb}{1,0,0}\r\n\r\n\\hypersetup{\r\n    colorlinks=true,\r\n    linkcolor=blue,\r\n    filecolor=blue,      \r\n    urlcolor=blue,\r\n} \r\n\\urlstyle{same}\r\n\r\n\\title{%TITLE%}\r\n\\author{%AUTHOR%}\r\n\\geometry{a4paper, portrait, top=10mm, left=20mm, right=15mm, bottom=25mm, includehead=true}\r\n\r\n\\pagestyle{scrheadings}\r\n\\clearscrheadfoot\r\n\\renewcommand\\sectionmark[1]{\\markright{\\MakeMarkcase {\\hskip .5em\\relax#1}}}\r\n\\setcounter{secnumdepth}{0}\r\n\r\n\\newcommand\\invisiblesection[1]{%\r\n  \\refstepcounter{section}%\r\n  \\addcontentsline{toc}{section}{\\protect\\numberline{\\thesection}#1}%\r\n  \\sectionmark{#1}\r\n}\r\n\r\n\\ohead{\\ArvoRegular \\footnotesize \\rightmark}\r\n\\ofoot{\\ArvoRegular \\footnotesize Seite \\thepage\\\r\n% / \\pageref{LastPage}\r\n}\r\n\\setheadsepline{0.4pt}\r\n\\setfootsepline{0.4pt}\r\n\r\n\\begin{document}\r\n\r\n\\shorthandoff{\"}\r\n\\sloppy\r\n\\hyphenpenalty=10000\r\n\\hbadness=10000\r\n\r\n%CONTENT%\r\n\r\n\\end{document}','\\setcounter{page}{1}\r\n\\thispagestyle{empty}\r\n\r\n\\vspace*{-25mm}\r\n\\begin{flushright}\r\n \\ArvoRegular\r\n \\small\r\n \\textbf{\\normalsize %INTRODUCTION_BIG%}\\\\\r\n %INTRODUCTION_SMALL%\r\n\\end{flushright}\r\n\r\n\\begin{tabularx}{\\textwidth}{|lX|}\r\n    \\cline{1-2}\r\n    \\ArvoGruen\r\n&                               \\\\\r\n    \\multicolumn{2}{|l|}{\r\n    \\parbox{17cm}{\\raggedright\\textbf{\\LARGE %TITLEPREFIX%} %TITLE%      }} \\\\\r\n                                                            &                               \\\\\r\n    %MOTION_DATA_TABLE%\r\n                                                            &                               \\\\\r\n    \\cline{1-2}\r\n\\end{tabularx}\r\n\\vspace{4mm}\r\n\r\n\\invisiblesection{\\ArvoRegular %TITLE_LONG%}\r\n\r\n%TEXT%\r\n'),(2,NULL,'Ohne Zeilennummern','\\documentclass[paper=a4, 11pt, pagesize, parskip=half, DIV=calc]{scrartcl}\r\n\\usepackage[T1]{fontenc}\r\n\\usepackage{lmodern}\r\n\\usepackage[%LANGUAGE%]{babel}\r\n\\usepackage{fixltx2e}\r\n\\usepackage{lineno}\r\n\\usepackage{tabularx}\r\n\\usepackage{scrpage2}\r\n\\usepackage[normalem]{ulem}\r\n\\usepackage[right]{eurosym}\r\n\\usepackage{fontspec}\r\n\\usepackage{geometry}\r\n\\usepackage{color}\r\n\\usepackage{lastpage}\r\n\\usepackage[normalem]{ulem}\r\n\\usepackage{hyperref}\r\n\\usepackage{wrapfig}\r\n\\usepackage{enumitem}\r\n\\usepackage{graphicx}\r\n\\usepackage{pdfpages}\r\n\\usepackage[export]{adjustbox}\r\n\r\n\\newfontfamily\\ArvoGruen[\r\n  Path=%ASSETROOT%Arvo/\r\n]{Arvo_Gruen_1004.otf}\r\n\\newfontfamily\\ArvoRegular[\r\n  Path=%ASSETROOT%Arvo/\r\n]{Arvo-Regular_v104.ttf}\r\n\\newfontfamily\\AntragsgruenSection[\r\n  Path=%ASSETROOT%Arvo/\r\n]{Arvo-Regular_v104.ttf}\r\n\\setmainfont[\r\n  Path=%ASSETROOT%PT-Sans/,\r\n  BoldFont=PTS75F.ttf,\r\n  ItalicFont=PTS56F.ttf,\r\n  BoldItalicFont=PTS76F.ttf\r\n]{PTS55F.ttf}\r\n\r\n\\definecolor{Insert}{rgb}{0,0.6,0}\r\n\\definecolor{Delete}{rgb}{1,0,0}\r\n\r\n\\hypersetup{\r\n    colorlinks=true,\r\n    linkcolor=blue,\r\n    filecolor=blue,      \r\n    urlcolor=blue,\r\n} \r\n\\urlstyle{same}\r\n\r\n\\title{%TITLE%}\r\n\\author{%AUTHOR%}\r\n\\geometry{a4paper, portrait, top=10mm, left=20mm, right=15mm, bottom=25mm, includehead=true}\r\n\r\n\\pagestyle{scrheadings}\r\n\\clearscrheadfoot\r\n\\renewcommand\\sectionmark[1]{\\markright{\\MakeMarkcase {\\hskip .5em\\relax#1}}}\r\n\\setcounter{secnumdepth}{0}\r\n\r\n\\newcommand\\invisiblesection[1]{%\r\n  \\refstepcounter{section}%\r\n  \\addcontentsline{toc}{section}{\\protect\\numberline{\\thesection}#1}%\r\n  \\sectionmark{#1}\r\n}\r\n\r\n\\ohead{\\ArvoRegular \\footnotesize \\rightmark}\r\n\\setheadsepline{0.4pt}\r\n\\setfootsepline{0.4pt}\r\n\r\n\\begin{document}\r\n\r\n\\shorthandoff{\"}\r\n\\sloppy\r\n\\hyphenpenalty=10000\r\n\\hbadness=10000\r\n\r\n%CONTENT%\r\n\r\n\\end{document}','\\setcounter{page}{1}\r\n\\thispagestyle{empty}\r\n\r\n\\vspace*{-25mm}\r\n\\begin{flushright}\r\n \\ArvoRegular\r\n \\small\r\n \\textbf{\\normalsize %INTRODUCTION_BIG%}\\\\\r\n %INTRODUCTION_SMALL%\r\n\\end{flushright}\r\n\r\n\\begin{tabularx}{\\textwidth}{|lX|}\r\n    \\cline{1-2}\r\n    \\ArvoGruen\r\n&                               \\\\\r\n    \\multicolumn{2}{|l|}{\r\n    \\parbox{17cm}{\\raggedright\\textbf{\\LARGE %TITLEPREFIX%} %TITLE%      }} \\\\\r\n                                                            &                               \\\\\r\n    %MOTION_DATA_TABLE%\r\n                                                            &                               \\\\\r\n    \\cline{1-2}\r\n\\end{tabularx}\r\n\\vspace{4mm}\r\n\r\n\\invisiblesection{\\ArvoRegular %TITLE_LONG%}\r\n\r\n%TEXT%\r\n'),(3,NULL,'Bewerbungen','\\documentclass[paper=a4, 11pt, pagesize, parskip=half, DIV=calc]{scrartcl}\r\n\\usepackage[T1]{fontenc}\r\n\\usepackage{lmodern}\r\n\\usepackage[%LANGUAGE%]{babel}\r\n\\usepackage{fixltx2e}\r\n\\usepackage{ragged2e}\r\n\\usepackage{lineno}\r\n\\usepackage{tabularx}\r\n\\usepackage{scrpage2}\r\n\\usepackage[normalem]{ulem}\r\n\\usepackage[right]{eurosym}\r\n\\usepackage{fontspec}\r\n\\usepackage{geometry}\r\n\\usepackage{color}\r\n\\usepackage{lastpage}\r\n\\usepackage[normalem]{ulem}\r\n\\usepackage{hyperref}\r\n\\usepackage{wrapfig}\r\n\\usepackage{enumitem}\r\n\\usepackage{graphicx}\r\n\\usepackage[export]{adjustbox}\r\n\\usepackage{pdfpages}\r\n\r\n\\newfontfamily\\ArvoGruen[\r\n  Path=%ASSETROOT%Arvo/\r\n]{Arvo_Gruen_1004.otf}\r\n\\newfontfamily\\ArvoRegular[\r\n  Path=%ASSETROOT%Arvo/\r\n]{Arvo-Regular_v104.ttf}\r\n\\newfontfamily\\AntragsgruenSection[\r\n  Path=%ASSETROOT%Arvo/\r\n]{Arvo-Regular_v104.ttf}\r\n\\setmainfont[\r\n  Path=%ASSETROOT%PT-Sans/,\r\n  BoldFont=PTS75F.ttf,\r\n  ItalicFont=PTS56F.ttf,\r\n  BoldItalicFont=PTS76F.ttf\r\n]{PTS55F.ttf}\r\n\r\n\\definecolor{Insert}{rgb}{0,0.6,0}\r\n\\definecolor{Delete}{rgb}{1,0,0}\r\n\r\n\\hypersetup{\r\n    colorlinks=true,\r\n    linkcolor=blue,\r\n    filecolor=blue,      \r\n    urlcolor=blue,\r\n} \r\n\\urlstyle{same}\r\n\r\n\\title{%TITLE%}\r\n\\author{%AUTHOR%}\r\n\\geometry{a4paper, portrait, top=10mm, left=20mm, right=15mm, bottom=25mm, includehead=true}\r\n\r\n\\pagestyle{scrheadings}\r\n\\clearscrheadfoot\r\n\\renewcommand\\sectionmark[1]{\\markright{\\MakeMarkcase {\\hskip .5em\\relax#1}}}\r\n\\setcounter{secnumdepth}{0}\r\n\r\n\\newcommand\\invisiblesection[1]{%\r\n  \\refstepcounter{section}%\r\n  \\addcontentsline{toc}{section}{\\protect\\numberline{\\thesection}#1}%\r\n  \\sectionmark{#1}\r\n}\r\n\r\n\\ohead{\\ArvoRegular \\footnotesize \\rightmark}\r\n\\ofoot{\\ArvoRegular \\footnotesize Seite \\thepage\\\r\n% / \\pageref{LastPage}\r\n}\r\n\\setheadsepline{0.4pt}\r\n\\setfootsepline{0.4pt}\r\n\r\n\\begin{document}\r\n\r\n\\shorthandoff{\"}\r\n\\sloppy\r\n\\hyphenpenalty=10000\r\n\\hbadness=10000\r\n\r\n%CONTENT%\r\n\r\n\\end{document}','\\setcounter{page}{1}\r\n\\thispagestyle{empty}\r\n\r\n\\vspace*{-25mm}\r\n\\begin{flushright}\r\n \\ArvoRegular\r\n \\small\r\n \\textbf{\\normalsize %INTRODUCTION_BIG%}\\\\\r\n %INTRODUCTION_SMALL%\r\n\\end{flushright}\r\n\r\n\\setlength{\\fboxrule}{0.01em}\r\n\\setlength{\\fboxsep}{0.5em}\r\n\\fbox{\\begin{minipage}{\\dimexpr\\textwidth-2\\fboxsep-2\\fboxrule\\relax}\r\n\\vspace{0.2cm}\r\n\r\n\\begin{tabular}{p{4cm}>{\\RaggedLeft\\arraybackslash}p{12.2cm}}\r\n\\textbf{\\LARGE %TITLEPREFIX%} & \\textbf{\\LARGE %TITLE_RAW%}\r\n\\end{tabular}\r\n\r\n\\vspace{0.4cm}\r\n\r\n\\begin{tabular}{p{4cm}>{\\RaggedRight\\arraybackslash}p{12.2cm}}\r\n\\textbf{%APP_TITLE%} \\\\\r\n%APP_TOP_LABEL% & %APP_TOP%\r\n\\end{tabular}\r\n\r\n\\vspace{0.2cm}\r\n\\end{minipage}}\r\n\\vspace{4mm}\r\n\r\n\\invisiblesection{\\ArvoRegular %TITLE_LONG%}\r\n\r\n%TEXT%\r\n'),(4,NULL,'NEOS','\\documentclass[paper=a4, 12pt, pagesize, parskip=half, DIV=calc]{scrartcl}\r\n\\usepackage[T1]{fontenc}\r\n\\usepackage{lmodern}\r\n\\usepackage[%LANGUAGE%]{babel}\r\n\\usepackage{fixltx2e}\r\n\\usepackage{lineno}\r\n\\usepackage{tabularx}\r\n\\usepackage{scrpage2}\r\n\\usepackage[normalem]{ulem}\r\n\\usepackage[right]{eurosym}\r\n\\usepackage{fontspec}\r\n\\usepackage{geometry}\r\n\\usepackage{color}\r\n\\usepackage{lastpage}\r\n\\usepackage[normalem]{ulem}\r\n\\usepackage{hyperref}\r\n\\usepackage{wrapfig}\r\n\\usepackage{enumitem}\r\n\\usepackage{graphicx}\r\n\\usepackage{pdfpages}\r\n\\usepackage[export]{adjustbox}\r\n\r\n\\newfontfamily\\ArvoGruen[\r\n  Path=%PLUGINROOT%neos/assets/montserrat/\r\n]{Montserrat-Black.ttf}\r\n\\newfontfamily\\ArvoRegular[\r\n  Path=%PLUGINROOT%neos/assets/montserrat/\r\n]{Montserrat-Regular.ttf}\r\n\\newfontfamily\\AntragsgruenSection[\r\n  Path=%PLUGINROOT%neos/assets/montserrat/\r\n]{Montserrat-Bold.ttf}\r\n\\setmainfont[\r\n  Path=%PLUGINROOT%neos/assets/source-sans-pro/,\r\n  BoldFont=SourceSerifPro-Bold.ttf,\r\n  ItalicFont=SourceSerifPro-It.ttf,\r\n  BoldItalicFont=SourceSerifPro-BoldIt.ttf\r\n]{SourceSerifPro-Regular.ttf}\r\n\r\n\\definecolor{Insert}{rgb}{0,0.6,0}\r\n\\definecolor{Delete}{rgb}{1,0,0}\r\n\r\n\\hypersetup{\r\n    colorlinks=true,\r\n    linkcolor=blue,\r\n    filecolor=blue,\r\n    urlcolor=blue,\r\n}\r\n\\urlstyle{same}\r\n\r\n\\title{%TITLE%}\r\n\\author{%AUTHOR%}\r\n\\geometry{a4paper, portrait, top=20mm, left=20mm, right=20mm, bottom=25mm, includehead=true}\r\n\r\n\\pagestyle{scrheadings}\r\n\\clearscrheadfoot\r\n\\renewcommand\\sectionmark[1]{\\markright{\\MakeMarkcase {\\hskip .5em\\relax#1}}}\r\n\\setcounter{secnumdepth}{0}\r\n\r\n\\newcommand\\invisiblesection[1]{%\r\n  \\refstepcounter{section}%\r\n  \\addcontentsline{toc}{section}{\\protect\\numberline{\\thesection}#1}%\r\n  \\sectionmark{#1}\r\n}\r\n\r\n\\begin{document}\r\n\r\n\\shorthandoff{\"}\r\n\\sloppy\r\n\\hyphenpenalty=10000\r\n\\hbadness=10000\r\n\r\n%CONTENT%\r\n\r\n\\end{document}','\\setcounter{page}{1}\r\n\\thispagestyle{scrheadings}\r\n\\clearscrheadfoot\r\n\\setheadsepline{0pt}\r\n\\setfootsepline{0.4pt}\r\n\\ohead{}\r\n\\ofoot{\\ArvoRegular \\footnotesize %PUBLICATION_DATE%}\r\n\\cfoot{\\ArvoRegular \\footnotesize %PAGE_LABEL% \\thepage \\\r\n/ {\\hypersetup{linkcolor=black}\\pageref{LastPage}}}\r\n\\ifoot{\\ArvoRegular \\footnotesize A1}\r\n\r\n\r\n\\vspace*{-25mm}\r\n\\begin{flushright}\r\n %LOGO%\r\n\\end{flushright}\r\n\r\n\\vspace*{-2mm}\r\n\\hrulefill\r\n\\vspace*{2mm}\r\n\r\n\\invisiblesection{\\ArvoRegular %TITLE_LONG%}\r\n\\begin{center}\\AntragsgruenSection %MOTION_TYPE%\\end{center}\r\n\r\n\\raggedright\r\n%INITIATOR_LABEL%: \\textbf{%AUTHOR%} \\linebreak\r\n\\linebreak\r\n%TITLE_LABEL%: \\textbf{%TITLE%} \\linebreak\r\n\r\n%TEXT%\r\n');
/*!40000 ALTER TABLE `texTemplate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` text NOT NULL,
  `nameGiven` text DEFAULT NULL,
  `nameFamily` text DEFAULT NULL,
  `organization` text DEFAULT NULL,
  `organizationIds` text DEFAULT NULL,
  `fixedData` tinyint(4) DEFAULT 0,
  `email` varchar(200) DEFAULT NULL,
  `emailConfirmed` tinyint(4) DEFAULT 0,
  `auth` varchar(190) DEFAULT NULL,
  `dateCreation` timestamp NOT NULL DEFAULT current_timestamp(),
  `status` tinyint(4) NOT NULL,
  `pwdEnc` varchar(100) DEFAULT NULL,
  `authKey` binary(100) NOT NULL,
  `recoveryToken` varchar(100) DEFAULT NULL,
  `recoveryAt` timestamp NULL DEFAULT NULL,
  `emailChange` varchar(255) DEFAULT NULL,
  `emailChangeAt` timestamp NULL DEFAULT NULL,
  `settings` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_UNIQUE` (`auth`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'',NULL,NULL,NULL,'',0,'admin@wir2020.local',1,'email:admin@wir2020.local','2020-12-20 11:40:56',0,'$2y$10$BBK6Gw/S/BUnUf3adoCcreZdKCNE7uTJaqqjab6T46caxis2f01m.','4GALeJ3tYxvA_pnbsvDlz9yJ2n3UoUca\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `userNotification`
--

DROP TABLE IF EXISTS `userNotification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `userNotification` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `consultationId` int(11) DEFAULT NULL,
  `notificationType` smallint(6) NOT NULL,
  `notificationReferenceId` int(11) DEFAULT NULL,
  `settings` text DEFAULT NULL,
  `lastNotification` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `userId` (`userId`),
  KEY `consultationId` (`consultationId`,`notificationType`,`notificationReferenceId`),
  CONSTRAINT `userNotification_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `user` (`id`),
  CONSTRAINT `userNotification_ibfk_2` FOREIGN KEY (`consultationId`) REFERENCES `consultation` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userNotification`
--

LOCK TABLES `userNotification` WRITE;
/*!40000 ALTER TABLE `userNotification` DISABLE KEYS */;
INSERT INTO `userNotification` VALUES (1,1,1,3,NULL,NULL,NULL);
/*!40000 ALTER TABLE `userNotification` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `votingBlock`
--

DROP TABLE IF EXISTS `votingBlock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `votingBlock` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `consultationId` int(11) NOT NULL,
  `title` varchar(150) NOT NULL,
  `votingStatus` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_voting_block_consultation` (`consultationId`),
  CONSTRAINT `fk_voting_block_consultation` FOREIGN KEY (`consultationId`) REFERENCES `consultation` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `votingBlock`
--

LOCK TABLES `votingBlock` WRITE;
/*!40000 ALTER TABLE `votingBlock` DISABLE KEYS */;
/*!40000 ALTER TABLE `votingBlock` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-12-20 11:58:12
