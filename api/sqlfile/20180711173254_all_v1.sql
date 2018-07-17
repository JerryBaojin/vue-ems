--
-- MySQL database dump
-- Created by DbManage class, Power By yanue. 
-- http://yanue.net 
--
-- 主机: 192.168.20.104
-- 生成日期: 2018 年  07 月 11 日 17:32
-- MySQL版本: 5.7.19
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
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

--
-- 转存表中的数据 admin
--

INSERT INTO `admin` VALUES('1','admin','SA','13981122915','2018-06-28 09:10:08');
INSERT INTO `admin` VALUES('2','test1','QA','13981122916','2018-06-28 09:31:35');
INSERT INTO `admin` VALUES('5','超级管理员','SA','13696063219','2018-07-11 17:31:51');
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
) ENGINE=MyISAM AUTO_INCREMENT=169 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

--
-- 转存表中的数据 dati_record
--

INSERT INTO `dati_record` VALUES('167','oOpIJw6OWG7yvqeYmGrl7f22wHoo','0','1531213778','11','single','5','21');
INSERT INTO `dati_record` VALUES('168','oOpIJw6OWG7yvqeYmGrl7f22wHoo','0','1531278003','10','single','0','42');
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
) ENGINE=MyISAM AUTO_INCREMENT=66 DEFAULT CHARSET=utf8mb4;

--
-- 转存表中的数据 log
--

