/*
Navicat MySQL Data Transfer

Source Server         : mysql56
Source Server Version : 50627
Source Host           : localhost:3306
Source Database       : bank

Target Server Type    : MYSQL
Target Server Version : 50627
File Encoding         : 65001

Date: 2015-11-13 09:49:04
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `fixed_deposit`
-- ----------------------------
DROP TABLE IF EXISTS `fixed_deposit`;
CREATE TABLE `fixed_deposit` (
  `fd_id` int(10) NOT NULL AUTO_INCREMENT,
  `user_id` int(10) NOT NULL,
  `fd_type` int(10) NOT NULL,
  `fd_start_date` varchar(30) NOT NULL,
  `fd_end_date` varchar(30) NOT NULL,
  `fd_amount` double(20,2) NOT NULL,
  `fd_income` double(20,2) NOT NULL,
  `fd_is_valid` int(10) NOT NULL,
  PRIMARY KEY (`fd_id`),
  KEY `fk_fd_user_id` (`user_id`),
  CONSTRAINT `fk_fd_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of fixed_deposit
-- ----------------------------
INSERT INTO `fixed_deposit` VALUES ('1', '15', '0', '1445169050818', '1443757181634', '500.00', '18250.00', '1');
INSERT INTO `fixed_deposit` VALUES ('2', '15', '1', '1445169801685', '1446641030613', '600.00', '65700.00', '0');
INSERT INTO `fixed_deposit` VALUES ('3', '12', '1', '1445169930883', '1446641159811', '300.00', '49275.00', '0');
INSERT INTO `fixed_deposit` VALUES ('4', '15', '0', '1445230762466', '1443818893282', '1.00', '36.50', '1');
INSERT INTO `fixed_deposit` VALUES ('7', '15', '1', '1445312102223', '1446783331151', '500.00', '54750.00', '0');
INSERT INTO `fixed_deposit` VALUES ('8', '15', '0', '1445315588666', '1461083588666', '100.00', '3650.00', '0');
INSERT INTO `fixed_deposit` VALUES ('9', '15', '1', '1445316073443', '1476852073443', '50.00', '5475.00', '0');
INSERT INTO `fixed_deposit` VALUES ('10', '18', '1', '1445910066402', '1477446066402', '400.00', '65700.00', '0');
INSERT INTO `fixed_deposit` VALUES ('11', '15', '0', '1445936793777', '1461704793777', '123.00', '4489.50', '0');
INSERT INTO `fixed_deposit` VALUES ('12', '19', '1', '1445945745325', '1477481745325', '123.00', '20202.75', '0');
INSERT INTO `fixed_deposit` VALUES ('14', '1', '1', '1446794076002', '1478330076002', '400.00', '6570.00', '0');
INSERT INTO `fixed_deposit` VALUES ('15', '1', '1', '1446802796408', '1478338796408', '123.00', '2020.28', '0');

-- ----------------------------
-- Table structure for `history`
-- ----------------------------
DROP TABLE IF EXISTS `history`;
CREATE TABLE `history` (
  `history_id` int(10) NOT NULL AUTO_INCREMENT,
  `user_id` int(10) NOT NULL,
  `history_type` int(1) NOT NULL,
  `history_amount` double(20,2) NOT NULL,
  `history_date` varchar(30) NOT NULL,
  PRIMARY KEY (`history_id`),
  KEY `fk_history_user_id` (`user_id`),
  CONSTRAINT `fk_history_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of history
-- ----------------------------
INSERT INTO `history` VALUES ('1', '15', '2', '500.00', '45345345345');
INSERT INTO `history` VALUES ('2', '15', '0', '200.00', '3534534534534');
INSERT INTO `history` VALUES ('3', '15', '1', '500.00', '345345345345');
INSERT INTO `history` VALUES ('4', '15', '2', '600.00', '345345');
INSERT INTO `history` VALUES ('5', '12', '0', '100.00', '345345353');
INSERT INTO `history` VALUES ('6', '12', '0', '100.00', '345345345');
INSERT INTO `history` VALUES ('7', '12', '1', '200.00', '345353453');
INSERT INTO `history` VALUES ('8', '12', '2', '300.00', '34534534534');
INSERT INTO `history` VALUES ('11', '15', '2', '1.00', '1445230762466');
INSERT INTO `history` VALUES ('17', '16', '1', '100000.00', '1445266143999');
INSERT INTO `history` VALUES ('18', '15', '2', '500.00', '1445312102223');
INSERT INTO `history` VALUES ('19', '15', '2', '100.00', '1445315588666');
INSERT INTO `history` VALUES ('20', '15', '2', '50.00', '1445316073443');
INSERT INTO `history` VALUES ('25', '18', '1', '4000.00', '1445910019302');
INSERT INTO `history` VALUES ('26', '18', '2', '400.00', '1445910066402');
INSERT INTO `history` VALUES ('27', '15', '1', '12213.00', '1445936586076');
INSERT INTO `history` VALUES ('28', '15', '2', '123.00', '1445936793777');
INSERT INTO `history` VALUES ('29', '19', '0', '12.00', '1445940411345');
INSERT INTO `history` VALUES ('30', '19', '0', '1.00', '1445940798592');
INSERT INTO `history` VALUES ('31', '19', '0', '12.00', '1445941394959');
INSERT INTO `history` VALUES ('32', '19', '0', '23.00', '1445942860208');
INSERT INTO `history` VALUES ('33', '19', '0', '12.00', '1445943134822');
INSERT INTO `history` VALUES ('34', '19', '0', '23.00', '1445943212604');
INSERT INTO `history` VALUES ('35', '19', '0', '12.00', '1445943335488');
INSERT INTO `history` VALUES ('36', '19', '0', '11.00', '1445943465078');
INSERT INTO `history` VALUES ('37', '19', '0', '10.00', '1445943566816');
INSERT INTO `history` VALUES ('38', '19', '0', '1.00', '1445944396254');
INSERT INTO `history` VALUES ('39', '19', '1', '123.00', '1445944403627');
INSERT INTO `history` VALUES ('40', '19', '1', '213.00', '1445945470944');
INSERT INTO `history` VALUES ('41', '19', '0', '12.00', '1445945589497');
INSERT INTO `history` VALUES ('42', '19', '1', '34534.00', '1445945725382');
INSERT INTO `history` VALUES ('43', '19', '2', '123.00', '1445945745325');
INSERT INTO `history` VALUES ('45', '19', '0', '200.00', '1446173170730');
INSERT INTO `history` VALUES ('46', '1', '1', '200.00', '1446794046709');
INSERT INTO `history` VALUES ('47', '1', '0', '20.00', '1446794058771');
INSERT INTO `history` VALUES ('48', '1', '2', '400.00', '1446794076002');
INSERT INTO `history` VALUES ('49', '1', '0', '1.00', '1446794136545');
INSERT INTO `history` VALUES ('50', '19', '0', '12.00', '1446802674206');
INSERT INTO `history` VALUES ('51', '1', '0', '12.00', '1446802772784');
INSERT INTO `history` VALUES ('52', '1', '1', '123.00', '1446802787651');
INSERT INTO `history` VALUES ('53', '1', '2', '123.00', '1446802796408');
INSERT INTO `history` VALUES ('54', '1', '0', '12.00', '1447377821552');

-- ----------------------------
-- Table structure for `staff`
-- ----------------------------
DROP TABLE IF EXISTS `staff`;
CREATE TABLE `staff` (
  `staff_id` int(10) NOT NULL AUTO_INCREMENT,
  `staff_name` varchar(20) NOT NULL,
  `staff_password` varchar(20) NOT NULL,
  PRIMARY KEY (`staff_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of staff
-- ----------------------------
INSERT INTO `staff` VALUES ('1', '1', '1');

-- ----------------------------
-- Table structure for `user`
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `user_id` int(10) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(20) NOT NULL,
  `user_password` int(6) NOT NULL,
  `user_type` int(1) NOT NULL,
  `user_balance` double(20,2) NOT NULL,
  `user_interest` double(20,2) NOT NULL,
  `user_idcard` varchar(20) NOT NULL,
  `user_last_settle_interest_date` varchar(20) NOT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('1', '谭凡', '111111', '1', '1500702.37', '0.00', '360121199510067556', '1447378054580');
INSERT INTO `user` VALUES ('6', '王二', '111111', '0', '6.00', '2013.89', '623423423423456654', '1447377833256');
INSERT INTO `user` VALUES ('7', '赵一', '111111', '0', '7.00', '2349.55', '734534345236457563', '1447377833260');
INSERT INTO `user` VALUES ('8', '斯蒂芬', '111111', '0', '8.00', '2685.20', '834534534555645636', '1447377833263');
INSERT INTO `user` VALUES ('9', '阿斯顿', '111111', '0', '9.00', '3020.86', '934564564634345466', '1447377833267');
INSERT INTO `user` VALUES ('11', '掉咋天', '325345', '1', '534.00', '1077563.65', '345345345345434356', '1447377833269');
INSERT INTO `user` VALUES ('12', '叶良辰', '123456', '1', '39862.52', '26309.25', '234235234534634634', '1447377833272');
INSERT INTO `user` VALUES ('13', '23432', '123456', '0', '123.00', '41161.95', '234343445553453453', '1447377833276');
INSERT INTO `user` VALUES ('14', '12342', '123456', '0', '234.00', '78308.11', '324534534353453454', '1447377833280');
INSERT INTO `user` VALUES ('15', '赵日天', '121212', '0', '155783.02', '4673.49', '345634634634634445', '1447377833283');
INSERT INTO `user` VALUES ('16', '福尔康', '121212', '1', '100099.00', '58858.22', '123235345431233445', '1446802927967');
INSERT INTO `user` VALUES ('17', '阿斯蒂芬', '111111', '0', '123.00', '12.05', '345334455343344455', '1446802927981');
INSERT INTO `user` VALUES ('18', '凌慧峰', '121212', '1', '3800.00', '410.40', '123456789123456789', '1446802927985');
INSERT INTO `user` VALUES ('19', '张珂瑞', '111111', '1', '38641.74', '0.00', '321321321321321345', '1446802927989');
