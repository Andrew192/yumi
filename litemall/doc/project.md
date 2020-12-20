# 1 litemall 시스템

## 1.1 소개

litemall은 기존 오픈 소스 프로젝트를 기반으로하는 간단한 쇼핑몰 시스템으로, 애플릿 클라이언트, 모바일 클라이언트 및 웹 관리를 포함한 완전한 프런트 엔드 및 백 엔드 프로젝트를 다시 구현합니다.

! [] (./ pics / project / project-structure.png)


프로젝트의 아키텍처는 4 개의 시스템과 9 개의 모듈입니다.

* 기본 시스템 하위 시스템 (플랫폼)

  데이터베이스, litemall-core 모듈, litemall-db 모듈 및 litemall-all 모듈로 구성됩니다.

* 소규모 쇼핑몰 서브 시스템 (wxmall, 즉 weixin mall)

  litemall-wx-api 모듈, litemall-wx 모듈 및 renard-wx 모듈로 구성됩니다.

* 가벼운 쇼핑몰 서브 시스템 (mobmall, 즉 모바일 쇼핑몰)

  litemall-wx-api 모듈과 litemall-vue 모듈로 구성됩니다.
  모바일 쇼핑몰 서브 시스템의 백엔드는 소형 쇼핑몰 서브 시스템과 동일합니다.
    
* 관리 백그라운드 하위 시스템 (관리자)

  litemall-admin-api 모듈과 litemall-admin 모듈로 구성됩니다.

그리고 9 개의 모듈에서 3 개의 기술 스택에 대한 개발 및 설계 :

* Spring Boot 기술 스택

  IDEA 개발 도구를 사용하여 litemall-core, litemall-db, litemall-admin-api,
  litemall-wx-api 및 litemall-all에는 5 개의 모듈이 있습니다.
  
* Miniprogram (WeChat Mini Program) 기술 스택

  WeChat 애플릿 개발 도구를 사용하여 litemall-wx 및 renard-wx 모듈을 개발합니다.
  
* Vue 기술 스택

  VSC 개발 도구를 사용하여 litemall-admin 모듈 및 litemall-vue 모듈을 개발하십시오.

### 1.1.1 프로젝트 특징

이 프로젝트의 특징은 다음과 같습니다.

* 데이터베이스 측면에서는 단순한 테이블 일뿐 테이블과 테이블 간의 종속성 관계는 외래 키로 설계되지 않고 Java 코드에 의존하여 서비스 수준 또는 비즈니스 수준에서 보장합니다. 이것의 장점은 데이터베이스를 자주 변경하는 것이 매우 편리하고 외래 키로 인해 데이터베이스를 수정하는 것이 어렵지 않다는 것입니다.
* 세 가지 기술 스택이 관련되지만 각 기술 스택에는 가장 기본적인 기술 만 포함됩니다.
  * 백엔드 기술 스택은 Spring, Spring Boot, Spring MVC 및 Mybatis 기술 만 포함하며 다른 백엔드 기술은 일시적으로 사용되지 않습니다.
  * 공식 미니 프로그램 문서 만 포함하는 미니 프로그램 기술 스택
  * 프런트 엔드 기술 스택은 vue, vuex, vue-route 및 요소 기술 만 포함합니다.
* 보안 측면에서 가장 기본적인 코드 만 사용하여 간단하고 기본적인 보안 서비스를 제공합니다.
* 성능 측면에서 메모리 데이터베이스 캐시 기능을 포함하지 않지만 완전히 MySQL에 의존합니다.
* 개체 스토리지 서비스의 경우 로컬 스토리지 및 타사 클라우드 스토리지 솔루션을 지원합니다.
* 메시지 알림의 경우 이메일 알림, 타사 클라우드 SMS 알림 및 WeChat 템플릿 알림을 지원합니다.
* 간편한 배포, 다중 서비스 배포 및 원 클릭 배포 스크립트 지원
* 문서는 포괄적이며 아직 개발 중이지만 개발자가 프로젝트를 이해하는 데 도움이되도록 계획의 문서 및 코드 주석이 확실히 완료 될 것입니다.

요컨대, 현재 시스템은 학습 기술과 비즈니스를 위해 개발 된 단순한 쇼핑몰 프로토 타입 시스템 일뿐입니다. 엔터프라이즈 수준의 기능은 많지 않지만 완전하고 합리적인 프로토 타입 시스템입니다.

노트:
> 위의 기능이 반드시 장점은 아닙니다.

## 1.2 시스템 기능

비즈니스 기능 측면에서 현재 6 개의 비즈니스 모듈로 구성됩니다.

* 회원 사업 모듈
* 쇼핑몰 비즈니스 모듈
* 상품 비즈니스 모듈
* 프로모션 사업 모듈
* 시스템 비즈니스 모듈
* 비즈니스 모듈 구성

### 1.2.1 Small Mall 기능

* 집
* 주제 목록, 주제 세부 정보
* 카테고리 목록, 카테고리 세부 정보
* 브랜드 목록, 브랜드 세부 정보
* 신제품 출시, 인기 추천
* 그룹 구매
* 검색
* 제품 세부 정보
* 제품 평가 목록, 제품 평가
* 쇼핑 카트
* 주문
* 개인
* 주문 목록, 주문 세부 정보, 주문 후 판매
* 주소 목록, 주소 추가, 주소 삭제
* 수집, 발자국, 정보

### 1.2.2 라이트 몰 기능

** 현재 개발 중, 불안정 **

다음은 완료해야 할 기능입니다.

* 집
* 주제 목록, 주제 세부 정보
* 카테고리 목록, 카테고리 세부 정보
* 브랜드 목록, 브랜드 세부 정보
* 신제품 출시, 인기 추천
* 그룹 구매
* 검색
* 제품 세부 정보
* 제품 평가 목록, 제품 평가
* 쇼핑 카트
* 주문
* 개인
* 주문 목록, 주문 세부 정보
* 주소 목록, 주소 추가, 주소 삭제
* 수집, 발자국, 정보

### 1.2.3 관리 플랫폼 기능

* 회원 관리
  * 회원 관리
  * 배송 주소
  * 회원 수집
  * 회원 발자국
  * 검색 기록
  * 피드백
* 매장 관리
  * 행정 구역
  * 브랜드 제조사
  * 주문 관리
  * 상품 카테고리
  * 일반적인 질문들
  * 키워드
  * 채널 관리 (미정)
* 상품 관리
  * 상품 목록
  * 선반에 상품
  * 상품 편집기
  * 사용자 의견
* 프로모션 관리
  * 광고 관리
  * 주제별 관리
  * 단체 구매 규정
  * 그룹 구매 활동
* 시스템 관리
  * 관리자
  * 알림 관리
  * 개체 저장
  * 권한 관리
  * 타이밍 작업 (미정)
  * 작업 로그
* 구성 관리
  * 쇼핑몰 구성
  * 미니 프로그램 구성
  * 배송 구성
  * 주문 구성
* 통계 보고서
  * 사용자 통계
  * 주문 통계
  * 상품 통계
* 개인
  * 알림 센터
  * 비밀번호 변경

## 1.3 프로젝트 기술

### 1.3.1 기술 참조

#### 1.3.1.1 스프링 부트 기술

Spring Boot 기술 스택에 대해서는 다음 문서 또는 프로젝트를 참조하십시오.

1. MySQL

   데이터베이스 및 테이블 생성, 추가, 쿼리, 업데이트 및 삭제 방법을 알아 봅니다.
    
2. 스프링 부트 2.x

    * https://docs.spring.io/spring-boot/docs/2.1.5.RELEASE/reference/htmlsingle/#getting-started-introducing-spring-boot
    * https://docs.spring.io/spring-boot/docs/2.1.5.RELEASE/reference/htmlsingle/#using-boot-maven

    여기에서 RestController, Service 및 자동화 된 구성을 사용하는 방법과 같은 주석을 이해해야합니다.
    Spring Boot는 많은 기능을 지원하며 개발자는 사용할 때 참조 할 수 있습니다.
    
3. Mybatis

    * http://www.mybatis.org/mybatis-3/
    * http://www.mybatis.org/mybatis-3/java-api.html
    * http://www.mybatis.org/mybatis-3/sqlmap-xml.html
 
    여기서 간단히 이해할 수 있으며 Mybatis Generator를 사용하여 Java 코드를 생성 할 수 있습니다.
    
4. Mybatis 생성기

    * http://www.mybatis.org/generator/running/runningWithMaven.html
    * http://www.mybatis.org/generator/generatedobjects/results.html
    * http://www.mybatis.org/generator/generatedobjects/exampleClassUsage.html
    
5. Mybatis PageHelper

    * https://github.com/pagehelper/Mybatis-PageHelper/blob/master/wikis/en/HowToUse.md
    
#### 1.3.1.2 미니 프로그램 기술

1. 미니 프로그램

    * https://developers.weixin.qq.com/miniprogram/dev/index.html
    * https://developers.weixin.qq.com/miniprogram/dev/component/
    * https://developers.weixin.qq.com/miniprogram/dev/api/
    * https://developers.weixin.qq.com/community/develop
    
    미니 프로그램에 문제가 발생하면 공식 커뮤니티에서 찾을 수 있습니다.

2. 위챗 페이

    * https://pay.weixin.qq.com/wiki/doc/api/wxa/wxa_api.php?chapter=7_3&index=1
    
#### 1.3.1.3 Vue 기술

1. Vue

    * https://cn.vuejs.org/index.html

2. 반트

    * https://youzan.github.io/vant/#/zh-CN/intro

3. 요소

    * https://element.eleme.cn/#/zh-CN/component/installation

4. vue-element-admin

    * https://github.com/PanJiaChen/vue-element-admin
    * https://panjiachen.github.io/vue-element-admin-site/zh/
    
### 1.3.2 프로젝트 단계

다음으로, 프로젝트 개발, 배포 (테스트) 및 출시의 3 단계에서 litemall을 소개합니다.

! [] (./ pics / project / stage.png)

명확해야 할 첫 번째 단계는 세 가지 단계입니다.

* dev

즉, 개발 또는 개발은 여기서 개발 단계를 나타내며 일반적으로 코드는 로컬에서 직접 컴파일, 실행 및 테스트됩니다.
또한 여기서 서비스 액세스 주소는 일반적으로 localhost입니다. 여기서 "사용자"는 주로 개발자 자신을 나타냅니다.

* 배포

