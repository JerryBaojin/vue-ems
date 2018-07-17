--
-- MySQL database dump
-- Created by DbManage class, Power By yanue. 
-- http://yanue.net 
--
-- 主机: 192.168.20.104
-- 生成日期: 2018 年  07 月 16 日 18:32
-- MySQL版本: 5.7.19-log
-- PHP 版本: 5.6.27

--
-- 数据库: `datijw`
--

-- -------------------------------------------------------

--
-- 表的结构admin
--

DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `id` int(15) NOT NULL AUTO_INCREMENT,
  `counter` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  `role` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  `phone` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  `rTime` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

--
-- 转存表中的数据 admin
--

INSERT INTO `admin` VALUES('1','admin','SA','13981122915','2018-06-28 09:10:08');
--
-- 表的结构dati_record
--

DROP TABLE IF EXISTS `dati_record`;
CREATE TABLE `dati_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `openid` varchar(50) COLLATE utf8mb4_bin NOT NULL,
  `Qid` varchar(255) COLLATE utf8mb4_bin DEFAULT '0' COMMENT '暂时未用',
  `times` int(30) NOT NULL,
  `counts` int(11) NOT NULL DEFAULT '0',
  `type` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT '//对应每个用户的唯一标志',
  `scores` smallint(6) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `openid,times,uid` (`openid`,`times`,`uid`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=179 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

--
-- 转存表中的数据 dati_record
--

INSERT INTO `dati_record` VALUES('173','oOpIJw6OWG7yvqeYmGrl7f22wHoo','0','1531446404','11','single','1','105');
INSERT INTO `dati_record` VALUES('174','oOpIJw6OWG7yvqeYmGrl7f22wHoo','0','1531726161','11','single','1','0');
INSERT INTO `dati_record` VALUES('175','oOpIJw6OWG7yvqeYmGrl7f22wHoo','0','1531729319','11','single','1','0');
INSERT INTO `dati_record` VALUES('176','oOpIJw6OWG7yvqeYmGrl7f22wHoo','0','1531729660','11','single','1','0');
INSERT INTO `dati_record` VALUES('177','oOpIJw6OWG7yvqeYmGrl7f22wHoo','0','1531730499','11','single','1','0');
INSERT INTO `dati_record` VALUES('178','oOpIJw6OWG7yvqeYmGrl7f22wHoo','0','1531731438','11','single','1','20');
--
-- 表的结构log
--

DROP TABLE IF EXISTS `log`;
CREATE TABLE `log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user` varchar(255) DEFAULT NULL,
  `action` varchar(255) DEFAULT NULL,
  `time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=96 DEFAULT CHARSET=utf8mb4;

--
-- 转存表中的数据 log
--

INSERT INTO `log` VALUES('81','admin','登录系统!','2018-07-13 09:51:46');
INSERT INTO `log` VALUES('82','admin','备份数据库','2018-07-16 15:26:24');
INSERT INTO `log` VALUES('83','admin','修改了系统通用设置','2018-07-16 15:29:11');
INSERT INTO `log` VALUES('84','admin','登录系统!','2018-07-16 16:14:27');
INSERT INTO `log` VALUES('85','admin','登录系统!','2018-07-16 16:25:35');
INSERT INTO `log` VALUES('86','admin','登录系统!','2018-07-16 17:20:49');
INSERT INTO `log` VALUES('87','admin','删除了用户','2018-07-16 17:43:06');
INSERT INTO `log` VALUES('88','admin','删除了Array用户','2018-07-16 17:48:46');
INSERT INTO `log` VALUES('89','admin','删除了delete from table_user where id in(6)用户','2018-07-16 17:52:04');
INSERT INTO `log` VALUES('90','admin','删除了delete from table_user where id in(7)用户','2018-07-16 17:53:54');
INSERT INTO `log` VALUES('91','admin','删除了delete from table_user where id in(8)用户','2018-07-16 18:04:38');
INSERT INTO `log` VALUES('92','admin','删除了delete from table_user where id in(9)用户','2018-07-16 18:12:37');
INSERT INTO `log` VALUES('93','admin','删除了delete from table_user where id in(10)用户','2018-07-16 18:13:14');
INSERT INTO `log` VALUES('94','admin','删除了11用户','2018-07-16 18:29:54');
INSERT INTO `log` VALUES('95','admin','备份数据库','2018-07-16 18:32:14');
--
-- 表的结构moduletest
--

DROP TABLE IF EXISTS `moduletest`;
CREATE TABLE `moduletest` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `combine` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `perconunter` smallint(6) DEFAULT NULL,
  `sysstatus` varchar(6) COLLATE utf8mb4_bin DEFAULT NULL,
  `timu` smallint(6) DEFAULT NULL,
  `type` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `types` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `qType` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `period` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

--
-- 转存表中的数据 moduletest
--

