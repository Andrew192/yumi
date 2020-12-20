# 일반적인 문제

## 1 작은 쇼핑몰

이것은 주로 litemall-wx-api, litemall-wx 및 renard-wx의 세 가지 모듈의 관련 문제를 나타냅니다.

### 1.1 미니 프로그램 WeChat 로그인 실패

현상:

미니 프로그램 WeChat 로그인 실패

이유:

미니 프로그램이 온라인 상태가되기 전에 개발자는 그가 신청 한 appid를 설정해야합니다. 그렇지 않으면 WeChat 로그인이 확실히 실패합니다.

풀다:

1. 제품 구매 과정 만 경험했다면 개발자는 계정 등록 및 로그인을 사용할 수 있습니다.
2. 개발자는 litemall-wx, renard-wx 및 litemall-core 모듈의 appid 정보를 신청 한 정보로 설정합니다.

### 1.2 appid가 수정되었지만 WeChat 로그인이 여전히 실패합니다.

현상:

WeChat 개발자 도구는 개발자가 신청 한 appid를 수정했으며 백엔드도 해당 정보를 업데이트했지만 WeChat 로그인은 여전히 ​​오류를보고했습니다.

이유:

캐싱 문제 일 수 있습니다. appid가 수정되었지만 WeChat 개발자 도구가 제때 업데이트되지 않았습니다.

풀다:

WeChat 개발자 도구에서 appid를 수정 한 후 litemall-wx 프로젝트 또는 WeChat 개발자 도구를 닫고 litemall-wx를 가져 오기 위해 다시 시작하십시오.

### 1.3 실제 전화 테스트가 비정상입니다.

현상:

WeChat 개발자 도구는 정상적으로 열리지 만 휴대폰이 작은 쇼핑몰을 스캔하고로드 한 후에는 페이지 구조 만 있고 데이터와 그림은 없습니다.

이유:

데이터 또는 사진에 액세스 할 수 없습니다.

풀다:

1. 소규모 쇼핑몰의 백엔드 서비스에 액세스 할 수 있는지, 모바일 브라우저를 통해 백엔드 서비스 주소 테스트에 액세스 할 수 있는지 확인
   * 소규모 쇼핑몰의 백엔드 서비스 주소가 localhost 인 경우 휴대폰에 접속할 수 없습니다.
   * 소규모 쇼핑몰의 백엔드 서비스 주소가 근거리 통신망 주소이고 휴대 전화가 근거리 통신망에 속하지 않습니다 (예 : 동일한 Wi-Fi가 아니거나 휴대 전화가 모바일 네트워크 인 경우).
   * 소규모 쇼핑몰 백엔드 서비스가 활성화되지 않음
2. 휴대폰 매장의 ** 디버깅 기능 **이 켜져 있습니다.

### 1.4 타사 휴대폰 테스트가 비정상입니다.

현상:

개발자 자신의 휴대폰 테스트는 정상이지만 타사 휴대폰 테스트는 비정상입니다.

풀다:

1. 소규모 쇼핑몰의 백엔드 서비스에 액세스 할 수 있고, 타사 모바일 브라우저를 통해 백엔드 서비스 주소 테스트에 액세스 할 수 있는지 확인합니다.
2. 타사 휴대폰 쇼핑몰의 ** 디버깅 기능 **이 켜져 있습니다.
3. WeChat Mini Program 플랫폼에서 제 3 자의 WeChat 계정을 ** Experiencer **로 설정합니다.

### 1.5 WeChat 결제 실패

현상:

작은 쇼핑몰에서 결제 할 수 없거나 클릭하여 결제시 항상 오류보고

이유:

개발자는 판매자 결제 권한이 있어야하며 다음 정보를 설정해야합니다.
```
litemall.wx.app-id =
litemall.wx.app-secret =
litemall.wx.mch-id =
litemall.wx.mch-key =
litemall.wx.notify-url =
```

풀다:

해당 결제 구성 정보를 설정하려면 '3.0 Small Mall 환경'을 참조하십시오.

### 1.6 결제는 성공했지만 상품은 아직 미결제 상태입니다

현상:

WeChat 개발자 도구에서 결제가 성공적으로 이루어졌지만 주문 페이지로 돌아갈 때 제품 주문은 여전히 ​​'미결제'상태로 표시됩니다.

그 이유는:

WeChat 플랫폼에서 결제가 완료되면 'wx.notify-url'에 지정된 주소로 결제 결과가 푸시됩니다.
따라서 개발자는`wx.notify-url`이 가리키는 액세스 링크에 성공적으로 액세스 할 수 있고 동시에 액세스 할 수 있는지 확인해야합니다.
정상적인 응답 결과를 반환 할 수 있습니다.