여기에서는 배포 (테스트 단계)를 나타내며 일반적으로 코드는 원격 서버에서 컴파일 및 패키징되고 실행됩니다.
외부에서 제공 할 수 있습니다. 또한 여기서 서비스 액세스 주소는 일반적으로 IP 주소입니다. IP가 공용 IP 인 경우
배포 후 외부에서 제공 할 수 있으며 인트라넷 주소 인 경우 인트라넷에서만 액세스 할 수 있습니다. 여기서 "사용자"는 주로
개발자 자체, 테스터를 의미합니다. 물론 로컬 영역 네트워크이거나 IP 액세스를 신경 쓰지 않는 경우 여기에서 "사용자"가됩니다.
최종 사용자 일 수도 있습니다.

* 찌르다

즉, 제품 또는 생산, 여기서는 온라인 단계를 나타내며, 일반적으로 코드는 외부 서비스를 위해 원격 서버에서 컴파일 및 패키징되고 실행됩니다.
또한 여기서 서비스 액세스 주소는 일반적으로 도메인 이름 주소이고 포트는 80web 포트입니다. 온라인에 접속하면 최종 사용자와 직접 마주하게됩니다.
서비스 코드 자체와 dep는 정확히 동일하지만 시나리오가 다르므로 운영 환경은 온라인 단계에서 수행해야 할 수 있습니다.
역방향 프록시를 사용하여 실제 내부 프로젝트 구조를 보호하는 것과 같은 조정. 또한 가장 큰 차이점은 온라인 환경에서 도메인 이름과 포트 80을 사용하는 것입니다.
배포 단계는 더 무료입니다.

둘째, 여기의 세 단계는 단순한 문서화가 아니라 프로젝트 자체의 동작에 직접적인 영향을 미친다는 점을 분명히해야합니다.
그리고 코드 컴파일 결과, 따라서 개발자는 명확한 이해가 필요합니다.

마지막으로 dep와 prod는 순차적 인 관계가 없습니다. 예를 들어 개발자가 이미 도메인 이름과 프로덕션 환경을 가지고있는 경우 직접
dep 단계를 건너 뛰고 온라인 환경에서 직접 배포하십시오. 따라서 때로는 배포 및 출시가 여기에서 한 단계입니다.

물론 첫 번째 개발 단계에서 첫 번째 개발 단계에서 도메인 이름 및 https 인증서와 같은 업무와 관련이없는 작업과의 간섭을 피할 수 있기 때문에 먼저 dep 한 다음 prod하는 것이 좋습니다.

또한 일부 비즈니스 기능 (예 : WeChat 결제)은 도메인 이름 액세스 여야하므로 개발 및 배포 단계를 먼저 시뮬레이션하거나 건너 뛸 수 있습니다.
이러한 비즈니스 기능을 먼저 개발하고 테스트하지 말고 이러한 온라인 환경을 개발하기 전에 다른 기능이 개발되고 성공적으로 배포 및 테스트 될 때까지 기다리십시오.
기능 실행을위한 좋은 기반이있을 것입니다.

다음으로 개발 단계, 배포 단계 및 온라인 단계에서 각각 다른 솔루션의 요점을 소개합니다.

## 1.4 개발 계획

! [] (./ pics / project / develop-stage.png)

그림에서 볼 수 있듯이 현재 개발 단계 계획 :

* MySQL 데이터 액세스 주소`jdbc : mysql : // localhost : 3306 / litemall`
* litemall-wx-api 백엔드 서비스 주소`http : // localhost : 8080 / wx`, 데이터는 MySQL에서 가져옴
* litemall-admin-api 백엔드 서비스 주소`http : // localhost : 8080 / admin`, 데이터는 MySQL에서 가져옴
* litemall-admin의 프런트 엔드 액세스 주소는`http : // localhost : 9527`이고 데이터는 litemall-admin-api에서 가져옵니다.
* litemall-wx에는 프런트 엔드 액세스 주소가 없지만 WeChat 애플릿 도구에서 직접 컴파일, 테스트 및 개발하며 결국 공식 WeChat 플랫폼에 배포됩니다 (즉, 웹 서버를 직접 배포 할 필요가 없음). 데이터는 litemall-wx-api에서 가져옵니다.


### 1.4.1 데이터베이스

데이터베이스 환경 설정 과정은 다음과 같습니다.

1. MySQL을 설치합니다.

2. 데이터베이스, 사용자 권한, 데이터베이스 테이블 및 테스트 데이터를 만듭니다.
   데이터베이스 파일은 litemall-db / sql 폴더에 저장되며 개발자는 MySQL에 저장하도록 요청합니다.
   다음 스크립트를 순서대로 실행하십시오.
   * 데이터베이스, 사용자 및 권한을 생성하는 데 사용되는 litemall_schema.sql
   * litemall_table.sql, 테이블 생성에 사용
   * litemall_data.sql, 테스트 데이터를 가져 오는 데 사용됩니다.

노트:
> 명령 줄 또는 MySQL Workbench를 사용하는 것이 좋습니다. Navicat을 사용하는 경우 가져 오기가 실패 할 수 있습니다.

개발자가 litemall_schema.sql을 실행하지 못하면 파일을 열 수 있습니다.
```
litemall이 있으면 데이터베이스를 삭제하십시오.
존재하는 경우 사용자 삭제 'litemall'@ '%';
데이터베이스 litemall 기본 문자 집합 만들기 utf8mb4 collate utf8mb4_unicode_ci;
litemall을 사용하십시오.
'litemall123456'로 식별되는 사용자 'litemall'@ '%'생성;
litemall. *에 대한 모든 권한을 'litemall'@ '%'에게 부여합니다.
플러시 권한
```
데이터베이스, 사용자 및 액세스 권한을 생성하기위한 여러 명령을 볼 수 있으므로 개발자는
명령 또는 도구는 여기에서 기능을 완료 할 수 있습니다.

### 1.4.2 Spring Boot 개발 환경

1. JDK8 설치 (Oracle JDK 또는 OpenJDK 일 수 있음)
2. Maven 설치
3. Git 설치 (선택 사항)
4. IDEA Community를 설치합니다. Maven 플러그인과 Git 플러그인을 설치하는 것이 좋습니다.
   여기에서는 IDEA 커뮤니티 버전이면 충분하며 IDEA 상용 버전은 필요하지 않습니다.
   Eclipse는 시도하지 않았지만 실행 가능해야합니다.
5. IDEA 가져 오기이 프로젝트
6. Maven 명령을 사용하여 종속 라이브러리 설치

   예 :
   ```
   cd litemall
   mvn 설치
   ```
   
   또는 IDEA의 Maven 플러그인을 사용하여이 프로젝트의 종속 라이브러리를 설치하고 '설치'를 클릭합니다.

    ! [] (./ pics / project / idea-maven-insatll.png)

7. Maven 명령으로이 프로젝트 컴파일

   예 :
   ```
   cd litemall
   mvn 컴파일
   ```

   이 시점에서 컴파일 된 파일을 포함하는 litemall-wx-api와 같은 모듈에 대한 더 많은 대상 폴더가 있음을 알 수 있습니다.
   
   또는 IDEA의 Maven 플러그인을 사용하여이 프로젝트를 컴파일하고 '컴파일'을 클릭합니다.
   
   IDEA를 사용하는 경우 현재 단계를 건너 뛰고 8 단계로 이동할 수도 있습니다 (이는 자동으로 컴파일 된 다음 런타임 중에 실행되기 때문입니다).
   
8. Maven 명령을 사용하여이 프로젝트의 모든 것을 실행합니다.

   예 :
   ```
   cd litemall / litemall-all
   mvn spring-boot : run
   ```
   
   IDEA를 사용하는 경우 litemall-all 모듈의 Application 클래스
   `Run Application.main ()`을 마우스 오른쪽 버튼으로 클릭하여 모듈을 실행하고
   
   ! [] (./ pics / project / idea-run-all.png)
   
   브라우저를 열고 다음을 입력하십시오.
    ```
    http : // localhost : 8080 / wx / index / index
    http : // localhost : 8080 / admin / index / index
    ```
    JSON 데이터가 나타나면 litemall-all 모듈이 정상적으로 작동하는 것입니다.
    
노트:
> 1. 위 단계에서는 Maven 명령 방법과 IDEA 방법이 모두 도입되었습니다.
> 그러나 개발자는 개발 단계에서 IDEA를 사용하는 것이 좋습니다.
> 2. 위의 단계는 실용적인 방법 일 뿐이며 개발자는이 단계를 고수하지 않고도 더 많은 것을 연습 할 수 있습니다.
> 물론 개발자가이 단계를 사용하지 않고 문제가있는 경우 직접 해결하시기 바랍니다.
> 3. 개발자가 IDEA를 사용하여 프로젝트를 가져 오거나 프로젝트를 실행할 때 일반적으로 litemall-admin 또는 litemall-vue 인 "소프트웨어 동결"현상이 발생할 수 있습니다.
> IDEA가 폴더에있는 많은 수의 파일을 인덱싱하려고 할 때 많은 종속 라이브러리가 node_modules 폴더에 자동으로 다운로드됩니다.
> IDEA가 중단됩니다. 구체적인 해결 방법은 [FAQ] (./ FAQ.md)를 참조하십시오.

### 1.4.3 WeChat Mini 프로그램 개발 환경

1. WeChat 애플릿 개발 도구를 설치합니다.
2.이 프로젝트의 litemall-wx 모듈 (또는 renard-wx 모듈) 폴더를 가져옵니다.
3. 컴파일하기 전에 litemall-all 모듈이 실행 중인지, litemall-wx 모듈의 config 폴더에있는 api.js가 올바른 백엔드 데이터 서비스 주소로 설정되었는지 확인하십시오.
4. 'Compile'을 클릭하면 데이터와 그림이 나타나면 정상적으로 실행됩니다.

노트:
> 개발자가 컴파일 한 후 사진과 데이터를 볼 수 있지만 WeChat 로그인 또는 WeChat 결제를 사용하면 확실히 실패합니다.
> 그 이유는 여기에있는 구성 정보가 appid 등 올바르게 설정되지 않았기 때문이며 자세한 구성은 1.4.5 항을 참조하십시오.

### 1.4.4 Vue 개발 환경

