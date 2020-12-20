## 도커

### 프로젝트 패키징

1. 프로젝트를 서버 또는 개발 시스템의 docker로 패키지화합니다.
    ```
    cd litemall
    cat ./litemall-db/sql/litemall_schema.sql> ./docker/db/init-sql/litemall.sql
    cat ./litemall-db/sql/litemall_table.sql >> ./docker/db/init-sql/litemall.sql
    cat ./litemall-db/sql/litemall_data.sql >> ./docker/db/init-sql/litemall.sql
    
    cd ./litemall-admin
    cnpm 설치
    cnpm 실행 build : dep
    
    cd ..
    mvn 클린 패키지
    cp -f ./litemall-all/target/litemall-all-*-exec.jar ./docker/litemall/litemall.jar
    ```
    여기서 작업은 다음과 같습니다.
    1. 데이터베이스 파일을 docker / db 폴더에 복사합니다.
    2. litemall-admin 프로젝트 컴파일
    3. litemall-all 모듈을 컴파일하고 litemall-admin으로 컴파일 한 정적 파일을 다음 위치에 복사합니다.
       litemall-all 모듈의 정적 디렉토리
       
2. litemall 폴더 아래의 * .yml 외부 구성 파일을 수정합니다. litemall-all 모듈이 시작되면
    외부 구성 파일을로드하고 기본 jar 패키지 내의 구성 파일을 재정의합니다.
    예를 들어, 구성 파일의 일부 위치는 원격 서버의 IP 주소로 설정해야합니다.
    
이 시점에서 Docker 배포 패키지 구조는 다음과 같습니다.

* 빈

deploy.sh 스크립트 및 reset.sh 스크립트를 포함하여 원격 서버에서 실행되는 저장소 스크립트

* db

litemall 데이터베이스 파일 저장

* litemall

litemall-all 바이너리 실행 패키지 및 litemall 외부 구성 파일을 포함하여 원격 서버에서 실행중인 코드를 저장합니다.

* 유틸리티

package.sh 스크립트 및 lazy.sh 스크립트를 포함하여 개발 서버에서 실행하는 스크립트를 저장합니다.
로컬 개발 서버에서 실행되기 때문에 개발자는 원격 서버에 업로드 할 필요가 없습니다.

* docker-compose.yml

docker-compose 구성 스크립트, docker-compose 명령을 실행하면

### 프로젝트 배포

1. 클라우드 서버 환경에 docker 및 docker-compose를 설치합니다 (MySQL 및 JDK1.8은 docker를 사용하여 자동으로 설치되므로 설치할 필요가 없습니다).
   또한 클라우드 서버의 보안 그룹이 해당 포트를 허용했는지 확인하십시오.

2. docker-compose 실행
    ```bash
    cd / home / ubuntu / docker
   sudo 도커 작성
    ```

3. 배포가 성공했는지 테스트합니다 (xxx.xxx.xxx.xxx는 클라우드 서버 IP 임).
    ```
    http://xxx.xxx.xxx.xxx:8080/wx/index/index
    http://xxx.xxx.xxx.xxx:8080/admin/index/index
    http://xxx.xxx.xxx.xxx:8080/#/login
    ```

### 프로젝트 보조 스크립트

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
./docker/util/lazy.sh
```

그러나 설정할 정보에는 민감한 보안 정보가 포함되므로 개발자는 여기에서 docker 폴더를 참조하는 것이 좋습니다.
그런 다음 고유 한 도커 폴더를 구현하고 외부 구성 파일 및 스크립트에 민감한 보안 정보를 적절하게 폐기하십시오
