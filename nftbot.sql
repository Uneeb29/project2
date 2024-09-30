-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost:8889
-- Generation Time: Jul 18, 2024 at 04:31 PM
-- Server version: 5.7.39
-- PHP Version: 7.4.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `nftbot`
--

-- --------------------------------------------------------

--
-- Table structure for table `aauth_groups`
--

CREATE TABLE `aauth_groups` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `definition` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `aauth_group_to_group`
--

CREATE TABLE `aauth_group_to_group` (
  `group_id` int(10) UNSIGNED NOT NULL,
  `subgroup_id` int(10) UNSIGNED NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED;

-- --------------------------------------------------------

--
-- Table structure for table `aauth_login_attempts`
--

CREATE TABLE `aauth_login_attempts` (
  `id` int(11) NOT NULL,
  `ip_address` varchar(39) DEFAULT '0',
  `timestamp` datetime DEFAULT NULL,
  `login_attempts` tinyint(4) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `aauth_login_attempts`
--

INSERT INTO `aauth_login_attempts` (`id`, `ip_address`, `timestamp`, `login_attempts`) VALUES
(1, '::1', '2024-06-25 10:15:48', 3),
(2, '::1', '2024-06-25 10:21:04', 2),
(3, '::1', '2024-07-05 07:08:42', 5);

-- --------------------------------------------------------

--
-- Table structure for table `aauth_perms`
--

CREATE TABLE `aauth_perms` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `definition` text
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `aauth_perm_to_group`
--

CREATE TABLE `aauth_perm_to_group` (
  `perm_id` int(10) UNSIGNED NOT NULL,
  `group_id` int(10) UNSIGNED NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED;

-- --------------------------------------------------------

--
-- Table structure for table `aauth_perm_to_user`
--

CREATE TABLE `aauth_perm_to_user` (
  `perm_id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED;

-- --------------------------------------------------------

--
-- Table structure for table `aauth_pms`
--

CREATE TABLE `aauth_pms` (
  `id` int(10) UNSIGNED NOT NULL,
  `sender_id` int(10) UNSIGNED NOT NULL,
  `receiver_id` int(10) UNSIGNED NOT NULL,
  `title` varchar(255) NOT NULL,
  `message` text,
  `date_sent` datetime DEFAULT NULL,
  `date_read` datetime DEFAULT NULL,
  `pm_deleted_sender` int(11) DEFAULT NULL,
  `pm_deleted_receiver` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `aauth_users`
--

CREATE TABLE `aauth_users` (
  `id` int(10) UNSIGNED NOT NULL,
  `email` varchar(100) NOT NULL,
  `upass` varchar(60) NOT NULL,
  `pass` varchar(60) DEFAULT NULL,
  `username` varchar(100) DEFAULT NULL,
  `banned` tinyint(1) DEFAULT '0',
  `last_login` datetime DEFAULT NULL,
  `last_activity` datetime DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `forgot_exp` text,
  `remember_time` datetime DEFAULT NULL,
  `remember_exp` text,
  `verification_code` text,
  `totp_secret` varchar(16) DEFAULT NULL,
  `ip_address` text,
  `nama` varchar(50) DEFAULT NULL,
  `session_id` varchar(50) DEFAULT NULL,
  `foto` varchar(50) DEFAULT NULL,
  `Subscribed` tinyint(1) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `aauth_users`
--

INSERT INTO `aauth_users` (`id`, `email`, `upass`, `pass`, `username`, `banned`, `last_login`, `last_activity`, `date_created`, `forgot_exp`, `remember_time`, `remember_exp`, `verification_code`, `totp_secret`, `ip_address`, `nama`, `session_id`, `foto`, `Subscribed`) VALUES
(1, 'ali@email.com', '$2y$10$DxaFm.zR54rrehCf/dizauLujAJ7RWYxXGCAOzwkj79lDGDpeIBq2', '$2y$10$UWH5SYiie2hZRR6mdHQQcum0PM1kEBoC0ZzFE7M23ru4hUX52Z5AW', 'ali', 0, '2024-06-25 10:51:08', '2024-06-25 10:51:08', '2024-06-25 10:29:26', NULL, NULL, NULL, 'ancd', NULL, '::1', NULL, '19d87bab965f668593ea53fca89c2f88', NULL, 0);

-- --------------------------------------------------------

--
-- Table structure for table `aauth_user_to_group`
--

CREATE TABLE `aauth_user_to_group` (
  `user_id` int(10) UNSIGNED NOT NULL,
  `group_id` int(10) UNSIGNED NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED;

-- --------------------------------------------------------

--
-- Table structure for table `aauth_user_variables`
--

CREATE TABLE `aauth_user_variables` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `data_key` varchar(100) NOT NULL,
  `value` text
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `blacklist`
--

CREATE TABLE `blacklist` (
  `telegram_handle` varchar(255) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `blacklist`
--

INSERT INTO `blacklist` (`telegram_handle`, `user_id`, `username`) VALUES
('7099628596', 1, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `chain`
--

CREATE TABLE `chain` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL,
  `short_name` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL,
  `testnet` tinyint(1) DEFAULT NULL,
  `website` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL,
  `explorer_url` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL,
  `chain_id` int(10) UNSIGNED DEFAULT NULL,
  `native_symbol` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `ci_sessions`
--

CREATE TABLE `ci_sessions` (
  `session_id` varchar(40) NOT NULL DEFAULT '0',
  `ip_address` varchar(16) NOT NULL DEFAULT '0',
  `user_agent` varchar(150) NOT NULL,
  `last_activity` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `user_data` mediumtext NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `ci_sessions`
--

INSERT INTO `ci_sessions` (`session_id`, `ip_address`, `user_agent`, `last_activity`, `user_data`) VALUES
('1ff588ad4be246954b15f6ca12a4b139', '::1', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Mobile Sa', 1720163280, ''),
('54a73159cf197e2426f1a840853b5e62', '::1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36', 1720163152, '');

-- --------------------------------------------------------

--
-- Table structure for table `tg_campaign`
--

CREATE TABLE `tg_campaign` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `campaign_name` varchar(255) DEFAULT NULL,
  `campaign_start_message` longtext,
  `campaign_start_image` varchar(255) DEFAULT NULL,
  `campaign_continue_message` longtext,
  `campaign_complete_message` longtext,
  `campaign_complete_image` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) UNSIGNED DEFAULT NULL,
  `end_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `tg_campaign`
--

INSERT INTO `tg_campaign` (`id`, `campaign_name`, `campaign_start_message`, `campaign_start_image`, `campaign_continue_message`, `campaign_complete_message`, `campaign_complete_image`, `is_active`, `end_date`) VALUES
(1, 'abcd', 'Hi', '', 'Continue', 'complete', '', 1, NULL),
(2, 'two', 'two', NULL, 'continue', 'complete', NULL, 1, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `tg_campaign_task`
--

CREATE TABLE `tg_campaign_task` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `campaign_id` bigint(20) UNSIGNED DEFAULT NULL,
  `task_order` int(11) UNSIGNED DEFAULT NULL,
  `task_name` varchar(255) DEFAULT NULL,
  `task_type` enum('default','proof') NOT NULL DEFAULT 'default',
  `task_instruction` longtext,
  `task_url` varchar(255) DEFAULT NULL,
  `task_image` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `tg_campaign_task_user`
--

CREATE TABLE `tg_campaign_task_user` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `campaign_task_id` bigint(20) NOT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `is_done` tinyint(1) DEFAULT NULL,
  `proof` longtext,
  `created_at` int(11) DEFAULT NULL,
  `done_at` int(11) DEFAULT NULL,
  `is_verified` tinyint(1) UNSIGNED NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `tg_campaign_user`
--

CREATE TABLE `tg_campaign_user` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `campaign_id` bigint(20) UNSIGNED DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `step` int(11) DEFAULT '0',
  `created_at` int(11) DEFAULT '0',
  `updated_at` int(11) DEFAULT '0',
  `is_verified` tinyint(1) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `tg_chat`
--

CREATE TABLE `tg_chat` (
  `id` bigint(20) NOT NULL COMMENT 'Unique identifier for this chat',
  `type` enum('private','group','supergroup','channel') COLLATE utf8mb4_unicode_520_ci NOT NULL COMMENT 'Type of chat, can be either private, group, supergroup or channel',
  `title` char(255) COLLATE utf8mb4_unicode_520_ci DEFAULT '' COMMENT 'Title, for supergroups, channels and group chats',
  `username` char(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL COMMENT 'Username, for private chats, supergroups and channels if available',
  `first_name` char(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL COMMENT 'First name of the other party in a private chat',
  `last_name` char(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL COMMENT 'Last name of the other party in a private chat',
  `is_forum` tinyint(1) DEFAULT '0' COMMENT 'True, if the supergroup chat is a forum (has topics enabled)',
  `all_members_are_administrators` tinyint(1) DEFAULT '0' COMMENT 'True if a all members of this group are admins',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Entry date creation',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Entry date update',
  `old_id` bigint(20) DEFAULT NULL COMMENT 'Unique chat identifier, this is filled when a group is converted to a supergroup'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `tg_chat`
--

INSERT INTO `tg_chat` (`id`, `type`, `title`, `username`, `first_name`, `last_name`, `is_forum`, `all_members_are_administrators`, `created_at`, `updated_at`, `old_id`) VALUES
(7099628596, 'private', '', '', 'Ali', 'Awais', 0, 0, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `tg_config`
--

CREATE TABLE `tg_config` (
  `id` int(10) UNSIGNED NOT NULL,
  `key` varchar(191) DEFAULT NULL,
  `value` longtext
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `tg_daily_task`
--

CREATE TABLE `tg_daily_task` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `task_id` bigint(20) NOT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `is_completed` tinyint(1) DEFAULT '0',
  `is_reviewed` tinyint(1) DEFAULT '0',
  `complete_date` int(11) DEFAULT NULL,
  `created_date` int(10) UNSIGNED DEFAULT NULL,
  `send_date` int(11) DEFAULT NULL,
  `send_status` tinyint(1) NOT NULL DEFAULT '0',
  `reason` text,
  `user_proof` text,
  `earn_point` tinyint(1) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `tg_group`
--

CREATE TABLE `tg_group` (
  `id` bigint(20) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `minimum_rank` int(11) DEFAULT '0',
  `old_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `tg_message`
--

CREATE TABLE `tg_message` (
  `chat_id` bigint(20) NOT NULL,
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `text` text,
  `entities` text,
  `dates` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `tg_message`
--

INSERT INTO `tg_message` (`chat_id`, `id`, `user_id`, `text`, `entities`, `dates`) VALUES
(7099628596, 11631, 7099628596, '/campaign', '[{\"offset\":0,\"length\":9,\"type\":\"bot_command\"}]', 1719218277),
(7099628596, 11632, 7099628596, '/groups', '[{\"offset\":0,\"length\":7,\"type\":\"bot_command\"}]', 1719218288),
(7099628596, 11633, 7099628596, '/campaign', '[{\"offset\":0,\"length\":9,\"type\":\"bot_command\"}]', 1720768373),
(7099628596, 11634, 7099628596, '/start 33_1', '[{\"offset\":0,\"length\":6,\"type\":\"bot_command\"}]', 1720768635),
(7099628596, 11635, 7099628596, '/start 33_1', '[{\"offset\":0,\"length\":6,\"type\":\"bot_command\"}]', 1720768771),
(7099628596, 11636, 7099628596, '/start 33_1', '[{\"offset\":0,\"length\":6,\"type\":\"bot_command\"}]', 1720768847),
(7099628596, 11637, 7099628596, '/start 33_1', '[{\"offset\":0,\"length\":6,\"type\":\"bot_command\"}]', 1720768889),
(7099628596, 11638, 7099628596, '/start 33_1', '[{\"offset\":0,\"length\":6,\"type\":\"bot_command\"}]', 1720768922),
(7099628596, 11639, 7099628596, '/start 33_1', '[{\"offset\":0,\"length\":6,\"type\":\"bot_command\"}]', 1720768955),
(7099628596, 11640, 7099628596, '/start 33_1', '[{\"offset\":0,\"length\":6,\"type\":\"bot_command\"}]', 1720769186),
(7099628596, 11641, 7099628596, '/start 33_1', '[{\"offset\":0,\"length\":6,\"type\":\"bot_command\"}]', 1720769219),
(7099628596, 11642, 7099628596, '/start 33_1', '[{\"offset\":0,\"length\":6,\"type\":\"bot_command\"}]', 1720769251),
(7099628596, 11643, 7099628596, '/start 33_1', '[{\"offset\":0,\"length\":6,\"type\":\"bot_command\"}]', 1720769273),
(7099628596, 11644, 7099628596, '/start 33_1', '[{\"offset\":0,\"length\":6,\"type\":\"bot_command\"}]', 1720769326),
(7099628596, 11645, 7099628596, '/campaign', '[{\"offset\":0,\"length\":9,\"type\":\"bot_command\"}]', 1720769360),
(7099628596, 11646, 7099628596, '/campaign', '[{\"offset\":0,\"length\":9,\"type\":\"bot_command\"}]', 1720769390),
(7099628596, 11647, 7099628596, '/start 33_1', '[{\"offset\":0,\"length\":6,\"type\":\"bot_command\"}]', 1720769396),
(7099628596, 11648, 7099628596, '/start', '[{\"offset\":0,\"length\":6,\"type\":\"bot_command\"}]', 1721319822),
(7099628596, 11649, 7099628596, '/start 33_1', '[{\"offset\":0,\"length\":6,\"type\":\"bot_command\"}]', 1721319876),
(7099628596, 11650, 7099628596, '/start 33_1', '[{\"offset\":0,\"length\":6,\"type\":\"bot_command\"}]', 1721319906),
(7099628596, 11651, 7099628596, '/start 33_1', '[{\"offset\":0,\"length\":6,\"type\":\"bot_command\"}]', 1721319954),
(7099628596, 11652, 7099628596, '/start 33_1', '[{\"offset\":0,\"length\":6,\"type\":\"bot_command\"}]', 1721320048),
(7099628596, 11653, 7099628596, '/start 33_1', '[{\"offset\":0,\"length\":6,\"type\":\"bot_command\"}]', 1721320089),
(7099628596, 11654, 7099628596, '/start 33_1', '[{\"offset\":0,\"length\":6,\"type\":\"bot_command\"}]', 1721320126),
(7099628596, 11655, 7099628596, '/start 33_1', '[{\"offset\":0,\"length\":6,\"type\":\"bot_command\"}]', 1721320148),
(7099628596, 11656, 7099628596, '/start', '[{\"offset\":0,\"length\":6,\"type\":\"bot_command\"}]', 1721320197),
(7099628596, 11657, 7099628596, '/campaign', '[{\"offset\":0,\"length\":9,\"type\":\"bot_command\"}]', 1721320217),
(7099628596, 11658, 7099628596, '/campaign', '[{\"offset\":0,\"length\":9,\"type\":\"bot_command\"}]', 1721320264),
(7099628596, 11659, 7099628596, '/start 7099628596', '[{\"offset\":0,\"length\":6,\"type\":\"bot_command\"}]', 1721320277);

-- --------------------------------------------------------

--
-- Table structure for table `tg_nft`
--

CREATE TABLE `tg_nft` (
  `id` int(11) UNSIGNED NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` longtext,
  `image` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `tg_nft_trait`
--

CREATE TABLE `tg_nft_trait` (
  `nft_id` int(11) UNSIGNED DEFAULT NULL,
  `id` int(11) UNSIGNED NOT NULL,
  `display_type` enum('text','boost_number','boost_percentage','number') DEFAULT 'text',
  `trait_type` varchar(255) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `tg_rank`
--

CREATE TABLE `tg_rank` (
  `id` int(10) UNSIGNED NOT NULL,
  `rank_number` tinyint(4) DEFAULT NULL,
  `name` varchar(191) DEFAULT NULL,
  `minimum_point` int(10) UNSIGNED DEFAULT NULL,
  `maximum_point` int(10) UNSIGNED DEFAULT NULL,
  `description` longtext
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `tg_rank_change`
--

CREATE TABLE `tg_rank_change` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `old_rank` int(11) NOT NULL,
  `new_rank` int(11) DEFAULT NULL,
  `is_processed` tinyint(1) DEFAULT '0',
  `is_success` tinyint(1) DEFAULT '0',
  `tx_hash` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `tg_setting`
--

CREATE TABLE `tg_setting` (
  `id` int(10) UNSIGNED NOT NULL,
  `private_key` varchar(100) DEFAULT NULL,
  `nft_address` varchar(100) DEFAULT NULL,
  `is_testnet` tinyint(1) DEFAULT NULL,
  `rpc_url` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `tg_tasks`
--

CREATE TABLE `tg_tasks` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` text,
  `link` varchar(255) DEFAULT NULL,
  `point` int(11) DEFAULT NULL,
  `published` tinyint(1) DEFAULT '0',
  `published_times` int(11) DEFAULT '0',
  `type` enum('MARK_AS_DONE','NEED_USER_PROOF','TWITTER_PROOF','IMAGE_PROOF','LINK_PROOF') DEFAULT 'MARK_AS_DONE',
  `images` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `tg_user`
--

CREATE TABLE `tg_user` (
  `id` bigint(20) NOT NULL,
  `is_bot` tinyint(3) UNSIGNED DEFAULT NULL,
  `first_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `username` varchar(191) DEFAULT NULL,
  `language_code` varchar(10) DEFAULT NULL,
  `is_premium` tinyint(1) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `private_key` varchar(65) DEFAULT NULL,
  `generated_address` varchar(50) DEFAULT NULL,
  `owner_address` varchar(50) DEFAULT NULL,
  `nft_rank` int(11) DEFAULT NULL,
  `banned_me` tinyint(1) NOT NULL DEFAULT '0',
  `enable_task` tinyint(1) NOT NULL DEFAULT '0',
  `twitter` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `tg_user_group`
--

CREATE TABLE `tg_user_group` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `group_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `tg_user_send_notification`
--

CREATE TABLE `tg_user_send_notification` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `message_text` longtext,
  `created_at` int(11) NOT NULL DEFAULT '0',
  `sent_at` int(11) NOT NULL DEFAULT '0',
  `is_processed` tinyint(1) UNSIGNED NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `user_aktifitas`
--

CREATE TABLE `user_aktifitas` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(11) NOT NULL,
  `aktifitas` text NOT NULL,
  `ip` varchar(100) DEFAULT NULL,
  `tanggal` datetime DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `user_aktifitas`
--

INSERT INTO `user_aktifitas` (`id`, `user_id`, `aktifitas`, `ip`, `tanggal`) VALUES
(1085, 1, 'Login', '::1', '2024-06-25 10:29:56'),
(1086, 1, 'Login', '::1', '2024-06-25 10:30:44'),
(1087, 1, 'Login', '::1', '2024-06-25 10:50:45'),
(1088, 1, 'Login', '::1', '2024-06-25 10:51:08');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `aauth_groups`
--
ALTER TABLE `aauth_groups`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Indexes for table `aauth_group_to_group`
--
ALTER TABLE `aauth_group_to_group`
  ADD PRIMARY KEY (`group_id`,`subgroup_id`) USING BTREE;

--
-- Indexes for table `aauth_login_attempts`
--
ALTER TABLE `aauth_login_attempts`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Indexes for table `aauth_perms`
--
ALTER TABLE `aauth_perms`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Indexes for table `aauth_perm_to_group`
--
ALTER TABLE `aauth_perm_to_group`
  ADD PRIMARY KEY (`perm_id`,`group_id`) USING BTREE;

--
-- Indexes for table `aauth_perm_to_user`
--
ALTER TABLE `aauth_perm_to_user`
  ADD PRIMARY KEY (`perm_id`,`user_id`) USING BTREE;

--
-- Indexes for table `aauth_pms`
--
ALTER TABLE `aauth_pms`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `full_index` (`id`,`sender_id`,`receiver_id`,`date_read`) USING BTREE;

--
-- Indexes for table `aauth_users`
--
ALTER TABLE `aauth_users`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD UNIQUE KEY `email` (`email`) USING BTREE,
  ADD UNIQUE KEY `username` (`username`) USING BTREE;

--
-- Indexes for table `aauth_user_to_group`
--
ALTER TABLE `aauth_user_to_group`
  ADD PRIMARY KEY (`user_id`,`group_id`) USING BTREE;

--
-- Indexes for table `aauth_user_variables`
--
ALTER TABLE `aauth_user_variables`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `user_id_index` (`user_id`) USING BTREE;

--
-- Indexes for table `chain`
--
ALTER TABLE `chain`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Indexes for table `ci_sessions`
--
ALTER TABLE `ci_sessions`
  ADD PRIMARY KEY (`session_id`) USING BTREE;

--
-- Indexes for table `tg_campaign`
--
ALTER TABLE `tg_campaign`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Indexes for table `tg_campaign_task`
--
ALTER TABLE `tg_campaign_task`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `campaign_id` (`campaign_id`) USING BTREE;

--
-- Indexes for table `tg_campaign_task_user`
--
ALTER TABLE `tg_campaign_task_user`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD UNIQUE KEY `user_id_2` (`user_id`,`campaign_task_id`) USING BTREE,
  ADD KEY `campaign_task_id` (`campaign_task_id`) USING BTREE,
  ADD KEY `user_id` (`user_id`) USING BTREE;

--
-- Indexes for table `tg_campaign_user`
--
ALTER TABLE `tg_campaign_user`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD UNIQUE KEY `campaign_id_2` (`campaign_id`,`user_id`) USING BTREE,
  ADD KEY `user_id` (`user_id`) USING BTREE,
  ADD KEY `campaign_id` (`campaign_id`) USING BTREE;

--
-- Indexes for table `tg_chat`
--
ALTER TABLE `tg_chat`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `old_id` (`old_id`) USING BTREE;

--
-- Indexes for table `tg_config`
--
ALTER TABLE `tg_config`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Indexes for table `tg_daily_task`
--
ALTER TABLE `tg_daily_task`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `task_id` (`task_id`) USING BTREE,
  ADD KEY `user_id` (`user_id`) USING BTREE;

--
-- Indexes for table `tg_group`
--
ALTER TABLE `tg_group`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `old_id` (`old_id`) USING BTREE,
  ADD KEY `minimum_rank` (`minimum_rank`) USING BTREE;

--
-- Indexes for table `tg_message`
--
ALTER TABLE `tg_message`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `chat_id` (`chat_id`) USING BTREE,
  ADD KEY `user_id` (`user_id`) USING BTREE;

--
-- Indexes for table `tg_nft`
--
ALTER TABLE `tg_nft`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Indexes for table `tg_nft_trait`
--
ALTER TABLE `tg_nft_trait`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `nft_id` (`nft_id`) USING BTREE;

--
-- Indexes for table `tg_rank`
--
ALTER TABLE `tg_rank`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Indexes for table `tg_rank_change`
--
ALTER TABLE `tg_rank_change`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD UNIQUE KEY `user_id_2` (`user_id`,`old_rank`,`new_rank`) USING BTREE,
  ADD KEY `user_id` (`user_id`) USING BTREE,
  ADD KEY `old_rank` (`old_rank`) USING BTREE,
  ADD KEY `new_rank` (`new_rank`) USING BTREE;

--
-- Indexes for table `tg_setting`
--
ALTER TABLE `tg_setting`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Indexes for table `tg_tasks`
--
ALTER TABLE `tg_tasks`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Indexes for table `tg_user`
--
ALTER TABLE `tg_user`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Indexes for table `tg_user_group`
--
ALTER TABLE `tg_user_group`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `user_id` (`user_id`) USING BTREE,
  ADD KEY `group_id` (`group_id`) USING BTREE;

--
-- Indexes for table `tg_user_send_notification`
--
ALTER TABLE `tg_user_send_notification`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `user_id` (`user_id`) USING BTREE;

--
-- Indexes for table `user_aktifitas`
--
ALTER TABLE `user_aktifitas`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `user_id` (`user_id`) USING BTREE,
  ADD KEY `tanggal` (`tanggal`) USING BTREE;

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `aauth_groups`
--
ALTER TABLE `aauth_groups`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `aauth_login_attempts`
--
ALTER TABLE `aauth_login_attempts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `aauth_perms`
--
ALTER TABLE `aauth_perms`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `aauth_pms`
--
ALTER TABLE `aauth_pms`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `aauth_users`
--
ALTER TABLE `aauth_users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `aauth_user_variables`
--
ALTER TABLE `aauth_user_variables`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `chain`
--
ALTER TABLE `chain`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tg_campaign`
--
ALTER TABLE `tg_campaign`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `tg_campaign_task`
--
ALTER TABLE `tg_campaign_task`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tg_campaign_task_user`
--
ALTER TABLE `tg_campaign_task_user`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tg_campaign_user`
--
ALTER TABLE `tg_campaign_user`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tg_config`
--
ALTER TABLE `tg_config`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tg_daily_task`
--
ALTER TABLE `tg_daily_task`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tg_message`
--
ALTER TABLE `tg_message`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11660;

--
-- AUTO_INCREMENT for table `tg_nft_trait`
--
ALTER TABLE `tg_nft_trait`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tg_rank`
--
ALTER TABLE `tg_rank`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tg_rank_change`
--
ALTER TABLE `tg_rank_change`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tg_setting`
--
ALTER TABLE `tg_setting`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tg_tasks`
--
ALTER TABLE `tg_tasks`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tg_user_group`
--
ALTER TABLE `tg_user_group`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tg_user_send_notification`
--
ALTER TABLE `tg_user_send_notification`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user_aktifitas`
--
ALTER TABLE `user_aktifitas`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1089;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
