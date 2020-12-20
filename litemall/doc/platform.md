# 2 litemall 기본 시스템

현재 litemall 기본 시스템은 다음 부분으로 구성됩니다.

* litemall-core 모듈
* litemall-db 모듈
* litemall-all 모듈
* 전 전쟁 모듈

litemall-db 모듈은 데이터베이스 액세스 서비스를 제공합니다.

litemall-core 모듈은 일반 서비스를 제공합니다.

litemall-all 모듈은 코드가 거의없는 패키지 모듈입니다. 이 모듈의 기능은 두 개의 스프링 부트 모듈을 통합하는 것입니다.
그리고 litemall-admin 모듈 정적 파일을 단일 Spring Boot 실행 가능 jar 패키지로 만듭니다.

litemall-all-war 모듈은 war 패키징을 사용한다는 점을 제외하면 litemall-all 모듈과 동일한 기능을 갖습니다.

## 2.2 litemall-db

litemall-db 모듈은 일반적인 Spring Boot 애플리케이션으로 mybatis 프레임 워크를 기반으로 데이터베이스 액세스 작업을 구현하고 외부 비즈니스 데이터 액세스 서비스를 제공합니다.

또한 litemall-db는 궁극적으로 다른 모듈에서 라이브러리로 사용되므로 외부가 아닙니다.
Spring MVC 기술을 사용하지 않고 직접 서비스합니다.

과학 기술:
* 스프링 부트 2.x
* MySQL
* 드루이드
* Mybatis
* PageHelper
* Mybatis 생성기
* Mybatis Generator 비공식 플러그인 mybatis-generator-plugin

! [] (./ pics / platform / db-main.png)

여기서 litemall-db 모듈은 다음 코드로 나눌 수 있습니다.

* mybatis 데이터베이스 액세스 코드
  * 생성기는 코드를 생성
  * 비 발전기 수동 코드
* 비즈니스 코드
* mybatis 생성기 지원 코드

### 2.2.1 Mybatis 데이터베이스 액세스 코드

mybatis 데이터베이스 액세스 코드는 dao 인터페이스 코드, dao 데이터베이스 XML 파일 및 도메인 코드를 참조합니다.
* dao 인터페이스 코드, 데이터베이스 액세스 인터페이스 선언
* dao 데이터베이스 XML 파일, 데이터베이스 액세스 작업 실현
* 도메인 코드는 데이터베이스에서 반환 된 데이터를 저장하는 것입니다.

또한 여기의 데이터베이스 액세스 코드는
* Mybatis 생성기는 자동으로 코드를 생성합니다. 즉, 위의 세 코드 또는 파일은 mybatis 생성기의 관련 플러그인을 기반으로 자동 생성됩니다.
* 비 mybatis 생성기 수동 코드, 위의 세 가지 코드를 직접 작성해야합니다.

#### 2.2.1.1 자동 코드 생성

! [] (./ pics / platform / mybatis-generator.png)

위 그림과 같이`mybatis-generator : generate`를 두 번 클릭하면 mybatis 생성기 플러그인이 다음을 수행합니다.

1.`mybatis-generator` 폴더에서`generatorConfig.xml` 파일을 읽습니다.
2.`jdbcConnection`에 따라 데이터베이스에 액세스합니다.
3. '테이블'에 따라 자동으로 생성되는 세 종류의 코드 :
   * src 폴더`org.linlinjava.litemall.db.dao` 패키지의 자바 코드
   * src 폴더`org.linlinjava.litemall.db.domain` 패키지의 Java 코드
   * 리소스 폴더`org.linlinjava.litemall.db.domain.dao`의 XML 파일

위의 세 코드는 데이터베이스의 작동을 캡슐화 할 수 있으며 개발자는 SQL 코드를 직접 조작 할 필요가 없습니다.
대신 Java 코드를 직접 조작하여 데이터베이스에 대한 액세스 처리를 완료하십시오.

mybatis 예제 코드를 기반으로 데이터베이스에 액세스하는 방법은 관련 정보를 참조하십시오.
또는이 모듈`org.linlinjava.litemall.db.service`의 패키지에있는 Java 코드를 참조하십시오.

물론 데이터베이스 액세스 효율성을 달성하기 위해 개발자는 매퍼 파일과 해당 Java 코드를 수동으로 사용자 지정할 수도 있습니다.
예를 들어, 두 테이블의 데이터에 액세스해야하는 경우 비즈니스 계층에서 Java 코드 순회 형식으로 두 테이블에 액세스해야합니다.
사용자 정의 매퍼 파일을 통해서도 가능합니다.

