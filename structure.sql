/*
 Navicat Premium Data Transfer

 Source Server         : NFT-BOT-HETZNER
 Source Server Type    : MySQL
 Source Server Version : 101104
 Source Host           : 95.216.219.32:3306
 Source Schema         : rbabot

 Target Server Type    : MySQL
 Target Server Version : 101104
 File Encoding         : 65001

 Date: 24/06/2024 15:14:27
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for aauth_group_to_group
-- ----------------------------
DROP TABLE IF EXISTS `aauth_group_to_group`;
CREATE TABLE `aauth_group_to_group`  (
  `group_id` int(10) UNSIGNED NOT NULL,
  `subgroup_id` int(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`group_id`, `subgroup_id`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Table structure for aauth_groups
-- ----------------------------
DROP TABLE IF EXISTS `aauth_groups`;
CREATE TABLE `aauth_groups`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `definition` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for aauth_login_attempts
-- ----------------------------
DROP TABLE IF EXISTS `aauth_login_attempts`;
CREATE TABLE `aauth_login_attempts`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ip_address` varchar(39) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT '0',
  `timestamp` datetime(0) NULL DEFAULT NULL,
  `login_attempts` tinyint(4) NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1041 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for aauth_perm_to_group
-- ----------------------------
DROP TABLE IF EXISTS `aauth_perm_to_group`;
CREATE TABLE `aauth_perm_to_group`  (
  `perm_id` int(10) UNSIGNED NOT NULL,
  `group_id` int(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`perm_id`, `group_id`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Table structure for aauth_perm_to_user
-- ----------------------------
DROP TABLE IF EXISTS `aauth_perm_to_user`;
CREATE TABLE `aauth_perm_to_user`  (
  `perm_id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`perm_id`, `user_id`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Table structure for aauth_perms
-- ----------------------------
DROP TABLE IF EXISTS `aauth_perms`;
CREATE TABLE `aauth_perms`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `definition` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 8 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for aauth_pms
-- ----------------------------
DROP TABLE IF EXISTS `aauth_pms`;
CREATE TABLE `aauth_pms`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `sender_id` int(10) UNSIGNED NOT NULL,
  `receiver_id` int(10) UNSIGNED NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `message` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL,
  `date_sent` datetime(0) NULL DEFAULT NULL,
  `date_read` datetime(0) NULL DEFAULT NULL,
  `pm_deleted_sender` int(11) NULL DEFAULT NULL,
  `pm_deleted_receiver` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `full_index`(`id`, `sender_id`, `receiver_id`, `date_read`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for aauth_user_to_group
-- ----------------------------
DROP TABLE IF EXISTS `aauth_user_to_group`;
CREATE TABLE `aauth_user_to_group`  (
  `user_id` int(10) UNSIGNED NOT NULL,
  `group_id` int(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`user_id`, `group_id`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Table structure for aauth_user_variables
-- ----------------------------
DROP TABLE IF EXISTS `aauth_user_variables`;
CREATE TABLE `aauth_user_variables`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int(10) UNSIGNED NOT NULL,
  `data_key` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `value` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_id_index`(`user_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for aauth_users
-- ----------------------------
DROP TABLE IF EXISTS `aauth_users`;
CREATE TABLE `aauth_users`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `email` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `upass` varchar(60) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `pass` varchar(60) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `username` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `banned` tinyint(1) NULL DEFAULT 0,
  `last_login` datetime(0) NULL DEFAULT NULL,
  `last_activity` datetime(0) NULL DEFAULT NULL,
  `date_created` datetime(0) NULL DEFAULT NULL,
  `forgot_exp` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL,
  `remember_time` datetime(0) NULL DEFAULT NULL,
  `remember_exp` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL,
  `verification_code` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL,
  `totp_secret` varchar(16) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `ip_address` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL,
  `nama` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `session_id` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `foto` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `email`(`email`) USING BTREE,
  UNIQUE INDEX `username`(`username`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 32 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for chain
-- ----------------------------
DROP TABLE IF EXISTS `chain`;
CREATE TABLE `chain`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `short_name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `testnet` tinyint(1) NULL DEFAULT NULL,
  `website` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `explorer_url` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `chain_id` int(10) UNSIGNED NULL DEFAULT NULL,
  `native_symbol` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for ci_sessions
-- ----------------------------
DROP TABLE IF EXISTS `ci_sessions`;
CREATE TABLE `ci_sessions`  (
  `session_id` varchar(40) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '0',
  `ip_address` varchar(16) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '0',
  `user_agent` varchar(150) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `last_activity` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `user_data` mediumtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`session_id`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for tg_campaign
-- ----------------------------
DROP TABLE IF EXISTS `tg_campaign`;
CREATE TABLE `tg_campaign`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `campaign_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `campaign_start_message` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `campaign_start_image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `campaign_continue_message` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `campaign_complete_message` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `campaign_complete_image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `is_active` tinyint(1) UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for tg_campaign_task
-- ----------------------------
DROP TABLE IF EXISTS `tg_campaign_task`;
CREATE TABLE `tg_campaign_task`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `campaign_id` bigint(20) UNSIGNED NULL DEFAULT NULL,
  `task_order` int(11) UNSIGNED NULL DEFAULT NULL,
  `task_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `task_type` enum('default','proof') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'default',
  `task_instruction` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `task_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `task_image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `campaign_id`(`campaign_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for tg_campaign_task_user
-- ----------------------------
DROP TABLE IF EXISTS `tg_campaign_task_user`;
CREATE TABLE `tg_campaign_task_user`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `campaign_task_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NULL DEFAULT NULL,
  `is_done` tinyint(1) NULL DEFAULT NULL,
  `proof` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `created_at` int(11) NULL DEFAULT NULL,
  `done_at` int(11) NULL DEFAULT NULL,
  `is_verified` tinyint(1) UNSIGNED NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `user_id_2`(`user_id`, `campaign_task_id`) USING BTREE,
  INDEX `campaign_task_id`(`campaign_task_id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for tg_campaign_user
-- ----------------------------
DROP TABLE IF EXISTS `tg_campaign_user`;
CREATE TABLE `tg_campaign_user`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `campaign_id` bigint(20) UNSIGNED NULL DEFAULT NULL,
  `user_id` bigint(20) NULL DEFAULT NULL,
  `step` int(11) NULL DEFAULT 0,
  `created_at` int(11) NULL DEFAULT 0,
  `updated_at` int(11) NULL DEFAULT 0,
  `is_verified` tinyint(1) NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `campaign_id_2`(`campaign_id`, `user_id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  INDEX `campaign_id`(`campaign_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for tg_chat
-- ----------------------------
DROP TABLE IF EXISTS `tg_chat`;
CREATE TABLE `tg_chat`  (
  `id` bigint(20) NOT NULL COMMENT 'Unique identifier for this chat',
  `type` enum('private','group','supergroup','channel') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL COMMENT 'Type of chat, can be either private, group, supergroup or channel',
  `title` char(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NULL DEFAULT '' COMMENT 'Title, for supergroups, channels and group chats',
  `username` char(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NULL DEFAULT NULL COMMENT 'Username, for private chats, supergroups and channels if available',
  `first_name` char(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NULL DEFAULT NULL COMMENT 'First name of the other party in a private chat',
  `last_name` char(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NULL DEFAULT NULL COMMENT 'Last name of the other party in a private chat',
  `is_forum` tinyint(1) NULL DEFAULT 0 COMMENT 'True, if the supergroup chat is a forum (has topics enabled)',
  `all_members_are_administrators` tinyint(1) NULL DEFAULT 0 COMMENT 'True if a all members of this group are admins',
  `created_at` timestamp(0) NULL DEFAULT NULL COMMENT 'Entry date creation',
  `updated_at` timestamp(0) NULL DEFAULT NULL COMMENT 'Entry date update',
  `old_id` bigint(20) NULL DEFAULT NULL COMMENT 'Unique chat identifier, this is filled when a group is converted to a supergroup',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `old_id`(`old_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_520_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for tg_config
-- ----------------------------
DROP TABLE IF EXISTS `tg_config`;
CREATE TABLE `tg_config`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `key` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `value` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for tg_daily_task
-- ----------------------------
DROP TABLE IF EXISTS `tg_daily_task`;
CREATE TABLE `tg_daily_task`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `task_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NULL DEFAULT NULL,
  `is_completed` tinyint(1) NULL DEFAULT 0,
  `is_reviewed` tinyint(1) NULL DEFAULT 0,
  `complete_date` int(11) NULL DEFAULT NULL,
  `created_date` int(10) UNSIGNED NULL DEFAULT NULL,
  `send_date` int(11) NULL DEFAULT NULL,
  `send_status` tinyint(1) NOT NULL DEFAULT 0,
  `reason` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `user_proof` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `earn_point` tinyint(1) NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `task_id`(`task_id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 84664 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for tg_group
-- ----------------------------
DROP TABLE IF EXISTS `tg_group`;
CREATE TABLE `tg_group`  (
  `id` bigint(20) NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `minimum_rank` int(11) NULL DEFAULT 0,
  `old_id` bigint(20) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `old_id`(`old_id`) USING BTREE,
  INDEX `minimum_rank`(`minimum_rank`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for tg_message
-- ----------------------------
DROP TABLE IF EXISTS `tg_message`;
CREATE TABLE `tg_message`  (
  `chat_id` bigint(20) NOT NULL,
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `text` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `entities` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `dates` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `chat_id`(`chat_id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11631 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for tg_nft
-- ----------------------------
DROP TABLE IF EXISTS `tg_nft`;
CREATE TABLE `tg_nft`  (
  `id` int(11) UNSIGNED NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `description` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for tg_nft_trait
-- ----------------------------
DROP TABLE IF EXISTS `tg_nft_trait`;
CREATE TABLE `tg_nft_trait`  (
  `nft_id` int(11) UNSIGNED NULL DEFAULT NULL,
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `display_type` enum('text','boost_number','boost_percentage','number') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'text',
  `trait_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `nft_id`(`nft_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for tg_rank
-- ----------------------------
DROP TABLE IF EXISTS `tg_rank`;
CREATE TABLE `tg_rank`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `rank_number` tinyint(4) NULL DEFAULT NULL,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `minimum_point` int(10) UNSIGNED NULL DEFAULT NULL,
  `maximum_point` int(10) UNSIGNED NULL DEFAULT NULL,
  `description` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for tg_rank_change
-- ----------------------------
DROP TABLE IF EXISTS `tg_rank_change`;
CREATE TABLE `tg_rank_change`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `old_rank` int(11) NOT NULL,
  `new_rank` int(11) NULL DEFAULT NULL,
  `is_processed` tinyint(1) NULL DEFAULT 0,
  `is_success` tinyint(1) NULL DEFAULT 0,
  `tx_hash` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `user_id_2`(`user_id`, `old_rank`, `new_rank`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  INDEX `old_rank`(`old_rank`) USING BTREE,
  INDEX `new_rank`(`new_rank`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 456 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for tg_setting
-- ----------------------------
DROP TABLE IF EXISTS `tg_setting`;
CREATE TABLE `tg_setting`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `private_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `nft_address` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `is_testnet` tinyint(1) NULL DEFAULT NULL,
  `rpc_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for tg_tasks
-- ----------------------------
DROP TABLE IF EXISTS `tg_tasks`;
CREATE TABLE `tg_tasks`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `link` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `point` int(11) NULL DEFAULT NULL,
  `published` tinyint(1) NULL DEFAULT 0,
  `published_times` int(11) NULL DEFAULT 0,
  `type` enum('MARK_AS_DONE','NEED_USER_PROOF','TWITTER_PROOF','IMAGE_PROOF','LINK_PROOF') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'MARK_AS_DONE',
  `images` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 740 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for tg_user
-- ----------------------------
DROP TABLE IF EXISTS `tg_user`;
CREATE TABLE `tg_user`  (
  `id` bigint(20) NOT NULL,
  `is_bot` tinyint(3) UNSIGNED NULL DEFAULT NULL,
  `first_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `last_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `username` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `language_code` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `is_premium` tinyint(1) NULL DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `private_key` varchar(65) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `generated_address` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `owner_address` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `nft_rank` int(11) NULL DEFAULT NULL,
  `banned_me` tinyint(1) NOT NULL DEFAULT 0,
  `enable_task` tinyint(1) NOT NULL DEFAULT 0,
  `twitter` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for tg_user_group
-- ----------------------------
DROP TABLE IF EXISTS `tg_user_group`;
CREATE TABLE `tg_user_group`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NULL DEFAULT NULL,
  `group_id` bigint(20) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  INDEX `group_id`(`group_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for tg_user_send_notification
-- ----------------------------
DROP TABLE IF EXISTS `tg_user_send_notification`;
CREATE TABLE `tg_user_send_notification`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NULL DEFAULT NULL,
  `message_text` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `created_at` int(11) NOT NULL DEFAULT 0,
  `sent_at` int(11) NOT NULL DEFAULT 0,
  `is_processed` tinyint(1) UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for user_aktifitas
-- ----------------------------
DROP TABLE IF EXISTS `user_aktifitas`;
CREATE TABLE `user_aktifitas`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `aktifitas` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ip` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `tanggal` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  INDEX `tanggal`(`tanggal`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1085 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- View structure for view_buy_logs_message_group
-- ----------------------------
DROP VIEW IF EXISTS `view_buy_logs_message_group`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `view_buy_logs_message_group` AS select `rbabot`.`buy_message_logs`.`id` AS `id`,`rbabot`.`buy_chat`.`type` AS `type`,`rbabot`.`buy_user`.`first_name` AS `first_name`,`rbabot`.`buy_user`.`last_name` AS `last_name`,`rbabot`.`buy_user`.`username` AS `username`,`rbabot`.`buy_chat`.`title` AS `title`,`rbabot`.`buy_message_logs`.`text` AS `text`,`rbabot`.`buy_message_logs`.`entities` AS `entities`,`rbabot`.`buy_message_logs`.`dates` AS `dates` from ((`buy_message_logs` join `buy_chat` on(`rbabot`.`buy_chat`.`id` = `rbabot`.`buy_message_logs`.`chat_id`)) join `buy_user` on(`rbabot`.`buy_user`.`id` = `rbabot`.`buy_message_logs`.`user_id`)) where `rbabot`.`buy_chat`.`type` = 'group' or `rbabot`.`buy_chat`.`type` = 'supergroup';

-- ----------------------------
-- View structure for view_buy_logs_message_private
-- ----------------------------
DROP VIEW IF EXISTS `view_buy_logs_message_private`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `view_buy_logs_message_private` AS select `rbabot`.`buy_message_logs`.`id` AS `id`,`rbabot`.`buy_chat`.`type` AS `type`,`rbabot`.`buy_user`.`first_name` AS `first_name`,`rbabot`.`buy_user`.`last_name` AS `last_name`,`rbabot`.`buy_user`.`username` AS `username`,`rbabot`.`buy_chat`.`title` AS `title`,`rbabot`.`buy_message_logs`.`text` AS `text`,`rbabot`.`buy_message_logs`.`entities` AS `entities`,`rbabot`.`buy_message_logs`.`dates` AS `dates` from ((`buy_message_logs` join `buy_chat` on(`rbabot`.`buy_chat`.`id` = `rbabot`.`buy_message_logs`.`chat_id`)) join `buy_user` on(`rbabot`.`buy_user`.`id` = `rbabot`.`buy_message_logs`.`user_id`)) where `rbabot`.`buy_chat`.`type` = 'private';

-- ----------------------------
-- View structure for view_campaign_entries
-- ----------------------------
DROP VIEW IF EXISTS `view_campaign_entries`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `view_campaign_entries` AS select `tg_campaign_task`.`campaign_id` AS `campaign_id`,`campaign_task_count`.`task_count` AS `task_count`,`tg_campaign_task_user`.`user_id` AS `user_id`,count(`tg_campaign_task_user`.`id`) AS `submitted_count`,sum(`tg_campaign_task_user`.`is_done`) AS `done_count`,min(`tg_campaign_task_user`.`created_at`) AS `sumbitted_start`,ifnull(max(`tg_campaign_task_user`.`done_at`),0) AS `submitted_end`,`tg_user`.`first_name` AS `first_name`,`tg_user`.`last_name` AS `last_name`,`tg_user`.`username` AS `username`,`tg_user`.`email` AS `email`,`tg_user`.`generated_address` AS `generated_address`,`tg_user`.`owner_address` AS `owner_address`,`tg_user`.`twitter` AS `twitter` from (((`tg_campaign_task` left join `tg_campaign_task_user` on(`tg_campaign_task_user`.`campaign_task_id` = `tg_campaign_task`.`id`)) join (select `tg_campaign_task`.`campaign_id` AS `campaign_id`,count(`tg_campaign_task`.`id`) AS `task_count` from `tg_campaign_task` group by `tg_campaign_task`.`campaign_id`) `campaign_task_count` on(`campaign_task_count`.`campaign_id` = `tg_campaign_task`.`campaign_id`)) join `tg_user` on(`tg_user`.`id` = `tg_campaign_task_user`.`user_id`)) group by `tg_campaign_task`.`campaign_id`,`tg_campaign_task_user`.`user_id`;

-- ----------------------------
-- View structure for view_campaign_entries_with_done
-- ----------------------------
DROP VIEW IF EXISTS `view_campaign_entries_with_done`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `view_campaign_entries_with_done` AS select `a`.`campaign_id` AS `campaign_id`,`a`.`task_count` AS `task_count`,`a`.`user_id` AS `user_id`,`a`.`submitted_count` AS `submitted_count`,`a`.`done_count` AS `done_count`,`a`.`sumbitted_start` AS `sumbitted_start`,`a`.`submitted_end` AS `submitted_end`,`a`.`first_name` AS `first_name`,`a`.`last_name` AS `last_name`,`a`.`username` AS `username`,`a`.`email` AS `email`,`a`.`generated_address` AS `generated_address`,`a`.`owner_address` AS `personal_wallet`,`a`.`twitter` AS `twitter`,if(`a`.`task_count` <= `a`.`done_count`,1,0) AS `is_finished` from `view_campaign_entries` `a`;

-- ----------------------------
-- View structure for view_campaign_task_user
-- ----------------------------
DROP VIEW IF EXISTS `view_campaign_task_user`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `view_campaign_task_user` AS select `tg_campaign_task`.`id` AS `id`,`tg_campaign_task`.`campaign_id` AS `campaign_id`,`tg_campaign_task`.`task_order` AS `task_order`,`tg_campaign_task`.`task_name` AS `task_name`,`tg_campaign_task`.`task_type` AS `task_type`,`tg_campaign_task`.`task_instruction` AS `task_instruction`,`tg_campaign_task_user`.`user_id` AS `user_id`,`tg_campaign_task_user`.`is_done` AS `is_done`,`tg_campaign_task_user`.`proof` AS `proof`,`tg_campaign_task_user`.`created_at` AS `created_at`,`tg_campaign_task_user`.`done_at` AS `done_at`,`tg_campaign_task_user`.`is_verified` AS `is_verified` from (`tg_campaign_task_user` join `tg_campaign_task` on(`tg_campaign_task_user`.`campaign_task_id` = `tg_campaign_task`.`id`));

-- ----------------------------
-- View structure for view_campaign_user_step
-- ----------------------------
DROP VIEW IF EXISTS `view_campaign_user_step`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `view_campaign_user_step` AS select `tg_campaign_task`.`campaign_id` AS `campaign_id`,`tg_campaign_task`.`task_order` AS `task_order`,`tg_campaign_task_user`.`user_id` AS `user_id`,`tg_campaign_task_user`.`is_done` AS `is_done`,`tg_campaign_task_user`.`campaign_task_id` AS `campaign_task_id` from (`tg_campaign_task_user` join `tg_campaign_task` on(`tg_campaign_task`.`id` = `tg_campaign_task_user`.`campaign_task_id`));

-- ----------------------------
-- View structure for view_sent_message
-- ----------------------------
DROP VIEW IF EXISTS `view_sent_message`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `view_sent_message` AS select `rbabot`.`buy_group`.`title` AS `group_title`,`rbabot`.`buy_message`.`message` AS `message`,`rbabot`.`buy_message`.`created` AS `created`,`rbabot`.`buy_message`.`is_processed` AS `is_processed`,`rbabot`.`buy_message`.`processed` AS `processed` from (`buy_message` left join `buy_group` on(`rbabot`.`buy_group`.`id` = `rbabot`.`buy_message`.`group`));

-- ----------------------------
-- View structure for view_staking
-- ----------------------------
DROP VIEW IF EXISTS `view_staking`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `view_staking` AS select `a`.`address` AS `address`,`a`.`staking_balance` AS `staking_balance`,`a`.`start_time` AS `start_time`,`a`.`actual_reward` AS `actual_reward`,`a`.`already_withdrawn` AS `already_withdrawn`,`a`.`pending_reward` AS `pending_reward`,`a`.`staking_int` AS `staking_int`,`a`.`actual_int` AS `actual_int`,`a`.`already_int` AS `already_int`,`a`.`pending_int` AS `pending_int`,`a`.`staking_type` AS `staking_type`,`a`.`actual_int` + `a`.`pending_int` - `a`.`already_int` AS `total` from `final_staking` `a`;

-- ----------------------------
-- View structure for view_task_need_review
-- ----------------------------
DROP VIEW IF EXISTS `view_task_need_review`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `view_task_need_review` AS select `tg_daily_task`.`task_id` AS `task_id`,`tg_daily_task`.`user_id` AS `user_id`,`tg_user`.`first_name` AS `first_name`,`tg_user`.`last_name` AS `last_name`,`tg_user`.`username` AS `username`,`tg_tasks`.`name` AS `task_name`,`tg_daily_task`.`complete_date` AS `complete_date`,`tg_tasks`.`point` AS `point`,`tg_tasks`.`description` AS `description`,`tg_tasks`.`link` AS `link`,`tg_daily_task`.`is_reviewed` AS `is_reviewed`,`tg_daily_task`.`reason` AS `reason`,`tg_daily_task`.`user_proof` AS `user_proof`,`tg_tasks`.`type` AS `type`,`tg_user`.`twitter` AS `twitter`,`tg_daily_task`.`id` AS `id` from ((`tg_daily_task` join `tg_user` on(`tg_daily_task`.`user_id` = `tg_user`.`id`)) join `tg_tasks` on(`tg_daily_task`.`task_id` = `tg_tasks`.`id`)) where `tg_daily_task`.`is_completed` = 1 and `tg_daily_task`.`is_reviewed` = 0;

-- ----------------------------
-- View structure for view_task_reviewed
-- ----------------------------
DROP VIEW IF EXISTS `view_task_reviewed`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `view_task_reviewed` AS select `tg_daily_task`.`task_id` AS `task_id`,`tg_daily_task`.`user_id` AS `user_id`,`tg_user`.`first_name` AS `first_name`,`tg_user`.`last_name` AS `last_name`,`tg_user`.`username` AS `username`,`tg_tasks`.`name` AS `task_name`,`tg_daily_task`.`complete_date` AS `complete_date`,`tg_tasks`.`point` AS `point`,`tg_tasks`.`description` AS `description`,`tg_tasks`.`link` AS `link`,`tg_daily_task`.`is_reviewed` AS `is_reviewed`,`tg_daily_task`.`reason` AS `reason`,`tg_daily_task`.`earn_point` AS `earn_point`,`tg_daily_task`.`user_proof` AS `user_proof` from ((`tg_daily_task` join `tg_user` on(`tg_daily_task`.`user_id` = `tg_user`.`id`)) join `tg_tasks` on(`tg_daily_task`.`task_id` = `tg_tasks`.`id`)) where `tg_daily_task`.`is_completed` = 1 and `tg_daily_task`.`is_reviewed` = 1;

-- ----------------------------
-- View structure for view_tg_group_chat
-- ----------------------------
DROP VIEW IF EXISTS `view_tg_group_chat`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `view_tg_group_chat` AS select `tg_message`.`id` AS `id`,`tg_user`.`first_name` AS `first_name`,`tg_user`.`last_name` AS `last_name`,`tg_user`.`username` AS `username`,`tg_message`.`text` AS `text`,`tg_message`.`entities` AS `entities`,`tg_message`.`dates` AS `dates`,`tg_chat`.`type` AS `type`,`tg_chat`.`title` AS `title`,`tg_chat`.`all_members_are_administrators` AS `all_members_are_administrators` from ((`tg_message` join `tg_chat` on(`tg_chat`.`id` = `tg_message`.`chat_id`)) join `tg_user` on(`tg_user`.`id` = `tg_message`.`user_id`)) where `tg_chat`.`type` = 'group' or `tg_chat`.`type` = 'supergroup';

-- ----------------------------
-- View structure for view_tg_private_chat
-- ----------------------------
DROP VIEW IF EXISTS `view_tg_private_chat`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `view_tg_private_chat` AS select `tg_message`.`id` AS `id`,`tg_user`.`first_name` AS `first_name`,`tg_user`.`last_name` AS `last_name`,`tg_user`.`username` AS `username`,`tg_message`.`text` AS `text`,`tg_message`.`entities` AS `entities`,`tg_message`.`dates` AS `dates` from ((`tg_message` join `tg_chat` on(`tg_chat`.`id` = `tg_message`.`chat_id`)) join `tg_user` on(`tg_user`.`id` = `tg_message`.`user_id`)) where `tg_chat`.`type` = 'private';

-- ----------------------------
-- View structure for view_tg_rank_change
-- ----------------------------
DROP VIEW IF EXISTS `view_tg_rank_change`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `view_tg_rank_change` AS select `tg_rank_change`.`id` AS `id`,`tg_rank_change`.`user_id` AS `user_id`,`tg_rank_change`.`old_rank` AS `old_rank`,`tg_rank_change`.`new_rank` AS `new_rank`,`tg_rank_change`.`is_processed` AS `is_processed`,`tg_rank_change`.`is_success` AS `is_success`,`tg_rank_change`.`tx_hash` AS `tx_hash`,`tg_user`.`generated_address` AS `generated_address`,`tg_user`.`first_name` AS `first_name`,`tg_user`.`last_name` AS `last_name` from (`tg_rank_change` join `tg_user` on(`tg_rank_change`.`user_id` = `tg_user`.`id`));

-- ----------------------------
-- View structure for view_tg_task_need_send
-- ----------------------------
DROP VIEW IF EXISTS `view_tg_task_need_send`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `view_tg_task_need_send` AS select `tg_daily_task`.`user_id` AS `user_id`,`tg_daily_task`.`send_status` AS `send_status`,`tg_tasks`.`name` AS `name`,`tg_tasks`.`description` AS `description`,`tg_tasks`.`link` AS `link`,`tg_tasks`.`point` AS `point`,`tg_daily_task`.`id` AS `id`,`tg_user`.`first_name` AS `first_name`,`tg_user`.`last_name` AS `last_name`,`tg_tasks`.`type` AS `type`,`tg_daily_task`.`task_id` AS `task_id`,`tg_tasks`.`images` AS `images` from ((`tg_daily_task` join `tg_tasks` on(`tg_tasks`.`id` = `tg_daily_task`.`task_id`)) join `tg_user` on(`tg_user`.`id` = `tg_daily_task`.`user_id`)) where `tg_daily_task`.`send_status` = 0;

-- ----------------------------
-- View structure for view_tg_task_queue
-- ----------------------------
DROP VIEW IF EXISTS `view_tg_task_queue`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `view_tg_task_queue` AS select `tg_daily_task`.`task_id` AS `task_id`,`tg_daily_task`.`user_id` AS `user_id`,`tg_user`.`first_name` AS `first_name`,`tg_user`.`last_name` AS `last_name`,`tg_user`.`username` AS `username`,`tg_tasks`.`name` AS `task_name`,`tg_daily_task`.`created_date` AS `created_date`,`tg_tasks`.`type` AS `type` from ((`tg_daily_task` join `tg_user` on(`tg_daily_task`.`user_id` = `tg_user`.`id`)) join `tg_tasks` on(`tg_daily_task`.`task_id` = `tg_tasks`.`id`)) where `tg_daily_task`.`send_status` = 0;

-- ----------------------------
-- View structure for view_tg_task_success
-- ----------------------------
DROP VIEW IF EXISTS `view_tg_task_success`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `view_tg_task_success` AS select `tg_daily_task`.`task_id` AS `task_id`,`tg_daily_task`.`user_id` AS `user_id`,`tg_user`.`first_name` AS `first_name`,`tg_user`.`last_name` AS `last_name`,`tg_user`.`username` AS `username`,`tg_tasks`.`name` AS `task_name`,`tg_daily_task`.`send_date` AS `send_date`,`tg_tasks`.`type` AS `type`,`tg_tasks`.`point` AS `point` from ((`tg_daily_task` join `tg_user` on(`tg_daily_task`.`user_id` = `tg_user`.`id`)) join `tg_tasks` on(`tg_daily_task`.`task_id` = `tg_tasks`.`id`)) where `tg_daily_task`.`send_status` = 1;

-- ----------------------------
-- View structure for view_tg_task_users
-- ----------------------------
DROP VIEW IF EXISTS `view_tg_task_users`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `view_tg_task_users` AS select `tg_daily_task`.`task_id` AS `task_id`,`tg_daily_task`.`user_id` AS `user_id`,`tg_user`.`first_name` AS `first_name`,`tg_user`.`last_name` AS `last_name`,`tg_user`.`username` AS `username`,`tg_tasks`.`name` AS `task_name`,`tg_daily_task`.`send_date` AS `send_date`,`tg_daily_task`.`is_completed` AS `is_completed`,`tg_daily_task`.`is_reviewed` AS `is_reviewed`,`tg_daily_task`.`complete_date` AS `complete_date`,`tg_tasks`.`description` AS `description`,`tg_tasks`.`point` AS `point`,`tg_tasks`.`type` AS `type`,`tg_daily_task`.`id` AS `id` from ((`tg_daily_task` join `tg_user` on(`tg_daily_task`.`user_id` = `tg_user`.`id`)) join `tg_tasks` on(`tg_daily_task`.`task_id` = `tg_tasks`.`id`)) where `tg_daily_task`.`send_status` = 1;

-- ----------------------------
-- View structure for view_tg_user_group
-- ----------------------------
DROP VIEW IF EXISTS `view_tg_user_group`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `view_tg_user_group` AS select `tg_user_group`.`user_id` AS `user_id`,`tg_user_group`.`group_id` AS `group_id`,`tg_group`.`title` AS `group_title`,`tg_group`.`username` AS `username`,`tg_group`.`minimum_rank` AS `minimum_rank` from ((`tg_user` join `tg_user_group` on(`tg_user`.`id` = `tg_user_group`.`user_id`)) join `tg_group` on(`tg_group`.`id` = `tg_user_group`.`group_id`));

-- ----------------------------
-- View structure for view_tg_user_statistic
-- ----------------------------
DROP VIEW IF EXISTS `view_tg_user_statistic`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `view_tg_user_statistic` AS select count(`tg_user`.`id`) AS `total`,(select count(`tg_user`.`id`) from `tg_user` where `tg_user`.`nft_rank` = 0) AS `rank0`,(select count(`tg_user`.`id`) from `tg_user` where `tg_user`.`nft_rank` = 1) AS `rank1`,(select count(`tg_user`.`id`) from `tg_user` where `tg_user`.`nft_rank` = 2) AS `rank2`,(select count(`tg_user`.`id`) from `tg_user` where `tg_user`.`nft_rank` = 3) AS `rank3`,(select count(`tg_user`.`id`) from `tg_user` where `tg_user`.`nft_rank` = 4) AS `rank4`,(select count(`tg_user`.`id`) from `tg_user` where `tg_user`.`nft_rank` = 5) AS `rank5`,(select count(`tg_user`.`id`) from `tg_user` where `tg_user`.`nft_rank` = 6) AS `rank6`,(select count(`tg_user`.`id`) from `tg_user` where `tg_user`.`nft_rank` = 7) AS `rank7`,(select count(`tg_user`.`id`) from `tg_user` where `tg_user`.`nft_rank` = 8) AS `rank8`,(select count(`tg_user`.`id`) from `tg_user` where `tg_user`.`nft_rank` = 9) AS `rank9`,(select count(`tg_user`.`id`) from `tg_user` where `tg_user`.`nft_rank` = 10) AS `rank10` from `tg_user`;

-- ----------------------------
-- View structure for view_user_competition_point
-- ----------------------------
DROP VIEW IF EXISTS `view_user_competition_point`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `view_user_competition_point` AS select `A`.`user_point` AS `user_point`,`A`.`user_id` AS `user_id`,`A`.`first_name` AS `first_name`,`A`.`last_name` AS `last_name`,`A`.`nft_rank` AS `nft_rank`,`A`.`email` AS `email`,`A`.`twitter` AS `twitter`,`A`.`username` AS `username` from (select sum(`tg_tasks`.`point`) AS `user_point`,`tg_daily_task`.`user_id` AS `user_id`,`tg_user`.`first_name` AS `first_name`,`tg_user`.`last_name` AS `last_name`,`tg_user`.`nft_rank` AS `nft_rank`,`tg_user`.`email` AS `email`,`tg_user`.`twitter` AS `twitter`,`tg_user`.`username` AS `username` from ((`tg_daily_task` join `tg_tasks` on(`tg_daily_task`.`task_id` = `tg_tasks`.`id`)) join `tg_user` on(`tg_daily_task`.`user_id` = `tg_user`.`id`)) where `tg_daily_task`.`earn_point` = 1 and `tg_daily_task`.`complete_date` between 1689526800 and 1690822799 group by `tg_daily_task`.`user_id`) `A` where `A`.`user_point` > 20;

-- ----------------------------
-- View structure for view_user_earn_point
-- ----------------------------
DROP VIEW IF EXISTS `view_user_earn_point`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `view_user_earn_point` AS select sum(`tg_tasks`.`point`) AS `user_point`,`tg_daily_task`.`user_id` AS `user_id` from (`tg_daily_task` join `tg_tasks` on(`tg_daily_task`.`task_id` = `tg_tasks`.`id`)) where `tg_daily_task`.`earn_point` = 1 group by `tg_daily_task`.`user_id`;

-- ----------------------------
-- View structure for view_user_earn_point_alltime
-- ----------------------------
DROP VIEW IF EXISTS `view_user_earn_point_alltime`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `view_user_earn_point_alltime` AS select sum(`tg_tasks`.`point`) AS `user_point`,`tg_daily_task`.`user_id` AS `user_id`,`tg_user`.`first_name` AS `first_name`,`tg_user`.`last_name` AS `last_name`,`tg_user`.`nft_rank` AS `nft_rank`,`tg_user`.`email` AS `email`,`tg_user`.`twitter` AS `twitter`,`tg_user`.`username` AS `username` from ((`tg_daily_task` join `tg_tasks` on(`tg_daily_task`.`task_id` = `tg_tasks`.`id`)) join `tg_user` on(`tg_daily_task`.`user_id` = `tg_user`.`id`)) where `tg_daily_task`.`earn_point` = 1 group by `tg_daily_task`.`user_id`;

-- ----------------------------
-- View structure for view_user_earn_point_b
-- ----------------------------
DROP VIEW IF EXISTS `view_user_earn_point_b`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `view_user_earn_point_b` AS select sum(`tg_tasks`.`point`) AS `user_point`,`tg_daily_task`.`user_id` AS `user_id`,`tg_user`.`first_name` AS `first_name`,`tg_user`.`last_name` AS `last_name`,`tg_user`.`generated_address` AS `generated_address`,`tg_user`.`nft_rank` AS `nft_rank` from ((`tg_daily_task` join `tg_tasks` on(`tg_daily_task`.`task_id` = `tg_tasks`.`id`)) join `tg_user` on(`tg_daily_task`.`user_id` = `tg_user`.`id`)) where `tg_daily_task`.`earn_point` = 1 group by `tg_daily_task`.`user_id`;

-- ----------------------------
-- View structure for view_user_earn_point_monthly
-- ----------------------------
DROP VIEW IF EXISTS `view_user_earn_point_monthly`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `view_user_earn_point_monthly` AS select sum(`tg_tasks`.`point`) AS `user_point`,`tg_daily_task`.`user_id` AS `user_id`,`tg_user`.`first_name` AS `first_name`,`tg_user`.`last_name` AS `last_name`,`tg_user`.`nft_rank` AS `nft_rank`,`tg_user`.`email` AS `email`,`tg_user`.`twitter` AS `twitter`,`tg_user`.`username` AS `username` from ((`tg_daily_task` join `tg_tasks` on(`tg_daily_task`.`task_id` = `tg_tasks`.`id`)) join `tg_user` on(`tg_daily_task`.`user_id` = `tg_user`.`id`)) where `tg_daily_task`.`earn_point` = 1 and `tg_daily_task`.`complete_date` > unix_timestamp(current_timestamp() - interval 30 day) group by `tg_daily_task`.`user_id`;

-- ----------------------------
-- View structure for view_user_earn_point_statistic
-- ----------------------------
DROP VIEW IF EXISTS `view_user_earn_point_statistic`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `view_user_earn_point_statistic` AS select ifnull(`view_user_earn_point_monthly`.`user_point`,0) AS `month_point`,ifnull(`view_user_earn_point_weekly`.`user_point`,0) AS `week_point`,`view_user_earn_point_monthly`.`user_id` AS `user_id`,`view_user_earn_point_monthly`.`first_name` AS `first_name`,`view_user_earn_point_monthly`.`last_name` AS `last_name`,`view_user_earn_point_monthly`.`nft_rank` AS `nft_rank`,`view_user_earn_point_monthly`.`email` AS `email`,`view_user_earn_point_monthly`.`twitter` AS `twitter`,`view_user_earn_point_monthly`.`username` AS `username` from (`view_user_earn_point_monthly` left join `view_user_earn_point_weekly` on(`view_user_earn_point_weekly`.`user_id` = `view_user_earn_point_monthly`.`user_id`)) order by `view_user_earn_point_monthly`.`user_point` desc;

-- ----------------------------
-- View structure for view_user_earn_point_weekly
-- ----------------------------
DROP VIEW IF EXISTS `view_user_earn_point_weekly`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `view_user_earn_point_weekly` AS select sum(`tg_tasks`.`point`) AS `user_point`,`tg_daily_task`.`user_id` AS `user_id`,`tg_user`.`first_name` AS `first_name`,`tg_user`.`last_name` AS `last_name`,`tg_user`.`nft_rank` AS `nft_rank`,`tg_user`.`email` AS `email`,`tg_user`.`twitter` AS `twitter` from ((`tg_daily_task` join `tg_tasks` on(`tg_daily_task`.`task_id` = `tg_tasks`.`id`)) join `tg_user` on(`tg_daily_task`.`user_id` = `tg_user`.`id`)) where `tg_daily_task`.`earn_point` = 1 and `tg_daily_task`.`complete_date` > unix_timestamp(current_timestamp() - interval 7 day) group by `tg_daily_task`.`user_id`;

-- ----------------------------
-- View structure for view_user_earn_pont_upgrade
-- ----------------------------
DROP VIEW IF EXISTS `view_user_earn_pont_upgrade`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `view_user_earn_pont_upgrade` AS select `view_user_earn_point_b`.`user_point` AS `user_point`,`view_user_earn_point_b`.`user_id` AS `user_id`,`view_user_earn_point_b`.`first_name` AS `first_name`,`view_user_earn_point_b`.`last_name` AS `last_name`,`view_user_earn_point_b`.`generated_address` AS `generated_address`,`view_user_earn_point_b`.`nft_rank` AS `nft_rank`,`tg_rank`.`rank_number` AS `rank_number` from (`view_user_earn_point_b` join `tg_rank`) where `view_user_earn_point_b`.`user_point` between `tg_rank`.`minimum_point` and `tg_rank`.`maximum_point`;

SET FOREIGN_KEY_CHECKS = 1;
