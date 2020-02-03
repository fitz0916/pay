/*
 Navicat Premium Data Transfer

 Source Server         : trans
 Source Server Type    : MySQL
 Source Server Version : 80018
 Source Host           : localhost:3306
 Source Schema         : pattern

 Target Server Type    : MySQL
 Target Server Version : 80018
 File Encoding         : 65001

 Date: 03/02/2020 18:05:12
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for trans_payment_order
-- ----------------------------
DROP TABLE IF EXISTS `trans_payment_order`;
CREATE TABLE `trans_payment_order` (
  `order_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '支付订单号',
  `customer_no` varchar(20) NOT NULL COMMENT '商户号',
  `customer_name` varchar(20) NOT NULL COMMENT '商户名称',
  `agent_id` int(12) NOT NULL COMMENT '代理商ID',
  `shop_id` int(12) NOT NULL COMMENT '门店ID',
  `third_customer_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '三方渠道号',
  `customer_order_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '商户订单号',
  `third_channel_order_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '三方渠道订单号',
  `pay_type` varchar(4) NOT NULL COMMENT '支付类型',
  `pay_status` tinyint(4) NOT NULL COMMENT '支付状态',
  `trans_time` datetime NOT NULL COMMENT '交易时间',
  `trans_finish_time` datetime NOT NULL COMMENT '交易完成时间',
  `topic` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '交易主题',
  `desciption` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '交易描述',
  `customer_payment_channel_info_id` int(12) NOT NULL COMMENT '商户渠道ID',
  `payment_channel_id` int(12) NOT NULL COMMENT '渠道ID',
  `payment_channel_account_id` int(11) NOT NULL COMMENT '渠道账号ID',
  `notify_url` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '后台回调地址',
  `return_url` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '前端回调地址',
  `pay_amount` bigint(16) NOT NULL COMMENT '交易金额',
  `third_channel_fee` decimal(4,4) NOT NULL COMMENT '三方渠道费率',
  `third_channel_proundage` bigint(16) NOT NULL COMMENT '三方渠道收取手续费（分）',
  `customer_fee` decimal(4,4) NOT NULL COMMENT '销售商户费率',
  `customer_proundage` bigint(16) NOT NULL COMMENT '收取商户手续费用(分)',
  `agent_fee` decimal(4,4) NOT NULL COMMENT '代理商费率',
  `agent_proundage` bigint(16) NOT NULL COMMENT '代理商手续费(实际金额*在开通通道界面配置的费率)',
  `customer_amount` bigint(16) NOT NULL COMMENT '商户实际到账金额(交易金额-交易金额*接入费率)',
  `qr_code` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '二维码地址',
  `settlement_type` int(4) NOT NULL COMMENT '结算类型 700:T0结算 701:T1结算  702:D0  703:D1',
  `settlement_status` tinyint(4) NOT NULL COMMENT '结算状态0：未结算，1：已结算 2：结算失败',
  `client_ip` varchar(20) NOT NULL COMMENT '请求IP',
  `currency` varchar(10) NOT NULL COMMENT '币种',
  `shop_fee` decimal(4,4) NOT NULL COMMENT '门店费率',
  `shop_proundage` bigint(16) NOT NULL COMMENT '收取门店手续费用(分)',
  PRIMARY KEY (`order_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SET FOREIGN_KEY_CHECKS = 1;
