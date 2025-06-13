#!/bin/bash

sleep 10
curl --fail http://localhost:8080 || {
    echo "1. Blue 컨테이너 Health check 실패. 롤백합니다."
    exit 1
}

echo "[1] 새 이미지를 docker hub로 부터 pull 내려 받는다"
docker pull masungil/hello-web:blue

sleep 10
curl --fail http://localhost:8080 || {
    echo "2. Blue 컨테이너 Health check 실패. 롤백합니다."
    exit 1
}

echo "[2] Blue 컨테이너 시작"
docker compose  up -d was1-blue was2-blue

echo "[3] Blue 컨테이너 Health Check 수행..."
sleep 10
curl --fail http://localhost:8080 || {
    echo "Blue 컨테이너 Health check 실패. 롤백합니다."
    exit 1
}

echo "[4] Blue  green으로 변경"
cp nginx-blue.conf nginx.conf
docker exec webserver nginx -s reload

echo "[5] blue 이미지를 green으로 이미지로 tag"
docker tag masungil/hello-web:blue  masungil/hello-web:green

echo "[6] green를 docker hub에 push 한다"
docker push masungil/hello-web:green

echo "[7] 현재 실행중이 docker comspose green를 새로운 green 이미지로 반영한다"
docker compose up -d was1-green was2-green

echo "[8] 현재 실행중이 blue 실행 환경을 green 환경 변경한다"
cp nginx-green.conf nginx.conf
docker exec webserver nginx -s reload

echo "[9] 불필요한 이미지/컨테이너 정리..."
docker image prune -f

echo "[10] 배포 완료"