INSERT INTO `log` VALUES('8','admin','添加么么哒管理员','2018-06-27 15:41:54');
INSERT INTO `log` VALUES('2','a','test','2018-06-25 16:11:03');
INSERT INTO `log` VALUES('3','a','test','2018-06-25 16:11:33');
INSERT INTO `log` VALUES('4','a','test','2018-06-25 16:17:26');
INSERT INTO `log` VALUES('5','admin','修改admin1信息','2018-06-27 10:12:11');
INSERT INTO `log` VALUES('6','admin','修改admin1信息','2018-06-27 10:13:53');
INSERT INTO `log` VALUES('7','admin','修改admin12信息','2018-06-27 10:15:18');
INSERT INTO `log` VALUES('9','admin12','添加admin管理员','2018-06-28 08:50:35');
INSERT INTO `log` VALUES('10','admin12','添加test管理员','2018-06-28 08:50:48');
INSERT INTO `log` VALUES('11','admin12','添加admin管理员','2018-06-28 08:51:40');
INSERT INTO `log` VALUES('12','admin12','添加test管理员','2018-06-28 08:56:27');
INSERT INTO `log` VALUES('13','admin12','添加admin管理员','2018-06-28 09:04:18');
INSERT INTO `log` VALUES('14','admin12','添加1管理员','2018-06-28 09:04:31');
INSERT INTO `log` VALUES('15','admin12','添加admin管理员','2018-06-28 09:06:11');
INSERT INTO `log` VALUES('16','admin12','添加admin管理员','2018-06-28 09:10:08');
INSERT INTO `log` VALUES('17','admin12','添加test1管理员','2018-06-28 09:31:35');
INSERT INTO `log` VALUES('18','admin','修改了套题测试配置','2018-06-29 09:15:06');
INSERT INTO `log` VALUES('19','admin','修改了套题测试配置','2018-06-29 09:15:51');
INSERT INTO `log` VALUES('20','admin','修改了套题测试配置','2018-06-29 09:26:38');
INSERT INTO `log` VALUES('21','admin','修改了套题测试配置','2018-06-29 09:27:32');
INSERT INTO `log` VALUES('22','admin','修改了套题测试配置','2018-06-29 10:49:20');
INSERT INTO `log` VALUES('23','admin','修改了套题测试配置','2018-06-29 10:49:28');
INSERT INTO `log` VALUES('24','admin','修改了套题测试配置','2018-06-29 11:52:24');
INSERT INTO `log` VALUES('25','admin','修改了系统通用设置','2018-06-29 11:54:20');
INSERT INTO `log` VALUES('26','admin','修改了套题测试配置','2018-07-03 17:53:39');
INSERT INTO `log` VALUES('27','admin','更新了积分设置!','2018-07-04 08:56:38');
INSERT INTO `log` VALUES('28','admin','更新了积分设置!','2018-07-04 08:57:13');
INSERT INTO `log` VALUES('29','admin','更新了积分设置!','2018-07-04 08:58:45');
INSERT INTO `log` VALUES('30','admin','更新了积分设置!','2018-07-04 10:03:50');
INSERT INTO `log` VALUES('31','admin','导出了排名表格','2018-07-06 11:14:11');
INSERT INTO `log` VALUES('32','admin','更新了积分设置!','2018-07-09 09:53:03');
INSERT INTO `log` VALUES('33','admin','更新了积分设置!','2018-07-09 10:23:33');
INSERT INTO `log` VALUES('34','admin','更新了积分设置!','2018-07-09 10:25:30');
INSERT INTO `log` VALUES('35','admin','登录系统!','2018-07-09 17:54:30');
INSERT INTO `log` VALUES('36','admin','登录系统!','2018-07-09 17:56:58');
INSERT INTO `log` VALUES('37','admin','登录系统!','2018-07-09 17:57:33');
INSERT INTO `log` VALUES('38','admin','备份数据库','2018-07-10 09:46:32');
INSERT INTO `log` VALUES('39','admin','备份数据库','2018-07-10 09:47:00');
INSERT INTO `log` VALUES('40','admin','备份数据库','2018-07-10 09:49:17');
INSERT INTO `log` VALUES('41','admin','备份数据库','2018-07-10 09:51:01');
INSERT INTO `log` VALUES('42','admin','备份数据库','2018-07-10 09:51:50');
INSERT INTO `log` VALUES('43','admin','备份数据库','2018-07-10 10:03:52');
INSERT INTO `log` VALUES('44','admin','备份数据库','2018-07-10 10:04:12');
INSERT INTO `log` VALUES('45','admin','备份数据库','2018-07-10 10:05:03');
INSERT INTO `log` VALUES('46','admin','备份数据库','2018-07-10 10:05:32');
INSERT INTO `log` VALUES('47','admin','登录系统!','2018-07-10 10:12:11');
INSERT INTO `log` VALUES('48','admin','登录系统!','2018-07-10 10:15:54');
INSERT INTO `log` VALUES('49','admin','登录系统!','2018-07-10 11:44:03');
INSERT INTO `log` VALUES('50','admin','登录系统!','2018-07-10 11:54:15');
INSERT INTO `log` VALUES('51','admin','登录系统!','2018-07-10 16:20:53');
INSERT INTO `log` VALUES('52','admin','登录系统!','2018-07-10 17:19:49');
INSERT INTO `log` VALUES('53','admin','修改了系统通用设置','2018-07-10 17:20:18');
INSERT INTO `log` VALUES('54','admin','登录系统!','2018-07-11 10:50:16');
INSERT INTO `log` VALUES('55','admin','登录系统!','2018-07-11 11:45:13');
INSERT INTO `log` VALUES('56','admin','修改了系统通用设置','2018-07-11 14:17:24');
INSERT INTO `log` VALUES('57','admin','添加超级管理员管理员','2018-07-11 15:25:48');
INSERT INTO `log` VALUES('58','admin','删除id为delete from admin WHERE id in (3)管理员','2018-07-11 15:26:55');
INSERT INTO `log` VALUES('59','admin','导出了排名表格','2018-07-11 08:27:42');
INSERT INTO `log` VALUES('60','admin','添加超级管理员管理员','2018-07-11 17:05:21');
INSERT INTO `log` VALUES('61','admin','删除id为delete from admin WHERE id in (4)管理员','2018-07-11 17:05:26');
INSERT INTO `log` VALUES('62','admin','更新了积分设置!','2018-07-11 17:10:44');
INSERT INTO `log` VALUES('63','admin','添加超级管理员管理员','2018-07-11 17:31:51');
INSERT INTO `log` VALUES('64','超级管理员','登录系统!','2018-07-11 17:32:32');
INSERT INTO `log` VALUES('65','超级管理员','备份数据库','2018-07-11 17:32:54');
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

INSERT INTO `moduletest` VALUES('1','random','10','开启','5','每日一测','{\"single\":8,\"muti\":1,\"judge\":1}','十九大','[1528300800000,1529078400000]');
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
) ENGINE=InnoDB AUTO_INCREMENT=681 DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 quiz
--

