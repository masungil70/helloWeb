# spring boot 을 이용한 blue-green 정책을 적용한 CI/CD
## 시스템 구성
1. vmware 가상머신 준비 
2. spring boot rest api (/) 
3. 저장소 설정 -> actions -> runners 에서 가상머신과 연동할 수 있게 설정한다 
-  
4. docker 폴더에 수작업으로 진행 할 수 있는 docker-compose.yml 파일 있음 

5. deploy 폴더에 수 작업으로 git으로부터 내려받고 빌드 한 후 blue 이미지를 만들어서 배포하는 작업을 진행한다

6. deploy 폴더에 blue-green 정책을 사용하기 위해 초기 이미지를 blue, green으로 작성 하여 등록하는 셀 파일이 있음 

7. deploy 폴더에 blue-green 정책을 실행하는 셀 파일이 있음. 해당 파일은 github actions에서 배포시 사용함 

8. 실행은 http://서버주소 실행해서 rest api 결과 확인 한다