1. [nodejs] (https://nodejs.org/en/) 설치
2. 종속 라이브러리 설치
    
    ```
    cd litemall / litemall-admin
    npm install -g cnpm --registry = https : //registry.npm.taobao.org
    cnpm 설치
    ```
    
3. 컴파일 및 실행
    
    ```
    cnpm 개발자 실행
    ```
    그런 다음 브라우저를 열고`http : // localhost : 9527`을 입력합니다.
    관리 배경의 로그인 페이지가 나타나면 관리 배경의 프런트 엔드가 정상적으로 작동하고 있음을 의미합니다.
    
4. litemall-all 모듈이 실행 중인지 확인하고 'Login'을 클릭합니다. 성공적으로 로그인 할 수 있다면 관리 배경의 프런트 엔드와 백 엔드가 성공적으로 연결되어 정상적으로 실행되고 있음을 의미합니다.

이 프로젝트는 VSC (Visual Studio Code)를 사용하여 litemall-admin 모듈을 개발하며 개발자는 다른 친숙한 IDE도 사용할 수 있습니다.

### 1.4.5 프로젝트 구성

Spring Boot 개발 환경, Vue 개발 환경 및 애플릿 개발 환경을 설치 한 후 해당 모듈을 시작하면 이미 일부 데이터 또는 효과를 볼 수 있습니다.
그러나 아직 활성화되지 않은 일부 기능은 개발자가이를 올바르게 활성화하도록 구성해야하기 때문입니다.

** 프로젝트 구성 구조 **

1. 관리 백엔드 프런트 엔드, 즉 litemall-admin 모듈, 구성 파일은 litemall-admin에 있으며 구성 파일`env.development`,`env.deployment`가 있습니다.
그리고`.env.production`. 여기서 설정 정보는 동일하며 가장 중요한 설정은 관리 배경의 서비스 루트 주소 인`VUE_APP_BASE_API`입니다.

   * 개발 단계에서 개발자는`cnpm run dev` 명령을 실행하고`env.development` 구성 파일이 여기에 사용됩니다.
   * 배포 단계에서 개발자가`cnpm run build : dep` 명령을 실행하면`env.deployment` 구성 파일이 여기에 사용됩니다.
   * 온라인 단계에서 개발자가`cnpm run build : prod` 명령을 실행하면`.env.production` 구성 파일이 여기에 사용됩니다.

2. 작은 쇼핑몰의 프런트 엔드, 즉 litemall-wx 모듈, 구성 파일은`litemall-wx / project.config.json` 및`litemall-wx / api.js`입니다.
여기서 가장 중요한 구성 정보는`project.config.json`의`appid`이며 개발자는 자신이 적용한 appid를 설정해야합니다.
그리고 작은 쇼핑몰의 서비스 루트 주소 인`apis.js`의`WxApiRoot`.

    ```
    //이 기계를 개발할 때 사용
     var WxApiRoot = 'http : // localhost : 8080 / wx /';
    // LAN 테스트 사용
    // var WxApiRoot = 'http : //192.168.0.101 : 8080 / wx /';
    // 클라우드 플랫폼 배포에 사용
    // var WxApiRoot = 'http : //122.51.199.160 : 8080 / wx /';
    // 클라우드 플랫폼이 온라인 일 때 사용
    // var WxApiRoot = 'https : //www.menethil.com.cn/wx/';

    ```

3. 관리 백엔드 및 소규모 몰 백엔드, 즉 여러 Spring Boot 모듈, 구성 파일은 각 모듈의`litemall-xx / src / main / java / resources`입니다.
`application.yml` 및`application-xx.yml` 구성 파일. 여기에서 각 모듈에는 두 개의 구성 파일이 있지만 실제로는 현재 모듈 구성 정보가 있습니다.
이들은 모두`application-xx.yml` 파일에 있으며`application.yml` 파일은 다른 모듈의 구성 파일을 가져 오는 데만 사용됩니다.

   예를 들어 litemall-all 모듈의`application.yml` 내용은 다음과 같습니다.
   ```
    봄:
        프로필 :
            활성 : db, core, admin, wx
        메시지:
            인코딩 : UTF-8
    ```
    따라서 litemall-all 모듈을 시작할 때 프로그램은 먼저 litemall-all의`application.yml`을로드 한 다음`spring.profiles.active` 정보를 전달합니다.
    4 개의 구성 파일`application-db.yml`,`application-core.yml`,`application-admin.yml` 및`application.yml-wx`를 순서대로 다시로드합니다.
    
여기서 백엔드 서비스 모듈의 구성은 다음과 같습니다.

#### 1.4.5.1 로그 구성

개발자가 litemall-all 모듈을 시작하면 모듈의`logback-spring.xml` 파일을 구성해야합니다.
```
    <logger name = "org.mybatis"level = "ERROR"/>
    <logger name = "org.springframework"level = "ERROR"/>
    <로거 이름 = "org.linlinjava.litemall.core"level = "DEBUG"/>
<logger name = "org.linlinjava.litemall.db"level = "DEBUG"/>
    <로거 이름 = "org.linlinjava.litemall.admin"level = "DEBUG"/>
    <로거 이름 = "org.linlinjava.litemall.wx"level = "DEBUG"/>
    <로거 이름 = "org.linlinjava.litemall"level = "DEBUG"/>
```

특정 구성에 대해서는 Spring Boot 로그 구성 및 로그 백 로그 구성을 직접 학습하십시오.

`org.linlinjava.litemall.core`는 litemall-core 모듈의 로그 수준을 정의합니다.
`org.linlinjava.litemall.db`는 litemall-db 모듈의 로그 수준을 정의합니다.
`org.linlinjava.litemall.wx`는 litemall-wx-api 모듈의 로그 수준을 정의합니다.
`org.linlinjava.litemall.admin`은 litemall-admin-api 모듈의 로그 수준을 정의합니다.
`org.linlinjava.litemall`은 litemall의 모든 백엔드 모듈의 로그 수준을 정의합니다.

물론 백엔드 모듈 수준이 DEBUG 일 때 개발자가 여기서 litemall을 시작하면 로그가 많지 않다는 것을 알 수 있습니다.
코드 내부에 기록 된 로그가 많지 않아 개발자가 필요에 따라 추가 할 수 있기 때문입니다.

노트:
> 개발자가 litemall-wx-api 모듈을 독립적으로 시작하는 경우 litemall-wx-api 모듈을 구성해야합니다.
> 로그 구성 방법.

#### 1.4.5.2 데이터베이스 연결 설정

litemall-db 모듈의`application-db.yml` 파일에서 데이터베이스 연결 및 druid를 구성합니다.

```

봄:
  데이터 소스 :
    드루이드 :
      URL : jdbc : mysql : // localhost : 3306 / litemall? useUnicode = true & characterEncoding = UTF-8 & serverTimezone = UTC & allowPublicKeyRetrieval = true & verifyServerCertificate = false & useSSL = false
      드라이버 클래스 이름 : com.mysql.jdbc.Driver
      사용자 이름 : litemall
      비밀번호 : litemall123456
      초기 크기 : 10
      최대 활성 : 50
      최소 유휴 : 10
      최대 대기 : 60000
      pool-prepared-statements : true
      연결 당 최대 풀 준비 문 크기 : 20
      유효성 검사 쿼리 : SELECT 1 FROM DUAL
      대출시 테스트 : 거짓
      반환시 테스트 : 거짓
      유휴 상태 테스트 : 참
      축출 실행 간격 (밀리 초) : 60000
      필터 : 통계, 벽
```

#### 1.4.5.3 WeChat 로그인 구성

WeChat 로그인은 두 위치를 구성해야합니다.
첫 번째는 소규모 쇼핑몰 프런트 엔드의 litemall-wx 모듈 (또는 renard-wx 모듈)에있는`project.config.json` 파일의 appid입니다.
두 번째는 소규모 쇼핑몰 백엔드에있는 litemall-core 모듈의`application-core.yml` 파일입니다.
```bash
litemall :
  wx :
    앱 ID : wxa5b486c6b918ecfb
    앱 비밀 : e04004829d4c383b4db7769d88dfbca1
```

여기에서`app-id`와`app-secret`은 개발자가 [WeChat Public Platform] (https://mp.weixin.qq.com/)에서 등록해야합니다.

노트
> 개발자는 여기서 혼란 스러울 수 있습니다. 작은 쇼핑몰의 백엔드는 litemall-wx-api 모듈의`application-wx.yml` 파일에서 구성되어야합니다.
> litemall-core 모듈도 애플릿 appid 구성 정보에 의존하기 때문에`application-core.yml` 파일에 배치됩니다.

#### 1.4.5.4 WeChat 결제 구성

litemall-core 모듈의`application-core.yml` 파일에서 WeChat 결제를 구성합니다.
```
litemall :
  wx :
    mch-id : 111111
    mch-key : xxxxxx
    알림 URL : https://www.example.com/wx/order/pay-notify
```

여기서 'mch-id'및 'mch-key'는 개발자가 [WeChat Merchant Platform] (https://pay.weixin.qq.com/)에서 등록해야합니다.

여기서 'notify-url'은 프로젝트가 시작된 후의 WeChat 결제 콜백 주소 여야합니다. WeChat 결제 성공 또는 실패시,
WeChat 판매자 플랫폼은 콜백 주소로 성공 또는 실패 데이터를 전송하므로 주소가 다음과 같은지 확인해야합니다.
litemall-wx-api 모듈의 WxOrderController 클래스의 payNotify 메서드에서 제공하는 API 주소입니다.

개발 단계에서 일부 기술을 사용하여 임시 외부 네트워크 주소 매핑을 로컬로 구현할 수 있으며 개발자는 Baidu 키워드 "WeChat 인트라넷 침투"를 스스로 배울 수 있습니다.
```
litemall:
  notify:
    mail:
      # 이메일 알림 구성, 사서함은 일반적으로 새 주문 수신과 같은 비즈니스 알림을 수신하는 데 사용되며 sendto는 이메일 수신자, 일반적으로 쇼핑몰 운영자를 정의합니다.
      enable: false
      host: smtp.exmail.qq.com
      username: ex@ex.com.cn
      password: XXXXXXXXXXXXX
      sendfrom: ex@ex.com.cn
      sendto: ex@qq.com
```

구성 방법 :
1. 메일 서버가 smtp 서비스를 엽니 다.
2. 개발자는 구성 파일에서 'enable'값을 'true'로 설정하고 다른 정보는 해당 값을 설정합니다.
여기서는 QQ 사서함 만 테스트되었으며 개발자는 다른 사서함을 직접 테스트해야합니다.

애플리케이션 시나리오 :
현재 이메일 알림 시나리오도 매우 간단합니다. 사용자가 주문을하면 시스템이 자동으로 'sendto'사용자에게 이메일을 보내 사용자에게 주문 정보를 알려줍니다.
향후 확장을 계속 최적화해야 할 수도 있습니다. 물론 주문 정보에 대한 이메일 알림이 필요하지 않은 경우 기본적으로 사용 중지 할 수 있습니다.

구성이 성공적인지 확인하십시오.
정보를 구성한 후 개발자는 litemall-core 모듈의`MailTest` 테스트 클래스를 실행할 수 있습니다.
개별적으로 메일을 보낸 다음 메일함에 로그인하여 메일이 성공적으로 수신되었는지 확인합니다.

#### 1.4.5.6 SMS 알림 구성

litemall-core 모듈의`application-core.yml` 파일에서 SMS 알림 서비스를 구성합니다.
```
litemall:
  notify:
    # SMS 템플릿 알림 구성
     # SMS는 고객에게 전달 SMS 알림, 구성 형식에주의를 알리는 데 사용됩니다. template-name, template-templateId는 NotifyType 열거 값을 참조하십시오.
    sms:
      enable: false
      # Tencent Cloud SMS 인 경우 활성 값 tencent를 설정합니다.
       # 알리바바 클라우드 SMS 인 경우 활성 값 알리 윤 설정
      active: tencent
      sign: litemall
      template:
        - name: paySucceed
          templateId: 156349
        - name: captcha
          templateId: 156433
        - name: ship
          templateId: 158002
        - name: refund
          templateId: 159447
      tencent:
        appid: 111111111
        appkey: xxxxxxxxxxxxxx
      aliyun:
        regionId: xxx
        accessKeyId: xxx
        accessKeySecret: xxx
```        

구성 방법 :
1. Tencent Cloud SMS 플랫폼 또는 Alibaba Cloud SMS 플랫폼을 신청 한 다음 네 가지 시나리오에 대한 SMS 템플릿을 설정합니다.
2. 개발자는 구성 파일에서`enable` 값을`true`로 설정하고`active` 값을`tencent` 또는`aliyun`으로 설정합니다.
3. 그런 다음 Tencent Cloud SMS 플랫폼에서 적용한 appid 값과 같은 기타 정보를 구성합니다.
여기서는 Tencent Cloud SMS 플랫폼과 Alibaba Cloud SMS 플랫폼 만 테스트되었으며 개발자는 다른 SMS 클라우드 플랫폼을 직접 테스트해야합니다.

애플리케이션 시나리오 :
현재 SMS 알림 시나리오는 결제 성공, 확인 코드, 주문 전송 및 환불 성공의 네 가지 시나리오 만 지원합니다.
향후 확장을 계속 최적화해야 할 수도 있습니다.

구성이 성공적인지 확인하십시오.
정보를 구성한 후 개발자는 litemall-core 모듈의 휴대폰 번호 및 "SmsTest"테스트 클래스를 설정할 수 있습니다.
템플릿에 필요한 매개 변수 값은 'SmsTest'테스트 클래스를 독립적으로 시작하여 SMS를 보낸 다음 휴대폰이 SMS를 성공적으로 수신하는지 확인합니다.

SMS 템플릿 매개 변수의 이름 :
여기서 문제가있다. 즉, Tencent Cloud SMS의 공식 플랫폼에서 SMS 템플릿 형식을 적용하기위한 템플릿 매개 변수가 배열이다.
예 : "안녕하세요, 인증 코드는 {0}이고 시간은 {1}"입니다.
Alibaba Cloud SMS의 공식 플랫폼에서 SMS 템플릿을 신청하기위한 템플릿 매개 변수는 JSON입니다.
예 : "안녕하세요, 인증 코드는 {param1}이고 시간은 {param2}입니다."
현재 코드의 다양성을 유지하기 위해이 프로젝트는 배열을 사용하여 매개 변수를 전달하고 Alibaba Cloud 애플리케이션 템플릿의 매개 변수에 대한 특정 가정을합니다.
1. Tencent Cloud 모듈 매개 변수는 템플릿을 신청할 때 "안녕하세요, 확인 코드는 {0}이고 시간은 {1}입니다"와 같은 공식 설정을 따릅니다.
2. Alibaba Cloud 템플릿 매개 변수이 프로젝트는 개발자가 공식적으로 신청 한 매개 변수의 형식이 "{code : xxx, code1 : xxx, code2 : xxx}"를 사용해야한다고 가정합니다.
예 : "안녕하세요, 인증 코드는 {code}이고 시간은 {code1}"입니다. 개발자는`AliyunSmsSender` 클래스의`sendWithTemplate` 메소드를 확인할 수 있습니다.
소스 코드를 이해할 수 있습니다. 불합리하다고 생각되면 관련 코드를 직접 조정할 수 있습니다.

#### 1.4.5.8 물류 구성

물류 구성은 주로 [타사 특급 조류 서비스] (http://www.kdniao.com/api-track)를 기반으로하는 상품 물류 정보를 조회하는 것입니다.

litemall-core 모듈의`application-core.yml` 파일에서 익스프레스 버드 물류 서비스를 구성합니다.
```
litemall:
  notify:
  # 快鸟物流查询配置
  express:
    enable: false
    appId: "XXXXXXXXX"
    appKey: "XXXXXXXXXXXXXXXXXXXXXXXXX"
    vendors:
    - code: "ZTO"
      name: "中通快递"
    - code: "YTO"
      name: "圆通速递"
    - code: "YD"
      name: "韵达速递"
    - code: "YZPY"
      name: "邮政快递包裹"
    - code: "EMS"
      name: "EMS"
    - code: "DBL"
      name: "德邦快递"
    - code: "FAST"
      name: "快捷快递"
    - code: "ZJS"
      name: "宅急送"
    - code: "TNT"
      name: "TNT快递"
    - code: "UPS"
      name: "UPS"
    - code: "DHL"
      name: "DHL"
    - code: "FEDEX"
      name: "FEDEX联邦(国内件)"
    - code: "FEDEX_GJ"
      name: "FEDEX联邦(国际件)"
```        

구성 방법 :
1. [익스프레스 버드 플랫폼] (http://www.kdniao.com/) 애플리케이션
2. 개발자는 구성 파일에서 'enable'값을 'true'로 설정하고 다른 정보를 설정합니다.
익스프레스 버드 플랫폼의 appId 및 appKey.

애플리케이션 시나리오 :
소규모 쇼핑몰에서 주문 내역을 조회 할 때 상품이 배송 된 경우 소규모 쇼핑몰 백엔드에서 자세한 물류 정보를 반환합니다.

구성이 성공적인지 확인하십시오.
정보를 구성한 후 개발자는 litemall-core 모듈의 'ExpressTest'테스트 클래스에서 익스프레스 회사 코드 및 코드를 설정할 수 있습니다.
익스프레스 번호를 실제 테스트하고 독립적으로`ExpressTest` 테스트 클래스를 시작하여 물류 정보를 쿼리합니다.

노트:
> 일부 택배 회사 (예 : SF Express, Shentong Express 등)는 개발 환경에서 추적 쿼리를 지원하지 않습니다.
> 특정 지원 또는 사용 제한 사항은 [공식 정보] (http://www.kdniao.com/UserCenter/v2/UserHome.aspx)를 참조하십시오.

#### 1.4.5.9 오브젝트 스토리지 구성

오브젝트 스토리지, 즉 파일 저장 및 다운로드.

litemall-core 모듈의`application-core.yml` 파일에서 객체 스토리지 서비스를 구성합니다.

* 로컬 개체 저장소 구성
개발자가 현재 서버를 사용하여 업로드 된 파일을 저장하는 경우 다음을 구성해야합니다.
```
litemall :
  저장:
    # 현재 작업 객체 저장 모드는 local, aliyun, tencent, qiniu입니다.
    활성 : 로컬
    # 로컬 오브젝트 스토리지 구성 정보
    현지:
      storagePath : 스토리지
      #이 장소는 wx 모듈의 WxStorageController의 fetch 메소드에 해당하는 주소 여야합니다.
      주소 : http : // localhost : 8080 / wx / storage / fetch /
```

구성 방법 :
구성 파일은`active` 값을`local`로 설정하여 현재 오브젝트 스토리지 모드가 로컬 오브젝트 스토리지임을 나타냅니다.
그리고`storagePath`는 업로드 된 파일이 저장되는 경로이고`address`는 파일에 액세스하기위한 외부 경로입니다.

* Alibaba Cloud Object Storage 구성

```
litemall :
  저장:
    # 현재 작업 객체 저장 모드는 local, aliyun, tencent, qiniu입니다.
    활성 : aliyun
    알리 윤 :
      끝점 : oss-cn-shenzhen.aliyuncs.com
      accessKeyId : 111111
      accessKeySecret : xxxxxx
      bucketName : litemall
```

구성 방법 :
1. 알리바바 클라우드 공식 웹 사이트 등록
2. 구성 파일은`active`의`aliyun` 값을 설정합니다. 이는 현재 오브젝트 스토리지 모드가 Alibaba Cloud Object Storage임을 의미합니다.

* Tencent 클라우드 개체 스토리지 구성

```
litemall:
  storage:
    # 当前工作的对象存储模式，分别是local、aliyun、tencent、qiniu
    active: tencent
    # 腾讯对象存储配置信息
    # 请参考 https://cloud.tencent.com/document/product/436/6249
    tencent:
      secretId: 111111
      secretKey: xxxxxx
      region: xxxxxx
      bucketName: litemall
```

구성 방법 :
1. Tencent Cloud 공식 웹 사이트 등록
2. 구성 파일은`active` 값을`tencent`로 설정하여 현재 오브젝트 스토리지 모드가 Tencent Cloud Object Storage임을 나타냅니다.

* Qiniu 클라우드 개체 스토리지 구성
```
litemall:
  storage:
    # 当前工作的对象存储模式，分别是local、aliyun、tencent、qiniu
    active: qiniu
    # 七牛云对象存储配置信息
    qiniu:
      endpoint: http://pd5cb6ulu.bkt.clouddn.com
      accessKey: 111111
      secretKey: xxxxxx
      bucketName: litemall
```

구성 방법 :
1. Qiniu Cloud 공식 웹 사이트 등록
2. 구성 파일은`active`의`qiniu` 값을 설정합니다. 이는 현재 오브젝트 스토리지 모드가 Qiniu Cloud Object Storage임을 의미합니다.

#### 1.4.5.10 기타 구성

위의 구성 정보 외에도이 프로젝트에 대한 다른 구성이 있습니다.
현재는 기본값 만 사용되며 개발자는 스스로 새로운 구성 정보를 연습하거나 확장 할 수 있습니다.

## 1.5 배포 계획
 
섹션 1.4에서는 개발 단계에서 몇 가지 주요 개발 프로세스를 소개합니다. 이 섹션에서는 성공적인 코드 개발 후 프로젝트를 배포 할 때 몇 가지 주요 프로세스를 소개합니다.

우선 개발 과정에서 프로젝트에서 사용하는 서비스 주소가 로컬 주소, 즉 localhost임을 명확히해야하며, 배포 과정에서 구체적인 상황에 따라 적절한 서버 주소와 포트를 설정해야합니다.

둘째, 명확히해야 할 것은 모듈 간의 관계입니다.
  
  * litemall-wx-api 모듈에는 litemall-core 모듈과 litemall-db 모듈이 포함되며 이는 서버에 배포됩니다.
  * litemall-admin-api 모듈에는 서버에 배포 된 litemall-core 모듈과 litemall-db 모듈이 포함됩니다.
  * litemall-all 모듈은 litemall-wx-api 모듈과 litemall-admin-api 모듈을 패키징합니다.
  * litemall-wx 모듈은 WeChat 개발자 도구에 배포되며 데이터 API 주소는 litemall-wx-api가있는 서비스 qi 주소를 가리 킵니다.
  * litemall-admin에 의해 컴파일 된 정적 파일은 웹 서버 또는 tomcat 서버에 배치되고 서버 주소 설정은 3의 litemall-admin-api가있는 주소를 가리 킵니다.
  
마지막으로 ** 프로젝트가 클라우드 서버를 배포하는 경우 개발자의 배포 환경에 따라 다음 파일 또는 코드에서 해당 구성을 수정합니다. **

1. MySQL 데이터베이스에 대한 적절한 사용자 이름 및 암호 정보를 설정합니다.
2. 백엔드 서비스 모듈에 대한 적절한 구성 정보를 설정합니다.
3. 소형 몰 프론트 엔드의 litemall-wx 모듈`config / api.js`의`WxApiRoot`는 소형 몰의 백엔드 서비스의 서비스 주소를 설정한다.
4. litemall-admin 모듈`.env.deployment`의`VUE_APP_BASE_API`에서 백엔드 관리 서비스의 서비스 주소를 설정합니다.

실제로 최종 배포 계획은 유연합니다.

* 동일한 클라우드 서버에 Spring Boot 서비스를 설치할 수 있으며 litemall-admin, litemall-admin-api, litemall-wx-api의 세 가지 서비스를 제공합니다.
* litemall-admin 정적 페이지 배포 서비스를 배포하기 위해 단일 클라우드 서버에 하나의 tomcat / nginx 서버 만 설치할 수 있습니다.
  그런 다음 두 개의 Spring Boot 백엔드 서비스를 배포합니다.
* 타사 CDN을 사용하여 litemall-admin 정적 페이지를 호스팅 할 수도 있으며 개발자는 두 개의 백엔드 서비스를 배포합니다.
* 물론 여러 서버에서도 클러스터링을 사용하여 동시에 서비스를 제공합니다.

노트
> 1. '네이티브'는 현재 개발중인 머신을 의미합니다.
> 2. '클라우드 서버'는 개발자가 구매하여 배포 한 원격 서버를 의미합니다.

몇 가지 옵션이 아래에 간략하게 나열되어 있습니다.

### 1.5.1 단일 머신 단일 서비스 배포 계획

이 섹션에서는 Tencent Cloud를 기반으로 한 단일 서버 단일 서비스 배포 솔루션을 소개합니다. 데모를 위해 서버 데이터와 애플리케이션이 단일 클라우드 서버에 배포되는 시나리오를 대상으로합니다.
다른 클라우드도 가능해야합니다.

주요 프로세스는 클라우드 서버 생성, 우분투 운영 체제 설치, JDK 및 MySQL 애플리케이션 운영 환경에 따라 단일 Spring Boot 서비스 배포입니다.

! [] (./ pics / project / deploy-single.png)

#### 1.5.1.1 클라우드 서버

1. 클라우드 서버 생성

   관련 작업은 Tencent Cloud, Alibaba Cloud 또는 기타 클라우드 플랫폼의 공식 문서를 참조하십시오.
   권장되는 최소 구성은 ** 1 코어 2G **입니다.
   
2. 운영 체제 설치

   이 프로젝트는 우분투 16.04.1을 사용하지만 다른 운영 체제를 제한하지 않습니다.

3. 보안 그룹 생성

    ! [] (./ pics / project / security-group.png)

    현재 허용되는 포트 : 8080, 80, 443, 22, 3306
    
    노트:
    실제로 여기에는 포트 8080 만 필요하며 다른 포트를 허용하는 것은 개발 단계에서 테스트 및 디버깅을 용이하게하기위한 것입니다.
    특히 3306 포트는 MySQL의 원격 액세스 포트로 온라인 단계에서 닫으십시오.
    
4. SSH 키 설정 (선택 사항)

    개발자는 비밀번호없이 클라우드 서버에 로그인 할 수 있고 스크립트에서 애플리케이션을 자동으로 업로드하는 데 사용할 수있는 SSH 키를 설정하는 것이 좋습니다.

5. PuTTY를 사용하여 클라우드 서버에 원격으로 로그인

    개발자가 SSH 키를 설정하면 비밀번호없이 로그인 할 수 있고, 그렇지 않으면 계정과 비밀번호로 로그인 할 수 있습니다.
    
#### 1.5.1.2 OpenJDK8

Openjdk-8-jre는 여기에 설치할 수 있습니다.

```bash
sudo apt-get update
sudo apt-get install openjdk-8-jre
```

jre 대신 jdk를 사용하려면 다음을 실행할 수 있습니다.

```bash
sudo apt-get update
sudo apt-get install openjdk-8-jdk
```

노트
> 사용자가 Oracle JDK8 또는 기타 JDK 환경을 사용하려면 설치 관련 정보를 참조하십시오.

#### 1.5.1.3 MySQL

```
sudo apt-get update
sudo apt-get install mysql-server
sudo apt-get install mysql-client
```

如果配置MySQL，可以运行命令
```
sudo mysql_secure_installation
```

#### 1.5.1.4 项目打包

1. 在服务器或者开发机打包项目到deploy；
    ```
    cd litemall
    cat ./litemall-db/sql/litemall_schema.sql > ./deploy/db/litemall.sql
    cat ./litemall-db/sql/litemall_table.sql >> ./deploy/db/litemall.sql
    cat ./litemall-db/sql/litemall_data.sql >> ./deploy/db/litemall.sql
    
    cd ./litemall-admin
    cnpm install
    cnpm run build:dep
    
    cd ..
    mvn clean package
    cp -f ./litemall-all/target/litemall-all-*-exec.jar ./deploy/litemall/litemall.jar
    ```
    
    이 스크립트의 역할은 다음과 같습니다.
    
    1. 데이터베이스 파일을 deploy / db 폴더에 복사합니다.
    2. litemall-admin 프로젝트를 컴파일합니다.
    3. litemall-all 모듈을 컴파일하고 litemall-admin으로 컴파일 한 정적 파일을 다음 위치에 복사합니다.
       litemall-all 모듈의 정적 디렉토리입니다.
       
2. litemall 폴더 아래의 * .yml 외부 구성 파일을 수정합니다. litemall-all 모듈이 시작되면
    외부 구성 파일을로드하고 기본 jar 패키지 내의 구성 파일을 재정의합니다.
    예를 들어, 구성 파일의 일부 위치는 원격 서버의 IP 주소로 설정해야합니다.
    
이때 배포 배포 패키지 구조는 다음과 같습니다.

* 빈
deploy.sh 스크립트 및 reset.sh 스크립트를 포함하여 원격 서버에서 실행되는 저장소 스크립트

* db
litemall 데이터베이스 파일 저장

* litemall
litemall-all 바이너리 실행 패키지 및 litemall 외부 구성 파일을 포함하여 원격 서버에서 실행중인 코드를 저장합니다.

* 유틸리티
package.sh 스크립트 및 lazy.sh 스크립트를 포함하여 개발 서버에서 실행하는 스크립트를 저장합니다.
로컬 개발 서버에서 실행되기 때문에 개발자는 원격 서버에 업로드 할 필요가 없습니다.

#### 1.5.1.5 프로젝트 배포

1. 원격 서버 환경 (MySQL 및 JDK1.8)이 설치되어 있습니다. 클라우드 서버의 보안 그룹이 해당 포트를 허용하는지 확인하십시오.
2. db / litemall.sql 가져 오기
    ```bash
    cd /home/ubuntu/deploy/db
    mysql -h localhost -u $ROOT -p$PASSWORD < litemall.sql
    ```
3. 서비스 시작
    ```bash
    sudo service litemall stop
    sudo ln -f -s /home/ubuntu/deploy/litemall/litemall.jar /etc/init.d/litemall
    sudo service litemall start
    ```
4. 배포 성공 여부 테스트 (xxx.xxx.xxx.xxx는 클라우드 서버 IP 임）：
    ```
    http://xxx.xxx.xxx.xxx:8080/wx/index/index
    http://xxx.xxx.xxx.xxx:8080/admin/index/index
    http://xxx.xxx.xxx.xxx:8080/#/login
    ```

노트:
> 개발자는 위의 세 주소에 성공적으로 액세스 할 수 있지만 관리 배경에서 로그인을 클릭하면 네트워크 연결이 실패합니다.
> 이것은 아마도 개발자의 litemall-admin 모듈의`config / dep.env.js` 또는`condig / prod.env.js` 일 것입니다.
> 'http://xxx.xxx.xxx.xxx:8080/admin'과 같은 올바른 관리 백엔드 주소가 설정되지 않았습니다.

#### 1.5.1.6 배포 스크립트 배포

이전 프로젝트 패키징 및 프로젝트 배포에서는 배포에 수동 명령이 사용되었습니다.
여기에 몇 가지 스크립트를 작성하여 단순화 할 수 있습니다.

* util / packet.sh

개발 서버에서 실행하면 프로젝트를 자동으로 패키징 할 수 있습니다.

* util / lazy.sh

개발 서버에서 실행하면 프로젝트를 자동으로 패키징하고, 프로젝트를 원격 서버에 업로드하고, 시스템에 자동으로 로그인하여 프로젝트 배포 스크립트를 실행할 수 있습니다.
    
노트:
> 1. 개발자는 util / lazy.sh에서 해당 원격 서버 로그인 계정과 키 파일 경로를 설정해야합니다.
> 2. 개발자는 bin / reset.sh에서 원격 서버의 MySQL 루트 로그인 계정을 설정해야합니다.
    
* bin / deploy.sh

원격 서버에서 실행하면 서비스를 자동으로 배포 할 수 있습니다.

* bin / reset.sh

원격 서버에서 실행하면 자동으로 데이터를 가져오고 로컬에 업로드 된 사진을 삭제 한 다음 bin / deploy.sh 배포 서비스를 실행할 수 있습니다.

노트:
> 개발자는 bin / reset.sh에서 원격 서버의 MySQL 루트 로그인 계정을 설정해야합니다.

요약하면 개발자가 구성 정보를 설정 한 후 lazy.sh 스크립트를 로컬에서 실행하여 한 번의 클릭으로 자동 배포 할 수 있습니다.
```bash
cd litemall
./deploy/util/lazy.sh
```

그러나 설정해야하는 정보에는 민감한 보안 정보가 포함되어 있으므로 개발자는 여기에서 배포 폴더를 참조하는 것이 좋습니다.
그런 다음 자체 배포 폴더를 구현하여 외부 구성 파일 및 스크립트에있는 중요한 보안 정보를 적절하게 폐기하십시오 !!!

#### 1.5.1.7 Docker 배포 스크립트

이 프로젝트는 단순히 docker 배포 계획을 구현합니다. 자세한 내용은 docker 폴더를 참조하세요.

### 1.5.2 단일 머신 다중 서비스 배포 체계


### 1.5.3 클러스터 클라우드 배포 계획

이 프로젝트는 소규모 및 중소기업을위한 소규모 쇼핑몰 시스템이므로 예상되는 분산 배포 계획은 다음과 같습니다.

1. 전용 클라우드 데이터베이스 배포 데이터
2. 전용 클라우드 스토리지 솔루션
3. 특수 CDN은 관리 백그라운드에서 정적 파일을 배포합니다.
4. 클라우드 서버는 관리 백그라운드에서 백엔드 서비스를 배포합니다.
5. 하나 이상의 클라우드 서버가 소규모 쇼핑몰을위한 백엔드 서비스를 배포합니다.

환경 적 이유로 인해 공식적으로 테스트되지는 않았지만이 간단한 클러스터 시나리오는 가능해야합니다.
1.5.2 절에 설명 된 세 가지 서비스는 독립적이므로 여기에 배포하도록 확장하는 것이 매우 쉽습니다.

그러나 인터넷 스타일의 분산 클라우드 배포가 필요한 경우 현재 프로젝트 아키텍처 및 계획이이를 지원하지 않습니다.
최소한 각 기능 모듈은 독립적 인 서비스 시스템이어야합니다. 또한 단일 사인온 시스템, 클러스터 및 캐시를 도입해야합니다.
그리고 메시지 대기열 및 기타 기술. 따라서 개발자가 이러한 형태의 분산 솔루션이 필요한 경우 다른 프로젝트를 참조하십시오.

## 1.6 온라인 계획

섹션 1.5 배포 계획에서 다양한 배포 계획을 소개했지만 실제로 이러한 계획 중 어느 것도 공식 환경에서 즉시 사용할 수 없습니다.

1. 공식 환경에는 도메인 이름과 HTTPS 인증서가 필요합니다.
2. 소규모 쇼핑몰의 애플릿에는 서버 도메인 이름에 대한 액세스 요구 사항이 있습니다.

이 섹션에서는`www.example.com` 도메인 이름을 예로 사용합니다.

노트
>`www.example.com`은 실제 환경에서 도메인 이름이 아닌 예시로만 사용됩니다.

다음은 1.5.1을 기반으로 한 단일 서버 단일 서비스 온라인 솔루션입니다. 즉, 세 가지 유형의 데이터를 동시에 제공하는 모든 백엔드 서비스입니다.
* 관리 배경에 대한 프런트 엔드 파일을 제공합니다.
* 백엔드 프런트 엔드를 관리하는 데 필요한 데이터를 제공합니다.
* 소규모 쇼핑몰 프런트 엔드에서 필요한 데이터를 제공합니다.

! [] (./ pics / project / online-deploy.png)


개발자는 자신의 비즈니스를 기반으로 다른 온라인 솔루션을 채택 할 수 있습니다.

### 1.6.1 도메인

1. 도메인 이름을 등록합니다. 일반적으로 상업용 웹 사이트는`.com`을 사용합니다.
2. 도메인 이름을 서버의 공용 네트워크 IP로 확인하고`ping` 명령을 사용하여 확인이 성공했는지 확인합니다.
3. 제출

### 1.6.2 nginx

https://www.digitalocean.com/community/tutorials/how-to-install-nginx-on-ubuntu-16-04

#### 1.6.2.1 nginx 설치

명령 채택
```bash
sudo apt-get 업데이트
sudo apt-get nginx 설치
```

일부 문서에는 방화벽 설정이 필요하다고 표시되어 있지만 Tencent Cloud 서버 방화벽은 기본적으로 활성화되어 있지 않습니다.
개발자는 직접 설정을 사용하거나 사용하지 않을 수 있습니다.

브라우저를 열고 다음 주소를 입력하십시오.
```
http://www.example.com
```

이 시점에서 nginx의 시작 페이지가 표시되면 설치가 완료된 것입니다.

설치 후 :
* `/var/www/html`：기본 정적 웹 파일 디렉토리
* `/etc/nginx`:
* `/etc/nginx/nginx.conf`:
* `/etc/nginx/sites-avaiable`:
* `/etc/nginx/sites-enabled`:
* `/etc/nginx/snippets`:
* `/var/log/nginx/access.log`:
* `/var/log/nginx/error.log`:

#### 1.6.2.2 https

1. 인증서 신청
   
    [Tencent Cloud 도메인 이름 인증서 신청 절차] (https://cloud.tencent.com/document/product/400/6814)를 참조하세요.

2. 인증서 다운로드

    여기서는 nginx 폴더 아래의 키 파일 (예 :`1_www.example.com_bundle.crt` 및`2_www.example.com.key`)이 사용됩니다.

3. nginx에 인증서 배포

    [Tencent 클라우드 인증서 설치 가이드 라인] (https://cloud.tencent.com/document/product/400/4143)을 참조하세요.
    두 개의 키 파일을`/ etc / nginx` 폴더에 저장 한 다음`/ etc / nginx / nginx.conf` 파일을 수정합니다.
   ```
	  server {
		listen 443;
		server_name www.example.com;
		ssl on;
		ssl_certificate /etc/nginx/1_www.example.com_bundle.crt;
		ssl_certificate_key /etc/nginx/2_www.example.com.key;
		ssl_session_timeout 5m;
		ssl_protocols TLSv1 TLSv1.1 TLSv1.2;
		ssl_ciphers ECDHE-RSA-AES128-GCM-SHA256:HIGH:!aNULL:!MD5:!RC4:!DHE;
		ssl_prefer_server_ciphers on;
      }
   ```
   
4. nginx 다시 시작

브라우저를 열고 다음 주소를 입력하십시오.
```
https://www.example.com
```

이 시점에서 https 프로토콜의 nginx 시작 페이지를 볼 수 있습니다.

#### 1.6.2.3 리버스 프록시 스프링 부트 백엔드

/ etc / nginx / nginx.conf` 파일 수정, nginx 정적 웹 파일 디렉토리 구성
```
server {
    location / {
        proxy_pass  http://localhost:8080;
        proxy_set_header    Host    $host;
        proxy_set_header    X-Real-IP   $remote_addr;
        proxy_set_header    X-Forwarded-For $proxy_add_x_forwarded_for;
    }
}
```

브라우저를 열고 다음 주소를 입력하십시오.
```
https://www.example.com/wx/index/index
https://www.example.com/admin/index/index
https://www.example.com/admin/index/index
```

브라우저를 열고 다음 주소를 입력하십시오. 이때 백엔드 데이터를 보면 역방향 프록시 구성이 성공했음을 나타냅니다.

#### 1.6.2.4 사이트 전체 암호화

서버는 자동으로 http 요청을 https로 리디렉션합니다.

```
server {
    listen 80;
    server_name www.example.com;
    rewrite https://$server_name$request_uri? permanent;
}
```

브라우저를 열고 다음 주소를 입력하십시오.
```
http://www.example.com
```

요약하면, 구성의 위의 다른 측면 이후에 nginx의 최종 구성은 다음과 같습니다.
1. 인증서`1_www.example.com_bundle.crt` 및`2_www.example.com.key`는
    `/ etc / nginx /`폴더에 있습니다.
2.`/ etc / nginx / nginx.conf` 파일을 수정합니다. [이 프로젝트의 nginx.conf] (./ conf / nginx.conf)를 참조하십시오.
3. nginx 다시 시작

노트:
> 더 많은 구성 방법과 기능을 위해 개발자는 스스로 학습해야합니다.

### 1.6.3 소규모 쇼핑몰이 온라인 상태입니다

1.6.2.3 절의 "Reverse proxy Spring Boot backend"성공 이후 소규모 쇼핑몰의 백엔드가 성공적으로 런칭되었습니다.
다음은 소규모 쇼핑몰의 프런트 엔드 온라인 프로세스에 대한 소개입니다.

온라인으로 전환하기 전에 코드 또는 구성 파일을 수정해야합니다.
1. litemall-wx-api 모듈의 WxOrderController 클래스의 payNotify 메서드 링크를 적절한 주소로 바꿉니다.

   노트:
   > 모든 주소로 변경할 수 있지만 여기에 노출되어서는 안됩니다. 즉,이 주소는 WeChat 판매자 플랫폼입니다.
   > 이곳의 소규모 쇼핑몰 백엔드 서비스와의 상호 작용 API는 보안 위험에 노출 될 수 있습니다.
   
2. litemall-core 모듈은 application-core.yml로 구성해야합니다.

    ```
    litemall:
        wx:
            app-id: wxa5b486c6b918ecfb
            app-secret: e04004829d4c383b4db7769d88dfbca1
            mch-id: 111111
            mch-key: xxxxxx
            notify-url: http://www.example.com/wx/order/pay-notify
    ```
    
    여기서`litemall.wx.notify-url`은 이전 개발자가 사용자 정의한 주소입니다.
    
3. litemall-wx 모듈의`project.config.json` 파일에서 해당 값을 조정합니다.
   특히`appid`는 개발자가 적용한 appid로 설정해야합니다.

### 1.6.4 관리 배경이 온라인 상태입니다.

1.6.2.3 절의 "Reverse proxy Spring Boot backend"가 성공한 후 관리 백엔드가 성공적으로 시작되었습니다.
백엔드 관리의 프론트 엔드와 백엔드를 포함하고 백엔드 관리의 프론트 엔드 파일과 백엔드 데이터를 동시에 제공합니다.
물론 여기에서 개발자는 다음 파일 또는 코드에서 해당 구성을 수정하기 위해 자신의 온라인 환경이 필요합니다.

1. MySQL 데이터베이스에 대한 적절한 사용자 이름 및 암호 정보를 설정합니다.
2. 관리 배경의 백엔드 서비스 모듈에 대한 적절한 구성 정보를 설정하고 개발자는 deploy / litemall의 외부 구성 파일을 참조하는 것이 좋습니다.
   이는 개발자가 모듈 내부의 개발 구성 파일을 수정하지 못하게 할 수 있습니다.
3. 관리 백엔드 프론트 엔드의 litemall-admin 모듈`.env.production`의`VUE_APP_BASE_API`는 백엔드 관리 서비스의 서비스 주소를 설정합니다.

### 1.6.5 프로젝트 평가

이 프로젝트는 참조 프로젝트 일뿐 프로젝트 코드의 품질과 기능은 개발자의 최종 요구 사항을 충족 할 수 없습니다.
따라서 개발자는 프로젝트 코드 **를주의 깊게 평가해야합니다.

온라인에 접속하기 전에 관리자 사용자 이름과 비밀번호를 변경하시기 바랍니다. 여기서 기본값은 사용할 수 없습니다.

### 1.6.6 프로젝트 최적화

다음은 배포 계획에 표시되지만 온라인 계획에서 최적화 할 수있는 몇 가지 단계입니다.

#### 1.6.6.1 관리 백그라운드 프런트 엔드 파일 시작 최적화

litemall-admin에 의해 컴파일 된 프런트 엔드 파일은 처음로드 할 때 시간이 많이 걸리며 시작 속도를 최적화하려면 몇 가지 조치가 필요합니다.

* 정적 파일 호스팅 CDN

  이전 섹션에서 Spring Boot는 관리 백그라운드에서 정적 파일을 배포하는 데 사용되었습니다.
  여기에서 한 단계 더 나아가 CDN에 정적 파일을 호스팅 할 수 있습니다. 물론 요금이 부과됩니다.

* gzip 압축

* 동적 로딩

#### 1.6.6.2 백엔드 서비스의 내부 액세스

원래 백엔드 서비스 (소형 몰의 백엔드 서비스 및 관리 백엔드의 백엔드 서비스 포함)는 도메인 이름 또는 IP를 통해 직접 서비스 할 수 있으며 여기에서 nginx 역방향 프록시를 사용할 수 있습니다.
포트 80을 통해 백엔드 서비스에 액세스합니다. 따라서 다음과 같은 결과가 나타납니다.
* 사용자는 https 프로토콜 (nginx 역방향 프록시)의 포트 80에서 백엔드 서비스에 액세스 할 수 있습니다.
* 사용자는 http 프로토콜의 8080을 통해 백엔드 서비스 (봄 부팅)에 액세스 할 수도 있습니다.
http는 안전하지 않으므로 여기에 보안 위험이있을 수 있습니다.

또한 백엔드 서비스의 외부 액세스가 취소되면 사용자가 백엔드 서비스에 액세스하는 데 보안 https 프로토콜 만 사용할 수 있도록 보장 할 수 있습니다.
동시에 내부의 특정 기술 아키텍처 세부 사항도 외부로부터 보호 할 수 있습니다.

#### 1.6.6.4 nginx 최적화

개발자는 자신의 비즈니스 또는 아키텍처에 따라 최적화하는 것이 좋습니다.

### 1.6.7 프로젝트 보안

프로젝트가 공식적으로 시작되면 공식적으로 서비스됩니다. 그러나 동시에 보안 위험과 해커 공격이있을 수 있습니다.

이 섹션에는 몇 가지주의 사항 만 나열되어 있으며 개발자는 추가 및 개선 할 수 있습니다.

#### 1.6.7.1 계정 보안

여기에서 계정 보안에는 몰 측의 사용자 계정과 관리 백엔드 측의 관리자 계정이 모두 포함됩니다.

현재 계정 보안에는 다음과 같은 일부 보호 조치가 여전히 부족합니다.

* 사용자 암호가 실패하고 임계 값을 초과하면 확인 코드가 표시됩니다.
* 사용자 암호가 실패하고 임계 값을 초과하면 로그인이 취소됩니다.
* 사용자 암호가 임계 값을 초과하지 않을 경우 휴대폰 인증 코드가 필요합니다.

#### 1.6.7.2 주요 사업 기록

주문 또는 금전 관련 작업과 관련하여 개발자는 향후 검토를 위해 최대한 데이터베이스에 기록하는 것이 좋습니다.

#### 1.6.7.3 API 통합 조정

이 프로젝트는 레퍼런스 API 인터페이스를 공개했으며, BUG가 있으면 해커가 입구로 사용될 수 있습니다.
개발자는 보안 위험을 줄이기 위해 온라인으로 전환하기 전에 인터페이스를 균일하게 조정하는 것이 좋습니다.

#### 1.6.7.4 조정

프로젝트 관리 백엔드에는 조정 기능이 없으므로 개발자가 쇼핑몰의 상태가 정상인지 확인하기 위해 조정 기능을 개발할 것을 권장합니다.

#### 1.6.7.5 환불 취소 또는 제한

이 프로젝트는 자동 환불 기능을 지원하지 않지만 관리자를 통한 수동 환불은 관리 배경에서 환불 버튼을 클릭합니다.
그러나 해커가 허점을 통해 관리 배경에 진입하여 불합리한 환불 작업을 수행하는 등 여전히 숨겨진 위험이있을 수 있습니다.

따라서 개발자는 관리 배경에서 환불 버튼을 취소하고 환불 정보 만 유지하는 것이 좋습니다. 관리자는 로그인 할 수 있습니다.
WeChat 공식 결제 플랫폼은 환불 작업을 수행합니다.

또는 개발자가 특정 비즈니스 로직 또는 시나리오를 기반으로 관리 백엔드의 환불 기능을 제한하는 것이 좋습니다. 예를 들어, 요일 설정
환불 한도는 무제한 환불 작업이 없음을 보장합니다.

#### 1.6.7.6 리소스 제한 액세스

일부 API 작업에는 백엔드 서버 리소스가 포함되므로 제한된 리소스가 악의적으로 사용되지 않도록 특정 제한을 적용해야합니다.

제한된 리소스에는 다음이 포함될 수 있습니다.

* 확인 코드
* 사진 업로드

몇 가지 제한 사항은 다음과 같습니다.

* 단일 IP의 액세스 빈도 제한
* 사용자가 업로드하는 사진 수 제한

#### 1.6.7.n이 프로젝트의 진행 상황 추적

개발자가 BUG에 대한 피드백을 받으면이 프로젝트는 문제 해결에 우선 순위를 부여하고 적시에 패치를 업로드합니다.
따라서 개발자는이 프로젝트의 진행 상황을 추적하고 각 버그 수정의 커밋에주의를 기울이는 것이 좋습니다.

동시에 개발자가 발견 된 모든 BUG에 대해 즉시 피드백을 제공하기를 바랍니다.

현재 LTS 버전은 없으며 향후 사업이 안정되면 출시 될 수 있습니다.

## 1.7 프로젝트 관리

다음은 현재 프로젝트 개발의 몇 가지 핵심 사항입니다.

### 1.7.1 project.gitignore

현재 프로젝트의 .gitignore는 단일 파일이 아니지만 여러 모듈이 있습니다.
* deploy/.gitignore
* litemall-admin/.gitignore
* litemall-admin-api/.gitignore
* litemall-core/.gitignore
* litemall-db/.gitignore
* litemall-wx-api/.gitignore
* litemall-all/.gitignore
* .gitignore

개발자는 단일 .gitignore 파일을 사용할 수 있습니다.

### 1.7.2 자동 프로젝트 배포

#### 1.7.2.1 배포 배포

현재 프로젝트에는 배포 배포 폴더가 있습니다. 위의 섹션 1.5.1에서 Tencent Cloud 서버를 배포하는 데 사용되는 몇 가지 스크립트입니다.

과정은 다음과 같습니다.
1. util 스크립트는 프로젝트를 패키징하고 Tencent Cloud 서버를 업로드하는 데 사용되는 현재 개발 서버에서 실행 중입니다.
2. 프로젝트가 패키징되면 패키징 된 프로젝트의 관련 모듈이 litemall 및 db 폴더로 컴파일됩니다.
3. 데이터베이스를 설치하고 데이터를 가져오고 프로젝트 서비스를 시작하기 위해 클라우드 서버에서 bin 스크립트를 실행합니다.

여기서 배포 방법은 비교적 간단하고 융통성이 없으며 개발자는 자신의 프로젝트 스크립트를 참조하고 개발할 수 있습니다.

#### 1.7.2.2 .gitlab-ci.yml 배포

현재 지원되지 않음

#### 1.7.2.3 도커 배포

현재 지원되지 않음

### 1.7.3 프로젝트 코드 스타일

이 프로젝트에는 세 가지 기술 스택이 포함되므로이 세 가지 기술 스택에 대한 세 가지 코드 스타일도 있습니다.

개발자가 코드를 제공하려는 경우 코드가 가능한 한 여기의 사양을 준수하는지 확인하는 것이 좋습니다.

#### 1.7.3.1 Spring Boot 기술 스택 코드 스타일

여기의 코드 스타일은 IDEA의 기본 코드 스타일을 채택합니다.

코드를 수정 한 후 '코드'메뉴의 '코드 재 형식화'를 사용하여 코드 형식을 지정합니다.

#### 1.7.3.2 미니 프로그램 기술 스택 코드 스타일

여기에서 코드 스타일은 WeChat 개발자 도구의 기본 코드 스타일을 채택합니다.

코드를 수정 한 후 '편집'메뉴의 '코드 서식'을 사용하여 코드 서식을 지정합니다.

#### 1.7.3.3 Vue 기술 스택 코드 스타일

여기서 코드 스타일은 ESLint 구성 코드 스타일을 채택합니다. 자세한 내용은 vue-element-admin 아래의 프로젝트를 참조하십시오.
[ESLint 문서] (https://panjiachen.github.io/vue-element-admin-site/zh/guide/advanced/eslint.html),
특히`vscode는 ESLint` 콘텐츠를 구성합니다.

노트:
> Visual Studio Code 편집기에서 마우스 오른쪽 버튼을 클릭하면`Format Code` 옵션이 있지만이 방법은 사용하지 마십시오.
> VSC 및 ESLint 코드 스타일의 서식 코드 스타일이 정확히 같지 않을 수 있기 때문입니다.

### 1.7.4 Spring Boot 다중 모듈 다중 단계 구성

현재 백엔드 서비스는 구조가 명확하고 테스트하기 쉬운 Spring Boot 다중 모듈 솔루션을 채택하고 있습니다.

그러나 문제, 즉 다중 모듈 구성 종속성이 있습니다.
예를 들어 litemall-db 모듈에 데이터베이스 구성 정보가있는 경우 다른 모듈을 가져 오는 방법
litemall-db 모듈의 구성 정보는 어떻습니까?

가장 간단한 방법은 litemall-db 모듈의 구성 정보를 다른 모듈에서 자신의 모듈로 복사하는 것입니다.
응용 프로그램 구성 파일이 있지만 문제는 데이터베이스 정보가 변경되면 다른 모듈이
다시 수동 수정은 매우 불편합니다.

현재이 프로젝트는 'spring.profiles.active'기반의 메소드를 채택하고 있으며 세부 내용은 다음과 같다.
1. litemall-db 모듈에는 application.yml 및 application-db.yml의 두 구성 파일이 있습니다.
    application-db.yml 구성 파일에 데이터베이스 구성 정보를 저장합니다.
2. litemall-core 모듈에는 application.yml 및 application-core.yml의 두 구성 파일도 있습니다.
    코어 모듈의 일부 구성 정보는 application-core.yml 구성 파일 및 application.yml에 저장됩니다.
    다음과 같은 구성이 있습니다.
    ```
    spring:
        profiles:
            active: core, db
    ```
    따라서 litemall-core 모듈이 별도로 시작되면 application.yml 구성 파일을 먼저 읽은 다음
     시스템은`spring.profiles.active`에 따라 application-db.yml 및 application-core.yml 구성 파일을 읽습니다.
     따라서 litemall-db 모듈의 구성 파일을 자동으로 읽습니다.
3. 비유하자면 litemall-all 모듈에 application.yml 구성 파일이 있습니다. 여기서 내용은
    ```
    spring:
        profiles:
            active:  db, core, admin, wx
    ```
    따라서 시스템이 litemall-all 모듈을 시작한 후 먼저 application.yml 구성 파일을 읽은 다음
    `spring.profiles.active`는 application-db.yml, application-core.yml,
    4 개 모듈, application-admin.yml 및 application-wx.yml의 구성 파일.
    
그러나 위의 솔루션이 다중 모듈 구성 종속성 문제를 해결하더라도 다른 프로필을 지원하는 방법,
즉, 개발 단계, 테스트 단계 및 온라인 단계의 구성이 다릅니다.

이 프로젝트의 아이디어는 Spring Boot의 구성 로딩 시퀀스를 기반으로 여기에서 소개되며 외부 구성 파일을 사용하여 jar 패키지의 내부 구성 파일을 덮어 씁니다.
1. 개발 단계에서 시스템의 구성 정보는 모듈의 리소스 디렉토리 구성 파일에 있습니다.
2. 테스트 또는 배포 단계에서 시스템은 litemall.jar 바이너리 jar 패키지로 패키징되며 jar 패키지의 내부 구성 파일은 이전 파일입니다.
    개발 단계의 구성 파일에 대해서는 이때 litemall.jar의 동일한 수준 디렉토리에 동일한 구성 파일을 만듭니다. 이러한 구성 파일에서
    테스트 또는 배포 단계의 구성 정보가 저장됩니다. litemall.jar을 시작할 때 시스템은 현재 디렉토리의 구성 파일을 읽습니다.
    jar 패키지 내의 구성 파일은 더 이상 읽히지 않습니다.
3. 마찬가지로 온라인 단계에서 litemall.jar 패키지의 동일한 수준 디렉토리에 온라인 구성 파일을 만듭니다.

또한 아래와 같이 다른 사고 방식을 사용할 수 있습니다.
! [] (./ pics / project / maven-profile.png)
! [] (./ pics / project / spring-profile.png)
! [] (./ pics / project / yml-resource.png)

사실 원칙도 매우 간단합니다. 즉, 구성 파일은 application- {module}-{profile} .yml을 사용하여 여러 단계에서 서로 다른 모듈의 구성 요구 사항을 지원합니다.

### 1.7.5 프런트 엔드 및 백 엔드 확인

이 프로젝트는 프론트 엔드와 백엔드 분리 프로젝트로 사용자 나 관리자가 시스템에 데이터를 입력하면
데이터에는 두 가지 수준의 확인이 필요합니다.

* 첫 번째 계층은 매개 변수 형식을 확인하는 프런트 엔드 확인입니다.
* 두 번째 계층은 백엔드 검증으로, 매개 변수를 검증 할뿐만 아니라 비즈니스 시나리오에 따라 검증합니다.

노트
> 현재 프로젝트 검증 아이디어는 이렇지 만 실제 코드 검증은 완벽하지 않습니다.
> 예를 들어 프런트 엔드 인증 코드가 완벽하지 않아 사용자 경험이 저하됩니다.

### 1.7.6 백엔드 응답 오류 코드

백엔드 서비스의 응답 결과는 다음과 같습니다.
```
{
    errno： 错误码，
    errmsg：错误消息，
    data：  响应数据
}
```

errno가 0이면 데이터는 비즈니스 데이터를 저장합니다.
오류가 0이 아니면 서비스가 실패하고 errmsg가 특정 오류 정보를 저장합니다.

현재 errno는 네 가지 형태로 존재합니다.
* 4xx, 프런트 엔드 오류는 프런트 엔드 개발자가 백 엔드 인터페이스 사용 사양을 다시 학습해야 함을 나타냅니다.
  * 401, 매개 변수 오류, 즉 프런트 엔드가 백 엔드에 필요한 매개 변수를 전달하지 않았습니다.
  * 402, 매개 변수 값이 잘못되었습니다. 즉, 프런트 엔드에서 전달한 매개 변수 값이 백 엔드의 수신 범위를 충족하지 않습니다.
* 5xx, 백엔드 시스템 오류 (501 제외)는 백엔드 개발자가 계속해서 코드를 최적화하고 백엔드 시스템 오류 코드의 반환을 피해야 함을 나타냅니다.
  * 501, 확인에 실패했습니다. 즉, 백엔드에서 사용자가 로그인해야합니다.
  * 502, 시스템 내부 오류, 즉 적절하게 명명 된 백엔드 내부 오류가 없습니다.
  * 503, 비즈니스는 지원하지 않습니다. 즉, 백엔드가 인터페이스를 정의하지만 기능을 구현하지 않았습니다.
  * 504, 업데이트 데이터가 잘못되었습니다. 즉, 백엔드가 낙관적 잠금 업데이트를 사용하고 동시 업데이트 중에 데이터 업데이트 무효화가 있습니다.
  * 505, 데이터 업데이트 실패, 즉 백엔드 데이터베이스 업데이트 실패 (일반적인 상황에서 업데이트가 성공해야 함).
* 6xx, 관리 백엔드 비즈니스 오류 코드, 자세한 내용은 litemall-admin-api 모듈의`AdminResponseCode` 클래스를 참조하십시오.
* 소규모 쇼핑몰의 백엔드 비즈니스 오류 코드 7xx, 자세한 내용은 litemall-wx-api 모듈의`WxResponseCode` 클래스를 참조하십시오.

소규모 쇼핑몰의 백엔드는 4xx, 5xx, 6xx 오류 코드를 반환 할 수 있고, 관리 백엔드의 백엔드는 4xx, 5xx 및 7xx 오류 코드를 반환 할 수 있다는 점에 유의해야합니다.
이 디자인의 이유는 작은 쇼핑몰의 프런트 엔드를 관리 배경의 프런트 엔드와 다르게 취급하는 것이 편리하기 때문입니다.

소규모 쇼핑몰의 프런트 엔드 응답에서 오류 코드를 처리하는 방법에는 세 가지가 있습니다.
* 4xx라면 프론트 엔드 개발자가 백엔드 API를 요청하는 방식에 문제가 있음을 의미합니다.
예를 들어 백엔드에는 '이름'매개 변수가 필요하지만 프런트 엔드는 값을 전달하지 않습니다. 이때 백엔드는 '잘못된 사용자 이름'을 반환합니다.
여기서 프런트 엔드가 잘못 사용 되었기 때문에 말이되지 않습니다. 반대로 단순히 "매개 변수가 잘못되었습니다"를 반환하면 조기에 알 수 있습니다.
프런트 엔드 개발자에 문제가 있습니다.
* 5xx 인 경우 (501 제외) 백엔드 시스템에 오류가 있으며 백엔드 개발자가이를 수정하거나 최적화해야합니다.
프런트 엔드는 특정 페이지에 오류 정보를 반환하는 대신 요청 응답에서 5xx 오류를 균일하게 처리 할 수 ​​있습니다.
예를 들어 백엔드는 데이터베이스 업데이트 중에 예외가 발생했음을 나타내는 "데이터 업데이트 실패"를 반환하므로 프런트 엔드 요청 응답은
관리자가 적시에 백엔드 개발자에게 연락 할 수 있도록 통합되고 단순한 오류 "시스템 오류, 관리자에게 문의". 그리고 백엔드 개발자
특정 오류 코드 및 오류 정보를 평가해야합니다. 예를 들어 여기에서 "데이터 업데이트 실패"는 데이터 테이블 조정 필드 일 수 있습니다.
결과적으로 Java 코드의 모델 객체는 데이터베이스 테이블과 일치하지 않으며 백엔드 개발자는 시간 내에이를 복구 할 수 있습니다.
또한 501 검증 실패의 경우 프론트 엔드 요청 응답 부서에서 통합 방식으로 리디렉션 페이지를 처리 ​​할 수 ​​있습니다.
* 6xx이면 특정 업무 오류임을 의미하며, 이때 Front-end는 특정 업무 페이지에 오류 정보를 표시 함과 동시에
또한 백엔드 개발자는 최종 사용자에게 표시되기 때문에 훌륭하고 친숙한 비즈니스 오류 메시지를 작성해야합니다.

소규모 쇼핑몰의 프런트 엔드와 유사하게 백엔드 응답 오류 코드를 처리하기 위해 관리 배경의 프런트 엔드에 대해 세 가지 유사한 처리 방법이 있습니다.

노트:
> 여기서 4xx 및 5xx 오류 코드는 HTTP의 4xx 및 5xx 상태 코드와 동일하지 않습니다.

### 1.7.7 TODO

이 프로젝트에는 몇 가지 TODO가 있습니다. ** 적극 권장 ** 개발자는 문제가 있는지 신중하게 검토하고 온라인으로 전환하기 전에 해당 조정을 수행합니다.
개발자는 IDE를 사용하여 이러한 TODO를 찾을 수 있습니다.

몇 가지 중요한 TODO는 다음과 같습니다.

#### 1.7.7.1 WeChat 환불 TODO

관리 배경 관리자가 환불 버튼을 클릭하면 관리 배경이 WeChat 환불 API를 통해 WeChat 판매자 플랫폼에 환불을 요청합니다.
그러나 보안 관점에서 개발자는 WeChat 환불 코드를 삭제하고 WeChat 판매자 플랫폼에 로그인하여 수동으로 환불하는 것이 좋습니다.
또는 개발자는 SMS 인증 코드 구현과 같은 보안 관련 코드를 추가 할 수 있습니다.

`AdminOrderController` 클래스 참조

다시 말하지만,이 프로젝트는 어떤 결과도 초래하지 않습니다.

#### 1.7.7.2 불완전한 TODO

일부 비즈니스는 기본 기능 만 구현하므로 여기서 TODO는 개발자가 스스로 생각하도록 상기시킵니다.

#### 1.7.7.3 리팩터링 TODO

일부 비즈니스 요구 사항은 명확하지 않아 구현시 불합리한 위치로 이어질 수 있습니다.
개발자는 코드 로직을 검토합니다.
