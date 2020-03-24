/*
 Navicat Premium Data Transfer

 Source Server         : trans
 Source Server Type    : MySQL
 Source Server Version : 80018
 Source Host           : localhost:3306
 Source Schema         : trans

 Target Server Type    : MySQL
 Target Server Version : 80018
 File Encoding         : 65001

 Date: 03/02/2020 18:06:08
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for pattern_agent
-- ----------------------------
DROP TABLE IF EXISTS `pattern_agent`;
CREATE TABLE `pattern_agent` (
  `agent_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `agent_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '代理商名称',
  `agent_no` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '代理商编号',
  `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '0:停用 1：启用 2：删除',
  `type` tinyint(4) NOT NULL COMMENT '1个体工商户 2公司/企业',
  `registry_date` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '公司注册时间',
  `business_license` varchar(50) NOT NULL DEFAULT '0' COMMENT '营业执照号',
  `address` varchar(100) NOT NULL DEFAULT '0' COMMENT '地址',
  `company_pic_path` varchar(100) NOT NULL DEFAULT '0' COMMENT '公司照片地址',
  `idcard_front_path` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '身份证正面地址',
  `idcard_back_path` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '身份证反面照片地址',
  `phone` varchar(15) NOT NULL DEFAULT '1' COMMENT '手机号码',
  `email` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'email',
  `qq` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'qq号',
  `wechat` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '微信号',
  `create_date` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_date` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`agent_id`)
) ENGINE=InnoDB AUTO_INCREMENT=420 DEFAULT CHARSET=utf8 COMMENT='代理商/商户';

-- ----------------------------
-- Table structure for pattern_black_list
-- ----------------------------
DROP TABLE IF EXISTS `pattern_black_list`;
CREATE TABLE `pattern_black_list` (
  `black_list_id` int(11) NOT NULL AUTO_INCREMENT,
  `ip` varchar(255) NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT '1',
  `create_time` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP,
  `update_time` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP,
  `remark` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`black_list_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table structure for pattern_customer
-- ----------------------------
DROP TABLE IF EXISTS `pattern_customer`;
CREATE TABLE `pattern_customer` (
  `customer_id` int(11) NOT NULL AUTO_INCREMENT,
  `agent_id` int(11) NOT NULL COMMENT '代理商ID',
  `shop_id` int(11) NOT NULL COMMENT '门店ID',
  `customer_no` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '商户号',
  `customer_name` varchar(50) NOT NULL COMMENT '商户名称',
  `settlement` bigint(12) NOT NULL DEFAULT '0' COMMENT '待结算金额单位分',
  `frozen_amount` bigint(12) NOT NULL DEFAULT '0' COMMENT '冻结总额，待解冻总额，单位分',
  `amount` bigint(12) NOT NULL COMMENT '可用金额',
  `cipher` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '交易/体现密码',
  `create_date` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_date` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '支付状态（0启用 1禁用 2删除）',
  `payout_way` tinyint(255) NOT NULL COMMENT '代付方式（0自动代付 1人工代付',
  `unfreeze_amount` bigint(12) NOT NULL DEFAULT '0' COMMENT '已解冻总额',
  `frozen_amount_sum` bigint(12) NOT NULL DEFAULT '0' COMMENT '冻结记录的总额',
  PRIMARY KEY (`customer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table structure for pattern_customer_payment_channel_fee
-- ----------------------------
DROP TABLE IF EXISTS `pattern_customer_payment_channel_fee`;
CREATE TABLE `pattern_customer_payment_channel_fee` (
  `payment_channeld_fee_id` int(12) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `customer_id` int(12) DEFAULT NULL,
  `payment_channel_id` int(12) NOT NULL COMMENT '渠道ID',
  `third_rate` decimal(4,4) NOT NULL COMMENT '三方费率',
  `agent_rate` decimal(4,4) NOT NULL COMMENT '代理商费率',
  `shop_rate` decimal(4,4) NOT NULL COMMENT '门店费率',
  `customer_rate` decimal(11,4) NOT NULL COMMENT '商户费率',
  `create_time` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '状态，0未生效，1生效 2删除',
  `remark` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0' COMMENT '备注',
  PRIMARY KEY (`payment_channeld_fee_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=25886 DEFAULT CHARSET=utf8 COMMENT='商户金额变动记录';

-- ----------------------------
-- Table structure for pattern_customer_payment_channel_info
-- ----------------------------
DROP TABLE IF EXISTS `pattern_customer_payment_channel_info`;
CREATE TABLE `pattern_customer_payment_channel_info` (
  `customer_payment_channel_info_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '商户支付通道ID',
  `payment_channel_id` int(10) NOT NULL COMMENT '所属支付通道ID',
  `customer_id` int(10) NOT NULL COMMENT '商户ID',
  `customer_no` varchar(15) NOT NULL,
  `settlement_type` int(10) DEFAULT NULL,
  `remark` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '0禁用 1启用 2删除',
  PRIMARY KEY (`customer_payment_channel_info_id`) USING BTREE,
  UNIQUE KEY `agent_id` (`customer_id`,`payment_channel_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1092 DEFAULT CHARSET=utf8 COMMENT='商户支付通道表';

-- ----------------------------
-- Table structure for pattern_payment_channel
-- ----------------------------
DROP TABLE IF EXISTS `pattern_payment_channel`;
CREATE TABLE `pattern_payment_channel` (
  `payment_channel_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '支付渠道ID',
  `payment_template_id` int(11) NOT NULL COMMENT '模板ID',
  `channel_name` varchar(50) NOT NULL DEFAULT '' COMMENT '简称',
  `third_channel_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '三方渠道名称',
  `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '0：停用 1：启用 2删除',
  `pay_type` varchar(10) NOT NULL COMMENT '支付类型',
  `business_contacts` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '商务联系人',
  `settlement_type` varchar(4) NOT NULL COMMENT '对接三方渠道的结算方式',
  `mobile` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '手机号码',
  `qq` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'qq',
  `wechat` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '微信',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `remark` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`payment_channel_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=213 DEFAULT CHARSET=utf8 COMMENT='支付渠道表';

-- ----------------------------
-- Table structure for pattern_payment_channel_account
-- ----------------------------
DROP TABLE IF EXISTS `pattern_payment_channel_account`;
CREATE TABLE `pattern_payment_channel_account` (
  `payment_channel_account_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '渠道账户ID',
  `payment_channel_id` int(11) NOT NULL COMMENT '支付渠道ID',
  `account_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '账号名称',
  `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '0：禁用 1：启用 2：删除',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `remark` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`payment_channel_account_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1138 DEFAULT CHARSET=utf8 COMMENT='渠道账户表';

-- ----------------------------
-- Table structure for pattern_payment_channel_account_para
-- ----------------------------
DROP TABLE IF EXISTS `pattern_payment_channel_account_para`;
CREATE TABLE `pattern_payment_channel_account_para` (
  `payment_channel_account_para_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '渠道账户参数ID',
  `payment_channel_account_id` int(10) NOT NULL COMMENT '渠道账户ID',
  `name` varchar(50) NOT NULL COMMENT '参数名',
  `value` text NOT NULL COMMENT '参数值',
  `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '0：禁用 1：启用 2：删除',
  `create_time` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `remark` varchar(150) NOT NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`payment_channel_account_para_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=279 DEFAULT CHARSET=utf8 COMMENT='渠道账户参数表';

-- ----------------------------
-- Table structure for pattern_payment_channelinfo_risk
-- ----------------------------
DROP TABLE IF EXISTS `pattern_payment_channelinfo_risk`;
CREATE TABLE `pattern_payment_channelinfo_risk` (
  `payment_channelinfo_risk_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '支付通道风控表ID',
  `payment_channel_id` int(11) unsigned NOT NULL COMMENT '支付通道ID',
  `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '0：禁用 1：启用 2：删除',
  `allowTime` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '允许支付时间(格式hh:mm:ss-hh:mm:ss 24小时制 多条用|隔开,不输入则不限制)',
  `allow_num` int(11) NOT NULL DEFAULT '-1' COMMENT '交易次数限制，默认值-1',
  `pay_interval` int(11) NOT NULL DEFAULT '-1' COMMENT '时间间隔 单位秒',
  `single_money` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '-1' COMMENT '单笔交易金额   格式  50-1000  单位分，多条用|隔开  空或者0不限制',
  `day_money` int(11) NOT NULL DEFAULT '-1' COMMENT '日限额,默认值-1',
  `user_most_number` int(11) NOT NULL DEFAULT '-1' COMMENT '允许终端用户支付最多次数，默认值-1',
  `strategy` tinyint(4) NOT NULL DEFAULT '0' COMMENT '使用策略 0随机 1优先级2权重',
  `min_money` int(11) NOT NULL COMMENT '单比交易最小金额，默认值-1',
  `max_money` int(11) NOT NULL COMMENT '单比交易最打金额，默认值-1',
  `is_froze` tinyint(4) NOT NULL COMMENT '是否冻结0冻结 1，正常',
  `create_time` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `remark` varchar(100) NOT NULL COMMENT '备注',
  PRIMARY KEY (`payment_channelinfo_risk_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=utf8 COMMENT='支付通道风控表';

-- ----------------------------
-- Table structure for pattern_payment_template
-- ----------------------------
DROP TABLE IF EXISTS `pattern_payment_template`;
CREATE TABLE `pattern_payment_template` (
  `payment_template_id` int(11) NOT NULL,
  `template_name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '支付名称',
  `template_desc` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '支付模板描述',
  `pay_type` varchar(10) NOT NULL COMMENT '支付类型',
  PRIMARY KEY (`payment_template_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table structure for pattern_payment_type
-- ----------------------------
DROP TABLE IF EXISTS `pattern_payment_type`;
CREATE TABLE `pattern_payment_type` (
  `payment_type_id` int(11) NOT NULL COMMENT '支付类型ID',
  `payment_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '支付类型名称',
  `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '0：禁用 1：启用 2：删除',
  `pay_model` tinyint(4) NOT NULL COMMENT '支付模式：0:web ，1:app',
  `create_time` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `remark` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '备注',
  PRIMARY KEY (`payment_type_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='支付类型表';

-- ----------------------------
-- Table structure for pattern_shop
-- ----------------------------
DROP TABLE IF EXISTS `pattern_shop`;
CREATE TABLE `pattern_shop` (
  `shop_id` int(8) NOT NULL AUTO_INCREMENT COMMENT '门店ID',
  `brand` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '品牌',
  `shop_no` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '门店编号',
  `agent_id` int(11) NOT NULL COMMENT '所属商户ID',
  `shop_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '门店名称',
  `address` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '门店地址',
  `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '0：禁用 1：启用 2：删除',
  `phone` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '门店管理账号',
  `create_time` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`shop_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2375 DEFAULT CHARSET=utf8 COMMENT='商户门店';

-- ----------------------------
-- Table structure for pattern_white_list
-- ----------------------------
DROP TABLE IF EXISTS `pattern_white_list`;
CREATE TABLE `pattern_white_list` (
  `white_list_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `ip` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT 'ip地址',
  `status` tinyint(4) DEFAULT NULL COMMENT '0：禁用 1：启用 2：删除',
  `create_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`white_list_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8 COMMENT='商户支付白名单';

SET FOREIGN_KEY_CHECKS = 1;
