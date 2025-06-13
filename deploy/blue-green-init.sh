#!/bin/bash
echo "blue-green 정책을 사용하기 위해 초기 이미지를 blue, green으로 작성 하여 등록해야 한다\n\n"

cd  ..

echo "gradlew 실행권한 설정\n" 
chmod +x gradlew
        
echo "build gradlew\n" 
./gradlew bootJar

      
echo "docker image build\n" 
docker build -t masungil/hello-web:blue . 

cd deploy
        
echo "docker hub login\n"
docker login -u masungil -p yjkim0812$
        
echo "docker tag 변경\n" 
docker tag masungil/hello-web:blue masungil/hello-web:green

echo "docker hub push\n" 
docker push masungil/hello-web:blue
docker push masungil/hello-web:green

echo "docker compose로 실행" 
docker compose up -d
