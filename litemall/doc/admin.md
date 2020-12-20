# 4 litemall管理后台

프로젝트 기술 구조 :

* 관리 백엔드 프런트 엔드, 즉 litemall-admin 모듈
  * vue
  * vuex
  * vue-router
  * axios
  * 요소
  * vue-element-admin 4.2.1
  * 기타, package.json 참조
* 관리 백엔드, 즉 litemall-admin-api 모듈
  * 스프링 부트 2.x
  * 봄 MVC

현재 존재하는 문제 :

* '누락'홈페이지에 작은 구성 요소를 구현하고 클릭하면 해당 페이지로 이동합니다.
*`Missing`은 테이블의 모든 데이터 내보내기를 지원합니다.
* '개선'관리자 로그인 페이지가 느리게 열리고 속도 최적화
*`Improve` 주소 최적화, 현재 모든 클릭은 백그라운드를 요청하며 기존 데이터는 캐시되어야합니다.
*`Improve` vue 및 vue-element-admin은 제때 업데이트됩니다.

## 4.1 litemall-admin-api

이 섹션에서는 관리 배경의 백그라운드 서비스 모듈을 소개합니다.

### 4.1.1 인증 서비스

AdminAuthController 클래스 참조

### 4.1.2 사용자 관리 서비스

사용자 관리 서비스는 다음과 같이 세분화됩니다.
* 회원 관리 서비스, AdminUserController 클래스 참조
* 수신 주소 서비스, AdminAddressController 클래스 참조
* 회원 수집 서비스, AdminCollectController 클래스 참조
* 멤버 풋 프린트 서비스, AdminFootprintController 클래스 참조
* 검색 기록 서비스, AdminHistoryController 클래스 참조
* 의견 피드백 서비스, AdminFeedbackController 클래스 참조

### 4.1.3 쇼핑몰 관리 서비스

쇼핑몰 관리 서비스는 다음과 같이 세분화됩니다.
* 관리 영역 서비스, AdminRegionController 클래스 참조
* 브랜드 제조업체 서비스, AdminBrandController 카테고리 참조
* 상품 카테고리 서비스, AdminCategoryController 카테고리 참조
* 주문 관리 서비스, AdminOrderController 클래스 참조
* 일반 질문 서비스, AdminIssueController 클래스 참조
* 키워드 서비스, AdminKeywordController 클래스 참조

### 4.1.4 상품 관리 서비스

상품 서비스, AdminAdminController 클래스 참조

### 4.1.5 프로모션 관리 서비스

프로모션 관리 서비스는 다음과 같이 세분화됩니다.

* 광고 서비스, AdminAdController 클래스 참조
* 특별 서비스, AdminTopicController 클래스 참조
* 그룹 구매 서비스, AdminGrouponController 클래스 참조

### 4.1.6 시스템 관리 서비스

시스템 관리 서비스는 다음과 같이 세분화됩니다.
* 관리자 서비스, AdminAdminController 클래스 참조
* 오브젝트 스토리지 서비스, AdminStorageController 클래스 참조

### 4.1.7 기타 서비스

* 통계 서비스, AdminStatController 클래스 참조
* 개인 서비스, AdminProfileController 클래스 참조

### 4.1.8 보안

여기 보안은 Shiro를 기반으로합니다.

#### 4.1.8.1 인증

#### 4.1.8.2 계정 비밀번호 추가 솔트

WeChat 로그인 인 경우 계정과 비밀번호가 필요하지 않습니다.

사용자가 계정 및 비밀번호 형식으로 로그인하는 경우 백엔드는 사용자 비밀번호에 솔트를 추가해야합니다.

#### 4.1.8.3 액세스 제어

백엔드는 특정 보안 제어를 지원하기 위해 권한 관리 기능을 구현합니다.
자세한 내용은 4.1.9를 참조하십시오.

### 4.1.9 권한 관리

권한 관리는 권한 운영 기능 만 완료하고 데이터 권한 기능은 완전하지 않습니다.

#### 4.1.9.1 권한 디자인

