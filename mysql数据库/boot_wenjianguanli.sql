-- --------------------------------------------------------
-- 主机:                           127.0.0.1
-- Server version:               10.3.14-MariaDB - MariaDB Server
-- Server OS:                    Linux
-- HeidiSQL 版本:                  10.1.0.5464
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Dumping database structure for boot_wenjianguanli
CREATE DATABASE IF NOT EXISTS `boot_wenjianguanli` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci */;
USE `boot_wenjianguanli`;

-- Dumping structure for table boot_wenjianguanli.auth
DROP TABLE IF EXISTS `auth`;
CREATE TABLE IF NOT EXISTS `auth` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `is_uploadable` int(11) NOT NULL DEFAULT 1 COMMENT '是否可以上传（需要判断对应的文件是否是文件夹），0不可以，1可以',
  `is_deletable` int(11) NOT NULL DEFAULT 1 COMMENT '是否可以删除，0不可以，1可以',
  `is_updatable` int(11) NOT NULL DEFAULT 1 COMMENT '是否可以更新，0不可以，1可以',
  `user_id` int(11) NOT NULL,
  `file_id` bigint(20) NOT NULL,
  `is_visible` int(11) NOT NULL DEFAULT 1 COMMENT '是否可以查看，0不可以，1可以',
  `is_downloadable` int(11) NOT NULL DEFAULT 1 COMMENT '用户是否可以下载，0不可以，1可以',
  `create_time` datetime NOT NULL DEFAULT current_timestamp() COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `fk_auth_user1_idx` (`user_id`),
  KEY `fk_auth_file1_idx` (`file_id`),
  CONSTRAINT `fk_auth_file1` FOREIGN KEY (`file_id`) REFERENCES `file` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_auth_user1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='用户对应指定文件的权限表，覆盖用户表的权限';

-- Dumping data for table boot_wenjianguanli.auth: ~3 rows (approximately)
/*!40000 ALTER TABLE `auth` DISABLE KEYS */;
INSERT INTO `auth` (`id`, `is_uploadable`, `is_deletable`, `is_updatable`, `user_id`, `file_id`, `is_visible`, `is_downloadable`, `create_time`) VALUES
	(3, 1, 1, 1, 2, 6, 1, 1, '2019-08-19 09:11:15'),
	(4, 1, 1, 1, 3, 7, 1, 1, '2019-08-19 09:24:50');
/*!40000 ALTER TABLE `auth` ENABLE KEYS */;

-- Dumping structure for table boot_wenjianguanli.category
DROP TABLE IF EXISTS `category`;
CREATE TABLE IF NOT EXISTS `category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `create_time` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_UNIQUE` (`name`),
  UNIQUE KEY `cat_id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='文件分类';

-- Dumping data for table boot_wenjianguanli.category: ~7 rows (approximately)
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` (`id`, `name`, `create_time`) VALUES
	(1, '图片', '2019-08-19 08:34:37'),
	(2, '视频', '2019-08-19 08:35:37'),
	(3, '文档', '2019-08-19 08:35:47'),
	(4, '软件', '2019-08-19 08:35:52'),
	(5, '压缩包', '2019-08-19 08:36:03'),
	(6, '其他', '2019-08-19 08:36:12'),
	(7, '资源', '2019-08-19 09:12:25');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;

-- Dumping structure for table boot_wenjianguanli.download
DROP TABLE IF EXISTS `download`;
CREATE TABLE IF NOT EXISTS `download` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `create_time` datetime NOT NULL DEFAULT current_timestamp() COMMENT '下载时间',
  `user_id` int(11) NOT NULL,
  `file_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `fk_download_user1_idx` (`user_id`),
  KEY `fk_download_file1_idx` (`file_id`),
  CONSTRAINT `fk_download_file1` FOREIGN KEY (`file_id`) REFERENCES `file` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_download_user1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='下载历史表';

-- Dumping data for table boot_wenjianguanli.download: ~5 rows (approximately)
/*!40000 ALTER TABLE `download` DISABLE KEYS */;
INSERT INTO `download` (`id`, `create_time`, `user_id`, `file_id`) VALUES
	(5, '2019-08-19 09:11:41', 2, 6),
	(6, '2019-08-19 09:12:14', 2, 6),
	(7, '2019-08-19 09:41:01', 2, 6),
	(8, '2019-08-19 09:41:01', 2, 6);
/*!40000 ALTER TABLE `download` ENABLE KEYS */;

-- Dumping structure for table boot_wenjianguanli.file
DROP TABLE IF EXISTS `file`;
CREATE TABLE IF NOT EXISTS `file` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `name` varchar(256) COLLATE utf8_unicode_ci DEFAULT '' COMMENT '文件名',
  `suffix` varchar(16) COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '文件后缀',
  `local_url` varchar(124) COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '本地路径',
  `visit_url` varchar(124) COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '客户端访问路径',
  `size` bigint(20) NOT NULL DEFAULT 0 COMMENT '文件大小，单位bit',
  `create_time` datetime NOT NULL DEFAULT current_timestamp() COMMENT '创建时间',
  `description` varchar(124) COLLATE utf8_unicode_ci DEFAULT '' COMMENT '文件描述',
  `check_times` int(11) NOT NULL DEFAULT 0 COMMENT '查看次数',
  `download_times` int(11) NOT NULL DEFAULT 0 COMMENT '下载次数',
  `tag` varchar(45) COLLATE utf8_unicode_ci DEFAULT '' COMMENT '文件标签',
  `user_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `is_downloadable` int(11) NOT NULL DEFAULT 1 COMMENT '（全局权限）文件是否可以下载，0不可以，1可以',
  `is_uploadable` int(11) NOT NULL DEFAULT 1 COMMENT '（全局权限）文件夹是否允许上传（需要判断文件是否是文件夹），0不可以，1可以',
  `is_visible` int(11) NOT NULL DEFAULT 1 COMMENT '（全局权限）文件是否可见，0不可以，1可以',
  `is_deletable` int(11) NOT NULL DEFAULT 1 COMMENT '（全局权限）文件是否可以删除，0不可以，1可以',
  `is_updatable` int(11) NOT NULL DEFAULT 1 COMMENT '（全局权限）文件是否可以更新，0不可以，1可以',
  `last_modify_time` datetime NOT NULL DEFAULT current_timestamp() COMMENT '最近一次修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `file_id_UNIQUE` (`id`),
  UNIQUE KEY `local_url_UNIQUE` (`local_url`),
  UNIQUE KEY `visit_url_UNIQUE` (`visit_url`),
  KEY `fk_file_user_idx` (`user_id`),
  KEY `fk_file_category1_idx` (`category_id`),
  CONSTRAINT `fk_file_category1` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_file_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='文件列表';

