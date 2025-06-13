#!/bin/bash

echo "[0] git으로부터 소스 받기"
git pull

echo "[1] 프로젝트 빌드"
./gradlew bootJar

echo "[2] 새 이미지 생성"
docker build -t masungil/hello-web:blue .

echo "[3] 새 이미지 push"
docker push masungil/hello-web:blue

echo "[4] 경로 변경"
cd deploy 

echo "[5] Blue 컨테이너 시작"
docker compose  up -d was1-blue was2-blue

echo "[6] Blue 컨테이너 Health Check 수행..."
sleep 3
curl --fail http://localhost:8080 || {
    echo "Blue 컨테이너 Health check 실패. 롤백합니다."
    exit 1
}

echo "[7] Blue  green으로 변경"
cp nginx-blue.conf nginx.conf
docker exec webserver nginx -s reload

echo "[8] blue 이미지를 green으로 이미지로 tag"
docker tag masungil/hello-web:blue  masungil/hello-web:green

echo "[9] green를 docker hub에 push 한다"
docker push masungil/hello-web:green

echo "[10] 현재 실행중이 docker comspose green를 새로운 green 이미지로 반영한다"
docker compose up -d was1-green was2-green

echo "[11] 현재 실행중이 blue 실행 환경을 green 환경 변경한다"
cp nginx-green.conf nginx.conf
docker exec webserver nginx -s reload

echo "[12] 불필요한 이미지/컨테이너 정리..."
docker image prune -f

echo "[13] 배포 완료"