데이터베이스 수준에서 권한 제어에는 세 개의 테이블`litemall_admin`,`litemall_role` 및`litemall_permission`이 포함됩니다.
* litemall_admin 테이블에는 역할 ID 배열을 저장하는 roleId 필드가 있습니다.
* litemall_role 테이블은 역할 이름과 역할 소개를 기록합니다.
* litemall_permission 테이블은 역할에서 사용하는 권한 값을 기록합니다.

이 세 가지 테이블을 통해 백엔드 수준의 권한 제어는 관리자의 역할과 소유 한 작업 권한을 구성 할 수 있습니다.
관리자가 로그인하여 권한으로 보호되는 일부 백엔드 주소에 액세스하면 백엔드는 현재 관리자의 작업 권한과 백엔드 주소에 필요한 작업 권한을 확인합니다.
일치하지 않으면 예외가 발생하고 프런트 엔드에 작업 권한이 없다는 메시지가 표시됩니다.

프런트 엔드 수준에서 권한 제어는 사용자에게 작업 권한을 표시하지 않을 수 있습니다.
그러나 프런트 엔드는 메뉴 권한 기능 및 버튼 권한 기능을 추가로 최적화 할 수 있습니다.
* 메뉴 권한, 즉 관리자가 로그인하면 프런트 엔드 메뉴가 자동으로 생성됩니다.
* 버튼 권한, 즉 관리자가 메뉴를 클릭하면 페이지로 이동하며 현재 관리자가 조작 할 수있는 버튼 만 페이지에 나타납니다.

위의 내용은 온라인 자료 및 오픈 소스 프로젝트에 대한 내용이지만 구현 세부 사항에 약간의 차이가있을 수 있습니다.

##### 4.1.9.1.1 5 개의 테이블 대신 3 개의 테이블

일반적으로 user, role, user_role, permission, role_permission의 5 개의 테이블이 있습니다.

그러나이 프로젝트에는 세 개의 테이블 만 필요합니다.
* user_role 테이블의 연관 관계는 user 테이블의 roles 필드를 통해 완료 할 수 있으므로 생략 할 수 있습니다.
* 권한 테이블이 생략되어있어 매우 이상 할 수 있지만 실제로는 가능합니다.

많은 오픈 소스 프로젝트의 권한 테이블은 현재 시스템의 모든 권한을 기록하고 마지막으로 관리 백엔드 사용자에게 제공합니다.
그러나 데이터 소스는 데이터 입력을위한 개발자 또는 시스템 사용자이지만 이것이 정말 합리적입니까?
* 개발자가 시스템을 개발 한 후 데이터베이스에 추가 권한 관련 콘텐츠를 작성해야하므로 두 단계의 독립적 인 단계가 있습니다.
  그다지 좋지 않을 수 있습니다. 또한 시스템이 업그레이드되고 새 권한이 완료되면 이러한 권한을 데이터베이스에 추가하는 방법도 있습니다.
  아주 좋은하지.
* 개발자가 권한 페이지를 디자인하고 시스템 관리자가 수동으로 새 권한을 추가하도록 지원하는 경우 실제로는 적절하지 않습니다.
  시스템 관리자가 URL 주소에 필요한 권한과 같은 시스템 권한을 이해하지 못할 수 있기 때문입니다.
  여기에있는 많은 오픈 소스 프로젝트에서이 접근 방식을 사용하지만 실제로 관리자는이를 전혀 이해하거나 사용하지 못할 수 있습니다.