풀다:

1. 개발자가 WeChat 개발자 도구에서 결제를 테스트하는 경우 일부 인트라넷 침투 도구를 사용해야합니다.
'WxOrderController.payNotify'로 표시된 로컬 주소를 입력합니다 (예 : 'http : // localhots / wx / order / pay-notify').
'http://xxx.com/wx/order/pay-notify'와 같이 인터넷에서 액세스 할 수있는 주소로 변환하고 마지막으로
이 주소를 가리 키도록`wx.notify-url`을 설정합니다.

2. 개발자가 이미 서비스를 시작한 경우 'wx.notify-url'이 가리키는 액세스 링크가 정상적으로 작동하는지 확인하십시오.

## 2. 경영 배경

이는 주로 litemall-admin-api 및 litemall-admin의 두 모듈의 관련 문제를 나타냅니다.

### 2.1 로그인 및 연결 시간 초과, 관리자에게 문의

현상:

관리 백그라운드에 로그인 할 때 오류 메시지가 나타납니다. 로그인 연결 시간 초과

이유:

1. 첫째, 이것이 프런트 엔드 및 백 엔드 분리 프로젝트이며 프런트 엔드가 백 엔드에 요청을 전송한다는 것을 이해해야합니다.
2. 둘째, litemall-admin / src / utils / request.js 파일에서 오류가보고 된 위치를 이해해야합니다.
3. 마지막으로 연결 시간 초과는 백엔드로 보낸 요청이 오랫동안 응답하지 않았 음을 의미합니다. 여기에는 두 가지 가능성이 있습니다.
    * 실제 연결 시간 제한, 현재 request.js 파일 설정 요청 시간 제한 시간은 5 초이므로 실제로 5 초 백엔드가 가능합니다.
    제 시간에 데이터를 반환하지 못했습니다.
    * 존재하지 않는 주소에서 데이터를 요청하는 것과 같은 잘못된 연결 시간 초과는 자연스럽게 연결 실패를 반환합니다.

풀다:

잘못된 연결 시간 제한은 일반적으로 개발자의 잘못된 설정으로 인해 발생합니다.

1. 먼저 Chrome의 개발자 도구를 사용하여 백엔드의 로그인 페이지에서 요청한 특정 주소를 확인합니다.
2. 그런 다음 백엔드 서비스가 시작되었는지 여부와 요청 된 주소에 액세스 할 수 있는지 테스트합니다.
3. 마지막으로 설정이 올바른 경우 Chrome의 개발자 도구를 사용하여 로그인 페이지를보고 백엔드에서 데이터 정보를 다시 요청합니다.
설정이 잘못된 경우 해당 백엔드 서비스를 시작하십시오.

### 2.2 설치 실패 / 실패한 시작

현상:

`cnpm install`을 실행하지 못했습니다.

이유:

종속성을 다운로드하지 못할 수 있습니다.

풀다:

node_modules를 지우거나`cnpm install` 명령을 다시 실행하거나 Baidu 또는 Google을 사용합니다.

### 2.3 페이징 데이터가 비정상적으로 반환 됨

현상:

관리 배경이 많은 수의 페이징 페이지를 클릭하는 경우 (당시 실제 최대 데이터 페이지 수를 초과 함) 백엔드는 여전히 데이터를 반환 할 수 있습니다.

이유:

이것은 버그는 아니지만 쿼리 페이지가 실제 페이지를 초과 할 때 어떤 효과가 생성되어야하는지에 대한 개발자의 다른 이해입니다.
* 데이터의 마지막 페이지를 반환하는 것이 합리적 일 수 있습니다.
* 빈 데이터를 반환하는 것이 합리적 일 수 있습니다.

풀다:

litemall-db 모듈의 application-db.yaml 리소스 파일에서 Reasonable이 true입니다.

    pagehelper :
      helperDialect : mysql
      합리적 : 참
      supportMethodsArguments : true
      매개 변수 : count = countSql

개발자는 타당성을 false로 설정 한 다음 문제가 해결 될 수 있는지 확인할 수 있습니다.

## 3. 기본 시스템

이것은 주로 litemall-db, litemall-core 및 litemall-all의 세 가지 모듈의 관련 문제를 나타냅니다.


### 3.1 유효하지 않은 바인딩 문

현상:

때때로 (특히 코드를 재생성하기 위해 mybatis 생성기를 사용) 백엔드 서비스가 오류를보고 함

```
org.apache.ibatis.binding.BindingException : 유효하지 않은 바운드 문 (찾을 수 없음) : org.linlinjava.litemall.db.dao.XXXX
```