-- Dumping data for table boot_wenjianguanli.file: ~3 rows (approximately)
/*!40000 ALTER TABLE `file` DISABLE KEYS */;
INSERT INTO `file` (`id`, `name`, `suffix`, `local_url`, `visit_url`, `size`, `create_time`, `description`, `check_times`, `download_times`, `tag`, `user_id`, `category_id`, `is_downloadable`, `is_uploadable`, `is_visible`, `is_deletable`, `is_updatable`, `last_modify_time`) VALUES
	(6, 'JAVAEE环境配置视频.mp4', 'mp4', '/root/Desktop/upload/20190819/JAVAEE环境配置视频.mp4', '/file/2019/08/19/899218815.mp4', 54549977, '2019-08-19 09:11:15', 'java教程', 0, 6, '教程,JAVA', 2, 2, 1, 1, 1, 1, 1, '2019-08-19 09:11:15'),
	(7, '3.png', 'png', '/root/Desktop/upload/20190819/3.png', '/file/2019/08/19/681171448.png', 437087, '2019-08-19 09:24:50', '', 0, 0, '', 3, 1, 1, 1, 1, 1, 1, '2019-08-19 09:24:50');
/*!40000 ALTER TABLE `file` ENABLE KEYS */;

-- Dumping structure for table boot_wenjianguanli.user
DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '用户编号',
  `username` varchar(16) COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '用户名',
  `real_name` varchar(45) COLLATE utf8_unicode_ci DEFAULT '' COMMENT '真实姓名',
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '邮箱地址',
  `password` varchar(128) COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '登录密码',
  `permission` int(11) NOT NULL DEFAULT 1 COMMENT '0（禁止登录），1（正常，普通用户），2（正常，管理员），3（正常，超级管理员）',
  `create_time` datetime NOT NULL DEFAULT current_timestamp() COMMENT '注册时间',
  `last_login_time` datetime NOT NULL DEFAULT current_timestamp() COMMENT '最后一次登录时间',
  `is_downloadable` int(11) NOT NULL DEFAULT 1 COMMENT '（全局权限）用户是否可以下载，0不可以，1可以',
  `is_uploadable` int(11) NOT NULL DEFAULT 1 COMMENT '（全局权限）用户是否可以上传，0不可以，1可以',
  `is_visible` int(11) NOT NULL DEFAULT 1 COMMENT '（全局权限）用户是否可以查看文件，0不可以，1可以',
  `is_deletable` int(11) NOT NULL DEFAULT 0 COMMENT '（全局权限）用户可以删除文件，0不可以，1可以',
  `is_updatable` int(11) NOT NULL DEFAULT 0 COMMENT '（全局权限）用户是否可以更新文件，0不可以，1可以',
  `avatar` varchar(255) COLLATE utf8_unicode_ci DEFAULT '' COMMENT '头像',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  UNIQUE KEY `username_UNIQUE` (`username`),
  UNIQUE KEY `create_time_UNIQUE` (`create_time`),
  UNIQUE KEY `email_UNIQUE` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='用户表';

-- Dumping data for table boot_wenjianguanli.user: ~2 rows (approximately)
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` (`id`, `username`, `real_name`, `email`, `password`, `permission`, `create_time`, `last_login_time`, `is_downloadable`, `is_uploadable`, `is_visible`, `is_deletable`, `is_updatable`, `avatar`) VALUES
	(2, 'admin', '李四', '1353123688@qq.com', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 3, '2019-08-19 08:33:19', '2019-08-19 09:37:22', 1, 1, 1, 1, 1, '/common/avatar/ayditjcfybqqjdij.png'),
	(3, 'lisi1234', '', '1341341688@qq.com', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 1, '2019-08-19 09:22:25', '2019-08-19 09:22:58', 1, 1, 1, 0, 0, '');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
