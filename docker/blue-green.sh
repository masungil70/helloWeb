#!/bin/bash

echo "[1] 새 이미지 Pull"
docker pull masungil/hello-web:blue

echo "[2] Blue 컨테이너 시작"
docker compose up -d was1-blue was2-blue

echo "[3] Health Check 수행..."
sleep 3
curl --fail http://localhost || {
    echo "Health check 실패. 롤백합니다."
    exit 1
}

echo "[4] Nginx 설정 전환"
cp nginx-blue.conf nginx.conf
docker restart webserver

echo "[5] 배포 완료"