이유:

자동으로 생성 된 새 XML 파일이 제때 컴파일 폴더 대상으로 업데이트되지 않아 대상에있는 mybatis의 Java 코드가 XML 파일과 일치하지 않게됩니다.

풀다:

Maven 명령 또는 플러그인을 사용하여 프로젝트를 정리 한 다음 다시 컴파일하고 패키징합니다.
```bash
mvn clean
mvn 패키지
```
### 3.2 Unknown column

현상:

```
데이터베이스를 쿼리하는 중 오류가 발생했습니다. 원인 : com.mysql.jdbc.exceptions.jdbc4.MySQLSyntaxErrorException : '필드 목록'에서 알 수없는 열 'add_time'
org / linlinjava / litemall / db / dao / LitemallSystemMapper.xml에 오류가있을 수 있습니다.
오류에는 org.linlinjava.litemall.db.dao.LitemallSystemMapper.selectByExample-Inline이 포함될 수 있습니다.
매개 변수를 설정하는 동안 오류가 발생했습니다.
SQL : select id, key_name, key_value, add_time, update_time, deleted from litemall_system
원인 : com.mysql.jdbc.exceptions.jdbc4.MySQLSyntaxErrorException : '필드 목록'에서 알 수없는 열 'add_time'
```

이유:

시스템은 개발 중이므로 업무에 따라 데이터베이스 테이블이 지속적으로 조정되므로 개발자가 코드를 업데이트 한 후 직접 실행하면 현재 코드가 발생할 수 있습니다.
개발자의 현재 데이터베이스 테이블이 오래되어 데이터베이스 작업이 실패했습니다.

풀다:

데이터베이스에 오류가있는 경우 개발자가 데이터베이스를 다시 가져 오는 것이 좋습니다.

### 3.3 데이터베이스 가져 오기 실패

현상:

개발자가 직접 (또는 Navicat을 사용하여) litemall_schema.sql을 실행하면 작업이 실패합니다.

이유:

하위 MySQL 버전에서는`존재하는 경우 사용자 삭제`가 지원되지 않거나 Navicat에서 지원하지 않을 수 있습니다.

풀다:

먼저 litemall_schema.sql 파일을 직접 열어 보시면
```
litemall이 있으면 데이터베이스를 삭제하십시오.
존재하는 경우 사용자 삭제 'litemall'@ 'localhost';
데이터베이스 litemall 기본 문자 집합 만들기 utf8mb4 collate utf8mb4_unicode_ci;
litemall을 사용하십시오.
'litemall123456'로 식별되는 사용자 'litemall'@ 'localhost'생성;
litemall. *에 대한 모든 권한을 'litemall'@ 'localhost'에 부여합니다.
플러시 권한;
```

보시다시피 여기에는 주로 세 가지 작업이 완료됩니다.
* 데이터베이스 만들기
* 데이터베이스 사용자 생성
*이 사용자에게 모든 작업 권한 할당

따라서 개발자가 litemall_schema.sql을 실행하지 못한 경우 개발자가 직접 사용할 수 있습니다.
관련 SQL 명령을 사용하거나 SQL 도구를 사용하여 데이터베이스, 사용자를 만들고 작업 권한을 할당합니다.

또한 실제로 ** 개발자는 배포 중 또는 온라인으로 litemall_schema.sql을 실행해서는 안됩니다. **

## 4. 프로젝트

이것은 주로 다른 프로젝트 개발 관련 문제를 나타냅니다.

### 4.1 프로젝트를 IDEA로 가져올 때 멈춤

현상:

IDEA가 프로젝트를 가져올 때 많은 시간이 걸리거나 정지되거나 계속 미친 듯이 실행됩니다.

이유:

litemall-admin 모듈 및 litemall-vue 모듈의 node_modules 폴더에 의해 발생해야합니다.
node_modules는 litemall-admin 및 litemall-vue 모듈이 의존하는 프로젝트 라이브러리이며 거의 2 억 개의 파일이있을 수 있습니다.
IDEA가 설정되지 않은 경우 폴더를 구문 분석하고 색인을 생성하여 카드가 손상 될 수 있습니다.

해결책:

1. 먼저 IDEA를 닫은 다음 litemall-admin 및 litemall-vue 모듈에서 node_modules 폴더를 삭제합니다.
2. 그런 다음 각각 빈 node_modules 폴더를 만듭니다.
3. IDEA를 다시 열고 litemall-admin 모듈과 litemall-vue 모듈의 node_modules 폴더에 대한 Excluded 상태를 각각 설정합니다.