다음으로`litemall_brand` 테이블을 예로 들어 코드를 자동으로 생성하는 방법을 보여줍니다.

1. mybatis 생성기 플러그인은`table` 태그를 읽습니다.

    ```
    <generatorConfiguration>
         <table tableName="litemall_brand">
             <generatedKey column="id" sqlStatement="MySql" identity="true" />
         </table>
    </generatorConfiguration>
    ```
    
2. src 폴더 아래의 도메인 패키지에 LitemallBrand.java 및 LitemallBrandExample.java 자동 생성
     dao 패키지의 LitemallBrandMapper.java 인터페이스와 리소스 폴더 아래의 dao 패키지에있는 LitemallBrandMapper.xml 파일.

3. 서비스 패키지에 LitemallBrandService.java를 수동으로 생성하여 특정 서비스를 제공합니다.
    예를 들어 브랜드 목록을 얻으려면 이전에 만든 세 가지 Java를 기반으로 목록 메서드를 만듭니다.
   
   ```java
    @Service
    public class LitemallBrandService {
       @Resource
       private LitemallBrandMapper brandMapper;

        public List<LitemallBrand> query(int offset, int limit) {
           LitemallBrandExample example = new LitemallBrandExample();
           example.or().andDeletedEqualTo(false);
           PageHelper.startPage(offset, limit);
           return brandMapper.selectByExample(example);    
        }
    }
   ```

mybatis 생성기 사용에 대해서는 공식 웹 사이트 또는 문서를 직접 참조 할 수 있습니다.

#### 2.2.1.2 매뉴얼 코드

mybatis 생성기는 개발자가 개발 작업을 단순화하는 데 도움이되는 코드를 자동으로 생성 할 수 있지만 다중 테이블 작업이나 특수 데이터베이스 작업의 경우에는
개발자는 여전히 mybatis 프레임 워크를 기반으로 관련 코드를 수동으로 작성해야합니다.

특히 mybatis 프레임 워크를 기반으로 코드를 작성하는 방법은 직접 정보를 찾으십시오.

여기에서 통계 함수를 예로 들어 보겠습니다.

1. dao 코드

   src 폴더`org.linlinjava.litemall.db.domain` 패키지의 StatMapper.java 코드는 데이터베이스 액세스 인터페이스를 정의합니다.

2. 도메인 코드
 
   데이터베이스 작업이 데이터 모델을 반환하도록하려면 src 폴더`org.linlinjava.litemall.db.domain` 패키지에 해당 코드를 생성 할 수 있습니다.
   여기서 통계 함수는 도메인 코드를 정의하지 않고 단순화 된`List <Map>`을 사용하여 데이터를 저장합니다.

3. XML 파일

   리소스 폴더`org.linlinjava.litemall.db.domain.dao`의 StatMapper.xml 파일은 실제 데이터베이스 액세스 작업을위한 것입니다.

4. 서비스 코드

   여기서`org.linlinjava.litemall.db.service`에 StatServie.java 코드를 정의하고 기본 매퍼 코드를 호출하고 외부에서 제공 할 수 있습니다.
    ```
    @Service
    public class StatService {
        @Resource
        private StatMapper statMapper;

        public List<Map> statUser() {
            return statMapper.statUser();
        }

        public List<Map> statOrder(){
            return statMapper.statOrder();
        }

        public List<Map> statGoods(){
            return statMapper.statGoods();
        }
    }
    ```
   
### 2.2.2 비즈니스 코드

섹션 2.2.1에 설명 된 코드가 이미 데이터베이스 액세스 작업을 제공 할 수 있지만 여기에서 비즈니스 액세스 계층 코드를 더 추상화해야합니다.
즉, 2.2.1에 설명 된 코드와 실제 비즈니스 요구 사항을 기반으로 특정 비즈니스 관련 작업을 구현하고 다른 모듈에 대한 편리한 비즈니스 데이터 서비스를 제공합니다.

