-- --------------------------------------------------------
-- 호스트:                          127.0.0.1
-- 서버 버전:                        11.2.2-MariaDB-1:11.2.2+maria~ubu2204 - mariadb.org binary distribution
-- 서버 OS:                        debian-linux-gnu
-- HeidiSQL 버전:                  11.3.0.6295
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- testdb 데이터베이스 구조 내보내기
CREATE DATABASE IF NOT EXISTS `testdb` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;
USE `testdb`;

-- 테이블 testdb.ALARM_BOX_MEMBER 구조 내보내기
CREATE TABLE IF NOT EXISTS `ALARM_BOX_MEMBER` (
  `alarm_box_seq` int(11) NOT NULL AUTO_INCREMENT,
  `alarm_box_member_id` varchar(50) NOT NULL,
  `alarm_box_push_alarm_id` int(11) NOT NULL,
  `alarm_box_is_checked` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`alarm_box_seq`),
  KEY `alarm_box_member_id` (`alarm_box_member_id`),
  KEY `alarm_box_push_alarm_id` (`alarm_box_push_alarm_id`),
  CONSTRAINT `ALARM_BOX_MEMBER_ibfk_1` FOREIGN KEY (`alarm_box_member_id`) REFERENCES `MEMBER` (`member_id`) ON DELETE CASCADE,
  CONSTRAINT `ALARM_BOX_MEMBER_ibfk_2` FOREIGN KEY (`alarm_box_push_alarm_id`) REFERENCES `PUSH_ALARM` (`push_alarm_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 테이블 데이터 testdb.ALARM_BOX_MEMBER:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `ALARM_BOX_MEMBER` DISABLE KEYS */;
/*!40000 ALTER TABLE `ALARM_BOX_MEMBER` ENABLE KEYS */;

-- 테이블 testdb.CART_PRODUCT 구조 내보내기
CREATE TABLE IF NOT EXISTS `CART_PRODUCT` (
  `cart_product_member_id` varchar(50) NOT NULL,
  `cart_product_menu_id` int(11) NOT NULL,
  `cart_product_count` int(11) NOT NULL DEFAULT 1,
  `cart_product_is_check` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`cart_product_member_id`,`cart_product_menu_id`) USING BTREE,
  KEY `cart_product_menu_id` (`cart_product_menu_id`),
  CONSTRAINT `CART_PRODUCT_ibfk_1` FOREIGN KEY (`cart_product_menu_id`) REFERENCES `MENU` (`menu_id`) ON DELETE CASCADE,
  CONSTRAINT `CART_PRODUCT_ibfk_2` FOREIGN KEY (`cart_product_member_id`) REFERENCES `MEMBER` (`member_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 테이블 데이터 testdb.CART_PRODUCT:~6 rows (대략적) 내보내기
/*!40000 ALTER TABLE `CART_PRODUCT` DISABLE KEYS */;
INSERT INTO `CART_PRODUCT` (`cart_product_member_id`, `cart_product_menu_id`, `cart_product_count`, `cart_product_is_check`) VALUES
	('asme12', 4, 0, 0),
	('asme12', 20, 0, 0),
	('asme12', 22, 0, 0),
	('asme12', 26, 0, 0),
	('dongdong', 23, 1, 0),
	('dongdong', 30, 1, 0);
/*!40000 ALTER TABLE `CART_PRODUCT` ENABLE KEYS */;

-- 테이블 testdb.HEART 구조 내보내기
CREATE TABLE IF NOT EXISTS `HEART` (
  `heart_store_id` int(11) NOT NULL,
  `heart_member_id` varchar(50) NOT NULL,
  PRIMARY KEY (`heart_store_id`,`heart_member_id`),
  KEY `heart_member_id` (`heart_member_id`),
  CONSTRAINT `HEART_ibfk_1` FOREIGN KEY (`heart_store_id`) REFERENCES `STORE` (`store_id`) ON DELETE CASCADE,
  CONSTRAINT `HEART_ibfk_2` FOREIGN KEY (`heart_member_id`) REFERENCES `MEMBER` (`member_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 테이블 데이터 testdb.HEART:~2 rows (대략적) 내보내기
/*!40000 ALTER TABLE `HEART` DISABLE KEYS */;
INSERT INTO `HEART` (`heart_store_id`, `heart_member_id`) VALUES
	(1, 'asme12'),
	(2, 'asme12');
/*!40000 ALTER TABLE `HEART` ENABLE KEYS */;

-- 프로시저 testdb.insert_payment 구조 내보내기
DELIMITER //
CREATE PROCEDURE `insert_payment`(
	IN `p_payment_member_id` VARCHAR(50),
	IN `p_payment_store_id` INT,
	IN `p_payment_type` INT,
	IN `p_payment_request_content` TEXT,
	IN `p_payment_get_id` INT,
	IN `p_payment_address` VARCHAR(300),
	IN `p_payment_address_detail` VARCHAR(300),
	IN `p_payment_address_latitude` DECIMAL(20,17),
	IN `p_payment_address_longitude` DECIMAL(20,17),
	IN `p_payment_mileage_price` INT,
	OUT `auto` INT
)
    DETERMINISTIC
BEGIN

	INSERT INTO PAYMENT(payment_member_id,payment_store_id,PAYMENT_TYPE,payment_request_content,payment_date,payment_get_id,payment_address,payment_address_detail,payment_address_latitude,payment_address_longitude,payment_mileage_price) 
	VALUES (p_payment_member_id,p_payment_store_id,p_payment_type,p_payment_request_content,NOW(),p_payment_get_id,p_payment_address,p_payment_address_detail,p_payment_address_latitude,p_payment_address_longitude,p_payment_mileage_price);
	
	SELECT AUTO_INCREMENT INTO auto FROM information_schema.tables WHERE TABLE_NAME = 'PAYMENT' AND table_schema = DATABASE() ;
	
END//
DELIMITER ;

-- 테이블 testdb.MEMBER 구조 내보내기
CREATE TABLE IF NOT EXISTS `MEMBER` (
  `member_id` varchar(50) NOT NULL,
  `member_name` varchar(100) NOT NULL,
  `member_nickname` varchar(100) NOT NULL,
  `member_password` varchar(100) NOT NULL,
  `member_email` varchar(200) NOT NULL,
  `member_phone` varchar(100) NOT NULL,
  `member_address` varchar(300) NOT NULL,
  `member_address_detail` varchar(300) DEFAULT NULL,
  `member_address_latitude` decimal(20,17) NOT NULL,
  `member_address_longitude` decimal(20,17) NOT NULL,
  `member_birthdate` date NOT NULL,
  `member_tier` int(11) NOT NULL DEFAULT 0,
  `member_push_ok` tinyint(1) NOT NULL DEFAULT 1,
  `member_ip_path` text DEFAULT NULL,
  `member_mileage` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`member_id`),
  UNIQUE KEY `member_nickname` (`member_nickname`),
  UNIQUE KEY `member_email` (`member_email`),
  UNIQUE KEY `member_phone` (`member_phone`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 테이블 데이터 testdb.MEMBER:~7 rows (대략적) 내보내기
/*!40000 ALTER TABLE `MEMBER` DISABLE KEYS */;
INSERT INTO `MEMBER` (`member_id`, `member_name`, `member_nickname`, `member_password`, `member_email`, `member_phone`, `member_address`, `member_address_detail`, `member_address_latitude`, `member_address_longitude`, `member_birthdate`, `member_tier`, `member_push_ok`, `member_ip_path`, `member_mileage`) VALUES
	('asme12', '임동선', '임동선#3218547282', '123456', 'asme12@naver.com', '01033331234', '경기 성남시 분당구 판교역로 166', '판교역로 166 102호', 37.39529694707520000, 127.11044929262200000, '2023-12-04', 1, 1, 'http://192.168.0.90:9090/app', 2100),
	('dongdong', '임동선', '동동', '12345', 'asme112@naver.com', '01033932244', '서울특별시 영등포구 선유로 207', NULL, 37.53200749149110000, 126.89379472416400000, '2023-12-04', 0, 1, 'http://192.168.0.90:9090/app', 3147),
	('haha', '마하이', '하하', '12345', 'haha@gmail.com', '01000000000', '서울특별시 마포구 월드컵북로 4길 77', NULL, 37.55938993132770000, 126.92266819719400000, '1998-10-20', 1, 1, NULL, 0),
	('hyunhyun', '김현성', '현현', '12345', 'liberatjd@gmail.com', '01096885728', '서울특별시 마포구 월드컵북로 4길 77', NULL, 37.55938993132770000, 126.92266819719400000, '1998-10-20', 1, 1, NULL, 0),
	('minmin', '민성환', '민민', '12345', 'minmin@gmail.com', '01011111111', '서울특별시 마포구 월드컵북로 4길 77', NULL, 37.55938993132770000, 126.92266819719400000, '1998-10-20', 1, 1, NULL, 0),
	('moonmoon', '정문경', '문문', '12345', 'sogong2022sogong@gmail.com', '01029904564', '서울특별시 마포구 월드컵북로 4길 77', NULL, 37.55938993132770000, 126.92266819719400000, '1988-01-29', 2, 1, NULL, 0),
	('yangyang', '양유경', '양양', '12345', 'mapu6025@gmail.com', '01086846025', '서울특별시 마포구 월드컵북로 4길 77', NULL, 37.55938993132770000, 126.92266819719400000, '2023-12-04', 0, 1, NULL, 0);
/*!40000 ALTER TABLE `MEMBER` ENABLE KEYS */;

-- 테이블 testdb.MEMBER_ADDRESS 구조 내보내기
CREATE TABLE IF NOT EXISTS `MEMBER_ADDRESS` (
  `member_address_seq` int(11) NOT NULL AUTO_INCREMENT,
  `member_address_member_id` varchar(50) NOT NULL,
  `member_address_name` varchar(50) NOT NULL,
  `member_address` varchar(300) NOT NULL,
  `member_address_detail` varchar(300) DEFAULT NULL,
  `member_address_latitude` decimal(20,17) NOT NULL,
  `member_address_longitude` decimal(20,17) NOT NULL,
  PRIMARY KEY (`member_address_seq`),
  UNIQUE KEY `member_address_member_id_member_address_name` (`member_address_member_id`,`member_address_name`),
  KEY `member_address_member_id` (`member_address_member_id`),
  CONSTRAINT `MEMBER_ADDRESS_ibfk_1` FOREIGN KEY (`member_address_member_id`) REFERENCES `MEMBER` (`member_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 테이블 데이터 testdb.MEMBER_ADDRESS:~2 rows (대략적) 내보내기
/*!40000 ALTER TABLE `MEMBER_ADDRESS` DISABLE KEYS */;
INSERT INTO `MEMBER_ADDRESS` (`member_address_seq`, `member_address_member_id`, `member_address_name`, `member_address`, `member_address_detail`, `member_address_latitude`, `member_address_longitude`) VALUES
	(1, 'dongdong', '우리집', '서울 강서구 강서로5가길 40', '101호', 37.52918564387200000, 126.84581650599100000),
	(3, 'asme12', '우리집', '서울 강서구 강서로47라길 56-3', '201호', 37.55049721308500000, 126.83294131677800000);
/*!40000 ALTER TABLE `MEMBER_ADDRESS` ENABLE KEYS */;

-- 테이블 testdb.MEMBER_REVIEW 구조 내보내기
CREATE TABLE IF NOT EXISTS `MEMBER_REVIEW` (
  `payment_seq` int(11) NOT NULL AUTO_INCREMENT,
  `member_review_title` varchar(300) NOT NULL,
  `member_review_content` text NOT NULL,
  `member_review_img_path` varchar(300) DEFAULT NULL,
  `member_review_date` timestamp NOT NULL,
  `member_review_recommend` tinyint(1) NOT NULL DEFAULT 1,
  `member_review_score_number` int(11) NOT NULL DEFAULT 5,
  `owner_review_content` text DEFAULT NULL,
  `owner_review_date` timestamp NULL DEFAULT NULL,
  `member_review_member_id` varchar(50) NOT NULL,
  PRIMARY KEY (`payment_seq`),
  KEY `payment_seq` (`payment_seq`,`member_review_member_id`),
  CONSTRAINT `MEMBER_REVIEW_ibfk_1` FOREIGN KEY (`payment_seq`) REFERENCES `PAYMENT` (`payment_seq`) ON DELETE CASCADE,
  CONSTRAINT `MEMBER_REVIEW_ibfk_3` FOREIGN KEY (`payment_seq`, `member_review_member_id`) REFERENCES `PAYMENT` (`payment_seq`, `payment_member_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 테이블 데이터 testdb.MEMBER_REVIEW:~10 rows (대략적) 내보내기
/*!40000 ALTER TABLE `MEMBER_REVIEW` DISABLE KEYS */;
INSERT INTO `MEMBER_REVIEW` (`payment_seq`, `member_review_title`, `member_review_content`, `member_review_img_path`, `member_review_date`, `member_review_recommend`, `member_review_score_number`, `owner_review_content`, `owner_review_date`, `member_review_member_id`) VALUES
	(1, '너무 맛있어요', '너무 맛있어요', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/review/1704279665589_images%20%281%29.jpg', '2024-01-01 20:01:05', 1, 5, '감사합니다 또 이용해주세요 푸하하크림빵입니다.', '2024-01-03 20:24:13', 'dongdong'),
	(2, '맛있어요', '맛있어요', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/review/1704279800665_images%20%282%29.jpg', '2024-01-01 20:03:20', 1, 5, '감사합니다 또 이용해주세요 푸하하크림빵입니다.', '2024-01-03 20:24:15', 'dongdong'),
	(3, '또 이용하겠습니다.', '사장님 빵이 너무 맛있어요 또 이용할게요', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/review/1704280066807_images%20%283%29.jpg', '2024-01-02 20:07:46', 1, 5, '감사합니다 또 이용해주세요 푸하하크림빵입니다.', '2024-01-03 20:24:18', 'dongdong'),
	(4, '사장님 빵이 너무 맛있어요', '사장님 빵이 너무 맛있어서 둘이 먹다 한 명만 살아 남았어요', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/review/1704280146779_images%20%285%29.jpg', '2024-01-02 20:09:06', 0, 5, '감사합니다 또 이용해주세요 푸하하크림빵입니다.', '2024-01-03 20:24:20', 'dongdong'),
	(5, '사장님 갓 구운 빵이 너무 맛있어요', '갓 구운 빵이 너무 따뜻하고 맛있어요', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/review/1704280204203_images%20%284%29.jpg', '2024-01-02 20:10:04', 1, 4, '감사합니다 또 이용해주세요 푸하하크림빵입니다.', '2024-01-03 20:24:25', 'dongdong'),
	(6, '빵이 너무 맛있어요', '빵이 너무 맛있어서 엄마가 좋아했어요', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/review/1704280256778_images%20%286%29.jpg', '2024-01-02 20:10:56', 1, 4, '감사합니다 또 이용해주세요 푸하하크림빵입니다.', '2024-01-03 20:24:22', 'dongdong'),
	(7, '사장님', '빵이 너무 맛있습니다.', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/review/1704280299266_images%20%287%29.jpg', '2024-01-03 20:11:39', 0, 5, '감사합니다~ 또 오세요~', '2024-01-04 11:13:09', 'dongdong'),
	(16, '너무 맛 없어요', '너무 맛 없어요~~', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/review/1704340167168_images%20%2810%29.jpg', '2024-01-04 12:49:27', 1, 1, NULL, NULL, 'dongdong'),
	(17, '너무 맛있어요', '너무 맛있어요', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/review/1704340008311_images%20%283%29.jpg', '2024-01-04 12:46:48', 1, 5, '맛있게 드셔주셔서 감사합니다!!', '2024-01-04 16:07:24', 'asme12'),
	(20, '너무 맛있어요!!!', '맛있습니다~~~', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/review/1704335897495_2022030801325_0.jpg', '2024-01-04 11:38:15', 1, 5, NULL, NULL, 'asme12');
/*!40000 ALTER TABLE `MEMBER_REVIEW` ENABLE KEYS */;

-- 테이블 testdb.MENU 구조 내보내기
CREATE TABLE IF NOT EXISTS `MENU` (
  `menu_id` int(11) NOT NULL AUTO_INCREMENT,
  `menu_store_id` int(11) DEFAULT NULL,
  `menu_category` int(11) NOT NULL,
  `menu_name` varchar(100) NOT NULL,
  `menu_image_path` varchar(300) DEFAULT NULL,
  `menu_thumb_image_path` varchar(300) DEFAULT NULL,
  `menu_count` int(11) NOT NULL DEFAULT 0,
  `menu_sale_count` int(11) NOT NULL DEFAULT 0,
  `menu_price` int(11) NOT NULL DEFAULT 0,
  `menu_describe` text DEFAULT NULL,
  `menu_is_signature` tinyint(1) DEFAULT NULL,
  `menu_is_hot` tinyint(1) DEFAULT NULL,
  `menu_is_subscribe` tinyint(1) DEFAULT NULL,
  `menu_discount_price` int(11) NOT NULL DEFAULT 0,
  `menu_time` int(11) DEFAULT 8,
  `menu_making_count` int(11) DEFAULT NULL,
  PRIMARY KEY (`menu_id`),
  UNIQUE KEY `menu_store_id_menu_name` (`menu_store_id`,`menu_name`),
  KEY `menu_store_id` (`menu_store_id`),
  KEY `menu_category` (`menu_category`),
  CONSTRAINT `MENU_ibfk_1` FOREIGN KEY (`menu_store_id`) REFERENCES `STORE` (`store_id`) ON DELETE CASCADE,
  CONSTRAINT `MENU_ibfk_2` FOREIGN KEY (`menu_category`) REFERENCES `MENU_CATEGORY` (`menu_category_seq`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 테이블 데이터 testdb.MENU:~20 rows (대략적) 내보내기
/*!40000 ALTER TABLE `MENU` DISABLE KEYS */;
INSERT INTO `MENU` (`menu_id`, `menu_store_id`, `menu_category`, `menu_name`, `menu_image_path`, `menu_thumb_image_path`, `menu_count`, `menu_sale_count`, `menu_price`, `menu_describe`, `menu_is_signature`, `menu_is_hot`, `menu_is_subscribe`, `menu_discount_price`, `menu_time`, `menu_making_count`) VALUES
	(1, 1, 4, '소금크림빵', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704096800539_%EC%86%8C%EA%B8%88%ED%81%AC%EB%A6%BC%EB%B9%B5%EB%A9%94%EC%9D%B8.jpg', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704096800539_thumb_%EC%86%8C%EA%B8%88%ED%81%AC%EB%A6%BC%EB%B9%B5.jpeg', 9, 0, 2800, '달지않고 특허받은 크림소금으로 느끼함까지 없엔 시그니쳐 크림빵', 1, 1, 0, 0, 8, NULL),
	(2, 1, 4, '리얼딸기크림빵', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704103386263_thumb_%EB%A6%AC%EC%96%BC%EB%94%B8%EA%B8%B0%ED%81%AC%EB%A6%BC%EB%B9%B5.jpeg', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704103386263_thumb_%EB%A6%AC%EC%96%BC%EB%94%B8%EA%B8%B0%ED%81%AC%EB%A6%BC%EB%B9%B5.jpeg', 10, 0, 2800, '상큼한 딸기와 부드러운 생크림의 환상 조합 인기 크림빵', 1, 0, 0, 0, 14, 0),
	(3, 1, 4, '제주말차크림빵', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704103513646_thumb_%EC%A0%9C%EC%A3%BC%EB%A7%90%EC%B0%A8%ED%81%AC%EB%A6%BC%EB%B9%B5.jpeg', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704103513646_thumb_%EC%A0%9C%EC%A3%BC%EB%A7%90%EC%B0%A8%ED%81%AC%EB%A6%BC%EB%B9%B5.jpeg', 10, 0, 2800, '맛과 향이 찐한 제주말차의 매력에 중독되는 인기 크림빵', 1, 0, 0, 0, 8, 0),
	(4, 1, 4, '그릭요거트크림빵', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704103692553_%EA%B7%B8%EB%A6%AD%EC%9A%94%EA%B1%B0%ED%8A%B8%ED%81%AC%EB%A6%BC%EB%B9%B5.jpg', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704103692553_thumb_%EA%B7%B8%EB%A6%AD%EC%9A%94%EA%B1%B0%ED%8A%B8%ED%81%AC%EB%A6%BC%EB%B9%B5.jpeg', 10, 0, 2800, '상큼한 그릭요거트의 깊은 풍미에 매료되는 인기 크림빵', 1, 0, 0, 0, 14, 0),
	(5, 1, 4, '덜단팥크림빵', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704103802642_%EB%8D%9C%EB%8B%A8%ED%8C%A5%ED%81%AC%EB%A6%BC%EB%B9%B5%EB%A9%94%EC%9D%B8.jpg', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704103802642_thumb_%EB%8D%9C%EB%8B%A8%ED%8C%A5%ED%81%AC%EB%A6%BC%EB%B9%B5.jpeg', 10, 0, 3000, '아는 맛에 매료되는 단팥과 생크림의 절대 조합', 0, 0, 0, 0, 10, NULL),
	(6, 1, 4, '말차단팥크림빵', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704103901710_%EB%A7%90%EC%B0%A8%EB%8B%A8%ED%8C%A5%ED%81%AC%EB%A6%BC%EB%B9%B5.jpg', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704103901710_thumb_%EB%A7%90%EC%B0%A8%EB%8B%A8%ED%8C%A5%ED%81%AC%EB%A6%BC%EB%B9%B5.jpeg', 10, 0, 3300, '말차 크림과 단팥이 더해져 쌉살 달콤함으로 태어난 프리미엄 크림빵', 0, 0, 0, 0, 8, NULL),
	(7, 1, 4, '초코X소금크림빵', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704104092577_%EC%B4%88%EC%BD%94x%EC%86%8C%EA%B8%88%ED%81%AC%EB%A6%BC%EB%B9%B5.jpg', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704104092577_thumb_%EC%B4%88%EC%BD%94X%EC%86%8C%EA%B8%88%ED%81%AC%EB%A6%BC%EB%B9%B5.jpeg', 10, 0, 3000, '연말 시즌한정 크림 소금 크림 빵위에 다크 초코가 퐁듀되어 달콤함이 더해진 소금 크림빵', 0, 0, 0, 0, 14, NULL),
	(8, 1, 1, '아메리카노', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704104415535_thumb_%EC%95%84%EB%A9%94%EB%A6%AC%EC%B9%B4%EB%85%B8.jpg', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704104415535_thumb_%EC%95%84%EB%A9%94%EB%A6%AC%EC%B9%B4%EB%85%B8.jpg', 0, 0, 2000, '가장 기본적인 커피로 로스팅원두 에스프레소에 차가운 물을 혼합한 커피', 0, 0, 0, 200, 8, 0),
	(9, 1, 1, '카페라떼', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704104542740_200406_HOT%E1%84%85%E1%85%A1%E1%84%84%E1%85%A6-1280x1280-1-1280x1280.jpg', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704104542740_thumb_ec4b1b342d0d3.png', 40, 0, 2500, '리스트레또 더블샷과 스팀우유를 넣어 만든 베이직 커피 음료', 0, 0, 0, 200, 14, NULL),
	(10, 1, 9, '아마레 체리 빙수', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704104640346_226649676_3_1688301908_w360.jpg', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704104640346_thumb_%EC%95%84%EB%A7%88%EB%A0%88%EC%B2%B4%EB%A6%AC%EB%B9%99%EC%88%98.jpg', 8, 0, 10000, '폭신한 우유 얼음에 아마레나 체리 시럽을 듬뿍 올린 아마레 체리 빙수', 1, 1, 0, 1000, 8, NULL),
	(11, 1, 9, '통단팥듬뿍우유팥빙수', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704104719563_KakaoTalk_20230604_135205436_08.jpg', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704104719563_thumb_KakaoTalk_20230531_093810580_06.jpg', 10, 0, 10000, '통단팥, 인절미떡과 함께 페스츄리처럼 겹겹이 간 우유 얼음을 사용해 부드러운 팥빙수', 0, 0, 0, 1000, 14, NULL),
	(12, 1, 1, '리얼 딸기라떼', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704104801055_maxresdefault.jpg', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704104801055_thumb_%EB%A6%AC%EC%96%BC%EB%94%B8%EA%B8%B0%EB%9D%BC%EB%96%BC_230323-1280x1280.jpg', 46, 0, 3000, '더욱 진해진 딸기라떼! 상큼한 딸기와 신선한 우유가 만나 부드럽게 즐기는 라떼', 0, 0, 0, 200, 8, NULL),
	(13, 1, 7, '생딸기프레지에', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704104950797_%EC%83%9D%EB%94%B8%EA%B8%B0%ED%94%84%EB%A0%88%EC%A7%80%EC%97%90-_%ED%94%BD%EC%88%98%EC%A0%95-%EC%9E%90%EC%8A%A4%EB%AF%BC%EC%A0%9C%EA%B1%B0.jpg', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704104950797_thumb_2111953714_0000002.jpg', 3, 0, 20000, '커스터드 치즈크림을 샌드하고 상큼한 비타베리로 장식한 생딸기 프레지에 케이크', 0, 0, 0, 2000, 8, NULL),
	(14, 1, 7, '순수(秀)우유 케이크', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704105050655_thumb_%EC%88%9C%EC%88%98%E7%A7%80%EC%9A%B0%EC%9C%A0-%EC%BC%80%EC%9D%B4%ED%81%AC-15cm.jpg', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704105050655_thumb_%EC%88%9C%EC%88%98%E7%A7%80%EC%9A%B0%EC%9C%A0-%EC%BC%80%EC%9D%B4%ED%81%AC-15cm.jpg', 4, 0, 18000, '신선한 우유의 고소한맛 그대로, 순수우유케이크', 0, 0, 0, 2000, 8, 0),
	(15, 1, 2, '고구마 슈크림 식빵', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704105190151_%EB%8B%A4%EC%9A%B4%EB%A1%9C%EB%93%9C%20%281%29.jpg', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704105190151_thumb_d6761620-f8b5-44ff-a98f-56a65c0b87f0.png', 17, 0, 3500, '콕콕 박혀있는 고구마와 달콤한 슈크림이 조화로워 남녀노소 좋아하는 우리가족 간식빵', 1, 1, 0, 500, 8, NULL),
	(16, 2, 7, '딸기생크림케이크', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704105600302_%EB%8B%A4%EC%9A%B4%EB%A1%9C%EB%93%9C%20%282%29.jpg', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704105600302_thumb_%EC%83%9D%EB%94%B8%EA%B8%B0%ED%94%84%EB%A0%88%EC%A7%80%EC%97%90-_%ED%94%BD%EC%88%98%EC%A0%95-%EC%9E%90%EC%8A%A4%EB%AF%BC%EC%A0%9C%EA%B1%B0.png', 3, 0, 20000, '커스터드 치즈크림을 샌드하고 상큼한 비타베리로 장식한 생딸기 프레지에 케이크', 0, 0, 0, 0, 8, NULL),
	(17, 2, 1, '아메리카노', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704105821844_%EB%8B%A4%EC%9A%B4%EB%A1%9C%EB%93%9C.jpg', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704105821844_thumb_images.jpg', 50, 0, 1500, '가장 기본적인 커피로 로스팅된 원두에 에스프레소를 차가운 물에 혼합한 커피', 0, 0, 0, 0, 8, NULL),
	(18, 2, 2, '5가지 곡물 식빵', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704105895918_302343-%EB%9C%AF%EC%96%B4%EB%A8%B9%EB%8A%94-%EB%A1%A4%EC%B9%98%EC%A6%88-%EB%B8%8C%EB%A0%88%EB%93%9C_%EC%8D%B8%EB%84%A4%EC%9D%BC1-600x600.png', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704105895918_thumb_5%EA%B0%80%EC%A7%80%EA%B3%A1%EB%AC%BC%EC%8B%9D%EB%B9%B5-1280x1280.jpg', 15, 0, 3000, '밀, 호밀, 귀리, 보리, 콩 5가지 곡물과 해바라기씨, 아다씨, 참깨, 검정깨 4가지 씨앗이 들어가 씹을수록 고소한 식빵', 1, 1, 0, 500, 8, NULL),
	(19, 2, 4, '콤비네이션피자 바게뜨', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704106013314_%EC%BD%A4%EB%B9%84%EB%84%A4%EC%9D%B4%EC%85%98%ED%94%BC%EC%9E%90%EB%B0%94%EA%B2%8C%EB%9C%A8-1280x1280.jpg', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704106013314_thumb_%EC%BD%A4%EB%B9%84%EB%84%A4%EC%9D%B4%EC%85%98%ED%94%BC%EC%9E%90%EB%B0%94%EA%B2%8C%EB%9C%A8-1280x1280.jpg', 20, 0, 4000, '', 0, 0, 0, 500, 8, NULL),
	(20, 2, 4, '매콤 제육고로케', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704106081201_img.jpg', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704106081201_thumb_05%EC%A0%9C%EC%9C%A1%EA%B3%A0%EB%A1%9C%EC%BC%80_%EB%8B%A8%EB%A9%B4.jpg', 30, 0, 3000, '한국대표 고기반찬이 고로케 속에! 아삭한 야채와 매콤한 제육이 들어간 고로케', 1, 1, 0, 500, 8, NULL),
	(21, 2, 3, '멀티그레인 호밀브레드', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704106156463_%ED%86%B5%EB%B0%80-%EB%B8%8C%EB%A0%88%EB%93%9C_%EC%8D%B8%EB%84%A4%EC%9D%BC1-%EC%88%98%EC%A0%95-600x600.jpg', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704106156463_thumb_%EB%A9%80%ED%8B%B0%EA%B7%B8%EB%A0%88%EC%9D%B8-%ED%98%B8%EB%B0%80%EB%B8%8C%EB%A0%88%EB%93%9C-1280x1280.jpg', 10, 0, 4000, '호두,참깨,호밀,귀리를 넣어 반죽한 구수한 풍미의 빵을 겉은 바삭하고 속은 촉촉하게 구워낸 곡물브레드', 0, 0, 0, 0, 8, NULL),
	(22, 3, 2, 'NEW시나몬모닝토스트', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704106322386_thumb_%EC%8B%9C%EB%82%98%EB%AA%AC-%EB%AA%A8%EB%8B%9D%ED%86%A0%EC%8A%A4%ED%8A%B8_%EC%8D%B8%EB%84%A4%EC%9D%BC1-1280x1280%20%281%29.jpg', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704106322386_thumb_%EC%8B%9C%EB%82%98%EB%AA%AC-%EB%AA%A8%EB%8B%9D%ED%86%A0%EC%8A%A4%ED%8A%B8_%EC%8D%B8%EB%84%A4%EC%9D%BC1-1280x1280%20%281%29.jpg', 20, 0, 3500, '페스츄리 결이 살아있어 바삭하고, 은은한 시나몬향과 달콤한 맛이 조화로운 패스츄리 식빵', 1, 1, 0, 1000, 8, 0),
	(23, 3, 2, '뜯어먹는 롤치즈 브레드', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704107457321_302342-%EB%9C%AF%EC%96%B4%EB%A8%B9%EB%8A%94-%EB%A1%A4%EC%B9%98%EC%A6%88-%EB%B8%8C%EB%A0%88%EB%93%9C_full_%EC%8D%B8%EB%84%A4%EC%9D%BC1.png', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704107457321_thumb_302343-%EB%9C%AF%EC%96%B4%EB%A8%B9%EB%8A%94-%EB%A1%A4%EC%B9%98%EC%A6%88-%EB%B8%8C%EB%A0%88%EB%93%9C_%EC%8D%B8%EB%84%A4%EC%9D%BC1.png', 5, 0, 5000, '쫄깃 담백한 빵에 감칠맛 나면서도 짭쪼름한 롤 치즈가 쏙쏙 박혀 뜯어먹으면 더 맛있는 브레드', 1, 0, 0, 0, 8, NULL),
	(24, 3, 4, '추억의앙꼬빵', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704107514358_%EB%8B%A4%EC%9A%B4%EB%A1%9C%EB%93%9C.jpg', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704107514358_thumb_%EC%B6%94%EC%96%B5%EC%9D%98%EC%95%99%EA%BC%AC%EB%B9%B5_%EB%8B%A8%EB%A9%B4-1280x1280.jpg', 30, 0, 2000, '촉촉하고 부드러운 빵에 곱게 갈아낸 부드러운 팥이 가득한 미니단팥빵', 0, 0, 0, 500, 8, NULL),
	(25, 3, 4, '사각사각 애플파이', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704107561799_%EB%8B%A4%EC%9A%B4%EB%A1%9C%EB%93%9C%20%281%29.jpg', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704107561799_thumb_02%EC%82%AC%EA%B0%81%EC%82%AC%EA%B0%81%EC%95%A0%ED%94%8C%ED%8C%8C%EC%9D%B4_%EB%8B%A8%EB%A9%B4.jpg', 30, 0, 1500, '사각사각 상큼한 사과 과육이 씹히는, 진한 버터 풍미의 클래식한 애플파이', 0, 0, 0, 0, 8, NULL),
	(26, 3, 4, '사르르 연유수플레', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704107599073_2Q4A2322-1.jpg', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704107599073_thumb_2Q4A2317.jpg', 30, 0, 1500, '신선한 머랭을 더해 부드러운 수플레 사이 연유생크림을 듬뿍 넣어 입안에서 사르르 녹는 한 입 케이크', 0, 0, 0, 0, 8, NULL),
	(27, 3, 8, '브랙퍼스트 머핀버거', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704107686967_%EB%8B%A4%EC%9A%B4%EB%A1%9C%EB%93%9C%20%282%29.jpg', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704107686967_thumb_%EB%B8%8C%EB%9E%99%ED%8D%BC%EC%8A%A4%ED%8A%B8-%EB%A8%B8%ED%95%80%EB%B2%84%EA%B1%B0-1280x1280.png', 30, 0, 3000, '고소한 메밀머핀 사이에 스크램블에그, 치즈, 미트패티 등 다양한 원료를 넣어 든든한 잉글리쉬머핀 샌드위치', 0, 0, 0, 500, 8, NULL),
	(28, 3, 8, '스크램블에그 소시지 바게뜨', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704107804714_%EB%8B%A4%EC%9A%B4%EB%A1%9C%EB%93%9C%20%283%29.jpg', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704107804714_thumb_%EC%8A%A4%ED%81%AC%EB%9E%A8%EB%B8%94%EC%97%90%EA%B7%B8-%EC%86%8C%EC%8B%9C%EC%A7%80-%EB%B0%94%EA%B2%8C%EB%9C%A8-%EC%83%8C%EB%93%9C%EC%9C%84%EC%B9%98-1280x1280.png', 30, 0, 3000, '바삭하고 부드러운 바게뜨 속 통통한 소시지와 부드러운 스크램블에그가 조화로운 샌드위치', 1, 0, 0, 0, 8, NULL),
	(29, 3, 9, '갓구운 쫀득바삭 초코칩 쿠키', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704107890444_chokchoko-la-chu802.jpg', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704107890444_thumb_%EA%B0%93%EA%B5%AC%EC%9A%B4-%EC%AB%80%EB%93%9D%EB%B0%94%EC%82%AD-%EC%9E%90%EC%9D%B4%EC%96%B8%ED%8A%B8-%EC%B4%88%EC%BD%94%EC%B9%A9-%EC%BF%A0%ED%82%A4.png', 40, 0, 2000, '크고 두툼한 사이즈가 매력인 뉴욕 스타일 르뱅쿠키 타입의 쿠키로 청키한 초코칩이 듬뿍 들어있는 자이언트 더블 초코칩 쿠키', 0, 0, 0, 500, 8, NULL),
	(30, 3, 9, '갓구운 쫀득바삭 스모어쿠키', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704107938724_%EA%B0%93%EA%B5%AC%EC%9A%B4-%EC%AB%80%EB%93%9D%EB%B0%94%EC%82%AD-%EC%9E%90%EC%9D%B4%EC%96%B8%ED%8A%B8-%EC%8A%A4%EB%AA%A8%EC%96%B4%EC%BF%A0%ED%82%A4.png', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704107938724_thumb_KakaoTalk_20230523_153231483_06.jpg', 29, 0, 2000, '더욱 커진 진한 초코쿠키 속 쫀득하고 달콤한 마시멜로우가 들어간 자이언트 스모어 쿠키', 0, 0, 0, 0, 8, NULL),
	(31, 3, 9, '갓구운 쫀득바삭 솔티드 카라멜 쿠키', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704108025906_%EA%B0%93%EA%B5%AC%EC%9A%B4-%EC%AB%80%EB%93%9D%EB%B0%94%EC%82%AD-%EC%9E%90%EC%9D%B4%EC%96%B8%ED%8A%B8-%EC%86%94%ED%8B%B0%EB%93%9C-%EC%B9%B4%EB%9D%BC%EB%A9%9C-%EC%BF%A0%ED%82%A4-600x600.png', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704108025906_thumb_%EB%B2%A0%EB%A6%AC-%EC%98%A4%ED%8A%B8%EB%B0%80-%EC%BF%A0%ED%82%A4-1-600x600.jpg', 0, 0, 0, '크고 두툼한 사이즈가 매력인 뉴욕 스타일 르뱅쿠키 타입의 쿠키로 단짠의 진수를 보여주는 자이언트 솔티드 카라멜 쿠키', 0, 0, 0, 0, 8, NULL),
	(32, 4, 9, '딸기바닐라푸딩', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704115263580_%EB%94%B8%EA%B8%B0%EB%B0%94%EB%8B%90%EB%9D%BC%ED%91%B8%EB%94%A98000.jpg', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704115263580_thumb_%EB%94%B8%EA%B8%B0%EB%B0%94%EB%8B%90%EB%9D%BC%ED%91%B8%EB%94%A98000.jpg', 10, 0, 8000, '달콤한 바닐라 크림 속 닐라웨이퍼와 신선한 설향 딸기가 가득 들어간 \'딸기바닐라푸딩\' 입니다.', 1, 1, 0, 0, 11, NULL),
	(33, 4, 9, '딸기오레오푸딩', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704115363727_thumb_%EB%94%B8%EA%B8%B0%EC%98%A4%EB%A0%88%EC%98%A4%ED%91%B8%EB%94%A98000.jpg', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704115363727_thumb_%EB%94%B8%EA%B8%B0%EC%98%A4%EB%A0%88%EC%98%A4%ED%91%B8%EB%94%A98000.jpg', 10, 0, 8000, '부드러운 바닐라크림에 쌉쌀한 블랙쿠키과 다크초콜릿, 상큼한 제철 딸기가 듬뿍 들어간\'딸기오레오푸딩\'입니다.', 0, 1, 0, 0, 11, 0),
	(34, 4, 9, '로얄밀크티푸딩', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704115554266_%EB%A1%9C%EC%96%84%EB%B0%80%ED%81%AC%ED%8B%B0%ED%91%B8%EB%94%A97800.jpg', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704115439866_thumb_%EB%A1%9C%EC%96%84%EB%B0%80%ED%81%AC%ED%8B%B0%ED%91%B8%EB%94%A97800.jpg', 20, 0, 7800, '세가지 홍차를 블렌딩하여 만든 밀크티 크림에 닐라웨이퍼와  다크 & 화이트초콜릿을 넣어 만든 \'로얄밀크티푸딩\' 입니다. ', 1, 0, 0, 0, 11, 0),
	(35, 4, 9, '마들렌러스크', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704115516426_%EB%A7%88%EB%93%A4%EB%A0%8C%EB%9F%AC%EC%8A%A4%ED%81%AC3600.jpg', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704115516426_thumb_%EB%A7%88%EB%93%A4%EB%A0%8C%EB%9F%AC%EC%8A%A4%ED%81%AC3600.jpg', 5, 0, 3600, '오프라인 매장 내 구움과자 중 가장 많은 인기를 자랑하는 코들렌을 활용하여 스낵처럼 재탄생 시킨 \'마들렌러스크\' 입니다.', 0, 0, 0, 0, 11, NULL),
	(36, 4, 9, '말차라즈베리', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704115617288_%EB%A7%90%EC%B0%A8%EB%9D%BC%EC%A6%88%EB%B2%A0%EB%A6%AC3800.jpg', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704115617288_thumb_%EB%A7%90%EC%B0%A8%EB%9D%BC%EC%A6%88%EB%B2%A0%EB%A6%AC3800.jpg', 10, 0, 3800, '말차라즈베리 티케이크입니다.', 0, 0, 0, 0, 11, NULL),
	(37, 4, 9, '미쯔말차푸딩', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704115686752_%EB%AF%B8%EC%AF%94%EB%A7%90%EC%B0%A8%ED%91%B8%EB%94%A97200.jpg', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704115686752_thumb_%EB%AF%B8%EC%AF%94%EB%A7%90%EC%B0%A8%ED%91%B8%EB%94%A97200.jpg', 10, 0, 7200, '묵직한듯 크리미한 말차크림과 쌉쌀한 맛의 블랙쿠키, 다크 & 화이트초콜릿 조합의 말차푸딩', 0, 0, 0, 0, 11, NULL),
	(38, 4, 9, '바나나오레오푸딩', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704115734501_%EB%B0%94%EB%82%98%EB%82%98%EC%98%A4%EB%A0%88%EC%98%A4%ED%91%B8%EB%94%A97300.jpg', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704115734501_thumb_%EB%B0%94%EB%82%98%EB%82%98%EC%98%A4%EB%A0%88%EC%98%A4%ED%91%B8%EB%94%A97300.jpg', 15, 0, 7300, '부드러운 바닐라크림 속 쌉쌀한 블랙쿠키와 신선한 바나나 조합의 누구나 좋아할 맛의 푸딩', 1, 1, 0, 0, 11, NULL),
	(39, 4, 9, '바나나푸딩', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704115771341_%EB%B0%94%EB%82%98%EB%82%98%ED%91%B8%EB%94%A97200.jpg', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704115771341_thumb_%EB%B0%94%EB%82%98%EB%82%98%ED%91%B8%EB%94%A97200.jpg', 18, 0, 7200, '부드러운 바닐라크림 속 신선한 바나나와 닐라웨이퍼 조합의 대중적인 맛의 달콤한 브레드 푸딩', 1, 1, 0, 0, 11, NULL),
	(40, 4, 9, '발로나밀크푸딩', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704115811593_%EB%B0%9C%EB%A1%9C%EB%82%98%EB%B0%80%ED%81%AC%ED%91%B8%EB%94%A97600.jpg', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704115811593_thumb_%EB%B0%9C%EB%A1%9C%EB%82%98%EB%B0%80%ED%81%AC%ED%91%B8%EB%94%A97600.jpg', 0, 0, 7600, '페레레로쉐, 허쉬로 유명한 유니그리사의 카라벨라 초콜릿과 발로나 크림을 블렌딩한 초코푸딩', 0, 0, 0, 0, 11, NULL),
	(41, 4, 9, '슈톨렌사블레버킷', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704115891304_%EC%8A%88%ED%86%A8%EB%A0%8C%EC%82%AC%EB%B8%8C%EB%A0%88%EB%B2%84%ED%82%B78300.jpg', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704115891304_thumb_%EC%8A%88%ED%86%A8%EB%A0%8C%EC%82%AC%EB%B8%8C%EB%A0%88%EB%B2%84%ED%82%B78300.jpg', 10, 0, 8300, '겨울 시즌에만 즐길 수 있는 리미티드 메뉴 \'슈톨렌 사블레버킷\' 입니다.', 0, 0, 0, 0, 11, NULL),
	(42, 4, 9, '쑥푸딩', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704115938525_%EC%91%A5%ED%91%B8%EB%94%A97400.jpg', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704115938525_thumb_%EC%91%A5%ED%91%B8%EB%94%A97400.jpg', 2, 0, 7400, '진한 쑥크림과 고소한 땅콩쿠키, 달콤한 콩배기가 듬뿍 들어간 쑥푸딩', 0, 0, 0, 0, 11, NULL),
	(43, 4, 9, '애플티케이크', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704115985748_%EC%95%A0%ED%94%8C%ED%8B%B0%EC%BC%80%EC%9D%B4%ED%81%AC3800.jpg', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704115985748_thumb_%EC%95%A0%ED%94%8C%ED%8B%B0%EC%BC%80%EC%9D%B4%ED%81%AC3800.jpg', 10, 0, 3800, '국내산 사과로 만든 애플티케이크 입니다.', 0, 0, 0, 0, 11, NULL),
	(44, 4, 9, '초코레이또', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704116022876_%EC%B4%88%EC%BD%94%EB%A0%88%EC%9D%B4%EB%98%903800.jpg', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704116022876_thumb_%EC%B4%88%EC%BD%94%EB%A0%88%EC%9D%B4%EB%98%903800.jpg', 8, 0, 3800, '달지않은 진한 맛의 발로나 베이스에 헤이즐넛스프레드와 라즈베리잼 조합의 티케이크', 0, 0, 0, 0, 11, NULL),
	(45, 4, 9, '트리플콤보스', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704116055921_%ED%8A%B8%EB%A6%AC%ED%94%8C%EC%BD%A4%EB%B3%B4%EC%8A%A43800.jpg', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704116055921_thumb_%ED%8A%B8%EB%A6%AC%ED%94%8C%EC%BD%A4%EB%B3%B4%EC%8A%A43800.jpg', 10, 0, 3800, '풍성한 치즈맛 베이스에 꼬독하게 씹히는 롤즈, 치즈케이크, 바삭한 콤보스 조합의 티케이크', 0, 0, 0, 0, 11, NULL),
	(46, 4, 9, '흑임자푸딩', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704116091379_%ED%9D%91%EC%9E%84%EC%9E%90%ED%91%B8%EB%94%A97500.jpg', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704116091379_thumb_%ED%9D%91%EC%9E%84%EC%9E%90%ED%91%B8%EB%94%A97500.jpg', 11, 0, 7500, '진한 흑임자 크림과 고소한 땅콩쿠키, 달콤한 콩배기로 어우러진 흑임자 푸딩', 0, 0, 0, 0, 11, NULL),
	(47, 5, 3, '마늘바게트', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704116736601_%EB%A7%88%EB%8A%98%EB%B0%94%EA%B2%8C%ED%8A%B86800.jpg', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704116736601_thumb_%EB%A7%88%EB%8A%98%EB%B0%94%EA%B2%8C%ED%8A%B86800.jpg', 25, 0, 6800, '만동제과의 시그니처 마늘바게트', 1, 1, 0, 0, 8, NULL),
	(48, 5, 3, '무화과깜빠뉴', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704116866665_%EB%AC%B4%ED%99%94%EA%B3%BC%EA%B9%9C%EB%B9%A0%EB%89%B44800.jpg', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704116866665_thumb_%EB%AC%B4%ED%99%94%EA%B3%BC%EA%B9%9C%EB%B9%A0%EB%89%B44800.jpg', 20, 0, 4800, '직접 공수한 무화과로 만들었습니다.', 0, 0, 0, 0, 8, NULL),
	(49, 5, 4, '어니언베이글', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704116918710_%EC%96%B4%EB%8B%88%EC%96%B8%EB%B2%A0%EC%9D%B4%EA%B8%805400.jpg', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704116918710_thumb_%EC%96%B4%EB%8B%88%EC%96%B8%EB%B2%A0%EC%9D%B4%EA%B8%805400.jpg', 10, 0, 5400, '커피와 잘 어울리는 어니언 베이글입니다.', 0, 0, 0, 0, 8, NULL),
	(50, 5, 4, '엉덩이', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704116958417_%EC%97%89%EB%8D%A9%EC%9D%B43300.jpg', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704116958417_thumb_%EC%97%89%EB%8D%A9%EC%9D%B43300.jpg', 10, 0, 3300, '새하얗고 토실토실한 엉덩이빵', 0, 0, 0, 0, 8, NULL),
	(51, 5, 4, '콘마요', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704117001428_%EC%BD%98%EB%A7%88%EC%9A%944800.jpg', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704117001428_thumb_%EC%BD%98%EB%A7%88%EC%9A%944800.jpg', 10, 0, 4800, '치즈와 콘이 잔뜩 올라간 콘마요', 1, 0, 0, 0, 8, NULL),
	(52, 8, 9, '오트밀씨드베리', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704118367060_%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7%202024-01-01%20231045.png', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704118367060_thumb_%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7%202024-01-01%20231045.png', 10, 0, 4700, '크랜베리와 각종 씨앗들이 듬뿍 들어간 풍성한 식감의 오트밀씨드베', 0, 0, 0, 0, 8, NULL),
	(53, 8, 9, '무화과시나몬', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704118487814_%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7%202024-01-01%20231431.png', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704118487814_thumb_%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7%202024-01-01%20231348.png', 6, 0, 4700, '건무화과 + 은은한 시나몬 향 + 호두, 지루할 틈이 없는 쿠키!', 1, 0, 0, 0, 8, NULL),
	(54, 8, 9, '말차화이트초코', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704118596091_%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7%202024-01-01%20231616.png', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704118596091_thumb_%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7%202024-01-01%20231601.png', 8, 0, 4700, '쌉쌀한 말차와 화이트초코, 마카다미아의 최강 조합이 뭉쳤다!', 0, 1, 0, 500, 8, NULL),
	(55, 8, 9, '피칸정크초코', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704119307536_%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7%202024-01-01%20232804.png', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704119307536_thumb_%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7%202024-01-01%20232804.png', 0, 0, 4700, '씁쓸한 카카오 반죽에 고급진 청크초코와 고소한 피칸이 콕콕 박혀있어요~!', 0, 0, 0, 0, 8, NULL),
	(56, 8, 9, '쑥인절미', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704119391973_%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7%202024-01-01%20232932.png', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704119391973_thumb_%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7%202024-01-01%20232932.png', 12, 0, 4900, '할매입맛 쏘리질뤄 yeah~~ 꼬숩미 대폭발하는 쿠키!', 0, 1, 0, 0, 8, NULL),
	(57, 8, 9, '흑심품었넹', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704119479772_%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7%202024-01-01%20233059.png', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704119479772_thumb_%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7%202024-01-01%20233040.png', 6, 0, 4900, '흑심 가득 품은 흑임자 쿠키가 나타났다!', 0, 0, 0, 300, 8, NULL),
	(58, 8, 9, '황치즈쌀쿠키', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704119585510_%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7%202024-01-01%20233242.png', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704119585510_thumb_%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7%202024-01-01%20233242.png', 5, 0, 4900, '황치즈를 듬뿍 넣어 단짠단짠한 맛이 매력적이며 쌀가루로 만들어 겉은 바삭하고 꾸덕쳑쳑한 식감!', 1, 0, 0, 0, 8, NULL),
	(59, 8, 9, '레몬얼그레이', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704119699242_%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7%202024-01-01%20233346.png', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704119699242_thumb_%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7%202024-01-01%20233321.png', 9, 0, 4900, '얼그레이향이 가득한 쿠키베이스에 상큼한 레몬아이싱까지! 중간중간 화이트 초콜릿도 있어요~', 0, 0, 0, 400, 8, NULL),
	(60, 8, 9, '로투스쌀스모어', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704119787018_%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7%202024-01-01%20233608.png', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704119787018_thumb_%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7%202024-01-01%20233608.png', 4, 0, 4900, '마시멜로우가 들어간 쫀득한 로투스쌀스모어 쿠키!', 0, 0, 0, 200, 8, NULL),
	(61, 8, 9, '약과쌀쿠키', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704119905421_%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7%202024-01-01%20233755.png', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704119905421_thumb_%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7%202024-01-01%20233739.png', 14, 0, 4900, '매장에서 출시하자마자 가장 잘나가는 메뉴 등극!! 쿠키 속 바닐라 크림치즈,,, oh my god', 1, 1, 0, 0, 8, NULL),
	(62, 8, 9, '통밀스콘', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704120229190_%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7%202024-01-01%20234327.png', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704120229190_thumb_%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7%202024-01-01%20234327.png', 4, 0, 3500, '통밀 본연의 맛이 매력적인 베이직한 스콘, 매력있는 맛!', 0, 0, 0, 200, 8, NULL),
	(63, 8, 9, '초코스콘', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704120309460_%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7%202024-01-01%20234452.png', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704120309460_thumb_%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7%202024-01-01%20234452.png', 8, 0, 3500, '달지 않은 초코맛 스콘! 낮은 당도의 초코스콘을 만들었습니다!', 0, 0, 0, 300, 8, NULL),
	(64, 8, 9, '단호박스콘', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704120402145_%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7%202024-01-01%20234625.png', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704120402145_thumb_%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7%202024-01-01%20234625.png', 9, 0, 3500, '단호박 자체가 당도를 가지고 있는 재로인 만큼 다른 스콘보다 비정제 원당을 줄여 은은한 단맛이 나요!', 0, 0, 0, 0, 8, NULL),
	(65, 8, 9, '플레인 꿀넹시에', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704120486586_%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7%202024-01-01%20234741.png', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704120486586_thumb_%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7%202024-01-01%20234741.png', 8, 0, 2500, '쌀가루와 아몬드가루로 만들어진 글루텐프리 제품!', 0, 0, 0, 0, 10, NULL),
	(66, 9, 4, '쪽파 크림치즈 소금빵', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704121970659_thumb_%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7%202024-01-02%20000908.png', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704121970659_thumb_%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7%202024-01-02%20000908.png', 6, 0, 7500, ' 최고급 필라델피아 크림치즈 미국산을 사용한 쫀쫀하고 맛있는 "추천빵"', 1, 0, 0, 0, 10, 0),
	(67, 9, 4, '아몬드 크루아상', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704122137624_thumb_%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7%202024-01-02%20001419.png', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704122137624_thumb_%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7%202024-01-02%20001419.png', 5, 0, 4500, '고소한 아몬드와 크루아상의 미친 조합!!', 0, 0, 0, 300, 10, 0),
	(68, 9, 4, '뺑오쇼콜라', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704122272791_%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7%202024-01-02%20001619.png', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704122272791_thumb_%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7%202024-01-02%20001619.png', 7, 0, 5000, '퍼프 페이스트리와 비슷한 납작한 네모 모양의 효모 반죽, 그리고 반죽 중간에 한두 조각의 초콜릿을 넣어 만든 프랑스의 페이스트리', 0, 0, 0, 500, 10, NULL),
	(69, 9, 4, '소금빵', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704122946048_thumb_%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7%202024-01-02%20002754.png', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704122946048_thumb_%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7%202024-01-02%20002754.png', 11, 0, 3800, '고소하고 짭짤한 우리집 시그니처 소금빵!', 0, 0, 0, 0, 14, 0),
	(70, 9, 4, '리얼 초코 소라빵', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704125261991_%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7%202024-01-02%20010316.png', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704125261991_thumb_%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7%202024-01-02%20010316.png', 6, 0, 4000, '부드러운 소라 모양 빵에 진한 초코 크림이 듬뿍 들어있는 간식빵', 0, 0, 0, 200, 11, NULL),
	(71, 9, 4, '트윈에그브레드', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704125452073_%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7%202024-01-02%20010926.png', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704125452073_thumb_%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7%202024-01-02%20010926.png', 7, 0, 3900, '삶은 계란이 빵 속에 통째로 쏙~ 맛있는 쌍둥이 모양의 계란빵', 0, 0, 0, 400, 11, NULL),
	(72, 9, 2, '마구마구 밤식빵', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704125725602_%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7%202024-01-02%20011323.png', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704125725602_thumb_%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7%202024-01-02%20011323.png', 7, 0, 6000, '밤 다이스를 듬뿍 넣고, 밤크림을 더해 풍미 UP! 더욱 커지고 촉촉하게 재탄생한 밤식빵', 0, 1, 0, 0, 10, NULL),
	(73, 9, 2, 'TLJ 옥수수식빵', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704125825901_%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7%202024-01-02%20011546.png', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704125825901_thumb_%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7%202024-01-02%20011546.png', 5, 0, 5200, '한층 더 촉촉해지고 옥수수 맛이 풍부한 빵 속에 고소한 옥수수 알갱이가 톡톡 씹히는 식빵', 0, 0, 0, 0, 11, NULL),
	(74, 9, 2, '폭신폭신 모닝롤', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704125953669_%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7%202024-01-02%20011744.png', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704125953669_thumb_%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7%202024-01-02%20011744.png', 9, 0, 4700, '보들보들한 빵 결 속 풍부한 버터 향 가득! 담백하고 부드러운 모닝롤', 0, 0, 0, 200, 10, NULL),
	(75, 9, 6, '소보로만난 앙넛', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704126155459_%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7%202024-01-02%20012202.png', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704126155459_thumb_%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7%202024-01-02%20012202.png', 3, 0, 4100, '고소한 소보로를 올려 겉은 바삭하고, 속은 포슬포슬한 도넛 속 달콤한 백앙금이 가득 들어있는 제품', 1, 0, 0, 400, 11, NULL),
	(76, 9, 6, '초코마카롱도넛', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704126259606_%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7%202024-01-02%20012321.png', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704126259606_thumb_%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7%202024-01-02%20012321.png', 5, 0, 3200, '초콜릿과 초코마카롱 후레이크를 듬뿍 얹은 달콤한 도넛', 0, 0, 0, 0, 12, NULL),
	(77, 9, 3, '데일리 블루베리 베이글', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704126390334_%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7%202024-01-02%20012525.png', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704126390334_thumb_%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7%202024-01-02%20012525.png', 0, 0, 2800, '폭신하고 쫄깃한 기지에 새콤달콤한 블루베리가 콕콕 박혀있는 블루베리 베이글', 0, 0, 0, 200, 10, NULL),
	(78, 9, 1, '아이스 아메리카노', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704126844979_thumb_%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7%202024-01-02%20013238.png', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704126844979_thumb_%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7%202024-01-02%20013238.png', 20, 0, 5000, '머리가 띵~ 해지게 차가운 마크스로프트만의 고소한 아메리카노입니다.', 0, 1, 0, 0, 10, 0),
	(79, 11, 9, '보늬밤', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704106718084_%EB%B3%B4%EB%8A%AC%EB%B0%A4.jpeg', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704106718084_thumb_%EB%B3%B4%EB%8A%AC%EB%B0%A4.jpeg', 10, 0, 9000, '달달한 밤조림과 풍미 가득한 밤크림이 어우러진 담백한 디저트', 0, 1, 0, 0, 13, NULL),
	(80, 11, 9, '옥수수', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704106816156_%EC%98%A5%EC%88%98%EC%88%98.jpeg', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704106816156_thumb_%EC%98%A5%EC%88%98%EC%88%98.jpeg', 8, 0, 85000, '노릇하게 구워진 옥수수와 크리스피한 오트밀이 어우러진 한끼 식사같은 디저트', 0, 1, 0, 0, 13, NULL),
	(81, 11, 9, '피스타치오살구', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704106933754_%ED%94%BC%EC%8A%A4%ED%83%80%EC%B9%98%EC%98%A4%EC%82%B4%EA%B5%AC.jpeg', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704106933754_thumb_%ED%94%BC%EC%8A%A4%ED%83%80%EC%B9%98%EC%98%A4%EC%82%B4%EA%B5%AC.jpeg', 10, 0, 9000, '새콤한 살구와 피스타치오의 고소함으로 가득 찬 산뜻한 디저트', 0, 0, 0, 0, 13, NULL),
	(82, 11, 9, '딸기', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704106990395_%EB%94%B8%EA%B8%B0.jpeg', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704106990395_thumb_%EB%94%B8%EA%B8%B0.jpeg', 4, 0, 9000, '신선한 제철 딸기와 치즈크림이 만나 상큼하고 달콤한 풍미를 느낄 수 있는 디저트', 0, 0, 0, 0, 15, NULL),
	(83, 11, 9, '홍시', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704107054129_%ED%99%8D%EC%8B%9C.jpeg', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704107054129_thumb_%ED%99%8D%EC%8B%9C.jpeg', 5, 0, 8500, '셔벗처럼 사각한 홍시, 곶감과 호두의 쫀득하고 고소한 식감을 즐길 수 있는 디저트', 0, 0, 0, 0, 15, NULL),
	(84, 11, 9, '바질토마토', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704107114836_%EB%B0%94%EC%A7%88%ED%86%A0%EB%A7%88%ED%86%A0.jpeg', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704107114836_thumb_%EB%B0%94%EC%A7%88%ED%86%A0%EB%A7%88%ED%86%A0.jpeg', 12, 0, 8500, '생 바질로 만든 신선한 크림과 토마토의 상큼함이 가득 찬 디저트', 0, 0, 0, 0, 13, NULL),
	(85, 11, 9, '초코바나나', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704107170206_%EC%B4%88%EC%BD%94%EB%B0%94%EB%82%98%EB%82%98.jpeg', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704107170206_thumb_%EC%B4%88%EC%BD%94%EB%B0%94%EB%82%98%EB%82%98.jpeg', 4, 0, 8500, '진한 가나슈와 바나나의 짙은 풍미와 맛으로 가득 찬 묵직한 식감의 디저트', 0, 0, 0, 0, 15, NULL),
	(86, 10, 7, '초코딸기케이크 1호', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704113230888_%EB%94%B8%EA%B8%B04.png', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704113230888_thumb_%EB%94%B8%EA%B8%B04.png', 1, 0, 28000, '촉촉한 초코 제누와즈 시트에 프랑스와 벨기에 초콜렛이 블렌딩 된 크림이 들어가 깊은 초콜렛의 맛과 촉촉한 식감을 맛볼 수 있는 케이크입니다. ', 0, 0, 0, 0, 12, 0),
	(87, 10, 7, '샤인머스캣요거트케이크 1호', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704113548864_%EC%83%A4%EC%9D%B83.png', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704113548864_thumb_%EC%83%A4%EC%9D%B83.png', 1, 0, 32000, '촉촉한 시트에 요거트 크림과 샤인머스캣이 층층이 샌딩되어 있어서\r\n부드럽고 상큼한 맛의 케이크입니다.', 0, 0, 0, 0, 12, 0),
	(88, 10, 7, '얼그레이자몽케이크 1호', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704113473385_%EB%94%B8%EA%B8%B06.png', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704113473385_thumb_%EB%94%B8%EA%B8%B06.png', 0, 0, 30000, '얼그레이 시트에 얼그레이 가나슈 몽떼 크림, 생 자몽, 샹티 크림의 구성으로 은은한 얼그레이의 향과 상큼한 자몽이 잘 어우러지는 마가렛의 베스트셀러 케이크입니다.', 0, 0, 0, 0, 12, 0),
	(89, 10, 7, '딸기프레지에케이크 1호', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704113328897_%EB%94%B8%EA%B8%B05.png', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704113328897_thumb_%EB%94%B8%EA%B8%B05.png', 1, 0, 28000, '촉촉한 버터시트, 직접 만든 피스타치오 프랄린이 들어가는 무슬린 크림, 딸기잼, 샹티크림, 생딸기가 가득 들어가는 마가렛의 시그니처 케이크입니다.', 0, 0, 0, 0, 12, 0),
	(90, 10, 7, '초코우유케이크 1호', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704113085732_%EB%94%B8%EA%B8%B03.png', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704113085732_thumb_%EB%94%B8%EA%B8%B03.png', 1, 0, 30000, '촉촉한 초코 제누와즈 시트, 발로나 초콜렛 크루스티엉, 발로나 초콜렛크림, 초콜렛 글레이즈 등 5단 레이어로 초코 맛을 풍부하게 느낄 수 있는 마가렛의 대표 케이크입니다.', 0, 0, 0, 0, 12, NULL),
	(91, 10, 4, '카스테라 큐브', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704115645425_%EC%B9%B4%EC%8A%A4%ED%85%8C%EB%9D%BC%ED%81%90%EB%B8%8C.jpg', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704115645425_thumb_%EC%B9%B4%EC%8A%A4%ED%85%8C%EB%9D%BC%ED%81%90%EB%B8%8C.jpg', 10, 0, 6300, '빠삭한 큐브랑 보들보들 카스테라가루의 만남! 벌써부터 맛있는거 느껴지시나요?1', 0, 0, 0, 0, 15, NULL),
	(92, 10, 9, '황치즈파운드', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704115960586_%ED%99%A9%EC%B9%98%EC%A6%88%ED%8C%8C%EC%9A%B4%EB%93%9C.jpg', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704115960586_thumb_%ED%99%A9%EC%B9%98%EC%A6%88%ED%8C%8C%EC%9A%B4%EB%93%9C.jpg', 7, 0, 5500, ' 감싸고 있는 골드 컬러의 부드러운 치즈는 달콤함과 고소함의 균형을 이루어 완벽한 맛을 만듭니다. 그 첫 입맛에서부터 느껴지는 달콤한 감미로움은 마치 디저트의 새로운 지평을 열어주는 듯한 느낌!', 0, 0, 0, 0, 11, NULL),
	(93, 10, 7, '수플레치즈케이크', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704116442954_%EC%88%98%ED%94%8C%EB%A0%88%EC%B9%98%EC%A6%88%EC%BC%80%EC%9E%8C%21%21.jpg', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704116442954_thumb_%EC%88%98%ED%94%8C%EB%A0%88%EC%B9%98%EC%A6%88%EC%BC%80%EC%9E%8C%21%21.jpg', 3, 0, 7000, '자극적이지 않고 부드러운 마가렛의 치즈케이크에요! 반죽에 머랭이 들어가서 아주 부드럽고 위에 올라간 마스카포네크림과 같이 드시면 더 부드럽고 맛있어요!', 0, 0, 0, 0, 15, NULL),
	(94, 10, 7, '말차컵케이크', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704116708926_%EB%A7%90%EC%B0%A8%EC%BB%B5%EC%BC%80%EC%9D%B4%ED%81%AC.jpg', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704116708926_thumb_%EB%A7%90%EC%B0%A8%EC%BB%B5%EC%BC%80%EC%9D%B4%ED%81%AC.jpg', 12, 0, 6300, '말차컵케이크 시트에 말차버터크림이 올라가서 아주 말차말차한 맛이에요! \r\n적당히 달콤쌉싸름한 당도로 누구나 기분좋게 드실 수 있는 맛이에요!\r\n마가렛 모양 슈가장식까지 너무 귀엽지 않나요', 0, 0, 0, 0, 16, NULL),
	(95, 10, 4, '아몬드크로와상', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704116927788_%ED%81%AC%EB%A1%9C%EC%99%80%EC%83%81.jpg', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704116927788_thumb_%ED%81%AC%EB%A1%9C%EC%99%80%EC%83%81.jpg', 3, 0, 7000, '바삭 달콤 꼬소한 아몬드크로와상\r\n한 입 베어물면 바삭한 식감에 달달한 아몬드크림,구운 아몬드의 고소한 맛을 느끼실 수 있어요!', 0, 0, 0, 0, 13, NULL),
	(96, 10, 4, '말차큐브', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704117422549_%EB%A7%90%EC%B0%A8%ED%81%90%EB%B8%8C.jpg', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704117422549_thumb_%EB%A7%90%EC%B0%A8%ED%81%90%EB%B8%8C2.jpg', 9, 0, 6500, '말차큐브빵은 일상에 조금의 따뜻함을 선사하는 특별한 빵입니다. 부드러운 큐브 형태의 빵 속에는 진하고 고소한 말차 크림이 즐비해, 차가운 날씨에도 마치 따뜻한 차 한 잔을 마시는 듯한 풍미를 느낄 수 있어요', 0, 0, 0, 0, 16, NULL),
	(97, 10, 4, '무화과크림치즈스콘', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704117668636_%EB%AC%B4%ED%99%94%EA%B3%BC%ED%81%AC%EB%A6%BC%EC%B9%98%EC%A6%88%EC%8A%A4%EC%BD%98.jpg', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704117668636_thumb_%EB%AC%B4%ED%99%94%EA%B3%BC%ED%81%AC%EB%A6%BC%EC%B9%98%EC%A6%88%EC%8A%A4%EC%BD%98.jpg', 2, 0, 6000, '와인에 졸인 무화과와 로스팅한 피칸이 듬뿍 들어간 무화과스콘에 무화과크림치즈면 맛없없 조합!', 0, 0, 0, 0, 18, NULL),
	(98, 10, 4, '체리타르트', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704117899835_%EC%B2%B4%EB%A6%AC%ED%83%80%EB%A5%B4%ED%8A%B8.jpg', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704117899835_thumb_%EC%B2%B4%EB%A6%AC%ED%83%80%EB%A5%B4%ED%8A%B8.jpg', 2, 0, 6700, '타르트지,치즈아파레유,체리콩포트,체리크림,생체리 조합으로 되어있어서 계속 먹어도 물리지 않는 맛이에요!', 0, 0, 0, 0, 15, NULL),
	(99, 10, 7, '망고 케이크', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704118067805_%EB%A7%9D%EA%B3%A0%20%EC%BC%80%EC%9D%B4%ED%81%AC.jpg', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704118067805_thumb_%EB%A7%9D%EA%B3%A0%20%EC%BC%80%EC%9D%B4%ED%81%AC.jpg', 2, 0, 6400, '촉촉한 시트에 잘 숙성된 망고를 듬뿍 넣고 상큼한 맛을 더해주는 패션 글레이즈로 마무리한 케이크', 0, 0, 0, 0, 8, NULL),
	(100, 10, 6, '브리오슈 도넛', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704118279341_%EB%8F%84%EB%84%9B.jpg', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704118279341_thumb_%EB%8F%84%EB%84%9B.jpg', 4, 0, 6500, '부드럽고 쫀득한 브리오슈 반죽에 다양한 크림을 가득가득 채워넣어서 한 입 베어물면 ㅎㅎ', 0, 0, 0, 0, 17, NULL),
	(101, 6, 4, '흑임자 앙버터', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704133706422_%ED%9D%91%EC%9E%84%EC%9E%90%EC%95%99%EB%B2%84%ED%84%B0.jpeg', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704133706422_thumb_%ED%9D%91%EC%9E%84%EC%9E%90%EC%95%99%EB%B2%84%ED%84%B0.jpeg', 7, 0, 5800, '고소한 흑임자 앙금과 풍미가득 프랑스산 발효버터가 샌드된 할미입맛 저격 빵', 1, 1, 0, 0, 9, NULL),
	(102, 6, 4, '마늘소금빵', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704133812805_%EB%A7%88%EB%8A%98%EC%86%8C%EA%B8%88%EB%B9%B5.jpeg', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704133812805_thumb_%EB%A7%88%EB%8A%98%EC%86%8C%EA%B8%88%EB%B9%B5.jpeg', 6, 0, 4000, '고소한 소금빵에 직접 만든 마늘소스와 구운 마늘칩이 듬뿍 얹어진 빵', 0, 0, 0, 0, 8, NULL),
	(103, 6, 4, '대보로빵', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704133930713_%EB%8C%80%EB%B3%B4%EB%A1%9C%EB%B9%B5.jpg', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704133930713_thumb_%EB%8C%80%EB%B3%B4%EB%A1%9C%EB%B9%B5.jpg', 5, 0, 4600, '버터베이커리 스테디셀러 소보로빵이 더욱 큰 사이즈로 리뉴얼!', 1, 1, 0, 0, 10, NULL),
	(104, 6, 4, '땅땅스콘', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704134000213_%EB%95%85%EB%95%85%EC%8A%A4%EC%BD%98.jpg', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704134000213_thumb_%EB%95%85%EB%95%85%EC%8A%A4%EC%BD%98.jpg', 4, 0, 3800, '땅콩버터와 땅콩크럼이 얹어진 고소한 스콘 위에 달달새콤 라즈베리잼', 1, 0, 0, 0, 11, NULL),
	(105, 6, 5, '페페로니 한판', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704134222880_%ED%8E%98%ED%8E%98%EB%A1%9C%EB%8B%88%20%ED%95%9C%ED%8C%90.jpg', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704134222880_thumb_%ED%8E%98%ED%8E%98%EB%A1%9C%EB%8B%88%20%ED%95%9C%ED%8C%90.jpg', 3, 0, 5300, '달달한 페스츄리 속 짭짤한 페페로니와 치즈, 양파가 듬뿍 든 단짠 조합의 ', 0, 0, 0, 0, 9, NULL),
	(106, 7, 1, '말샷추', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704135634732_%EB%A7%90%EC%83%B7%EC%B6%94.png', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704135634732_thumb_%EB%A7%90%EC%83%B7%EC%B6%94.png', 100, 0, 5300, '말차라떼 샷 추가', 1, 1, 0, 0, 0, NULL),
	(107, 7, 1, '토샷추', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704135658766_%ED%86%A0%EC%83%B7%EC%B6%94.png', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704135658766_thumb_%ED%86%A0%EC%83%B7%EC%B6%94.png', 100, 0, 5300, '토피넛라떼 샷 추가', 1, 0, 0, 0, 0, NULL),
	(108, 7, 4, '대파크림치즈 소금빵', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704135783096_thumb_%EB%8C%80%ED%8C%8C%ED%81%AC%EB%A6%BC%20%EC%B9%98%EC%A6%88%20%EC%86%8C%EA%B8%88%EB%B9%B5.png', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704135783096_thumb_%EB%8C%80%ED%8C%8C%ED%81%AC%EB%A6%BC%20%EC%B9%98%EC%A6%88%20%EC%86%8C%EA%B8%88%EB%B9%B5.png', 1, 0, 4500, '달콤한 크림치즈와 알싸한 대파가 조화로운 소금빵', 1, 1, 0, 0, 9, 0),
	(109, 7, 7, '레몬 생크림 케이크', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704135808691_%EB%A0%88%EB%AA%AC%20%EC%83%9D%ED%81%AC%EB%A6%BC%20%EC%BC%80%EC%9D%B4%ED%81%AC.png', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704135808691_thumb_%EB%A0%88%EB%AA%AC%20%EC%83%9D%ED%81%AC%EB%A6%BC%20%EC%BC%80%EC%9D%B4%ED%81%AC.png', 2, 0, 6600, '레몬이 들어간 상큼달달 케이크', 0, 0, 0, 0, 8, NULL),
	(110, 7, 4, '마늘 소금빵', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704135850201_%EB%A7%88%EB%8A%98%20%EC%86%8C%EA%B8%88%EB%B9%B5.png', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704135850201_thumb_%EB%A7%88%EB%8A%98%20%EC%86%8C%EA%B8%88%EB%B9%B5.png', 0, 0, 4500, '마늘과 버터가 가득 들어간 달달짭짤 소금빵', 0, 0, 0, 0, 9, NULL),
	(111, 7, 7, '레몬 케이크', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704135879748_%EB%A0%88%EB%AA%AC%20%EC%BC%80%EC%9D%B4%ED%81%AC.png', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704135879748_thumb_%EB%A0%88%EB%AA%AC%20%EC%BC%80%EC%9D%B4%ED%81%AC.png', 2, 0, 3500, '레몬 글레이즈가 올라간 레몬모양의 파운드케이크', 0, 0, 0, 0, 8, NULL),
	(112, 7, 4, '소금빵', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704135916235_%EB%A9%94%EB%89%B4%EC%86%8C%EA%B8%88%EB%B9%A0.png', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704135916235_thumb_%EB%A9%94%EB%89%B4%EC%86%8C%EA%B8%88%EB%B9%A0.png', 3, 0, 3000, '오리지널 소금빵', 0, 1, 0, 0, 9, NULL),
	(113, 7, 7, '바스크 치즈케이크', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704135948090_%EB%B0%94%EC%8A%A4%ED%81%AC%20%EC%B9%98%EC%A6%88%20%EC%BC%80%EC%9D%B4%ED%81%AC.png', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704135948090_thumb_%EB%B0%94%EC%8A%A4%ED%81%AC%20%EC%B9%98%EC%A6%88%20%EC%BC%80%EC%9D%B4%ED%81%AC.png', 6, 0, 6600, '크림치즈가 듬뿍 들어간 수제케이크', 0, 0, 0, 0, 8, NULL),
	(114, 7, 4, '앙버터 소금빵', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704135975171_%EC%95%99%EB%B2%84%ED%84%B0%20%EC%86%8C%EA%B8%88%EB%B9%B5.png', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704135975171_thumb_%EC%95%99%EB%B2%84%ED%84%B0%20%EC%86%8C%EA%B8%88%EB%B9%B5.png', 7, 0, 4500, '팥, 호두, 버터가 어우러진 소금빵', 1, 0, 9, 0, 8, NULL),
	(115, 7, 7, '얼그레이 파운드케이크', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704136008849_%EC%96%BC%EA%B7%B8%EB%A0%88%EC%9D%B4%20%ED%8C%8C%EC%9A%B4%EB%93%9C%20%EC%BC%80%EC%9D%B4%ED%81%AC.png', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704136008849_thumb_%EC%96%BC%EA%B7%B8%EB%A0%88%EC%9D%B4%20%ED%8C%8C%EC%9A%B4%EB%93%9C%20%EC%BC%80%EC%9D%B4%ED%81%AC.png', 4, 0, 3700, '얼그레이의 깊은 맛이 느껴지는 파운드 케이크', 0, 0, 0, 0, 8, NULL),
	(116, 7, 7, '초코 갸또', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704136052211_%EC%B4%88%EC%BD%94%20%EA%B0%B8%EB%98%90.png', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704136052211_thumb_%EC%B4%88%EC%BD%94%20%EA%B0%B8%EB%98%90.png', 6, 0, 6600, '찐득꾸덕 초코케이크', 0, 0, 0, 0, 8, NULL),
	(117, 7, 7, '크림치즈 당근 컵케이크', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704136087553_%ED%81%AC%EB%A6%BC%EC%B9%98%EC%A6%88%20%EB%8B%B9%EA%B7%BC%20%EC%BB%B5%EC%BC%80%EC%9D%B4%ED%81%AC.png', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704136087553_thumb_%ED%81%AC%EB%A6%BC%EC%B9%98%EC%A6%88%20%EB%8B%B9%EA%B7%BC%20%EC%BB%B5%EC%BC%80%EC%9D%B4%ED%81%AC.png', 7, 0, 4300, '향기로운 시나몬과 당근 크림치즈의 만남', 0, 0, 0, 0, 8, NULL),
	(118, 7, 4, '토마토 바질 소금빵', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704136118005_%ED%86%A0%EB%A7%88%ED%86%A0%20%EB%B0%94%EC%A7%88%20%EC%86%8C%EA%B8%88%EB%B9%B5.png', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704136118005_thumb_%ED%86%A0%EB%A7%88%ED%86%A0%20%EB%B0%94%EC%A7%88%20%EC%86%8C%EA%B8%88%EB%B9%B5.png', 8, 0, 4500, '풍미 대박 토마토 바질 소금빵', 1, 0, 0, 0, 9, NULL),
	(119, 7, 7, '황치즈 파운드케이크', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704136140088_%ED%99%A9%EC%B9%98%EC%A6%88%20%ED%8C%8C%EC%9A%B4%EB%93%9C%20%EC%BC%80%EC%9D%B4%ED%81%AC.png', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704136140088_thumb_%ED%99%A9%EC%B9%98%EC%A6%88%20%ED%8C%8C%EC%9A%B4%EB%93%9C%20%EC%BC%80%EC%9D%B4%ED%81%AC.png', 7, 0, 4300, '단짠 꾸덕 황치즈 파운드 케이크', 0, 0, 0, 0, 8, NULL),
	(120, 7, 9, '더블 초코 헤이즐넛 쿠키', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704136506952_%EB%8D%94%EB%B8%94%20%EC%B4%88%EC%BD%94%20%ED%97%A4%EC%9D%B4%EC%A6%90%EB%84%9B%20%EC%BF%A0%ED%82%A4.png', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704136506952_thumb_%EB%8D%94%EB%B8%94%20%EC%B4%88%EC%BD%94%20%ED%97%A4%EC%9D%B4%EC%A6%90%EB%84%9B%20%EC%BF%A0%ED%82%A4.png', 15, 0, 3800, '발로나 카카오 베이스에 헤이즐넛과 초코를 듬뿍!', 0, 0, 0, 0, 11, NULL),
	(121, 7, 9, '레드벨벳 크림치즈 쿠키', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704136531596_%EB%A0%88%EB%93%9C%EB%B2%A8%EB%B2%B3%20%ED%81%AC%EB%A6%BC%EC%B9%98%EC%A6%88%20%EC%BF%A0%ED%82%A4.png', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704136531596_thumb_%EB%A0%88%EB%93%9C%EB%B2%A8%EB%B2%B3%20%ED%81%AC%EB%A6%BC%EC%B9%98%EC%A6%88%20%EC%BF%A0%ED%82%A4.png', 12, 0, 4000, '레드벨벳도 좋아해요~', 0, 0, 0, 0, 11, NULL),
	(122, 7, 9, '말차 화이트 초코 쿠키', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704136564488_%EB%A7%90%EC%B0%A8%20%ED%99%94%EC%9D%B4%ED%8A%B8%20%EC%B4%88%EC%BD%94%20%EC%BF%A0%ED%82%A4.png', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704136564488_thumb_%EB%A7%90%EC%B0%A8%20%ED%99%94%EC%9D%B4%ED%8A%B8%20%EC%B4%88%EC%BD%94%20%EC%BF%A0%ED%82%A4.png', 0, 0, 3800, '제주 유기농 말차에 화이트 초콜릿 콕콕!', 0, 0, 0, 0, 11, NULL),
	(123, 7, 9, '바나나 푸딩', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704136590461_%EB%B0%94%EB%82%98%EB%82%98%ED%91%B8%EB%94%A9.png', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704136590461_thumb_%EB%B0%94%EB%82%98%EB%82%98%ED%91%B8%EB%94%A9.png', 5, 0, 6800, '향긋한 바나나와 커스터드 크림, 쿠키', 0, 0, 0, 0, 8, NULL),
	(124, 7, 9, '버터바', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704136615382_%EB%B2%84%ED%84%B0%EB%B0%94.png', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704136615382_thumb_%EB%B2%84%ED%84%B0%EB%B0%94.png', 9, 0, 4500, '스카치 캔디의 풍미가 느껴지는 쫀득 바삭 버터바', 0, 0, 0, 0, 8, NULL),
	(125, 7, 9, '솔티 카라멜 스콘', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704136646342_thumb_%EC%86%94%ED%8B%B0%20%EC%B9%B4%EB%9D%BC%EB%A9%9C%20%EC%8A%A4%EC%BD%98.png', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704136646342_thumb_%EC%86%94%ED%8B%B0%20%EC%B9%B4%EB%9D%BC%EB%A9%9C%20%EC%8A%A4%EC%BD%98.png', 6, 0, 4200, '카라멜과 소금의 단짠단짠 조합', 0, 0, 0, 0, 8, 0),
	(126, 7, 9, '솔티 카라멜 휘낭시에', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704136677156_%EC%86%94%ED%8B%B0%20%EC%B9%B4%EB%9D%BC%EB%A9%9C%20%ED%9C%98%EB%82%AD%EC%8B%9C%EC%97%90.png', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704136677156_thumb_%EC%86%94%ED%8B%B0%20%EC%B9%B4%EB%9D%BC%EB%A9%9C%20%ED%9C%98%EB%82%AD%EC%8B%9C%EC%97%90.png', 14, 0, 3000, '카라멜과 소금의 단짠단짠 조합', 0, 0, 0, 0, 8, NULL),
	(127, 7, 5, '에그 타르트', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704136714321_%EC%97%90%EA%B7%B8%20%ED%83%80%EB%A5%B4%ED%8A%B8.png', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704136714321_thumb_%EC%97%90%EA%B7%B8%20%ED%83%80%EB%A5%B4%ED%8A%B8.png', 10, 0, 3700, '당일 구워낸 바닐라빈이 듬뿍 들어간 겉바속촉 에그타르트', 0, 0, 0, 0, 8, NULL),
	(128, 7, 9, '오레오 브라우니', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704136749355_%EC%98%A4%EB%A0%88%EC%98%A4%20%EB%B8%8C%EB%9D%BC%EC%9A%B0%EB%8B%88.png', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704136749355_thumb_%EC%98%A4%EB%A0%88%EC%98%A4%20%EB%B8%8C%EB%9D%BC%EC%9A%B0%EB%8B%88.png', 0, 0, 4000, '오레오가 듬뿍 올라간 촉촉 브라우니', 0, 0, 0, 0, 8, NULL),
	(129, 7, 9, '오레오 크림치즈 쿠키', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704136777936_%EC%98%A4%EB%A0%88%EC%98%A4%20%ED%81%AC%EB%A6%BC%EC%B9%98%EC%A6%88%20%EC%BF%A0%ED%82%A4.png', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704136777936_thumb_%EC%98%A4%EB%A0%88%EC%98%A4%20%ED%81%AC%EB%A6%BC%EC%B9%98%EC%A6%88%20%EC%BF%A0%ED%82%A4.png', 7, 0, 4000, '오레오와 찰떡궁합 크림치즈', 0, 0, 0, 0, 11, NULL),
	(130, 7, 9, '초코칩 스콘', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704136808970_%EC%B4%88%EC%BD%94%EC%B9%A9%20%EC%8A%A4%EC%BD%98.png', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704136808970_thumb_%EC%B4%88%EC%BD%94%EC%B9%A9%20%EC%8A%A4%EC%BD%98.png', 3, 0, 4000, '초콜릿 칩이 쏙쏙 박힌 진한 초코 스콘', 0, 0, 0, 0, 8, NULL),
	(131, 7, 9, '치즈 스콘', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704136875020_%EC%B9%98%EC%A6%88%20%EC%8A%A4%EC%BD%98.png', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704136875020_thumb_%EC%B9%98%EC%A6%88%20%EC%8A%A4%EC%BD%98.png', 5, 0, 3800, '풍미 대박 치즈 스콘', 0, 0, 0, 0, 8, NULL),
	(132, 7, 9, '플레인 스콘', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704136907453_%ED%94%8C%EB%A0%88%EC%9D%B8%20%EC%8A%A4%EC%BD%98.png', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704136907453_thumb_%ED%94%8C%EB%A0%88%EC%9D%B8%20%EC%8A%A4%EC%BD%98.png', 8, 0, 3500, '퍽퍽하지 않고 담백하고 부드러운 베이직 스콘', 0, 0, 0, 0, 8, NULL),
	(133, 7, 9, '호두 초코 쿠키', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704136937640_%ED%98%B8%EB%91%90%20%EC%B4%88%EC%BD%94%20%EC%BF%A0%ED%82%A4.png', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704136937640_thumb_%ED%98%B8%EB%91%90%20%EC%B4%88%EC%BD%94%20%EC%BF%A0%ED%82%A4.png', 3, 0, 3800, '발로나 카카오 베이스에 고소한 호두 콕콕!', 0, 0, 0, 0, 11, NULL),
	(134, 7, 9, '황치즈 크림치즈 쿠키', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704136962901_%ED%99%A9%EC%B9%98%EC%A6%88%20%ED%81%AC%EB%A6%BC%EC%B9%98%EC%A6%88%20%EC%BF%A0%ED%82%A4.png', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704136962901_thumb_%ED%99%A9%EC%B9%98%EC%A6%88%20%ED%81%AC%EB%A6%BC%EC%B9%98%EC%A6%88%20%EC%BF%A0%ED%82%A4.png', 7, 0, 4200, '체다치즈와 황치즈크림치즈의 짭짤달달 쿠키', 0, 0, 0, 0, 11, NULL),
	(135, 7, 9, '휘낭시에', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704136991110_%ED%9C%98%EB%82%AD%EC%8B%9C%EC%97%90.png', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704136991110_thumb_%ED%9C%98%EB%82%AD%EC%8B%9C%EC%97%90.png', 14, 0, 2800, '오리지널 휘낭시에', 0, 0, 0, 0, 8, NULL),
	(136, 12, 7, '초코 푸딩 컵케이크', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704177604235_thumb_%EC%B4%88%EC%BD%94%20%ED%91%B8%EB%94%A9%20%EC%BB%B5%EC%BC%80%EC%9D%B4%ED%81%AC.png', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704177604235_thumb_%EC%B4%88%EC%BD%94%20%ED%91%B8%EB%94%A9%20%EC%BB%B5%EC%BC%80%EC%9D%B4%ED%81%AC.png', 22, 0, 6800, '귀여운 댕댕이 컵케이크 속 에 부드러운 푸딩이 들어 있어 더욱 귀엽고 매력있는 디저트', 1, 1, 0, 0, 8, 0),
	(137, 12, 7, '딸기 푸딩 컵케이크', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704177798250_thumb_%EB%94%B8%EA%B8%B0%20%ED%91%B8%EB%94%A9%20%EC%BB%B5%EC%BC%80%EC%9D%B4%ED%81%AC.png', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704177798250_thumb_%EB%94%B8%EA%B8%B0%20%ED%91%B8%EB%94%A9%20%EC%BB%B5%EC%BC%80%EC%9D%B4%ED%81%AC.png', 22, 0, 6800, '귀여운 댕댕이 컵케이크 속 에 부드러운 푸딩이 들어 있어 더욱 귀엽고 매력있는 디저트', 0, 0, 0, 0, 8, 0),
	(138, 12, 7, '밀크 푸딩 컵케이크', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704177852135_thumb_%EB%B0%80%ED%81%AC%20%ED%91%B8%EB%94%A9%20%EC%BB%B5%EC%BC%80%EC%9D%B4%ED%81%AC.png', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704177852135_thumb_%EB%B0%80%ED%81%AC%20%ED%91%B8%EB%94%A9%20%EC%BB%B5%EC%BC%80%EC%9D%B4%ED%81%AC.png', 22, 0, 6800, '귀여운 댕댕이 컵케이크 속 에 부드러운 푸딩이 들어 있어 더욱 귀엽고 매력있는 디저트🖤\r\n', 0, 0, 0, 0, 8, 0),
	(139, 12, 7, '초코 치즈케이크', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704177901768_thumb_%EC%B4%88%EC%BD%94%20%EC%B9%98%EC%A6%88%EC%BC%80%EC%9D%B4%ED%81%AC.jpg', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704177901768_thumb_%EC%B4%88%EC%BD%94%20%EC%B9%98%EC%A6%88%EC%BC%80%EC%9D%B4%ED%81%AC.jpg', 22, 0, 5800, '꾸덕한 치즈케이크 위에 달콤한 초코크림이 매력적인 초코 치즈 케이크\r\n', 0, 1, 0, 0, 8, 0),
	(140, 12, 7, '딸기 치즈케이크', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704177942615_thumb_%EB%94%B8%EA%B8%B0%20%EC%B9%98%EC%A6%88%EC%BC%80%EC%9D%B4%ED%81%AC.png', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704177942615_thumb_%EB%94%B8%EA%B8%B0%20%EC%B9%98%EC%A6%88%EC%BC%80%EC%9D%B4%ED%81%AC.png', 22, 0, 5800, '꾸덕한 치즈케이크 위에 달콤한 딸기크림이 매력적인 딸기 치즈 케이크\r\n', 0, 1, 0, 0, 8, 0),
	(141, 12, 9, '무화과 아몬드 스모어쿠키', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704177985647_thumb_%EB%AC%B4%ED%99%94%EA%B3%BC%20%EC%95%84%EB%AA%AC%EB%93%9C%20%EC%8A%A4%EB%AA%A8%EC%96%B4%EC%BF%A0%ED%82%A4.jpg', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704177985647_thumb_%EB%AC%B4%ED%99%94%EA%B3%BC%20%EC%95%84%EB%AA%AC%EB%93%9C%20%EC%8A%A4%EB%AA%A8%EC%96%B4%EC%BF%A0%ED%82%A4.jpg', 11, 0, 3600, '달콤한 무화과 가 가득 들어 있는 무화과 스모어 쿠키💛\r\n', 0, 1, 0, 0, 8, 0),
	(142, 12, 9, '스트로베리 뉴욕롤', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704178079178_thumb_%EC%8A%A4%ED%8A%B8%EB%A1%9C%EB%B2%A0%EB%A6%AC%20%EB%89%B4%EC%9A%95%EB%A1%A4.jpg', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704178079178_thumb_%EC%8A%A4%ED%8A%B8%EB%A1%9C%EB%B2%A0%EB%A6%AC%20%EB%89%B4%EC%9A%95%EB%A1%A4.jpg', 10, 0, 5300, '몽블랑 속 달콤한 딸기 크림이 가득 들어간 겉바속촉 매력의 뉴욕롤?\r\n', 0, 1, 0, 0, 8, 0),
	(143, 12, 1, 'BEST 폴로밀크티BOTTLE', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704178131428_thumb_BEST%20%ED%8F%B4%EB%A1%9C%EB%B0%80%ED%81%AC%ED%8B%B0BOTTLE.png', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704178131428_thumb_BEST%20%ED%8F%B4%EB%A1%9C%EB%B0%80%ED%81%AC%ED%8B%B0BOTTLE.png', 20, 0, 6500, '예쁘고 깜찍한 베어브릭보틀에 담긴 깔끔한 폴로 밀크티는 필로 베이커리의 베스트 음료입니다.\r\n', 0, 0, 0, 0, 8, 0),
	(144, 13, 2, '우유식빵', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704179921811_%EC%9A%B0%EC%9C%A0%EC%8B%9D%EB%B9%B5.jpg', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704179921811_thumb_%EC%9A%B0%EC%9C%A0%EC%8B%9D%EB%B9%B5.jpg', 22, 0, 4500, '우유식빵 포근하면서 친숙하지만 엘레강스하면서도 놀라운 식빵\r\n식빵의 한계를 넘어 예술의 경지에 다다르다', 0, 1, 0, 0, 8, NULL),
	(145, 13, 3, '소금빵', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704180027754_%EC%86%8C%EA%B8%88%EB%B9%B5.jpg', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704180027754_thumb_%EC%86%8C%EA%B8%88%EB%B9%B5.jpg', 4, 0, 2000, '소금빵\r\n소금은 짠 맛이다. 하지만 짠 맛이 느껴지기 전에 단 맛과 조화를 이뤄 짜지 않지만 자극적이고 달지 않지만 달달한 극상의 조화를 경험할 수 있다', 0, 0, 0, 0, 8, NULL),
	(146, 13, 3, '모카빵', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704180111458_%EB%AA%A8%EC%B9%B4%EB%B9%B5.jpg', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704180111458_thumb_%EB%AA%A8%EC%B9%B4%EB%B9%B5.jpg', 20, 0, 4800, '모카빵\r\n모카향은 코스요리의 에피타이저 느낌이랄까?\r\n모카향을 머금은 채 한 입 배어물면 스테이크의 육중한 맛이 느껴진다', 0, 0, 0, 0, 8, NULL),
	(147, 13, 3, '깨찰빵', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704180198407_%EA%B9%A8%EC%B0%B0%EB%B9%B5.jpg', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704180198407_thumb_%EA%B9%A8%EC%B0%B0%EB%B9%B5.jpg', 120, 0, 2200, '깨찰빵 아즈텍 신화에서 숭배받는 뱀신이자 용신. 마야, 톨텍 문명에서도 숭배받은 캐찰코아틀을 연상하게 할 숭배의 맛', 0, 0, 0, 0, 8, NULL),
	(148, 13, 4, '호두 단팥빵', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704180259796_%ED%98%B8%EB%91%90%20%EB%8B%A8%ED%8C%A5%EB%B9%B5.jpg', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704180259796_thumb_%ED%98%B8%EB%91%90%20%EB%8B%A8%ED%8C%A5%EB%B9%B5.jpg', 20, 0, 1800, '호두 단팥빵\r\n아 짜장면과 어울릴지도?', 0, 0, 0, 0, 8, NULL),
	(149, 13, 2, '라이스 붓세', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704180362814_%EB%9D%BC%EC%9D%B4%EC%8A%A4%20%EB%B6%93%EC%84%B8.jpg', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704180362814_thumb_%EB%9D%BC%EC%9D%B4%EC%8A%A4%20%EB%B6%93%EC%84%B8.jpg', 20, 0, 2200, '라이스 붓세\r\n이런 빵이 있는지도 몰랐다\r\n쌀과 붓세 붓세란 무엇일까?\r\n프랑스 구움 과자를 의미한다\r\n프랑스 에펠탑이 연상나는 맛이다', 0, 0, 0, 0, 8, NULL),
	(150, 13, 6, '플레인바게트', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704180425579_%ED%94%8C%EB%A0%88%EC%9D%B8%EB%B0%94%EA%B2%8C%ED%8A%B8.jpg', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704180425579_thumb_%ED%94%8C%EB%A0%88%EC%9D%B8%EB%B0%94%EA%B2%8C%ED%8A%B8.jpg', 20, 0, 3500, '플레인바게트\r\n딱딱해 보이지만 속은 부드럽다\r\n현관에 하나 두고 배고플 때 먹고 위급시엔 무기로 사용한다', 0, 0, 0, 0, 8, NULL),
	(151, 13, 2, '초코식빵', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704180485636_%EC%B4%88%EC%BD%94%EC%8B%9D%EB%B9%B5.jpg', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704180485636_thumb_%EC%B4%88%EC%BD%94%EC%8B%9D%EB%B9%B5.jpg', 10, 0, 6000, '초코식빵\r\n이건 진짜 맛있다\r\n식빵을 가장한 초코빵\r\n아침에 브런치 먹자하고 초코빵을 거하게 즐길 수 있다', 0, 1, 0, 0, 8, NULL),
	(152, 12, 9, '황치즈 스모어 쿠키', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704180773074_thumb_%ED%99%A9%EC%B9%98%EC%A6%88%20%EC%8A%A4%EB%AA%A8%EC%96%B4%20%EC%BF%A0%ED%82%A4.jpg', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704180773074_thumb_%ED%99%A9%EC%B9%98%EC%A6%88%20%EC%8A%A4%EB%AA%A8%EC%96%B4%20%EC%BF%A0%ED%82%A4.jpg', 20, 0, 3600, '부드러운 황치즈 에 쫀득한 스모어 가 만나 인기 만점 의 황치즈 스모어 쿠키🧡\r\n', 0, 0, 0, 0, 8, 0),
	(153, 12, 7, '체리 치즈 케이크', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704180811196_thumb_%EC%B2%B4%EB%A6%AC%20%EC%B9%98%EC%A6%88%20%EC%BC%80%EC%9D%B4%ED%81%AC.jpg', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704180811196_thumb_%EC%B2%B4%EB%A6%AC%20%EC%B9%98%EC%A6%88%20%EC%BC%80%EC%9D%B4%ED%81%AC.jpg', 20, 0, 5800, '꾸덕한 치즈케이크 위에 달콤새콤한 체리크림이 매력적인 체리 치즈 케이크\r\n', 0, 0, 0, 0, 8, 0),
	(154, 12, 7, '무화과 바닐라 파운드 케이크', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704180924136_thumb_%EB%AC%B4%ED%99%94%EA%B3%BC%20%EB%B0%94%EB%8B%90%EB%9D%BC%20%ED%8C%8C%EC%9A%B4%EB%93%9C%20%EC%BC%80%EC%9D%B4%ED%81%AC.jpg', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704180924136_thumb_%EB%AC%B4%ED%99%94%EA%B3%BC%20%EB%B0%94%EB%8B%90%EB%9D%BC%20%ED%8C%8C%EC%9A%B4%EB%93%9C%20%EC%BC%80%EC%9D%B4%ED%81%AC.jpg', 20, 0, 3800, '무화과 바닐라 파운드 케이크\r\n맛있다.', 0, 0, 0, 0, 8, 0),
	(155, 12, 9, '루토스 뉴욕롤', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704180972756_%EB%A3%A8%ED%86%A0%EC%8A%A4%20%EB%89%B4%EC%9A%95%EB%A1%A4.png', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704180972756_thumb_%EB%A3%A8%ED%86%A0%EC%8A%A4%20%EB%89%B4%EC%9A%95%EB%A1%A4.png', 20, 0, 5300, '몽블랑 속 달콤한 루토스 크림이 가득 들어간 겉바속촉 매력의 뉴욕롤🤎\r\n', 0, 0, 0, 0, 8, NULL),
	(156, 12, 9, '초코 샌드스콘', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704181031194_%EC%B4%88%EC%BD%94%20%EC%83%8C%EB%93%9C%EC%8A%A4%EC%BD%98.jpg', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704181031194_thumb_%EC%B4%88%EC%BD%94%20%EC%83%8C%EB%93%9C%EC%8A%A4%EC%BD%98.jpg', 20, 0, 4600, '초코 샌드스콘\r\n귀여움 하나로 살만하다', 0, 0, 0, 0, 8, NULL),
	(157, 12, 1, 'BEST 딸기라떼BOTTLE', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704181088663_BEST%20%EB%94%B8%EA%B8%B0%EB%9D%BC%EB%96%BCBOTTLE.png', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704181088663_thumb_BEST%20%EB%94%B8%EA%B8%B0%EB%9D%BC%EB%96%BCBOTTLE.png', 20, 0, 6800, '귀여운 베어브릭 보틀에 담긴 딸기라떼. 수제 딸기청이 들어가 더욱 상콤달콤한 딸기라떼.\r\n', 0, 1, 0, 0, 8, NULL),
	(158, 12, 1, '헤이즐넛 돌체 라떼', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704181125425_%ED%97%A4%EC%9D%B4%EC%A6%90%EB%84%9B%20%EB%8F%8C%EC%B2%B4%20%EB%9D%BC%EB%96%BC.png', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/menu/1704181125425_thumb_%ED%97%A4%EC%9D%B4%EC%A6%90%EB%84%9B%20%EB%8F%8C%EC%B2%B4%20%EB%9D%BC%EB%96%BC.png', 20, 0, 6500, '풍미깊은 헤이즐넛 시럽 과 달콤한 연유가 만나 인기만점인 헤이즐넛 돌체라떼\r\n', 0, 0, 0, 0, 8, NULL);
/*!40000 ALTER TABLE `MENU` ENABLE KEYS */;

-- 테이블 testdb.MENU_CATEGORY 구조 내보내기
CREATE TABLE IF NOT EXISTS `MENU_CATEGORY` (
  `menu_category_seq` int(11) NOT NULL AUTO_INCREMENT,
  `menu_category_name` varchar(30) NOT NULL,
  PRIMARY KEY (`menu_category_seq`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 테이블 데이터 testdb.MENU_CATEGORY:~9 rows (대략적) 내보내기
/*!40000 ALTER TABLE `MENU_CATEGORY` DISABLE KEYS */;
INSERT INTO `MENU_CATEGORY` (`menu_category_seq`, `menu_category_name`) VALUES
	(1, '음료'),
	(2, '식빵'),
	(3, '건강빵'),
	(4, '간식빵'),
	(5, '파이/패스트리'),
	(6, '도넛/고로케'),
	(7, '케이크'),
	(8, '샌드위치/샐러드'),
	(9, '디저트/스낵');
/*!40000 ALTER TABLE `MENU_CATEGORY` ENABLE KEYS */;

-- 테이블 testdb.OWNER 구조 내보내기
CREATE TABLE IF NOT EXISTS `OWNER` (
  `owner_id` varchar(50) NOT NULL,
  `owner_name` varchar(100) NOT NULL,
  `owner_password` varchar(100) NOT NULL,
  `owner_email` varchar(200) NOT NULL,
  `owner_phone` varchar(100) NOT NULL,
  `owner_address` varchar(300) NOT NULL,
  `owner_address_detail` varchar(300) DEFAULT NULL,
  `owner_address_latitude` decimal(20,17) NOT NULL,
  `owner_address_longitude` decimal(20,17) NOT NULL,
  `owner_regist_code` varchar(200) NOT NULL,
  PRIMARY KEY (`owner_id`),
  UNIQUE KEY `owner_email` (`owner_email`),
  UNIQUE KEY `owner_phone` (`owner_phone`),
  UNIQUE KEY `owner_regist_code` (`owner_regist_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 테이블 데이터 testdb.OWNER:~4 rows (대략적) 내보내기
/*!40000 ALTER TABLE `OWNER` DISABLE KEYS */;
INSERT INTO `OWNER` (`owner_id`, `owner_name`, `owner_password`, `owner_email`, `owner_phone`, `owner_address`, `owner_address_detail`, `owner_address_latitude`, `owner_address_longitude`, `owner_regist_code`) VALUES
	('kakaodong', '정문경', '12345', 'asme12@naver.com', '01048854885', '경기 성남시 분당구 판교역로 166', '판교역로 166', 37.39529694707520000, 127.11044929262200000, '48854885123'),
	('owner01', '임동선', '12345', 'liberatjd@gmail.com', '01096885728', '서울특별시 마포구 월드컵북로 4길 77', NULL, 37.55938993132770000, 126.92266819719400000, '12345678'),
	('owner02', '양유경', '12345', 'owner2@gmail.com', '01011111111', '서울특별시 마포구 월드컵북로 4길 77', NULL, 37.55938993132770000, 126.92266819719400000, '22345678'),
	('owner03', '정진', '12345', 'owner3@gmail.com', '01022222222', '서울특별시 마포구 월드컵북로 4길 77', NULL, 37.55938993132770000, 126.92266819719400000, '32345678');
/*!40000 ALTER TABLE `OWNER` ENABLE KEYS */;

-- 테이블 testdb.PAYMENT 구조 내보내기
CREATE TABLE IF NOT EXISTS `PAYMENT` (
  `payment_seq` int(11) NOT NULL AUTO_INCREMENT,
  `payment_member_id` varchar(50) NOT NULL,
  `payment_store_id` int(11) NOT NULL,
  `payment_type` int(11) NOT NULL,
  `payment_request_content` text DEFAULT NULL,
  `payment_delivery_fee` int(11) NOT NULL DEFAULT 0,
  `payment_coupon_id` int(11) DEFAULT NULL,
  `payment_mileage_price` int(11) NOT NULL DEFAULT 0,
  `payment_point_price` int(11) DEFAULT NULL,
  `payment_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `payment_get_id` int(11) NOT NULL,
  `payment_address` varchar(300) DEFAULT NULL,
  `payment_address_detail` varchar(300) DEFAULT NULL,
  `payment_address_latitude` decimal(20,17) DEFAULT NULL,
  `payment_address_longitude` decimal(20,17) DEFAULT NULL,
  `payment_is_cancel` tinyint(1) NOT NULL DEFAULT 0,
  `payment_cancel_content` text DEFAULT NULL,
  `payment_status_id` int(11) NOT NULL DEFAULT 0,
  `payment_predict_time` int(11) NOT NULL DEFAULT 30,
  `payment_merchant_uid` text DEFAULT NULL,
  PRIMARY KEY (`payment_seq`),
  UNIQUE KEY `payment_seq_payment_member_id` (`payment_seq`,`payment_member_id`),
  KEY `payment_member_id` (`payment_member_id`),
  KEY `payment_type` (`payment_type`),
  KEY `payment_get_id` (`payment_get_id`),
  KEY `payment_store_id` (`payment_store_id`),
  KEY `PAYMENT_ibfk_5` (`payment_status_id`),
  CONSTRAINT `PAYMENT_ibfk_1` FOREIGN KEY (`payment_member_id`) REFERENCES `MEMBER` (`member_id`) ON DELETE CASCADE,
  CONSTRAINT `PAYMENT_ibfk_2` FOREIGN KEY (`payment_type`) REFERENCES `PAYMENT_TYPE` (`payment_type_seq`) ON DELETE CASCADE,
  CONSTRAINT `PAYMENT_ibfk_3` FOREIGN KEY (`payment_get_id`) REFERENCES `PAYMENT_GET` (`payment_get_id`) ON DELETE CASCADE,
  CONSTRAINT `PAYMENT_ibfk_4` FOREIGN KEY (`payment_store_id`) REFERENCES `STORE` (`store_id`) ON DELETE CASCADE,
  CONSTRAINT `PAYMENT_ibfk_5` FOREIGN KEY (`payment_status_id`) REFERENCES `PAYMENT_STATUS` (`payment_status_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 테이블 데이터 testdb.PAYMENT:~35 rows (대략적) 내보내기
/*!40000 ALTER TABLE `PAYMENT` DISABLE KEYS */;
INSERT INTO `PAYMENT` (`payment_seq`, `payment_member_id`, `payment_store_id`, `payment_type`, `payment_request_content`, `payment_delivery_fee`, `payment_coupon_id`, `payment_mileage_price`, `payment_point_price`, `payment_date`, `payment_get_id`, `payment_address`, `payment_address_detail`, `payment_address_latitude`, `payment_address_longitude`, `payment_is_cancel`, `payment_cancel_content`, `payment_status_id`, `payment_predict_time`, `payment_merchant_uid`) VALUES
	(1, 'dongdong', 1, 1, '문 앞에 두고 벨 누르지 마세요!!', 0, NULL, 176, NULL, '2024-01-01 19:37:29', 1, '서울 강서구 강서로5가길 40', '101호', 37.52918564387200000, 126.84581650599100000, 0, NULL, 5, 30, NULL),
	(2, 'dongdong', 1, 1, '문 앞에 두고 가세요', 0, NULL, 0, NULL, '2024-01-01 19:38:31', 1, '서울 강서구 강서로5가길 40', '101호', 37.52918564387200000, 126.84581650599100000, 0, NULL, 5, 30, NULL),
	(3, 'dongdong', 1, 1, '문 앞에 두고 가세요', 0, NULL, 0, NULL, '2024-01-02 19:39:07', 1, '서울 강서구 강서로5가길 40', '101호', 37.52918564387200000, 126.84581650599100000, 0, NULL, 5, 30, NULL),
	(4, 'dongdong', 1, 1, '문 앞에 두고 가주세요', 0, NULL, 0, NULL, '2024-01-02 19:40:12', 1, '서울 강서구 강서로5가길 40', '101호', 37.52918564387200000, 126.84581650599100000, 0, NULL, 5, 30, NULL),
	(5, 'dongdong', 1, 1, '티슈도 넣어주세요', 0, NULL, 0, NULL, '2024-01-02 19:40:59', 1, '서울 강서구 강서로5가길 40', '101호', 37.52918564387200000, 126.84581650599100000, 0, NULL, 5, 30, NULL),
	(6, 'dongdong', 1, 1, '초 3개 주세요', 0, NULL, 0, NULL, '2024-01-02 19:42:50', 1, '서울 강서구 강서로5가길 40', '101호', 37.52918564387200000, 126.84581650599100000, 0, NULL, 5, 30, NULL),
	(7, 'dongdong', 1, 1, '시럽 많이 뿌려주세요', 0, NULL, 0, NULL, '2024-01-03 19:43:38', 1, '서울 강서구 강서로5가길 40', '101호', 37.52918564387200000, 126.84581650599100000, 0, NULL, 5, 30, NULL),
	(8, 'dongdong', 1, 1, '얼음 많이 주세요', 0, NULL, 0, NULL, '2024-01-03 19:45:00', 1, '서울 강서구 강서로5가길 40', '101호', 37.52918564387200000, 126.84581650599100000, 0, NULL, 5, 30, NULL),
	(9, 'dongdong', 1, 1, '우유 많이 넣어주세요', 0, NULL, 0, NULL, '2024-01-03 19:45:38', 1, '서울 강서구 강서로5가길 40', '101호', 37.52918564387200000, 126.84581650599100000, 0, NULL, 5, 30, NULL),
	(10, 'dongdong', 1, 1, '', 0, NULL, 0, NULL, '2024-01-03 19:47:10', 1, '서울 강서구 강서로5가길 40', '101호', 37.52918564387200000, 126.84581650599100000, 0, NULL, 5, 30, NULL),
	(11, 'dongdong', 1, 1, '초 긴 거 3개 짧은 거 1개 주세요', 0, NULL, 0, NULL, '2024-01-04 19:47:48', 1, '서울 강서구 강서로5가길 40', '101호', 37.52918564387200000, 126.84581650599100000, 0, NULL, 5, 30, NULL),
	(12, 'dongdong', 1, 1, '팥 많이 넣어주세요', 0, NULL, 0, NULL, '2024-01-04 19:48:16', 1, '서울 강서구 강서로5가길 40', '101호', 37.52918564387200000, 126.84581650599100000, 0, NULL, 5, 30, NULL),
	(13, 'dongdong', 1, 1, '', 0, NULL, 0, NULL, '2024-01-04 19:48:36', 1, '서울 강서구 강서로5가길 40', '101호', 37.52918564387200000, 126.84581650599100000, 0, NULL, 5, 30, NULL),
	(14, 'dongdong', 1, 1, '', 0, NULL, 0, NULL, '2024-01-04 19:51:28', 1, '서울 강서구 강서로5가길 40', '101호', 37.52918564387200000, 126.84581650599100000, 0, NULL, 5, 30, NULL),
	(15, 'dongdong', 1, 1, '문 앞에 두고 가세요.', 0, NULL, 0, NULL, '2024-01-04 19:52:08', 1, '서울 강서구 강서로5가길 40', '101호', 37.52918564387200000, 126.84581650599100000, 0, NULL, 5, 30, NULL),
	(16, 'dongdong', 1, 1, '', 0, NULL, 0, NULL, '2024-01-04 19:52:44', 1, '서울 강서구 강서로5가길 40', '101호', 37.52918564387200000, 126.84581650599100000, 0, NULL, 5, 30, NULL),
	(17, 'asme12', 1, 3, '사장님 맛있게 부탁드려요! 벨은 누르지 말아주세요~~', 0, NULL, 320, NULL, '2024-01-04 09:52:50', 1, '서울 강서구 강서로5길 4', '102호', 37.52925470714320000, 126.84779733436800000, 0, NULL, 5, 30, '1704329549845'),
	(18, 'dongdong', 3, 3, '안녕하세요', 0, NULL, 0, NULL, '2024-01-04 10:04:55', 1, '서울 강서구 강서로5가길 40', '101호', 37.52918564387200000, 126.84581650599100000, 0, NULL, 4, 30, '1704330262226'),
	(19, 'asme12', 1, 3, '사장님 맛있게 부탁드려요! 벨은 누르지 말아주세요~~', 0, NULL, 225, NULL, '2024-01-04 10:13:41', 1, '서울 강서구 강서로47라길 56-3', '201호', 37.55049721308500000, 126.83294131677800000, 0, NULL, 5, 30, '1704330806211'),
	(20, 'asme12', 1, 1, '', 0, NULL, 0, NULL, '2024-01-04 10:44:19', 1, '서울 강서구 강서로47라길 56-3', '201호', 37.55049721308500000, 126.83294131677800000, 0, NULL, 5, 30, NULL),
	(21, 'dongdong', 1, 1, '', 0, NULL, 0, NULL, '2024-01-04 11:10:16', 1, '서울 강서구 강서로5가길 40', '101호', 37.52918564387200000, 126.84581650599100000, 0, NULL, 5, 30, NULL),
	(22, 'asme12', 1, 3, '문 앞에 두고 가주세요.', 0, NULL, 1195, NULL, '2024-01-04 14:55:31', 1, '서울 강서구 강서로47라길 56-3', '201호', 37.55049721308500000, 126.83294131677800000, 0, NULL, 5, 30, '1704347716075'),
	(23, 'asme12', 1, 1, '', 0, NULL, 0, NULL, '2024-01-04 15:23:12', 1, '서울 강서구 강서로47라길 56-3', '201호', 37.55049721308500000, 126.83294131677800000, 0, NULL, 5, 30, NULL),
	(24, 'asme12', 1, 1, '', 0, NULL, 0, NULL, '2024-01-04 15:30:09', 1, '서울 강서구 강서로47라길 56-3', '201호', 37.55049721308500000, 126.83294131677800000, 0, NULL, 5, 30, NULL),
	(25, 'asme12', 1, 1, '', 0, NULL, 0, NULL, '2024-01-04 15:30:13', 1, '서울 강서구 강서로47라길 56-3', '201호', 37.55049721308500000, 126.83294131677800000, 0, NULL, 5, 30, NULL),
	(26, 'asme12', 1, 1, '', 0, NULL, 0, NULL, '2024-01-04 15:32:32', 1, '서울 강서구 강서로47라길 56-3', '201호', 37.55049721308500000, 126.83294131677800000, 0, NULL, 5, 30, NULL),
	(27, 'dongdong', 1, 1, '', 0, NULL, 0, NULL, '2024-01-04 19:35:13', 1, '서울 강서구 강서로5가길 40', '101호', 37.52918564387200000, 126.84581650599100000, 0, NULL, 5, 30, NULL),
	(28, 'dongdong', 1, 1, '', 0, NULL, 0, NULL, '2024-01-04 19:39:05', 1, '서울 강서구 강서로5가길 40', '101호', 37.52918564387200000, 126.84581650599100000, 0, NULL, 5, 30, NULL),
	(29, 'dongdong', 1, 1, '', 0, NULL, 0, NULL, '2024-01-04 19:41:23', 1, '서울 강서구 강서로5가길 40', '101호', 37.52918564387200000, 126.84581650599100000, 0, NULL, 5, 30, NULL),
	(30, 'dongdong', 4, 1, '', 0, NULL, 0, NULL, '2024-01-04 19:56:48', 2, NULL, NULL, 0.00000000000000000, 0.00000000000000000, 0, NULL, 0, 30, NULL),
	(31, 'asme12', 1, 1, '', 0, NULL, 0, NULL, '2024-01-05 09:19:01', 1, '서울 강서구 강서로47라길 56-3', '201호', 37.55049721308500000, 126.83294131677800000, 0, NULL, 5, 30, NULL),
	(32, 'asme12', 1, 1, '', 0, NULL, 0, NULL, '2024-01-05 09:20:55', 1, '서울 강서구 강서로47라길 56-3', '201호', 37.55049721308500000, 126.83294131677800000, 0, NULL, 5, 30, NULL),
	(33, 'asme12', 1, 1, '', 0, NULL, 0, NULL, '2024-01-05 09:23:48', 1, '서울 강서구 강서로47라길 56-3', '201호', 37.55049721308500000, 126.83294131677800000, 0, NULL, 5, 30, NULL),
	(34, 'asme12', 1, 1, '', 0, NULL, 0, NULL, '2024-01-05 10:07:31', 1, '서울 강서구 강서로47라길 56-3', '201호', 37.55049721308500000, 126.83294131677800000, 0, NULL, 5, 30, NULL),
	(35, 'asme12', 1, 1, '', 0, NULL, 0, NULL, '2024-01-05 17:06:21', 1, '서울 강서구 강서로47라길 56-3', '201호', 37.55049721308500000, 126.83294131677800000, 0, NULL, 5, 30, NULL);
/*!40000 ALTER TABLE `PAYMENT` ENABLE KEYS */;

-- 테이블 testdb.PAYMENT_GET 구조 내보내기
CREATE TABLE IF NOT EXISTS `PAYMENT_GET` (
  `payment_get_id` int(11) NOT NULL,
  `payment_get_content` varchar(30) NOT NULL,
  PRIMARY KEY (`payment_get_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 테이블 데이터 testdb.PAYMENT_GET:~3 rows (대략적) 내보내기
/*!40000 ALTER TABLE `PAYMENT_GET` DISABLE KEYS */;
INSERT INTO `PAYMENT_GET` (`payment_get_id`, `payment_get_content`) VALUES
	(1, '배달'),
	(2, '픽업'),
	(3, '구독');
/*!40000 ALTER TABLE `PAYMENT_GET` ENABLE KEYS */;

-- 테이블 testdb.PAYMENT_PRODUCT 구조 내보내기
CREATE TABLE IF NOT EXISTS `PAYMENT_PRODUCT` (
  `payment_product_payment_id` int(11) NOT NULL,
  `payment_product_menu_id` int(11) NOT NULL,
  `payment_product_count` int(11) NOT NULL DEFAULT 1,
  `payment_product_price` int(11) NOT NULL,
  `payment_product_discount_price` int(11) NOT NULL,
  PRIMARY KEY (`payment_product_payment_id`,`payment_product_menu_id`),
  KEY `payment_product_menu_id` (`payment_product_menu_id`),
  CONSTRAINT `PAYMENT_PRODUCT_ibfk_1` FOREIGN KEY (`payment_product_payment_id`) REFERENCES `PAYMENT` (`payment_seq`) ON DELETE CASCADE,
  CONSTRAINT `PAYMENT_PRODUCT_ibfk_2` FOREIGN KEY (`payment_product_menu_id`) REFERENCES `MENU` (`menu_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 테이블 데이터 testdb.PAYMENT_PRODUCT:~38 rows (대략적) 내보내기
/*!40000 ALTER TABLE `PAYMENT_PRODUCT` DISABLE KEYS */;
INSERT INTO `PAYMENT_PRODUCT` (`payment_product_payment_id`, `payment_product_menu_id`, `payment_product_count`, `payment_product_price`, `payment_product_discount_price`) VALUES
	(1, 3, 1, 2800, 0),
	(1, 12, 1, 3000, 200),
	(2, 7, 1, 3000, 0),
	(2, 9, 1, 2500, 200),
	(3, 10, 1, 10000, 1000),
	(3, 13, 1, 20000, 2000),
	(4, 2, 1, 2800, 0),
	(5, 1, 1, 2800, 0),
	(6, 14, 1, 18000, 2000),
	(7, 10, 1, 10000, 1000),
	(8, 12, 1, 3000, 200),
	(9, 9, 1, 2500, 200),
	(10, 12, 1, 3000, 200),
	(11, 13, 1, 20000, 2000),
	(12, 11, 1, 10000, 1000),
	(13, 7, 1, 3000, 0),
	(14, 9, 1, 2500, 200),
	(15, 6, 1, 3300, 0),
	(16, 12, 1, 3000, 200),
	(17, 15, 3, 10500, 1500),
	(18, 30, 1, 2000, 0),
	(19, 15, 3, 10500, 1500),
	(20, 1, 1, 2800, 0),
	(21, 15, 3, 10500, 1500),
	(22, 15, 3, 10500, 1500),
	(23, 10, 1, 10000, 1000),
	(24, 12, 1, 3000, 200),
	(25, 12, 1, 3000, 200),
	(26, 12, 1, 3000, 200),
	(27, 15, 1, 3500, 500),
	(28, 15, 1, 3500, 500),
	(29, 15, 1, 3500, 500),
	(30, 39, 2, 14400, 0),
	(31, 12, 1, 3000, 200),
	(32, 14, 1, 18000, 2000),
	(33, 13, 1, 20000, 2000),
	(34, 10, 1, 10000, 1000),
	(35, 13, 1, 20000, 2000);
/*!40000 ALTER TABLE `PAYMENT_PRODUCT` ENABLE KEYS */;

-- 테이블 testdb.PAYMENT_STATUS 구조 내보내기
CREATE TABLE IF NOT EXISTS `PAYMENT_STATUS` (
  `payment_status_id` int(11) NOT NULL,
  `payment_status_name` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`payment_status_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 테이블 데이터 testdb.PAYMENT_STATUS:~9 rows (대략적) 내보내기
/*!40000 ALTER TABLE `PAYMENT_STATUS` DISABLE KEYS */;
INSERT INTO `PAYMENT_STATUS` (`payment_status_id`, `payment_status_name`) VALUES
	(0, '대기'),
	(1, '수락'),
	(2, '준비완료'),
	(3, '배달출발'),
	(4, '완료대기'),
	(5, '수령완료'),
	(10, '주문취소'),
	(11, '거절'),
	(12, '거절완료');
/*!40000 ALTER TABLE `PAYMENT_STATUS` ENABLE KEYS */;

-- 테이블 testdb.PAYMENT_TYPE 구조 내보내기
CREATE TABLE IF NOT EXISTS `PAYMENT_TYPE` (
  `payment_type_seq` int(11) NOT NULL,
  `payment_type` varchar(30) NOT NULL,
  PRIMARY KEY (`payment_type_seq`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 테이블 데이터 testdb.PAYMENT_TYPE:~4 rows (대략적) 내보내기
/*!40000 ALTER TABLE `PAYMENT_TYPE` DISABLE KEYS */;
INSERT INTO `PAYMENT_TYPE` (`payment_type_seq`, `payment_type`) VALUES
	(1, '만나서 결제'),
	(2, '카드'),
	(3, '카카오페이'),
	(4, '토스페이');
/*!40000 ALTER TABLE `PAYMENT_TYPE` ENABLE KEYS */;

-- 테이블 testdb.PUSH_ALARM 구조 내보내기
CREATE TABLE IF NOT EXISTS `PUSH_ALARM` (
  `push_alarm_id` int(11) NOT NULL AUTO_INCREMENT,
  `push_alarm_store_id` int(11) NOT NULL,
  `push_alarm_title` varchar(300) NOT NULL,
  `push_alarm_content` text NOT NULL,
  `push_alarm_category_id` int(11) NOT NULL,
  `push_alarm_datetime` timestamp NOT NULL,
  `push_alarm_to_target_id` varchar(10) NOT NULL,
  PRIMARY KEY (`push_alarm_id`),
  KEY `push_alarm_store_id` (`push_alarm_store_id`),
  KEY `push_alarm_category_id` (`push_alarm_category_id`),
  CONSTRAINT `PUSH_ALARM_ibfk_1` FOREIGN KEY (`push_alarm_store_id`) REFERENCES `STORE` (`store_id`) ON DELETE CASCADE,
  CONSTRAINT `PUSH_ALARM_ibfk_2` FOREIGN KEY (`push_alarm_category_id`) REFERENCES `PUSH_ALARM_CATEGORY` (`push_alarm_category_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 테이블 데이터 testdb.PUSH_ALARM:~4 rows (대략적) 내보내기
/*!40000 ALTER TABLE `PUSH_ALARM` DISABLE KEYS */;
INSERT INTO `PUSH_ALARM` (`push_alarm_id`, `push_alarm_store_id`, `push_alarm_title`, `push_alarm_content`, `push_alarm_category_id`, `push_alarm_datetime`, `push_alarm_to_target_id`) VALUES
	(1, 1, '한정수량!', '#빵 구워졌어요\r\n우리 가게의 빵이 방금 구워졌습니다\r\n향긋한 빵이 오늘의 행복을 선사할 거예요\r\n빵의 온기와 함께 사랑도 전달됩니다\r\n지금 바로 우리 가게로 오세요!', 1, '2024-01-04 11:06:28', '찜'),
	(2, 1, '한정수량!', '#빵 구워졌어요\r\n우리 가게의 빵이 방금 구워졌습니다\r\n', 1, '2024-01-04 11:06:41', '찜'),
	(3, 1, '갓 구운 빵 나왔어요!', '#따끈따끈\r\n우리 가게의 빵이 방금 탄생했어요\r\n따끈따끈한 향기와 함께 맛도 최고! \r\n사장님이 직접 구운 빵, 놓치지 마세요\r\n지금 바로 매장으로 오세요!', 1, '2024-01-04 15:52:42', '찜'),
	(4, 1, '갓 구운 빵 나왔어요!', '#따끈따끈\r\n우리 가게의 빵이 방금 탄생했어요\r\n따끈따끈한 향기와 함께 맛도 최고! \r\n사장님이 직접 구운 빵, 놓치지 마세요\r\n지금 바로 매장으로 오세요!', 1, '2024-01-04 16:04:04', '찜');
/*!40000 ALTER TABLE `PUSH_ALARM` ENABLE KEYS */;

-- 테이블 testdb.PUSH_ALARM_CATEGORY 구조 내보내기
CREATE TABLE IF NOT EXISTS `PUSH_ALARM_CATEGORY` (
  `push_alarm_category_id` int(11) NOT NULL,
  `push_alarm_category_name` varchar(60) NOT NULL,
  PRIMARY KEY (`push_alarm_category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 테이블 데이터 testdb.PUSH_ALARM_CATEGORY:~3 rows (대략적) 내보내기
/*!40000 ALTER TABLE `PUSH_ALARM_CATEGORY` DISABLE KEYS */;
INSERT INTO `PUSH_ALARM_CATEGORY` (`push_alarm_category_id`, `push_alarm_category_name`) VALUES
	(1, '빵나오는 시간'),
	(2, '가게 공지'),
	(3, '구독 공지');
/*!40000 ALTER TABLE `PUSH_ALARM_CATEGORY` ENABLE KEYS */;

-- 테이블 testdb.STORE 구조 내보내기
CREATE TABLE IF NOT EXISTS `STORE` (
  `store_id` int(11) NOT NULL AUTO_INCREMENT,
  `store_owner_id` varchar(50) NOT NULL,
  `store_is_pickup` tinyint(1) NOT NULL,
  `store_is_delivery` tinyint(1) NOT NULL,
  `store_is_subscribe` tinyint(1) NOT NULL,
  `store_name` varchar(100) NOT NULL,
  `store_address` varchar(300) NOT NULL,
  `store_address_detail` varchar(300) DEFAULT NULL,
  `store_address_latitude` decimal(20,17) NOT NULL,
  `store_address_longitude` decimal(20,17) NOT NULL,
  `store_phone` varchar(100) NOT NULL,
  `store_min_delivery_price` int(11) NOT NULL,
  `store_avg_delivery_predict_time` int(11) DEFAULT 15,
  `store_operation_hour` varchar(60) DEFAULT '0',
  `store_is_open` tinyint(1) NOT NULL DEFAULT 0,
  `store_closed_date` varchar(30) DEFAULT NULL,
  `store_introduce` text DEFAULT NULL,
  `store_made_in` text DEFAULT NULL,
  `store_view_count` int(11) NOT NULL DEFAULT 0,
  `store_pay_tier` int(11) NOT NULL,
  `store_delivery_fee` int(11) NOT NULL DEFAULT 0,
  `store_avg_score_number` double DEFAULT NULL,
  `store_ip_path` text DEFAULT NULL,
  `store_img_thumbnail_path` varchar(300) DEFAULT NULL,
  `store_img_path` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`store_id`),
  UNIQUE KEY `store_name` (`store_name`),
  UNIQUE KEY `store_phone` (`store_phone`),
  KEY `store_owner_id` (`store_owner_id`),
  CONSTRAINT `STORE_ibfk_1` FOREIGN KEY (`store_owner_id`) REFERENCES `OWNER` (`owner_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 테이블 데이터 testdb.STORE:~13 rows (대략적) 내보내기
/*!40000 ALTER TABLE `STORE` DISABLE KEYS */;
INSERT INTO `STORE` (`store_id`, `store_owner_id`, `store_is_pickup`, `store_is_delivery`, `store_is_subscribe`, `store_name`, `store_address`, `store_address_detail`, `store_address_latitude`, `store_address_longitude`, `store_phone`, `store_min_delivery_price`, `store_avg_delivery_predict_time`, `store_operation_hour`, `store_is_open`, `store_closed_date`, `store_introduce`, `store_made_in`, `store_view_count`, `store_pay_tier`, `store_delivery_fee`, `store_avg_score_number`, `store_ip_path`, `store_img_thumbnail_path`, `store_img_path`) VALUES
	(1, 'owner01', 1, 1, 1, '푸하하크림빵', '서울특별시 마포구 양화로 19길 22-25', '1층', 37.55898372753500000, 126.92442390517200000, '023336003', 8000, 30, '08:00-21:00', 1, '일', '한입 베어 물면 푸하하 웃음 나는 푸하하크림빵입니다. 크림빵을 전문으로 하는 빵가게 입니다.', '밀가루:국내산,우유:국내산,고구마:국내산,딸기:국내산', 0, 0, 2000, 4.4, 'http://192.168.0.130:9090/app4', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/store/1704094426511_thumbnail_2023-01-23.jpg', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/store/1704094427120_2023-02-14.jpg'),
	(2, 'owner02', 1, 0, 0, '뽀르뚜아', '서울특별시 마포구 동교로 201', '1층', 37.55822081614460000, 126.92297204215300000, '023343067', 10000, 30, '07:00-23:00', 1, '연중무휴', '천연 발효종을 사용하는 뽀르뚜아입니다. 엄선된 재료를 사용해서 최상의 품질의 빵을 제공하겠습니다.', '밀가루:국내산,소고기:한우,딸기:국내산', 0, 0, 0, NULL, 'http://192.168.0.98:9090/app4', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/store/1704111759074_thumbnail_%EB%8B%A4%EC%9A%B4%EB%A1%9C%EB%93%9C%20%284%29.jpg', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/store/1704111759215_%EB%8B%A4%EC%9A%B4%EB%A1%9C%EB%93%9C%20%281%29.jpg'),
	(3, 'owner03', 0, 1, 1, '자미당', '서울특별시 마포구 동교로 27길 22', '1층', 37.55915389200000000, 126.92242680410800000, '023228433', 6000, 15, '08:00-21:00', 1, '일', '자미당은 좋은 맛을 내는 집 이라는 뜻으로 맛 좋은 빵을 제공하겠습니다.', '밀가루:국내산,소시지:독일산,계란:국내산', 0, 1, 3000, NULL, 'http://192.168.0.130:9090/app4', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/store/1704108144878_thumbnail_50CB18C6-295B-4BA7-9471-53C6E3CA8C4D.jpg', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/store/1704108145118_KakaoTalk_20210325_101305264_01_edited_j.webp'),
	(4, 'owner01', 1, 1, 1, '코코로카라', '서울 마포구 연남로1길 41', '1층', 37.55983489464895000, 126.92084191808017000, '01002540254', 7000, 15, '11:00-21:00', 0, '연중무휴', '안녕하세요, 마음을 담은 작은 과자점 코코로카라 입니다 :) 부족함이 많은 매장이지만 늘 따뜻한 관심과 다정한 시선으로 바라봐주셔 진심으로 감사합니다.이곳까지의 소중한 발걸음이 헛되이 되지 않도록 보다 더 만족스러운 디저트로 보답하도록 늘 최선을 다해 노력 하겠습니다 :)', '계란:국내산,우유:국내산,딸기:국내산', 0, 1, 0, NULL, NULL, 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/store/1704113828427_thumbnail_%EA%B0%80%EA%B2%8C1.jpg', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/store/1704113829492_%EA%B0%80%EA%B2%8C2.jpg'),
	(5, 'owner01', 1, 1, 1, '만동제과', '서울 서대문구 연희로 32', '1층', 37.55983489464895000, 126.92084191808017000, '050714045079', 8000, 15, '10:00-20:30', 1, '일', '귀한 발걸음과 시간을 내서 방문해주시는 고객님들을 위해, 어떻게하면 더 좋은 맛을 가진 빵을 제공할 수 있을지, 어떻게하면 저희가 만드는 빵을 통해 오늘도 행복한 미소를 지을 수 있을지 항상 고민합니다. 앞으로도 더 많은 분들에게, 저희가 만드는 빵을통해 보다 행복한 미소를 지을 수 있도록 최선을 다해 빵을 반죽할것을 약속하겠습니다.  언제든 만동제과의 빵이 생각난다면 만동제과의 문을 두드려주시기 바랍니다.', '밀가루:국내산, 버터:미국산,마늘:국내산', 0, 0, 3000, NULL, NULL, 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/store/1704116387371_thumbnail_%EB%A7%8C%EB%8F%99%EC%A0%9C%EA%B3%BC.jpg', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/store/1704116387698_%EA%B0%80%EA%B2%8C2.jpg'),
	(6, 'owner01', 1, 1, 1, '버터베이커리', '서울 마포구 동교로 226', '1층', 37.55983489464895000, 126.92398528821766000, '023322642', 8000, 15, '09:00-21:30', 0, '연중무휴', '흔한 광고 하나 쓰지 않고 오로지 입소문만으로 8년간 유지해온 연남동 찐 맛집!! 빵 반죽만 먹어도 맛있다!', '밀가루:국내산,버터:프랑스', 0, 1, 0, NULL, NULL, 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/store/1704132295893_thumbnail_%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7%202024-01-02%20030225.png', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/store/1704132297882_%EB%82%B4%EB%B6%80.jpeg'),
	(7, 'owner03', 0, 1, 1, '고요베이크샵', '서울 마포구 동교로 144-3', '단독주택', 37.55983489464895000, 126.92084191808017000, '050713097421', 6000, 15, '11:00-21:00', 1, '연중무휴', '유투버 고요비가 운영하는 3층으로 이루어진 단독주택을 개조한 대형 베이커리 카페입니다. 도심 속에서의 휴식, 소중한 사람과의 데이트 친구들과 놀거리 등 좋은 추억을 간직하실 수 있도록 최선을 다하겠습니다:)', '밀가루:국내산,버터:미국산', 0, 1, 3000, NULL, NULL, 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/store/1704135238567_thumbnail_%EC%8D%B8%EB%84%A4%EC%9D%BC.jpeg', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/store/1704135238910_%EA%B0%80%EA%B2%8C%20%EB%82%B4%EB%B6%80.jpeg'),
	(8, 'owner01', 1, 1, 0, '꿀넹쿠키', '서울 마포구 동교로 255-1', '1층', 37.56274531136743600, 126.92458524151847000, '050713999668', 8000, 30, '08:00-21:00', 1, '연중무휴', '-23kg 빵순이 다이어터가 만드는 건강한 재료로 죄책감 없이 먹을 수 있는 비건르뱅쿠키', '밀가루:국내산, 버터:미국산', 0, 0, 3000, NULL, 'http://192.168.0.90:9090/app4', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/store/1704118005862_thumbnail_%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7%202024-01-01%20230335.png', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/store/1704118007433_%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7%202024-01-01%20230627.png'),
	(9, 'owner01', 0, 1, 0, '마크스로프트', '서울특별시 마포구 양화로 19길 22-25', '1층', 37.55426199252017000, 126.92749098243947000, '050713427796', 8000, 30, '10:00-22:00', 1, '연중무휴', '-Mark’s Loft (breadworks) 홍대본점- Fresh Deli • Sandwich • Bread •Cakes and more…', '밀가루:국내산, 버터:미국산,쌀가루:국내산', 0, 0, 0, NULL, NULL, 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/store/1704121565748_thumbnail_%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7%202024-01-02%20000332.png', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/store/1704121566056_%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7%202024-01-02%20000542.png'),
	(10, 'owner01', 1, 1, 1, '마가렛연남', '서울 마포구 성미산로29길 10', '1층', 37.55431146910602000, 126.92736361643314000, '050713826412', 8000, 15, '11:00-22:00', 0, '일', '우리 빵집은 정성스럽게 만든 다양한 종류의 빵들로 가득 차 있습니다. 매일매일 변화하는 빵 메뉴는 당신에게 다채로운 맛의 세계를 열어줄거에요. 따뜻한 오븐에서 나오는 각기 다른 모양과 맛의 빵들은 당신을 향기롭고 달콤한 세계로 안내합니다.', '옥수수가루:국내산,버터:국내산,치즈 :국내산,아몬드:미국산,설탕:국내산', 0, 1, 0, NULL, NULL, 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/store/1704119021725_thumbnail_%EC%84%AC%EB%84%A4%EC%9D%BC.jpg', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/store/1704119022594_%EC%83%81%EC%84%B8.jpg'),
	(11, 'owner03', 0, 1, 1, '파롤앤랑그', '서울 마포구 성미산로29길 8', '1층', 37.56498316643037000, 126.92285121293236000, '023322527', 8000, 15, '13:00-21:00', 1, '일', '연남동에서 만날 수 있는 귀여우면서도 맛있는 디저트 카페, 바로 파롤앤랑크입니다. 우리 카페는 네모난 파이로 유명하며, 그 독특한 디자인과 풍부한 맛으로 연남동 지역에서 손꼽히는 곳 중 하나로 자리매김하고 있습니다.', '밀가루:국내산,버터:국내산,설탕:국내산,바나나:필리핀,토마토:국내산,홍시:국내산,딸기:국내산,피스타치오:미국,옥수수:미국', 0, 1, 3000, NULL, 'http://192.168.0.90:9090/app4', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/store/1704102786502_thumbnail_%ED%8C%8C%EB%A1%A4%EC%95%A4%EB%9E%91%EA%B7%B8%EA%B0%80%EA%B2%8C.jpeg', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/store/1704108524080_%EB%9E%91%EA%B7%B8%EC%83%81%EC%84%B82.jpg'),
	(12, 'owner02', 1, 0, 0, '필로베이커리', '서울 마포구 홍익로2길 27-22', '2층 필로베이커리', 37.56003517955236000, 126.92398528821766000, '050713817786', 10000, 20, '07:00-23:00', 1, '월', 'NO SUGARE. 건강하고 맛있는 누구에게나 선물하기 좋은 무설탕 디저트 카페.  필로베이커리 는 설탕대신 스테비아를 사용하여 맛있고 건강한 디저트를 매장에서 직접 만듭니다.', '밀가루:국내산,버터:미국산,초코:가나,모카파우더:몽골', 0, 0, 2500, NULL, 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/store/1704177354438_thumbnail_%ED%95%84%EB%A1%9C%EB%B2%A0%EC%9D%B4%EC%BB%A4%EB%A6%AC%EB%8C%80%EB%AC%B8.png', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/store/1704177354438_thumbnail_%ED%95%84%EB%A1%9C%EB%B2%A0%EC%9D%B4%EC%BB%A4%EB%A6%AC%EB%8C%80%EB%AC%B8.png', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/store/1704177356282_%ED%95%84%EB%A1%9C%EB%B2%A0%EC%9D%B4%EC%BB%A4%EB%A6%AC%EB%8C%80%EB%AC%B8.png'),
	(13, 'owner01', 1, 1, 1, '브레드앤밀 일산점', '경기 고양시 일산서구 일산로 523 보성상가', '하늘빌딩 1층 110호', 37.67676678906713000, 126.76945107983065000, '0319751911', 5000, 15, '08:00-21:00', 0, '연중무휴', '맛있고 건강에 유익한 빵을 만들기 위해 유기농 밀가루와 유기농 우유, 100%우유버터를 사용하는 수제 식빵 전문점 브레드앤밀 입니다.  항상 신선한 빵을 제공해 드리기 위해 당일생산,당일판매의 원칙을 지켜가고 있습니다.', '초코:가나,밀가루:수입산,우유:연세대,계란:국내산,치즈:스위스,모카파우더:미국,김:제주도', 0, 0, 0, NULL, 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/store/1704179698572_thumbnail_%EB%B8%8C%EB%9E%98%EB%93%9C%EC%95%A4%EB%B0%80.jpg', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/store/1704179698572_thumbnail_%EB%B8%8C%EB%9E%98%EB%93%9C%EC%95%A4%EB%B0%80.jpg', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/store/1704179699124_%EB%B8%8C%EB%9E%98%EB%93%9C%EC%95%A4%EB%B0%80.jpg');
/*!40000 ALTER TABLE `STORE` ENABLE KEYS */;

-- 테이블 testdb.STORE_IMG_PATH 구조 내보내기
CREATE TABLE IF NOT EXISTS `STORE_IMG_PATH` (
  `store_img_path_seq` int(11) NOT NULL AUTO_INCREMENT,
  `store_img_path_store_id` int(11) NOT NULL,
  `store_img_path` varchar(300) NOT NULL,
  `store_img_path_category` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`store_img_path_seq`),
  KEY `store_img_path_store_id` (`store_img_path_store_id`),
  CONSTRAINT `STORE_IMG_PATH_ibfk_1` FOREIGN KEY (`store_img_path_store_id`) REFERENCES `STORE` (`store_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 테이블 데이터 testdb.STORE_IMG_PATH:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `STORE_IMG_PATH` DISABLE KEYS */;
/*!40000 ALTER TABLE `STORE_IMG_PATH` ENABLE KEYS */;

-- 테이블 testdb.STORE_NOTICE 구조 내보내기
CREATE TABLE IF NOT EXISTS `STORE_NOTICE` (
  `store_notice_seq` int(11) NOT NULL AUTO_INCREMENT,
  `store_notice_store_id` int(11) NOT NULL,
  `store_notice_title` varchar(300) NOT NULL,
  `store_notice_content` text NOT NULL,
  `store_notice_img_path` varchar(300) DEFAULT NULL,
  `store_notice_date` timestamp NOT NULL,
  `store_notice_view_count` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`store_notice_seq`),
  KEY `store_notice_store_id` (`store_notice_store_id`),
  CONSTRAINT `STORE_NOTICE_ibfk_1` FOREIGN KEY (`store_notice_store_id`) REFERENCES `STORE` (`store_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 테이블 데이터 testdb.STORE_NOTICE:~10 rows (대략적) 내보내기
/*!40000 ALTER TABLE `STORE_NOTICE` DISABLE KEYS */;
INSERT INTO `STORE_NOTICE` (`store_notice_seq`, `store_notice_store_id`, `store_notice_title`, `store_notice_content`, `store_notice_img_path`, `store_notice_date`, `store_notice_view_count`) VALUES
	(1, 3, '자미당에서 NEW시나몬모닝토스트 식빵이 새로 출시 되었습니다.', '페스츄리 결이 살아있어 바삭하고, 은은한 시나몬향과 달콤한 맛이 조화로운 패스츄리 식빵인 NEW시나몬모닝토스트가 출시 되었습니다.\r\n출시 기념 이벤트로 NEW시나몬모닝토스트가 1000원 할인 행사 중입니다. 많은 관심 부탁드립니다.', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/notice/1704108842178_574698-%EB%AA%A8%EB%8B%9D%ED%86%A0%EC%8A%A4%ED%8A%B8_%EC%8D%B8%EB%84%A4%EC%9D%BC1-1280x1280.jpg', '2024-01-01 20:34:02', 0),
	(2, 1, '매장 이전 안내', '저희 푸하하크림빵은 23년 12월 7일 부로 "서울특별시 마포구 양화로 19길 22-25 1층"으로 이전하게 되었습니다.\r\n지속적인 관심과 사랑 부탁드립니다.', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/notice/1704109618634_%EC%BA%A1%EC%B2%98.PNG', '2024-01-01 20:46:58', 0),
	(3, 2, '딸기 원자재 인상으로 인한 가격 변동', '최근 딸기 원재료 가격 급등으로 인해 저희의 "딸기 생크림 케이크"의 가격이 18,000원에서 20,000원으로 조정되었음을 알려드리게 되었습니다. \r\n이 결정은 가볍게 내려진 것이 아니며, 우리 제품에서 기대하는 탁월한 맛과 신선함을 제공하기 위해 고품질의 재료를 사용하기 위해 최선을 다하고 있습니다. 여러분의 이해와 지속적인 관심에 감사드립니다. 질문이나 문의 사항이 있는 경우 언제든지 당사 고객 서비스 팀에 문의해 주세요. 감사합니다', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/notice/1704114774466_5969627.png', '2024-01-01 22:12:54', 0),
	(4, 8, '꿀넹쿠키 스콘모양 변경안내', '안녕하세요? 꿀사장입니다~ 스콘 관련 공지사항이 있어 공지사항을 올립니다. 삼각모양을 만드는 과정에서 어깨통증이 유발되어 품질과 서비스의 향상을 위해 2022년 2월 28일(월)부터 스콘모양이 변경됨을 알려 드립니다. 모양만 변경될 뿐, 중량 및 재료 등 모양의 변경은 없음을 약속드립니다. 앞으로도 건강하면서 맛있는 비건빵으로 고객님께 만족을 드릴 수 있도록 최선을 다하겠습니다.', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/notice/1704120863604_%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7%202024-01-01%20235127.png', '2024-01-01 23:54:23', 0),
	(5, 9, '사장님이 미쳤어요~!', '소금빵에 진심인 사장님이 하나 더 쏜다!! 마크스로프트 고객님을 위한 소금빵 2+1 이벤트를 진행합니다. *현장 구매시만 가능한 이벤트입니다!', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/notice/1704128110011_%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7%202024-01-02%20015236.png', '2024-01-02 01:55:10', 0),
	(6, 11, '파롤앤랑크 공지사항', '휴무일 안내\r\n다가오는 공휴일이나 특별한 날에는 매장이 휴무일일 수 있습니다. 불편함이 없도록 방문 전에 매장 운영일정을 확인해주세요. 여러분의 양해와 협조에 감사드립니다.', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/notice/1704107506348_%EB%9E%91%ED%81%AC%20%EA%B3%B5%EC%A7%80%EC%82%AC%ED%95%AD.png', '2024-01-01 20:08:52', 0),
	(7, 10, '마가렛 연남 딸기케이크 출시🍓🍓🍓', '제철인 겨울 딸기로 만든 맛있는 딸기케이크가 출시되었습니다🎂\r\n촉촉한 시트와 우유맛 진한 크림, 달콤한 딸기가 가득 들어있습니다.\r\n마가렛에서 판매하는 모든 케이크들은\r\n100% 동물성크림, 프랑스초콜렛, 마스카포네 치즈 등\r\n좋은 재료들만 이용해서 만들고 있으니 안심하고 드셔도 괜찮습니다.\r\n\r\n매장에서는 조각케이크로 구매 가능하시고\r\n홀케이크는 025에서 예약 가능합니다', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/notice/1704110767821_%EB%94%B8%EA%B8%B0%EC%BC%80%EC%9D%B4%ED%81%AC.jpeg', '2024-01-01 21:06:08', 0),
	(8, 10, '소중한 의견 기다려요! 📣', '고객 여러분의 소중한 의견을 듣고 싶어요. 서비스나 메뉴에 대한 아이디어가 있다면 언제든지 말씀해주세요. 함께 더 나은 마가렛연남을 만들어 나갈 수 있도록 노력하겠습니다.\r\n\r\n감사합니다. 빵과 함께하는 특별한 순간, 마가렛연남과 함께해요! 🥖🌈', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/notice/1704111748806_%EC%9D%98%EA%B2%AC.jpg', '2024-01-01 21:22:31', 0),
	(9, 12, '임시휴무 🧸필로베이커리 설날 휴무✨ 🧸필로베이커리 설날 휴무✨', '📢🐻‍❄️안녕하세요 필로베이커리 는 설 당일부터 화요일 (1/22-1/24) 은 휴무일입니다.\r\n방문에 차질 없으시길 바랍니다♥️🐰\r\n\r\n필로베이커리를 찾아주시고, 사랑해주시는 모든 분들께 감사하며 새해복 많이 받으세요♥️🐰\r\n\r\n\r\n✨건강한 디저트 필로베이커리 에서 만나요🐰내용 더보기\r\n기간 2023.01.23. ~ 2023.01.24.', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/notice/1704177728166_%EA%B3%B5%EC%A7%80%EC%82%AC%ED%95%AD%EC%84%A4%ED%9C%B4%EB%AC%B4.png', '2024-01-02 15:42:08', 0),
	(10, 13, '전화 예약 및 단체 예약 공지!', '알림 예약: 031-975-1911 전화예약은 오전에 부탁드립니다. 빵나오는 시간은 조금씩 달라질 수 있습니다.', 'https://project0254.s3.ap-northeast-2.amazonaws.com/image/notice/1704179800063_%EB%B8%8C%EB%9E%98%EB%93%9C%EC%95%A4%EB%B0%80%EA%B3%B5%EC%A7%80.jpg', '2024-01-02 16:16:40', 0);
/*!40000 ALTER TABLE `STORE_NOTICE` ENABLE KEYS */;

-- 테이블 testdb.test 구조 내보내기
CREATE TABLE IF NOT EXISTS `test` (
  `seqno` int(11) NOT NULL AUTO_INCREMENT,
  `content` text NOT NULL,
  `열 3` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`seqno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 테이블 데이터 testdb.test:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `test` DISABLE KEYS */;
INSERT INTO `test` (`seqno`, `content`, `열 3`) VALUES
	(1, '테스트1', NULL),
	(2, '테스트2', '2023-12-12 17:51:14'),
	(3, '테스트3', NULL),
	(4, '테스트4', NULL),
	(5, '테스트5', NULL),
	(6, '테스트6', NULL),
	(7, '테스트7', NULL),
	(8, '테스트8', NULL),
	(9, '테스트9', NULL),
	(10, '테스트', '2023-12-12 17:51:09'),
	(11, '테스트100', '2023-12-12 17:54:39');
/*!40000 ALTER TABLE `test` ENABLE KEYS */;

-- 트리거 testdb.alarm_box_member 구조 내보내기
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `alarm_box_member` AFTER INSERT ON `PUSH_ALARM` FOR EACH ROW BEGIN
INSERT into ALARM_BOX_MEMBER (alarm_box_push_alarm_id,alarm_box_member_id)
SELECT p.push_alarm_id, h.heart_member_id FROM PUSH_ALARM p JOIN HEART h ON (p.push_alarm_store_id = h.heart_store_id)  WHERE push_alarm_id= NEW.push_alarm_id;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- 트리거 testdb.MEMBER_REVIEW_insert 구조 내보내기
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `MEMBER_REVIEW_insert` AFTER INSERT ON `MEMBER_REVIEW` FOR EACH ROW BEGIN
	
	DECLARE store_id_value INT;
	
	SELECT payment_store_id INTO store_id_value
	FROM PAYMENT
	WHERE payment_seq = NEW.payment_seq;

	UPDATE STORE SET store_avg_score_number = (SELECT  ROUND(AVG(m.member_review_score_number),1) AS avg_score FROM MEMBER_REVIEW m LEFT JOIN PAYMENT p ON (m.payment_seq=p.payment_seq) GROUP BY p.payment_store_id)
	WHERE store_id = store_id_value;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- 트리거 testdb.member_update 구조 내보내기
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `member_update` AFTER INSERT ON `PAYMENT` FOR EACH ROW BEGIN
	
	DECLARE member_id_value VARCHAR(50);
	DECLARE member_count_value int;
	
	SELECT p.payment_member_id INTO member_id_value
	FROM PAYMENT p WHERE p.payment_status_id=5 AND p.payment_member_id= NEW.payment_member_id GROUP BY p.payment_member_id;
	
	SELECT COUNT(*)  INTO member_count_value 
	FROM PAYMENT p WHERE p.payment_status_id=5 AND p.payment_member_id= NEW.payment_member_id GROUP BY p.payment_member_id;
	
	IF member_count_value > 20 THEN
		UPDATE MEMBER SET member_tier = 2 WHERE member_id = member_id_value;
	ELSEIF member_count_value > 10 THEN
		UPDATE MEMBER SET member_tier = 1 WHERE member_id = member_id_value;
	END IF;
	
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- 트리거 testdb.mileage_update 구조 내보내기
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `mileage_update` BEFORE UPDATE ON `PAYMENT` FOR EACH ROW BEGIN
	IF NEW.payment_status_id = 4  THEN
	UPDATE MEMBER SET member_mileage = 
	(SELECT  m.member_mileage+ROUND(SUM(pp.payment_product_price-pp.payment_product_discount_price)*0.025)  
	FROM PAYMENT_PRODUCT pp JOIN PAYMENT p ON(p.payment_seq=pp.payment_product_payment_id) 
	JOIN MEMBER m ON(m.member_id=p.payment_member_id)
	WHERE pp.payment_product_payment_id= (NEW.payment_seq) GROUP BY pp.payment_product_payment_id)
	WHERE member_id = NEW.payment_member_id;
	END IF;

	
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- 트리거 testdb.payment_insert 구조 내보내기
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `payment_insert` BEFORE INSERT ON `PAYMENT` FOR EACH ROW BEGIN
	UPDATE MEMBER SET member_mileage = MEMBER.member_mileage - new.payment_mileage_price WHERE MEMBER.member_id= NEW.payment_member_id;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