여기서이 프로젝트는 [biu] (https://github.com/CaiBaoHong/biu) 프로젝트의 주석 방식을 나타냅니다.
시스템의 모든 권한은 데이터베이스의 권한 테이블 데이터를 통해 획득되지 않지만 현재 시스템은 주석을 통해 자동 분석됩니다.
모든 권한. 주석이기 때문에 개발자는 새로운 권한을 개발할 때 코드에 직접 작성하기 만하면됩니다.
데이터베이스에 다시 쓸 필요가 없습니다.

물론 이것은 3 개의 테이블이 좋다거나 5 개의 테이블이 좋지 않다는 것을 의미하지는 않으며, 개발자는 자신의 이해에 따라 그것을 할 수 있습니다.

이 프로젝트의 특정 구현에 대해서는 아래 세부 정보를 참조하십시오.

##### 4.1.9.1.2 세 가지 유형이 아닌 한 가지 유형의 권한 만 있습니다.

[biu] (https://github.com/CaiBaoHong/biu) 프로젝트에는 세 가지 유형의 권한이 있음이 분명합니다.
메뉴 권한 메타 데이터, 버튼 권한 메타 데이터, 인터페이스 권한 메타 데이터.
분명히 처음 두 권한은 프런트 엔드 권한에 해당하고 인터페이스 권한 메타 데이터는 백 엔드 권한입니다.

이 프로젝트는이 개념을 채택하지 않았습니다. 그 이유는 최종 관리자를위한 것이거나 IT를 이해하지 못할 수 있기 때문입니다.
일반 관리자의 경우 프런트 엔드 권한 페이지에 사용자가 확인할 수있는 세 가지 권한이있어 혼동을 일으킬 수 있습니다. 사실은,
프런트 엔드 페이지는 여전히 권한 효과가 있어야한다고 제안합니다.

이 프로젝트는 관리자 권한이 하나 뿐이지 만이 권한 자체는 메뉴 권한 메타 데이터, 버튼 권한 메타 데이터, 인터페이스 권한 메타 데이터에 해당합니다.
따라서 관리자가 권한을 선택하면 백그라운드 권한이 성공적으로 승인되고 프런트 엔드 메뉴 권한과 버튼 권한이 자동으로 조정됩니다.
구체적인 구현 세부 정보는 아래를 참조하세요.

백엔드 권한은 shiro를 기반으로 구현되며 관련 코드는 litemall-admin-api 모듈에 있습니다.

##### 4.1.9.2 기본 구성

1. config 하위 패키지의`ShiroConfig`는 Shiro를 소개하고 shirFilter, realm 및 sessionManager를 구성합니다.
2. shiroFilter 구성에서는 소수의 URL 만 익명으로 액세스 할 수 있으며 다른 URL은 로그인해야 액세스 할 수 있습니다.
3. Realm은 인증 및 권한 부여 기능에 사용되는 shiro 하위 패키지의`AdminAuthorizingRealm` 클래스를 설정합니다.
4. SessionManager는 세션 관리자를 재설정하는 데 사용되는 shiro 하위 패키지의`AdminWebSessionManager` 클래스를 설정합니다.
   기본 세션 관리자는 세션 보존을 위해 쿠키를 기반으로하며 여기에서는 세션 보존을 위해 사용자 지정 헤더를 기반으로합니다.

위의 단계를 마치면 shiro가 정상적으로 구성됩니다.
* 관리자가 로그인하면 먼저 인증합니다.
* 인증에 성공하면 권한을 부여하고 백엔드에서 역할과 권한을 저장하고 동시에 응답 헤더에 사용자 지정 헤더와 sessionId를 작성합니다.
* 인증에 실패하면 인증 예외가 발생합니다.
* 관리자가 페이지를 다시 방문하면 shiro는 사용자 정의 헤더를 통해 자동으로 인증합니다.

##### 4.1.9.3 권한 확인

그러나 위의 내용은 인증 기능 만 완료하고 권한 확인 기능은 완료하지 않습니다.
여기서 개발자는 Controller 클래스 메서드에서`RequiresPermissions` 주석을 사용해야합니다.
```
@RestController
@RequestMapping("/admin/ad")
public class AdminAdController {

    @RequiresPermissions("admin:ad:list")
    @RequiresPermissionsDesc(menu={"프로모션 관리", "광고 관리"}, button = "쿼리")
    @GetMapping("/list")
    public Object list(String name, String content,
                       @RequestParam(defaultValue = "1") Integer page,
                       @RequestParam(defaultValue = "10") Integer limit,
                       @Sort @RequestParam(defaultValue = "add_time") String sort,
                       @Order @RequestParam(defaultValue = "desc") String order) {
        List<LitemallAd> adList = adService.querySelective(name, content, page, limit, sort, order);
        int total = adService.countSelective(name, content, page, limit, sort, order);
        Map<String, Object> data = new HashMap<>();
        data.put("total", total);
        data.put("items", adList);

        return ResponseUtil.ok(data);
    }
}
```
특정 권한 확인 논리는 shiro에 의해 자동으로 완료됩니다.
1. 성공적인 로그인 또는 세션 로그인, shiro는 이미 현재 사용자의 권한 목록을 가지고 있습니다.
2. 접근 보호 방법에서 shiro는`RequiresPermissions` 주석을 통해 필요한 작업 권한 목록을 가져옵니다.
3. 할당 된 권한이 작업에 필요한 권한과 일치하는지 테스트하고 일치하면 메서드를 호출 할 수 있으며 그렇지 않으면 권한없는 예외가 발생합니다.

##### 4.1.9.4 권한 설명

주석 서브 패키지에 사용자 정의`RequiresPermissionsDesc` 주석이 있습니다.
```
@Target({ElementType.TYPE, ElementType.METHOD})
@Retention(RetentionPolicy.RUNTIME)
public @interface RequiresPermissionsDesc {
    String[] menu();
    String button();
}
```

여기에서 권한 설명 주석을 사용자 정의해야하는 이유를 논의하십시오.
> 백엔드에 대한 권한을 디자인 한 후 시스템 권한을 프런트 엔드로 보내야합니다. 관리자는 시스템의 모든 현재 권한을보고 역할에 대한 권한 구성을 허용 할 수 있습니다.
> 다음은 구현 문제입니다.
> 일부 오픈 소스 프로젝트는 시스템의 모든 권한을 기록하기 위해 데이터베이스에 권한 테이블을 디자인하지만 섹션 4.1.9.1.1에서는이 접근 방식의 제한 사항에 대해 설명합니다.
> 따라서 본 프로젝트는 권한 주석 (RequiresPermissions)을 사용할 때 개발자가 권한 문서 주석 (RequiresPermissionsDesc)을 사용해야하는 권한 주석 방식을 채택하고 있습니다.
> 이러한 방식으로 시스템은 권한 주석을 통해 권한 목록을 자동으로 생성하고 읽을 수있는 정보를 프런트 엔드에 반환 할 수 있습니다.

예 :
```
@RestController
@RequestMapping("/admin/ad")
public class AdminAdController {

    @RequiresPermissions("admin:ad:list")
    @RequiresPermissionsDesc(menu={"프로모션 관리", "광고 관리"}, button = "쿼리")
    @GetMapping("/list")
    public Object list(String name, String content,
                       @RequestParam(defaultValue = "1") Integer page,
                       @RequestParam(defaultValue = "10") Integer limit,
                       @Sort @RequestParam(defaultValue = "add_time") String sort,
                       @Order @RequestParam(defaultValue = "desc") String order) {
        List<LitemallAd> adList = adService.querySelective(name, content, page, limit, sort, order);
        int total = adService.countSelective(name, content, page, limit, sort, order);
        Map<String, Object> data = new HashMap<>();
        data.put("total", total);
        data.put("items", adList);

        return ResponseUtil.ok(data);
    }
}
```


이 프로젝트는`RequiresPermissions` 주석과`RequiresPermissionsDesc` 주석을 검색합니다 (util 하위 패키지의 PermissionUtil 클래스 참조).
`Permission` 클래스 모음은 내부적으로 생성됩니다.
```
public class Permission {
    private RequiresPermissions requiresPermissions;
    private RequiresPermissionsDesc requiresPermissionsDesc;
    private String api;
}
```

즉, 권한에는 제한 (RequirementsPermissions 값)뿐만 아니라 권한에 해당하는 오퍼레이션 API도 있습니다.
권한에 대한 설명도 있습니다 (requiresPermissionsDesc의 메뉴 및 버튼).

프런트 엔드 권한에 필요한 일부 권한 콘텐츠는 여기에서 간접적으로 생성 할 수 있습니다. 자세한 내용은 섹션 4.2.1을 참조하세요.

물론 여기서 주석을 사용하는 경우 데이터베이스에 권한 정보를 저장할 필요가 없다는 점을 지적해야합니다.
그러나 유연성 측면에서도 문제가있을 수 있습니다.

### 4.1.10 시간 지정 작업

작업 하위 패키지에는 다음과 같은 타이밍 작업이 있습니다.
* OrderJob 클래스
  * checkOrderUnpaid
  * checkOrderUnconfirm
  * checkOrderComment
* CouponJob 클래스
  * checkCouponExpired

노트:
> 시간이 지정된 작업이 AdminOrderController 클래스에 배치되어 있지만 여기에는 적합하지 않을 수 있습니다.
> 향후 조정 또는 개선이 필요합니다.

## 4.2 litemall-admin

이 장에서는 관리 백엔드의 프런트 엔드 모듈을 소개합니다.

litemall-admin 모듈의 코드는 [vue-element-admin] (https://github.com/PanJiaChen/vue-element-admin)을 기반으로합니다.


#### 4.2.1 프런트 엔드 권한

프런트 엔드 권한의 기능은 메뉴 또는 페이지 버튼을 숨기고 사용자 경험을 최적화하는 것임을 다시 한 번 분명히해야합니다.
실제로 실제 권한 보호 기능은 없습니다.

여기에서 프런트 엔드 확인에 대한 아이디어는 vue-element-admin 문서를 참조 할 수 있습니다.
* [라우팅 및 사이드 바] (https://panjiachen.github.io/vue-element-admin-site/zh/guide/essentials/router-and-nav.html)
* [인증 확인] (https://panjiachen.github.io/vue-element-admin-site/zh/guide/essentials/permission.html)

##### 4.2.1.2 역할 페이지

관리자의 역할 페이지는 역할을 만들고 권한을 할당하는 데 사용됩니다.

인증 버튼을 클릭하면 시스템의 모든 권한과 현재 할당 된 권한이 표시되며, 특정 코드는 AdminRoleController의 getPermissions에서 확인할 수 있습니다.
* 시스템의 모든 권한은 권한 설명 주석의 백엔드 자동 구문 분석을 통해 얻을 수 있습니다.
* 현재 할당 된 권한은 데이터베이스 액세스를 통해 얻을 수 있습니다.

#### 4.2.1.3 권한 API

vue-element-admin의 권한 검사는 역할별로 수행 된 권한 검사를 기반으로합니다.
일부 다른 오픈 소스 프로젝트에서는 권한 값을 기반으로 권한 확인이 수행됩니다.
이 프로젝트는 권한 URL을 기반으로 권한 확인을 완료하도록 조정되었습니다.

먼저 역할 기반 권한 확인이 그다지 좋지 않은 이유를 논의하십시오.

vue-element-admin의 권한 확인을 위해서는 메뉴 또는 페이지 버튼에 역할 정보를 작성해야합니다.
여기에서 원칙이 가능합니다. 그러나 문제가 있습니다. 즉, 관리자가 역할을 동적으로 생성한다는 것입니다.
따라서 메뉴 또는 페이지 버튼은 액세스에 필요한 역할을 직접 기록하므로 이후 유지 관리 및 업그레이드에 도움이되지 않습니다.

그런 다음 권한 값을 기반으로 한 권한 검사가 그다지 좋지 않은 이유를 논의하십시오.

프런트 엔드 분리 프로젝트에서 프런트 엔드와 백 엔드는 서로 다른 개발자가 개발해야합니다. 권한 값이 채택되면
이로 인해 앞뒤 끝이 단단히 결합 될 수 있습니다.
예를 들어 백엔드 개발자가 개발 한 API는`/ admin / ad / list`이고 백엔드 액세스에 필요한 권한 값은`admin : ad : list`입니다.
이때 프런트 엔드는 메뉴 나 페이지 버튼이 쓰여진 곳에`admin : ad : list'`를 써야합니다.
물론 이것은 원칙적으로나 작동 중에도 가능합니다. 그러나 프론트 엔드 개발자는 백엔드에 액세스하고 있음을 알아야합니다.
API에 해당하는 작업 권한 값입니다. 따라서 전면과 후면을 분리하는 좋은 방법이 문제가 될 수 있습니다.

이 프로젝트는 권한 URL 확인 방법을 기반으로합니다.

백엔드 권한 확인 로직은 여전히 ​​권한 값이고 프런트 엔드 권한 확인 로직은 URL입니다.
예를 들어 백엔드 개발자가 개발 한 API는`/ admin / ad / list`이고 백엔드 액세스에 필요한 권한 값은`admin : ad : list`입니다.
이때 프런트 엔드는 권한 값을 고려할 필요가 없으며 API에 액세스하는 방법 만 알면됩니다.
메뉴 또는 페이지 버튼 대신 'admin : ad : list'대신 'GET / admin / ad / list'를 작성합니다.
백엔드 권한은 (권한 값, 권한 설명, 권한 액세스 API)로 구성된 Permission 클래스이기 때문에 가능합니다.

물론 여기에는 특정 제한이 있습니다.

#### 4.2.1.4 메뉴 권한

`src / route / index.js`의 코드를 참조하세요.

예 :
```
  {
    path: '/promotion',
    component: Layout,
    redirect: 'noredirect',
    alwaysShow: true,
    name: 'promotionManage',
    meta: {
      title: '프로모션 관리',
      icon: 'chart'
    },
    children: [
      {
        path: 'ad',
        component: () => import('@/views/promotion/ad'),
        name: 'ad',
        meta: {
          perms: ['GET /admin/ad/list', 'POST /admin/ad/create', 'GET /admin/ad/read', 'POST /admin/ad/update', 'POST /admin/ad/delete'],
          title: '광고 관리',
          noCache: true
        }
      }
      }
    ]
  },
```

메뉴 메타의 perms 속성은 현재 메뉴에 필요한 작업 권한을 선언합니다.
관리자가 로그인 한 후 할당 된 작업 권한이 하나 이상있는 경우이 메뉴가 표시됩니다.
그렇지 않으면 메뉴가 숨겨집니다.


##### 4.2.1.4 버튼 권한

각 페이지에서 일부 구성 요소는 'v-permission'명령 또는 'checkPermission'함수를 사용하여 버튼 권한을 구현할 수 있습니다.

예 :`src / views / promation / ad` 페이지
```
    <div class = "filter-container">
      <el-input v-model = "listQuery.name"clearable class = "filter-item"style = "width : 200px;"placeholder = "광고 제목을 입력하세요"/>
      <el-input v-model = "listQuery.content"clearable class = "filter-item"style = "width : 200px;"placeholder = "광고 내용을 입력하세요."/>
      <el-button v-permission = "[ 'GET / admin / ad / list']"class = "filter-item"type = "primary"icon = "el-icon-search"@ click = "handleFilter"> 찾기 </ el-button>
      <el-button v-permission = "[ 'POST / admin / ad / create']"class = "filter-item"type = "primary"icon = "el-icon-edit"@ click = "handleCreate"> 추가 </ el-button>
      <el-button : loading = "downloadLoading"class = "filter-item"type = "primary"icon = "el-icon-download"@ click = "handleDownload"> 내보내기 </ el-button>
    </ div>
```

요소의`el-button` 구성 요소는 작업 권한이`GET / admin / ad / list'`임을 선언합니다.
관리자가 로그인 한 후 할당 된 작업 권한이 일치하면이 버튼이 표시됩니다.
그렇지 않으면 버튼이 숨겨집니다.

##### 4.1.1.5 권한 제한

프런트 엔드 권한 여기에서 코드 조정은 비합리적인 부분을 해결하기 위해 설계되었지만 실제로는
특정 제한 또는 제한.

다음은 개발자가 코드를 검토하거나 재 설계 할 수있는 몇 가지 가능한 문제입니다.

## 4.3 새로운 구성 요소 개발

이 장에서는 새로운 관리 배경 기능을 개발하는 방법을 소개합니다.

### 4.3.1 백엔드 프런트 엔드 페이지 관리

### 4.3.2 프런트 엔드 및 백엔드 양방향 서비스 API

### 4.3.3 백엔드 서비스 관리

### 4.3.4 데이터베이스