여기서 비즈니스 코드는 종종 단일 테이블과 관련된 비즈니스 코드이며 다중 테이블 작업을 포함하는 Java 코드는 일반적으로 다른 상위 수준 모듈에서 구현된다는 점을 지적해야합니다.
여기서 비즈니스 계층은 절대적인 것이 아닙니다. 예를 들어 개발자는 여기에서 비즈니스 코드를 취소하고 다른 모듈에서 2.2.1에 설명 된 코드를 직접 호출 할 수 있습니다.

일반적으로 비즈니스 계층 코드는 src 폴더`org.linlinjava.litemall.db.service` 패키지에 있습니다.

### 2.2.3 mybatis 생성기 지원 코드

mybatis 생성기가 자동으로 코드를 생성 할 때 데이터베이스 유형은 내장 유형 변환기를 통해 Java 클래스로 자동 변환됩니다.
예를 들어 데이터베이스 유형 'varchar'는 자동으로 'java.lang.String'으로 변환됩니다.

그러나 경우에 따라 TypeHandler를 사용자 지정하여 사용자 지정 형식 변환기를 사용할 수 있습니다.
개발자는 이해하기 위해 관련 자료를 읽을 수 있습니다.

이 프로젝트에서 데이터 테이블의 디자인을 단순화하기 위해 일부 필드는 'varchar'를 사용하여 데이터를 Json 형식으로 저장합니다.
예를 들어 특별한 제품 이미지 테이블을 디자인 할 필요없이`[url0, url1, ...]`을 사용하여 제품 이미지 목록을 직접 저장할 수 있습니다.

여기서 TypeHandler를 커스터마이즈하면 Java`String []`과 데이터베이스 유형`varchar` 간의 자동 변환이 가능합니다.

1. JsonStringArrayTypeHandler 클래스를 구현합니다.
2. mybatis 생성기 구성 파일에서 필수 필드를 구성합니다.
    ```
        <table tableName="litemall_goods">
            <columnOverride column="gallery" javaType="java.lang.String[]"
                            typeHandler="org.linlinjava.litemall.db.mybatis.JsonStringArrayTypeHandler"/>
        </table>
    ```
3. mybatis 생성기를 사용하여 자동으로 코드를 생성하면 LitemallGoods의 갤러리가`String []`유형임을 알 수 있습니다.

현재 두 개의 사용자 정의 TypeHandler 만 구현됩니다.
* JsonStringArrayTypeHandler 클래스는`String []`과`varchar` 간의 변환을 구현하며 저장된 JSON 데이터 형식은`[string0, string1, ...]`입니다.
* JsonIntegerArrayTypeHandler 클래스는`Integer []`와`varchar` 간의 변환을 구현하며 저장된 JSON 데이터 형식은`[integer0, integer1, ...]`입니다.

개발자가 JSON 데이터를 다른 형식으로 저장하거나 사용자 지정 형식으로 데이터를 저장해야하는 경우 직접 개발하십시오.

### 2.2.4 새로운 서비스 구성 요소

이 섹션에서는 테이블을 기반으로 새 서비스 구성 요소를 만드는 방법을 설명합니다.

1. 데이터베이스에 테이블을 만듭니다 (예 :`litemall_demo`).

    ```sql
    CREATE TABLE `litemall`.`litemall_demo` (
      `id` INT NOT NULL AUTO_INCREMENT,
      `name` VARCHAR(45) NULL,
      `address` VARCHAR(45) NULL,
      PRIMARY KEY (`id`));
      
    INSERT INTO `litemall`.`litemall_demo` (`id`, `name`, `address`) 
    VALUES ('1', 'hello', 'world');
    ```

2. generatorConfig.xml에 새 테이블 태그 추가

    ```
    <generatorConfiguration>
         <table tableName="litemall_demo">
             <generatedKey column="id" sqlStatement="MySql" identity="true" />
         </table>
    </generatorConfiguration>
    ```
3. mybatis 생성기 플러그인을 두 번 클릭하고 LitemallDemo.java 클래스, LitemallDemoExample.java 클래스를 확인합니다.
    LitemallDemoMapper.java 인터페이스 및 LitemallDemoMapper.xml이 생성되는지 여부.
   
4. 서비스에 새 LitemallDemoService.java 클래스를 만듭니다.

   ```java
    @Service
    public class LitemallDemoService {
       @Resource
       private LitemallDemoMapper demoMapper;

        public List<LitemallDemo> list() {
           LitemallDemoExample example = new LitemallDemoExample();
           return demoMapper.selectByExample(example);    
        }
    }
   ```