INSERT INTO `quiz` VALUES('603','题目',' ###A.选项A###B.选项B###C.选项C','答案','0','0','0','类型','single');
INSERT INTO `quiz` VALUES('604','创卫标准要求小美容美（理）发店营业面积不小于多少平方米？',' ###A.10平方米###B.15平方米###C.20平方米','B','0','0','0','十九大','single');
INSERT INTO `quiz` VALUES('605','创卫标准要求辖区内婴儿死亡率，不高于多少？',' ###A.≤12%###B.≤15%###C.≤18%','A','0','0','0','十九大','single');
INSERT INTO `quiz` VALUES('606','肠道门诊应在什么时间设立?',' ###A.1-6月###B.2-7月###C.5-10月','C','0','0','0','十九大','single');
INSERT INTO `quiz` VALUES('607','什么叫“四害”?',' ###A.老鼠###B.蚊子###C.蟑螂','A,B,C','0','0','0','十九大','single');
INSERT INTO `quiz` VALUES('642','题目',' ###A.选项A###B.选项B###C.选项C','答案','0','0','0','类型','single');
INSERT INTO `quiz` VALUES('643','创卫标准要求小美容美（理）发店营业面积不小于多少平方米？',' ###A.10平方米###B.15平方米###C.20平方米','B','0','0','0','十九大','single');
INSERT INTO `quiz` VALUES('644','创卫标准要求辖区内婴儿死亡率，不高于多少？',' ###A.≤12%###B.≤15%###C.≤18%','A','0','0','0','十九大','single');
INSERT INTO `quiz` VALUES('645','肠道门诊应在什么时间设立?',' ###A.1-6月###B.2-7月###C.5-10月','C','0','0','0','十九大','single');
INSERT INTO `quiz` VALUES('646','什么叫“四害”?',' ###A.老鼠###B.蚊子###C.蟑螂','A,B,C','0','0','0','十九大','single');
INSERT INTO `quiz` VALUES('647','鼠类可传播多少种疾病？',' ###A.10多种###B.20多种###C.30多种','C','0','0','0','十九大','single');
INSERT INTO `quiz` VALUES('648','老鼠分为哪几类？',' ###A.家栖鼠###B.野栖鼠###C.褐家鼠','A,B','0','0','0','十九大','single');
INSERT INTO `quiz` VALUES('649','创卫标准要求防鼠设施合格率是多少？',' ###A.≥93%###B.≥92%###C.≥91%','A','0','0','0','十九大','single');
INSERT INTO `quiz` VALUES('650','慢性鼠药中毒该注射什么救治？',' ###A.维生素C###B.维生素B###C.维生素KI','C','0','0','0','十九大','single');
INSERT INTO `quiz` VALUES('651','鼠类的天敌有哪些?',' ###A.猫###B.鹰###C.蛇','A,B,C','0','0','0','十九大','single');
INSERT INTO `quiz` VALUES('652','流行性出血热，体温在1--2日内升到多少摄氏度？',' ###A.36℃-38℃###B.37℃-39℃###C.39℃-40℃','C','0','0','0','十九大','single');
INSERT INTO `quiz` VALUES('653','我国由蚊子传播的主要疾病有？',' ###A.疟疾###B.乙型脑炎###C.丝虫病','A,B,C','0','0','0','十九大','single');
INSERT INTO `quiz` VALUES('654','餐具消毒方法有哪几种？',' ###A.物理消毒###B.化学消毒###C.常规消毒','A,B','1','0','0','十九大','single');
INSERT INTO `quiz` VALUES('655','依照餐饮服务单位的食品安全管理状况，动态等级分为几个等级?',' ###A.优秀###B.良好###C.一般','A,B,C','1','0','0','十九大','single');
INSERT INTO `quiz` VALUES('656','餐饮服务食品安全量化等级分为哪些?',' ###A.动态等级###B.年度等级###C.季度等级','A,B','1','0','0','十九大','single');
INSERT INTO `quiz` VALUES('657','小餐馆的厨房（包括辅助设施）面积必须不低于多少？',' ###A.8平方米###B.9平方米###C.10平方米','A','1','0','0','十九大','single');
INSERT INTO `quiz` VALUES('658','对餐饮业的厕所卫生标准要达到“几洁”',' ###A.“一洁”###B.“三洁”###C.“六洁”','C','0','0','0','十九大','single');
INSERT INTO `quiz` VALUES('659','对餐饮业的厕所卫生标准要达到“几无”',' ###A.“一无”###B.“二无”###C.“四无”','C','0','0','0','十九大','single');
INSERT INTO `quiz` VALUES('660','创卫标准中对生活污水集中处理率的要求是？',' ###A.≥80%###B.≥85%###C.≥90%','B','0','0','0','十九大','single');
INSERT INTO `quiz` VALUES('661','国家卫生城市工作中对建成区绿化率要达到多少？',' ###A.≥36%###B.≥37%###C.≥38%','A','1','0','0','十九大','single');
INSERT INTO `quiz` VALUES('662','食品卫生应做到的“四防”是指?',' ###A.防尘、防蝇、防鼠、防腐###B.防尘、防蝇、防鼠、防腐###C.防尘、防蝇、防鼠、防蚊','A','1','0','0','每日一题','single');
INSERT INTO `quiz` VALUES('663','农（集）贸市场室内清扫、保洁不得低于几级道路保洁标准？?',' ###A.一级###B.二级###C.三级','B','1','0','0','每日一题','single');
INSERT INTO `quiz` VALUES('664','突发事件应急工作，应当遵循（?B?）方针',' ###A.全民动员，预防为主###B.预防为主，常备不懈###C.统一领导，预防为主','B','1','0','0','每日一题','single');
INSERT INTO `quiz` VALUES('665','公共场所使用分体空调的，空调滤网要定期清洗应当',' ###A.每周不少于一次 ###B.每两周不少于一次###C.每月不少于一次 ','C','1','0','0','每日一题','single');
INSERT INTO `quiz` VALUES('666','国家卫生城市标准中要求近多少年未发生特大环境污染与破坏事故',' ###A.1年###B.2年###C.3年','C','1','0','0','每日一题','single');
INSERT INTO `quiz` VALUES('667','烟尘控制区覆盖率应该大于等于多少？',' ###A.75%###B.80%###C.85%','B','1','0','0','每日一题','single');
INSERT INTO `quiz` VALUES('668','全国卫生城市标准中本市居民对卫生状况满意率应该大于等于多少？',' ###A.80%###B.85%###C.90%','C','1','0','0','每日一题','single');
INSERT INTO `quiz` VALUES('669','全国爱国卫生月定于每年的几月？',' ###A.1月###B.4月###C.7月 ','B','1','0','0','每日一题','single');
INSERT INTO `quiz` VALUES('670','门前三包责任制包括内容？',' ###A.卫生、绿化、秩序###B.卫生、防火、绿化###C.卫生、秩序、防火','A','1','0','0','每日一题','single');
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

