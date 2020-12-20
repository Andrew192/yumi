-- MySQL dump 10.13  Distrib 5.7.17, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: litemall
-- ------------------------------------------------------
-- Server version	5.7.21-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `litemall_ad`
--

DROP TABLE IF EXISTS `litemall_ad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `litemall_ad` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(63) NOT NULL DEFAULT '' COMMENT '광고 제목',
  `link` varchar(255) NOT NULL DEFAULT '' COMMENT '광고제품 이벤트 페이지 링크',
  `url` varchar(255) NOT NULL COMMENT '광고사진',
  `position` tinyint(3) DEFAULT '1' COMMENT '광고순위', /*1은 홈페이지*/
  `content` varchar(255) DEFAULT '' COMMENT '활동',
  `start_time` datetime DEFAULT NULL COMMENT '광고시작시간',
  `end_time` datetime DEFAULT NULL COMMENT '광고 종료 시간',
  `enabled` tinyint(1) DEFAULT '0' COMMENT '시작 여부',
  `add_time` datetime DEFAULT NULL COMMENT '생성 시간',
  `update_time` datetime DEFAULT NULL COMMENT '업데이트 시간',
  `deleted` tinyint(1) DEFAULT '0' COMMENT '휴지통', /*묘비라는데 맥락상 휴지통이 맞는듯*/
  PRIMARY KEY (`id`),
  KEY `enabled` (`enabled`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COMMENT='광고테이블';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `litemall_address`
--

DROP TABLE IF EXISTS `litemall_address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `litemall_address` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(63) NOT NULL DEFAULT '' COMMENT '수취인이름',
  `user_id` int(11) NOT NULL DEFAULT '0' COMMENT '사용자id',
  `province` varchar(63) NOT NULL COMMENT '구id',
  `city` varchar(63) NOT NULL COMMENT '도시id',
  `county` varchar(63) NOT NULL COMMENT '구역id', /*필요한가?*/
  `address_detail` varchar(127) NOT NULL DEFAULT '' COMMENT '상세주소',
  `area_code` char(6) DEFAULT NULL COMMENT '지역코드', /*필요한가?*/
  `postal_code` char(6) DEFAULT NULL COMMENT '우편번호',
  `tel` varchar(20) NOT NULL DEFAULT '' COMMENT '전화번호',
  `is_default` tinyint(1) NOT NULL DEFAULT '0' COMMENT '기본주소',
  `add_time` datetime DEFAULT NULL COMMENT '생성시간',
  `update_time` datetime DEFAULT NULL COMMENT '업데이트시간',
  `deleted` tinyint(1) DEFAULT '0' COMMENT '휴지통',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COMMENT='주소테이블';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `litemall_admin`
--

