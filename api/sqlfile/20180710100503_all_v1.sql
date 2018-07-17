--
-- MySQL database dump
-- Created by DbManage class, Power By yanue. 
-- http://yanue.net 
--
-- 主机: localhost
-- 生成日期: 2018 年  07 月 10 日 10:05
-- MySQL版本: 5.5.53
-- PHP 版本: 5.6.27

--
-- 数据库: `fapai`
--

-- -------------------------------------------------------

--
-- 表的结构collection
--

DROP TABLE IF EXISTS `collection`;
CREATE TABLE `collection` (
  `CID` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `UID` bigint(20) unsigned NOT NULL,
  `HID` bigint(20) unsigned NOT NULL,
  `Time` datetime DEFAULT NULL,
  PRIMARY KEY (`CID`),
  KEY `FK_Reference_11` (`UID`),
  KEY `FK_Reference_12` (`HID`),
  CONSTRAINT `FK_Reference_11` FOREIGN KEY (`UID`) REFERENCES `user` (`UID`),
  CONSTRAINT `FK_Reference_12` FOREIGN KEY (`HID`) REFERENCES `house` (`HID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 collection
--

INSERT INTO `collection` VALUES('2','1','1','2018-04-08 00:00:00');
--
-- 表的结构house
--

DROP TABLE IF EXISTS `house`;
CREATE TABLE `house` (
  `HID` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `Title` char(250) NOT NULL,
  `Money` double(20,2) NOT NULL,
  `Layout` char(250) NOT NULL,
  `Area` double(20,8) NOT NULL,
  `Address` char(250) NOT NULL,
  `Detail` varchar(1000) NOT NULL,
  `Orientation` char(250) NOT NULL,
  `Province` char(250) NOT NULL,
  `City` char(250) NOT NULL,
  `District` char(250) NOT NULL,
  `FinishDate` date NOT NULL,
  `Floor` char(250) NOT NULL,
  `Location` char(250) NOT NULL,
  `Status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '-1已删除1正常0待审',
  `Process` tinyint(1) NOT NULL DEFAULT '0',
  `StartPrice` double(20,2) NOT NULL,
  `FarePrice` double(20,2) NOT NULL,
  `AssessmentPrice` double(20,2) NOT NULL,
  `StartDate` date NOT NULL,
  `AssessmentDepartment` char(250) NOT NULL,
  `AssessmentDate` date NOT NULL,
  `CUID` bigint(20) unsigned NOT NULL,
  `CTime` datetime NOT NULL,
  PRIMARY KEY (`HID`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8 COMMENT='Vue(modules,api,components)';

--
-- 转存表中的数据 house
--

INSERT INTO `house` VALUES('1','房屋1','1000.00','3-4-2','123.00000000','南部县','1','南','四川','南充','南部县','2018-03-01','12','1','1','1','13.00','5.00','43.00','2018-03-28','1','2018-04-04','1','2018-04-08 00:00:30');
INSERT INTO `house` VALUES('2','房屋2','1100.00','4-2-3','111.00000000','成都','1','北','广东','成都','成华区','2018-04-13','1','1','1','1','53.00','32.00','2.00','2018-04-19','1','2018-04-12','2','2018-04-13 00:00:30');
INSERT INTO `house` VALUES('3','房屋3','1200.00','2-3-4','100.00000000','绵阳','1','东','上海','绵阳','涪城区','2018-04-20','5','1','1','1','34.00','23.00','234.00','2018-04-20','1','2018-04-27','3','2018-04-27 00:00:30');
INSERT INTO `house` VALUES('10','四川','56.00','5-9-9','56.00000000','地址','1','东','上海','市辖区','卢湾区','2018-05-05','5','','0','0','56.00','5.00','5.00','2018-05-05','2018-05-05','2018-05-05','1','2018-04-16 20:29:29');
INSERT INTO `house` VALUES('11','四川','56.00','5-9-9','56.00000000','地址','1','东','上海','市辖区','卢湾区','2018-05-05','5','','0','0','56.00','5.00','5.00','2018-05-05','2018-05-05','2018-05-05','1','2018-04-16 20:33:57');
INSERT INTO `house` VALUES('12','名字','56.00','5-8-8','56.00000000','阿斯顿','1','东','天津','市辖区','选择区域','2018-05-05','5','','0','0','5.00','5.00','5.00','2018-05-05','5','2018-05-05','1','2018-04-17 17:19:44');
INSERT INTO `house` VALUES('13','名字','56.00','5-8-8','56.00000000','阿斯顿','1','东','天津','市辖区','选择区域','2018-05-05','5','','0','0','5.00','5.00','5.00','2018-05-05','5','2018-05-05','1','2018-04-17 17:21:36');
INSERT INTO `house` VALUES('14','名字','56.00','5-8-8','56.00000000','阿斯顿','1','东','天津','市辖区','选择区域','2018-05-05','5','','0','0','5.00','5.00','5.00','2018-05-05','5','2018-05-05','1','2018-04-17 17:26:19');
INSERT INTO `house` VALUES('15','','0.00','','0.00000000','','','东','undefined','undefined','undefined','0000-00-00','','','0','0','0.00','0.00','0.00','0000-00-00','','0000-00-00','0','2018-04-17 18:09:59');
INSERT INTO `house` VALUES('16','','0.00','','0.00000000','','','东','undefined','undefined','undefined','0000-00-00','','','0','0','0.00','0.00','0.00','0000-00-00','','0000-00-00','0','2018-04-17 18:10:20');
INSERT INTO `house` VALUES('17','','0.00','','0.00000000','','','东','undefined','undefined','undefined','0000-00-00','','','0','0','0.00','0.00','0.00','0000-00-00','','0000-00-00','0','2018-04-17 18:10:37');
INSERT INTO `house` VALUES('18','','0.00','','0.00000000','','','东','undefined','undefined','undefined','0000-00-00','','','0','0','0.00','0.00','0.00','0000-00-00','','0000-00-00','0','2018-04-17 18:10:55');
INSERT INTO `house` VALUES('19','','0.00','','0.00000000','','','东','undefined','undefined','undefined','0000-00-00','','','0','0','0.00','0.00','0.00','0000-00-00','','0000-00-00','0','2018-04-17 18:11:10');
INSERT INTO `house` VALUES('20','x','1.00','7-7-7','56.00000000','as','5','东','福建','三明市','明溪县','2018-05-05','1','','0','0','56.00','56.00','56.00','2018-05-05','5','2018-05-05','5','2018-04-17 18:12:20');
INSERT INTO `house` VALUES('21','x','1.00','7-7-7','56.00000000','as','5','东','福建','三明市','明溪县','2018-05-05','1','','0','0','56.00','56.00','56.00','2018-05-05','5','2018-05-05','5','2018-04-17 18:13:38');
INSERT INTO `house` VALUES('22','x','1.00','7-7-7','56.00000000','as','5','东','福建','三明市','明溪县','2018-05-05','1','','0','0','56.00','56.00','56.00','2018-05-05','5','2018-05-05','5','2018-04-17 18:13:50');
INSERT INTO `house` VALUES('23','x','1.00','7-7-7','56.00000000','as','5','东','福建','三明市','明溪县','2018-05-05','1','','0','0','56.00','56.00','56.00','2018-05-05','5','2018-05-05','5','2018-04-17 18:15:47');
INSERT INTO `house` VALUES('24','x','1.00','7-7-7','56.00000000','as','5','东','福建','三明市','明溪县','2018-05-05','1','','0','0','56.00','56.00','56.00','2018-05-05','5','2018-05-05','5','2018-04-17 18:19:25');
INSERT INTO `house` VALUES('25','x','1.00','7-7-7','56.00000000','as','5','东','福建','三明市','明溪县','2018-05-05','1','','0','0','56.00','56.00','56.00','2018-05-05','5','2018-05-05','5','2018-04-17 18:21:57');
INSERT INTO `house` VALUES('26','x','1.00','7-7-7','56.00000000','as','5','东','福建','三明市','明溪县','2018-05-05','1','','0','0','56.00','56.00','56.00','2018-05-05','5','2018-05-05','5','2018-04-17 18:23:12');
INSERT INTO `house` VALUES('27','56','56.00','9','56.00000000','56','2','东','北京','市辖区','东城区','2011-01-01','45','','0','0','1.00','1.00','1.00','2011-01-01','2','2011-01-01','2','2018-04-18 15:16:14');
INSERT INTO `house` VALUES('28','56','56.00','9','56.00000000','56','2','东','北京','市辖区','东城区','2011-01-01','45','','0','0','1.00','1.00','1.00','2011-01-01','2','2011-01-01','2','2018-04-18 15:20:21');
INSERT INTO `house` VALUES('29','56','56.00','9','56.00000000','56','2','东','北京','市辖区','东城区','2011-01-01','45','','0','0','1.00','1.00','1.00','2011-01-01','2','2011-01-01','2','2018-04-18 15:42:37');
INSERT INTO `house` VALUES('30','x','56.00','5-8-8','56.00000000','a','1','东','北京','市辖区','东城区','2011-01-01','5','','0','0','1.00','1.00','1.00','2011-01-01','1','2011-01-01','1','2018-04-18 19:33:57');
INSERT INTO `house` VALUES('31','x','56.00','5-8-8','56.00000000','a','1','东','北京','市辖区','东城区','2011-01-01','5','','0','0','1.00','1.00','1.00','2011-01-01','1','2011-01-01','1','2018-04-18 19:35:11');
--
-- 表的结构house_image
--

DROP TABLE IF EXISTS `house_image`;
CREATE TABLE `house_image` (
  `HIID` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `HID` bigint(20) unsigned NOT NULL,
  `IID` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`HIID`),
  KEY `FK_Reference_2` (`HID`),
  KEY `FK_Reference_1` (`IID`),
  CONSTRAINT `FK_Reference_1` FOREIGN KEY (`IID`) REFERENCES `images` (`IID`),
  CONSTRAINT `FK_Reference_2` FOREIGN KEY (`HID`) REFERENCES `house` (`HID`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 house_image
--

INSERT INTO `house_image` VALUES('3','3','3');
INSERT INTO `house_image` VALUES('4','1','2');
INSERT INTO `house_image` VALUES('6','1','3');
INSERT INTO `house_image` VALUES('7','2','1');
INSERT INTO `house_image` VALUES('8','2','3');
INSERT INTO `house_image` VALUES('9','3','1');
INSERT INTO `house_image` VALUES('10','3','2');
INSERT INTO `house_image` VALUES('11','1','4');
INSERT INTO `house_image` VALUES('12','1','5');
INSERT INTO `house_image` VALUES('13','1','6');
INSERT INTO `house_image` VALUES('14','2','4');
INSERT INTO `house_image` VALUES('15','2','5');
INSERT INTO `house_image` VALUES('16','2','6');
INSERT INTO `house_image` VALUES('17','3','4');
INSERT INTO `house_image` VALUES('18','3','5');
INSERT INTO `house_image` VALUES('19','3','6');
INSERT INTO `house_image` VALUES('24','26','15');
INSERT INTO `house_image` VALUES('25','26','16');
INSERT INTO `house_image` VALUES('26','26','17');
INSERT INTO `house_image` VALUES('27','26','18');
--
-- 表的结构images
--

DROP TABLE IF EXISTS `images`;
CREATE TABLE `images` (
  `IID` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `SavePath` char(250) NOT NULL,
  `ViewPath` char(250) NOT NULL,
  PRIMARY KEY (`IID`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 images
--

INSERT INTO `images` VALUES('1','\"1\"','http://www.houqin.swust.edu.cn/upload/201712/1512369212.jpg');
INSERT INTO `images` VALUES('2','\"2\"','http://www.houqin.swust.edu.cn/upload/201712/1512369212.jpg');
INSERT INTO `images` VALUES('3','\"3\"','http://www.houqin.swust.edu.cn/upload/201712/1512369212.jpg');
INSERT INTO `images` VALUES('4','4','http://www.houqin.swust.edu.cn/upload/201712/1512372795.jpg');
INSERT INTO `images` VALUES('5','5','http://www.houqin.swust.edu.cn/upload/201712/1512372795.jpg');
INSERT INTO `images` VALUES('6','6','http://www.houqin.swust.edu.cn/upload/201712/1512372795.jpg');
INSERT INTO `images` VALUES('15','/upload/20180417/1523960592.jpg','http://www.houqin.swust.edu.cn/upload/20180417/1523960592.jpg');
INSERT INTO `images` VALUES('16','/upload/20180417/1523960592.jpg','http://www.houqin.swust.edu.cn/upload/20180417/1523960592.jpg');
INSERT INTO `images` VALUES('17','/upload/20180417/1523960592.jpg','http://www.houqin.swust.edu.cn/upload/20180417/1523960592.jpg');
INSERT INTO `images` VALUES('18','/upload/20180417/1523960592.png','http://www.houqin.swust.edu.cn/upload/20180417/1523960592.png');
INSERT INTO `images` VALUES('19','','');
--
-- 表的结构message
--

DROP TABLE IF EXISTS `message`;
CREATE TABLE `message` (
  `MID` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `Title` char(250) NOT NULL,
  `Content` varchar(1000) NOT NULL,
  `CTime` datetime NOT NULL,
  `CUID` bigint(20) unsigned NOT NULL,
  `PicURL` char(250) NOT NULL,
  PRIMARY KEY (`MID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 message
--

INSERT INTO `message` VALUES('1','1','1','2018-04-07 23:15:27','1','https://www.linuxidc.com/upload/2014_06/140604110237132.png');
--
-- 表的结构orders
--

DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders` (
  `OID` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `PayUID` bigint(20) unsigned NOT NULL,
  `PayTime` datetime NOT NULL,
  `PayMoney` double(20,8) NOT NULL,
  `HID` bigint(20) unsigned NOT NULL,
  `PayResult` tinyint(1) NOT NULL COMMENT '0未付款1已付款-1已退款',
  `PayWay` tinyint(1) NOT NULL COMMENT '0微信1支付宝',
  `PayOrder` char(250) NOT NULL,
  PRIMARY KEY (`OID`),
  KEY `FK_Reference_15` (`PayUID`),
  KEY `FK_Reference_16` (`HID`),
  CONSTRAINT `FK_Reference_15` FOREIGN KEY (`PayUID`) REFERENCES `user` (`UID`),
  CONSTRAINT `FK_Reference_16` FOREIGN KEY (`HID`) REFERENCES `house` (`HID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 orders
--

--
-- 表的结构permission
--

DROP TABLE IF EXISTS `permission`;
CREATE TABLE `permission` (
  `PID` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `Title` char(250) NOT NULL DEFAULT '',
  `Code` char(250) NOT NULL DEFAULT '',
  PRIMARY KEY (`PID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 permission
--

--
-- 表的结构setting
--

DROP TABLE IF EXISTS `setting`;
CREATE TABLE `setting` (
  `K` char(250) NOT NULL,
  `V` char(250) NOT NULL,
  PRIMARY KEY (`K`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 setting
--

--
-- 表的结构share
--

DROP TABLE IF EXISTS `share`;
CREATE TABLE `share` (
  `SID` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `SUID` bigint(20) unsigned NOT NULL,
  `STime` datetime NOT NULL,
  `CUID` bigint(20) unsigned NOT NULL,
  `CTime` datetime NOT NULL,
  PRIMARY KEY (`SID`),
  KEY `FK_Reference_7` (`SUID`),
  KEY `FK_Reference_8` (`CUID`),
  CONSTRAINT `FK_Reference_7` FOREIGN KEY (`SUID`) REFERENCES `user` (`UID`),
  CONSTRAINT `FK_Reference_8` FOREIGN KEY (`CUID`) REFERENCES `user` (`UID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 share
--

--
-- 表的结构user
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `UID` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `Account` char(250) NOT NULL DEFAULT '',
  `PWD` char(250) NOT NULL DEFAULT '',
  `NickName` char(250) NOT NULL DEFAULT '',
  `Name` char(250) NOT NULL DEFAULT '',
  `Sex` tinyint(1) NOT NULL DEFAULT '0',
  `Tel` char(250) NOT NULL DEFAULT '',
  `Address` char(250) NOT NULL DEFAULT '',
  `Phone` char(250) NOT NULL DEFAULT '',
  `IsVerified` tinyint(1) NOT NULL DEFAULT '0',
  `Level` bigint(20) NOT NULL DEFAULT '0',
  `SUID` bigint(20) unsigned NOT NULL DEFAULT '0',
  `CTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `IDCard` char(250) NOT NULL,
  PRIMARY KEY (`UID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='Vue(modules,api,components)\r\n需要用到邀请码，邀请码生成规则为 8位邀请码，末尾是';

--
-- 转存表中的数据 user
--

INSERT INTO `user` VALUES('1','admin','e10adc3949ba59abbe56e057f20f883e','admin','admin','0','','','','0','0','0','2018-04-08 15:55:57','');
--
-- 表的结构user_group
--

DROP TABLE IF EXISTS `user_group`;
CREATE TABLE `user_group` (
  `UGID` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `Title` char(250) NOT NULL,
  PRIMARY KEY (`UGID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 user_group
--

--
-- 表的结构user_group_permission
--

DROP TABLE IF EXISTS `user_group_permission`;
CREATE TABLE `user_group_permission` (
  `UGPLID` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `UGID` bigint(20) unsigned NOT NULL,
  `PID` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`UGPLID`),
  KEY `FK_Reference_5` (`UGID`),
  KEY `FK_Reference_6` (`PID`),
  CONSTRAINT `FK_Reference_5` FOREIGN KEY (`UGID`) REFERENCES `user_group` (`UGID`),
  CONSTRAINT `FK_Reference_6` FOREIGN KEY (`PID`) REFERENCES `permission` (`PID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 user_group_permission
--

--
-- 表的结构user_group_user
--

DROP TABLE IF EXISTS `user_group_user`;
CREATE TABLE `user_group_user` (
  `UGLID` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `UID` bigint(20) unsigned NOT NULL,
  `UGID` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`UGLID`),
  KEY `FK_Reference_3` (`UID`),
  KEY `FK_Reference_4` (`UGID`),
  CONSTRAINT `FK_Reference_3` FOREIGN KEY (`UID`) REFERENCES `user` (`UID`),
  CONSTRAINT `FK_Reference_4` FOREIGN KEY (`UGID`) REFERENCES `user_group` (`UGID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 user_group_user
--

--
-- 表的结构user_message
--

DROP TABLE IF EXISTS `user_message`;
CREATE TABLE `user_message` (
  `MLID` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `MID` bigint(20) unsigned NOT NULL,
  `UID` bigint(20) unsigned NOT NULL,
  `IsRead` tinyint(1) NOT NULL,
  PRIMARY KEY (`MLID`),
  KEY `FK_Reference_17` (`MID`),
  KEY `FK_Reference_18` (`UID`),
  CONSTRAINT `FK_Reference_17` FOREIGN KEY (`MID`) REFERENCES `message` (`MID`),
  CONSTRAINT `FK_Reference_18` FOREIGN KEY (`UID`) REFERENCES `user` (`UID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 user_message
--

--
-- 表的结构view_log
--

DROP TABLE IF EXISTS `view_log`;
CREATE TABLE `view_log` (
  `VLID` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `UID` bigint(20) unsigned NOT NULL,
  `Time` datetime NOT NULL,
  `HID` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`VLID`),
  KEY `FK_Reference_13` (`UID`),
  KEY `FK_Reference_14` (`HID`),
  CONSTRAINT `FK_Reference_13` FOREIGN KEY (`UID`) REFERENCES `user` (`UID`),
  CONSTRAINT `FK_Reference_14` FOREIGN KEY (`HID`) REFERENCES `house` (`HID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 view_log
--

--
-- 表的结构wallet
--

DROP TABLE IF EXISTS `wallet`;
CREATE TABLE `wallet` (
  `UID` bigint(20) unsigned NOT NULL,
  `Balance` double(20,2) unsigned NOT NULL,
  PRIMARY KEY (`UID`),
  CONSTRAINT `FK_Reference_9` FOREIGN KEY (`UID`) REFERENCES `user` (`UID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 wallet
--

INSERT INTO `wallet` VALUES('1','4.00');
--
-- 表的结构wallet_log
--

DROP TABLE IF EXISTS `wallet_log`;
CREATE TABLE `wallet_log` (
  `WLID` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `UID` bigint(20) unsigned NOT NULL,
  `CTime` datetime NOT NULL,
  `Money` double(20,2) NOT NULL,
  `AfterMoney` double(20,2) NOT NULL,
  `Reason` char(250) NOT NULL,
  PRIMARY KEY (`WLID`),
  KEY `FK_Reference_10` (`UID`),
  CONSTRAINT `FK_Reference_10` FOREIGN KEY (`UID`) REFERENCES `user` (`UID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 wallet_log
--