INSERT INTO `sysconfig` VALUES('1','random','30','24','开启','24','每周一测','a,2,515,','{\"single\":5,\"muti\":13,\"judge\":1}','desc','http://img5.imgtn.bdimg.com/it/u=1055545886,930296925&fm=27&gp=0.jpg','http://www.baidu.com','一周一测','[1530547200000,1532966400000]','{\"single\":35,\"muti\":9,\"judge\":13}');
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
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

--
-- 转存表中的数据 table_user
--

INSERT INTO `table_user` VALUES('6','0','何庭','42','10','','13981122911','','0','1','','市中区','2018-07-11 10:58:42');
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
) ENGINE=MyISAM AUTO_INCREMENT=43 DEFAULT CHARSET=utf8mb4;

--
-- 转存表中的数据 users
--

INSERT INTO `users` VALUES('41','Jerry?','oOpIJw6OWG7yvqeYmGrl7f22wHoo','http://thirdwx.qlogo.cn/mmopen/Y7JA4wbmYX6sjGlMtDBjuGPKeeu7yYe9MBxvMs3RyHewE7CSwNkiaBRDMfJGnA44qkOe0CTiaySqYjnYTNTSNoHicPLoeppvZEib/132','2018-06-26 09:03:19','0','{\"ip\":\"61.157.200.94\",\"addr\":{\"province\":\"四川省\",\"city\":\"内江市\"}}');