DROP TABLE IF EXISTS `litemall_admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `litemall_admin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(63) NOT NULL DEFAULT '' COMMENT '관리자이름',
  `password` varchar(63) NOT NULL DEFAULT '' COMMENT '관리자비밀번호',
  `last_login_ip` varchar(63) DEFAULT '' COMMENT '최근로그인ip',
  `last_login_time` datetime DEFAULT NULL COMMENT '최근로그인시간',
  `avatar` varchar(255) DEFAULT '''' COMMENT '프로필사진',
  `add_time` datetime DEFAULT NULL COMMENT '생성시간',
  `update_time` datetime DEFAULT NULL COMMENT '업데이트시간',
  `deleted` tinyint(1) DEFAULT '0' COMMENT '휴지통',
  `role_ids` varchar(127) DEFAULT '[]' COMMENT '역할목록',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COMMENT='관리자테이블';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `litemall_aftersale`
--

DROP TABLE IF EXISTS `litemall_aftersale`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `litemall_aftersale` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `aftersale_sn` varchar(63) DEFAULT NULL COMMENT '판매번호',
  `order_id` int(11) NOT NULL COMMENT '주문id',
  `user_id` int(11) NOT NULL COMMENT '사용자id',
  `type` smallint(6) DEFAULT '0' COMMENT '판매후유형0:미수령상품 환불, 1:수령된 상품에 대한 환불(반품필요x), 2:사용자 반품에 대한 환불', /*0:미수령상품 환불, 1:수령된 상품에 대한 환불(반품필요x), 2:사용자 반품에 대한 환불*/
  `reason` varchar(31) DEFAULT '' COMMENT '반품사유',
  `amount` decimal(10,2) DEFAULT '0.00' COMMENT '환불금액',
  `pictures` varchar(1023) DEFAULT '[]' COMMENT '환불 바우처 이미지 링크 어레이',
  `comment` varchar(511) DEFAULT '' COMMENT '환불지침',
  `status` smallint(6) DEFAULT '0' COMMENT '판매 후 상태0:적용가능, 1:사용자신청, 2:관리자 승인, 3:환불, 4:검토 거부, 5:사용자 취소' /*0:적용가능, 1:사용자신청, 2:관리자 승인, 3:환불, 4:검토 거부, 5:사용자 취소*/,
  `handle_time` datetime DEFAULT NULL COMMENT '운영시간',
  `add_time` datetime DEFAULT NULL COMMENT '생성시간',
  `update_time` datetime DEFAULT NULL COMMENT '업데이트시간',
  `deleted` tinyint(1) DEFAULT '0' COMMENT '판매번호',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COMMENT='판매후테이블';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `litemall_brand`
--

DROP TABLE IF EXISTS `litemall_brand`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `litemall_brand` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT '브랜드명',
  `desc` varchar(255) NOT NULL DEFAULT '' COMMENT '브랜드소개',
  `pic_url` varchar(255) NOT NULL DEFAULT '' COMMENT '브랜드이미지',
  `sort_order` tinyint(3) DEFAULT '50',
  `floor_price` decimal(10,2) DEFAULT '0.00' COMMENT '브랜드 제품은 가격이 저렴하고 페이지 표시에만 사용됩니다.',
  `add_time` datetime DEFAULT NULL COMMENT '생성시간',
  `update_time` datetime DEFAULT NULL COMMENT '업데이트시간',
  `deleted` tinyint(1) DEFAULT '0' COMMENT '휴지통',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1046003 DEFAULT CHARSET=utf8mb4 COMMENT='브랜드테이블';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `litemall_cart`
--

DROP TABLE IF EXISTS `litemall_cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `litemall_cart` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL COMMENT '사용자id',
  `goods_id` int(11) DEFAULT NULL COMMENT '상품id',
  `goods_sn` varchar(63) DEFAULT NULL COMMENT '제품번호',
  `goods_name` varchar(127) DEFAULT NULL COMMENT '상품명',
  `product_id` int(11) DEFAULT NULL COMMENT '상품id',
  `price` decimal(10,2) DEFAULT '0.00' COMMENT '상품가격',
  `number` smallint(5) DEFAULT '0' COMMENT '상품수량',
  `specifications` varchar(1023) DEFAULT NULL COMMENT '제품사양값(JSON 배열)',
  `checked` tinyint(1) DEFAULT '1' COMMENT '장바구니내 상품선택여부',
  `pic_url` varchar(255) DEFAULT NULL COMMENT '상품이미지',
  `add_time` datetime DEFAULT NULL COMMENT '생성시간',
  `update_time` datetime DEFAULT NULL COMMENT '업데이트시간',
  `deleted` tinyint(1) DEFAULT '0' COMMENT '휴지통',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COMMENT='장바구니테이블';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `litemall_category`
--

DROP TABLE IF EXISTS `litemall_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `litemall_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(63) NOT NULL DEFAULT '' COMMENT '카테고리 이름',
  `keywords` varchar(1023) NOT NULL DEFAULT '' COMMENT '카테고리키워드(JSON 배열)',
  `desc` varchar(255) DEFAULT '' COMMENT '카테고리 슬로건 소개',
  `pid` int(11) NOT NULL DEFAULT '0' COMMENT '상위카테고리ID',
  `icon_url` varchar(255) DEFAULT '' COMMENT '카테고리아이콘',
  `pic_url` varchar(255) DEFAULT '' COMMENT '카테고리사진',
  `level` varchar(255) DEFAULT 'L1',
  `sort_order` tinyint(3) DEFAULT '50' COMMENT '종류',
  `add_time` datetime DEFAULT NULL COMMENT '생성시간',
  `update_time` datetime DEFAULT NULL COMMENT '업데이트시간',
  `deleted` tinyint(1) DEFAULT '0' COMMENT '휴지통',
  PRIMARY KEY (`id`),
  KEY `parent_id` (`pid`)
) ENGINE=InnoDB AUTO_INCREMENT=1036007 DEFAULT CHARSET=utf8mb4 COMMENT='카테고리테이블';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `litemall_collect`
--

DROP TABLE IF EXISTS `litemall_collect`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `litemall_collect` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL DEFAULT '0' COMMENT '사용자id',
  `value_id` int(11) NOT NULL DEFAULT '0' COMMENT 'type = 0:제품 ID, type = 1:토픽 ID',
  `type` tinyint(3) NOT NULL DEFAULT '0' COMMENT '컬렉션 유형 0:제품id, 1:토픽 id',
  `add_time` datetime DEFAULT NULL COMMENT '생성시간',
  `update_time` datetime DEFAULT NULL COMMENT '업데이트시간',
  `deleted` tinyint(1) DEFAULT '0' COMMENT '휴지통',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `goods_id` (`value_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='컬렉션테이블';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `litemall_comment`
--

DROP TABLE IF EXISTS `litemall_comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `litemall_comment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `value_id` int(11) NOT NULL DEFAULT '0' COMMENT 'type = 0:상품평, type = 1:특별 코멘트',
  `type` tinyint(3) NOT NULL DEFAULT '0' COMMENT 'Comment type, type = 0:상품설명, type = 1:특별 설명',
  `content` varchar(1023) DEFAULT '' COMMENT '코멘트내용',
  `admin_content` varchar(511) DEFAULT '' COMMENT '관리자코멘트내용',
  `user_id` int(11) NOT NULL DEFAULT '0' COMMENT '사용자id',
  `has_picture` tinyint(1) DEFAULT '0' COMMENT '사진포함여부',
  `pic_urls` varchar(1023) DEFAULT NULL COMMENT '사진주소목록(JSON 배열)',
  `star` smallint(6) DEFAULT '1' COMMENT '별점 1-5',
  `add_time` datetime DEFAULT NULL COMMENT '생성시간',
  `update_time` datetime DEFAULT NULL COMMENT '업데이트시간',
  `deleted` tinyint(1) DEFAULT '0' COMMENT '휴지통',
  PRIMARY KEY (`id`),
  KEY `id_value` (`value_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1012 DEFAULT CHARSET=utf8mb4 COMMENT='댓글양식테이블';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `litemall_coupon`
--

DROP TABLE IF EXISTS `litemall_coupon`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `litemall_coupon` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(63) NOT NULL COMMENT '쿠폰이름',
  `desc` varchar(127) DEFAULT '' COMMENT '일반적으로 쿠폰의 제한 텍스트를 보여주는 쿠폰 소개',
  `tag` varchar(63) DEFAULT '' COMMENT '신규 유저를 위한 쿠폰 라벨',
  `total` int(11) NOT NULL DEFAULT '0' COMMENT '쿠폰수, 0이면 무제한',
  `discount` decimal(10,2) DEFAULT '0.00' COMMENT '할인가격',
  `min` decimal(10,2) DEFAULT '0.00' COMMENT '최소 소비량',
  `limit` smallint(6) DEFAULT '1' COMMENT '쿠폰수 제한 0:제한없음, default:1',
  `type` smallint(6) DEFAULT '0' COMMENT '쿠폰선물유형 0:범용쿠폰, 1:등록쿠폰, 2:쿠폰 코드',
  `status` smallint(6) DEFAULT '0' COMMENT '쿠폰상태 0:사용가능, 1:만료, 2:제거',
  `goods_type` smallint(6) DEFAULT '0' COMMENT '상품제한유형 0:모든상품, 1:카테고리제한, 2:상품제한',
  `goods_value` varchar(1023) DEFAULT '[]' COMMENT '상품한도값 0:빈 컬렉션, 1: 카테고리 컬렉션, 2: 상품 컬렉션',
  `code` varchar(63) DEFAULT NULL COMMENT '쿠폰코드',
  `time_type` smallint(6) DEFAULT '0' COMMENT '유효시간 0:수집시간 유효일수 기준, 1:start time과 end time 정해져있음',
  `days` smallint(6) DEFAULT '0' COMMENT '수집시간 유효일',
  `start_time` datetime DEFAULT NULL COMMENT '시작시간',
  `end_time` datetime DEFAULT NULL COMMENT '만료시간',
  `add_time` datetime DEFAULT NULL COMMENT '생성시간',
  `update_time` datetime DEFAULT NULL COMMENT '업데이트시간',
  `deleted` tinyint(1) DEFAULT '0' COMMENT '휴지통',
  PRIMARY KEY (`id`),
  KEY `code` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COMMENT='쿠폰정보,규정테이블';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `litemall_coupon_user`
--

DROP TABLE IF EXISTS `litemall_coupon_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `litemall_coupon_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL COMMENT '사용자id',
  `coupon_id` int(11) NOT NULL COMMENT '쿠폰ID',
  `status` smallint(6) DEFAULT '0' COMMENT '상태 0:미사용, 1:사용완료, 2:만료, 3:제거',
  `used_time` datetime DEFAULT NULL COMMENT '사용시간',
  `start_time` datetime DEFAULT NULL COMMENT '시작시간',
  `end_time` datetime DEFAULT NULL COMMENT '만료시간',
  `order_id` int(11) DEFAULT NULL COMMENT '주문id',
  `add_time` datetime DEFAULT NULL COMMENT '생성시간',
  `update_time` datetime DEFAULT NULL COMMENT '업데이트시간',
  `deleted` tinyint(1) DEFAULT '0' COMMENT '휴지통',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COMMENT='쿠폰사용자사용양식테이블';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `litemall_feedback`
--

DROP TABLE IF EXISTS `litemall_feedback`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `litemall_feedback` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL DEFAULT '0' COMMENT '사용자id',
  `username` varchar(63) NOT NULL DEFAULT '' COMMENT '사용자이름',
  `mobile` varchar(20) NOT NULL DEFAULT '' COMMENT '전화번호',
  `feed_type` varchar(63) NOT NULL DEFAULT '' COMMENT '피드백유형',
  `content` varchar(1023) NOT NULL COMMENT '피드백내용',
  `status` int(3) NOT NULL DEFAULT '0' COMMENT '상태',
  `has_picture` tinyint(1) DEFAULT '0' COMMENT '사진포함유무',
  `pic_urls` varchar(1023) DEFAULT NULL COMMENT '사진주소목록(JSON 배열)',
  `add_time` datetime DEFAULT NULL COMMENT '생성시간',
  `update_time` datetime DEFAULT NULL COMMENT '업데이트시간',
  `deleted` tinyint(1) DEFAULT '0' COMMENT '휴지통',
  PRIMARY KEY (`id`),
  KEY `id_value` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='피드백 폼';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `litemall_footprint`
--

DROP TABLE IF EXISTS `litemall_footprint`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `litemall_footprint` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL DEFAULT '0' COMMENT '사용자id',
  `goods_id` int(11) NOT NULL DEFAULT '0' COMMENT '상품id',
  `add_time` datetime DEFAULT NULL COMMENT '생성시간',
  `update_time` datetime DEFAULT NULL COMMENT '업데이트시간',
  `deleted` tinyint(1) DEFAULT '0' COMMENT '휴지통',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='사용자검색기록테이블';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `litemall_goods`
--

DROP TABLE IF EXISTS `litemall_goods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `litemall_goods` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `goods_sn` varchar(63) NOT NULL DEFAULT '' COMMENT '상품번호',
  `name` varchar(127) NOT NULL DEFAULT '' COMMENT '상품명',
  `category_id` int(11) DEFAULT '0' COMMENT '카테고리id',
  `brand_id` int(11) DEFAULT '0',
  `gallery` varchar(1023) DEFAULT NULL COMMENT '제품홍보사진목록 (JSON 배열)',
  `keywords` varchar(255) DEFAULT '' COMMENT '제품 키워드 (쉼표 구분)',
  `brief` varchar(255) DEFAULT '' COMMENT '제품 설명',
  `is_on_sale` tinyint(1) DEFAULT '1' COMMENT '할인 중',
  `sort_order` smallint(4) DEFAULT '100',
  `pic_url` varchar(255) DEFAULT NULL COMMENT '상품 이미지 URL',
  `share_url` varchar(255) DEFAULT NULL COMMENT '공유 URL',
  `is_new` tinyint(1) DEFAULT '0' COMMENT '신제품 출시 여부, 설정시 출시 페이지에 표시 가능',
  `is_hot` tinyint(1) DEFAULT '0' COMMENT '인기도 추천, 설정시 인기 페이지에 표시 가능',
  `unit` varchar(31) DEFAULT '조각' COMMENT '조각, 단품 단위',
  `counter_price` decimal(10,2) DEFAULT '0.00' COMMENT '카운터가격',
  `retail_price` decimal(10,2) DEFAULT '100000.00' COMMENT '소매가',
  `detail` text COMMENT '상세설명',
  `add_time` datetime DEFAULT NULL COMMENT '생성시간',
  `update_time` datetime DEFAULT NULL COMMENT '업데이트시간',
  `deleted` tinyint(1) DEFAULT '0' COMMENT '휴지통',
  PRIMARY KEY (`id`),
  KEY `goods_sn` (`goods_sn`),
  KEY `cat_id` (`category_id`),
  KEY `brand_id` (`brand_id`),
  KEY `sort_order` (`sort_order`)
) ENGINE=InnoDB AUTO_INCREMENT=1181004 DEFAULT CHARSET=utf8mb4 COMMENT='상품정보테이블';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `litemall_goods_attribute`
--



DROP TABLE IF EXISTS `litemall_goods_attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `litemall_goods_attribute` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `goods_id` int(11) NOT NULL DEFAULT '0' COMMENT '상품id',
  `attribute` varchar(255) NOT NULL COMMENT '상품속성이름',
  `value` varchar(255) NOT NULL COMMENT '상품속성값',
  `add_time` datetime DEFAULT NULL COMMENT '생성시간',
  `update_time` datetime DEFAULT NULL COMMENT '업데이트시간',
  `deleted` tinyint(1) DEFAULT '0' COMMENT '휴지통',
  PRIMARY KEY (`id`),
  KEY `goods_id` (`goods_id`)
) ENGINE=InnoDB AUTO_INCREMENT=877 DEFAULT CHARSET=utf8mb4 COMMENT='상품속성테이블';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `litemall_goods_product`
--

DROP TABLE IF EXISTS `litemall_goods_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `litemall_goods_product` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `goods_id` int(11) NOT NULL DEFAULT '0' COMMENT '상품id',
  `specifications` varchar(1023) NOT NULL COMMENT '제품사양값목록(JSON 형식)',
  `price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '상품가격',
  `number` int(11) NOT NULL DEFAULT '0' COMMENT '상품수량',
  `url` varchar(125) DEFAULT NULL COMMENT '상품사진',
  `add_time` datetime DEFAULT NULL COMMENT '생성시간',
  `update_time` datetime DEFAULT NULL COMMENT '업데이트시간',
  `deleted` tinyint(1) DEFAULT '0' COMMENT '휴지통',
  PRIMARY KEY (`id`),
  KEY `goods_id` (`goods_id`)
) ENGINE=InnoDB AUTO_INCREMENT=251 DEFAULT CHARSET=utf8mb4 COMMENT='상품목록테이블';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `litemall_goods_specification`
--

DROP TABLE IF EXISTS `litemall_goods_specification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `litemall_goods_specification` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `goods_id` int(11) NOT NULL DEFAULT '0' COMMENT '상품id',
  `specification` varchar(255) NOT NULL DEFAULT '' COMMENT '제품사향이름',
  `value` varchar(255) NOT NULL DEFAULT '' COMMENT '제품사양값',
  `pic_url` varchar(255) NOT NULL DEFAULT '' COMMENT '제품사양사진',
  `add_time` datetime DEFAULT NULL COMMENT '생성시간',
  `update_time` datetime DEFAULT NULL COMMENT '업데이트시간',
  `deleted` tinyint(1) DEFAULT '0' COMMENT '휴지통',
  PRIMARY KEY (`id`),
  KEY `goods_id` (`goods_id`)
) ENGINE=InnoDB AUTO_INCREMENT=250 DEFAULT CHARSET=utf8mb4 COMMENT='제품사양테이블';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `litemall_groupon`
--

DROP TABLE IF EXISTS `litemall_groupon`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `litemall_groupon` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) NOT NULL COMMENT '주문id',
  `groupon_id` int(11) DEFAULT '0' COMMENT '그룹id, 0:그룹사용자',
  `rules_id` int(11) NOT NULL COMMENT '그룹구매규칙id',
  `user_id` int(11) NOT NULL COMMENT '사용자id',
  `share_url` varchar(255) DEFAULT NULL COMMENT '그룹 구매 공유 사진 주소',
  `creator_user_id` int(11) NOT NULL COMMENT '그룹사용자id',
  `creator_user_time` datetime DEFAULT NULL COMMENT '개장시간',
  `status` smallint(6) DEFAULT '0' COMMENT '그룹구매활동상태, 0:그룹x, 1:그룹개설, 2:그룹실패',
  `add_time` datetime DEFAULT NULL COMMENT '생성시간',
  `update_time` datetime DEFAULT NULL COMMENT '업데이트시간',
  `deleted` tinyint(1) DEFAULT '0' COMMENT '휴지통',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='그룹구매활동테이블';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `litemall_groupon_rules`
--

DROP TABLE IF EXISTS `litemall_groupon_rules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `litemall_groupon_rules` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `goods_id` int(11) NOT NULL COMMENT '상품id',
  `goods_name` varchar(127) NOT NULL COMMENT '상품명',
  `pic_url` varchar(255) DEFAULT NULL COMMENT '상품이미지',
  `discount` decimal(63,0) NOT NULL COMMENT '할인가격',
  `discount_member` int(11) NOT NULL COMMENT '할인조건충족멤버수',
  `expire_time` datetime DEFAULT NULL COMMENT '그룹구매만료시간',
  `status` smallint(6) DEFAULT '0' COMMENT '그룹 구매 규칙 상태, 0:일반, 1:만료시 자동오프라인, 2:관리 수동오프라인',
  `add_time` datetime DEFAULT NULL COMMENT '생성시간',
  `update_time` datetime DEFAULT NULL COMMENT '업데이트시간',
  `deleted` tinyint(1) DEFAULT '0' COMMENT '휴지통',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `goods_id` (`goods_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='그룹구매규칙테이블';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `litemall_issue`
--

DROP TABLE IF EXISTS `litemall_issue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `litemall_issue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `question` varchar(255) DEFAULT NULL COMMENT '질문제목',
  `answer` varchar(255) DEFAULT NULL COMMENT '답변',
  `add_time` datetime DEFAULT NULL COMMENT '생성시간',
  `update_time` datetime DEFAULT NULL COMMENT '업데이트시간',
  `deleted` tinyint(1) DEFAULT '0' COMMENT '휴지통',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COMMENT='자주묻는질문';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `litemall_keyword`
--

DROP TABLE IF EXISTS `litemall_keyword`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `litemall_keyword` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `keyword` varchar(127) NOT NULL DEFAULT '' COMMENT '키워드',
  `url` varchar(255) NOT NULL DEFAULT '' COMMENT '키워드 이동 링크',
  `is_hot` tinyint(1) NOT NULL DEFAULT '0' COMMENT '인기 키워드 여부',
  `is_default` tinyint(1) NOT NULL DEFAULT '0' COMMENT '기본 키워드 여부',
  `sort_order` int(11) NOT NULL DEFAULT '100' COMMENT '종류',
  `add_time` datetime DEFAULT NULL COMMENT '생성시간',
  `update_time` datetime DEFAULT NULL COMMENT '업데이트시간',
  `deleted` tinyint(1) DEFAULT '0' COMMENT '휴지통',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COMMENT='키워드 테이블';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `litemall_log`
--

DROP TABLE IF EXISTS `litemall_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `litemall_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `admin` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '관리자',
  `ip` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '관리자 주소',
  `type` int(11) DEFAULT NULL COMMENT '작동 분류',
  `action` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '동작',
  `status` tinyint(1) DEFAULT NULL COMMENT '작동 상태',
  `result` varchar(127) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '작업결과, 성공 메시지, 실패 메시지',
  `comment` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '추가 정보',
  `add_time` datetime DEFAULT NULL COMMENT '생성시간',
  `update_time` datetime DEFAULT NULL COMMENT '업데이트시간',
  `deleted` tinyint(1) DEFAULT '0' COMMENT '휴지통',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='작업로그테이블';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `litemall_notice`
--

DROP TABLE IF EXISTS `litemall_notice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `litemall_notice` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(63) DEFAULT NULL COMMENT '알림제목',
  `content` varchar(511) DEFAULT NULL COMMENT '알림내용',
  `admin_id` int(11) DEFAULT '0' COMMENT '알림 관리자 id, 시스템 내장 알림일시 0',
  `add_time` datetime DEFAULT NULL COMMENT '생성시간',
  `update_time` datetime DEFAULT NULL COMMENT '업데이트시간',
  `deleted` tinyint(1) DEFAULT '0' COMMENT '휴지통',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COMMENT='알림테이블';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `litemall_notice_admin`
--

DROP TABLE IF EXISTS `litemall_notice_admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `litemall_notice_admin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `notice_id` int(11) DEFAULT NULL COMMENT '알림id',
  `notice_title` varchar(63) DEFAULT NULL COMMENT '알림제목',
  `admin_id` int(11) DEFAULT NULL COMMENT '알림 관리자 id',
  `read_time` datetime DEFAULT NULL COMMENT '읽은 시간, null:읽지않음',
  `add_time` datetime DEFAULT NULL COMMENT '생성시간',
  `update_time` datetime DEFAULT NULL COMMENT '업데이트시간',
  `deleted` tinyint(1) DEFAULT '0' COMMENT '휴지통',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COMMENT='관리자알림테이블';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `litemall_order`
--

DROP TABLE IF EXISTS `litemall_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `litemall_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL COMMENT '사용자id',
  `order_sn` varchar(63) NOT NULL COMMENT '주문번호',
  `order_status` smallint(6) NOT NULL COMMENT '주문상태',
  `aftersale_status` smallint(6) DEFAULT '0' COMMENT '판매후상태 0:적용가능, 1:사용자신청, 2:관리자 승인, 3:환불, 4:검토 거부, 5:사용자 취소',
  `consignee` varchar(63) NOT NULL COMMENT '수취인',
  `mobile` varchar(63) NOT NULL COMMENT '수취인전화번호',
  `address` varchar(127) NOT NULL COMMENT '주소받기',
  `message` varchar(512) NOT NULL DEFAULT '' COMMENT '사용자주문메시지',
  `goods_price` decimal(10,2) NOT NULL COMMENT '총제품비용',
  `freight_price` decimal(10,2) NOT NULL COMMENT '배송료',
  `coupon_price` decimal(10,2) NOT NULL COMMENT '쿠폰변형',
  `integral_price` decimal(10,2) NOT NULL COMMENT '사용자포인트감소',
  `groupon_price` decimal(10,2) NOT NULL COMMENT '단체구매할인',
  `order_price` decimal(10,2) NOT NULL COMMENT '주문비용 = goods_price + freight_price - coupon_price',
  `actual_price` decimal(10,2) NOT NULL COMMENT '본인부담금 = order_price - integral_price',
  `pay_id` varchar(63) DEFAULT NULL COMMENT 'wechat 결제번호',
  `pay_time` datetime DEFAULT NULL COMMENT 'wechat 결제시간',
  `ship_sn` varchar(63) DEFAULT NULL COMMENT '운송 번호',
  `ship_channel` varchar(63) DEFAULT NULL COMMENT '배송 택배 회사',
  `ship_time` datetime DEFAULT NULL COMMENT '배송 시작 시간',
  `refund_amount` decimal(10,2) DEFAULT NULL COMMENT '실제 환불 금액',
  `refund_type` varchar(63) DEFAULT NULL COMMENT '환불 방법',
  `refund_content` varchar(127) DEFAULT NULL COMMENT '환불 내용',
  `refund_time` datetime DEFAULT NULL COMMENT '환불 시간',
  `confirm_time` datetime DEFAULT NULL COMMENT '확인 시간',
  `comments` smallint(6) DEFAULT '0' COMMENT '평가 주문 항목 수량',
  `end_time` datetime DEFAULT NULL COMMENT '주문 마감 시간',
  `add_time` datetime DEFAULT NULL COMMENT '생성시간',
  `update_time` datetime DEFAULT NULL COMMENT '업데이트시간',
  `deleted` tinyint(1) DEFAULT '0' COMMENT '휴지통',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='주문테이블';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `litemall_order_goods`
--

DROP TABLE IF EXISTS `litemall_order_goods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `litemall_order_goods` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) NOT NULL DEFAULT '0' COMMENT '주문id',
  `goods_id` int(11) NOT NULL DEFAULT '0' COMMENT '상품id',
  `goods_name` varchar(127) NOT NULL DEFAULT '' COMMENT '상품명',
  `goods_sn` varchar(63) NOT NULL DEFAULT '' COMMENT '제품 번호',
  `product_id` int(11) NOT NULL DEFAULT '0' COMMENT '상품항목id',
  `number` smallint(5) NOT NULL DEFAULT '0' COMMENT '상품수량',
  `price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '상품가격',
  `specifications` varchar(1023) NOT NULL COMMENT '제품사양목록',
  `pic_url` varchar(255) NOT NULL DEFAULT '' COMMENT '제품이미지',
  `comment` int(11) DEFAULT '0' COMMENT '주문상품코멘트, -1:만료후 평가 불가, 0:평가가능, 이외의값:comment id',
  `add_time` datetime DEFAULT NULL COMMENT '생성시간',
  `update_time` datetime DEFAULT NULL COMMENT '업데이트시간',
  `deleted` tinyint(1) DEFAULT '0' COMMENT '휴지통',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  KEY `goods_id` (`goods_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='주문항목테이블';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `litemall_permission`
--

DROP TABLE IF EXISTS `litemall_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `litemall_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_id` int(11) DEFAULT NULL COMMENT '역할id',
  `permission` varchar(63) DEFAULT NULL COMMENT '권한',
  `add_time` datetime DEFAULT NULL COMMENT '생성시간',
  `update_time` datetime DEFAULT NULL COMMENT '업데이트시간',
  `deleted` tinyint(1) DEFAULT '0' COMMENT '휴지통',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COMMENT='권한테이블';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `litemall_region`
--

DROP TABLE IF EXISTS `litemall_region`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `litemall_region` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) NOT NULL DEFAULT '0' COMMENT '행정구역 상위 id(구/군 : 시, 도시 : 도, 지방 : 0',
  `name` varchar(120) NOT NULL DEFAULT '' COMMENT '행정구역 이름',
  `type` tinyint(3) NOT NULL DEFAULT '0' COMMENT '행정구역 유형(1:도, 2:도시, 3:구)',
  `code` int(11) NOT NULL DEFAULT '0' COMMENT '행정구역 번호',
  PRIMARY KEY (`id`),
  KEY `parent_id` (`pid`),
  KEY `region_type` (`type`),
  KEY `agency_id` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=3232 DEFAULT CHARSET=utf8mb4 COMMENT='행정구역테이블';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `litemall_role`
--

DROP TABLE IF EXISTS `litemall_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `litemall_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(63) NOT NULL COMMENT '역할 이름',
  `desc` varchar(1023) DEFAULT NULL COMMENT '역할 설명',
  `enabled` tinyint(1) DEFAULT '1' COMMENT '활성화 여부',
  `add_time` datetime DEFAULT NULL COMMENT '생성시간',
  `update_time` datetime DEFAULT NULL COMMENT '업데이트시간',
  `deleted` tinyint(1) DEFAULT '0' COMMENT '휴지통',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COMMENT='역할테이블';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `litemall_search_history`
--

DROP TABLE IF EXISTS `litemall_search_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `litemall_search_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL COMMENT '사용자id',
  `keyword` varchar(63) NOT NULL COMMENT '키워드 검색',
  `from` varchar(63) NOT NULL DEFAULT '' COMMENT 'pc,wx,app과 같은 검색소스',
  `add_time` datetime DEFAULT NULL COMMENT '생성시간',
  `update_time` datetime DEFAULT NULL COMMENT '업데이트시간',
  `deleted` tinyint(1) DEFAULT '0' COMMENT '휴지통',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='검색내역테이블';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `litemall_storage`
--

DROP TABLE IF EXISTS `litemall_storage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `litemall_storage` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `key` varchar(63) NOT NULL COMMENT '파일의 고유 색인',
  `name` varchar(255) NOT NULL COMMENT '파일 이름',
  `type` varchar(20) NOT NULL COMMENT '파일 유형',
  `size` int(11) NOT NULL COMMENT '파일 크기',
  `url` varchar(255) DEFAULT NULL COMMENT '파일 액세스 링크',
  `add_time` datetime DEFAULT NULL COMMENT '생성시간',
  `update_time` datetime DEFAULT NULL COMMENT '업데이트시간',
  `deleted` tinyint(1) DEFAULT '0' COMMENT '휴지통',
  PRIMARY KEY (`id`),
  KEY `key` (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='파일저장테이블';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `litemall_system`
--

DROP TABLE IF EXISTS `litemall_system`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `litemall_system` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `key_name` varchar(255) NOT NULL COMMENT '시스템구성이름',
  `key_value` varchar(255) NOT NULL COMMENT '시스템구성값',
  `add_time` datetime DEFAULT NULL COMMENT '생성시간',
  `update_time` datetime DEFAULT NULL COMMENT '업데이트시간',
  `deleted` tinyint(1) DEFAULT '0' COMMENT '휴지통',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='시스템구성테이블';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `litemall_topic`
--

DROP TABLE IF EXISTS `litemall_topic`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `litemall_topic` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL DEFAULT '''' COMMENT '토픽이름',
  `subtitle` varchar(255) DEFAULT '''' COMMENT '토픽부제',
  `content` text COMMENT '주제별 컨텐츠 (텍스트 형식)',
  `price` decimal(10,2) DEFAULT '0.00' COMMENT '관련 상품 최저가',
  `read_count` varchar(255) DEFAULT '1k' COMMENT '토픽별 읽기',
  `pic_url` varchar(255) DEFAULT '' COMMENT '토픽별 사진',
  `sort_order` int(11) DEFAULT '100' COMMENT '종류',
  `goods` varchar(1023) DEFAULT '' COMMENT '토픽 관련 제품 (JSON 형식)',
  `add_time` datetime DEFAULT NULL COMMENT '생성시간',
  `update_time` datetime DEFAULT NULL COMMENT '업데이트시간',
  `deleted` tinyint(1) DEFAULT '0' COMMENT '휴지통',
  PRIMARY KEY (`id`),
  KEY `topic_id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=319 DEFAULT CHARSET=utf8mb4 COMMENT='토픽테이블';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `litemall_user`
--

DROP TABLE IF EXISTS `litemall_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `litemall_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(63) NOT NULL COMMENT '사용자이름',
  `password` varchar(63) NOT NULL DEFAULT '' COMMENT '패스워드',
  `gender` tinyint(3) NOT NULL DEFAULT '0' COMMENT '성별, 0:알수없음, 1:남성 혹은 여성',
  `birthday` date DEFAULT NULL COMMENT '생일',
  `last_login_time` datetime DEFAULT NULL COMMENT '최근로그인시간',
  `last_login_ip` varchar(63) NOT NULL DEFAULT '' COMMENT '최근로그인IP',
  `user_level` tinyint(3) DEFAULT '0' COMMENT '0:일반 사용자, 1:VIP 사용자, 2:최고VIP 사용자',
  `nickname` varchar(63) NOT NULL DEFAULT '' COMMENT '닉네임 혹은 네트워크 이름',
  `mobile` varchar(20) NOT NULL DEFAULT '' COMMENT '전화번호',
  `avatar` varchar(255) NOT NULL DEFAULT '' COMMENT '프로필사진',
  `weixin_openid` varchar(63) NOT NULL DEFAULT '' COMMENT 'wechat로그인 openid',
  `session_key` varchar(100) NOT NULL DEFAULT '' COMMENT 'wechat로그인 세션 키',
  `status` tinyint(3) NOT NULL DEFAULT '0' COMMENT '0:사용가능, 1:비활성화, 2:로그아웃',
  `add_time` datetime DEFAULT NULL COMMENT '생성시간',
  `update_time` datetime DEFAULT NULL COMMENT '업데이트시간',
  `deleted` tinyint(1) DEFAULT '0' COMMENT '휴지통',
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_name` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COMMENT='사용자테이블';
/*!40101 SET character_set_client = @saved_cs_client */;

/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-12-16 23:12:57