5.`src / test / java / org.linlinjava.litemall.db` 패키지에 LitemallDemoTest.java 클래스를 생성 할 수 있습니다.
     테스트에 Junit을 사용하십시오.

    ```java
    @WebAppConfiguration
    @RunWith(SpringJUnit4ClassRunner.class)
    @SpringBootTest
    public class LitemallDemoTest {    
       @Autowired
       private LitemallDemoService demoService;
    
       @Test
       public void test() {    
        List<LitemallDemo> litemallDemoList = demoService.list();
        Assert.assertTrue(litemallDemoList.size() != 0);
       }
    
    }
    ```

6. 마찬가지로 LitemallDemoService를 컨트롤러에서 사용하여 외부 서비스를 제공 할 수 있습니다.
    
    ```java
    @RestController
    @RequestMapping("/demo")
    public class DemoController {
       @Autowired
       private LitemallDemoService demoService;
    
       @RequestMapping("/list")
       public Object list(){    
           List<LitemallDemo> demoList = demoService.list();   
           return demoList;
       }
    }
    ```

### 2.2.5 논리적 삭제

데이터 삭제는 물리적으로 직접 삭제하거나 삭제 필드를 설정하여 논리적으로 삭제할 수 있습니다.
특정 비즈니스에 따라 일부 데이터는 물리적으로 삭제 될 수 있고 일부 데이터는 논리적으로 만 삭제 될 수 있습니다.

현재이 프로젝트의 모든 삭제 작업은 논리적 삭제입니다.
개발자는 데이터베이스가 쓸모없는 데이터를 저장하지 않도록 실제 물리적 삭제를 수행하도록 코드를 스스로 수정할 수 있습니다.

### 2.2.6 동시 접속

이 서비스는 다중 스레드 및 동시 서비스이기 때문에 여러 스레드가 데이터베이스에서 동일한 데이터를 동시에 작동하는 문제가 발생합니다.
데이터가 거의 삭제되지 않거나 논리적으로 삭제되기 때문에 운영 데이터를 단순화하여 데이터를 업데이트 할 수 있습니다.
즉, 데이터베이스에서 동일한 데이터를 업데이트하는 여러 스레드의 동시성 문제를 해결해야합니다.

* https://blog.csdn.net/qq315737546/article/details/76850173
* http://baijiahao.baidu.com/s?id=1571172971189129
* https://blog.csdn.net/speedme/article/details/48525119

예를 들어, 주문을하는 과정에서 사용자 A가 상품 G를 구매하는 수는 1이고 사용자 B도 상품 G를 동시에 구매합니다.
수량도 1입니다. 양호한 동시성 제어가없는 경우 상품 G의 수량이 대신 1만큼만 감소 할 수 있습니다.
잉태 2.

일반적으로 비관적 잠금 또는 낙관적 잠금은 동시 업데이트 문제를 처리하는 데 사용됩니다.

이 프로젝트는 현재`update_time` 필드를 기반으로하는 낙관적 잠금 메커니즘을 사용합니다.
원칙은 다음과 같습니다.

1. 모든 테이블에는 update_time 필드가 있습니다.
2. 업데이트하기 전에 데이터를 쿼리하여 테이블의 비즈니스 데이터 및 update_time 필드를 가져옵니다.
3. 업데이트시 where 조건을 통해 데이터베이스의 현재 update_time 필드와 현재 update_time 필드가 동일한 지 쿼리합니다.
   * 동일하다면 데이터를 변경없이 업데이트 할 수 있으며, 동시에 데이터가 업데이트됨을 의미합니다. update_time은 현재 업데이트 시간을 설정합니다.
   * 동일하지 않은 경우 데이터가 변경되어 업데이트가 실패하고 데이터를 수정할 수 없음을 의미합니다.
   
물론 낙관적 잠금을 사용하기 때문에 또 다른 문제가 있습니다.
데이터베이스 업데이트에 실패 할 수 있으므로 업데이트 실패를 어떻게 처리해야합니까?
현재는 업데이트가 실패했다는 오류 만보고합니다.

### 2.2.7 트랜잭션 관리

litemall-db 모듈은 트랜잭션 관리를 포함하지 않지만 다른 백그라운드 서비스 모듈을 포함합니다.
그러나 다른 백그라운드 서비스 모듈은 litemall-db 모듈에 의존하기 때문에 여기에 나열됩니다.

트랜잭션 관리의 문제는 여러 테이블의 수정 작업에서 나타납니다.

