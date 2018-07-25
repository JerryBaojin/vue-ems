/*
Navicat MySQL Data Transfer

Source Server         : 104
Source Server Version : 50719
Source Host           : 192.168.20.104:3306
Source Database       : dati

Target Server Type    : MYSQL
Target Server Version : 50719
File Encoding         : 65001

Date: 2018-05-28 15:43:20
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `id` int(15) NOT NULL AUTO_INCREMENT,
  `counter` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  `role` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  `phone` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  `rTime` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES ('1', 'admin', 'SA', '13981122915', '2018-05-22 17:30:32');

-- ----------------------------
-- Table structure for dati_record
-- ----------------------------
DROP TABLE IF EXISTS `dati_record`;
CREATE TABLE `dati_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `Qid` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  `result` tinyint(4) NOT NULL DEFAULT '0',
  `times` datetime NOT NULL,
  `counts` int(11) NOT NULL DEFAULT '0',
  `type` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `uid` (`uid`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=57 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- ----------------------------
-- Records of dati_record
-- ----------------------------
INSERT INTO `dati_record` VALUES ('56', '1', '276', '1', '2018-05-18 17:57:50', '1', 'single');

-- ----------------------------
-- Table structure for quiz
-- ----------------------------
DROP TABLE IF EXISTS `quiz`;
CREATE TABLE `quiz` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `question` varchar(100) NOT NULL,
  `answer` longtext NOT NULL,
  `correct` varchar(20) NOT NULL,
  `isChecked` tinyint(4) NOT NULL DEFAULT '0',
  `picked` int(11) DEFAULT '0',
  `rates` int(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=536 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of quiz
-- ----------------------------
INSERT INTO `quiz` VALUES ('498', '创卫标准要求小美容美（理）发店营业面积不小于多少平方米？', ' ###A.10平方米###B.15平方米###C.20平方米', 'B', '0', '0', '0');
INSERT INTO `quiz` VALUES ('499', '创卫标准要求辖区内婴儿死亡率，不高于多少？', ' ###A.≤12%###B.≤15%###C.≤18%', 'A', '0', '0', '0');
INSERT INTO `quiz` VALUES ('500', '肠道门诊应在什么时间设立?', ' ###A.1-6月###B.2-7月###C.5-10月', 'C', '0', '0', '0');
INSERT INTO `quiz` VALUES ('501', '什么叫“四害”?', ' ###A.老鼠###B.蚊子###C.蟑螂', 'A,B,C', '0', '0', '0');
INSERT INTO `quiz` VALUES ('502', '鼠类可传播多少种疾病？', ' ###A.10多种###B.20多种###C.30多种', 'C', '0', '0', '0');
INSERT INTO `quiz` VALUES ('503', '老鼠分为哪几类？', ' ###A.家栖鼠###B.野栖鼠###C.褐家鼠', 'A,B', '0', '0', '0');
INSERT INTO `quiz` VALUES ('504', '创卫标准要求防鼠设施合格率是多少？', ' ###A.≥93%###B.≥92%###C.≥91%', 'A', '0', '0', '0');
INSERT INTO `quiz` VALUES ('505', '慢性鼠药中毒该注射什么救治？', ' ###A.维生素C###B.维生素B###C.维生素KI', 'C', '0', '0', '0');
INSERT INTO `quiz` VALUES ('506', '鼠类的天敌有哪些?', ' ###A.猫###B.鹰###C.蛇', 'A,B,C', '0', '0', '0');
INSERT INTO `quiz` VALUES ('507', '流行性出血热，体温在1--2日内升到多少摄氏度？', ' ###A.36℃-38℃###B.37℃-39℃###C.39℃-40℃', 'C', '0', '0', '0');
INSERT INTO `quiz` VALUES ('508', '我国由蚊子传播的主要疾病有？', ' ###A.疟疾###B.乙型脑炎###C.丝虫病', 'A,B,C', '0', '0', '0');
INSERT INTO `quiz` VALUES ('509', '餐具消毒方法有哪几种？', ' ###A.物理消毒###B.化学消毒###C.常规消毒', 'A,B', '0', '0', '0');
INSERT INTO `quiz` VALUES ('510', '依照餐饮服务单位的食品安全管理状况，动态等级分为几个等级?', ' ###A.优秀###B.良好###C.一般', 'A,B,C', '0', '0', '0');
INSERT INTO `quiz` VALUES ('511', '餐饮服务食品安全量化等级分为哪些?', ' ###A.动态等级###B.年度等级###C.季度等级', 'A,B', '0', '0', '0');
INSERT INTO `quiz` VALUES ('512', '小餐馆的厨房（包括辅助设施）面积必须不低于多少？', ' ###A.8平方米###B.9平方米###C.10平方米', 'A', '0', '0', '0');
INSERT INTO `quiz` VALUES ('513', '对餐饮业的厕所卫生标准要达到“几洁”', ' ###A.“一洁”###B.“三洁”###C.“六洁”', 'C', '0', '0', '0');
INSERT INTO `quiz` VALUES ('514', '对餐饮业的厕所卫生标准要达到“几无”', ' ###A.“一无”###B.“二无”###C.“四无”', 'C', '0', '0', '0');
INSERT INTO `quiz` VALUES ('515', '创卫标准中对生活污水集中处理率的要求是？', ' ###A.≥80%###B.≥85%###C.≥90%', 'B', '0', '0', '0');
INSERT INTO `quiz` VALUES ('516', '国家卫生城市工作中对建成区绿化率要达到多少？', ' ###A.≥36%###B.≥37%###C.≥38%', 'A', '0', '0', '0');
INSERT INTO `quiz` VALUES ('517', '食品卫生应做到的“四防”是指?', ' ###A.防尘、防蝇、防鼠、防腐###B.防尘、防蝇、防鼠、防腐###C.防尘、防蝇、防鼠、防蚊', 'A', '0', '0', '0');
INSERT INTO `quiz` VALUES ('518', '农（集）贸市场室内清扫、保洁不得低于几级道路保洁标准？?', ' ###A.一级###B.二级###C.三级', 'B', '0', '0', '0');
INSERT INTO `quiz` VALUES ('519', '突发事件应急工作，应当遵循（?B?）方针', ' ###A.全民动员，预防为主###B.预防为主，常备不懈###C.统一领导，预防为主', 'B', '0', '0', '0');
INSERT INTO `quiz` VALUES ('520', '公共场所使用分体空调的，空调滤网要定期清洗应当', ' ###A.每周不少于一次 ###B.每两周不少于一次###C.每月不少于一次 ', 'C', '0', '0', '0');
INSERT INTO `quiz` VALUES ('521', '国家卫生城市标准中要求近多少年未发生特大环境污染与破坏事故', ' ###A.1年###B.2年###C.3年', 'C', '0', '0', '0');
INSERT INTO `quiz` VALUES ('522', '烟尘控制区覆盖率应该大于等于多少？', ' ###A.75%###B.80%###C.85%', 'B', '0', '0', '0');
INSERT INTO `quiz` VALUES ('523', '全国卫生城市标准中本市居民对卫生状况满意率应该大于等于多少？', ' ###A.80%###B.85%###C.90%', 'C', '0', '0', '0');
INSERT INTO `quiz` VALUES ('524', '全国爱国卫生月定于每年的几月？', ' ###A.1月###B.4月###C.7月 ', 'B', '0', '0', '0');
INSERT INTO `quiz` VALUES ('525', '门前三包责任制包括内容？', ' ###A.卫生、绿化、秩序###B.卫生、防火、绿化###C.卫生、秩序、防火', 'A', '0', '0', '0');
INSERT INTO `quiz` VALUES ('526', '国家旅店业卫生标准明确规定：旅店卧具应做到？', ' ###A.一客一换 ###B.一天一换###C.三天一换', 'A', '0', '0', '0');
INSERT INTO `quiz` VALUES ('527', '讲卫生“五勤”的内容是？', ' ###A.勤洗头、勤理发、勤剪指甲、勤洗澡、勤换袜子###B.勤洗头、勤理发、勤剪指甲、勤洗澡、勤换衣裤 ###C.勤洗头、勤理发、勤剪指甲、勤洗澡、勤换鞋  ', 'B', '0', '0', '0');
INSERT INTO `quiz` VALUES ('528', '公共场所、饮食卫生从业人员多长时间体检一次', ' ###A.半年  ###B.1年###C.2年  ', 'B', '0', '0', '0');
INSERT INTO `quiz` VALUES ('529', '您认为“尊老爱幼、男女平等、夫妻和睦、勤俭持家、邻里团结”是每个市民都必须遵循的？', ' ###A.社会公德###B.职业道德###C.家庭美德', 'C', '0', '0', '0');
INSERT INTO `quiz` VALUES ('530', '随地吐痰、乱抛废物、乘车争先恐后，等等，都是有悖于什么不良行为？', ' ###A.社会公德###B.职业道德###C.家庭美德', 'A', '0', '0', '0');
INSERT INTO `quiz` VALUES ('531', '精神文明要坚持什么的方针？', ' ###A.重在教育###B.重在建设 ###C.重在宣传', 'B', '0', '0', '0');
INSERT INTO `quiz` VALUES ('532', '人们接受道德教育最早的地方是？', ' ###A.学校   ###B.家庭###C.单位', 'B', '0', '0', '0');
INSERT INTO `quiz` VALUES ('533', '临床用血100%来自无偿献血，其中自愿无偿献血率达到多少？  ', ' ###A.≥85%###B.≥90%###C.≥95%', 'B', '0', '0', '0');
INSERT INTO `quiz` VALUES ('534', '“创卫”标准里,集中式饮用水水源地水质达标率是多少？', ' ###A.≥85%###B.≥95%###C.≥100%', 'C', '0', '0', '0');
INSERT INTO `quiz` VALUES ('535', '“创卫”标准里要求近几年内不发生较大（Ⅲ级）以上级别环境污染事件？', '###A.2年###B.3年###C.4年', 'A,C,B', '0', '0', '0');

-- ----------------------------
-- Table structure for scores_month
-- ----------------------------
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

-- ----------------------------
-- Records of scores_month
-- ----------------------------
INSERT INTO `scores_month` VALUES ('1', '2017-4', '50', '1', '0', '0');

-- ----------------------------
-- Table structure for sysconfig
-- ----------------------------
DROP TABLE IF EXISTS `sysconfig`;
CREATE TABLE `sysconfig` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `combine` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `conunter` smallint(6) DEFAULT NULL,
  `perconunter` smallint(6) DEFAULT NULL,
  `delivery` varchar(6) COLLATE utf8mb4_bin DEFAULT NULL,
  `timu` smallint(6) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- ----------------------------
-- Records of sysconfig
-- ----------------------------
INSERT INTO `sysconfig` VALUES ('1', '随机组卷', '30', '30', 'true', '10');

-- ----------------------------
-- Table structure for table_user
-- ----------------------------
DROP TABLE IF EXISTS `table_user`;
CREATE TABLE `table_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `UID` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  `pwd` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  `scores` int(255) DEFAULT '0',
  `counts` int(11) NOT NULL DEFAULT '0',
  `phone` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `workUnit` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `department` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `type` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- ----------------------------
-- Records of table_user
-- ----------------------------
INSERT INTO `table_user` VALUES ('1', '1', '何庭', '123123', '179', '92', '13981122915', '内江日报', '应用部', '1');

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `oid` int(25) NOT NULL AUTO_INCREMENT,
  `nickname` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  `openid` varchar(100) COLLATE utf8mb4_bin NOT NULL,
  `headImg` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `RegistTime` datetime DEFAULT NULL,
  `uid` bigint(13) NOT NULL DEFAULT '0' COMMENT '//对于table_user表中的UID',
  PRIMARY KEY (`oid`),
  KEY `openid` (`openid`) USING BTREE,
  KEY `UID` (`uid`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES ('33', 'Jerry', 'oOpIJw6OWG7yvqeYmGrl7f22wHoo', 'http://thirdwx.qlogo.cn/mmopen/Y7JA4wbmYX6sjGlMtDBjuGPKeeu7yYe9MBxvMs3RyHewE7CSwNkiaBRDMfJGnA44qkOe0CTiaySqYjnYTNTSNoHicPLoeppvZEib/132', '2018-05-18 17:29:53', '1');
DROP TRIGGER IF EXISTS `dati_record`;
DELIMITER ;;
CREATE TRIGGER `dati_record` AFTER INSERT ON `dati_record` FOR EACH ROW BEGIN
		UPDATE `table_user` SET `scores`=scores+NEW.result,`counts`=counts+NEW.counts  WHERE uid=NEW.uid;
	END
;;
DELIMITER ;
