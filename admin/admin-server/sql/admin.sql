/*
 Navicat Premium Data Transfer

 Source Server         : trans
 Source Server Type    : MySQL
 Source Server Version : 80018
 Source Host           : localhost:3306
 Source Schema         : admin

 Target Server Type    : MySQL
 Target Server Version : 80018
 File Encoding         : 65001

 Date: 12/01/2020 21:23:03
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for admin_log
-- ----------------------------
DROP TABLE IF EXISTS `admin_log`;
CREATE TABLE `admin_log` (
  `log_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `description` varchar(100) NOT NULL DEFAULT '' COMMENT '操作描述',
  `user_name` varchar(50) NOT NULL DEFAULT '' COMMENT '操作用户',
  `start_time` datetime NOT NULL COMMENT '操作时间',
  `spend_time` int(11) NOT NULL COMMENT '消耗时间',
  `base_path` varchar(500) NOT NULL DEFAULT '' COMMENT '根路径',
  `uri` varchar(500) NOT NULL DEFAULT '' COMMENT 'URI',
  `url` varchar(500) NOT NULL DEFAULT '' COMMENT 'URL',
  `method` varchar(10) NOT NULL COMMENT '请求类型',
  `parameter` mediumtext,
  `user_agent` varchar(500) NOT NULL COMMENT '用户标识',
  `ip` varchar(30) NOT NULL COMMENT 'IP地址',
  `result` mediumtext,
  PRIMARY KEY (`log_id`) USING BTREE,
  KEY `log_id` (`log_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=32252 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='操作日志';

-- ----------------------------
-- Table structure for admin_organization
-- ----------------------------
DROP TABLE IF EXISTS `admin_organization`;
CREATE TABLE `admin_organization` (
  `organization_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `parent_id` int(11) NOT NULL COMMENT '父主键',
  `name` varchar(100) NOT NULL COMMENT '组织名称',
  `description` varchar(100) NOT NULL COMMENT '组织描述',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`organization_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='用户组织';

-- ----------------------------
-- Records of admin_organization
-- ----------------------------
BEGIN;
INSERT INTO `admin_organization` VALUES (1, 0, '后台管理权限', '后台管理权限', '2019-12-17 18:03:19', '2019-12-17 18:03:22');
INSERT INTO `admin_organization` VALUES (4, 0, 'test222', '44444', '2020-01-02 19:59:17', '2020-01-03 23:33:50');
COMMIT;

-- ----------------------------
-- Table structure for admin_permission
-- ----------------------------
DROP TABLE IF EXISTS `admin_permission`;
CREATE TABLE `admin_permission` (
  `permission_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `system_id` int(11) NOT NULL COMMENT '所属系统',
  `parent_id` int(11) NOT NULL DEFAULT '0' COMMENT '所属上级',
  `name` varchar(20) NOT NULL COMMENT '名称',
  `type` tinyint(4) NOT NULL DEFAULT '1' COMMENT '类型(1:目录,2:菜单,3:按钮)',
  `permission_value` varchar(50) NOT NULL DEFAULT '' COMMENT '权限值',
  `uri` varchar(100) NOT NULL DEFAULT '' COMMENT '路径',
  `icon` varchar(50) NOT NULL DEFAULT '' COMMENT '图标',
  `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '状态(2禁止,1:正常)',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`permission_id`),
  KEY `FK_Reference_19` (`system_id`)
) ENGINE=InnoDB AUTO_INCREMENT=270 DEFAULT CHARSET=utf8 COMMENT='权限';

-- ----------------------------
-- Records of admin_permission
-- ----------------------------
BEGIN;
INSERT INTO `admin_permission` VALUES (1, 1, 0, '系统组织管理', 1, '\'\'', '\'\'', 'zmdi zmdi-accounts-list ', 1, '2019-12-18 10:42:37');
INSERT INTO `admin_permission` VALUES (2, 1, 1, '系统管理', 2, 'admin:system:read', '/manage/system/index', '\'\'', 1, '2019-12-18 10:43:56');
INSERT INTO `admin_permission` VALUES (3, 1, 1, '组织管理', 2, 'admin:organization:read', '/manage/organization/index', '\'\'', 1, '2019-12-18 14:32:49');
INSERT INTO `admin_permission` VALUES (4, 1, 0, '角色用户管理', 1, '\'\'', '\'\'', 'zmdi zmdi-accounts', 1, '2019-12-18 14:34:33');
INSERT INTO `admin_permission` VALUES (5, 1, 4, '角色管理', 2, 'admin:role:read', '/manage/role/index', '\'\'', 1, '2019-12-18 14:35:28');
INSERT INTO `admin_permission` VALUES (6, 1, 4, '用户管理', 2, 'admin:user:read', '/manage/user/index', '\'\'', 1, '2019-12-18 14:36:12');
INSERT INTO `admin_permission` VALUES (7, 1, 0, '权限资源管理', 1, '\'\'', '\'\'', 'zmdi zmdi-lock-outline', 1, '2019-12-18 14:36:50');
INSERT INTO `admin_permission` VALUES (8, 1, 0, '其他数据管理', 1, '\'\'', '\'\'', 'zmdi zmdi-more', 1, '2019-12-18 14:40:09');
INSERT INTO `admin_permission` VALUES (9, 1, 8, '会话管理', 2, 'admin:session:read', '/manage/session/index', '\'\'', 1, '2019-12-18 14:40:57');
INSERT INTO `admin_permission` VALUES (10, 1, 8, '日志记录', 2, 'admin:log:read', '/manage/log/index', '\'\'', 1, '2019-12-18 14:41:31');
INSERT INTO `admin_permission` VALUES (11, 1, 2, '新增系统', 3, 'admin:system:create', '/manage/system/create', 'zmdi zmdi-plus', 1, '2019-12-18 14:43:15');
INSERT INTO `admin_permission` VALUES (12, 1, 2, '编辑系统', 3, 'admin:system:update', '/manage/system/update', 'zmdi zmdi-edit', 1, '2019-12-18 14:43:54');
INSERT INTO `admin_permission` VALUES (13, 1, 2, '删除系统', 3, 'admin:system:delete', '/manage/system/delete', 'zmdi zmdi-close', 1, '2019-12-18 14:44:33');
INSERT INTO `admin_permission` VALUES (14, 1, 3, '新增组织', 3, 'admin:organization:create', '/manage/organization/create', 'zmdi zmdi-plus', 1, '2019-12-18 14:45:19');
INSERT INTO `admin_permission` VALUES (15, 1, 3, '编辑组织', 3, 'admin:organization:update', '/manage/organization/update', 'zmdi zmdi-edit', 1, '2019-12-18 14:45:51');
INSERT INTO `admin_permission` VALUES (16, 1, 3, '删除组织', 3, 'admin:organization:delete', '/manage/organization/delete', 'zmdi zmdi-close', 1, '2019-12-18 14:46:27');
INSERT INTO `admin_permission` VALUES (17, 1, 6, '新增用户', 3, 'admin:user:create', '/manage/user/create', 'zmdi zmdi-plus', 1, '2019-12-18 14:47:37');
INSERT INTO `admin_permission` VALUES (18, 1, 6, '编辑用户', 3, 'admin:user:update', '/manage/user/update', 'zmdi zmdi-edit', 1, '2019-12-18 14:48:15');
INSERT INTO `admin_permission` VALUES (19, 1, 6, '删除用户', 3, 'admin:user:delete', '/manage/user/delete', 'zmdi zmdi-close', 1, '2019-12-18 14:48:51');
INSERT INTO `admin_permission` VALUES (20, 1, 6, '用户组织', 3, 'admin:user:organization', '/manage/user/organization', 'zmdi zmdi-accounts-list', 1, '2019-12-18 14:49:39');
INSERT INTO `admin_permission` VALUES (21, 1, 6, '用户角色', 3, 'admin:user:role', '/manage/user/role', 'zmdi zmdi-accounts', 1, '2019-12-18 14:50:14');
INSERT INTO `admin_permission` VALUES (22, 1, 6, '用户权限', 3, 'admin:user:permission', '/manage/user/permission', 'zmdi zmdi-key', 1, '2019-12-18 14:50:44');
INSERT INTO `admin_permission` VALUES (23, 1, 5, '新增角色', 3, 'admin:role:create', '/manage/role/create', 'zmdi zmdi-plus', 1, '2019-12-18 14:52:00');
INSERT INTO `admin_permission` VALUES (24, 1, 5, '编辑角色', 3, 'admin:role:update', '/manage/role/update', 'zmdi zmdi-edit', 1, '2019-12-18 14:52:28');
INSERT INTO `admin_permission` VALUES (25, 1, 5, '删除角色', 3, 'admin:role:delete', '/manage/role/delete', 'zmdi zmdi-close', 1, '2019-12-18 14:53:02');
INSERT INTO `admin_permission` VALUES (26, 1, 5, '角色权限', 3, 'admin:role:permission', '/manage/role/permission', 'zmdi zmdi-key', 1, '2019-12-18 14:53:40');
INSERT INTO `admin_permission` VALUES (27, 1, 7, '权限管理', 2, 'admin:permission:read', '/manage/permission/index', '‘’', 1, '2019-12-18 14:54:36');
INSERT INTO `admin_permission` VALUES (28, 1, 27, '新增权限', 3, 'admin:permission:create', '/permission/create', 'zmdi zmdi-plus', 1, '2020-01-03 20:10:52');
INSERT INTO `admin_permission` VALUES (244, 1, 27, '编辑权限', 3, 'admin:permission:update', '/permission/update', 'zmdi zmdi-edit', 1, '2020-01-03 20:13:50');
INSERT INTO `admin_permission` VALUES (245, 1, 27, '删除权限', 3, 'admin:permission:delete', '/permission/delete', 'zmdi zmdi-close', 1, '2020-01-03 20:18:07');
INSERT INTO `admin_permission` VALUES (246, 2, 0, '代理商管理', 1, '', '', 'zmdi zmdi-accounts-list', 1, '2020-01-05 14:34:48');
INSERT INTO `admin_permission` VALUES (247, 2, 246, '代理商管理', 2, 'pattern:agent:read', '/manage/agent/index', '', 1, '2020-01-05 14:38:18');
INSERT INTO `admin_permission` VALUES (248, 2, 247, '新增代理商', 3, 'pattern:agent:create', '/manage/agent/create', 'zmdi zmdi-plus', 1, '2020-01-05 14:39:12');
INSERT INTO `admin_permission` VALUES (249, 2, 247, '编辑代理商', 3, 'pattern:agent:update', '/manage/agent/update', 'zmdi zmdi-edit', 1, '2020-01-05 14:40:12');
INSERT INTO `admin_permission` VALUES (250, 2, 247, '删除代理商', 3, 'pattern:agent:delete', '/manage/agent/delete', 'zmdi zmdi-close', 1, '2020-01-05 14:40:41');
INSERT INTO `admin_permission` VALUES (251, 2, 0, '渠道管理', 1, '', '', 'zmdi zmdi-paypal', 1, '2020-01-05 14:41:24');
INSERT INTO `admin_permission` VALUES (252, 2, 247, '编辑门店', 3, 'pattern:shop:update', '/manage/shop/update', 'zmdi zmdi-plus', 1, '2020-01-05 15:38:29');
INSERT INTO `admin_permission` VALUES (253, 2, 247, '查看商户', 3, 'pattern:customer:red', '/manage/customer/index', 'zmdi zmdi-plus', 1, '2020-01-05 15:40:34');
INSERT INTO `admin_permission` VALUES (254, 2, 246, '门店管理', 2, 'pattern:shop:read', '/manage/shop/list', 'zmdi zmdi-accounts-list', 1, '2020-01-08 22:21:28');
INSERT INTO `admin_permission` VALUES (255, 2, 247, '新增门店', 3, 'pattern:shop:create', '/manage/shop/create', ',zmdi zmdi-plus', 1, '2020-01-08 23:12:13');
INSERT INTO `admin_permission` VALUES (256, 2, 254, '编辑', 3, 'pattern:shop:update', '/manage/shop/update', 'zmdi zmdi-edit', 1, '2020-01-08 23:13:00');
INSERT INTO `admin_permission` VALUES (257, 2, 254, '删除', 3, 'pattern:shop:delete', '/manage/shop/delete', 'zmdi zmdi-close', 1, '2020-01-08 23:13:39');
INSERT INTO `admin_permission` VALUES (258, 2, 246, '商户管理', 2, 'pattern:customer:read', '/manage/customer/index', 'zmdi zmdi-accounts-list,zmdi zmdi-accounts-list', 1, '2020-01-09 23:05:47');
INSERT INTO `admin_permission` VALUES (259, 2, 247, '编辑商户', 3, 'pattern:customer:update', '/manage/customer/update', 'zmdi zmdi-widgets', 1, '2020-01-11 20:49:05');
INSERT INTO `admin_permission` VALUES (260, 2, 247, '新增商户', 3, 'pattern:customer:create', '/manage/customer/create', 'zmdi zmdi-widgets', 1, '2020-01-11 20:55:18');
INSERT INTO `admin_permission` VALUES (261, 2, 251, '支付渠道', 2, 'pattern:paymentchannel:read', '/manage/paymentchannel/index', 'zmdi zmdi-widgets', 1, '2020-01-12 15:25:45');
INSERT INTO `admin_permission` VALUES (262, 2, 261, '新增渠道', 3, 'pattern:paymentchannel:create', '/manage/paymentchannel/create', 'zmdi zmdi-plus', 1, '2020-01-12 15:27:21');
INSERT INTO `admin_permission` VALUES (263, 2, 261, '编辑渠道', 3, 'pattern:paymentchannel:update', '/manage/paymentchannel/update', 'zmdi zmdi-edit', 1, '2020-01-12 15:28:22');
INSERT INTO `admin_permission` VALUES (264, 2, 261, '添加账号', 3, 'pattern:paymentchannelaccount:create', '/manage/paymentchannelaccount/create', 'zmdi zmdi-plus', 1, '2020-01-12 15:29:50');
INSERT INTO `admin_permission` VALUES (265, 2, 261, '查看账号', 3, 'pattern:paymentchannelaccount:red', '/manage/paymentchannelaccount/list', 'zmdi zmdi-widgets', 1, '2020-01-12 15:31:02');
INSERT INTO `admin_permission` VALUES (266, 2, 261, '编辑账号', 3, 'pattern:paymentchannelaccount:update', '/manage/paymentchannelaccount/update', 'zmdi zmdi-widgets', 1, '2020-01-12 15:31:45');
INSERT INTO `admin_permission` VALUES (267, 2, 261, '查看账号参数', 3, 'pattern:paymentchannelaccountpara:red', '/manage/paymentchannelaccountpara/index', 'zmdi zmdi-widgets', 1, '2020-01-12 15:33:24');
INSERT INTO `admin_permission` VALUES (268, 2, 261, '编辑账号参数', 3, 'pattern:paymentchannelaccountpara:update', '/manage/paymentchannelaccountpara/update', 'zmdi zmdi-widgets', 1, '2020-01-12 15:34:16');
INSERT INTO `admin_permission` VALUES (269, 2, 261, '新增账号参数', 3, 'pattern:paymentchannelaccountpara:create', '/manage/paymentchannelaccountpara/create', 'zmdi zmdi-widgets', 1, '2020-01-12 15:35:04');
COMMIT;

-- ----------------------------
-- Table structure for admin_role
-- ----------------------------
DROP TABLE IF EXISTS `admin_role`;
CREATE TABLE `admin_role` (
  `role_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `name` varchar(20) NOT NULL COMMENT '角色名称',
  `title` varchar(20) NOT NULL COMMENT '角色标题',
  `description` varchar(200) NOT NULL DEFAULT '' COMMENT '角色描述',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '状态1：启用2：停用',
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COMMENT='角色';

-- ----------------------------
-- Records of admin_role
-- ----------------------------
BEGIN;
INSERT INTO `admin_role` VALUES (1, '超级管理员', '超级管理员', '超级管理员', '2019-12-18 09:53:26', '2019-12-18 09:53:29', 1);
COMMIT;

-- ----------------------------
-- Table structure for admin_role_permission
-- ----------------------------
DROP TABLE IF EXISTS `admin_role_permission`;
CREATE TABLE `admin_role_permission` (
  `role_permission_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `role_id` int(11) NOT NULL COMMENT '角色编号',
  `permission_id` int(11) NOT NULL COMMENT '权限编号',
  PRIMARY KEY (`role_permission_id`),
  KEY `FK_Reference_17` (`role_id`),
  KEY `FK_Reference_18` (`permission_id`)
) ENGINE=InnoDB AUTO_INCREMENT=493 DEFAULT CHARSET=utf8 COMMENT='角色权限关联表';

-- ----------------------------
-- Records of admin_role_permission
-- ----------------------------
BEGIN;
INSERT INTO `admin_role_permission` VALUES (1, 1, 1);
INSERT INTO `admin_role_permission` VALUES (2, 1, 2);
INSERT INTO `admin_role_permission` VALUES (3, 1, 3);
INSERT INTO `admin_role_permission` VALUES (4, 1, 4);
INSERT INTO `admin_role_permission` VALUES (5, 1, 5);
INSERT INTO `admin_role_permission` VALUES (6, 1, 6);
INSERT INTO `admin_role_permission` VALUES (7, 1, 7);
INSERT INTO `admin_role_permission` VALUES (8, 1, 8);
INSERT INTO `admin_role_permission` VALUES (9, 1, 9);
INSERT INTO `admin_role_permission` VALUES (10, 1, 10);
INSERT INTO `admin_role_permission` VALUES (11, 1, 11);
INSERT INTO `admin_role_permission` VALUES (12, 1, 12);
INSERT INTO `admin_role_permission` VALUES (13, 1, 13);
INSERT INTO `admin_role_permission` VALUES (14, 1, 14);
INSERT INTO `admin_role_permission` VALUES (15, 1, 15);
INSERT INTO `admin_role_permission` VALUES (16, 1, 16);
INSERT INTO `admin_role_permission` VALUES (17, 1, 17);
INSERT INTO `admin_role_permission` VALUES (18, 1, 18);
INSERT INTO `admin_role_permission` VALUES (19, 1, 19);
INSERT INTO `admin_role_permission` VALUES (20, 1, 20);
INSERT INTO `admin_role_permission` VALUES (21, 1, 21);
INSERT INTO `admin_role_permission` VALUES (22, 1, 22);
INSERT INTO `admin_role_permission` VALUES (23, 1, 23);
INSERT INTO `admin_role_permission` VALUES (24, 1, 24);
INSERT INTO `admin_role_permission` VALUES (25, 1, 25);
INSERT INTO `admin_role_permission` VALUES (26, 1, 26);
INSERT INTO `admin_role_permission` VALUES (27, 1, 27);
INSERT INTO `admin_role_permission` VALUES (466, 1, 28);
INSERT INTO `admin_role_permission` VALUES (467, 1, 244);
INSERT INTO `admin_role_permission` VALUES (468, 1, 245);
INSERT INTO `admin_role_permission` VALUES (469, 1, 246);
INSERT INTO `admin_role_permission` VALUES (470, 1, 247);
INSERT INTO `admin_role_permission` VALUES (471, 1, 248);
INSERT INTO `admin_role_permission` VALUES (472, 1, 249);
INSERT INTO `admin_role_permission` VALUES (473, 1, 250);
INSERT INTO `admin_role_permission` VALUES (474, 1, 251);
INSERT INTO `admin_role_permission` VALUES (475, 1, 252);
INSERT INTO `admin_role_permission` VALUES (476, 1, 253);
INSERT INTO `admin_role_permission` VALUES (477, 1, 254);
INSERT INTO `admin_role_permission` VALUES (478, 1, 255);
INSERT INTO `admin_role_permission` VALUES (479, 1, 256);
INSERT INTO `admin_role_permission` VALUES (480, 1, 257);
INSERT INTO `admin_role_permission` VALUES (481, 1, 258);
INSERT INTO `admin_role_permission` VALUES (482, 1, 259);
INSERT INTO `admin_role_permission` VALUES (483, 1, 260);
INSERT INTO `admin_role_permission` VALUES (484, 1, 261);
INSERT INTO `admin_role_permission` VALUES (485, 1, 262);
INSERT INTO `admin_role_permission` VALUES (486, 1, 263);
INSERT INTO `admin_role_permission` VALUES (487, 1, 264);
INSERT INTO `admin_role_permission` VALUES (488, 1, 265);
INSERT INTO `admin_role_permission` VALUES (489, 1, 266);
INSERT INTO `admin_role_permission` VALUES (490, 1, 267);
INSERT INTO `admin_role_permission` VALUES (491, 1, 268);
INSERT INTO `admin_role_permission` VALUES (492, 1, 269);
COMMIT;

-- ----------------------------
-- Table structure for admin_system
-- ----------------------------
DROP TABLE IF EXISTS `admin_system`;
CREATE TABLE `admin_system` (
  `system_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `icon` varchar(50) NOT NULL,
  `banner` varchar(150) NOT NULL,
  `theme` varchar(50) NOT NULL,
  `basepath` varchar(100) NOT NULL,
  `status` tinyint(4) NOT NULL,
  `name` varchar(20) NOT NULL,
  `title` varchar(20) NOT NULL,
  `description` varchar(20) NOT NULL,
  `create_time` datetime NOT NULL,
  `update_time` datetime NOT NULL,
  PRIMARY KEY (`system_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COMMENT='系统';

-- ----------------------------
-- Records of admin_system
-- ----------------------------
BEGIN;
INSERT INTO `admin_system` VALUES (1, 'zmdi zmdi-shield-security', '/resources/images/zheng-upms.png', '#29A176', 'http://localhost:9001', 1, '权限管理系统', '权限管理系统', '权限管理系统', '2019-12-18 09:54:54', '2019-12-18 09:54:58');
INSERT INTO `admin_system` VALUES (2, 'zmdi zmdi-shield-security', '/resources/images/zheng-pay.png', '#29A176', 'http://localhost:9002', 1, '运营后台管理系统', '运营后台管理系统', '运营后台管理系统', '2020-01-05 13:40:30', '2020-01-05 13:44:17');
COMMIT;

-- ----------------------------
-- Table structure for admin_user
-- ----------------------------
DROP TABLE IF EXISTS `admin_user`;
CREATE TABLE `admin_user` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `user_name` varchar(20) NOT NULL COMMENT '帐号',
  `password` varchar(35) NOT NULL COMMENT '密码MD5(密码+盐)',
  `salt` varchar(150) NOT NULL COMMENT '盐',
  `real_name` varchar(20) NOT NULL COMMENT '姓名',
  `avatar` varchar(150) NOT NULL COMMENT '头像',
  `phone` varchar(20) NOT NULL COMMENT '电话',
  `email` varchar(30) NOT NULL COMMENT '邮箱',
  `sex` tinyint(4) NOT NULL COMMENT '性别（1：男，2：女）',
  `locked` tinyint(4) NOT NULL COMMENT '状态(1:锁定,2:正常)',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `user_type` tinyint(4) NOT NULL DEFAULT '0' COMMENT '用户类型（0：管理员，1：普通用户）',
  `agent_id` int(11) DEFAULT NULL COMMENT '代理商、商户、门店ID',
  `level` tinyint(4) DEFAULT NULL COMMENT '0:代理商1:商户2:门店',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=118 DEFAULT CHARSET=utf8 COMMENT='用户';

-- ----------------------------
-- Records of admin_user
-- ----------------------------
BEGIN;
INSERT INTO `admin_user` VALUES (1, 'admin', '26139E3EEDB90F7E66FA00E50A2F25C4', '123456', '安拉', '/resources/images/avatar.jpg', '110', '110', 1, 0, '2019-12-31 16:39:23', '2019-12-31 16:39:26', 0, 1, 1);
INSERT INTO `admin_user` VALUES (116, 'test', '7479E1234A7F63C97CC590AB300CEC32', '9DDCA4600F584985B575F8FC719C818E', 'test', 'test', '110', '111', 1, 0, '2020-01-04 00:50:00', '2020-01-04 00:50:00', 0, NULL, 0);
COMMIT;

-- ----------------------------
-- Table structure for admin_user_organization
-- ----------------------------
DROP TABLE IF EXISTS `admin_user_organization`;
CREATE TABLE `admin_user_organization` (
  `user_organization_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `user_id` int(11) NOT NULL COMMENT '用户编号',
  `organization_id` int(11) NOT NULL COMMENT '组织编号',
  PRIMARY KEY (`user_organization_id`),
  KEY `FK_Reference_15` (`user_id`),
  KEY `FK_Reference_16` (`organization_id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8 COMMENT='用户组织关联表';

-- ----------------------------
-- Records of admin_user_organization
-- ----------------------------
BEGIN;
INSERT INTO `admin_user_organization` VALUES (1, 1, 1);
INSERT INTO `admin_user_organization` VALUES (2, 3, 1);
COMMIT;

-- ----------------------------
-- Table structure for admin_user_permission
-- ----------------------------
DROP TABLE IF EXISTS `admin_user_permission`;
CREATE TABLE `admin_user_permission` (
  `user_permission_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `user_id` int(11) NOT NULL COMMENT '用户编号',
  `permission_id` int(11) NOT NULL COMMENT '权限编号',
  `type` tinyint(4) NOT NULL COMMENT '权限类型(1:减权限,2:增权限)',
  PRIMARY KEY (`user_permission_id`),
  KEY `FK_Reference_13` (`user_id`),
  KEY `FK_Reference_14` (`permission_id`)
) ENGINE=InnoDB AUTO_INCREMENT=775 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of admin_user_permission
-- ----------------------------
BEGIN;
INSERT INTO `admin_user_permission` VALUES (1, 3, 1, 1);
INSERT INTO `admin_user_permission` VALUES (2, 3, 2, 1);
INSERT INTO `admin_user_permission` VALUES (3, 3, 11, 1);
INSERT INTO `admin_user_permission` VALUES (4, 3, 12, 1);
INSERT INTO `admin_user_permission` VALUES (5, 3, 13, 1);
INSERT INTO `admin_user_permission` VALUES (6, 3, 3, 1);
INSERT INTO `admin_user_permission` VALUES (7, 3, 14, 1);
INSERT INTO `admin_user_permission` VALUES (8, 3, 15, 1);
INSERT INTO `admin_user_permission` VALUES (9, 3, 16, 1);
INSERT INTO `admin_user_permission` VALUES (10, 3, 4, 1);
INSERT INTO `admin_user_permission` VALUES (11, 3, 5, 1);
INSERT INTO `admin_user_permission` VALUES (12, 3, 23, 1);
INSERT INTO `admin_user_permission` VALUES (13, 3, 24, 1);
INSERT INTO `admin_user_permission` VALUES (14, 3, 25, 1);
INSERT INTO `admin_user_permission` VALUES (15, 3, 26, 1);
INSERT INTO `admin_user_permission` VALUES (16, 3, 6, 1);
INSERT INTO `admin_user_permission` VALUES (17, 3, 17, 1);
INSERT INTO `admin_user_permission` VALUES (18, 3, 18, 1);
INSERT INTO `admin_user_permission` VALUES (19, 3, 19, 1);
INSERT INTO `admin_user_permission` VALUES (20, 3, 20, 1);
INSERT INTO `admin_user_permission` VALUES (21, 3, 21, 1);
INSERT INTO `admin_user_permission` VALUES (22, 3, 22, 1);
INSERT INTO `admin_user_permission` VALUES (23, 3, 17, 1);
INSERT INTO `admin_user_permission` VALUES (24, 3, 18, 1);
INSERT INTO `admin_user_permission` VALUES (25, 3, 19, 1);
INSERT INTO `admin_user_permission` VALUES (26, 3, 20, 1);
INSERT INTO `admin_user_permission` VALUES (27, 3, 21, 1);
INSERT INTO `admin_user_permission` VALUES (28, 3, 22, 1);
INSERT INTO `admin_user_permission` VALUES (29, 3, 11, 1);
INSERT INTO `admin_user_permission` VALUES (30, 3, 9, 1);
INSERT INTO `admin_user_permission` VALUES (31, 3, 10, 1);
INSERT INTO `admin_user_permission` VALUES (761, 116, 1, 1);
INSERT INTO `admin_user_permission` VALUES (762, 116, 2, 1);
INSERT INTO `admin_user_permission` VALUES (763, 116, 14, 1);
INSERT INTO `admin_user_permission` VALUES (764, 116, 3, 1);
INSERT INTO `admin_user_permission` VALUES (765, 116, 5, 1);
INSERT INTO `admin_user_permission` VALUES (766, 116, 4, 1);
INSERT INTO `admin_user_permission` VALUES (767, 1, 246, 1);
INSERT INTO `admin_user_permission` VALUES (768, 1, 247, 1);
INSERT INTO `admin_user_permission` VALUES (769, 1, 248, 1);
INSERT INTO `admin_user_permission` VALUES (770, 1, 249, 1);
INSERT INTO `admin_user_permission` VALUES (771, 1, 250, 1);
INSERT INTO `admin_user_permission` VALUES (772, 1, 252, 1);
INSERT INTO `admin_user_permission` VALUES (773, 1, 253, 1);
INSERT INTO `admin_user_permission` VALUES (774, 1, 251, 1);
COMMIT;

-- ----------------------------
-- Table structure for admin_user_role
-- ----------------------------
DROP TABLE IF EXISTS `admin_user_role`;
CREATE TABLE `admin_user_role` (
  `user_role_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `user_id` int(11) NOT NULL COMMENT '用户编号',
  `role_id` int(11) NOT NULL COMMENT '角色编号',
  PRIMARY KEY (`user_role_id`),
  KEY `FK_Reference_11` (`user_id`),
  KEY `FK_Reference_12` (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=86 DEFAULT CHARSET=utf8 COMMENT='用户角色关联表';

-- ----------------------------
-- Records of admin_user_role
-- ----------------------------
BEGIN;
INSERT INTO `admin_user_role` VALUES (1, 1, 1);
INSERT INTO `admin_user_role` VALUES (2, 3, 1);
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