예를 들어 사용자 A는 테이블 1을 수정 한 다음 테이블 2를 수정하고, 테이블 2를 수정할 때 오류가 발생하면
이때 트랜잭션 관리가 도입되지 않은 경우 업데이트 된 표 1의 데이터와 표 2의 데이터가 있습니다.
질문이 업데이트되지 않았습니다.

해결책은 Spring 고유의 트랜잭션 관리 메커니즘을 사용하는 것입니다.
트랜잭션 관리의 SQL 작업에서 오류가 발생하고 예외가 발생하면 이전 작업이 롤백됩니다.

노트:
> 동시 액세스는 여러 사용자가 동시에 단일 테이블을 운영 할 때 발생할 수있는 문제입니다.
> 그리고 트랜잭션 관리는 단일 사용자가 여러 테이블을 운영 할 때 발생할 수있는 문제입니다.

### 2.2.8 Mybatis 강화 프레임 워크

mybatis-generator를 통해 많은 코드가 자동으로 생성되었으며 특정 기능이 있습니다.
그러나 개발자는 생성 된 코드를 기반으로 고정 된 CRUD 코드를 작성해야합니다.

코드를 더욱 단순화하고 기능을 향상시킬 수있는 두 개의 mybatis 강화 프레임 워크가 이미 있습니다.
* [mybatis-plus] (https://github.com/baomidou/mybatis-plus)
* [매퍼] (https://github.com/abel533/Mapper)

현재 채택되지 않았으며 데이터베이스 액세스 코드는 향후 이들 중 하나를 기반으로 리팩토링 될 수 있습니다.
관심있는 개발자는 스스로 공부하고 사용할 수 있습니다.

## 2.3 리 테몰 코어

litemall-core 모듈은이 프로젝트의 공통 코드입니다.

* 구성

  Spring Boot 비동기 기능 활성화와 같은 일반 구성.

* 유틸리티

  도구 코드.

* qcode

  이 프로젝트에 맞춤 설정된 공유 QR 코드 사진입니다.
  
* 저장

  스토리지 기능, 로컬 스토리지, Tencent 클라우드 스토리지, Ali 클라우드 스토리지 및 Qiniu 클라우드 스토리지를 지원합니다.
      
* 알림

  알림 알림 기능은 이메일 알림, SMS 알림 및 WeChat 알림을 지원합니다.

* 표현하다

  물류 서비스, 주문 물류 정보 조회.
  
* 시스템

  litemall-db 모듈의 데이터베이스 액세스를 통해이 프로젝트의 시스템 구성 정보를 읽습니다.

* 검증 인

  백엔드 확인 요청 매개 변수를 돕기 위해 두 개의 확인 주석이 제공됩니다.
  
### 2.3.1 구성

#### 2.3.1.1 CorsConfig

현재 개발 프로세스에서 CORS 구성은 모든 요청을 허용합니다.

실제로 배포 할 때 개발자는 현재 서비스가 설정된 도메인 이름의 요청 만 수락하도록 몇 가지 조정을해야합니다.

#### 2.3.1.2 GlobalExceptionHandler

시스템에서 예외가 발생하고 개발자가 catch하지 않으면 예외 내용이 프런트 엔드로 전송됩니다.
여기에서 전역 예외 처리기를 제공하여 개발자가 처리하지 않은 모든 예외를 처리하기 위해
시스템을 보호하기 위해 "내부 시스템 오류"와 같은 정보가 프런트 엔드로 전송됩니다.

#### 2.3.1.3 JacksonConfig

Jackson은 몇 가지 설정을했습니다.

### 2.3.2 유틸리티

노트
> 여기서 util 코드는 특정 비즈니스를 포함하지 않습니다. 예를 들어 litemall-db 모듈에 하나가 있습니다.
> OrderUtil 클래스는 데이터베이스에서 litemall_order 테이블의 일부 변환 작업을 처리합니다.

#### 2.3.2.1 ResponseUtil

응답에서 본문의 내용 형식을 설정하는 데 사용됩니다.

성공하면 다음과 같습니다.

```json
{
  errno: 0,
  errmsg: '成功',
  data: XXX
}
```

실패하면 다음과 같습니다.

```json
{
  errno: 非0的XXX,
  errmsg: XXX
}
```

#### 2.3.2.2 JacksonUtil

POST가 요청되면 요청 된 json 콘텐츠가 본문에 있습니다.
일반적으로 데이터를 검색하는 두 가지 방법이 있습니다.
* json 내용이 POJO에 해당하는 경우 POJO가 메서드에서 사용될 때 spring은 자동으로 채우기 데이터를 구문 분석합니다.
* 또는 개발자 자신이 jackson 또는 기타 json 처리 라이브러리를 사용하여 데이터를 수동으로 구문 분석합니다.

여기서 JacksonUtil은 분석 작업을 단순화합니다. 이 코드에는 제한이 있으므로 개발자는주의를 기울이거나 Jackson에 익숙해야합니다.
사용하는 개발자는 코드를 최적화 할 수 있습니다.

#### 2.3.2.3 CharUtil

고정 길이 임의의 문자 문자열 또는 임의의 숫자 문자열을 생성합니다.

#### 2.3.2.4 bcypt

사용자 암호 또는 관리자 암호를 암호화하고 저장하는 데 사용됩니다.

bcypt 코드는 본질적으로 봄의 코드입니다.

### 2.3.3 QR 코드

QCodeService 클래스를 참조하십시오.

### 2.3.4 오브젝트 스토리지

오브젝트 스토리지 서비스의 현재 목표는 사진 업로드 및 다운로드를 지원하는 것입니다.

오브젝트 스토리지 서비스는 자동으로 구성 구성을 읽은 다음 서비스를 인스턴스화합니다.

개체 스토리지 인터페이스 :
```
public interface Storage {
    void store(InputStream inputStream, long contentLength, String contentType, String keyName);
    Stream<Path> loadAll();
    Path load(String keyName);
    Resource loadAsResource(String keyName);
    void delete(String keyName);
    String generateUrl(String keyName);
}
```

#### 2.3.4.1 로컬 스토리지 서비스

LocalStorage 클래스를 참조하십시오.

#### 2.3.4.2 Tencent 클라우드 스토리지 서비스

TencentStorage 클래스를 참조하십시오.

#### 2.3.4.3 알리바바 클라우드 스토리지 서비스

AliyunStorage 클래스를 참조하십시오.

#### 2.3.4.4 Qiniu 클라우드 스토리지 서비스

QiniuStorage 클래스를 참조하십시오.

### 2.3.5 메시지 알림

메시지 알림은 사용자 또는 관리자에게 알리는 데 사용됩니다.

노트:
> 현재 구현은 상대적으로 거칠며 향후 세부 사항이 개선 될 것입니다.

#### 2.3.5.1 이메일 알림

NotifyService 클래스의`notifyMail` 메소드를 참조하십시오.

#### 2.3.5.2 SMS 알림

NotifyService 클래스의`notifySms` 및`notifySmsTemplate` 메소드를 참조하십시오.

SMS 알림 구현 클래스에 대해서는`TencentSmsSender` 클래스를 참조하십시오.
즉, 현재 Tencent Cloud SMS 만 지원되며 다른 SMS 서비스는 지원되지 않습니다.
또한 개발자는 먼저 Tencent Cloud SMS 플랫폼에서 템플릿을 신청해야 사용할 수 있습니다.

#### 2.3.5.3 WeChat 알림

NotifyService 클래스의`notifySms` 및`notifyWxTemplate` 메소드를 참조하십시오.
그리고 WeChat 알림 구현 클래스는`WxTemplateSender` 클래스를 참조하십시오.
개발자는 템플릿을 사용하려면 WeChat 플랫폼에서 템플릿을 신청해야합니다.

### 2.3.6 물류 추적

물류 추적은 타사 서비스 인 Kuaiao 물류 쿼리 서비스를 기반으로합니다.
개발자는 그것을 사용하기 위해 신청해야합니다.

`ExpressService` 클래스를 참조하십시오.

### 2.3.7 시스템 설정

### 2.3.8 검증 노트

개발자가 HTTP 매개 변수를 확인할 수 있도록 두 가지 확인 주석이 사용자 정의되었습니다.

#### 2.3.8.1 주문

사용자 요청 매개 변수 값이 'desc'또는 'asc'만 될 수 있는지 확인합니다.

여기서 순서는 순서가 아니라 정렬을 의미합니다.

1. 주석 순서 정의
    ```
    @Target({METHOD, FIELD, PARAMETER})
    @Retention(RUNTIME)
    @Documented
    @Constraint(validatedBy = OrderValidator.class)
    public @interface Order {
        String message() default "排序类型不支持";
        String[] accepts() default {"desc", "asc"};
        Class<?>[] groups() default {};
        Class<? extends Payload>[] payload() default {};
    }
    ```
2. OrderValidator
    ```
    public class OrderValidator implements ConstraintValidator<Order, String> {
        private List<String> valueList;
        @Override
        public void initialize(Order order) {
            valueList = new ArrayList<String>();
            for (String val : order.accepts()) {
                valueList.add(val.toUpperCase());
            }
        }
        @Override
        public boolean isValid(String s, ConstraintValidatorContext constraintValidatorContext) {
            if (!valueList.contains(s.toUpperCase())) {
                return false;
            }
            return true;
        }
    }
    ```
3. 주석 사용
    ```
    @RestController
    @RequestMapping("/wx/topic")
    @Validated
    public class WxTopicController {
        @GetMapping("list")
        public Object list(@RequestParam(defaultValue = "1") Integer page,
                       @RequestParam(defaultValue = "10") Integer limit,
                       @Sort @RequestParam(defaultValue = "add_time") String sort,
                       @Order @RequestParam(defaultValue = "desc") String order) {
         ...
         }
    ```
    
#### 2.3.8.2 Sort

사용자 요청 매개 변수 값이 'add_time'또는 'id'만 될 수 있는지 확인합니다.

1. 주석 정렬 정의
    ```
    @Target({METHOD, FIELD, PARAMETER})
    @Retention(RUNTIME)
    @Documented
    @Constraint(validatedBy = SortValidator.class)
    public @interface Sort {
        String message() default "排序字段不支持";
        String[] accepts() default {"add_time", "id"};
        Class<?>[] groups() default {};
        Class<? extends Payload>[] payload() default {};
    }
    ```
2. SortValidator구현
    ```
    public class SortValidator implements ConstraintValidator<Sort, String> {
        private List<String> valueList;
    
        @Override
        public void initialize(Sort sort) {
            valueList = new ArrayList<String>();
            for (String val : sort.accepts()) {
                valueList.add(val.toUpperCase());
            }
        }
    
        @Override
        public boolean isValid(String s, ConstraintValidatorContext constraintValidatorContext) {
            if (!valueList.contains(s.toUpperCase())) {
                return false;
            }
            return true;
        }
    }
    ```
3. 주석 사용
    ```
    @RestController
    @RequestMapping("/wx/topic")
    @Validated
    public class WxTopicController {
        @GetMapping("list")
        public Object list(@RequestParam(defaultValue = "1") Integer page,
                       @RequestParam(defaultValue = "10") Integer limit,
                       @Sort @RequestParam(defaultValue = "add_time") String sort,
                       @Order @RequestParam(defaultValue = "desc") String order) {
         ...
         }
    ```

## 2.4 litemall-all

섹션 1.5에서 논의 된 배포 계획에서 단일 서버 단일 서비스 계획이 설계되었습니다.
즉, 두 개의 백그라운드 서비스와 정적 파일이 Spring Boot 실행 가능 jar 패키지에 배포됩니다.

litemall-all 모듈을 살펴보면 코드에는 Application 클래스가 하나만 있습니다.

실제 원칙은 litemall-all 모듈의 pom.xml 파일입니다.

1. 패키징 방법은`jar`이므로 실행 가능한 jar 형식이 마지막에 패키징됩니다.
2. litemall-wx-api 모듈 및 litemall-admin-api 모듈에 따라
   따라서 패키징 중에 종속 라이브러리로서 litemall-all 모듈의 출력에 패키징됩니다.
3. 복사 리소스 플러그인을 사용하여 litemall-admin 모듈의 dist를 패키징합니다.
   폴더를 litemall-all 모듈의 정적 폴더에 복사하고이 폴더를
   Spring Boot 애플리케이션의 기본 정적 파일 경로입니다.
   
   노트:
   >이 플러그인은 단순한 복사 작업이므로 개발자는 litemall-all
   > 최종 정적 파일을 얻으려면 먼저 litemall-admin 모듈을 컴파일하십시오.


## 2.5 litemall-all-war

litemall-all-war 모듈은 litemall-all-all 모듈에 대한 작은 조정입니다.
최종 패키지에서 litemall.war는 tomcat 배포를위한 대상 디렉터리 아래에 생성됩니다.
