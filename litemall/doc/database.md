# 데이터베이스

litemall 데이터베이스는 nideshop의 [nideshop.sql] (https://github.com/tumobi/nideshop/blob/master/nideshop.sql) 데이터베이스를 기반으로합니다.
그런 다음 실제 개발 과정에서 조정 및 수정되었습니다.

* 일부 불필요한 테이블을 삭제했습니다.
* 테이블에서 불필요한 필드를 삭제하십시오.
* 행정 구역 데이터 litemall_region은 원래 nideshop의 데이터를 사용하지 않지만 [중국 행정 구역] (https://github.com/modood/Administrative-divisions-of-China)을 사용합니다.
* 테이블의 일부 필드는 JSON으로 저장됩니다.
* 테이블의 날짜 또는 시간 필드는 DATE, DATETIME을 사용합니다.
* 필드의 데이터 유형은 MEDIUMINT를 피하지만 INT와 같이 대략적으로 구성됩니다.
* 표의 데이터는 정리, 조정 및 보완되었습니다 (가짜 데이터).

litemall 데이터베이스는 litemall-db 폴더 아래의 sql 폴더에있는 세 개의 sql 파일로 구성됩니다.

1. litemall_schema.sql
  
   역할은 빈 데이터베이스를 만들고 사용자를 만들고 액세스 권한을 설정하는 것입니다.
   
   개발자는 개발 및 테스트 단계에서 사용할 수 있지만 배포 및 프로덕션 단계에서 여기에서 기본 사용자 이름과 암호를 수정하는 데주의를 기울여야합니다.

   여기에있는 sql 파일을 반드시 실행할 필요는 없으며 개발자는 수동으로 또는 명령 줄 또는 IDE를 사용하여 해당 작업을 수행 할 수 있습니다.
   
2. litemall_table.sql

   역할은 데이터베이스 테이블을 생성하는 것이지만 데이터는 생성되지 않습니다.
   
   따라서 개발자는 배포 및 프로덕션 단계에서 직접 사용할 수 있습니다.
 
3. litemall_data.sql

   역할은 테스트 데이터를 만드는 것입니다.
      
   개발자는 개발 및 테스트 중에 사용할 수 있지만 배포 및 개발 중에 자신의 데이터를 사용해야합니다.

요약하면 여기서 litemall이 실제로 실행해야하는 sql 파일은 litemall_table.sql이며 다른 두 sql 파일의 개발자는이 파일을 사용할지 여부를 결정합니다.

## 1 데이터 테이블 구조

### 1.1 사용자 관련

! [] (./ pics / database / user.png)

### 1.2 상품 관련

! [] (./ pics / database / goods.png)

### 1.3 주문 관련

! [] (./ pics / database / order.png)

### 1.4 기타

! [] (./ pics / database / others.png)

## 2 데이터 시트 디자인

다음으로 데이터 시트의 몇 가지 주요 세부 사항에 대해 설명합니다.

### 2.1 상품 및 제품 디자인

상품 테이블 (litemall_goods), 상품 속성 테이블 (litemall_goods_attribute), 상품 사양 테이블 (litemall_goods_specification), 상품 테이블 (litemall_goods_product)의 4 가지 유형이 있습니다.

상품 테이블은 상품 소개, 상품 사진, 상품 카테고리, 상품 브랜드 판매자 등을 포함한 상품의 기본 정보입니다.

상품 매개 변수 테이블은 실제로 상품의 기본 정보이지만 일대 다 관계이기 때문에 상품 테이블에 직접 저장할 수 없습니다 (JSON도 사용할 수 있지만 비합리적입니다).
따라서 일반적으로 상품의 일부 공개 기본 상품 매개 변수 인 독립적 인 상품 매개 변수 테이블이 채택됩니다.

상품 명세표는 상품을 더욱 구별하기위한 상품의 식별표입니다. 예를 들어, 동일한 의류는 동일한 기본 정보와 기본 속성을 갖지만 크기 속성은 다음과 같을 수 있습니다.
옷은 여러 개의 상품으로 나뉘고 해당 수량과 가격이 일치하지 않습니다. 제품 사양은 제품 속성으로 볼 수 있지만 특별한 특성이 있습니다.

제품 사양과 사양 값 사이에는 몇 가지 관계가 있습니다.

* 단일 사양 및 단일 사양 값, 가장 일반적인, 즉 현재 제품에 제품이 있습니다.
* 단일 사양 및 여러 사양 값이 더 일반적입니다. 즉, 현재 제품에는 특정 사양을 기반으로 여러 제품이 있으며 일반적으로 가격은 동일하며 물론 다를 수 있습니다.
* 여러 사양과 단일 사양 값은 첫 번째 경우 또는 네 번째 경우로 단순화 할 수 있으며 이는 일반적으로 실제 상황에서 일반적이지 않습니다.
* 여러 사양 및 여러 사양 값, 일반적으로 두 가지 사양 또는 세 가지 사양이 더 일반적이며 해당 가격이 정확히 동일하지 않습니다.

상품 목록은 궁극적으로 상품 재고 관리 및 구매 비즈니스를 실현하는 개체 개체이며 여러 사양 값, 수량 및 가격이 있습니다.
예를 들어, 동일한 의류 브랜드의 경우 최종 제품의 크기 또는 색상이 제공되지 않을 수 있으며 각 제품의 가격은 동일하거나 다를 수 있습니다.

요약하면, 공통 제품은 실제로 데이터베이스에 하나의 제품 테이블 항목이 있고, (적어도 0) 여러 제품 속성 테이블 항목이 있으며, (적어도 하나) 여러 제품 사양 테이블 항목이 있습니다.
(적어도 하나) 여러 항목 목록 항목이 있습니다.

예는 다음과 같습니다.

* "2018 봄옷 상품 번호 1111111"제품,
* 두 가지 상품 매개 변수가 있습니다.
  * 속성 이름은 "사람 중심"이고 속성 값은 "men"입니다.
  * 속성 이름 "fabric", 속성 값 "100 % cotton"
* 2 가지 사양 (각각 5 가지 사양 및 3 가지 사양)이 있으며 총 8 가지 제품 사양,
  * 사양 명 "크기", 규칙 값 "S"
  * 사양 명 "크기", 규칙 값 "M"
  * 사양 명 "크기", 규칙 값 "L"
  * 사양 명 "size", 규칙 값 "XL"
  * 사양 이름 "크기", 규칙 값 "XXL"
  * 사양 명 "color", 사양 값 "blue"
  * 사양 명 "색상", 사양 값 "회색"
  * 사양 명 "color", 사양 값 "black"
* 총 15 개의 상품이 있습니다 (사이즈 * 색상 = 15 개 상품)
  * 상품 "S Blue", 수량 100, 가격 100
  * 상품 "M Blue", 수량 100, 가격 100
  * 상품 "L Blue", 수량 100, 가격 100
  * 상품 "XL Blue", 수량 100, 가격 100
  * 상품 "XXL Blue", 수량 100, 가격 100
  * 상품 "S 그레이", 수량 100, 가격 100
  * 상품 "M 그레이", 수량 100, 가격 100
  * 상품 "L 그레이", 수량 100, 가격 100
  * 상품 "XL 그레이", 수량 100, 가격 100
  * 상품 "XXL 그레이", 수량 100, 가격 100
  * 상품 "S Black", 수량 100, 가격 100
  * 상품 "M Black", 수량 100, 가격 100
  * 상품 "L Black", 수량 100, 가격 100
  * 상품 "XL Black", 수량 0, 가격 100
  * 상품 "XXL Black", 수량 0, 가격 100
  
다음은 몇 가지 자세한 논의입니다.

* 상품 테이블에는 수량 및 가격 속성이있을 수 있으며 상품에는 수량 및 가격 속성도있을 수 있습니다. 현재 디자인은 다음과 같습니다.
  * 제품 목록의 가격은 특정 제품의 가격, 일반적으로 모든 제품 가격의 최소값 또는 기본 스타일의 가격과 동일해야합니다.
  * 상품 표의 수량 및 가격은 최종 주문 가격 계산이 아닌 표시 용으로 만 사용해야합니다.
  * 상품 목록의 수량은 모든 상품의 수량 합계로 설정되어야합니다.
  * 관리 백그라운드에서 상품을 추가 할 때 관리자가 상품 테이블의 수량 및 가격 속성을 입력하지 않으면 해당 값이 자동으로 채워지며 채워지면 디스플레이가 사용됩니다.
  * 소규모 쇼핑몰에서는 사용자가 상품 상세 정보를 볼 때 처음에 상품리스트의 가격이 표시되며, 사용자가 특정 사양을 선택하면 상품이 표시됩니다.
    세부 사항의 가격은 사양의 가격으로 자동 전환되어야합니다.
* 제품 사양은 사양 사진을 가질 수 있으며, 효과는 사양 이름 앞에 사양 사진을 배치하는 것입니다.
* 제품은 제품 사진을 가질 수 있으며, 효과는 모든 사양을 선택한 후 해당 제품을 사용할 수 있으며 제품 사진은 제품 가격 앞에 배치됩니다.
* 상품이 M, N 사양의 두 가지 사양이있는 경우 일반적으로 'M * N'제품이 있어야하지만 일부 제품은 자연적으로 존재하지 않을 수 있습니다.
  현재 모든 상품 정보가 있어야하며 실제 상품이없는 경우 상품 수량도 0으로 설정해야합니다.

노트:

> 여기의 디자인은 실제 프로젝트 디자인과 일치하지 않을 수 있지만 현재는 가능합니다.
> 상품의 중국어 용어 "제품"및 영어 용어 "상품", 중국어 용어 "货品"및 영어 용어 "제품"이 올바르지 않을 수 있습니다.

### 2.2 사용자 및 WeChat 사용자 디자인

현재는 사용자 로그인과 위챗 로그인의 두 가지 방법을 지원할 계획이며 하나의 litemall-user 테이블 만 사용하는 두 가지 로그인 방법은 그다지 적합하지 않을 수 있습니다.

또한 다양한 타사 로그인을 추가로 지원하는 경우 여기에서 다시 디자인해야합니다.

### 2.3 행정 구역 설계
 
litemall_region 테이블은 지방,시 및 카운티 수준의 세 가지 수준을 포함하여 관리 지역 정보를 저장합니다.

지역 데이터는 원래 nideship.sql에 있지만 litemall.sql의 지역 데이터는
[중국 행정부] (https://github.com/modood/Administrative-divisions-of-China) 프로젝트.

### 2.4 주문 설계

주문 정보는 주로 기본 정보, 제품 정보, 주소 정보, 비용 정보, 속달 정보, 결제 정보 및 기타 정보로 구성됩니다.
litemall_order 테이블 및 litemall_order_goods 테이블에 의해 저장됩니다.

* 기본 정보

사용자, 주문 상태, 주문 메시지 등과 같은 주문 생성시 일부 기본 정보
주문 상태는 가장 중요한 정보입니다.

* 제품 정보

주문에 여러 항목이있을 수 있으므로 주문의 항목 정보는 별도의 주문 항목 테이블 (상품이라고도 함)에 기록됩니다.

* 비용 정보

제품 총 가격, 할인 및 면제, 실제 지불과 같은 주문 비용.

* 배송 정보

사용자가 주문시 선택한 배송 주소 및 연락처 정보.

* 배송 정보

현재 특급 정보에는 특급 회사, 특급 번호 및 특급 배송 시간 만 기록됩니다.
단, 속달 배송 과정에서 누락 된 품목 등 일부 이상이있는 경우 현재 시스템은 처리하기 어렵습니다.

* 결제 정보

지불 시간 및 지불 주문 ID.

* 댓글 정보

주문 항목의 설명 상태입니다.

* 기타 정보

#### 2.4.1 주문 상태

! [] (pics / database / order-status.png)

주문은 몇 가지 기본 상태로 나뉩니다.

* 101

  상태 코드 101, 주문이 생성되면 주문 번호, 배송 주소 정보, 주문 제품 정보 및 주문 관련 수수료 정보를 기록합니다.

* 201

  상태 코드 201, 사용자가 WeChat 결제를 결제 할 때 시스템은 WeChat 결제 주문 번호, 결제 시간 및 결제 상태를 기록합니다.

* 301 Zhuàngtài mǎ 301, cǐ shí shāngchǎng yǐjīng fā huò, xìtǒng jìlù kuàidì gōngsī, kuàidì dān hào, kuàidì fāsòng shíjiān. Dāng kuàidì gōngsī fǎnkuì yònghù qiānshōu hòu, xìtǒng jìlù kuàidì dàodá shíjiān. * 401 Zhuàngtài mǎ 401, dāng yònghù shōu dào huò yǐhòu diǎnjī quèrèn shōu huò, xìtǒng jìlù quèrèn shíjiān. Yǐshàng shì yīgè dìngdān chénggōng wánchéng de jīběn liúchéng, dàn shíjì zhōng hái cúnzài qítā qíngkuàng. * 102 Zhuàngtài mǎ 102, yònghù xià dān hòu wèi fùkuǎn zhīqián, diǎnjī qǔxiāo ànniǔ, xìtǒng jìlù jiéshù shíjiān * 103 zhuàngtài mǎ 103, yònghù xià dān hòu bàn xiǎoshí wèi fùkuǎn zé xìtǒng zìdòng qǔxiāo, xìtǒng jìlù jiéshù shíjiān * 202 zhuàngtài mǎ 202, yònghù fùkuǎn yǐhòu wèi fā huò qián, diǎn jí tuì kuǎn ànniǔ, xìtǒng jìnxíng shèzhì tuì kuǎn zhuàngtài, děngdài guǎnlǐ yuán tuì kuǎn cāozuò * 203 zhuàngtài mǎ 203, guǎnlǐ yuán zài guǎnlǐ hòutái kàn dào yònghù de tuì kuǎn shēnqǐng, diǎn jí tuì kuǎn ànniǔ jìnxíng tuì kuǎn cāozuò. * 402 Zhuàngtài mǎ 402, yònghù yǐ qiānshōu què bu diǎnjī quèrèn shōu huò, chāoqī 7 tiān yǐhòu, zé xìtǒng zìdòng quèrèn shōu huò. Yònghù bùnéng zài diǎnjī quèrèn shōu huò ànniǔ, dànshì kěyǐ píngjià dìngdān shāngpǐn. Cǐwài, dāng dìngdān zhuàngtài mǎ shì 102,103,203,401 hé 402 shí, dìngdān kěyǐ zhíxíng shānchú cāozuò. Mùqián de shèjì shì bù zhíxíng wùlǐ shānchú, ér shì luójí shānchú, yīncǐ yònghù chákàn zìjǐ dìngdān shíjiāng kàn bù dào zhèxiē “yǐ shānchú” de dìngdān. Zhùyì: > Zài shàng tú zhōng kěyǐ kàn dào `101`dào `101`de zhuàngtài biànhuà, zhèlǐ zhǐshì xiǎo shāngchǎng yònghù de cāozuò, bù huì yǐngxiǎng dìngdān zhuàngtài mǎ. > Rúguǒ yònghù diǎnjī fùkuǎn shí, hòu duān fúwù huì shēngchéng yù zhīfù huìhuà id, dànshì bù huì yǐngxiǎng dìngdān zhuàngtài. > Rúguǒ ér yònghù zhīfù guòchéng zhōng, fàngqì zhīfù, zé yě bù huì yǐngxiǎng dìngdān zhuàngtài. #### 2.4.2 Zhuàngtài biànhuà * chūshǐ -> 101 xiǎo shāngchǎng yònghù zài xiǎo shāngchǎng diǎnjī `xià dān `ànniǔ, cǐ shí xiǎo shāngchéng hòu duān fúwù huì shēngchǎn shānghù dìngdān. Suǒ duìyìng de hòutái fúwù fāngfǎ shì litemall-wx-api mókuài de `WxOrderController.Submit`fāngfǎ. * 101 -> 101 Zhèlǐ kāifā zhě kěnéng huì qíguài, zhèlǐ cúnzài 101->101 de biànhuà, zhèlǐ biǎomíng hòutái méiyǒu xiǎngyìng xiǎo chéngxù duāndì qǐngqiú, dànshì zhèlǐ de xiǎngyìng méiyǒu dǎozhì dìngdān zhuàngtài shíjì de biànhuà. Zhèlǐ suǒ zhǐ de xiǎngyìng xiǎo chéngxù duān qǐngqiú shì zhǐ xià dān chénggōng yǐhòu xiǎo chéngxù duān zìdòng qǐngqiú fùkuǎn huòzhě yònghù zài dìngdān yèmiàn zhōng diǎnjī `fùkuǎn `suǒ dǎozhì de duì hòutái fúwù de yù zhīfù qǐngqiú. Guānyú wēixìn zhīfù liúchéng, kěyǐ cānkàn guānfāng wéndàng de [xiǎo chéngxù zhīfù yèwùliúchéng](https://Pay.Weixin.Qq.Com/wiki/doc/api/wxa/wxa_api.Php?Chapter=7_4&index=3) yě jiùshì shuō zhèlǐ xiǎo shāngchéng hòutái fúwù huì fǎnhuí fù zhīfù xìnxī. Suǒ duìyìng de hòutái fúwù fāngfǎ shì litemall-wx-api mókuài de `WxOrderController.Prepay` xiǎo shāngchéng jiēshōu fǎnhuí de yù zhīfù xìnxī hòu, huì zài xiǎo chéngxù duān chūxiàn zhīfù yèmiàn. Rúguǒ yònghù fàngqì zhīfù, zé bù huì chūxiàn rènhé xiàoguǒ, bù huì xiàng xiǎo shāngchǎng hòutái fúwù fāsòng rènhé xìnxī. Rúguǒ yònghù zhīfù, zé huì dǎozhì wēixìn shānghù píngtái xiàng xiǎo shāngchǎng hòutái fúwù tuīsòng zhīfù jiéguǒ. * 101 -> 102 Rúguǒ yònghù méiyǒu zhīfù, nàme cǐ shí yònghù kěyǐ diǎnjī `qǔxiāo dìngdān `ànniǔ lái fàngqì dāngqián dìngdān. Suǒ duìyìng de hòutái fúwù fāngfǎ shì litemall-wx-api mókuài de `WxOrderController.Cancel` * 101 -> 103 rúguǒ yònghù méiyǒu zhīfù, yě méiyǒu diǎnjī `qǔxiāo dìngdān `ànniǔ, nàme xìtǒng huì dìngshí cháxún shùjùkù de dìngdān xìnxī. Rúguǒ fāxiàn cúnzài dìngdān wèi zhīfù zhuàngtài chāoshí bàn xiǎoshí, cǐ shí xìtǒng huì zìdòng qǔxiāo dìngdān, lái shìfàng shāngpǐn zīyuán. Duìyìng de yīnggāi shì litemall-admin-api mókuài de xìtǒng dìngshí rènwù de `OrderJob.CheckOrderUnpaid` * 101 -> 201 rúguǒ yònghù zhīfù, wēixìn shānghù píngtái huì xiàng xiǎo shāngchǎng hòutái fúwù tuīsòng zhīfù jiéguǒ. Ér xiǎngyìng jiéguǒ biǎoshì zhīfù chénggōng, zé dìngdān zhuàngtài xìnxī shèzhì 201, biǎoshì zhīfù chénggōng. Suǒ duìyìng de hòutái fúwù fāngfǎ shì litemall-wx-api mókuài de `WxOrderController.PayNotify` * 201 -> 202 dāng yònghù zhīfù yǐhòu, guǎnlǐ yuán wèi fā huò qián, yònghù kěyǐ diǎnjī `tuì kuǎn `shēnqǐng tuì kuǎn qǔxiāo dìngdān. Tōngcháng yònghù diǎn jí tuì kuǎn yǐhòu xìtǒng kěyǐ jīyú wēixìn shānghù píngtái de tuì kuǎn jiēkǒu shíxiàn zìdòng tuì kuǎn, dànshì zhèlǐ kǎolǜ dào ānquán yuányīn, bù zhīchí xìtǒng zìdòng tuì kuǎn cāozuò. Xiāngyìng de, zhèlǐ xiǎo shāngchǎng hòutái fúwù zhǐshì shèzhì dìngdān zhuàngtài, biǎoshì tuì kuǎn shēnqǐng zhōng. Suǒ duìyìng de hòutái fúwù fāngfǎ shì litemall-wx-api mókuài de `WxOrderController.Refund` * 202 -> 203 zhèlǐ tuì kuǎn cāozuò shì yóu guǎnlǐ yuán zài wēixìn shānghù píngtái shǒudòng tuì kuǎn, ránhòu zài běn xiàngmù dì guǎnlǐ píngtái lǐmiàn diǎnjī `tuì kuǎn quèrèn `ànniǔ, cǐ shí dìngdān zhuàngtài huì shèzhì chéng 203, biǎomíng tuì kuǎn yǐjīng chénggōng, tóngshí xìtǒng huì zìdòng huīfù dìngdān shāngpǐn shùliàng. Suǒ duìyìng de hòutái fúwù fāngfǎ shì litemall-admin-api mókuài de `AdminOrderController.RefundConfirm` * 201 -> 301 dāng dìngdān zhīfù yǐhòu, guǎnlǐ yuán jìnxíng dìngdān fā huò, ránhòu zài guǎnlǐ píngtái diǎnjī `fā huò `, tiánxiě kuàidì xìnxī, shèzhì dìngdān zhuàngtài shì 301, biǎoshì guǎnlǐ yuán yǐ fā huò zhuàngtài. Suǒ duìyìng de hòutái fúwù fāngfǎ shì litemall-admin-api mókuài de `AdminOrderController.Ship` * 301 -> 401 dāng yònghù shōu dào shāngpǐn yǐhòu, yònghù diǎnjī `shōu huò quèrèn `ànniǔ, shèzhì dìngdān zhuàngtài 401, biǎoshì yònghù chénggōng shōu huò. Suǒ duìyìng de hòutái fúwù fāngfǎ shì litemall-wx-api mókuài de `WxOrderController.Confirm` * 301 -> 402 dāng guǎnlǐ yuán fā huò yǐhòu, yònghù yīzhí méiyǒu quèrèn shōu huò, xìtǒng dìngshí jiǎncè dìngdān zhuàngtài, rúguǒ fāxiàn fā huò yǐhòu qītiān yònghù dōu méiyǒu shōu huò, cǐ shí xìtǒng zìdòng quèrèn yònghù shōu huò, shèzhì dìngdān zhuàngtài 402. Yīnggāi gǎi wèi litemall-admin-api mókuài de xìtǒng dìngshí rènwù `OrderJob.CheckOrderUnconfirm` zhùyì: > Shàngshù dìngdān zhuàngtài biànhuà zhōng jùtǐ de luójí chǔlǐ kěyǐ cānkǎo xiāngyìng mókuài wéndàng hé mókuài dàimǎ. #### 2.4.2 Yònghù cāozuò dìngdān zhuàngtài mǎ biāozhìle dìngdān de zhuàngtài, dànshì duìyú yònghù ér yán, zhēnzhèng guānxīn de zhǐshì tāmen nénggòu jìnxíng de cāozuò, yě jiùshì zài xiǎo shāngchǎng de xiǎo chéngxù duān yònghù kěyǐ jìnxíng diǎnjī de ànniǔ cāozuò, mùqián zhīchí: * `Zhīfù `, rúguǒ xià dān hòu wèi lìjí zhīfù, zé dìngdān xiángqíng yèmiàn huì chūxiàn `zhīfù `ànniǔ; * `qǔxiāo `, rúguǒ yònghù wèi zhīfù, zé dìngdān xiángqíng yèmiàn huì chūxiàn `qǔxiāo `ànniǔ; * `tuì kuǎn `, rúguǒ yònghù zhīfù hòu dànshì guǎnlǐ yuán wèi fā huò, zé dìngdān xiángqíng yèmiàn huì chūxiàn `tuì kuǎn `ànniǔ; * `quèrèn shōu huò `, rúguǒ guǎnlǐ yuán yǐ fā huò, zé dìngdān xiángqíng yèmiàn huì chūxiàn `quèrèn shōu huò `ànniǔ; * `shēnqǐng tuìhuò `, rúguǒ yònghù yǐjīng quèrèn shōu huò tóngshí wèi chāoguò yīduàn shí jiān, zé dìngdān xiángqíng yèmiàn huì chūxiàn `shēnqǐng tuìhuò `ànniǔ; zhùyì, zhèlǐ rúguǒ shì xìtǒng chāoshí zìdòng quèrèn shōu huò, zé bù huì chūxiàn; * `qù píngjià `, rúguǒ yònghù quèrèn shōu huò yǐhòu, zé dìngdān xiángqíng yèmiàn huì chūxiàn `qù píngjià `ànniǔ; * `zàicì gòumǎi `, rúguǒ yònghù quèrèn shōu huò yǐhòu, zé dìngdān xiángqíng yèmiàn huì chūxiàn `zàicì gòumǎi `ànniǔ; * `shānchú `, rúguǒ dāngqián dìngdān zhuàngtài mǎ shì 102,103,203,401 hé 402 shí, zé dìngdān xiángqíng yèmiàn huì chūxiàn `shānchú dìngdān `ànniǔ; zhùyì, zhèlǐ de shānchú cāozuò shì luójí shānchú, jí shèzhì dìngdān de shānchú zhuàngtài `deleted`. Yīncǐ dìngdān zhuàngtài mǎ hé xiǎo shāngchǎng yònghù cāozuò zhī jiān cúnzài yìngshè guānxì: * 101 Yònghù kěyǐ `zhīfù `,`qǔxiāo ` * 102 yònghù kěyǐ `shānchú ` * 103 yònghù kěyǐ `shānchú ` * 201 yònghù kěyǐ `tuì kuǎn ` * 203 yònghù kěyǐ `shānchú ` * 301 yònghù kěyǐ `quèrèn shōu huò ` * 401 yònghù kěyǐ `shānchú `,`qù píngjià `,`shēnqǐng shòuhòu `,`zàicì gòumǎi ` * 402 yònghù kěyǐ `shānchú `,`qù píngjià `,`shēnqǐng shòuhòu `,`zàicì gòumǎi ` #### 2.4.3 Shēnqǐng shòuhòu dāng yònghù quèrèn shōu huò huòzhě xìtǒng zìdòng quèrèn shōu huò yǐhòu, dìngdān kěyǐ shēnqǐng shòuhòu. Mùqián jǐn zhīchí dìngdān zhěngtǐ shòuhòu, ér bù zhīchí dìngdān shāngpǐn dúlì shòuhòu. Zhè shì yīnwèi: Dìngdān cúnzài shāngpǐn shòu jià, yōuhuì quàn jiǎnmiǎn, tuángòu jiǎnmiǎn yǐjí wù liú yùnfèi shǔxìng, rúguǒ yào zhīchí dāngè shāngpǐn tuì kuǎn, nàme cúnzài yīgè xūyào jiějué de wèntí jiùshì dāngè shāngpǐn de tuì kuǎn jīn'é rúhé jìsuàn. Rúguǒ kāifā zhě zhèlǐ kǎolǜ qīngchǔ, yě kěyǐ cānkǎo dāngqián dàimǎ shíxiàn dìngdān shāngpǐn dúlì shòuhòu litemall_order biǎo zhōng cúnzài `aftersale_status`zìduàn, jìlù dìngdān shòuhòu zhuàngtài. Ér jùtǐ de shòuhòu jìlù zé shì litemall_aftersale biǎo jìlù. Zhèlǐ `type`zìduàn biǎoshì dāngqián shòuhòu lèixíng, mùqián cúnzài sān zhǒng lèixíng: * Rúguǒ type=0, jí “wèi shōu huò tuì kuǎn”, tōngcháng shì xìtǒng chāoshí zìdòng quèrèn shōu huò, ér shíjì shang yònghù méiyǒu shōu huò, yīncǐ kěyǐ xuǎnzé zhège; * rúguǒ type=1, jí “wúxū tuìhuò tuì kuǎn”, tōngcháng shì yònghù quèrèn shōu huò hòu shēnqǐng shòuhòu, ér guǎnlǐ yuán tóngyì kěyǐ bù xūyào tuìhuò, zhíjiē tuì kuǎn gěi yònghù; * rúguǒ type=2, jí “tuìhuò tuì kuǎn”, tōngcháng shì yònghù quèrèn shōu huò hòu shēnqǐng shòuhòu, guǎnlǐ yuán tóngyì yònghù tuìhuò, dāng guǎnlǐ yuán shōu dào huò yǐhòu zài tuì kuǎn gěi yònghù. Xūyào zhùyì de shì: Dāngqián shíxiàn zhōng, rúguǒ shì “tuìhuò tuì kuǎn” lèixíng, nàme guǎnlǐ yuán zài jìnxíng tuì kuǎn yǐhòu, xìtǒng huì zìdòng huīfù huòpǐn shùliàng. Zhè shì yīnwèi guǎnlǐ yuán wánchéng “tuìhuò tuì kuǎn” shòuhòu, shuōmíng guǎnlǐ yuán yǐjīng shōu dào yònghù de tuìhuò. Kāifā zhě kěyǐ gǎibiàn zhèlǐ de shíxiàn luójí, lìrú cǎiyòng dúlì de tuìhuò rù kù liúchéng. `Status`zìduàn biǎoshì dāngqián shòuhòu zhuàngtài, fēnbié shì: * Rúguǒ status=0, wèi shēnqǐng shòuhòu; * rúguǒ status=1, yònghù shēnqǐng shòuhòu, děngdài guǎnlǐ yuán shěnhé; * rúguǒ status=2, guǎnlǐ yuán shěnhé tōngguò, děngdài guǎnlǐ yuán tuì kuǎn;
자세히
3840 / 5000
번역 결과
* 301

  상태 코드 301은이 때 쇼핑몰이 배송되었으며 시스템은 택배사, 택배 번호, 택배 배송 시간을 기록합니다.
  특급 회사가 사용자에게 영수증에 서명하도록 피드백하면 시스템이 특급 도착 시간을 기록합니다.

* 401

  상태 코드 401, 사용자가 상품을 수령 한 후 수령 확인을 클릭하면 시스템은 확인 시간을 기록합니다.

위는 주문을 성공적으로 완료하기위한 기본 프로세스이지만 실제로 다른 상황이 있습니다.

* 102

  상태 코드 102, 사용자가 주문한 후 결제하기 전에 취소 버튼을 클릭하면 시스템이 종료 시간을 기록합니다.

* 103

  상태 코드 103, 사용자가 주문 후 30 분을 지불하지 않으면 시스템이 자동으로 취소되며 시스템은 종료 시간을 기록합니다.

* 202

  상태 코드 202, 사용자가 결제 한 후 배송이 이루어지기 전에 환불 버튼을 클릭하여 환불 상태를 설정하고 관리자가 환불을 기다립니다.

* 203

  상태 코드 203, 관리자는 관리 배경에서 사용자의 환불 애플리케이션을보고 환불 버튼을 클릭하여 환불 작업을 수행합니다.
  
* 402

  상태 코드 402, 사용자가 영수증에 서명했지만 영수증 확인을 클릭하지 않고 7 일이 지나면 시스템에서 영수증을 자동으로 확인합니다.
  사용자는 더 이상 영수증 확인 버튼을 클릭 할 수 없지만 주문 상품을 평가할 수 있습니다.

또한 주문 상태 코드가 102, 103, 203, 401, 402 인 경우 주문을 삭제할 수 있습니다.
현재 디자인은 물리적 삭제가 아니라 논리적 삭제를 수행하므로 사용자는 주문을 볼 때 이러한 "삭제 된"주문을 볼 수 없습니다.

노트:
> 위 그림에서 '101'에서 '101'로 상태가 변경된 것을 확인할 수 있으며, 이는 소규모 쇼핑몰 사용자의 조작 일 뿐이며 주문 상태 코드에는 영향을주지 않습니다.
> 사용자가 결제를 클릭하면 백엔드 서비스가 선결제 세션 ID를 생성하지만 주문 상태에는 영향을주지 않습니다.
> 사용자가 결제 과정에서 결제를 포기하더라도 주문 상태에는 영향을 미치지 않습니다.

#### 2.4.2 상태 변경

* 이니셜-> 101

소규모 쇼핑몰 사용자는 소규모 쇼핑몰에서 '주문하기'버튼을 클릭하면 이때 소규모 쇼핑몰 백엔드 서비스가 가맹점 주문을 생성합니다.

해당 백그라운드 서비스 메소드는 litemall-wx-api 모듈의`WxOrderController.submit` 메소드입니다.
 
* 101-> 101

개발자는 여기서 놀라실 수 있습니다. 101-> 101 변경 사항이 있으며 이는 배경이 응답하지 않음을 나타냅니다.
애플릿의 요청이지만 여기의 응답으로 인해 주문 상태가 실제로 변경되지는 않았습니다. 여기 참조
미니 단말기의 요청에 응답한다는 것은 주문이 성공적으로 이루어 지거나 사용자가 주문 페이지에 들어간 후 미니 단말기가 자동으로 결제를 요청하는 것을 의미합니다.
'결제'를 클릭하여 발생하는 백엔드 서비스에 대한 선결제 요청입니다.

WeChat 결제 절차는 공식 문서 [Mini Program Payment Business Process] (https://pay.weixin.qq.com/wiki/doc/api/wxa/wxa_api.php?chapter=7_4&index=3)를 참조하세요.
즉, 이곳의 작은 쇼핑몰의 백엔드 서비스는 결제 정보를 반환합니다.

해당 백그라운드 서비스 메소드는 litemall-wx-api 모듈의`WxOrderController.prepay`입니다.

반납 된 선불 정보를 소형 몰에서 접수하면 소형 단말기에 결제 페이지가 나타납니다.
사용자가 결제를 포기할 경우 아무런 효과가 없으며 소규모 쇼핑몰 백엔드 서비스로 정보가 전송되지 않습니다.
사용자가 결제하면 위챗 가맹점 플랫폼이 결제 결과를 소규모 쇼핑몰 백그라운드 서비스로 푸시하게됩니다.

* 101-> 102

사용자가 결제하지 않은 경우 '주문 취소'버튼을 클릭하여 현재 주문을 포기할 수 있습니다.

해당 백그라운드 서비스 메소드는 litemall-wx-api 모듈의`WxOrderController.cancel`입니다.

* 101-> 103

사용자가 결제하지 않거나 '주문 취소'버튼을 클릭하면 시스템은 주기적으로 데이터베이스에서 주문 정보를 쿼리합니다.
30 분 동안 시간이 초과 된 미결제 주문이있는 경우 시스템은이 시점에서 자동으로 주문을 취소하여 상품 자원을 해제합니다.

해당하는 것은 litemall-admin-api 모듈의 시스템 타이밍 작업의`OrderJob.checkOrderUnpaid` 여야합니다.

* 101-> 201

사용자가 결제하면 위챗 가맹점 플랫폼은 결제 결과를 소규모 쇼핑몰 백그라운드 서비스로 푸시합니다.
응답 결과 결제 성공으로 표시되는 경우 주문 상태 정보는 201로 설정되어 결제 성공을 나타냅니다.

해당 백그라운드 서비스 메소드는 litemall-wx-api 모듈의`WxOrderController.payNotify`입니다.

* 201-> 202

사용자는 결제 후 'Refund'를 클릭하여 관리자가 상품을 배송하기 전에 주문을 취소하기 위해 환불을 신청할 수 있습니다.
일반적으로 사용자가 환불을 클릭 한 후 시스템은 WeChat 판매자 플랫폼의 환불 인터페이스를 기반으로 자동 환불을 실현할 수 있습니다.
그러나 보안상의 이유로 시스템은 자동 환불 작업을 지원하지 않습니다.
이에 따라 여기에있는 소규모 쇼핑몰의 백엔드 서비스는 주문 상태 만 설정하여 환불 신청이 진행 중임을 나타냅니다.

해당 백그라운드 서비스 메소드는 litemall-wx-api 모듈의`WxOrderController.refund`입니다.

* 202-> 203

여기에서 환불 작업은 WeChat 판매자 플랫폼의 관리자가 수동으로 환불 한 다음 프로젝트의
관리 플랫폼에서 'Refund Confirmation'버튼을 클릭하면 주문 상태가 203으로 설정됩니다.
환불이 완료되었으며 시스템이 주문한 항목 수를 자동으로 복원합니다.

해당 백그라운드 서비스 메소드는 litemall-admin-api 모듈의`AdminOrderController.refundConfirm`입니다.

* 201-> 301

주문이 결제되면 관리자가 주문을 배송 한 다음 관리 플랫폼을 클릭하여 배송 정보를 입력합니다.
주문 상태를 301로 설정하여 관리자가 상태를 발송했음을 나타냅니다.

해당 백그라운드 서비스 메소드는 litemall-admin-api 모듈의`AdminOrderController.ship`입니다.

* 301-> 401

사용자가 상품을 수령하면 사용자는 '수령 확인'버튼을 클릭하여 주문 상태 (401)를 설정하여 사용자가 상품을 성공적으로 수령했음을 나타냅니다.

해당 백그라운드 서비스 메소드는 litemall-wx-api 모듈의`WxOrderController.confirm`입니다.

* 301-> 402

관리자가 상품을 배송 한 후 사용자가 상품 수령을 확인하지 않은 경우 시스템은 배송 후 발견되는 경우 주문 상태를 정기적으로 확인합니다.
사용자가 7 일 동안 상품을받지 못한 경우 시스템은 자동으로 상품 수령 여부를 확인하고 주문 상태 (402)를 설정한다.

litemall-admin-api 모듈의 시스템 타이밍 태스크`OrderJob.checkOrderUnconfirm`으로 변경되어야합니다.

노트:
> 위의 주문 상태 변경에서 특정 로직 처리에 대해서는 해당 모듈 문서 및 모듈 코드를 참조하십시오.

#### 2.4.2 사용자 조작

주문 상태 코드는 주문 상태를 식별하지만 사용자의 경우 진정으로 관심을 갖는 것은 그들이 할 수있는 일입니다.
즉, 사용자는 소형 쇼핑몰의 소형 프로그램 단말기에서 버튼을 클릭 할 수 있으며 현재 다음을 지원합니다.

* '결제', 주문 후 바로 결제가 이루어지지 않는 경우 주문 상세 페이지에 '결제'버튼이 나타납니다.
* '취소', 사용자가 결제하지 않으면 주문 세부 정보 페이지에 '취소'버튼이 표시됩니다.
* '환불', 사용자가 결제 한 후 관리자가 상품을 배송하지 않은 경우 주문 세부 정보 페이지에 '환불'버튼이 표시됩니다.
* '입고 확인', 관리자가 이미 상품을 배송 한 경우 주문 내역 페이지에 '입고 확인'버튼이 나타납니다.
* '반품 신청', 사용자가 일정 기간이 지나지 않은 배송을 확인한 경우 주문 세부 정보 페이지에 '반품 신청'버튼이 표시됩니다.
   시스템이 시간이 지남에 따라 상품 수령을 자동으로 확인하면 표시되지 않습니다.
*`검토로 이동`, 사용자가 영수증을 확인하면 주문 세부 정보 페이지에`검토로 이동`버튼이 표시됩니다.
* '다시 구매', 사용자가 영수증을 확인하면 주문 세부 정보 페이지에 '다시 구매'버튼이 표시됩니다.
* '삭제', 현재 주문 상태 코드가 102, 103, 203, 401 및 402 인 경우 주문 세부 정보 페이지에 '주문 삭제'버튼이 표시됩니다.
   여기서 삭제 작업은 논리적 삭제, 즉 '삭제됨'주문의 삭제 상태를 설정합니다.
  
따라서 주문 상태 코드와 소규모 쇼핑몰 사용자 작업간에 매핑 관계가 있습니다.

* 101

  사용자는 '결제', '취소'가능

* 102

  사용자는 '삭제'가능

* 103

  사용자는 '삭제'가능

* 201

  사용자는 '환불'가능

* 203

  사용자는 '삭제'가능

* 301

  사용자는 '영수증 확인'가능

* 401

  사용자는 '삭제', '검토', '애프터 신청', '다시 구매'가능

* 402

  사용자는 '삭제', '검토', '애프터 신청', '다시 구매'가능

#### 2.4.3 A / S 신청

사용자가 영수증을 확인하거나 시스템이 자동으로 영수증을 확인한 후 주문은 A / S를 신청할 수 있습니다.
현재는 주문의 전체 A / S 만 지원하고 있으며, 개별 주문 품목의 A / S는 지원하지 않습니다.
주문이 상품 가격, 쿠폰 할인, 단체 구매 할인, 물류화물의 속성을 가지고 있기 때문입니다.
단일 제품 환불을 지원하려면 해결해야 할 문제가 단일 제품입니다.
환불 금액 계산 방법. 개발자가 여기에서 명확하게 생각하면 현재 코드 구현을 참조 할 수도 있습니다.
애프터 세일 상품 독립적 주문

'aftersale_status'필드는 주문의 판매 후 상태를 기록하는 litemall_order 테이블에 있습니다.
특정 판매 후 레코드는 litemall_aftersale 테이블 레코드입니다.

여기서`type` 필드는 현재 A / S 유형을 나타냅니다. 현재 세 가지 유형이 있습니다.

* type = 0, 즉 "미수령 상품에 대한 환불"인 경우 일반적으로 시스템은 시간이 지남에 따라 상품의 수령을 자동으로 확인하지만 실제로는 사용자가 상품을받지 않았으므로이를 선택할 수 있습니다.
* type = 1, 즉 "환불을 위해 상품을 반품 할 필요가 없다"인 경우, 일반적으로 이용자는 상품 수령을 확인한 후 A / S를 신청하며, 관리자는 상품을 반품하고 이용자에게 직접 환불 할 필요가 없음에 동의합니다.
* type = 2 인 경우 "반품에 대한 환불"을 의미하며, 일반적으로 이용자가 상품 수령을 확인하고 A / S 신청을 한 후 관리자가 이용자에게 상품을 반품하는 것에 동의하며, 관리자가 상품을 수령하면 이용자에게 환불됩니다.

현재 구현에서 "반품 및 환불"유형 인 경우 관리자가 환불을 수행 한 후 시스템이 자동으로 상품 수량을 복원합니다.
이는 관리자가 "반품 및 환불"판매를 완료하여 관리자가 사용자의 반품을 받았음을 나타 내기 때문입니다.
개발자는 여기에서 독립적 인 반환 및 저장 프로세스를 사용하는 등의 구현 논리를 변경할 수 있습니다.

'상태'필드는 다음과 같은 현재 판매 후 상태를 나타냅니다.

* 상태 = 0 인 경우 A / S 신청이 적용되지 않습니다.
* status = 1 인 경우 사용자는 A / S를 신청하고 관리자의 검토를 기다립니다.
* status = 2 인 경우 관리자는 검토를 통과하고 관리자가 환불을 기다립니다.
* 상태 = 3 인 경우 관리자가 환불하고 A / S가 완료된 것입니다.
* status = 4 인 경우 관리자가 검토에 실패하고 A / S가 완료됩니다.
* 상태 = 5 인 경우 사용자가 A / S를 해지 한 것이며, 사용자는 A / S 신청 후 관리자가 검토하기 전에 취소를 신청할 수 있습니다.

여기에 추가해야 할 것은 주문 litemall_order 테이블의`aftersale_status` 필드 및 주문 litemall_aftersale입니다.
테이블의 'status'필드는 완전히 일치하므로 프런트 엔드가 주문 상태 및 주문의 A / S 상태를 쿼리하는 데 편리합니다.

'amount'필드는 현재 A / S 환불 금액을 나타냅니다. 앞서 언급했듯이 현재 주문의 전체 A / S 만 지원하므로 현재 설계된 환불 금액은 다음과 같습니다.
실제 결제 주문 배송을 주문하십시오.

#### 2.4.4 제품 평가

litemall_order 테이블에는 평가되지 않은 주문 항목이 여러 개 있음을 나타내는`comments` 필드가 있습니다.
litemall_order_goods 테이블에는 현재 주문 제품의 댓글 ID를 나타내는`comment` 필드가 있습니다.

* 사용자가 영수증을 확인한 후 '댓글'은 현재 주문에서 미 심사 상품 수를 설정합니다. 그리고`comment`는 0으로 설정됩니다.
* 사용자가 주문 항목을 평가하면 '댓글'이 1 개 줄어들고 '댓글'은 새로 생성 된 댓글을 가리 킵니다.
* 사용자가 기한이 지난 댓글이 없으면 '댓글'은 0으로, '댓글'은 -1로 설정됩니다.

### 2.5 코멘트 디자인

주석 테이블 litemall_comment는 주석 관련 정보를 저장하며, 그 중 가장 중요한 것은`type` 필드와`value_id` 필드입니다.

여기서`type` 필드는 현재 댓글 유형을 나타냅니다. 현재 두 가지 유형이 있습니다.

* type = 0 인 경우 현재 댓글은 주문 상품 댓글이고 value_id는 주문 상품 ID입니다.
* type = 1 인 경우 현재 댓글은 주제 댓글이고 value_id는 주제 ID입니다.

`admin_content` 필드에는 레코드 관리 배경의 관리자가 사용자의 댓글에 대한 응답이 포함됩니다.

### 2.6 그룹 구매 디자인

그룹 구매는 그룹 구매 규칙 테이블 litemall_groupon_rules와 그룹 구매 활동 테이블 litemall_groupon으로 구성됩니다.

관리자는 관리 백그라운드에서 일부 상품에 대한 그룹 구매 규칙을 구성하고이를 litemall_groupon_rules 테이블에 저장합니다.

사용자는 소규모 쇼핑몰에서 그룹 구매 규칙에 따라 제공되는 우대 정보를 볼 수 있습니다.
다음으로 사용자에게는 두 가지 작업이 있습니다.
첫 번째는 사용자가 그룹을 열고 litemall_groupon에 저장하고 사용자가 제품 그룹 구매 페이지를 친구와 적극적으로 공유하는 것입니다.
두 번째는 사용자가 그룹에 참여한다는 것입니다.이 그룹은 litemall_groupon에도 저장됩니다.

그룹 회원 수가 그룹 구매 규칙을 충족하는 경우에만 생성 된 주문이 유효합니다. 그렇지 않으면 관리자가 현재 그룹 구매를 취소하기 위해 환불해야합니다.

### 2.7 쿠폰 디자인

쿠폰은 litemall_coupon 테이블과 litemall_coupon_user 테이블로 구성됩니다.
* litemall_coupon 테이블은 쿠폰의 기본 정보 및 사용 규칙입니다.
* litemall_coupon_user 테이블은 사용자 쿠폰 수령 및 사용 기록입니다.

#### 2.7.1 유형

쿠폰이 전송되는 방식을 식별하는 유형 필드는 현재 다음을 지원합니다.
* 유니버설 쿠폰, 즉 홈페이지 나 쿠폰 목록 페이지에서 사용자가 쿠폰 정보를 확인하고 클릭하여받을 수 있습니다.
* 등록 쿠폰, 즉 사용자가 성공적으로 등록한 후 시스템이 자동으로 사용자에게 전송합니다.
* 교환 쿠폰 즉, 사용자가 개인 쿠폰 페이지에 교환 코드를 입력하여 쿠폰을 교환합니다.

#### 2.7.2 상품 _ 유형

goods_type 필드는 쿠폰에 사용할 수있는 상품의 범위를 식별합니다.
* 범용, 즉 모든 상품을 사용할 수 있습니다.
* 카테고리 제한, ** 현재 지원되지 않음 **, 즉 특정 상품 카테고리 만 사용할 수 있습니다.
* 상품 제한, ** 현재 지원되지 않음 **, 즉 일부 상품은 쿠폰 만 사용할 수 있습니다.

#### 2.7.3 시간 _ 유형

time_type 필드는 쿠폰의 유효 기간을 식별합니다.
* 사용자가 쿠폰을받은 상대 일수, 즉 사용자가 쿠폰을받은 후 며칠 이내에 유효합니다.
* 관리자가 설정 한 절대 시간, 즉 쿠폰의 시작 시간과 종료 시간.

#### 2.7.4 상태

상태 필드는 쿠폰의 현재 상태를 식별합니다.

여기서 지적해야 할 점은 litemall_coupon 및 litemall_coupon_user 테이블 모두 상태 필드가 있다는 것입니다.

litemall_coupon 테이블의 상태 필드에는 다음 세 가지 상태가 포함됩니다.
* 일반적으로 사용 가능,
* 만료 됨,
* 제거 되었어,

litemall_coupon_user 테이블의 상태 필드에는 다음 세 가지 상태가 포함됩니다.
* 미사용,
* 중고,
* 만료 됨,
* 제거 되었어,

### 2.8 시스템 구성 설계

시스템 구성 테이블 litemall_system은 시스템의 구성 정보를 저장합니다.

여기서는 Java 코드 레이어의 시스템 구성 테이블 만 업데이트 할 수 있다는 점에 유의해야합니다.
만들기 및 삭제 작업을 수행 할 수 없습니다. 즉, 시스템 구성 데이터는 개발자 여야합니다.
시스템 구성 요구 사항에 따라 데이터베이스에서 수동으로 생성합니다.

### 2.9 스토리지 객체 설계

litemall_storage 저장소 개체 테이블은 업로드 된 파일 정보를 저장합니다.

사용자 또는 관리자가 이미지를 업로드하면 이미지 파일이 로컬 또는 타사 클라우드 스토리지 서버에 저장됩니다.
동시에 스토리지 오브젝트 테이블에 기록하십시오.

### 2.10 작업 로그 디자인

비즈니스 로그 테이블 litemall_log는 관리자의 주요 작업을 기록합니다.

논의 할 필요가있는 것은 많은 프로젝트의 비즈니스 로그 모듈이 주석을 사용한다는 것입니다. 즉, 메소드 주석을 추가하여 자동으로 캡처 할 수 있습니다.
사용자의 동작 행동. 이것은 매우 편리하고 비즈니스 코드에 영향을 미치지 않지만 실제로는 거친 방식으로 기록되며 기록은 의미가 없습니다.

따라서이 프로젝트는 비즈니스 운영 및 결과를 기록하는 방법에서 수기 비즈니스 로그 코드를 사용합니다.
더 번거롭기는하지만 레코드가 세분화되도록 할 수 있습니다. 또한 관리자가 궁극적으로 작업에 대해 덜 신경을 쓴다면
실제로 작성할 코드가 많지 않습니다.

의미론을 고려할 때 운영 비즈니스는 "누가 어떤 작업을했는지, 그 결과는 성공 또는 실패였으며, 실패 이유는 무엇이며, 추가 정보는 무엇입니까"여야합니다.
따라서 여기에서 디자인 된 비즈니스 로그 테이블의 주요 필드는 다음과 같습니다.
* 관리자
* IP 주소
* 작업 분류
* 작업 동작
* 작동 상태
* 작업 결과
* 추가 정보

#### 2.10.1 동작 범주

여기의 로그 유형은 4 가지 유형으로 설계되었습니다 (물론 개발자는 확장 가능해야 함)
* 일반 로그 : 사용자가 조회가 필요하다고 생각하는 일반 작업 로그를 기본 로그 수준으로 권장
* 보안 로그 : 로그인, 관리자 삭제 등 사용자 보안 관련 작업 로그
* 주문 로그 : 주문 배송, 환불 등 사용자 거래와 관련된 작업 로그
* 기타 로그 : 위 3 가지가 적합하지 않은 경우 다른 로그를 선택할 수 있으며 우선 순위가 가장 낮은 로그 수준을 권장합니다.

물론 개발자는 최종 사용자와 논의하고 의사 소통하고 로그인 관련 또는 주문 관련과 같은 진정으로 중요한 비즈니스 작업을 기록하는 것이 좋습니다.

#### 2.10.2 동작 결과

작업이 성공하면 작업 결과 필드를 사용하여 작업중인 개체를 기록 할 수 있습니다.
물론 일부 작업에는 특정 개체가 없으므로 생략 할 수 있습니다.

작업이 실패하면 작업 결과 필드를 사용하여 실패 이유를 기록 할 수도 있습니다.

#### 2.10.3 작업 실패

작업 상태 필드와 작업 결과 필드가 있지만 작업 실패 상태를 기록 할 수 있습니다.
그러나 일반적으로 실패한 작업은 시스템이나 데이터베이스에 영향을 미치지 않으므로 실제로 개발자는
너무 많은 작업 실패 로그를 기록하지만 성공한 작업 로그를 기록하여 시스템 관리자에게 현재 상태 변경 사항을 알립니다.

물론 작업 실패를 기록할지 여부는 개발자 또는 최종 사용자에게 필요한지 여부에 따라 다릅니다.
예를 들어 여기에 로그인하면 사용자 로그인 실패 로그가 기록되어야합니다. 저장된 IP 주소는 관리자가
시스템에 액세스합니다.

### 2.11 유니버설 디자인

위의 테이블 외에도 데이터베이스에는 litemall_topic 토픽 테이블과 같은 다른 비즈니스 테이블이 있습니다.
그러나 그것들은 모두 직관적이며 논의 할 필요가 없습니다.

다음은 테이블 디자인에서 특정 비즈니스 의미가없는 몇 가지 일반적인 필드입니다.

#### 2.11.1 삭제됨

매우 적은 수의 테이블을 제외하고 다른 모든 테이블에는 논리적 삭제를 지원하는 'deleted'필드가 있습니다.
따라서 데이터 삭제시 데이터는 직접 삭제되지 않고 'deleted'필드가 수정됩니다.
물론 데이터베이스 관리자는 데이터베이스에 연결하여 데이터를 직접 삭제하거나 개발자가
여기에서 논리를 수정하여 물리적 삭제를 사용할 수 있습니다.

#### 2.11.2 add_time

일부 테이블을 제외하고 다른 모든 테이블에는 데이터 생성 시간을 기록하는 'add_time'필드가 있습니다.

#### 2.11.3 업데이트 _ 시간

일부 테이블을 제외하고 다른 모든 테이블에는 데이터 수정 시간을 기록하는`update_time` 필드가 있습니다.

또한 개발자는 update_time을 사용하여 낙관적 잠금 업데이트 메커니즘을 구현할 수 있습니다.