INSERT INTO `moduletest` VALUES('1','random','10','关闭','5','每日一测','{\"single\":8,\"muti\":1,\"judge\":1}','十九大','[1528300800000,1529078400000]');
--
-- 表的结构quiz
--

DROP TABLE IF EXISTS `quiz`;
CREATE TABLE `quiz` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `question` varchar(100) NOT NULL,
  `answer` longtext NOT NULL,
  `correct` varchar(20) NOT NULL,
  `isChecked` tinyint(4) NOT NULL DEFAULT '0',
  `picked` int(11) DEFAULT '0',
  `rates` int(11) DEFAULT '0',
  `qType` varchar(255) NOT NULL DEFAULT '0',
  `types` varchar(15) NOT NULL DEFAULT 'single',
  PRIMARY KEY (`id`),
  KEY `qType` (`qType`) USING BTREE,
  KEY `types` (`types`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=869 DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 quiz
--

INSERT INTO `quiz` VALUES('823','创卫标准要求小美容美（理）发店营业面积不小于多少平方米？','###A.10平方米###B.15平方米###C.20平方米','B','0','0','0','创卫','single');
INSERT INTO `quiz` VALUES('824','创卫标准要求小美容美（理）发店营业面积不小于多少平方米？','###A.10平方米###B.15平方米###C.210平方米###D.2110平方米###E.2011平方米','B','0','0','0','创卫','single');
INSERT INTO `quiz` VALUES('825','创卫标准要求小美容美（理）发店营业面积不小于多少平方米？','###A.10平方米###B.15平方米###C.20平方米###D.20平方米###E.20平方米','B','0','0','0','创卫','single');
INSERT INTO `quiz` VALUES('826','创卫标准要求小美容美（理）发店营业面积不小于多少平方米？','###A.10平方米###B.15平方米###C.20平方米###D.20平方米###E.20平方米','B','0','0','0','创卫','single');
INSERT INTO `quiz` VALUES('827','创卫标准要求小美容美（理）发店营业面积不小于多少平方米？','###A.10平方米###B.15平方米###C.20平方米###D.20平方米###E.20平方米','B','0','0','0','创卫','single');
INSERT INTO `quiz` VALUES('828','创卫标准要求小美容美（理）发店营业面积不小于多少平方米？','###A.10平方米###B.15平方米###C.20平方米###D.20平方米###E.20平方米','B','0','0','0','创卫','single');
INSERT INTO `quiz` VALUES('829','创卫标准要求小美容美（理）发店营业面积不小于多少平方米？','###A.10平方米###B.15平方米###C.20平方米###D.20平方米###E.20平方米','B','0','0','0','创卫','single');
INSERT INTO `quiz` VALUES('830','创卫标准要求小美容美（理）发店营业面积不小于多少平方米？','###A.10平方米###B.15平方米###C.20平方米###D.20平方米###E.20平方米','B','0','0','0','创卫','single');
INSERT INTO `quiz` VALUES('831','创卫标准要求小美容美（理）发店营业面积不小于多少平方米？','###A.10平方米###B.15平方米###C.20平方米###D.20平方米###E.20平方米','B','0','0','0','创卫','single');
INSERT INTO `quiz` VALUES('832','创卫标准要求小美容美（理）发店营业面积不小于多少平方米？','###A.10平方米###B.15平方米###C.20平方米###D.20平方米###E.20平方米','B','0','0','0','创卫','single');
INSERT INTO `quiz` VALUES('833','创卫标准要求小美容美（理）发店营业面积不小于多少平方米？','###A.10平方米###B.15平方米###C.20平方米###D.20平方米###E.20平方米','B','0','0','0','创卫','single');
INSERT INTO `quiz` VALUES('834','创卫标准要求小美容美（理）发店营业面积不小于多少平方米？','###A.10平方米###B.15平方米###C.20平方米###D.20平方米###E.20平方米','B','0','0','0','创卫','single');
INSERT INTO `quiz` VALUES('835','创卫标准要求小美容美（理）发店营业面积不小于多少平方米？','###A.10平方米###B.15平方米###C.20平方米###D.20平方米###E.20平方米','B','0','0','0','创卫','single');
INSERT INTO `quiz` VALUES('836','创卫标准要求小美容美（理）发店营业面积不小于多少平方米？','###A.10平方米###B.15平方米###C.20平方米###D.20平方米###E.20平方米','B','0','0','0','创卫','single');
INSERT INTO `quiz` VALUES('837','创卫标准要求小美容美（理）发店营业面积不小于多少平方米？','###A.10平方米###B.15平方米###C.20平方米###D.20平方米###E.20平方米','B','0','0','0','创卫','single');
INSERT INTO `quiz` VALUES('838','创卫标准要求小美容美（理）发店营业面积不小于多少平方米？','###A.10平方米###B.15平方米###C.20平方米###D.20平方米###E.20平方米','B','0','0','0','创卫','single');
INSERT INTO `quiz` VALUES('839','创卫标准要求小美容美（理）发店营业面积不小于多少平方米？','###A.10平方米###B.15平方米###C.20平方米###D.20平方米###E.20平方米','B','0','0','0','创卫','single');
INSERT INTO `quiz` VALUES('844','创卫标准要求小美容美（理）发店营业面积不小于多少平方米？','###A.10平方米###B.15平方米###C.20平方米###D.20平方米###E.20平方米','B','0','0','0','创卫','single');
--
-- 表的结构scores_config
--

DROP TABLE IF EXISTS `scores_config`;
CREATE TABLE `scores_config` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `socres_lv` varchar(255) DEFAULT NULL,
  `socres_name` varchar(255) DEFAULT NULL,
  `socres_headPic` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

--
-- 转存表中的数据 scores_config
--

INSERT INTO `scores_config` VALUES('1','[\"100\",\"300\",\"600\",\"900\"]','[\"初级学童\",\"优秀学生\",\"三好学生\",\"至尊学霸\"]','{\"lv1\":\"api/upload/img/5b3b41b599936.jpg\",\"lv2\":\"api/upload/img/5b3b480280b47.jpg\",\"lv3\":\"api/upload/img/5b42c6fdf3929.jpg\",\"lv4\":\"api/upload/img/5b45c992f363e.jpg\"}');
--
-- 表的结构scores_month
--

DROP TABLE IF EXISTS `scores_month`;
CREATE TABLE `scores_month` (
  `id` int(255) NOT NULL AUTO_INCREMENT,
  `month` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `scoress` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `UID` bigint(13) NOT NULL DEFAULT '0',
  `rank` int(11) NOT NULL DEFAULT '0',
  `countQ` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `UID` (`UID`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

--
-- 转存表中的数据 scores_month
--

INSERT INTO `scores_month` VALUES('1','2017-4','50','1','0','0');
--
-- 表的结构sysconfig
--

DROP TABLE IF EXISTS `sysconfig`;
CREATE TABLE `sysconfig` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `combine` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `conunter` smallint(6) DEFAULT NULL,
  `perconunter` smallint(6) DEFAULT NULL,
  `sysstatus` varchar(6) COLLATE utf8mb4_bin DEFAULT NULL,
  `timu` smallint(6) DEFAULT NULL,
  `type` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `filter` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `types` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `shareDesc` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `shareImage` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `shareLink` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `qType` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `period` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `ScoresConfig` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

--
-- 转存表中的数据 sysconfig
--

INSERT INTO `sysconfig` VALUES('1','random','30','30','开启','11','每日一测','a,2,515,','{\"single\":5,\"muti\":13,\"judge\":1}','desc','http://img5.imgtn.bdimg.com/it/u=1055545886,930296925&fm=27&gp=0.jpg','http://www.baidu.com','创卫','[1530547200000,1532966400000]','{\"single\":10,\"muti\":10,\"judge\":10}');
--
-- 表的结构table_user
--

DROP TABLE IF EXISTS `table_user`;
CREATE TABLE `table_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `UID` int(11) NOT NULL DEFAULT '0',
  `name` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `scores` int(255) DEFAULT '0' COMMENT '默认2分',
  `counts` int(11) NOT NULL DEFAULT '0',
  `levelImg` varchar(255) COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `phone` bigint(13) DEFAULT NULL,
  `level` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `type` tinyint(4) NOT NULL DEFAULT '0',
  `role` tinyint(4) NOT NULL DEFAULT '0' COMMENT '0->外部人员',
  `dirName` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `workUnit` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `InTime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `phone` (`phone`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

--
-- 转存表中的数据 table_user
--

INSERT INTO `table_user` VALUES('1','1','','125','66','api/upload/img/5b3b41b599936.jpg','13981122915','初级学童2级','0','0','大漠穷秋','','2018-07-13 09:43:09');
--
-- 表的结构users
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `oid` int(25) NOT NULL AUTO_INCREMENT,
  `nickname` varchar(255) NOT NULL,
  `openid` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `headImg` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `RegistTime` datetime DEFAULT NULL,
  `uid` bigint(13) NOT NULL DEFAULT '0' COMMENT '//对于table_user表中的UID，0对应社会用户',
  `IP` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`oid`),
  UNIQUE KEY `openid` (`openid`) USING BTREE,
  KEY `UID` (`uid`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

--
-- 转存表中的数据 users
--

INSERT INTO `users` VALUES('1','Jerry?','oOpIJw6OWG7yvqeYmGrl7f22wHoo','http://thirdwx.qlogo.cn/mmopen/Y7JA4wbmYX6sjGlMtDBjuGPKeeu7yYe9MBxvMs3RyHewE7CSwNkiaBRDMfJGnA44qkOe0CTiaySqYjnYTNTSNoHicPLoeppvZEib/132','2018-07-13 09:40:29','1','{\"ip\":\"221.10.161.2\",\"addr\":{\"province\":\"四川省\",\"city\":\"内江市\"}}');
